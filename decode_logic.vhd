----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/22/2018 09:39:26 PM
-- Design Name: 
-- Module Name: decode_logic - Behavioral
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

entity decode_logic is
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
end decode_logic;

architecture Behavioral of decode_logic is
--4:2 mux
component s1_4x1_mux 
port(	
        rstm1 : in std_logic;
        muxins11,muxins12,muxins13,muxins14: in std_logic;
      control_lines1: in std_logic_vector(1 downto 0);
      muxouts1: out std_logic);
end component;

component s2_4x1_mux 
--  Port ( );
port(
      rstm2 : in std_logic;
      muxins21,muxins22,muxins23,muxins24: in std_logic_vector(1 downto 0);
      control_lines2: in std_logic_vector(1 downto 0);
      muxouts2: out std_logic_vector(1 downto 0));
end component; 

--this is the jump logic for the pcload
component jump_logic 
Port (
            z,rst               :       in      std_logic;
            neg             :       in      std_logic;
            ibit4           :       in      std_logic;
            ibit5           :       in      std_logic;
            ibit6           :       in      std_logic;
            ibit7           :       in      std_logic;
            op              :       in      std_logic_vector (1 downto 0);
            jmp_logic_out    :       out     std_logic
         );
end component;

component s2_16x1_mux 
--  Port ( );
port( 
      rstm4 : in std_logic;
      mux16ins21,mux16ins22,mux16ins23,mux16ins24,mux16ins25,mux16ins26,mux16ins27,mux16ins28,mux16ins29,mux16ins210,mux16ins211,mux16ins212,mux16ins213,mux16ins214,mux16ins215,mux16ins216: in std_logic_vector(1 downto 0);
      control_line16s2: in std_logic_vector(3 downto 0);
      mux16outs2: out std_logic_vector(1 downto 0));
end component; 

component s1_16x1_mux 
--  Port ( );
port( 
      rstm3 : in std_logic;
      mux16ins11,mux16ins12,mux16ins13,mux16ins14,mux16ins15,mux16ins16,mux16ins17,mux16ins18,mux16ins19,mux16ins110,mux16ins111,mux16ins112,mux16ins113,mux16ins114,mux16ins115,mux16ins116: in std_logic;
      control_line16s1: in std_logic_vector(3 downto 0);
      mux16outs1: out std_logic);
end component; 

signal jmp_logic   :   std_logic;
signal Rd, Rs, op1, op2, reg_big_mux_out , addr_big_mux_out,aluop_out,sregsel_out,dregsel_out :   std_logic_vector(1 downto 0);
signal rw_and, dwrite_big_mux_out,pcselsi   :   std_logic;
signal op1op2 : std_logic_vector (3 downto 0);


begin
op1     <=      instruction(7 downto 6);
op2     <=      instruction(5 downto 4);
Rd<= instruction (3 downto 2);
Rs <= instruction( 1 downto 0);

rw_and  <=      instruction(4)  and (not instruction(5)) and instruction(6);
op1op2(3 downto 2) <= op1;
op1op2(1 downto 0) <= op2;   

--irload mux
ir_load_logic  : s1_4x1_mux port map(rstm1 => rst1,muxins11 => '1', muxins12 => '0', muxins13 => '0', muxins14 => '0', control_lines1 => stage, muxouts1 => irload);

--imload mux
immed_load_logic : s1_4x1_mux port map (rstm1 => rst1,muxins11 => '0', muxins12 => instruction(7), muxins13 => '0', muxins14 => '0', control_lines1 => stage, muxouts1 => imload);

--pcload mux with jump logic on I2
pc_load     : s1_4x1_mux port map (rstm1 => rst1,muxins11 => '1', muxins12 => instruction(7), muxins13 => jmp_logic, muxins14 => '0', control_lines1 => stage, muxouts1 => pcload);

--jump logic for pc load
jmp_logic1   :   jump_logic port map (rst => rst1,z => zero, neg => negative, ibit4 => instruction(4), ibit5 => instruction(5)
                , ibit6 => instruction(6), ibit7 => instruction(7), op => op2, jmp_logic_out => jmp_logic);
--readwrite mux                
read_write_logic  :   s1_4x1_mux port map(rstm1 => rst1,muxins11 => '0', muxins12 => '0', muxins13 => rw_and, muxins14 => '0', control_lines1 => stage, muxouts1 => readwrite);
   
--regsel mux with mux16 output coming in on I2
reg_sel      :   s2_4x1_mux port map      (rstm2 => rst1,muxins21 => "00", muxins22 => "00", muxins23 => reg_big_mux_out, muxins24 => "00", control_lines2 => stage, muxouts2 => regsel);

--16:4 mux that feeds the regsel 4:2 mux on I2 need to figure out how to use op1 and op2 for s
regsel_big_mux  :   s2_16x1_mux port map (rstm4 => rst1,mux16ins21 => "11", mux16ins22 => "11", mux16ins23 => "11", mux16ins24 => "11", mux16ins25 => "10", mux16ins26 => "00", mux16ins27 => "01", mux16ins28 => "00", mux16ins29 => "00",
                                    mux16ins210 => "00", mux16ins211 => "00", mux16ins212 => "00", mux16ins213 => "10", mux16ins214 => "00", mux16ins215 => "00", mux16ins216 => "00", control_line16s2 => op1op2 , mux16outs2 => reg_big_mux_out);
                                     
