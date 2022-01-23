library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SYED_mini_ALU is

	port
	(
					S										: in std_logic;
					clk									: in std_logic;
					ir										: in	std_logic_vector(31 downto 0);
					Cout									: out std_logic;
					Overflow								: out std_logic;
					Negative								: out std_logic;
					Result								: out std_logic_vector(31 downto 0);
					rd: out std_logic_vector(31 downto 0)
	);
	
end SYED_mini_ALU;

architecture Structure of SYED_mini_ALU is

	component SYED_nbit_Add_Sub is
		generic 	(n				: integer:= 32
		);
		port 		(A, B									: in std_logic_vector(n-1 downto 0);
					Cin									: in std_logic;
					SUM									: out std_logic_vector(n-1 downto 0);
					Cout, O_flag, N_flag				: out std_logic
		);
			
	end component;

	component SYED_register_file IS
		port
		(
					rd1add								: in std_logic_vector(4 downto 0);
					rd2add								: in std_logic_vector(4 downto 0);
					wradd									: in std_logic_vector(4 downto 0);
					data									: in std_logic_vector(31 downto 0); 
					wren									: in std_logic;    
					clock									: in std_logic; 
					Q1										: out std_logic_vector(31 downto 0);
					Q2										: out std_logic_vector(31 downto 0) 
		);
	end component;
	
	component SYED_IMM_register is
		port
		(
					rdaddr								: in std_logic_vector(4 downto 0);
					wraddr								: in std_logic_vector(4 downto 0);
					data									: in std_logic_vector(15 downto 0); 
					wren									: in std_logic;    
					clock									: in std_logic; 
					Q										: out std_logic_vector(15 downto 0) 
		);
	end component;
	
	signal op_code 		: std_logic_vector (3 downto 0);
	signal rd_addr			: std_logic_vector (4 downto 0);
	signal rt_addr			: std_logic_vector (4 downto 0);
	signal rs_addr			: std_logic_vector (4 downto 0);
	signal SUM				: std_logic_vector (31 downto 0);
	signal rd_data			: std_logic_vector (31 downto 0);
	signal rt_data			: std_logic_vector (31 downto 0);
	signal rs_data			: std_logic_vector (31 downto 0);
	signal tmp 				: std_logic_vector (31 downto 0);
	signal rt_data_bitw	: std_logic_vector (31 downto 0);
	signal rs_data_bitw	: std_logic_vector (31 downto 0);
	signal tmp_bitw 		: std_logic_vector (31 downto 0);
	signal tmp_IMM			: std_logic_vector (15 downto 0);
	signal IMM				: std_logic_vector (31 downto 0);
	signal IMM_zex			: std_logic_vector (31 downto 0);
	signal shamt 			: std_logic_vector (3 downto 0);
	signal carry			: std_logic;
	signal reg_wr			: std_logic;

begin



	op_code <= ir (31 downto 28);
	rd_addr <= ir (27 downto 23);
	rt_addr <= ir (22 downto 18);
	rs_addr <= ir (17 downto 13);
	
	
	
	SYED_IMM :	SYED_IMM_register
		port map ( rdaddr=>"00000", wraddr=>"11111", wren=>'0', data=>"0000000000000000", clock=>clk, Q=>tmp_IMM );
	
	SYED_register: SYED_register_file
		port map ( rd1add=>rs_addr, rd2add=>rt_addr, wradd=>rd_addr, data=>tmp, wren=>reg_wr, clock=>clk, Q1=>rs_data, Q2=>rt_data );
					
	SYED_add_sub : SYED_nbit_Add_Sub
		port map ( A=>rs_data, B=>rt_data, Cin=>carry, SUM=>tmp, Cout=>Cout, O_flag=>Overflow, N_flag=>Negative );
		
	
	rt_data_bitw <= rt_data;
	rs_data_bitw <= rs_data;
	
	
	process (op_code, rs_addr, rt_addr, rd_addr, SUM, rd_data, rs_data, rt_data, tmp)
		begin
		
			if S ='1' then
				if tmp_IMM(15) ='0' then
					IMM <= B"0000000000000000" & tmp_IMM;
					
				elsif tmp_IMM(15) ='1' then
					IMM <= B"1111111111111111" & tmp_IMM;
				end if;
	
			elsif S = '0' then
				IMM <= B"0000000000000000" & tmp_IMM;	
			end if;
	
			IMM_zex <= B"0000000000000000" & tmp_IMM;
			shamt	  <= tmp_IMM (3 downto 0); 
		
			case op_code is
			
				when "0000" => --add
					if rt_data(31) = '1' then
						carry	<= '1';
					else
						carry <= '0';
					end if;
					
					reg_wr	<= '0';
					Result	<= tmp;
					rd			<= tmp;
				
				when "0001" => --addu
					carry 	<= '0';
					reg_wr	<= '0';
					Result	<= tmp;
					rd			<= tmp;
				
				when "0010" => --addi
					if IMM(31) = '1' then
						carry	<= '1';
					else
						carry <= '0';
					end if;
					
					reg_wr	<= '0';
					Result	<= tmp;
				
				when "0011" => --addiu
					carry 	<= '0';
					reg_wr	<= '0';
					Result	<= tmp;
				
				when "0100" => --sub
					carry 	<= '1';
					reg_wr	<= '0';
					Result	<= tmp;
					rd			<= tmp;
				
				when "0101" => --subu
					carry 	<= '1';
					reg_wr	<= '0';
					Result	<= tmp;
					rd			<= tmp;
				
				when "0110" => --bitwise and
					tmp_bitw<= rs_data_bitw and rt_data_bitw;
					Result 	<= tmp_bitw;
					rd 		<= tmp_bitw;
				
				when "0111" => --bitwise andi
					tmp_bitw<= rs_data_bitw and IMM_zex;
					Result 	<= tmp_bitw;
					rd 		<= tmp_bitw;
				
				when "1000" => --bitwise nor
					tmp_bitw<= rs_data_bitw nor rt_data_bitw;
					Result 	<= tmp_bitw;
					rd 		<= tmp_bitw;
				
				when "1001" => --bitwise ori
					tmp_bitw<= rs_data_bitw or IMM_zex;
					Result 	<= tmp_bitw;
					rd 		<= tmp_bitw;
				
				when "1010" => --sll
					tmp_bitw <= std_logic_vector (shift_left(unsigned(rt_data), to_integer(unsigned(shamt))));
					Result 	<= tmp_bitw;
					rd 		<= tmp_bitw;
				
				when "1011" => --srl
					tmp_bitw <= std_logic_vector (shift_right(unsigned(rt_data), to_integer(unsigned(shamt))));
					Result 	<= tmp_bitw;
					rd 		<= tmp_bitw;
				
				when "1100" => --sra
					tmp_bitw <= std_logic_vector (shift_right(signed(rt_data), to_integer(unsigned(shamt))));
					Result 	<= tmp_bitw;
					rd 		<= tmp_bitw;
				
				when "1101" => --lw
					
				
				
				when "1110" => --sw
				
				
				when others =>
				
			end case;
		
	end process;

end Structure;