LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY TB_ALU IS
END TB_ALU;
 
ARCHITECTURE behavior OF TB_ALU IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         DataIn_1 : IN  std_logic_vector(31 downto 0);
         DataIn_2 : IN  std_logic_vector(31 downto 0);
         Data_ALUOP : IN  std_logic_vector(5 downto 0);
         Data_Acarreo : IN  std_logic;
         DataOut : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal DataIn_1 : std_logic_vector(31 downto 0) := (others => '0');
   signal DataIn_2 : std_logic_vector(31 downto 0) := (others => '0');
   signal Data_ALUOP : std_logic_vector(5 downto 0) := (others => '0');
   signal Data_Acarreo : std_logic := '0';

 	--Outputs
   signal DataOut : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          DataIn_1 => DataIn_1,
          DataIn_2 => DataIn_2,
          Data_ALUOP => Data_ALUOP,
          Data_Acarreo => Data_Acarreo,
          DataOut => DataOut
        );

  
 

   -- Stimulus process
   stim_proc: process
   begin		
     wait for 100 ns;	

     
   end process;

END;
