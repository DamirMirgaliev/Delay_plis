library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity tb_fifo_delay is
end tb_fifo_delay;

architecture testbench of tb_fifo_delay is

    constant CLK_PERIOD : time := 20 ns;
    constant DAT_WIDTH : positive := 24;

    signal i_clk : std_logic := '0';
    signal i_rst : std_logic := '0';
    signal i_val : std_logic := '0';
    signal i_dat : std_logic_vector(DAT_WIDTH - 1 downto 0) := (others => '0');
    signal o_val : std_logic;
    signal o_dat : std_logic_vector(DAT_WIDTH - 1 downto 0);

begin

    -- Установка DUT
    uut: entity work.fifo_delay
        generic map (
            DAT_WIDTH => DAT_WIDTH
        )
        port map (
            i_clk => i_clk,
            i_rst => i_rst,
            i_val => i_val,
            i_dat => i_dat,
            o_val => o_val,
            o_dat => o_dat
        );

    -- Генерация тактового сигнала
    clk_process : process
    begin
        while true loop
            i_clk <= '0';
            wait for CLK_PERIOD / 2;
            i_clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    -- Основной процесс тестирования
    stim_process : process
    begin
        -- Сброс
        i_rst <= '1';
        wait for CLK_PERIOD * 2;
        i_rst <= '0';
        wait for CLK_PERIOD;

        -- Тестовые векторы
        i_val <= '1';
        i_dat <= std_logic_vector(to_signed(10, DAT_WIDTH));
        wait for CLK_PERIOD;

        i_val <= '0'; -- Убираем валидность
        wait for CLK_PERIOD * 5;

        i_val <= '1';
        i_dat <= std_logic_vector(to_signed(20, DAT_WIDTH));
        wait for CLK_PERIOD;

        i_val <= '0';
        wait for CLK_PERIOD * 5;

        i_val <= '1';
        i_dat <= std_logic_vector(to_signed(30, DAT_WIDTH));
        wait for CLK_PERIOD;

        -- Завершение теста
        wait;
    end process;

end architecture testbench;