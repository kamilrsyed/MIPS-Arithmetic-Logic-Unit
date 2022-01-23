library ieee;
use ieee.std_logic_1164.all;

entity SYED_Overflow_Logic is
	
	port 		(MSB, MSB_Cout, MSB_Cin		: in std_logic;	
				 OVERFLoW, NEGATIVE			: out std_logic
				);
			
end SYED_Overflow_Logic;

architecture behavior of SYED_Overflow_Logic is

begin

	OVERFLOW <= MSB_Cout xor MSB_Cin;
	NEGATIVE <= MSB;
	
end behavior;