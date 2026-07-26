
Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity delay_detector is
    port(fin,fref : in std_logic;
        lock: out std_logic;
        up,down : out std_logic);
end delay_detector;


architecture behave of delay_detector is
    signal clry: std_logic;
    signal aout,bout : std_logic;
    signal aout_bar,bout_bar : std_logic;
    signal vcc: std_logic;
    
begin

--Get Input Frequency 
vcc<='1';
clry<= aout nand bout;            

a: process(fin,clry)
begin
if clry='1' then
     aout<='0';
     
elsif rising_edge(fin) then
     aout<=vcc;
     aout_bar<= not vcc;
end if;
end process a;


-- Get reference frequency

b: process(fref,clry)
begin
if clry='1' then
   bout<='0';
elsif rising_edge(fref) then
   bout <= vcc;
   bout_bar<= not vcc;
end if;
end process b;
    
Lock <= aout_bar and bout_bar;    
  
up    <= aout_bar;
down  <= bout_bar;  
  
end behave;    

