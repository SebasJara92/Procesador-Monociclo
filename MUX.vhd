library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX is
    Port ( DataIn_crs2 : in  STD_LOGIC_VECTOR (31 downto 0);
           DataIn_SEU : in  STD_LOGIC_VECTOR (31 downto 0);
           DataIn_Imm : in  STD_LOGIC;
           DataOut_ALU : out  STD_LOGIC_VECTOR (31 downto 0));
end MUX;

architecture Behavioral of MUX is --Multiplexor: establece de acuerdo a las entradas que recibe
                                                --una salida que sera la que tome la ALU para definir que operacion hacer

begin

	process(DataIn_crs2,DataIn_SEU,DataIn_Imm) --process sencible a la salida 2 del RF, a la salida del SEU y al inmendiato
		begin
			if(DataIn_Imm = '1')then   ---Si el inmediato es '1' entonces:
				DataOut_ALU <= DataIn_SEU;
			else
				if(DataIn_Imm = '0')then
					DataOut_ALU <= DataIn_crs2;
				end if;
			end if;
	end process;


end Behavioral;

