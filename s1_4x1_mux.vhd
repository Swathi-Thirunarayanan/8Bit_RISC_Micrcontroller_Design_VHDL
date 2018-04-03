----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/22/2018 10:29:18 PM
-- Design Name: 
-- Module Name: std_logic_vector_4x1_mux - Behavioral
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

entity s1_4x1_mux is
--  Port ( );
port( 
      rstm1 : in std_logic;
      muxins11,muxins12,muxins13,muxins14: in std_logic;
      control_lines1: in std_logic_vector(1 downto 0);
      muxouts1: out std_logic);
end s1_4x1_mux;

architecture Behavioral of s1_4x1_mux is
begin
process(rstm1,control_lines1,muxins11,muxins12,muxins13,muxins14)
begin
if(rstm1 = '1') then
muxouts1 <= '0';
elsif(control_lines1 = "00") then
muxouts1 <= muxins11;
elsif (control_lines1 ="01") then
muxouts1 <= muxins12;
elsif (control_lines1 = "10") then
muxouts1 <= muxins13;
else
muxouts1 <= muxins14;
end if;
end process;             
end Behavioral;
