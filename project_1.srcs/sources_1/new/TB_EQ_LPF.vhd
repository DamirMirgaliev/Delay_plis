library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TB_EQ_LPF is
end TB_EQ_LPF;

architecture Behavioral of TB_EQ_LPF is

    -- ���������
    constant CLK_PERIOD : time := 10 ns;
    constant TEST_DATA_WIDTH : positive := 16;

    -- ������� ��� ������������
    signal L_i_aclk : std_logic := '0';
    signal L_i_val : std_logic := '0';
    signal L_i_dat : std_logic_vector(TEST_DATA_WIDTH - 1 downto 0) := (others => '0');
    signal L_o_val : std_logic;
    signal L_o_dat : std_logic_vector(39 downto 0);

begin

    -- ������������ DUT (Device Under Test)
    DUT: entity work.EQ_LPF
    generic map(
        L_DAT_WIDTH => TEST_DATA_WIDTH
    )
    port map(
        L_i_aclk => L_i_aclk,
        L_i_val => L_i_val,
        L_i_dat => L_i_dat,
        L_o_val => L_o_val,
        L_o_dat => L_o_dat
    );

    -- ��������� ��������� �������
    clk_process : process
    begin
        while true loop
            L_i_aclk <= '0';
            wait for CLK_PERIOD / 2;
            L_i_aclk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    -- �������� �������
    stim_process: process
    begin
        -- ��������� ���������
        L_i_val <= '0';
        L_i_dat <= (others => '0');
        wait for 20 ns;  -- ����, ����� DUT ����������������

        -- ������ ������ �� ����
        L_i_val <= '1';
        L_i_dat <= std_logic_vector(to_unsigned(10, TEST_DATA_WIDTH));  -- ������ ������
        wait for CLK_PERIOD;

        -- ������� ���������� ���������
        L_i_val <= '0';
        wait for 20 ns; -- ���� ����� ��������� ����������

        -- ����� �������� ����� �������� ������
        L_i_val <= '1';
        L_i_dat <= std_logic_vector(to_unsigned(20, TEST_DATA_WIDTH));  -- ������ �������� ������
        wait for CLK_PERIOD;

        -- ������� ���������� ���������
        L_i_val <= '0';
        wait for 20 ns;

        -- ���������� ���������
        wait;
    end process;

end Behavioral;