----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/23/2018 10:05:08 PM
-- Design Name: 
-- Module Name: jump_logic - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity jump_logic is
Port (  rst             :   in      std_logic;
        z               :   in      std_logic;
        neg             :   in      std_logic;
        ibit4           :   in      std_logic;
        ibit5           :   in      std_logic;
        ibit6           :   in      std_logic;
        ibit7           :   in      std_logic;
        op              :   in      std_logic_vector (1 downto 0);
        jmp_logic_out    :   out     std_logic
         );
end jump_logic;

architecture Behavioral of jump_logic is

component s1_4x1_mux is
port(
    rstm1 : in std_logic;	
    muxins11,muxins12,muxins13,muxins14: in std_logic;
      control_lines1: in std_logic_vector(1 downto 0);
      muxouts1: out std_logic);
end component;

signal not_z, z_and_n, jmp_mux_out, and1_out, and2_out : std_logic;

begin

jmp_mux : s1_4x1_mux  port map (rstm1 => rst, muxins11 => z, muxins12 => not_z, muxins13 => z_and_n, muxins14 => neg, control_lines1 => op, muxouts1 => jmp_mux_out);

not_z   <= not z;
z_and_n <= (not z) and (not neg);

and1_out <= (not ibit6) and ibit7 and jmp_mux_out;

and2_out <= ibit4 and ibit5 and ibit6 and ibit7;

jmp_logic_out <= and1_out or and2_out;

end Behavioral;