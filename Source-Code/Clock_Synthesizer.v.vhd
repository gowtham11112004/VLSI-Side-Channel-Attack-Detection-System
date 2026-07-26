
library ieee;
use ieee.std_logic_1164.all;

entity Clock_Synth is
port(clk,clr,a,b,c,d: in std_logic;
    ykk:in std_logic_vector(6 downto 0);
y,yss: out std_logic_vector(6 downto 0));
end Clock_Synth;

architecture behave of Clock_Synth is
signal p1,p2,p3,p4,s1,s2,q0,q1,q2,k1,k2,k3,y1: std_logic;

begin
t1:process(clk,k1,ykk)
begin
if clr='1' or ykk(6)='1' then
q0<='0';
elsif rising_edge(clk) then
q0<=k1;
end if;
end process t1;


t2:process(clk,k2,ykk)
begin
if clr='1' or ykk(6)='1'then
q1<='0';
elsif rising_edge(clk) then
q1<=k2;
end if;
end process t2;

t3:process(clk,k3,ykk)
begin
if clr='1' or ykk(6)='1'then
q2<='0';
elsif rising_edge(clk) then
q2<=k3;
end if;
end process t3;
-- Gate functions
s1	<= q1 nor a;
s2	<= (not d ) and q2;

p1	<= s1 or s2;
p2	<=s2 or c;
p3	<= p1 nand p2;
p4	<=s1 nor p3;

y1	<= not p4;
k1<= (not d) nor p4;
k2<=b nor s1;
k3<=p4;

y(0)<=P1 or ykk(0);
y(1)<=p2 or ykk(1);
y(2)<=p3 or ykk(2);
y(3)<=p4 or ykk(3);
y(4)<=k1 or ykk(4);
y(5)<=k2 or ykk(5);
y(6)<=k3 or ykk(6);

yss(0)<=P1;
yss(1)<=p2;
yss(2)<=p3;
yss(3)<=p4;
yss(4)<=k1;
yss(5)<=k2;
yss(6)<=k3;

end behave;