LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY TB_SEU IS
END TB_SEU;
 
ARCHITECTURE behavior OF TB_SEU IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SEU
    PORT(
         DataIn_Imm13 : IN  std_logic_vector(12 downto 0);
         DataOut_Imm32 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal DataIn_Imm13 : std_logic_vector(12 downto 0) := (others => '0');

 	--Outputs
   signal DataOut_Imm32 : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
  
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SEU PORT MAP (
          DataIn_Imm13 => DataIn_Imm13,
          DataOut_Imm32 => DataOut_Imm32
        );
 

   -- Estimulos al process
   stim_proc: process
   begin		
		DataIn_Imm13 <= "0111111111111";
      wait for 20 ns;
				DataIn_Imm13 <= "1000000000000";
		wait;  
	end process;

END;
