--------------------------------------------------------------------------
-- Flip-flop D
--
-- Descripción: Flip-flop D, diparado con flanco ascendente, con entrada
-- 				de habilitación y set y reset asincrónicos
--
-- Autor: Nicolás Alvarez
-- Fecha: 28/05/14
--------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity ffdNoQ is
	port(
		clk, rst, set, ena: in std_logic;
		D: in std_logic;
		Q: out std_logic;
		notQ: out std_logic
	);
end;

architecture ffd_arq of ffdNoQ is
begin
	process(clk, rst, set)
	begin
		if rst = '1' then
			Q <= '0';
			notQ <= '1';
		elsif set = '1' then
			Q <= '1';
			notQ <= '0';
		elsif rising_edge(clk) then                 
			if ena = '1' then
				Q <= D;
				notQ <= not(D);
			end if;
		end if;
	end process;
end;