library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Riconoscitore_Mealy is
	port( i: in std_logic;
		  RST, CLK: in std_logic;
			Y: out std_logic
	);
end Riconoscitore_Mealy;

-- versione con 1 process:
architecture Behavioral_1proc of Riconoscitore_Mealy is

type stato is (S0, S1, S2);
signal stato_corrente : stato := S0;
begin
stato_uscita_mem: process(CLK)
	begin
	if rising_edge(CLK) then
	   if( RST = '1') then
	       stato_corrente <= S0;
	       Y <= '0';
	   else
	   	case stato_corrente is
			when S0 =>
				if( i = '0' ) then
					stato_corrente <= S1;
					Y <= '0';
				else 
					stato_corrente <= S0;
					Y <= '0';
				end if;
			when S1 =>
				if( i = '0' ) then
					stato_corrente <= S1;
					Y <= '0';
				else
					stato_corrente <= S2;
					Y <= '0';
				end if;
			when S2 =>
				if( i = '0' ) then
					stato_corrente <= S0;
					Y <= '1';
				else
					stato_corrente <= S0;
					Y <= '0';
				end if;
			when others =>
			        stato_corrente <= S0;
			        Y <= '0';
		end case;
		end if;
	end if;
end process;

end Behavioral_1proc;



-- versione con 2 process: attenzione, in presenza di pi� architecture
-- viene sintetizzata quella che compare per ultima nel file
architecture Behavioral_2proc of Riconoscitore_Mealy is

type stato is (S0, S1, S2);

signal stato_corrente : stato := S0;
signal stato_prossimo : stato;

begin

-- questo processo rappresenta la parte combinatoria di una macchina sequenziale
stato_uscita: process(stato_corrente, i)
	begin
	   case stato_corrente is
			when S0 =>
				if( i = '0' ) then
					stato_prossimo <= S1;
					Y <= '0';
				else 
					stato_prossimo <= S0;
					Y <= '0';
				end if;
			when S1 =>
				if( i = '0' ) then
					stato_prossimo <= S1;
					Y <= '0';
				else
					stato_prossimo <= S2;
					Y <= '0';
				end if;
			when S2 =>
				if( i = '0' ) then
					stato_prossimo <= S0;
					Y <= '1';
				else
					stato_prossimo <= S0;
					Y <= '0';
				end if;
		end case;
end process;

-- questo processo rappresenta gli elementi di memoria 
mem: process (CLK)
begin
	if( CLK'event and CLK = '1' ) then
		if( RST = '1') then
	       stato_corrente <= S0;
	    else
	       stato_corrente <= stato_prossimo;
	    end if;
   end if;
end process;


end Behavioral_2proc;

