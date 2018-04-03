----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/22/2018 08:46:43 PM
-- Design Name: 
-- Module Name: phase_counter - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity phase_counter is
--  Port ();
port ( 
      clk: in std_logic; 
      rst: in std_logic; 
      stage: out std_logic_vector(1 downto 0)); 
end phase_counter;

architecture Behavioral of phase_counter is
signal cnt,tmp : std_logic_vector(1 downto 0);
signal resetsig : std_logic;
begin
  process(clk,rst)
	begin
	    if(rst ='1')then
		    cnt <= "11";
		else if(rising_edge(clk)) then
		    if(cnt<"10") then
		    cnt <= cnt + 1;
		    else cnt <= "00";
   --         if(resetsig = '1') then
   --         cnt <= "00";
            end if;
		end if;
	end if;
	end process;
--	resetsig <= cnt(1) and cnt(0);
     tmp <= "00" when cnt = "11" else cnt;
	 stage <= tmp;
end Behavioral;
