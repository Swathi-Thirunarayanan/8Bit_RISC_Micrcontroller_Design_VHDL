----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/23/2018 03:12:28 AM
-- Design Name: 
-- Module Name: Register file - Behavioral
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

entity Register_file is
--  Port ( );
port(
     clock  : in std_logic;
     dwrite: in std_logic;
     dval: in std_logic_vector(7 downto 0);
     dregsel,sregsel: in std_logic_vector(1 downto 0);
     dbus,sbus : out std_logic_vector(7 downto 0);
     zero,negative : out std_logic;
     r0,r1,r2,r3 : out std_logic_vector(7 downto 0));
end Register_file;

architecture Behavioral of Register_file is

component registerfs 
--  Port ( );
port(
     clk : in std_logic;
     enable: in std_logic;
     din: in std_logic_vector(7 downto 0);
     dout : out std_logic_vector(7 downto 0));
  --   regsig : out std_logic);
end component;

component s8_4x1_mux 
--  Port ( );
port(
     -- muxen : in std_logic;
      muxin1,muxin2,muxin3,muxin4: in std_logic_vector(7 downto 0);
      control_line: in std_logic_vector(1 downto 0);
      muxout: out std_logic_vector(7 downto 0));
end component;

component demux1x4 is
--  Port ( );
port(
      --c : in std_logic;
      demuxin: in std_logic;
      demuxctrl: in std_logic_vector(1 downto 0);
      demuxoutput1,demuxoutput2,demuxoutput3,demuxoutput4: out std_logic);
end component;

signal rwrite0,rwrite1,rwrite2,rwrite3 : std_logic;
--signal regsig : std_logic:='0';
signal dval0,dval1, dval2,dval3 : std_logic_vector(7 downto 0):= x"00";
signal dmux1,dmux2,dmux3,dmux4,dbussig,sbussig: std_logic_vector(7 downto 0):= x"00";

begin

d: demux1x4 port map(demuxin => dwrite, demuxctrl => dregsel, demuxoutput1 => rwrite0, demuxoutput2 => rwrite1, demuxoutput3 => rwrite2, demuxoutput4 => rwrite3);

process(dregsel,dval)
begin
if(dregsel = "00") then
dval0 <= dval;
dval1 <= x"00";
dval2 <= x"00";
dval3 <= x"00";
elsif(dregsel = "01") then
dval1 <= dval;
dval0 <= x"00";
dval2 <= x"00";
dval3 <= x"00";
elsif(dregsel = "10") then
dval2 <= dval;
dval1 <= x"00";
dval0 <= x"00";
dval3 <= x"00";
else
dval3 <= dval;
dval1 <= x"00";
dval2 <= x"00";
dval0 <= x"00";
end if;
end process;

--dval0 <= dval when dregsel ="00";
--dval1 <= dval when dregsel = "01";
--dval2 <= dval when dregsel = "10";
--dval3 <= dval when dregsel = "11";
      
   
reg0: registerfs port map(clk => clock, enable => rwrite0, din => dval0, dout => dmux1);
reg1: registerfs port map(clk => clock, enable => rwrite1, din => dval1, dout => dmux2);
reg2: registerfs port map(clk => clock, enable => rwrite2, din => dval2, dout => dmux3);
reg3: registerfs port map(clk => clock, enable => rwrite3, din => dval3, dout => dmux4);

m0: s8_4x1_mux port map(muxin1 => dmux1,muxin2 => dmux2, muxin3 => dmux3, muxin4 => dmux4, control_line=>dregsel,muxout =>dbussig); 
m1: s8_4x1_mux port map(muxin1 => dmux1,muxin2 => dmux2, muxin3 => dmux3, muxin4 => dmux4, control_line=>sregsel,muxout =>sbussig); 


zero <= not (dbussig(0) or dbussig(1) or dbussig(2) or dbussig(3) or dbussig(4) or dbussig(5) or dbussig(6) or dbussig(7));
negative <= dbussig(7);
dbus <= dbussig;
sbus <= sbussig;

r0 <= dmux1;
r1 <= dmux2;
r2 <= dmux3;
r3 <= dmux4;


end Behavioral;
