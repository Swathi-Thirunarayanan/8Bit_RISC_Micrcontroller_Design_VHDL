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

entity s8_2x1_mux is
--  Port ( );
port(
      muxin2x1,muxin2x2: in std_logic_vector(7 downto 0);
      control_line2x1: in std_logic;
      muxout2x1: out std_logic_vector(7 downto 0));
end s8_2x1_mux;

architecture Behavioral of s8_2x1_mux is
begin
with control_line2x1 select muxout2x1 <= muxin2x1 when '0',
                                   muxin2x2 when others;                

end Behavioral;
