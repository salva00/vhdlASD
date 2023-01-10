----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clock_divider is
	 generic(
				clock_frequency_in : integer := 100000000;--100MHz
				clock_frequency_out : integer := 500 --500 Hz
				);
    Port ( clock_in : in  STD_LOGIC;
		   reset : in STD_LOGIC;
           clock_out : out  STD_LOGIC);
end clock_divider;

architecture Behavioral of clock_divider is

signal clockfx: std_logic := '0';

constant count_max_value : integer := (clock_frequency_in/clock_frequency_out) -1;

begin

clock_out <= clockfx;

count_for_division: process(clock_in)
variable counter : integer range 0 to count_max_value := 0;
begin
	
	if clock_in'event and clock_in = '1' then
	 if reset = '1' then
		counter := 0;
		clockfx <= '0';
	 else
		if counter = count_max_value then
			clockfx <=  '1';
			counter := 0;
		else
			clockfx <=  '0';
			counter := counter + 1;
		end if;
	 end if;
	end if;
end process;


end Behavioral;

