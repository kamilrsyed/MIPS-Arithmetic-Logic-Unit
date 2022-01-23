library ieee;
use ieee.std_logic_1164.all;

entity SYED_1bit_Full_Adder is

	port (fa_A, fa_B, fa_Cin	: in std_logic;
			fa_SUM, fa_Cout	: out std_logic);
			
end SYED_1bit_Full_Adder;

architecture Structure of SYED_1bit_Full_Adder is

	component SYED_Half_Adder	
	
		port (ha_A, ha_B			: in std_logic;
				ha_SUM, ha_Cout	: out std_logic);	
				
	end component;

	signal half_adder_sum, half_adder_Cout : std_logic_vector (1 downto 0);
	
begin
	
	HA_1 : SYED_Half_Adder
		port map ( 	ha_A=>fa_A,
						ha_B=>fa_B,
						ha_SUM=>half_adder_sum(0),
						ha_Cout=>half_adder_Cout(0) 
		);
		
	HA_2 : SYED_Half_adder
		port map ( 	ha_A=>fa_Cin,
						ha_B=>half_adder_sum(0),
						ha_SUM=>half_adder_sum(1),
						ha_Cout=>half_adder_Cout(1)
		);
		
	fa_SUM <= half_adder_sum(1);
	fa_Cout <= half_adder_Cout(0) OR half_adder_Cout(1);
	
		
end Structure;	