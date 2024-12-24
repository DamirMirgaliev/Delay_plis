library IEEE;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity EQ_LPF is
    generic(
    L_DAT_WIDTH : positive := 16
);
port (
    L_i_aclk      : in  std_logic;
    L_i_val      : in  std_logic;
    L_i_dat      : in  std_logic_vector(L_DAT_WIDTH -1 downto 0);
    L_o_val      : out std_logic;
    L_o_dat      : out std_logic_vector(L_DAT_WIDTH -1 downto 0)
);
end EQ_LPF;

architecture Behavioral of EQ_LPF is

    COMPONENT Xfir_LPF_128t_b16_Z7000
    PORT (
        s_axis_data_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        s_axis_data_tready  : OUT STD_LOGIC;
        s_axis_data_tvalid : IN STD_LOGIC;
        aclk : IN STD_LOGIC;
        m_axis_data_tvalid : OUT STD_LOGIC;
        m_axis_data_tdata : OUT STD_LOGIC_VECTOR(39 DOWNTO 0)
    );
    END COMPONENT;
    
    signal Lval_d1 : std_logic;
    signal Lval_d2 : std_logic;
    signal Lval    : std_logic;
    signal Ldat    : std_logic_vector(L_DAT_WIDTH -1 downto 0);
    
    signal L_aclk : STD_LOGIC;
    signal L_stvalid : std_logic;
    signal L_stdata  : std_logic_vector(15 DOWNTO 0);
    signal L_mtvalid : std_logic;
    signal L_mtdata  : std_logic_vector(39 DOWNTO 0);  
    
    attribute DONT_TOUCH : string;
    attribute DONT_TOUCH of L_i_val : signal is "true";
    attribute DONT_TOUCH of L_i_dat : signal is "true";
    attribute DONT_TOUCH of L_o_val : signal is "true";
    attribute DONT_TOUCH of L_o_dat : signal is "true";

    attribute MARK_DEBUG : string;
    attribute MARK_DEBUG of L_i_val : signal is "true";
    attribute MARK_DEBUG of L_i_dat : signal is "true";
    attribute MARK_DEBUG of L_o_val : signal is "true";
    attribute MARK_DEBUG of L_o_dat : signal is "true";
    
        -- Определение диапозона для трех фильтров
--    constant low_filter : coeff_array := (
--        to_signed(10, WIDTH),
--        to_signed(200, WIDTH)
--    );

--    constant mid_filter : coeff_array := (
--        to_signed(200, WIDTH),
--        to_signed(5000, WIDTH)
--    );

--    constant high_filter : coeff_array := (
--        to_signed(5000, WIDTH),
--        to_signed(20000, WIDTH)
--    );

--    signal x_reg1, x_reg2, x_reg3 : array(0 to N-1) of signed(WIDTH-1 downto 0);
--    signal y1_int, y2_int, y3_int : signed(WIDTH-1 downto 0);
--    signal y_combined : signed(WIDTH-1 downto 0);
    
begin
    
        L_INP_proc: process(L_i_aclk)
    begin
        if rising_edge(L_i_aclk) then
            Lval_d1 <= L_i_val;
            Lval_d2 <= Lval_d1;
            Lval <= Lval_d1 and not Lval_d2;
            Ldat <= L_i_dat;

            L_stdata  <= Ldat;
            L_stvalid <= Lval;
        end if;
    end process;

    fir_compiler_v7_2_6 : Xfir_LPF_128t_b16_Z7000 
    port map(
        aclk => L_i_aclk,
        s_axis_data_tdata => L_stdata,
        s_axis_data_tvalid => L_stvalid,
        s_axis_data_tready => open,
        m_axis_data_tdata  => L_mtdata,
        m_axis_data_tvalid => L_mtvalid
    );


    -- FIR-фильтр 1
--    process(clk, reset)
--    begin
--        if reset = '1' then
--            x_reg1 <= (others => (others => '0'));
--            y1_int <= (others => '0');
--        elsif rising_edge(clk) then
--            x_reg1(0) <= signed(x);
--            for i in N-1 downto 1 loop
--                x_reg1(i) <= x_reg1(i-1);
--            end loop;

--            y1_int <= (others => '0');
--            for i in 0 to N-1 loop
--                y1_int <= y1_int + (x_reg1(i) * coeffs_filter1(i));
--            end loop;
--        end if;
--    end process;

--    -- FIR-фильтр 2
--    process(clk, reset)
--    begin
--        if reset = '1' then
--            x_reg2 <= (others => (others => '0'));
--            y2_int <= (others => '0');
--        elsif rising_edge(clk) then
--            x_reg2(0) <= signed(x);
--            for i in N-1 downto 1 loop
--                x_reg2(i) <= x_reg2(i-1);
--            end loop;

--            y2_int <= (others => '0');
--            for i in 0 to N-1 loop
--                y2_int <= y2_int + (x_reg2(i) * coeffs_filter2(i));
--            end loop;
--        end if;
--    end process;

--    -- FIR-фильтр 3
--    process(clk, reset)
--    begin
--        if reset = '1' then
--            x_reg3 <= (others => (others => '0'));
--            y3_int <= (others => '0');
--        elsif rising_edge(clk) then
--            x_reg3(0) <= signed(x);
--            for i in N-1 downto 1 loop
--                x_reg3(i) <= x_reg3(i-1);
--            end loop;

--            y3_int <= (others => '0');
--            for i in 0 to N-1 loop
--                y3_int <= y3_int + (x_reg3(i) * coeffs_filter3(i));
--            end loop;
--        end if;
--    end process;

    -- Комбинирование выходных сигналов
--    process(y1_int, y2_int, y3_int)
--    begin
--        y_combined <= y1_int + y2_int + y3_int; -- Суммируем три выходных сигнала
--        y <= std_logic_vector(y_combined);
--    end process;
end Behavioral;
