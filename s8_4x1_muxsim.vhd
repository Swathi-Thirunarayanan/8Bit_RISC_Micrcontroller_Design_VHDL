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

-- Uncomment the following library declaration if using----------------------------------------------------------------------------------
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

entity s8_4x1_muxsim is
--  Port ( );
end s8_4x1_muxsim;

architecture Behavioral_Sim of s8_4x1_muxsim is

component s8_4x1_mux is
--  Port ( );
port(
      muxin1,muxin2,muxin3,muxin4: in std_logic_vector(7 downto 0);
      control_line: in std_logic_vector(1 downto 0);
      muxout: out std_logic_vector(7 downto 0));
end component;

        signal muxin1 : std_logic_vector(7 downto 0):= "11110000" ;
        signal muxin2 : std_logic_vector(7 downto 0):= "11011011";
        signal muxin3 : std_logic_vector(7 downto 0):= "10101010";
        signal muxin4 : std_logic_vector(7 downto 0):= "10101011";
        signal muxout : std_logic_vector(7 downto 0);
        signal control_line   : std_logic_vector(1 downto 0);
begin
UUT: s8_4x1_mux port map (muxin1=>muxin1, muxin2 =>muxin2 , muxin3 =>muxin3, muxin4 => muxin4, control_line=> control_line,muxout => muxout);
sti: process
begin
  control_line <=  "00";
  wait for 100 ns;
  control_line <= "01";
  wait for 100 ns;
  control_line <= "10";
  wait for 100 ns;
  control_line <= "11";
  wait for 100 ns;
end process;
end Behavioral_Sim;

-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity std_logic_vector_4x1_mux is
--  Port ( );
port(
      muxin1, muxin2, muxin3, muxin4: in std_logic_vector(7 downto 0);
      control_line: in std_logic_vector(1 downto 0);
      muxout: out std_logic_vector(7 downto 0));
end std_logic_vector_4x1_mux;

architecture Behavioral of std_logic_vector_4x1_mux is
begin
with control_line select muxout <= muxin1 when "00",
                                   muxin2 when "01",
                                   muxin3 when "10",
                                   muxin4 when others;                   

end Behavioral;
