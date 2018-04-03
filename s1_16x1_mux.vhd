----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/25/2018 11:23:53 AM
-- Design Name: 
-- Module Name: s1_16x1_mux - Behavioral
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

entity s1_16x1_mux is
--  Port ( );
port( 
      rstm3 : in std_logic;
      mux16ins11,mux16ins12,mux16ins13,mux16ins14,mux16ins15,mux16ins16,mux16ins17,mux16ins18,mux16ins19,mux16ins110,mux16ins111,mux16ins112,mux16ins113,mux16ins114,mux16ins115,mux16ins116: in std_logic;
      control_line16s1: in std_logic_vector(3 downto 0);
      mux16outs1: out std_logic);
end s1_16x1_mux;

architecture Behavioral of s1_16x1_mux is
begin
process(rstm3, control_line16s1,mux16ins11,mux16ins12,mux16ins13,mux16ins14,mux16ins15,mux16ins16,mux16ins17,mux16ins18,mux16ins19,mux16ins110,mux16ins111,mux16ins112,mux16ins113,mux16ins114,mux16ins115,mux16ins116)
begin
if(rstm3 = '1') then
mux16outs1 <= '0';
elsif(control_line16s1 = "0000") then
mux16outs1 <= mux16ins11;
elsif (control_line16s1 ="0001") then
mux16outs1 <= mux16ins12;
elsif (control_line16s1 = "0010") then
mux16outs1 <= mux16ins13;
elsif (control_line16s1 = "0011") then
mux16outs1 <= mux16ins14;
elsif (control_line16s1 = "0100") then
mux16outs1 <= mux16ins15;
elsif (control_line16s1 = "0101") then
mux16outs1 <= mux16ins16;
elsif (control_line16s1 = "0110") then
mux16outs1 <= mux16ins17;
elsif (control_line16s1 = "0111") then
mux16outs1 <= mux16ins18;
elsif (control_line16s1 = "1000") then
mux16outs1 <= mux16ins19;
elsif (control_line16s1 = "1001") then
mux16outs1 <= mux16ins110;
elsif (control_line16s1 = "1010") then
mux16outs1 <= mux16ins111;
elsif (control_line16s1 = "1011") then
mux16outs1 <= mux16ins112;
elsif (control_line16s1 = "1100") then
mux16outs1 <= mux16ins113;
elsif (control_line16s1 = "1101") then
mux16outs1 <= mux16ins114;
elsif (control_line16s1 = "1110") then
mux16outs1 <= mux16ins115;
else
mux16outs1 <= mux16ins116;
end if;
end process; 
end Behavioral;