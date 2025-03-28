library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_EQ_LPF is
end tb_EQ_LPF;

architecture Behavioral of tb_EQ_LPF is

    signal L_i_aclk      : std_logic := '0';
    signal L_i_val      : std_logic;
    signal L_i_dat      : std_logic_vector(15 downto 0);
    signal L_o_val      : std_logic;
    signal L_o_dat      : std_logic_vector(39 downto 0);

    constant CLK_PERIOD : time := 10 ns;

    -- instantiate the EQ_LPF module
    component EQ_LPF is
        generic(
            L_DAT_WIDTH : positive := 16
        );
        port (
            L_i_aclk      : in  std_logic;
            L_i_val      : in  std_logic;
            L_i_dat      : in  std_logic_vector(L_DAT_WIDTH -1 downto 0);
            L_o_val      : out std_logic;
            L_o_dat      : out std_logic_vector(39 downto 0)
        );
    end component;

begin

    uut: EQ_LPF
        port map (
            L_i_aclk => L_i_aclk,
            L_i_val => L_i_val,
            L_i_dat => L_i_dat,
            L_o_val => L_o_val,
            L_o_dat => L_o_dat
        );

    -- clock generation
    clk_process : process
    begin
        while True loop
            L_i_aclk <= '0';
            wait for CLK_PERIOD/2;
            L_i_aclk <= '1';
            wait for CLK_PERIOD/2;
        end loop;
        wait;
    end process;

    stimulus: process
    begin
        -- Test 1: Signal < 500 Hz
        L_i_val <= '1';
        L_i_dat <= x"1F4"; -- 500 in hex
        wait for 20 ns;

        -- Test 2: Signal > 500 Hz
        L_i_dat <= x"FFF"; -- Some value > 500 in hex
        wait for 20 ns;

        -- Test 3: Check output for 30 dB boost
        assert (L_o_dat = x"0078A1B5") report "Output did not match expected value for 30 dB boost" severity error; -- Expected 30 dB boost output

        -- Test 4: Signal stops
        L_i_val <= '0';
        wait for 20 ns;

        -- End simulation
        wait;
    end process;

end Behavioral;
