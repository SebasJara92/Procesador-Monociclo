LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY TB_IM IS
END TB_IM;
 
ARCHITECTURE behavior OF TB_IM IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT IM
    PORT(
         DataIn : IN  std_logic_vector(31 downto 0);
         rst : IN  std_logic;
         DataOut : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal DataIn : std_logic_vector(31 downto 0) := (others => '0');
   signal rst : std_logic := '0';

 	--Outputs
   signal DataOut : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: IM PORT MAP (
          DataIn => DataIn,
          rst => rst,
          DataOut => DataOut
        );

   -- Clock process definitions
   

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
			rst<='1';
			DataIn <= "00000000000000000000000000000000";
      wait for 100 ns;	
			rst<='0';
			DataIn <= "11100000000000000000000000000000";
      wait;
	end process;

END;
