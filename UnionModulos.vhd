library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity UnionModulos is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           DataOut : out  STD_LOGIC_VECTOR (31 downto 0));
end UnionModulos;

architecture Behavioral of UnionModulos is

	COMPONENT PC
	PORT(
		clk : IN std_logic;
		DataIn : IN std_logic_vector(31 downto 0);
		rst : IN std_logic;          
		DataOut : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT Sumador_32Bits
	PORT(
		DataIn : IN std_logic_vector(31 downto 0);
		DataIn_nPC : IN std_logic_vector(31 downto 0);          
		DataOut : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT IM
	PORT(
		DataIn : IN std_logic_vector(31 downto 0);
		rst : IN std_logic;          
		DataOut : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT RF
	PORT(
		DataIn_rs1 : IN std_logic_vector(5 downto 0);
		DataIn_rs2 : IN std_logic_vector(5 downto 0);
		DataIn_rd : IN std_logic_vector(5 downto 0);
		DataWrite : IN std_logic_vector(31 downto 0);
		rst : IN std_logic;          
		DataOut_crs1 : OUT std_logic_vector(31 downto 0);
		DataOut_crs2 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT CU
	PORT(
		op : IN std_logic_vector(1 downto 0);
		op3 : IN std_logic_vector(5 downto 0);          
		ALUOP : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;

	COMPONENT ALU
	PORT(
		DataIn_crs1 : IN std_logic_vector(31 downto 0);
		DataIn_crs2 : IN std_logic_vector(31 downto 0);
		Data_ALUOP : IN std_logic_vector(5 downto 0);
		DataIn_Carry : IN std_logic;          
		DataOut_Result : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	
	COMPONENT MUX
	PORT(
		DataIn_crs2 : IN std_logic_vector(31 downto 0);
		DataIn_SEU : IN std_logic_vector(31 downto 0);
		DataIn_Imm : IN std_logic;          
		DataOut_ALU : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	
	COMPONENT SEU
	PORT(
		DataIn_Imm13 : IN std_logic_vector(12 downto 0);          
		DataOut_Imm32 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT PSR
	PORT(
		DataIn_NZVC : IN std_logic_vector(3 downto 0);
		rst : IN std_logic;
		clk : IN std_logic;
		DataIn_newcwp : IN std_logic;          
		DataOut_Carry : OUT std_logic;
		DataOut_cwp : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT PSR_Modifier
	PORT(
		DataIn_MUX : IN std_logic_vector(31 downto 0);
		DataIn_ALUResult : IN std_logic_vector(31 downto 0);
		DataIn_crs1 : IN std_logic_vector(31 downto 0);
		DataIn_ALUOP : IN std_logic_vector(5 downto 0);
		rst : IN std_logic;          
		DataOut_nzvc : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
	
	COMPONENT WindowsManager
	PORT(
		DataIn_rs1 : IN std_logic_vector(4 downto 0);
		DataIn_rs2 : IN std_logic_vector(4 downto 0);
		DataIn_rd : IN std_logic_vector(4 downto 0);
		DataIn_op : IN std_logic_vector(1 downto 0);
		DataIn_op3 : IN std_logic_vector(5 downto 0);
		DataIn_cwp : IN std_logic;          
		DataOut_newcwp : OUT std_logic;
		DataOut_newrs1 : OUT std_logic_vector(5 downto 0);
		DataOut_newrs2 : OUT std_logic_vector(5 downto 0);
		DataOut_newrd : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;

	signal aux1, aux2, aux3, aux4, aux5, aux6, aux7, aux8, aux9: std_logic_vector(31 downto 0);
	signal auxCU: std_logic_vector(5 downto 0); --señal que sale de la CU (ALUOP) y entra a la ALU
	signal auxNZVC: std_logic_vector(3 downto 0); --señal nvzc que sale del PSR_Modifier
	signal auxCarry: std_logic; --señal de salida del PSR
	signal auxCWP: std_logic; --señal que sale del PSR y llega al windows manager
	signal auxNewCPW: std_logic; --Señal que sale del windows manager y llega al PSR
	signal auxrs1, auxrs2, auxrd: std_logic_vector(5 downto 0); --señales de 6 bits que salen del windows manager

begin

	Inst_nPC: PC PORT MAP(
			clk => clk,
			DataIn => aux2, ---aux2 es la salida del sumador y se convierte en la entrada del nPC
			rst => rst ,
			DataOut => aux1 --La salida del nPC(aux1) es la entrada al PC
		);

	Inst_PC: PC PORT MAP(
			clk => clk,
			DataIn => aux1 ,
			rst => rst ,
			DataOut => aux3 --salida del PC que se convierte en la entrada del IM
		);
		
	Inst_Sumador_32Bits: Sumador_32Bits PORT MAP(
			DataIn => "00000000000000000000000000000001", --hexadecimal y da el salto de 4 
			DataIn_nPC => aux1, --Une el nPC y el sumador
			DataOut => aux2 
		);
		
	Inst_IM: IM PORT MAP(
		DataIn => aux3, --entrada que se recibe del PC
		rst => rst,
		DataOut => aux4 --salida del IM
	);

	Inst_RF: RF PORT MAP(  
		DataIn_rs1 => auxrs1,
		DataIn_rs2 => auxrs2,
		DataIn_rd => auxrd,
		DataWrite => aux9, --señal qu ellega de la ALU con el resultado
		rst => rst,
		DataOut_crs1 => aux6, --salida del RF que es la entrada 1 en la ALU
		DataOut_crs2 => aux7 ---Salida del RF que es la entrada al MUX
	);

	Inst_CU: CU PORT MAP(
		op =>aux4(31 downto 30) ,
		op3 => aux4(24 downto 19),
		ALUOP => auxCU  ---Salida de 6 bits de la CU
	);

	Inst_ALU: ALU PORT MAP(
		DataIn_crs1 => aux6, --señal que llega del RF
		DataIn_crs2 =>  aux8, --señal que llega dela salida del MUX
		Data_ALUOP => auxCU, ---Llega de la CU
		DataOut_Result => aux9, --Señal de salida de la ALU(resultado)
		DataIn_Carry => auxCarry ---señal de salida del PSR
	);

	Inst_MUX: MUX PORT MAP(
		DataIn_crs2 => aux7, --salida del RF(crs2)
		DataIn_SEU => aux5, --señal que llega de la SEU
		DataIn_Imm => aux4(13), --salida del IM que da el bit 13 
		DataOut_ALU => aux8 ---salida del MUX que es la entrada 2 de la ALU
	);


	Inst_SEU: SEU PORT MAP(
		DataIn_Imm13 => aux4(12 downto 0),
		DataOut_Imm32 => aux5 --salida de la SEU que va al MUX
	);
	
	Inst_PSR: PSR PORT MAP(
		DataIn_NZVC => auxNZVC, --señal que llega del PSR_Modifier
		rst => rst,
		clk => clk,
		DataOut_Carry => auxCarry, --señal de salida del PSR
		DataIn_newcwp => auxNewCPW, 
		DataOut_cwp => auxCWP
	);
	

	Inst_PSR_Modifier: PSR_Modifier PORT MAP(
		DataIn_MUX => aux8, ---salida del MUX que es la entrada 2 de la ALU
		DataIn_ALUResult => aux9, --Señal de salida de la ALU(resultado)
		DataIn_crs1 => aux6, --Salida 1 del RF que llega a la ALU
		DataIn_ALUOP => auxCU, --señal que sale de la CU (ALUOP) y entra a la ALU
		DataOut_nzvc => auxNZVC, --señal que sale del PSR_Modifier(4 bits)
		rst => rst
	);
	
	Inst_WindowsManager: WindowsManager PORT MAP(
		DataIn_rs1 => aux4(18 downto 14), --Se toman 5 bits del aux4(del 14 al 18) y se le asignan al rs1
		DataIn_rs2 => aux4(4 downto 0), --Se toman 5 bits del aux4(del 0 al 4) y se le asignan al rs2
		DataIn_rd => aux4(29 downto 25), --Se toman 5 bits del aux4(del 25 al 29) y se le asignan al rd
		DataIn_op => aux4(31 downto 30) ,
		DataIn_op3 => aux4(24 downto 19),
		DataIn_cwp => auxCWP, --señal que llega del PSR
		DataOut_newcwp => auxNewCPW , --señal que sale para el PSR
		DataOut_newrs1 => auxrs1,
		DataOut_newrs2 => auxrs2,
		DataOut_newrd => auxrd
	);
	
	DataOut <= aux9;
	

end Behavioral;

