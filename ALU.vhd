library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL; ---libreria para operaciones aritméticas

entity ALU is  --ALU: calcula operaciones aritméticas (como suma, resta, multiplicación, etc.) y operaciones lógicas (sí, y, o, no), entre valores (generalmente uno o dos
    Port ( DataIn_crs1 : in  STD_LOGIC_VECTOR(31 downto 0);  ---rS1
           DataIn_crs2 : in  STD_LOGIC_VECTOR(31 downto 0); ----rS2
           Data_ALUOP: in  STD_LOGIC_VECTOR(5 downto 0);
           DataOut_Result : out  STD_LOGIC_VECTOR(31 downto 0);
			  DataIn_Carry : in STD_LOGIC
			  );
end ALU;

architecture Behavioral of ALU is

begin

	process(DataIn_crs1,DataIn_crs2,Data_ALUOP, DataIn_Carry) ---Process sencible a las 4 entradas
		begin
			case (Data_ALUOP) is   --Caso para el dato que viene del ALUOP
				when "000000" => --Suma(add)
					DataOut_Result <= DataIn_crs1 + DataIn_crs2;
				when 	"001000" => --ADDx
					DataOut_Result <= DataIn_crs1 + DataIn_crs2 + DataIn_Carry;
				when 	"011000" => --ADDxcc
					DataOut_Result <= DataIn_crs1 + DataIn_crs2 + DataIn_Carry;
				when 	"010000" => --ADDcc 
					DataOut_Result <= DataIn_crs1 + DataIn_crs2;
				when "000100" => --Resta(sub)
					DataOut_Result <= DataIn_crs1 - DataIn_crs2;
				when 	"010100" => --SUBcc
					DataOut_Result <= DataIn_crs1 - DataIn_crs2;
				when 	"001100" => -- SUBx
					DataOut_Result <= DataIn_crs1 - DataIn_crs2 - DataIn_Carry;
				when 	"011100" => --SUBxcc
					DataOut_Result <= DataIn_crs1 - DataIn_crs2 - DataIn_Carry;
				when "000010" => --OR lógico
					DataOut_Result <= DataIn_crs1 or DataIn_crs2;
				when "000110" => --ORN
					DataOut_Result <= DataIn_crs1 or not DataIn_crs2;
				when "010010" => --ORcc
					DataOut_Result <= DataIn_crs1 or  DataIn_crs2;
				when "010110" => --ORNcc
					DataOut_Result <= DataIn_crs1 or not DataIn_crs2;
				when "000001" => --AND lógico
					DataOut_Result <= DataIn_crs1 and DataIn_crs2;
				when 	"000101" => --ANDN
					DataOut_Result <= DataIn_crs1 and not DataIn_crs2;
				when 	"010001" => --ANDcc
					DataOut_Result <= DataIn_crs1 and DataIn_crs2;
				when 	"010101" => --ANDNcc
					DataOut_Result <= DataIn_crs1 and not DataIn_crs2;
				when "000011" => --XOR lógico
					DataOut_Result <= DataIn_crs1 xor DataIn_crs2;
				when "000111" => --XOR not
					DataOut_Result <= DataIn_crs1 xnor DataIn_crs2;
				when 	"010011" => --XORcc
					DataOut_Result <= DataIn_crs1 xor DataIn_crs2;
				when 	"010111" => --XNORcc
					DataOut_Result <= DataIn_crs1 xnor DataIn_crs2;
				when 	"100101" => --sll
					DataOut_Result <= to_stdlogicvector(to_bitvector(DataIn_crs1) sll conv_integer(DataIn_crs2));
				when 	"100110" => --srl
					DataOut_Result <= to_stdlogicvector(to_bitvector(DataIn_crs1) sll conv_integer(DataIn_crs2));
				when others => -- Nop para el resto de casos
					DataOut_Result <= (others=>'0');
			end case;
	end process;


end Behavioral;

