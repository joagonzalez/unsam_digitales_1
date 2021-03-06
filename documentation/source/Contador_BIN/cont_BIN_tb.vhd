library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity cont_BIN_tb is 

end;

architecture cont_BIN_tb_arq of cont_BIN_tb is
	signal clk : std_logic := '0';
	signal rst : std_logic := '1';
	--signal ena : std_logic := '1';
	signal Q, out1, out2 : std_logic_vector (15 downto 0);
	--signal out1: out std_logic;
	--signal out2: out std_logic;
	
begin 
 	clk <= not clk after 10 ns;
	--ena <= '1' after 50 ns;
	inst : entity work.cont_BIN 
			port map(
			clk => clk,
			--rst => rst,
			Q => Q,
			out1 => out1,
			out2 => out2
		);
	rst <= '0' after 85 ns;
end;
