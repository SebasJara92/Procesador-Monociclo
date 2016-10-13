LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY TB_CU IS
END TB_CU;
 
ARCHITECTURE behavior OF TB_CU IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CU
    PORT(
         op : IN  std_logic_vector(1 downto 0);
         op2 : IN  std_logic_vector(2 downto 0);
         op3 : IN  std_logic_vector(5 downto 0);
         cond : IN  std_logic_vector(3 downto 0);
         icc : IN  std_logic_vector(3 downto 0);
         HabilitadorMemoria : OUT  std_logic;
         DestRF : OUT  std_logic;
         FuenteRF : OUT  std_logic_vector(1 downto 0);
         FuentePC : OUT  std_logic_vector(1 downto 0);
         WriteEnMemoria : OUT  std_logic;
         WriteEnRF : OUT  std_logic;
         ALUOP : OUT  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal op : std_logic_vector(1 downto 0) := (others => '0');
   signal op2 : std_logic_vector(2 downto 0) := (others => '0');
   signal op3 : std_logic_vector(5 downto 0) := (others => '0');
   signal cond : std_logic_vector(3 downto 0) := (others => '0');
   signal icc : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal HabilitadorMemoria : std_logic;
   signal DestRF : std_logic;
   signal FuenteRF : std_logic_vector(1 downto 0);
   signal FuentePC : std_logic_vector(1 downto 0);
   signal WriteEnMemoria : std_logic;
   signal WriteEnRF : std_logic;
   signal ALUOP : std_logic_vector(5 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CU PORT MAP (
          op => op,
          op2 => op2,
          op3 => op3,
          cond => cond,
          icc => icc,
          HabilitadorMemoria => HabilitadorMemoria,
          DestRF => DestRF,
          FuenteRF => FuenteRF,
          FuentePC => FuentePC,
          WriteEnMemoria => WriteEnMemoria,
          WriteEnRF => WriteEnRF,
          ALUOP => ALUOP
        );

   

   -- Stimulus process
   stim_proc: process
   begin		
			op <= "10";
				op2 <= "000";
				op3 <= "000000" ;
				cond <= "0000";
				icc <= "0000";		
			wait for 100 ns;
				op <= "10";
				op2 <= "000";
				op3 <= "010000" ;
				cond <= "0000";
				icc <= "0000";		
			wait for 100 ns;
				op <= "00";
				op2 <= "010";
				op3 <= "000000" ;
				cond <= "1000";
				icc <= "0000";		
			wait;
	end process;

END;
