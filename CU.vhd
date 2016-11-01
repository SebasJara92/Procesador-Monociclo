library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity CU is
    Port ( op : in  STD_LOGIC_VECTOR (1 downto 0);
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
           ALUOP : out  STD_LOGIC_VECTOR (5 downto 0));
end CU;

architecture Behavioral of CU is

begin
	process(op,op3) --Process sencible al op y op3
		begin 
			if(op = "10") then  --Si op es 10:
				case(op3) is  --Un case para cada operacion con el op3
						when "000000" =>			--La CU toma la suma(Add)
								ALUOP <= op3;
						when "010000" =>			--La CU toma la suma(Addcc)
								ALUOP <= op3;
						when "001000" =>			--La CU toma la suma(Addx)
								ALUOP <= op3;
						when "011000" =>			--La CU toma la suma(Addxcc)
								ALUOP <= op3;
						when "000100" =>        --La CU toma la resta(sub)
								ALUOP <= op3;
						when "010100" =>        --La CU toma la resta(subcc)
								ALUOP <= op3;
						when "001100" =>        --La CU toma la resta(subx)
								ALUOP <= op3;
						when "011100" =>        --La CU toma la resta(subxcc)
								ALUOP <= op3;
						when "000010" => 			--La CU toma el Or lógico
								ALUOP <= op3;
						when "010010" => 			--La CU toma el Orcc lógico
								ALUOP <= op3;
						when "000110" => 			--La CU toma el Orn lógico
								ALUOP <= op3;
						when "010110" => 			--La CU toma el Orncc lógico
								ALUOP <= op3;
						when "000001" => 			--La CU toma el And lógico
								ALUOP <= op3;
						when "010001" => 			--La CU toma el Andcc lógico
								ALUOP <= op3;
						when "000101" => 			--La CU toma el Andn lógico
								ALUOP <= op3;
						when "010101" => 			--La CU toma el Andncc lógico
								ALUOP <= op3;
						when "000011" => 			--La CU toma el Xor
								ALUOP <= op3;
						when "000111" => 			--Toma el Xnor
								ALUOP <= op3;
						when "010011" => 			--Toma el Xorcc
								ALUOP <= op3;
						when "010111" => 			--Toma el Xnorcc
								ALUOP <= op3;
						when "100101" => 			--sll
								ALUOP <= op3;
						when "100110" => 			--srl
								ALUOP <= op3;
						when 	"111100" =>       --save
								ALUOP <= op3;
						when 	"111101" =>       --restore
								ALUOP <= op3;
						when others => 
								ALUOP <= (others => '0');  --Para otros casos
			  end case;
		  end if;			
	end process;



end Behavioral;

