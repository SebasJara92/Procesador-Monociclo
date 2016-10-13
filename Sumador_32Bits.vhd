library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Sumador_32Bits is
    Port ( DataIn : in  STD_LOGIC_VECTOR(31 downto 0);   ---Dato de entrada de 32 bits
           DataIn_nPC : in  STD_LOGIC_VECTOR(31 downto 0);  ---Dato que llega de nPC de 32 bits
           DataOut : out  STD_LOGIC_VECTOR(31 downto 0));  --dato de salida de 32 bits
end Sumador_32Bits;

architecture Behavioral of Sumador_32Bits is

begin

	process(DataIn, DataIn_nPC)  ---Process con los dos datos de entrada
		begin
	
			DataOut <= DataIn + DataIn_nPC;  --suma 
	
	end process;
	
	
end Behavioral;

