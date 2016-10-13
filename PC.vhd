library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PC is
    Port ( clk : in  STD_LOGIC;     ----Reloj de la FPGA
           DataIn : in  STD_LOGIC_VECTOR (31 downto 0);   ---Direccion de entrada
           rst : in  STD_LOGIC;  ---reset
           DataOut : out  STD_LOGIC_VECTOR (31 downto 0));  ---Direccion de salida
end PC;

architecture Behavioral of PC is


begin

	process(clk,DataIn,rst)  ---Process sencible al reloj de la FPGA
		begin

		if(rising_edge(clk))then --Si hay un flanco de subida entonces:
			if(rst = '1')then --Y si el reset(rst) está en 1 entonces:
				  DataOut <= (others=> '0');  ---Saca el dato de salida en 0
			else
				  DataOut <= DataIn;  --Dato de entrada igual al de salida
			end if;
	  end if;
	  
	end process;

end Behavioral;

