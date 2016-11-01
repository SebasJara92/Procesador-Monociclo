library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RF is
    Port ( DataIn_rs1 : in  STD_LOGIC_VECTOR(5 downto 0);  --registro fuente 1
           DataIn_rs2 : in  STD_LOGIC_VECTOR(5 downto 0); --registro fuente 2
           DataIn_rd : in  STD_LOGIC_VECTOR(5 downto 0);  --registro destino
           DataWrite : in  STD_LOGIC_VECTOR(31 downto 0); --dato a escribir
           rst : in  STD_LOGIC;
           DataOut_crs1 : out  STD_LOGIC_VECTOR(31 downto 0); --dato con el contenido de resgristo 1
           DataOut_crs2 : out  STD_LOGIC_VECTOR(31 downto 0)); --dato con el contenido de registro 2
end RF;

architecture Behavioral of RF is

	type Memory_RF is array (0 to 63) of std_logic_vector (31 downto 0); --Modelo de memoria(ram_type) donde se crea un arreglo 
	                                                                    --de 64 posiciones(el alto del RF) y un vector de 32 posiciones(el ancho del RF) 
	signal registros : Memory_RF :=(others => x"00000000"); --Se crea una señal con los registros en x"00000000"

begin

process(rst,DataIn_rs1,DataIn_rs2,DataIn_rd,DataWrite)
	begin
		registros(0) <= x"00000000"; --Asegura que se quede en cero (g0)
			if(rst = '1')then --Si reset está activado entonces: Todo en '0'
				DataOut_crs1 <= (others=>'0');
				DataOut_crs2 <= (others=>'0');
				registros <= (others => x"00000000");
			else
				DataOut_crs1 <= registros(conv_integer(DataIn_rs1)); --registran los datos de entrada 
				DataOut_crs2 <= registros(conv_integer(DataIn_rs2));
			   if(DataIn_rd /= "00000")then
					registros(conv_integer(DataIn_rd)) <= DataWrite;	
				end if;
			end if;
		
	end process;

end Behavioral;

