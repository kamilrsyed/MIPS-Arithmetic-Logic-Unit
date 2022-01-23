library ieee;
use ieee.std_logic_1164.all;

entity SYED_nbit_Add_Sub is
	-- defining generic n
	generic 	(n				: integer:= 16
				);
	
	port 		(A, B									: in std_logic_vector(n-1 downto 0);
				Cin									: in std_logic;
				SUM									: out std_logic_vector(n-1 downto 0);
				Cout, O_flag, N_flag				: out std_logic
				);
			
end SYED_nbit_Add_Sub;

architecture Structure of SYED_nbit_Add_Sub is
	
	component SYED_1bit_Full_Adder is
	
		port (fa_A, fa_B, fa_Cin	: in std_logic;
				fa_SUM, fa_Cout		: out std_logic
				);
				
	end component;
	
	component SYED_Overflow_Logic is
	
		port 	(MSB, MSB_Cout, MSB_Cin		: in std_logic;	
				 OVERFLOW, NEGATIVE			: out std_logic
				 );
	end component;
	
	signal onebitSUM 			: std_logic_vector (n-1 downto 0);
	signal Carry				: std_logic_vector (n-1 downto 0);
	signal Op_code				: std_logic;
	signal sub_var				: std_logic_vector (n-1 downto 0);

	
begin

	-- Op_code defines whether the circuit would behave as adder or subtractor
	-- Op_code = 0 (adder) Op_code = 1 (subtractor)
	Op_code <= Cin;
	
	process (sub_var, Op_code, B) is	
	begin
	
		-- perforing two's compliment of all the bits of B when Op_code = 1
		for i in 0 to n-1 loop		
			sub_var(i) <= B(i) xor Op_code;
		end loop;
		
	end process;
	
	FA_0 : SYED_1bit_Full_Adder
			port map ( 	fa_A=>A(0), fa_B=>sub_var(0), fa_Cin=>Cin, fa_SUM=>onebitSUM(0), fa_Cout=>Carry(0) );
	
	FA: for i in 1 to n-1 generate	
		FA_i : SYED_1bit_Full_Adder
			port map ( 	fa_A=>A(i), fa_B=>sub_var(i), fa_Cin=>Carry(i-1), fa_SUM=>onebitSUM(i), fa_Cout=>Carry(i) );		
	end generate;
	
	O_L: SYED_Overflow_Logic
			port map (  MSB=>onebitSUM(n-1), MSB_Cout=>Carry(n-1), MSB_Cin=>Carry(n-2), OVERFLOW=>O_flag, NEGATIVE=>N_flag );
		
	SUM <= onebitSUM;
	Cout <= Carry(n-1);
		
end Structure;	