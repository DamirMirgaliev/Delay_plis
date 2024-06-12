----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.11.2023 09:58:10
-- Design Name: 
-- Module Name: fifo_delay - Behavioral
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
use IEEE.numeric_std.ALL;


entity fifo_delay is
    generic(
        DAT_WIDTH : positive := 24
    );
    port (
        i_clk      : in  std_logic;                      
        i_rst      : in  std_logic;
        i_val      : in  std_logic;
        i_dat      : in  std_logic_vector(DAT_WIDTH -1 downto 0);
        o_val      : out std_logic;
        o_dat      : out std_logic_vector(DAT_WIDTH -1 downto 0)
    );
end fifo_delay;



architecture Behavioral of fifo_delay is

    constant DELAY_INT : positive := 32000;

    COMPONENT axis_data_fifo_0
    PORT (
    s_axis_aresetn : IN STD_LOGIC;
        s_axis_aclk : IN STD_LOGIC;
        s_axis_tvalid : IN STD_LOGIC;
        s_axis_tready : OUT STD_LOGIC;
        s_axis_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        m_axis_tvalid : OUT STD_LOGIC;
        m_axis_tready : IN STD_LOGIC;
        m_axis_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        axis_data_count : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        axis_wr_data_count : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        axis_rd_data_count : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
    END COMPONENT;

    signal val_d1 : std_logic;
    signal val_d2 : std_logic;
    signal val    : std_logic;
    signal dat    : std_logic_vector(DAT_WIDTH -1 downto 0);

    signal s_axis_aresetn : STD_LOGIC;
    signal s_axis_aclk : STD_LOGIC;
    signal count   : std_logic_vector(31 DOWNTO 0);
    signal stvalid : std_logic;
    signal stdata  : std_logic_vector(31 DOWNTO 0);
    signal mtvalid : std_logic;
    signal mtdata  : std_logic_vector(31 DOWNTO 0);
    signal mtready : std_logic;        
    
    attribute DONT_TOUCH : string;
    attribute DONT_TOUCH of i_rst : signal is "true";
    attribute DONT_TOUCH of i_val : signal is "true";
    attribute DONT_TOUCH of i_dat : signal is "true";
    attribute DONT_TOUCH of o_val : signal is "true";
    attribute DONT_TOUCH of o_dat : signal is "true";
    attribute DONT_TOUCH of count : signal is "true";

    attribute MARK_DEBUG : string;
    attribute MARK_DEBUG of i_rst : signal is "true";
    attribute MARK_DEBUG of i_val : signal is "true";
    attribute MARK_DEBUG of i_dat : signal is "true";
    attribute MARK_DEBUG of o_val : signal is "true";
    attribute MARK_DEBUG of o_dat : signal is "true";
    attribute MARK_DEBUG of count : signal is "true";

    
begin

        
    INP_proc: process(i_clk)
    begin
        if rising_edge(i_clk) then
            val_d1 <= i_val;
            val_d2 <= val_d1;
            val <= val_d1 and not val_d2;
            dat <= i_dat;

            stdata  <= std_logic_vector(resize(unsigned(dat), 32));
            stvalid <= val;
        end if;
    end process;



    s_axis_aresetn <= not i_rst;

    i_fifo : axis_data_fifo_0 
    port map(
        s_axis_aresetn => s_axis_aresetn,
        s_axis_aclk => i_clk,
        s_axis_tdata =>stdata,
        s_axis_tvalid =>stvalid,
        s_axis_tready => open,
        m_axis_tdata  => mtdata,
        m_axis_tvalid => mtvalid,
        m_axis_tready => mtready,
        axis_data_count => count
    );


    READY_proc: process(i_clk)
    begin
        if rising_edge(i_clk) then
            if i_rst = '1' then
                mtready <= '0';
            elsif unsigned(count) > DELAY_INT then
                mtready <= val;
            end if;
        end if;
    end process;


     o_dat <= mtdata(o_dat'range);
     o_val <= mtvalid;
   

end architecture Behavioral;