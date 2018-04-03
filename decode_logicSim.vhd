----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/24/2018 09:00:01 PM
-- Design Name: 
-- Module Name: decode_sim - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decode_logicsim is
--  Port ( );
end decode_logicsim;

architecture Behavioral of decode_logicsim is
component decode_logic
Port ( 
            instruction     :       in  STD_LOGIC_VECTOR (7 downto 0);
            zero            :       in  STD_LOGIC;
            negative        :       in  STD_LOGIC;
            rst1            :       in  STD_LOGIC;
            stage           :       in  STD_LOGIC_VECTOR (1 downto 0);
            addrsel         :       out STD_LOGIC_VECTOR (1 downto 0);
            irload          :       out STD_LOGIC;
            imload          :       out STD_LOGIC;
            regsel          :       out STD_LOGIC_VECTOR (1 downto 0);
            dwrite          :       out STD_LOGIC;
            aluop           :       out STD_LOGIC_VECTOR (1 downto 0);
            readwrite       :       out STD_LOGIC;
            pcsel           :       out STD_LOGIC;
            pcload          :       out STD_LOGIC;
            sregsel         :       out STD_LOGIC_VECTOR (1 downto 0);
            dregsel         :       out STD_LOGIC_VECTOR (1 downto 0));
end component;
signal instruction:  std_logic_vector(7 downto 0); --instruction input from IR
signal  zero :  std_logic; --zero line from Register File
  signal negative:  std_logic; --negative from Register file
  signal addrsel,stage :  std_logic_vector(1 downto 0);
  signal irload : std_logic;
  signal imload : std_logic;
  signal regsel: std_logic_vector(1 downto 0);
  signal dwrite: std_logic;
  signal aluop: std_logic_vector(1 downto 0);
  signal readwrite: std_logic;
  signal pcsel: std_logic;
  signal pcload: std_logic;
  signal sregsel: std_logic_vector(1 downto 0);
  signal dregsel: std_logic_vector(1 downto 0);
  signal rst1 : std_logic;
  
begin
s1: decode_logic port map (irload=>irload,imload=>imload,regsel=>regsel,dwrite=>dwrite,aluop=>aluop,instruction=>instruction,zero=>zero,negative=>negative,addrsel=>addrsel,stage => stage, rst1 =>rst1, pcsel=>pcsel,pcload=>pcload,readwrite=>readwrite,sregsel=>sregsel,dregsel=>dregsel);

process
begin
instruction<= "00000001";
for i in 0 to 15 loop
zero <= '1';
negative<='0';
stage <= "00";
wait for 20ns;
stage <= "01";
wait for 20ns;
stage <= "10";
wait for 20ns;
instruction <= instruction + 1;
end loop;
end process;

process
begin
rst1<='1';
wait for 20ns;
rst1<='0';
wait;
end process;
end Behavioral;
