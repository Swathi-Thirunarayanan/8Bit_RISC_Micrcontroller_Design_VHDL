----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/18/2018 02:25:09 AM
-- Design Name: 
-- Module Name: MemorySim - RAM
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
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MemorySim is
--  Port ( );
end MemorySim;

architecture RAM of MemorySim is

component Memory
    port( 
        address: in std_logic_vector(7 downto 0); 
        dataout: in std_logic_vector(7 downto 0); 
        readwrite: in std_logic; 
        clk: in std_logic; 
        rst: in std_logic;
        datain: out std_logic_vector(7 downto 0));
end component;

signal address,dataout : std_logic_vector(7 downto 0):= (others => '0');
signal datain : std_logic_vector(7 downto 0);
signal readwrite,clk : std_logic:='0'; 
signal rst : std_logic := '1';
constant CLK_period : time := 10 ns;
begin
UUT : Memory port map(address=>address,dataout=>dataout,readwrite=>readwrite,clk=>clk, rst => rst, datain => datain);

CLK_process : process
   begin
        Clk <= '0';
        wait for CLK_period/2;
        Clk <= '1';
        wait for CLK_period/2;
   end process;

   -- Stimulate Write process
stim_write_read : process
   begin   
       -- write
      wait for CLK_period * 1;  
      Address <= x"00";
      Rst   <= '0';
      for i in 0 to 256 loop
           readwrite <= '0';  
         wait for CLK_period * 1;  
         Address <= Address +1;      
      end loop;    
end process;

end RAM;

