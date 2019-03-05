--------------------------------------------------------------------------
-- Flip-flop D
--
-- Descripci�n: Flip-flop D, diparado con flanco ascendente, con entrada
-- 				de habilitaci�n y set y reset asincr�nicos
--
-- Autor: Nicol�s Alvarez
-- Fecha: 28/05/14
--------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity ffd is
	port(
		clk, rst, set, ena: in std_logic;
		D: in std_logic;
		Q: out std_logic
	);
end;

architecture ffd_arq of ffd is
begin
	process(clk, rst, set)
	begin
		if rst = '1' then
			Q <= '0';
		elsif set = '1' then
			Q <= '1';
		elsif rising_edge(clk) then                 
			if ena = '1' then
				Q <= D;
			end if;
		end if;
	end process;
end;