library IEEE;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity EQ_HPF is
    generic(
        H_DAT_WIDTH : positive := 16
    );
    port (
        H_i_aclk     : in  std_logic;
        H_i_val      : in  std_logic;
        H_i_dat      : in  std_logic_vector(H_DAT_WIDTH -1 downto 0);
        H_o_val      : out std_logic;
        H_o_dat      : out std_logic_vector(23 downto 0)
    );
end EQ_HPF;

architecture Behavioral of EQ_HPF is

    COMPONENT Xfir_HPF_128t_b16_Z700
    PORT (
        s_axis_data_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        s_axis_data_tready  : OUT STD_LOGIC;
        s_axis_data_tvalid : IN STD_LOGIC;
        aclk : IN STD_LOGIC;
        m_axis_data_tvalid : OUT STD_LOGIC;
        m_axis_data_tdata : OUT STD_LOGIC_VECTOR(39 DOWNTO 0)
    );
    END COMPONENT;
    
    signal Hval_d1 : std_logic;
    signal Hval_d2 : std_logic;
    signal Hval    : std_logic;
    signal Hdat    : std_logic_vector(H_DAT_WIDTH -1 downto 0);   
    
    signal H_aclk    : STD_LOGIC;
    signal H_stvalid : std_logic;
    signal H_stdata  : std_logic_vector(H_DAT_WIDTH -1 DOWNTO 0);
    signal H_mtvalid : std_logic;
    signal H_mtdata  : std_logic_vector(39 DOWNTO 0);     
    
    attribute DONT_TOUCH : string;
    attribute DONT_TOUCH of H_i_val : signal is "true";
    attribute DONT_TOUCH of H_i_dat : signal is "true";
    attribute DONT_TOUCH of H_o_val : signal is "true";
    attribute DONT_TOUCH of H_o_dat : signal is "true";

    attribute MARK_DEBUG : string;
    attribute MARK_DEBUG of H_i_val : signal is "true";
    attribute MARK_DEBUG of H_i_dat : signal is "true";
    attribute MARK_DEBUG of H_o_val : signal is "true";
    attribute MARK_DEBUG of H_o_dat : signal is "true";

begin

    H_INP_proc: process(H_i_aclk)
    begin
        if rising_edge(H_i_aclk) then
            Hval_d1 <= H_i_val;
            Hval_d2 <= Hval_d1;
            Hval <= Hval_d1 and not Hval_d2;
            Hdat <= H_i_dat;

            H_stdata  <= Hdat;
            H_stvalid <= Hval;
        end if;
    end process;
    
        fir_compiler_v7_2_6 : Xfir_HPF_128t_b16_Z700 
    port map(
        aclk => H_i_aclk,
        s_axis_data_tdata  => H_stdata,
        s_axis_data_tvalid => H_stvalid,
        s_axis_data_tready => open,
        m_axis_data_tdata  => H_mtdata,
        m_axis_data_tvalid => H_mtvalid
    );
    
end Behavioral;
