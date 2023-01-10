

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity TB_Reg_ss is
--  Port ( );
end TB_Reg_ss;

architecture Behavioral of TB_Reg_ss is
component Reg_ss
    generic ( 
        n : integer := 8
    );
    Port ( 
        CLK : in std_logic ;
        RST : in std_logic ;
        write: in std_logic;
        dir  :   in std_logic; 
        data_in: in std_logic;
        data_out: out std_logic
    );
end component ;
    signal clock : std_logic := '0';
    signal reset : std_logic := '0';
    signal enable: std_logic := '0';
    signal direction : std_logic := '0';
    signal data_input : std_logic := '0';
    signal data_output : std_logic := '0';
    constant CLK_period : time := 10ns; 
begin
    test_reg_ss: Reg_ss port map(
        clock,
        reset,
        enable,
        direction,
        data_input,
        data_output   
    );
    clk_proc: process
    begin
        clock <= '0';
        wait for CLK_period / 2;
        clock <= '1';
        wait for CLK_period /2;
    end process;
    
    test_proc: process 
    begin
        wait for 100ns;
        reset <= '1';
        wait for 10ns;
        reset <= '0';
        wait for 30ns;
        
        data_input <= '1';
        direction <= '0';
        --enable deve durare un periodo di clock
        enable <= '1';
        wait for 10ns;
        enable <= '0';
        
        wait for 100ns;
        data_input <= '1';
        direction <= '1';
        --enable deve durare un periodo di clock
        enable <= '1';
        wait for 10ns;
        enable <= '0';
        
        wait;
    end process;


end Behavioral;
