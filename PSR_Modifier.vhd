library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PSR_Modifier is ---Registro que que contiene información sobre el estado de la procesador.
    Port ( DataIn_MUX : in  STD_LOGIC;
           DataIn_crs1 : in  STD_LOGIC;
           DataIn_ALUOP : in  STD_LOGIC_VECTOR (5 downto 0);
           DataIn_ALUResult : in  STD_LOGIC_VECTOR (31 downto 0);
           DataOut_nzvc : out  STD_LOGIC_VECTOR (3 downto 0)); --n(negative), z(zero), v(overflow), c(carry)
end PSR_Modifier;

architecture Behavioral of PSR_Modifier is

begin

process(DataIn_ALUResult,DataIn_MUX ,DataIn_crs1,DataIn_ALUOP)
begin
	if(DataIn_ALUOP = "010000" or DataIn_ALUOP = "011000")then--ADDCC(Add and modify icc) ADDXCC(Add with Carry and modify icc)
		DataOut_nzvc(3) <= DataIn_ALUResult(31);	
		if(DataIn_ALUResult = X"00000000")then
			DataOut_nzvc(2) <= '1';
		else
			DataOut_nzvc(2) <= '0';
		end if;
		DataOut_nzvc(1) <= (DataIn_MUX and DataIn_crs1 and (not DataIn_ALUResult(31))) or ((DataIn_MUX) and (not DataIn_crs1) and  DataIn_ALUResult(31));
		DataOut_nzvc(0) <= (DataIn_MUX and DataIn_crs1) or ((not DataIn_ALUResult(31)) and (DataIn_MUX or DataIn_crs1));
	else
		if(DataIn_ALUOP = "010100")then--SUBCC(Subtract and modify icc)
			DataOut_nzvc(3) <= DataIn_ALUResult(31);
			if(DataIn_ALUResult = X"00000000")then
				DataOut_nzvc(2) <= '1';
			else
				DataOut_nzvc(2) <= '0';
			end if;
			DataOut_nzvc(1) <= ((DataIn_MUX and (not DataIn_crs1) and (not DataIn_ALUResult(31))) or ((not DataIn_MUX) and DataIn_crs1 and DataIn_ALUResult(31)));
			DataOut_nzvc(0) <= ((not DataIn_MUX) and DataIn_crs1) or (DataIn_ALUResult(31) and ((not DataIn_MUX) or DataIn_crs1));
		else
			if(DataIn_ALUOP = "000101"  or DataIn_ALUOP = "000111" or DataIn_ALUOP = "001001" or DataIn_ALUOP = "001011" or DataIn_ALUOP = "001101" or DataIn_ALUOP = "001111")then
				DataOut_nzvc(3) <= DataIn_ALUResult(31);
				if(DataIn_ALUResult = X"00000000")then
					DataOut_nzvc(2) <= '1';
				else
					DataOut_nzvc(2) <= '0';
				end if;
				DataOut_nzvc(1) <= '0';
				DataOut_nzvc(0) <= '0';
			--else
				--DataOut_nzvc <= "1000";
			end if;
		end if;
	end if;
end process;


end Behavioral;

