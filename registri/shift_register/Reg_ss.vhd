

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


--Shift register bidirectional
--dir=0 -> right shift
--dir=1 -> left shift
entity Reg_ss is
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
end Reg_ss;

architecture Behavioral of Reg_ss is
    signal output : std_logic_vector (n-1 downto 0) := (others => '0');
begin
    
    data_out <= output(n-1) when dir='1' else
                output(0);
                
    shift_reg_proc: process 
    begin 
        if(CLK'event and CLK = '1') then
            if(RST = '1') then
                output <= (others => '0');
            elsif(write = '1') then
                if(dir = '0') then
                    output(n-1) <= data_in;
                    output(n-2 downto 0) <= output(n-1 downto 1);
                else
                    output(0) <= data_in;
                    output(n-1 downto 1) <= output(n-2 downto 0);
                end if;
             
            end if;
        end if;
    
    end process;


end Behavioral;
