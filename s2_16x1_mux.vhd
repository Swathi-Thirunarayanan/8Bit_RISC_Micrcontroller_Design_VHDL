----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/25/2018 10:21:07 AM
-- Design Name: 
-- Module Name: s2_16x1_mux - Behavioral
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

entity s2_16x1_mux is
--  Port ( );
port( 
      rstm4 : in std_logic;
      mux16ins21,mux16ins22,mux16ins23,mux16ins24,mux16ins25,mux16ins26,mux16ins27,mux16ins28,mux16ins29,mux16ins210,mux16ins211,mux16ins212,mux16ins213,mux16ins214,mux16ins215,mux16ins216: in std_logic_vector(1 downto 0);
      control_line16s2: in std_logic_vector(3 downto 0);
      mux16outs2: out std_logic_vector(1 downto 0));
end s2_16x1_mux;

architecture Behavioral of s2_16x1_mux is
begin
process(rstm4, control_line16s2,mux16ins21,mux16ins22,mux16ins23,mux16ins24,mux16ins25,mux16ins26,mux16ins27,mux16ins28,mux16ins29,mux16ins210,mux16ins211,mux16ins212,mux16ins213,mux16ins214,mux16ins215,mux16ins216)
begin
if(rstm4 = '1') then
mux16outs2 <= "00";
elsif(control_line16s2 = "0000") then
mux16outs2 <= mux16ins21;
elsif (control_line16s2 ="0001") then
mux16outs2 <= mux16ins22;
elsif (control_line16s2 = "0010") then
mux16outs2 <= mux16ins23;
elsif (control_line16s2 = "0011") then
mux16outs2 <= mux16ins24;
elsif (control_line16s2 = "0100") then
mux16outs2 <= mux16ins25;
elsif (control_line16s2 = "0101") then
mux16outs2 <= mux16ins26;
elsif (control_line16s2 = "0110") then
mux16outs2 <= mux16ins27;
elsif (control_line16s2 = "0111") then
mux16outs2 <= mux16ins28;
elsif (control_line16s2 = "1000") then
mux16outs2 <= mux16ins29;
elsif (control_line16s2 = "1001") then
mux16outs2 <= mux16ins210;
elsif (control_line16s2 = "1010") then
mux16outs2 <= mux16ins211;
elsif (control_line16s2 = "1011") then
mux16outs2 <= mux16ins212;
elsif (control_line16s2 = "1100") then
mux16outs2 <= mux16ins213;
elsif (control_line16s2 = "1101") then
mux16outs2 <= mux16ins214;
elsif (control_line16s2 = "1110") then
mux16outs2 <= mux16ins215;
else
mux16outs2 <= mux16ins216;
end if;
end process; 

end Behavioral;
