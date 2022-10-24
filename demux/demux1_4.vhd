library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demux1_4 is
port( 
      a2 : in std_logic;
      s2 : in std_logic_vector(0 to 1); 
      y2 : out std_logic_vector(0 to 3) 
    );
end demux1_4;

architecture Dataflow of demux1_4 is

begin
    with s2 select
        y2 <= (0 => a2, others => '0') when "00",   --il bit piu a sx meno significativo
              (1 => a2, others => '0') when "10",
              (2 => a2, others => '0') when "01",
              (3 => a2, others => '0') when "11",
              "----" when others;
end Dataflow;
