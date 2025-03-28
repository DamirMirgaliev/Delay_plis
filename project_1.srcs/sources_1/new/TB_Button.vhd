library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_button is
end tb_button;

architecture testbench of tb_button is

    constant CLK_PERIOD : time := 20 ns;

    signal i_clk : std_logic := '0';
    signal i_press : std_logic := '0';
    signal o_short : std_logic;
    signal o_long : std_logic;

begin

    -- DUT
    uut: entity work.button
        generic map (
            FCLK => 50.0e6,
            SHORT_PRESS_DURATION => 0.1,
            LONG_PRESS_DURATION => 1.0
        )
        port map (
            i_clk => i_clk,
            i_press => i_press,
            o_short => o_short,
            o_long => o_long
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

    -- Стимулы
    stim_process : process
    begin
        -- Начальные состояния
        i_press <= '0';
        wait for CLK_PERIOD * 2;

        -- Краткое нажатие
        i_press <= '1';
        wait for 1 ms;  -- Установка нажатия на 1 мс
        i_press <= '0'; 
        wait for CLK_PERIOD * 10;  -- Подождать перед следующим тестом

        -- Долгое нажатие
        i_press <= '1';
        wait for 10 ms;  -- Установка нажатия на 10 мс
        i_press <= '0';
        wait for CLK_PERIOD * 10;  -- Подождать перед завершением теста

        wait;
    end process;

end architecture testbench;