----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/25/2018 03:20:12 PM
-- Design Name: 
-- Module Name: Microcontroller - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Microcontroller is
--  Port ( );
port(
      main_clock : in std_logic;
      main_reset : in std_logic;
      pc_sel,pc_load,ir_load,im_load,read_write,d_write,zer,neg :out std_logic;
      addr_sel,reg_sel,dreg_sel,sreg_sel,stages : out std_logic_vector(1 downto 0);
      alu_op : out std_logic_vector(1 downto 0);
      alu_out,regi0,regi1,regi2,regi3,pc_out,data_in,s_bus,d_bus,ir_out,im_out    : out std_logic_vector(7 downto 0));
end Microcontroller;

architecture Behavioral of Microcontroller is
component phase_counter is
--  Port ();
port ( 
      clk: in std_logic; 
      rst: in std_logic; 
      stage: out std_logic_vector(1 downto 0)); 
end component;

component s8_2x1_mux is
--  Port ( );
port(
      muxin2x1,muxin2x2: in std_logic_vector(7 downto 0);
      control_line2x1: in std_logic;
      muxout2x1: out std_logic_vector(7 downto 0));
end component;

component PC is
--  Port ( );
port(
     pcin: in std_logic_vector(7 downto 0);
     clk : in std_logic;
     rst : in std_logic;
     pcload: in std_logic;
     pcout: out std_logic_vector(7 downto 0));
end component;

component ALU is                                      
port( 
        A: in std_logic_vector(7 downto 0);        
        B: in std_logic_vector(7 downto 0);        
        aluop: in std_logic_vector(1 downto 0);    
        result: out std_logic_vector(7 downto 0)); 
end component;

component s8_4x1_mux is
--  Port ( );
port(
      muxin1,muxin2,muxin3,muxin4: in std_logic_vector(7 downto 0);
      control_line: in std_logic_vector(1 downto 0);
      muxout: out std_logic_vector(7 downto 0));
end component;

component decode_logic is
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

component Register_file is
--  Port ( );
port(
     clock  : in std_logic;
     dwrite: in std_logic;
     dval: in std_logic_vector(7 downto 0);
     dregsel,sregsel: in std_logic_vector(1 downto 0);
     dbus,sbus : out std_logic_vector(7 downto 0);
     zero,negative : out std_logic;
     r0,r1,r2,r3 : out std_logic_vector(7 downto 0));
end component;

component IR is
--  Port ( );
port(
     Irin: in std_logic_vector(7 downto 0);
     clk : in std_logic;
     irload: in std_logic;
     Irout: out std_logic_vector(7 downto 0));
end component;

component Immediate_Register is
--  Port ( );
port(
     Imin: in std_logic_vector(7 downto 0);
     clk : in std_logic;
     imload: in std_logic;
     Imout: out std_logic_vector(7 downto 0));
end component;

component Memory is
--  Port ( );
    port( 
        address: in std_logic_vector(7 downto 0); 
        dataout: in std_logic_vector(7 downto 0); 
        readwrite: in std_logic; 
        clk: in std_logic; 
        rst: in std_logic;
        datain: out std_logic_vector(7 downto 0));
end component;

signal pcinsig,pcoutsig,immedsig, pccounter,sbussig,dbussig,addroutsig,datainsig,iroutsig,regoutsig,aluoutsig: std_logic_vector(7 downto 0);
signal pcloadsig, pcselsig,readwritesig,irloadsig,imloadsig,dwritesig,zerosig,negativesig : std_logic;
signal addrselsig,regselsig,dregselsig,sregselsig,aluopsig,stage_outsig : std_logic_vector(1 downto 0);
 


begin
pccounter <= std_logic_vector(unsigned(pcoutsig) + 1);
mainpc: PC port map(clk => main_clock, rst=> main_reset , pcin => pcinsig  , pcload => pcloadsig , pcout => pcoutsig);
pc_mux: s8_2x1_mux port map(muxin2x1 => immedsig, muxin2x2 => pccounter , control_line2x1 => pcselsig, muxout2x1 => pcinsig);
address_mux : s8_4x1_mux port map(muxin1 => pcoutsig, muxin2 => immedsig, muxin3 => sbussig , muxin4 => dbussig ,control_line => addrselsig, muxout => addroutsig); 
mainmemory : memory port map(address => addroutsig, dataout => dbussig, readwrite => readwritesig , clk => main_clock, rst => main_reset, datain => datainsig); 
mainir : IR port map(clk => main_clock,irin => datainsig, irout => iroutsig, irload => irloadsig);
mainim : Immediate_Register port map(clk => main_clock, imin => datainsig ,  imload => imloadsig, imout => immedsig);
register_mux : s8_4x1_mux port map(muxin1 => immedsig, muxin2 => sbussig, muxin3 => datainsig , muxin4 => aluoutsig,control_line => regselsig, muxout => regoutsig);  
mainregister: Register_file port map(clock => main_clock, dwrite => dwritesig, dval => regoutsig, dregsel => dregselsig , sregsel => sregselsig, dbus => dbussig, sbus => sbussig, zero => zerosig , negative => negativesig, r0 => regi0, r1 => regi1, r2 => regi2, r3 => regi3);
mainalu : ALU port map(a => dbussig, b => sbussig , aluop => aluopsig ,result => aluoutsig);
decode : decode_logic port map(instruction => iroutsig, zero => zerosig , negative => negativesig , rst1 => main_reset, stage => stage_outsig, addrsel => addrselsig, irload => irloadsig, imload => imloadsig, regsel => regselsig, dwrite => dwritesig, aluop => aluopsig, readwrite => readwritesig, pcsel => pcselsig, pcload => pcloadsig, sregsel => sregselsig, dregsel => dregselsig);
stage : phase_counter port map(clk => main_clock, rst => main_reset, stage => stage_outsig);
alu_out <= aluoutsig;
pc_sel <= pcselsig;
pc_load <= pcloadsig;
ir_load <= irloadsig;
im_load <= imloadsig;
read_write <= readwritesig;
d_write  <= dwritesig;
addr_sel <= addrselsig;
reg_sel <= regselsig;
dreg_sel <= dregselsig;
sreg_sel <= sregselsig;
alu_op <= aluopsig;
stages <= stage_outsig;
data_in <= datainsig;
pc_out <= pcoutsig;
zer <= zerosig;
neg <= negativesig;
s_bus <= sbussig;
d_bus <= dbussig;
ir_out <= iroutsig;
im_out <= immedsig;
end Behavioral;
