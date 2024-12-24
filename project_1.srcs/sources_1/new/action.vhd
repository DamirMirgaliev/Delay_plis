library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity action is
Port ( clk_100  : in    STD_LOGIC; -- 100 mhz master takt 
       AC_ADR0  : out   STD_LOGIC;  -- control signals to ADAU chip
       AC_ADR1  : out   STD_LOGIC;
       AC_GPIO0 : out   STD_LOGIC;  -- I2S MISO
       AC_GPIO1 : in    STD_LOGIC;  -- I2S MOSI
       AC_GPIO2 : in    STD_LOGIC;  -- I2S_bclk
       AC_GPIO3 : in    STD_LOGIC;  -- I2S_LR
       AC_MCLK  : out   STD_LOGIC;
       AC_SCK   : out   STD_LOGIC;
       AC_SDA   : inout STD_LOGIC;
       BTNC     : in    STD_LOGIC;
       BTNU     : in    STD_LOGIC;
       BTND     : in    STD_LOGIC;
       BTNR     : in    STD_LOGIC;
       BTNL     : in    STD_LOGIC
       );
end action;



architecture Behavioral of action is
    
    COMPONENT audio_top
    Port ( clk_100  : in    STD_LOGIC; -- 100 mhz input clock 
        AC_ADR0  : out   STD_LOGIC; -- contol signals to audio chip
        AC_ADR1  : out   STD_LOGIC;
        AC_GPIO0 : out   STD_LOGIC;  -- I2S MISO
        AC_GPIO1 : in    STD_LOGIC;  -- I2S MOSI
        AC_GPIO2 : in    STD_LOGIC;  -- I2S_bclk
        AC_GPIO3 : in    STD_LOGIC;  -- I2S_LR
        AC_MCLK  : out   STD_LOGIC;
        AC_SCK   : out   STD_LOGIC;
        AC_SDA   : inout STD_LOGIC;
        
        

        hphone_l  : in STD_LOGIC_VECTOR(23 downto 0);
        hphone_l_valid : in std_logic;
        hphone_r  : in STD_LOGIC_VECTOR(23 downto 0);
        hphone_r_valid_dummy : in std_logic;
        
        line_in_l    : out STD_LOGIC_VECTOR(23 downto 0);
        line_in_r    : out STD_LOGIC_VECTOR(23 downto 0);
        
        o_clk_100      : out std_logic;
        new_sample     : out STD_LOGIC;     -- goes up for 1 clk cycle if new sample is transmitted received
        sample_clk_48k : out std_logic  -- sample clock 
        );
    END COMPONENT;

    COMPONENT fifo_delay is
    generic(
        DAT_WIDTH : positive
    );
    port (
        i_clk      : in  std_logic;                      
        i_rst      : in  std_logic;
        i_val      : in  std_logic;
        i_dat      : in  std_logic_vector(DAT_WIDTH -1 downto 0);
        o_val      : out std_logic;
        o_dat      : out std_logic_vector(DAT_WIDTH -1 downto 0)
    );
    END COMPONENT fifo_delay;
    
    COMPONENT EQ_HPF is
    generic(
        H_DAT_WIDTH : positive
    );
    port (
        H_i_aclk     : in  std_logic;
        H_i_val      : in  std_logic;
        H_i_dat      : in  std_logic_vector(H_DAT_WIDTH -1 downto 0);
        H_o_val      : out std_logic;
        H_o_dat      : out std_logic_vector(H_DAT_WIDTH -1 downto 0)
    );
    END COMPONENT EQ_HPF;
    
        COMPONENT EQ_LPF is
    generic(
        L_DAT_WIDTH : positive
    );
    port (
        L_i_aclk     : in  std_logic;
        L_i_val      : in  std_logic;
        L_i_dat      : in  std_logic_vector(L_DAT_WIDTH -1 downto 0);
        L_o_val      : out std_logic;
        L_o_dat      : out std_logic_vector(L_DAT_WIDTH -1 downto 0)
    );
    END COMPONENT EQ_LPF;
    
    COMPONENT button is
    generic(
        FCLK                 : real := 50.0e6; -- Clock Frequency Hz
        SHORT_PRESS_DURATION : real := 0.1;    -- seconds
        LONG_PRESS_DURATION  : real := 1.0     -- seconds
        );
    port(
        i_clk    : in  std_logic;
        i_press  : in  std_logic;
        o_short  : out std_logic;
        o_long   : out std_logic
        );
    END COMPONENT button;
    
    signal current_volume_LPF : INTEGER range 0 to 4 := 0;
    signal current_volume_HPF : INTEGER range 0 to 4 := 0;
   
    signal clk_100_buffered: std_logic;

    signal counter : unsigned (5 downto 0);
    signal hphone_l, hphone_r : std_logic_vector (23 downto 0);
    signal hphone_l_valid, hphone_r_valid: std_logic;
    signal new_sample : std_logic;
    signal sample_clk_48k: std_logic;
    signal line_in_l, line_in_r : std_logic_vector (23 downto 0);
    signal line_in_l_delayed, line_in_r_delayed : std_logic_vector (23 downto 0);
    signal line_in_l_HPF, line_in_r_HPF : std_logic_vector (23 downto 0);
    signal l_HPF, r_HPF : std_logic_vector (23 downto 0);
    signal line_in_l_LPF, line_in_r_LPF : std_logic_vector (23 downto 0);
    signal line_in_l_EQ, line_in_r_EQ : std_logic_vector (23 downto 0);
    
    signal Central_button_short, Central_button_long : STD_LOGIC;
    signal Up_button_short, Up_button_long : STD_LOGIC;           
    signal Down_button_short, Down_button_long : STD_LOGIC;
    signal Left_button_short, Left_button_long : STD_LOGIC;
    signal Right_button_short, Right_button_long : STD_LOGIC;    

    -- keep signals for tracking them with the Logic Analyzer
    attribute keep : string;
    attribute keep of sample_clk_48k : signal is "true";
    attribute keep of hphone_l : signal is "true";
    attribute keep of hphone_r : signal is "true";
    
    attribute keep of line_in_l : signal is "true";
    attribute keep of line_in_r : signal is "true";
    

