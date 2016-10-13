LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY TB_Sumador_32Bits IS
END TB_Sumador_32Bits;
 
ARCHITECTURE behavior OF TB_Sumador_32Bits IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Sumador_32Bits
    PORT(
         DataIn : IN  std_logic_vector(31 downto 0);
         DataIn_nPC : IN  std_logic_vector(31 downto 0);
         DataOut : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal DataIn : std_logic_vector(31 downto 0) := (others => '0');
   signal DataIn_nPC : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal DataOut : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Sumador_32Bits PORT MAP (
          DataIn => DataIn,
          DataIn_nPC => DataIn_nPC,
          DataOut => DataOut
        ); 
   --Estimulacion al process
  stim_proc: process
	begin
		wait for 20 ns;
			DataIn <= "00000010010100001001000000000001";
			DataIn_nPC <= "00000001100110000000000000000001";
		wait;  
  end process;
 
 
END;
