library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_EQ_HPF is
end tb_EQ_HPF;

architecture Behavioral of tb_EQ_HPF is

    -- Constants
    constant CLK_PERIOD : time := 10 ns;

    -- Signals
    signal H_i_aclk      : std_logic := '0';
    signal H_i_val       : std_logic := '0';
    signal H_i_dat       : std_logic_vector(15 downto 0) := (others => '0');
    signal H_o_val       : std_logic;
    signal H_o_dat       : std_logic_vector(39 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.EQ_HPF
        generic map(
            H_DAT_WIDTH => 16
        )
        port map(
            H_i_aclk => H_i_aclk,
            H_i_val => H_i_val,
            H_i_dat => H_i_dat,
            H_o_val => H_o_val,
            H_o_dat => H_o_dat
        );

    -- Clock generation
    H_i_aclk_process: process
    begin
        while true loop
            H_i_aclk <= '0';
            wait for CLK_PERIOD / 2;
            H_i_aclk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    -- Stimulus process
    stimulus_process: process
    begin        
        -- Test Case 1: Simple Input Test (Below 500 Hz)
        H_i_val <= '1';
        H_i_dat <= "0000000000001010"; -- 10 (меньше 500 √ц)
        wait for CLK_PERIOD; 
        H_i_val <= '0';
        wait for CLK_PERIOD;

        -- Test Case 2: Another Input Test (Above 500 Hz)
        H_i_val <= '1';
        H_i_dat <= "0011111010000000"; -- 4800 (выше 500 √ц)
        wait for CLK_PERIOD; 
        H_i_val <= '0';
        wait for CLK_PERIOD;

        -- Test Case 3: High Frequency Signal (Above 500 Hz)
        H_i_val <= '1';
        H_i_dat <= "0111111010000000"; -- 7800 (выше 500 √ц)
        wait for CLK_PERIOD; 
        H_i_val <= '0';
        wait for CLK_PERIOD;

        -- Test Case 4: Check Edge Case (Exactly 500 Hz)
        H_i_val <= '1';
        H_i_dat <= "0000001000000000"; -- 512 (равно 500 √ц)
        wait for CLK_PERIOD; 
        H_i_val <= '0';
        wait for CLK_PERIOD;

        -- Test Case 5: Low Frequency Signal (Below 500 Hz)
        H_i_val <= '1';
        H_i_dat <= "0000000000000011"; -- 3 (меньше 500 √ц)
        wait for CLK_PERIOD; 
        H_i_val <= '0';
        wait for CLK_PERIOD;

        -- Test Case 6: Increase Volume by 30 dB (Above 500 Hz)
        H_i_val <= '1';
        H_i_dat <= std_logic_vector(unsigned(to_unsigned(10, 16)) + unsigned(to_unsigned(30, 16))); -- ”величение громкости на 30 дЅ (результат должен быть выше 500 √ц)
        wait for CLK_PERIOD;
        H_i_val <= '0';
        wait for CLK_PERIOD;

        -- Additional test cases can be added as needed

        wait;
    end process;

end Behavioral;
