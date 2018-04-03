----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/23/2018 04:29:19 AM
-- Design Name: 
-- Module Name: register_fileSim - Behavioral
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

entity register_fileSim is
--  Port ( );
end register_fileSim;

architecture Behavioral of register_fileSim is

component Register_file 
--  Port ( );
port(
     clock  : in std_logic;
     dwrite: in std_logic;
     dval: in std_logic_vector(7 downto 0);
     dregsel,sregsel: in std_logic_vector(1 downto 0);
     dbus,sbus : out std_logic_vector(7 downto 0);
     zero,negative : out std_logic);
end component;

signal clock,dwrite,zero,negative : std_logic;
signal dval, dbus,sbus : std_logic_vector(7 downto 0);
signal dregsel,sregsel:  std_logic_vector(1 downto 0);

begin
UUT: Register_file port map(clock => clock,dwrite => dwrite, dval => dval,dregsel => dregsel, sregsel => sregsel,dbus => dbus, sbus => sbus, zero => zero, negative => negative);

C:process
begin
clock <= '1';
wait for 100 ns;
clock <= '0';
wait for 100 ns;
end process;

enab: process
begin
wait for 100 ns;
dwrite <= '1';
wait for 1000 ns;
dwrite <= '0';
wait for 100 ns;
dwrite <= '1';
wait;
end process;

process
begin
wait for 100 ns;
wait until falling_edge(clock);
dval <= x"de";
dregsel <= "00";
sregsel <= "00";
--wait for 100 ns;
wait until falling_edge(clock);
dval <= x"ef";
dregsel <= "01";
sregsel <= "10";
--wait for 100 ns;
wait until falling_edge(clock);
dval <= x"ff";
dregsel <= "10";
sregsel <= "11";
--wait for 100 ns;
wait until falling_edge(clock);
dval <= x"fc";
dregsel <= "11";
sregsel <= "01";
--wait for 100 ns;
wait until falling_edge(clock);
dval <= x"fd";
dregsel <= "10";
sregsel <= "01";
wait until falling_edge(clock);
dval <= x"fe";
dregsel <= "00";
sregsel <= "00";

end process;
end Behavioral;