begin

    i_audio : audio_top port map (
      clk_100  => clk_100, 
      AC_ADR0  => AC_ADR0,
      AC_ADR1  => AC_ADR1,
      AC_GPIO0 => AC_GPIO0,
      AC_GPIO1 => AC_GPIO1,
      AC_GPIO2 => AC_GPIO2,
      AC_GPIO3 => AC_GPIO3,
      AC_MCLK  => AC_MCLK,
      AC_SCK   => AC_SCK,
      AC_SDA   => AC_SDA,
      
      
      hphone_l  => hphone_l,
      hphone_l_valid => hphone_l_valid,
      hphone_r  => hphone_r,
      hphone_r_valid_dummy => hphone_r_valid,   --  this valid will be discarded later
      
      line_in_l => line_in_l,  
      line_in_r => line_in_r,

      o_clk_100  => clk_100_buffered,
      new_sample => new_sample,
      sample_clk_48k => sample_clk_48k
     
   );
        
        Button_Press_Central : button
        port map(
           i_clk   => clk_100_buffered,
           i_press => BTNC,        
           o_short => Central_button_short,
           o_long  => Central_button_long 
           );        
        
        Button_Press_Up : button
        port map(
            i_clk   => clk_100_buffered,
            i_press => BTNU,        
            o_short => Up_button_short,
            o_long  => Up_button_long 
            );
            
        Button_Press_Down : button
            port map(
               i_clk   => clk_100_buffered,
               i_press => BTND,        
               o_short => Down_button_short,
               o_long  => Down_button_long 
               );        
            
        Button_Press_Left : button
            port map(
                i_clk   => clk_100_buffered,
                i_press => BTNL,        
                o_short => Left_button_short,
                o_long  => Left_button_long 
                ); 
                
        Button_Press_Right : button
            port map(
                i_clk   => clk_100_buffered,
                i_press => BTNR,        
                o_short => Right_button_short,
                o_long  => Right_button_long 
                );                           

    R_DELAY_inst: fifo_delay
    generic map(
        DAT_WIDTH => hphone_r'length)
    port map(
        i_clk => clk_100_buffered,
        i_rst => BTNC,
        i_val => new_sample,
        i_dat => line_in_r,
        o_val => open,
        o_dat => line_in_r_delayed);

    L_DELAY_inst: fifo_delay
    generic map(
        DAT_WIDTH => hphone_l'length)
    port map(
        i_clk => clk_100_buffered,
        i_rst => BTNC,
        i_val => new_sample,
        i_dat => line_in_l,
        o_val => open,
        o_dat => line_in_l_delayed);
        
    R_EQ_HPF_inst: EQ_HPF
    generic map(
        H_DAT_WIDTH => hphone_r'length)
    port map(
        H_i_aclk => clk_100_buffered,
        H_i_val => new_sample,
        H_i_dat => line_in_r_delayed,
        H_o_val => open,
        H_o_dat => line_in_r_HPF); 
        
    L_EQ_HPF_inst: EQ_HPF
    generic map(
        H_DAT_WIDTH => hphone_l'length)
    port map(
        H_i_aclk => clk_100_buffered,
        H_i_val => new_sample,
        H_i_dat => line_in_l_delayed,
        H_o_val => open,
        H_o_dat => line_in_l_HPF); 
        
    R_EQ_LPF_inst: EQ_LPF
        generic map(
            L_DAT_WIDTH => hphone_r'length)
        port map(
            L_i_aclk => clk_100_buffered,
            L_i_val => new_sample,
            L_i_dat => line_in_r_delayed,
            L_o_val => open,
            L_o_dat => line_in_r_HPF); 
            
    L_EQ_LPF_inst: EQ_LPF
        generic map(
            L_DAT_WIDTH => hphone_l'length)
        port map(
            L_i_aclk => clk_100_buffered,
            L_i_val => new_sample,
            L_i_dat => line_in_l_delayed,
            L_o_val => open,
            L_o_dat => line_in_l_HPF);           

READY_proc: process(clk_100_buffered)
begin
--        if btn1_temp /= btn1 then
--            btn1 <= btn1_temp;

        if rising_edge(sample_clk_48k) then
            hphone_l_valid <= new_sample;
            hphone_r_valid <= new_sample;
            
            if Left_button_short = '1' and current_volume_LPF = 0 then
                line_in_l_LPF <= line_in_l_LPF;
                line_in_r_LPF <= line_in_r_LPF;                
                current_volume_LPF <= current_volume_LPF + 1;
            elsif Left_button_short = '1' and current_volume_LPF = 1 then -- +30Äá
                line_in_l_LPF <= std_logic_vector(signed(line_in_l_LPF) + "00011110");
                line_in_r_LPF <= std_logic_vector(signed(line_in_r_LPF) + "00011110");                
                current_volume_LPF <= current_volume_LPF + 1;     
            elsif Left_button_short = '1' and current_volume_LPF = 2 then -- -60Äá
                line_in_l_LPF <= std_logic_vector(signed(line_in_l_LPF) - "00111100");
                line_in_r_LPF <= std_logic_vector(signed(line_in_r_LPF) - "00111100");                
                current_volume_LPF <= current_volume_LPF + 1;
            elsif Left_button_short = '1' and current_volume_LPF = 3 then -- -60Äá
                line_in_l_LPF <= std_logic_vector(signed(line_in_l_LPF) - "00111100");
                line_in_r_LPF <= std_logic_vector(signed(line_in_r_LPF) - "00111100");             
                current_volume_LPF <= current_volume_LPF + 1;  
            elsif current_volume_LPF = 4 then
                current_volume_LPF <= 0;                                           
            end if;
            
            if Right_button_short = '1' and current_volume_HPF = 0 then
                line_in_l_HPF <= line_in_l_HPF;
                line_in_r_HPF <= line_in_r_HPF;                
                current_volume_HPF <= current_volume_HPF + 1;
            elsif Right_button_short = '1' and current_volume_HPF = 1 then -- +30Äá
                line_in_l_HPF <= std_logic_vector(signed(line_in_l_HPF) + "00011110");
                line_in_r_HPF <= std_logic_vector(signed(line_in_r_HPF) + "00011110");                
                current_volume_HPF <= current_volume_HPF + 1;     
            elsif Right_button_short = '1' and current_volume_HPF = 2 then -- -60Äá
                line_in_l_HPF <= std_logic_vector(signed(line_in_l_HPF) - "00111100");
                line_in_r_HPF <= std_logic_vector(signed(line_in_r_HPF) - "00111100");                
                current_volume_HPF <= current_volume_HPF + 1;
            elsif Right_button_short = '1' and current_volume_HPF = 3 then -- -60Äá
                line_in_l_HPF <= std_logic_vector(signed(line_in_l_HPF) - "00111100");
                line_in_r_HPF <= std_logic_vector(signed(line_in_r_HPF) - "00111100");                 
                current_volume_HPF <= current_volume_HPF + 1;  
            elsif current_volume_HPF = 4 then
                current_volume_HPF <= 0;                                           
            end if;
            
            if Up_button_short = '1' then
                line_in_l_EQ <= std_logic_vector(signed(line_in_l_LPF) + signed(line_in_l_HPF));
                line_in_r_EQ <= std_logic_vector(signed(line_in_r_LPF) + signed(line_in_r_HPF));                
                hphone_l <= std_logic_vector(shift_right(signed(line_in_l), 1) + shift_right(signed(line_in_l_EQ), 1));
                hphone_r <= std_logic_vector(shift_right(signed(line_in_r), 1) + shift_right(signed(line_in_r_EQ), 1));    
            else
                hphone_l <= line_in_l;
                hphone_r <= line_in_r;
--        if BTNC = '1' and prev_btn = '0' then
--            debounced_btn <= '1';
--        elsif BTNC = '0' and prev_btn = '1' then
--            debounced_btn <= '0';
--        end if;

--        prev_btn <= BTNC;
--        btn1_temp := debounced_btn;

--        hphone_l_valid <= new_sample;
--        hphone_r_valid <= new_sample;
--        btncd <=btnc;                  
--        btncsum <= btnc and not btncd; 
--        if btnc = '1' then                    
--           state <= not state;
--            end if;
        
--            if state = '0' then
--                hphone_l <= line_in_l;
--                hphone_r <= line_in_r;
--                btncsum <= '0';                
--            else
--                hphone_l <= std_logic_vector(shift_right(signed(line_in_l), 1) + shift_right(signed(line_in_l_delayed), 1));
--                hphone_r <= std_logic_vector(shift_right(signed(line_in_r), 1) + shift_right(signed(line_in_r_delayed), 1));

      end if;  

    end if;
end process;

end Behavioral;
