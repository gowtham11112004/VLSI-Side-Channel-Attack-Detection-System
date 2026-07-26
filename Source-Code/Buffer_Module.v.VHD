Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;


entity BUFF is
port(clk,clr,upcnt: in std_logic;
carry,barrow : out std_logic);
end BUFF;


architecture behave of BUFF is
signal upcounter , downcounter : std_logic_vector(7 downto 0);
    
begin
    
lpfilter: process(clk,clr,upcnt)
begin
    if clr='1' then
        upcounter<="00000000";
        downcounter<="11111111";
        elsif rising_edge(clk) then
            if upcnt = '1' then
            upcounter   <=    upcounter+1;
            else
            downcounter<=downcounter-1;
        end if;            
end if;      
end process lpfilter;    

carry    <=    upcounter(7);
barrow   <=    downcounter(7);

end behave;    
    



