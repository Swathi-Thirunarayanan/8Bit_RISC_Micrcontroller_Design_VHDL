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

entity s2_4x1_mux is
--  Port ( );
port( 
      rstm2 : in std_logic;
      muxins21,muxins22,muxins23,muxins24: in std_logic_vector(1 downto 0);
      control_lines2: in std_logic_vector(1 downto 0);
      muxouts2: out std_logic_vector(1 downto 0));
end s2_4x1_mux;

architecture Behavioral of s2_4x1_mux is
begin
process(rstm2, control_lines2,muxins21,muxins22,muxins23,muxins24)
begin
if(rstm2 = '1') then
muxouts2 <= "00";
elsif(control_lines2 = "00") then
muxouts2 <= muxins21;
elsif (control_lines2 ="01") then
muxouts2 <= muxins22;
elsif (control_lines2 = "10") then
muxouts2 <= muxins23;
else
muxouts2 <= muxins24;
end if;
end process;             
end Behavioral;
