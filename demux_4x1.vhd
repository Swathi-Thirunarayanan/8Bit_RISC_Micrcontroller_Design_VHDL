----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/23/2018 04:46:23 PM
-- Design Name: 
-- Module Name: demux1x4 - Behavioral
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

entity demux1x4 is
--  Port ( );
port(
     --c : in std_logic;
      demuxin: in std_logic;
      demuxctrl: in std_logic_vector(1 downto 0);
      demuxoutput1,demuxoutput2,demuxoutput3,demuxoutput4: out std_logic);
end demux1x4;

architecture Behavioral of demux1x4 is

begin
process(demuxin, demuxctrl)
begin
--if(rising_edge(c)) then
case demuxctrl is
when "00" => demuxoutput1 <= demuxin; demuxoutput2 <= '0'; demuxoutput3 <= '0'; demuxoutput4 <='0';
when "01" => demuxoutput1 <='0'; demuxoutput2 <= demuxin; demuxoutput3 <='0'; demuxoutput4 <='0';
when "10" => demuxoutput1 <='0'; demuxoutput2 <='0'; demuxoutput3 <= demuxin; demuxoutput4 <='0';
when others => demuxoutput1 <='0'; demuxoutput2 <='0'; demuxoutput3 <='0'; demuxoutput4 <= demuxin;
end case;
--end if;
end process;
end Behavioral;
