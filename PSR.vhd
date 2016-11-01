library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PSR is --(Process state register)Registo de 32 bits en el cual se pueden modificar algunos 
              --bits de ellos(especificamnte los nzvc) y que indican si hubo algun cambio en un proceso
    Port ( DataIn_NZVC : in  STD_LOGIC_VECTOR (3 downto 0);
           rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           DataOut_Carry : out  STD_LOGIC;
			  DataIn_newcwp : in STD_LOGIC;
			  DataOut_cwp : out STD_LOGIC
			  );
end PSR;

architecture Behavioral of PSR is

begin
	process(rst,clk,DataIn_NZVC, DataIn_newcwp ) --process sensible a los 4 bist de entrada(nzvc), al reloj y el reset y al new cwp
	begin
		if rst='1' then    ---Si reset está en 1 limpia todo y el accareo es 0
			DataOut_Carry <= '0';
		else
			if rising_edge(clk) then  --para cada flanco de subida:
				DataOut_Carry<=DataIn_NZVC(0);   --Le asigna al dato de salida el bit en la posición cero(c)
				DataOut_cwp <= DataIn_newcwp;  --el cwp es igual al nuevo cwp
			end if;
		end if;
	end process;


end Behavioral;

