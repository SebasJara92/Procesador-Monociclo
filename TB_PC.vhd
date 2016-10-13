LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY TB_PC IS
END TB_PC;
 
ARCHITECTURE behavior OF TB_PC IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PC
    PORT(
         clk : IN  std_logic;
         DataIn : IN  std_logic_vector(31 downto 0);
         rst : IN  std_logic;
         DataOut : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal DataIn : std_logic_vector(31 downto 0) := (others => '0');
   signal rst : std_logic := '0';

 	--Outputs
   signal DataOut : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PC PORT MAP (
          clk => clk,
          DataIn => DataIn,
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
 

   ---Estimulación para hacer el process
   stim_proc: process
	begin		
		rst <= '1';	---Coloca el rest en 1 y asigna x"00000000"
		wait for 100 ns;
				 DataIn <= x"00000000";
		 
		rst <= '0'; ---COloca el reset en 0 e inica el process
			wait for 20 ns;
			DataIn <= x"00000001";
			wait for 20 ns;
			DataIn <= x"00000002";
			wait for 20 ns;
			DataIn <= x"00000003";
			
		wait;
	end process;

	END;
