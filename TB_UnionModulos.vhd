LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
  
ENTITY TB_UnionModulos IS
END TB_UnionModulos;
 
ARCHITECTURE behavior OF TB_UnionModulos IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT UnionModulos
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         DataOut : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal DataOut : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: UnionModulos PORT MAP (
          clk => clk,
          rst => rst,
          DataOut => DataOut
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      rst <= '1';
		wait for 100 ns;
			rst <= '0';
		wait; 

    
   end process;

END;
