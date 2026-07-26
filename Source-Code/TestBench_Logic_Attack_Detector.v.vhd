LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;


ENTITY TestBench_LAD IS
END TestBench_LAD;

ARCHITECTURE behavior OF TestBench_LAD IS

COMPONENT Logic_Attack_Detector is
    port(clk,clr : in std_logic;
        a,b,c,d: in std_logic;
        config: in std_logic_vector(3 downto 0);
        y: out std_logic_vector(6 downto 0));
end COMPONENT;


   signal clk : std_logic := '0';
   signal clr : std_logic := '1';
   signal a,b,c,d:std_logic := '0';
   signal y:  std_logic_vector(6 downto 0);     
SIGNAL    config: std_logic_vector(3 downto 0);
   constant clk_period  : time := 100 ps;
      constant clk_period1  : time := 1000 ps;
  
BEGIN

TB_LAD: Logic_Attack_Detector PORT MAP (clk,clr,a,b,c,d,config,y);    

   clk_process :process
   begin
        clk <= '0';
        wait for clk_period/2;  --for 0.5 ns signal is '0'.
        clk <= '1';
        wait for clk_period/2;  --for next 0.5 ns signal is '1'.
   end process;
   
   
   -- Stimulus process
  stim_proc: process
   begin        
        wait for 700 ps;
        clr <='1';
        wait for 300 ps;
        clr <='0';        
        wait;
  end process;
  
  
  stim_proc_2: process
   begin        
        wait for 50 ps;
        a <='0';b<='0';c<='0';d<='0';
        wait for 100 ps;
        a <='0';b<='0';c<='0';d<='1';
        wait for 100 ps;
        a <='0';b<='0';c<='1';d<='0';
        wait for 100 ps;
        a <='0';b<='0';c<='1';d<='1';
        wait for 100 ps;
        a <='0';b<='1';c<='0';d<='0';
        wait for 100 ps;
        a <='0';b<='1';c<='0';d<='1';
        wait for 100 ps;
        a <='0';b<='1';c<='1';d<='0';                                        
        wait for 100 ps;
        a <='0';b<='1';c<='1';d<='1';                                        
        wait for 100 ps;
        a <='1';b<='0';c<='0';d<='0';                                        
        wait for 100 ps;
        a <='1';b<='0';c<='0';d<='1';                                        
        wait for 100 ps;
        a <='1';b<='1';c<='0';d<='0';                                                                        
        wait for clk_period/2;
  end process stim_proc_2;
  
  stim_procGG: process
   begin        
        wait for 5000 ps;
        config <="0000";
        wait for 5000 ps;
        config <="0001"; 
        wait for 5000 ps;
        config <="0000";        
        wait for 5000 ps;
        config <="0010";
        wait for 5000 ps;
        config <="0000";        
        wait for 5000 ps;
        config <="0100"; 
        wait for 5000 ps;
        config <="0000";                             
        wait for 5000 ps;
        config <="1000"; 
        wait for 5000 ps;
        config <="0000";        
        wait for 5000 ps;
        config <="0011"; 
        wait for 5000 ps;
        config <="0000";        
        wait for 5000 ps;
        config <="0110";
        wait for 5000 ps;
        config <="0000";                                 
  end process stim_procGG;
  
 END;
 
 
 
