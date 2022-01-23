library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;


entity SYED_IMM_register is
port(
 rdaddr			: in std_logic_vector(4 downto 0);
 wraddr			: in std_logic_vector(4 downto 0);
 data				: in std_logic_vector(15 downto 0); 
 wren				: in std_logic;    
 clock			: in std_logic; 
 Q				: out std_logic_vector(15 downto 0) 
);
end SYED_IMM_register;

architecture Behavioral of SYED_IMM_register is
--initializizng memory array
type SYED_IMM is array (0 to 31 ) of std_logic_vector (15 downto 0);

signal SYED_IMM_array: SYED_IMM:=(
	"0000000011111111",
	"0000000000000000",
	"0000000000000000",
	"0000000000000000",
   "0000000000000000",
	"0000000000000000",
	"0000000000000000",
	"0000000000000000",
   "0000000000000000",
	"0000000000000000",
	"0000000000000000",
	"0000000000000000", 
   "0000000000000000",
	"0000000000000000",
	"0000000000000000",
	"0000000000000000",
   "0000000000000000",
	"0000000000000000",
	"0000000000000000",
	"0000000000000000",
   "0000000000000000",
	"0000000000000000",
	"0000000000000000",
	"0000000000000000",
   "0000000000000000",
	"0000000000000000",
	"0000000000000000",
	"0000000000000000",
   "0000000000000000",
	"0000000000000000",
	"0000000000000000",
	"0000000000000000"
	);

begin	
	process(clock)
	begin
	 if(rising_edge(clock)) then
	 
		 if(wren='1') then 
			--converting address to integer
		 SYED_IMM_array(to_integer(unsigned(wraddr))) <= data;
		 end if;
		 
	 end if;
	end process;
	
	 -- output
	 Q <= SYED_IMM_array(to_integer(unsigned(rdaddr)));
end Behavioral;