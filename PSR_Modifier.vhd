library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity PSR_Modifier is ---Registro que se encarga de modificar el PSR
    Port ( DataIn_MUX : in  STD_LOGIC_VECTOR (31 downto 0);
           DataIn_ALUResult : in  STD_LOGIC_VECTOR (31 downto 0) ;
           DataIn_crs1 : in  STD_LOGIC_VECTOR (31 downto 0);
           DataIn_ALUOP : in  STD_LOGIC_VECTOR (5 downto 0);   --Con estas entradas puede determinar que valores
																					--del nzvc debe moficar                                                             
           DataOut_nzvc : out  STD_LOGIC_VECTOR (3 downto 0); --n(negative), z(zero), v(overflow), c(carry)
			  rst : in STD_LOGIC
			  );
end PSR_Modifier;

architecture Behavioral of PSR_Modifier is
begin

process(DataIn_ALUResult,DataIn_MUX ,DataIn_crs1,DataIn_ALUOP) ---Process sencible a las 4 entradas:
begin
	if (rst = '1') then  --Si rst está en 1 limpia todo
			DataOut_nzvc <= (others=>'0');
		else
		--Instrucciones que modifican en icc(integer conditional code)
			
			--Instrucciones lógicas:
			if (DataIn_ALUOP="010001" OR DataIn_ALUOP="010101" OR DataIn_ALUOP="010010" OR DataIn_ALUOP="010110" OR DataIn_ALUOP="010011" OR DataIn_ALUOP="010111") then -- ANDcc or ANDNcc or ORcc or ORNcc or XORcc or XNORcc
				DataOut_nzvc(3) <= DataIn_ALUResult(31);--el signo que traiga
				if (conv_integer(DataIn_ALUResult)=0) then
					DataOut_nzvc(2) <= '1';--Si el DataIn_ALUResult=0 pone a z en 1
				else
					DataOut_nzvc(2) <= '0';
				end if;
				DataOut_nzvc(1) <= '0';--los operadores logicos no generan overflow ni carry
				DataOut_nzvc(0) <= '0';
			end if;
			
				
         --Instrucciones aritmeticas:				
			if (DataIn_ALUOP="010000" or DataIn_ALUOP="011000") then  -- ADDcc or ADDxcc
				DataOut_nzvc(3) <= DataIn_ALUResult(31);
				if (conv_integer(DataIn_ALUResult)=0) then  --SI el resultado de la ALU=0:
					DataOut_nzvc(2) <= '1';   ---Pone z=1
				else
					DataOut_nzvc(2) <= '0';  --pone z=0
				end if;
				DataOut_nzvc(1) <= (DataIn_crs1(31) and DataIn_MUX(31) and (not DataIn_ALUResult(31))) or ((not DataIn_crs1(31)) and (not DataIn_MUX(31)) and DataIn_ALUResult(31)); --Asiga el bit (overFlow) al ultimo bit del DataIn-crs1 y el DataIn_MUX o solo al DataIN_ALUResult  
				DataOut_nzvc(0) <= (DataIn_crs1(31) and DataIn_MUX(31)) or ((not DataIn_ALUResult(31)) and (DataIn_crs1(31) or DataIn_MUX(31)) );
			end if;
			
			
			if (DataIn_ALUOP="001000" or DataIn_ALUOP="001010") then --SUBcc(si la resta da cero el PSR_Modifier pone z=1) or SUBxcc(este tiene en cuneta el bit de acarreo)
				DataOut_nzvc(3) <= DataIn_ALUResult(31);
				if (conv_integer(DataIn_ALUResult)=0) then
					DataOut_nzvc(2) <= '1';
				else
					DataOut_nzvc(2) <= '0';
				end if;
				DataOut_nzvc(1) <= (DataIn_crs1(31) and (not DataIn_MUX(31)) and (not DataIn_ALUResult(31))) or ((not DataIn_crs1(31)) and DataIn_MUX(31) and DataIn_ALUResult(31));
				DataOut_nzvc(0) <= ((not DataIn_crs1(31)) and DataIn_MUX(31)) or (DataIn_ALUResult(31) and ((not DataIn_crs1(31)) or DataIn_MUX(31)));
			end if;
		end if;
		
end process;

end Behavioral;