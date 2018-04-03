----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/23/2018 03:05:05 AM
-- Design Name: 
-- Module Name: Immediate_Register - Behavioral
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

entity Immediate_Register is
--  Port ( );
port(
     Imin: in std_logic_vector(7 downto 0);
     clk : in std_logic;
     imload: in std_logic;
     Imout: out std_logic_vector(7 downto 0));
end Immediate_Register;

architecture Behavioral of Immediate_Register is
 --signal imout1 : std_logic_vector(7 downto 0);
begin
--imout <= imin when rising_edge(clk) and imload = '1';
process(clk,imload)
begin
if (rising_edge(clk) and imload = '1') then
imout <= imin;
end if;
end process;
 --imout <= imout1;
 
end Behavioral;
