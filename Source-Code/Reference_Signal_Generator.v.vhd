Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity ref_sig_gen is
port(clk,clr: in std_logic;
    sel: in std_logic_vector(7 downto 0);
    ref_clk : out std_logic);
end ref_sig_gen;

architecture behave of  ref_sig_gen is
signal clkcounter_i,clkcounter : std_logic_vector(19 downto 0);
signal asig: std_logic;
begin

-- Clock divider
Clkdiv : process(clk,clr)
begin
    if clr='1' then
        clkcounter_i<="00000000000000000000";
        elsif rising_edge(clk) then
        clkcounter_i<= clkcounter_i +1;
end if;
end process Clkdiv;       


clkcounter <= clkcounter_i;

-- Data Selector
data_selector: process(sel,clr,clk)
begin
if clr ='1' then
    ref_clk <='0';
    asig<='1';
    elsif rising_edge(clk) then
        
      if sel="00000001" then
       ref_clk	<=	asig and clkcounter(0);
       
       
      else if sel="00000010" then
       ref_clk	<=	asig and clkcounter(1);       
      
      else if sel="00000011" then
       ref_clk	<=	asig and clkcounter(2);       
    
       
      else if sel="00000100" then
       ref_clk	<=	asig and clkcounter(3);       
            
      
      else if sel="00000101" then
       ref_clk	<=	asig and clkcounter(4);       
               
       
      else if sel="00000110" then
       ref_clk	<=	asig and clkcounter(5);       
     

      else if sel="00000111" then
       ref_clk	<=	asig and clkcounter(6);       
        
       
      else if sel="00001000" then
       ref_clk	<=	asig and clkcounter(7);       
       
      else if sel="00001001" then
       ref_clk	<=	asig and clkcounter(8);       

       
      else if sel="00001010" then
       ref_clk	<=	asig and clkcounter(9);       
      
       
      else if sel="00001011" then
       ref_clk	<=	asig and clkcounter(10);  
                  
  
      else if sel="00001100" then
       ref_clk	<=	asig and clkcounter(11);       
      
      
      else if sel="00001101" then
       ref_clk	<=	asig and clkcounter(12);       
       
       
      else if sel="00001110" then
       ref_clk	<=	asig and clkcounter(13);       

       
      else if sel="00001111" then
       ref_clk	<=	asig and clkcounter(14);       
       
       
      else if sel="00010000" then
       ref_clk	<=	asig and clkcounter(15);       
       
       
      else if sel="00010001" then
       ref_clk	<=	asig and clkcounter(16);     
       
       
      else if sel="00010010" then
       ref_clk	<=	asig and clkcounter(17); 
       
       
      else if sel="00010011" then
       ref_clk	<=	asig and clkcounter(18); 
       
       
      else 
       ref_clk	<=	asig and clkcounter(19);               
       end if;                                                                                           

end if;
end if;
end if;
end if;
end if;
end if;
end if;
end if;
end if;
end if;
end if;
end if;
end if;
end if;
end if; 
end if;    
end if; 
end if;      
end if;
end process data_selector; 

   
end behave;   


