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

entity s8_2x1_muxsim is
--  Port ( );
end s8_2x1_muxsim;

architecture Behavioral_Sim of s8_2x1_muxsim is

component s8_2x1_mux is
--  Port ( );
port(
      muxin2x1,muxin2x2: in std_logic_vector(7 downto 0);
      control_line2x1: in std_logic;
      muxout2x1: out std_logic_vector(7 downto 0));
end component;

        signal muxin2x1 : std_logic_vector(7 downto 0):= "11110000" ;
        signal muxin2x2 : std_logic_vector(7 downto 0):= "11011011";
        signal muxout2x1 : std_logic_vector(7 downto 0);
        signal control_line2x1   : std_logic;
begin
UUT: s8_2x1_mux port map (muxin2x1=>muxin2x1, muxin2x2 =>muxin2x2 ,control_line2x1=> control_line2x1,muxout2x1 => muxout2x1);
sti: process
begin
  control_line2x1 <=  '0';
  wait for 100 ns;
  control_line2x1 <= '1';
  wait for 100 ns;
end process;
end Behavioral_Sim;
