library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.STD_LOGIC_ARITH.ALL;


entity WindowsManager is  --Windowing: permite visualizar los registros que estan en la ventana
                          --Se encarga de gestionar todas la ventanas(de acuerdo al rs1 y a lo que leer del cwp genera un nuevo rs1)
	 Port ( DataIn_rs1 : in  STD_LOGIC_VECTOR (4 downto 0);
           DataIn_rs2 : in  STD_LOGIC_VECTOR (4 downto 0);
           DataIn_rd : in  STD_LOGIC_VECTOR (4 downto 0);
           DataIn_op : in  STD_LOGIC_VECTOR (1 downto 0);
           DataIn_op3 : in  STD_LOGIC_VECTOR (5 downto 0);
           DataIn_cwp : in  STD_LOGIC; --Current window pointer(indica la ventana actual de trabajo)
           DataOut_newcwp : out  STD_LOGIC;
           DataOut_newrs1 : out  STD_LOGIC_VECTOR (5 downto 0); --Son 6 bits para direccionar los 40 registros
           DataOut_newrs2 : out  STD_LOGIC_VECTOR (5 downto 0);
           DataOut_newrd : out  STD_LOGIC_VECTOR (5 downto 0)
			  );
end WindowsManager;

architecture Behavioral of WindowsManager is

begin

process(DataIn_rs1,DataIn_rs2,DataIn_rd, DataIn_cwp)
	begin
		
		--Para registros locales y de salida
		if (DataIn_rs1 >= "10000" and DataIn_rs1<="10111") then
			DataOut_newrs1<=conv_std_logic_vector(conv_integer(DataIn_rs1)+(conv_integer(DataIn_cwp)*16),6);
		end if;
		if (DataIn_rs2>="10000" and DataIn_rs2<="10111") then
			DataOut_newrs2<=conv_std_logic_vector(conv_integer(DataIn_rs2)+(conv_integer(DataIn_cwp)*16),6);
		end if;
		if (DataIn_rd>="10000" and DataIn_rd<="10111") then
			DataOut_newrd<=conv_std_logic_vector(conv_integer(DataIn_rd)+(conv_integer(DataIn_cwp)*16),6);
		end if;
		
		--Para registros de entrada
		if (DataIn_rs1>="11000" and DataIn_rs1<="11111") then
			DataOut_newrs1<=conv_std_logic_vector(conv_integer(DataIn_rs1)-(conv_integer(DataIn_cwp)*16),6);
		end if;
		if (DataIn_rs2>="11000" and DataIn_rs2<="11111") then
			DataOut_newrs2<=conv_std_logic_vector(conv_integer(DataIn_rs2)-(conv_integer(DataIn_cwp)*16),6);
		end if;
		if (DataIn_rd>="11000" and DataIn_rd<="11111") then
			DataOut_newrd<=conv_std_logic_vector(conv_integer(DataIn_rd)-(conv_integer(DataIn_cwp)*16),6);
		end if;
		
		--Para registros globales
		if (DataIn_rs1>="00000" and DataIn_rs1<="00111") then
			DataOut_newrs1<='0'&DataIn_rs1;
		end if;
		if (DataIn_rs2>="00000" and DataIn_rs2<="00111") then
			DataOut_newrs2<='0'&DataIn_rs2;
		end if;
		if (DataIn_rd>="00000" and DataIn_rd<="00111") then
			DataOut_newrd<='0'&DataIn_rd;
		end if;
end process;

--save: cwp<=cwp-1 } cwp<='0'
--restore: cwp<=cwp+1 } cwp<='1'
process(DataIn_op,DataIn_op3,DataIn_cwp)
	begin
		--formato3
		if (DataIn_op="10") then
			--save
			if (DataIn_op3="111100")then
				DataOut_newcwp<='0';
			end if;
			--restore
			if (DataIn_op3="111101")then
				DataOut_newcwp<='1';
			end if;
		end if;
end process;

end Behavioral;

