library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SEU is    --Unidad de extension de signo: incrementa la cantidad de bits de un número 
                 --preservando el signo y el valor del numero original.
    Port ( DataIn_Imm13 : in  STD_LOGIC_VECTOR(12 downto 0);  --Inmediato de 13
           DataOut_Imm32 : out  STD_LOGIC_VECTOR(31 downto 0)); --Inmediato de 32
end SEU;

architecture Behavioral of SEU is

begin

	process(DataIn_Imm13)
		begin
				if(DataIn_Imm13(12) = '1')then    ---Si la posicion 12 del inmediato es 1 entonces:
					DataOut_Imm32(12 downto 0) <= DataIn_Imm13;   --Pone los 13 bits del inmendiato en los primeros 13 bits de DataOut_Imm32
					DataOut_Imm32(31 downto 13) <= (others => '1'); --Y pone el resto de bits del DataOut_Imm32 en 1
				else 
					DataOut_Imm32(12 downto 0) <= DataIn_Imm13;
					DataOut_Imm32(31 downto 13) <= (others => '0');
				
				end if;
	end process;
		
end Behavioral;

