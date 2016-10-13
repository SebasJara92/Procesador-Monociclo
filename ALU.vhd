library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL; ---libreria para operaciones aritméticas

entity ALU is  --ALU: calcula operaciones aritméticas (como suma, resta, multiplicación, etc.) y operaciones lógicas (sí, y, o, no), entre valores (generalmente uno o dos
    Port ( DataIn_crs1 : in  STD_LOGIC_VECTOR(31 downto 0);  ---rS1
           DataIn_crs2 : in  STD_LOGIC_VECTOR(31 downto 0); ----rS2
           Data_ALUOP: in  STD_LOGIC_VECTOR(5 downto 0);
           DataOut_Result : out  STD_LOGIC_VECTOR(31 downto 0));
end ALU;

architecture Behavioral of ALU is

begin

	process(DataIn_crs1,DataIn_crs2,Data_ALUOP) ---Process sencible a las 4 entradas
		begin
			case (Data_ALUOP) is   --Caso para el dato que viene del ALUOP
				when "000000" => --Suma(add)
					DataOut_Result <= DataIn_crs1 + DataIn_crs2;
				when "000100" => --Resta(sub)
					DataOut_Result <= DataIn_crs1 - DataIn_crs2;
				when "000010" => --or lógico
					DataOut_Result <= DataIn_crs1 or DataIn_crs2;
				when "000001" => --and lógico
					DataOut_Result <= DataIn_crs1 and DataIn_crs2;
				when "000011" => --XOR lógico
					DataOut_Result <= DataIn_crs1 xor DataIn_crs2;
				when "000110" => --OR not
					DataOut_Result <= DataIn_crs1 or not DataIn_crs2;
				when "000101" => --AND not
					DataOut_Result <= DataIn_crs1 and not DataIn_crs2;
				when "000111" => --XOR not
					DataOut_Result <= DataIn_crs1 xnor not DataIn_crs2;
				when others => -- Nop para el resto de casos
					DataOut_Result <= (others=>'0');
			end case;
	end process;


end Behavioral;

