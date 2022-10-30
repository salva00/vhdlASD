library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Riconoscitore_Moore is
	port( i: in std_logic;
			RST, CLK: in std_logic;
			Y: out std_logic
	);
end Riconoscitore_Moore;

architecture Behavioral_1proc of Riconoscitore_Moore is

type stato is (S0, S1, S2, S3);
signal stato_corrente : stato := S0;
begin
stato_uscita_mem: process(CLK)
	begin
	if( CLK'event and CLK = '1' ) then
		if (RST = '1') then
		  stato_corrente <= S0;
		  Y <= '0';
		  
		else
		  case stato_corrente is
			when S0 =>
			    Y <= '0';
				if( i = '0' ) then
					stato_corrente <= S1;
				else 
					stato_corrente <= S0;
				end if;
			when S1 =>
				Y <= '0';
				if( i = '0' ) then
					stato_corrente <= S1;
				else
					stato_corrente <= S2;
				end if;
			when S2 =>
				Y <= '0';
				if( i = '0' ) then
					stato_corrente <= S3;
				else
					stato_corrente <= S0;
				end if;
			when S3 =>
				Y <= '1';
				if( i = '0' ) then
					stato_corrente <= S1;
				else
					stato_corrente <= S0;
				end if;
			when others =>
				stato_corrente <= S0;
				Y <= '0';
		end case;
	  end if;
	end if;
end process;

end Behavioral_1proc;


