----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.11.2023 09:58:10
-- Design Name: 
-- Module Name: sound - Behavioral
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


entity sound is
    Port ( 
           AC_SCK       :      OUT std_logic;
           sample       :      out STD_LOGIC_VECTOR(23 downto 0);
           valid        :      out STD_LOGIC
           );
           end sound;



architecture Behavioral of sound is
signal data_array : std_logic_vector(31 DOWNTO 0) := (others => '0');
signal fifo_depth_counter : integer := 0;
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
        signal s_axis_aresetn : STD_LOGIC;
        signal s_axis_aclk : STD_LOGIC;
        signal count : std_logic_vector(31 DOWNTO 0);
        signal stdata : std_logic_vector(31 DOWNTO 0);
        signal mtdata : std_logic_vector(31 DOWNTO 0);
        signal stready : std_logic;
        signal mtready : std_logic;        
        signal stvalid : std_logic;
        signal mtvalid : std_logic;      
begin
i_fifo : axis_data_fifo_0 port map(
s_axis_aresetn => s_axis_aresetn,
s_axis_aclk => s_axis_aclk,
s_axis_tdata=>stdata,
s_axis_tvalid=>stvalid,
s_axis_tready=>stready,
m_axis_tdata=>mtdata,
m_axis_tvalid=>mtvalid,
m_axis_tready=>mtready,
axis_data_count=>count
);
    process(stvalid, stready)
    begin
        if stvalid = '1' and stready = '1' then
            if fifo_depth_counter < 32768 then
                fifo_depth_counter <= fifo_depth_counter + 1;
            else
                mtready <= '1';
            end if;
        end if;
    end process;

    process(stvalid, stready)
    begin
        if mtready = '1' and fifo_depth_counter = 32768 then
            mtdata <= stdata;
        end if;
    end process;

end architecture Behavioral;