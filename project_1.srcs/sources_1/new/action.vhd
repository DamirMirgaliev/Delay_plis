----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.11.2023 09:20:00
-- Design Name: 
-- Module Name: action - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


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
       BTNC     : in    STD_LOGIC
       );
end action;



architecture Behavioral of action is

    signal debounced_btn : std_logic := '0';
    signal prev_btn : std_logic := '0';
    signal btncsum : std_logic := '0';
    signal btncd : std_logic := '0';    
    signal state : std_logic := '0';
    
    
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
   
    signal clk_100_buffered: std_logic;

    signal counter : unsigned (5 downto 0);
    signal hphone_l, hphone_r : std_logic_vector (23 downto 0);
    signal hphone_l_valid, hphone_r_valid: std_logic;
    signal new_sample : std_logic;
    signal sample_clk_48k: std_logic;
    signal line_in_l, line_in_r : std_logic_vector (23 downto 0);
    signal line_in_l_delayed, line_in_r_delayed : std_logic_vector (23 downto 0);

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

READY_proc: process(clk_100_buffered)
    variable btn1_temp: std_logic;
begin
--        if btn1_temp /= btn1 then
--            btn1 <= btn1_temp;
    if rising_edge(clk_100_buffered) then
--        if BTNC = '1' and prev_btn = '0' then
--            debounced_btn <= '1';
--        elsif BTNC = '0' and prev_btn = '1' then
--            debounced_btn <= '0';
--        end if;

--        prev_btn <= BTNC;
--        btn1_temp := debounced_btn;

        hphone_l_valid <= new_sample;
        hphone_r_valid <= new_sample;
        btncd <=btnc;                  
        btncsum <= btnc and not btncd; 
        if btnc = '1' then                    
           state <= not state;
            end if;
        
            if state = '0' then
                hphone_l <= line_in_l;
                hphone_r <= line_in_r;
                btncsum <= '0';                
            else
                hphone_l <= std_logic_vector(shift_right(signed(line_in_l), 1) + shift_right(signed(line_in_l_delayed), 1));
                hphone_r <= std_logic_vector(shift_right(signed(line_in_r), 1) + shift_right(signed(line_in_r_delayed), 1));
            end if;
      end if;  

--    end if;
end process;

end Behavioral;
