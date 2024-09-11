library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Rattling is
    port(
    C, CLR         : in STD_LOGIC; -- C - Positive-Edge Clock, CLR - Asynchronous Reset (Active High) 
    clk_100        : in STD_LOGIC;
    Q              : out STD_LOGIC_VECTOR(3 downto 0); -- Q - Data Output
    new_sample     : out STD_LOGIC;                      -- active for 1 clk cycle if new "line in" sample is tranmitted/received
    sample_clk_48k : out STD_LOGIC                       -- sample clock (new sample at rising edge)
    );   
end Rattling;

architecture Behavioral of Rattling is
    signal tmp: std_logic_vector(3 downto 0);
    signal log : std_logic := '0';
begin
    process (C, CLR, log)
    begin
        if (CLR='1') then
            tmp <= "0000";
        elsif (C'event and C='1') then
            tmp <= tmp + 1;
        end if;
    
        if (log = '1') then
    
        end if;
end process;

    Q <= tmp;
    
    

end Behavioral;
