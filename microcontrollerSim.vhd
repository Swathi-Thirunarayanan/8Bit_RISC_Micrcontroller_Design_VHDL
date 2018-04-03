----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/25/2018 06:52:46 PM
-- Design Name: 
-- Module Name: microcontrollerSim - Behavioral
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

entity microcontrollerSim is
--  Port ( );
end microcontrollerSim;

architecture Behavioral of microcontrollerSim is
component Microcontroller is
--  Port ( );
port(
      main_clock : in std_logic;
      main_reset : in std_logic;
      pc_sel,pc_load,ir_load,im_load,read_write,d_write,zer,neg :out std_logic;
      addr_sel,reg_sel,dreg_sel,sreg_sel,stages : out std_logic_vector(1 downto 0);
      alu_op : out std_logic_vector(1 downto 0);
      alu_out,regi0,regi1,regi2,regi3,pc_out,data_in,s_bus,d_bus,ir_out,im_out    : out std_logic_vector(7 downto 0));
end component;
signal main_clock, main_reset,pc_sel,pc_load,ir_load,im_load,read_write,d_write,zer,neg : std_logic;
signal alu_out,regi0,regi1,regi2,regi3,pc_out,data_in,s_bus,d_bus,ir_out,im_out    : std_logic_vector(7 downto 0);
signal alu_op,addr_sel,reg_sel,dreg_sel,sreg_sel,stages  : std_logic_vector(1 downto 0);
 
begin
UUT: Microcontroller port map (main_clock => main_clock,main_reset=>main_reset,alu_out => alu_out,pc_sel => pc_sel,pc_load => pc_load ,ir_load => ir_load,im_load => im_load,
        read_write => read_write,d_write => d_write,addr_sel => addr_sel ,reg_sel => addr_sel,dreg_sel => dreg_sel,sreg_sel => sreg_sel,alu_op => alu_op,regi0=>regi0,
        regi1 => regi1, regi2 => regi2, regi3 => regi3, stages => stages,zer => zer,neg => neg, s_bus => s_bus,d_bus => d_bus,data_in => data_in,pc_out => pc_out,ir_out => ir_out, im_out => im_out);

clock: process
begin
--wait for 20 ns;
main_clock <= '1';
wait for 20 ns;
main_clock <= '0';
wait for 20 ns;
end process;

reset: process
begin
main_reset <= '1';
wait for 40 ns;
main_reset <= '0';
wait;
end process;

end Behavioral;
