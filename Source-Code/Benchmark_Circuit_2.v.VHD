library ieee;
use ieee.std_logic_1164.all;

entity BENCHMARK_CKT2 is
port(clk,clr,a,b,c,d: in std_logic;
yu: out std_logic);
end BENCHMARK_CKT2;

architecture behave of BENCHMARK_CKT2 is
signal p1,p2,p3,p4,s1,s2,q0,q1,q2,k1,k2,k3: std_logic;

begin
t1:process(clk,k1)
begin
if clr='1' then
q0<='0';
elsif rising_edge(clk) then
q0<=k1;
end if;
end process t1;

t2:process(clk,k2)
begin
if clr='1' then
q1<='0';
elsif rising_edge(clk) then
q1<=k2;
end if;
end process t2;

t3:process(clk,k3)
begin
if clr='1' then
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

yu	<= not p4;
k1<= (not d) nor p4;
k2<=b nor s1;
k3<=p4;
end behave;
