----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/23/2018 03:45:34 AM
-- Design Name: 
-- Module Name: register - Behavioral
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

entity registerfs is
--  Port ( );
port(
     clk : in std_logic;
     enable: in std_logic;
     din: in std_logic_vector(7 downto 0);
     dout : out std_logic_vector(7 downto 0));
     --regsig: out std_logic);
end registerfs;

architecture Behavioral of registerfs is

begin
process(clk)
begin
if(rising_edge(clk)) then
if(enable = '1') then
dout <= din;
end if;
end if;
end process;

end Behavioral;
