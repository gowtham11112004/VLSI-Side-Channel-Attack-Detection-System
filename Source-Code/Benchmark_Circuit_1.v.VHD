library ieee;
use ieee.std_logic_1164.all;

entity BENCHMARK_CKT1 is
port(clk,clr,aa,ba,ca,da: in std_logic;
ya: out std_logic);
end BENCHMARK_CKT1;

architecture behave of BENCHMARK_CKT1 is
signal p1a,p2a,p3a,p4a,s1a,s2a,q0a,q1a,q2a,k1a,k2a,k3a: std_logic;

begin
t1a:process(clk,k1a)
begin
if clr='1' then
q0a<='0';
elsif rising_edge(clk) then
q0a<=k1a;
end if;
end process t1a;


t2a:process(clk,k2a)
begin
if clr='1' then
q1a<='0';
elsif rising_edge(clk) then
q1a<=k2a;
end if;
end process t2a;

t3a:process(clk,k3a)
begin
if clr='1' then
q2a<='0';
elsif rising_edge(clk) then
q2a<=k3a;
end if;
end process t3a;
-- Gate functions
s1a	<= q1a nor aa;
s2a	<= (not da ) and q2a;

p1a	<= s1a or s2a;
p2a	<=s2a or ca;
p3a	<= p1a nand p2a;
p4a	<=s1a nor p3a;

ya	<= not p4a;
k1a<= (not da) nor p4a;
k2a<=ba nor s1a;
k3a<=p4a;

end behave;

