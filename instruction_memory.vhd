------------------------------------------------------
-- Bloco de instruções da memória
-- 
-- Contém todas as intruções que serão executadas.
-- 
-- 
-- Inicialmente este componente le o arquivo 'instructions.txt'
-- e salva ele em um segundo array
-- 
-- Pega um endereço de 32bits e retorna a instrução daquele endereço 
------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use STD.textio.all; -- Required for freading a file

entity instruction_memory is
	port (
		read_address: in STD_LOGIC_VECTOR (31 downto 0);
		instruction, last_instr_address: out STD_LOGIC_VECTOR (31 downto 0)
	);
end instruction_memory;


architecture behavioral of instruction_memory is	  

    -- 128 byte instruction memory (32 rows * 4 bytes/row)
    type mem_array is array(0 to 31) of STD_LOGIC_VECTOR (31 downto 0);
    signal data_mem: mem_array := (
        "00000000000000000000000000000000", -- initialize data memory
        "00100000000100000000000000000000", -- addi $zero, $zero, 0
        "00100000000100010000000000000001", -- addi $s0, $zero, 1
        "00100000000100100000000000000001", -- addi $s1, $zero, 1
        "00100000000010000000000000001111", -- addi $zero, $zero, 15
        "00100000000010010000000000000000", -- addi $t0, $zero, 0
        "00100000000010010000000000000000", -- addi $t0, $zero, 0
        "00010001000010010000000000011110", -- beq $s0, $t0, 30
        "10101100010100100000000000000100", -- sw $s1, 4($t0)
        "00000010001100001001000000100000", -- add $s2, $s1, $s0
        "00000000000100011000000000100000", -- add $s3, $s1, $t0
        "00000000000100101000100000100000", -- add $s4, $s1, $t2
        "00100001001010010000000000000001", -- addi $t2, $t2, 1
        "00100000010000100000000000000100", -- addi $t1, $zero, 4
        "00001000000000000000000000000111", -- j 7 
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",  
        "00000000000000000000000000000000", -- mem 20
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000", 
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000", 
        "00000000000000000000000000000000", -- mem 30
        "00000000000000000000000000000000"
    );
    begin

    -- Processo para ler intruções para a memoria
    

    -- Desde que os registradores são multiplos de 4 bits, podemos ignorar os ultimos dois
    instruction <= data_mem(to_integer(unsigned(read_address(31 downto 2))));

end behavioral;