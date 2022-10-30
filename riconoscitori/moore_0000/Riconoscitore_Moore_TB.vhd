library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.ALL;


entity Riconoscitore_Moore_TB is
end Riconoscitore_Moore_TB;

architecture Behavioral of Riconoscitore_Moore_TB is

COMPONENT Riconoscitore_Moore
    PORT(
         i : IN  std_logic;
         RST,CLK : IN  std_logic;
         Y : OUT  std_logic
        );
    END COMPONENT;
    
--Inputs
   signal i : std_logic := '0';
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';

 	--Outputs
   signal Y : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Riconoscitore_Moore port map(
          i => i,
          RST => RST,
          CLK => CLK,
          Y => Y
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLK_period*10;

      -- insert stimulus here 
		i<='0';
		wait for 10 ns;
		i<='0';
		wait for 10 ns;
		i<='1';
		wait for 10 ns;
		i<='0';
		wait for 10 ns;
		i<='0';
		wait for 10 ns;
		i<='1';
		wait for 10 ns;
		i<='0';
		
      wait;
   end process;

END;