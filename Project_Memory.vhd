----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/18/2018 01:18:19 AM
-- Design Name: 
-- Module Name: Memory - RAM
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

entity Memory is
--  Port ( );
    port( 
        address: in std_logic_vector(7 downto 0); 
        dataout: in std_logic_vector(7 downto 0); 
        readwrite: in std_logic; 
        clk: in std_logic; 
        rst: in std_logic;
        datain: out std_logic_vector(7 downto 0));
end Memory;

architecture RAM of Memory is
   type ram_type is array (0 to (2**address'length)-1) of std_logic_vector(datain'range);  
   signal ramArray : ram_type;

begin

process(clk,rst) is
	begin
	   if Rst = '1' then
                -- Clear Memory on Reset
        ramArray <= (others => (others => '0'));
	   else
	   ramArray(0) <= x"e4";
	   ramArray(1) <= x"00";
	   ramArray(2) <= x"e0";
	   ramArray(3) <= x"80";
	   ramArray(4) <= x"48";
	   ramArray(5) <= x"88";
	   ramArray(6) <= x"0d";
	   ramArray(7) <= x"26";
	   ramArray(8) <= x"ec";
	   ramArray(9) <= x"01";
	   ramArray(10) <= x"23";
	   ramArray(11) <= x"ff";
	   ramArray(12) <= x"04";
	   ramArray(13) <= x"d4";
	   ramArray(14) <= x"40";
	   ramArray(15) <= x"ff";
	   ramArray(16) <= x"0f";
	   ramArray(128) <= x"02";
	   ramArray(129) <= x"01";
	   ramArray(130) <= x"00";  
	  	   if rising_edge(Clk) then
	if readwrite = '1' then		
	ramArray(to_integer(unsigned(Address))) <= Dataout;
	end if; 
	end if;
	end if;
    end process;
   Datain <= ramArray(to_integer(unsigned(Address)));
end RAM;
