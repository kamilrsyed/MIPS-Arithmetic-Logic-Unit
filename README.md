# MIPS-Arithmetic-Logic-Unit
This was one of the class projects for CS343 

----------------README--------------------

to verify the design:

- copy all project in ModelSim software
- compile all the files
- simulate SYED_mini_ALU and provide instruction
in IR signal
- set the rs, rt register values to perform
various mips instructions
- rs address is 0b00000 in SYED_register_file
- rt address is 0b00001 in SYED_register_file
- rd address is 0b00011 in SYED_register_file
- imm address is 0b00000 in SYED_IMM_register

Op_codes for instructions are:
- add		0000
- addu	0001
- addi	0010
- addiu	0011
- sub		0100
- subu	0101
- and		0110
- andi	0111
- nor		1000
- ori		1001
- sll		1010
- srl		1011
- srl		1100
- lw 		1101
- sw		1110
