library ieee;
use ieee.std_logic_1164.all;

entity SYED_Half_Adder is

	port (ha_A, ha_B			: in std_logic;
			ha_SUM, ha_Cout	: out std_logic);

end SYED_Half_Adder;

architecture Behavioral of SYED_Half_Adder is

begin
	
	P1: process (ha_A, ha_B)
			begin 
				ha_SUM <= ha_A xor ha_B;
			end process;
			
	P2: process (ha_A, ha_B)
			begin
				ha_Cout <= ha_A and ha_B;
			end process;
		
end Behavioral;	