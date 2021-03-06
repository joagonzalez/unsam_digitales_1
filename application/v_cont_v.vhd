------------------------------------------------------------
-- Module: v_cont_v
-- Description: vertical counter
-- Authors: David Wolovelsky y Joaquin Gonzalez
-- ED1 - UNSAM
-- 2019
------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity v_cont_v is
	port(
		clk: in std_logic;		-- Clock del sistema
		ena: in std_logic;		-- Enable del sistema	
		rst: in std_logic;
		Q: out std_logic_vector(9 downto 0);
		v_rst: out std_logic
	);
end v_cont_v;

architecture v_cont_v_a of v_cont_v is
	
component v_ffd
	port(
		clk: in std_logic;
		rst: in std_logic;
		ena: in std_logic;
		D: in std_logic;
		Q: out std_logic
	);	
end component;

component v_cont_bin_base
	port(
		clk: in std_logic;
		rst: in std_logic;
		ena: in std_logic;
		D: in std_logic;
		Q: out std_logic;
		ACU: out std_logic
	);	
end component;

signal Di_vec, Qi_vec, ACU_vec: std_logic_vector(9 downto 0); -- Conexiones vectoriales para la implementacion del contador

signal rst_end: std_logic;	-- Conexion de reset al finalizar de contar 522

-- signal Q_end: std_logic_vector(3 downto 0);

signal rst_cont: std_logic;

begin
      
   ffd0: v_ffd
       port map(
          clk => clk,	    -- Clock del v_ffd
          rst => rst_cont,	-- Reset del v_ffd
          ena => ena,    	-- Enable del sistema
          D => Di_vec(0),	  
          Q => Qi_vec(0)
      );
      
   Di_vec(0) <= not Qi_vec(0);
   ACU_vec(0) <= Qi_vec(0);
   
   v_cont_bin_base_block: for i in 1 to 9 generate -- Generamos todos los bloques requeridos por el contador
	   v_cont_bin_base_i: v_cont_bin_base
	      port map(
	          clk => clk,
	          rst => rst_cont,
	          ena => ena,
	          D => Di_vec(i),
	          Q => Qi_vec(i),
	          ACU => ACU_vec(i)
	       );
        Di_vec(i) <= ACU_vec(i-1);
	end generate v_cont_bin_base_block;

--	522		=	 ‭‭1000001010‬‬ 
	rst_end <= Qi_vec(9) and (not Qi_vec(8)) and (not Qi_vec(7)) and (not Qi_vec(6)) and (not Qi_vec(5)) and (not Qi_vec(4)) and Qi_vec(3) and (not Qi_vec(2)) and Qi_vec(1) and (not Qi_vec(0));
	-- rst_end <= Qi_vec(9) and (not Qi_vec(8)) and (not Qi_vec(7)) and (not Qi_vec(6)) and (not Qi_vec(5)) and (not Qi_vec(4)) and Qi_vec(3) and (not Qi_vec(2)) and Qi_vec(1) and Qi_vec(0);
	rst_cont <= rst or rst_end;

    Q <= Qi_vec;
	-- v_rst <= Qi_vec(9) and (not Qi_vec(8)) and (not Qi_vec(7)) and (not Qi_vec(6)) and (not Qi_vec(5)) and (not Qi_vec(4)) and Qi_vec(3) and (not Qi_vec(2)) and Qi_vec(1) and (not Qi_vec(0));
	v_rst <= Qi_vec(9) and (not Qi_vec(8)) and (not Qi_vec(7)) and (not Qi_vec(6)) and (not Qi_vec(5)) and (not Qi_vec(4)) and Qi_vec(3) and (not Qi_vec(2)) and (not Qi_vec(1)) and Qi_vec(0);
	
end;