--addrsel needs two bits for output??                                    
address_sel     :   s2_4x1_mux port map(rstm2 => rst1,muxins21 => "00", muxins22 => "00", muxins23 => addr_big_mux_out, muxins24 => "00", control_lines2 => stage, muxouts2 => addrsel);  

addr_big_mux    :   s2_16x1_mux port map  (rstm4 => rst1,mux16ins21 => "00", mux16ins22 => "00", mux16ins23 => "00", mux16ins24 => "00", mux16ins25 => "10", mux16ins26 => "10", mux16ins27 => "00", mux16ins28 => "00", mux16ins29 => "00",
                                    mux16ins210 => "00", mux16ins211 => "00", mux16ins212 => "00", mux16ins213 => "01", mux16ins214 => "01", mux16ins215 => "00", mux16ins216 => "00", control_line16s2 => op1op2 , mux16outs2 => addr_big_mux_out);

--dwrite
dwrite_logic    :   s1_4x1_mux port map     (rstm1 => rst1,muxins11 => '0', muxins12 => '0', muxins13 => dwrite_big_mux_out, muxins14 => '0', control_lines1 => stage, muxouts1 => dwrite);  

--16:4 mux that feeds the dwrite 4:2 mux on I2 need to figure out how to use op1 and op2 for s
dwrite_big_mux  :   s1_16x1_mux port map  (rstm3 => rst1,mux16ins11 => '1', mux16ins12 => '1', mux16ins13 => '1', mux16ins14 => '1', mux16ins15 => '1', mux16ins16 => '0', mux16ins17 => '1', mux16ins18 => '0', mux16ins19 => '0',
                                    mux16ins110 => '0', mux16ins111 => '0', mux16ins112 => '0', mux16ins113 => '1', mux16ins114 => '0', mux16ins115 => '1', mux16ins116 => '0', control_line16s1 => op1op2 , mux16outs1 => dwrite_big_mux_out);   
  
aluop_logic     :  s2_4x1_mux port map(rstm2 => rst1,muxins21 => "00", muxins22 => "00", muxins23 => aluop_out, muxins24 => "00", control_lines2 => stage, muxouts2 => aluop);  

aluop_bigmux    : s2_16x1_mux port map  (rstm4 => rst1,mux16ins21 => op2, mux16ins22 => op2, mux16ins23 => op2, mux16ins24 => op2, mux16ins25 => "00", mux16ins26 => "00", mux16ins27 => "00", mux16ins28 => "00", mux16ins29 => op2,
                                    mux16ins210 => op2, mux16ins211 => op2, mux16ins212 => op2, mux16ins213 => "00", mux16ins214 => "00", mux16ins215 => "00", mux16ins216 => "00", control_line16s2 => op1op2 , mux16outs2 => aluop_out);

sregsel_logic     :  s2_4x1_mux port map(rstm2 => rst1,muxins21 => "00", muxins22 => instruction(1 downto 0), muxins23 => sregsel_out, muxins24 => "00", control_lines2 => stage, muxouts2 => sregsel);  

sregsel_bigmux    : s2_16x1_mux port map  (rstm4 => rst1,mux16ins21 => Rs, mux16ins22 => Rs, mux16ins23 => Rs, mux16ins24 => Rs, mux16ins25 => Rs, mux16ins26 => Rs, mux16ins27 => Rs, mux16ins28 => "00", mux16ins29 => "00",
                                    mux16ins210 => "00", mux16ins211 => "00", mux16ins212 => "00", mux16ins213 => "00", mux16ins214 => "00", mux16ins215 => "00", mux16ins216 => "00", control_line16s2 => op1op2 , mux16outs2 => sregsel_out);

dregsel_logic     :  s2_4x1_mux port map(rstm2 => rst1,muxins21 => "00", muxins22 => "00", muxins23 => dregsel_out, muxins24 => "00", control_lines2 => stage, muxouts2 => dregsel);  

dregsel_bigmux    : s2_16x1_mux port map  (rstm4 => rst1,mux16ins21 => Rd, mux16ins22 => Rd, mux16ins23 => Rd, mux16ins24 => Rd, mux16ins25 => Rd, mux16ins26 => Rd, mux16ins27 => Rd, mux16ins28 => "00", mux16ins29 => Rd,
                                    mux16ins210 => Rd, mux16ins211 => Rd, mux16ins212 => Rd, mux16ins213 => Rd, mux16ins214 => Rd, mux16ins215 => Rd, mux16ins216 => "00", control_line16s2 => op1op2 , mux16outs2 => dregsel_out);

pcsel_logic       : s1_4x1_mux port map     (rstm1 => rst1, muxins11 => '1', muxins12 => pcselsi, muxins13 => '0', muxins14 => '0', control_lines1 => stage, muxouts1 => pcsel);  

pcselsi <= '0' when instruction(7) = '0' else '1';
end Behavioral;
