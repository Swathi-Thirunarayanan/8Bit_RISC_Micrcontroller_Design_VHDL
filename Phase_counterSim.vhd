----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/22/2018 08:53:18 PM
-- Design Name: 
-- Module Name: Phase_counterSim - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Phase_counterSim is
--  Port ( );
end Phase_counterSim;

architecture Behavioral of Phase_counterSim is
        signal Clk,rst : std_logic;
        signal stage   : std_logic_vector(1 downto 0);
begin
p0:entity work.phase_counter(Behavioral) port map (Clk=>Clk, rst =>rst , stage =>stage);

clock:process
  begin
    clk <= '0';
	wait for 100 ns;
	clk <= '1';
	wait for 100 ns;
 end process;
 
 stimulus : process
  begin
    rst <= '1';
	wait for 200 ns;
	rst <= '0';
	wait;
	end process;
end Behavioral;
