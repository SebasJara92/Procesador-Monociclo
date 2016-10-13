library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use std.textio.all;


entity IM is
    Port ( ---clk : in STD_LOGIC;
	        DataIn : in  STD_LOGIC_VECTOR(31 downto 0);
           rst : in  STD_LOGIC;
           DataOut : out  STD_LOGIC_VECTOR(31 downto 0));
end IM;

architecture Behavioral of IM is   --Memoria de instrucciones

	type rom_type is array (0 to 63) of std_logic_vector (31 downto 0); --definición de la matriz: 
		                                                                 -- type "nombre tipo" is array
	impure function InitRomFromFile (RomFileName : in string) return rom_type is  --Una función impura es aquella que depende de elementos que no sean sólo 
	                                                                              --sus parámetros de entrada (e.g.shared variables).
																											--InitRomFromFile: Metodo para la inicializacion de la memoria(ROM)
		FILE RomFile : text open read_mode is RomFileName;
		variable RomFileLine : line;
		variable temp_bv : bit_vector(31 downto 0);
		variable temp_mem : rom_type;

		begin
		
			for I in rom_type'range loop
					readline (RomFile, RomFileLine);
					read(RomFileLine, temp_bv);
					temp_mem(i) := to_stdlogicvector(temp_bv);
			end loop;
		return temp_mem;
	end function;

		
	signal instructionsIn : rom_type := InitRomFromFile("prueba.txt");  --Señal que saca las instrucciones del archivo

begin
	process(rst,DataIn,instructionsIn)--clk) --Process sencible al reset, a la direccion de entrada y a las instrucciones que entran del archivo
	begin
		--if(rising_edge(clk))then  --Si hay un  flanco de subida entonces:
			if(rst = '1')then  --Si el reset esta en 1 entonces:
				DataOut <= (others=>'0'); --la instruccion de salida es 0
			else
				DataOut <= instructionsIn(conv_integer(DataIn(5 downto 0))); --De lo contrario el dato de salida es igual a la instruccion del archivo
			end if;
		--end if;
	end process;
end Behavioral;

