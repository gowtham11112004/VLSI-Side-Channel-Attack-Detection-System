Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity Attack_gen is
    port(clk,clr: in std_logic;
    config : in std_logic_vector(3 downto 0);
    Attack_Insert: out std_logic_vector(6 downto 0));
end Attack_gen;


architecture behave of Attack_gen is
SIGNAL Attack_Insert1,Attack_Insert2,Attack_Insert3:  std_logic_vector(6 downto 0);  
begin

--Information leaking
--Information leaking: an FPGA vendor?s confidential data needed 
--for the fabrication of the FPGA chips may be mishandled or leaked 
--to parties (e.g., another competing FPGA vendor) that should not 
--have access to such data (Pw controlled)

Unauthorized_Probe:process(clk,clr,config(0))
begin
    if clr='1' or config(0)='0'then
        Attack_Insert1<="0000000";
        elsif rising_edge(clk) then
        Attack_Insert1<="1000000";
    end if;            
end process Unauthorized_Probe;    

--Reverse engineering: 
--IP core vendors expect their IPs cannot be reverse engineered 
--by untrusted parties (Hacking of Data- Insertion detection)

Data_Insert:process(clk,clr)
begin
    if clr='1' or config(1)='0' then
        Attack_Insert2<="1011101";
        elsif rising_edge(clk) then
        Attack_Insert2<=Attack_Insert2+1; -- Fetch Wrong Data into the Logic
    end if;            
end process Data_Insert;


--FPGA replay attack: 
--an adversary downgrades an FPGA-based system 
--to the previous version of FPGA chips with known vulnerabilities 
--and explores such vulnerabilities. (Forbidden_Resets)

Forbidden_Resets:process(clk,clr,config(2))
begin
    if clr='1' or config(2)='0' then
        Attack_Insert3<="0000000";
        elsif rising_edge(clk) then
        Attack_Insert3(0)<=Attack_Insert2(2) xor Attack_Insert2(1) xor Attack_Insert3(3); -- Fetch reset loop
        Attack_Insert3(1)<=Attack_Insert2(4) xor Attack_Insert2(5) xor Attack_Insert3(4); -- Fetch reset loop
        Attack_Insert3(2)<=Attack_Insert2(6) xor Attack_Insert2(1) xor Attack_Insert3(1); -- Fetch reset loop
        Attack_Insert3(3)<=Attack_Insert2(2) xor Attack_Insert2(4) xor Attack_Insert3(2); -- Fetch reset loop
        Attack_Insert3(4)<=Attack_Insert2(3) xor Attack_Insert2(1) xor Attack_Insert3(5); -- Fetch reset loop
        Attack_Insert3(5)<=Attack_Insert2(2) xor Attack_Insert2(6) xor Attack_Insert3(6); -- Fetch reset loop                                        
        Attack_Insert3(6)<=Attack_Insert2(2) xor Attack_Insert2(2) xor Attack_Insert3(0); -- Fetch reset loop        
    end if;            
end process Forbidden_Resets;

AttackRouter:process(clk,clr,config)
begin
if clr='1' then
Attack_Insert<="0000000";
elsif falling_edge(clk) then
    case config is
        when "0001"=>Attack_Insert<=Attack_Insert1;
        when "0010"=>Attack_Insert<=Attack_Insert2;
        when "0100"=>Attack_Insert<=Attack_Insert3;  
        when others =>Attack_Insert<="0000000";
    end case;
end if;
end process AttackRouter;
   
end behave;    



