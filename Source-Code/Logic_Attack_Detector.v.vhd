Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity Logic_Attack_Detector is
    port(clk,clr : in std_logic;
        a,b,c,d: in std_logic;
        config: in std_logic_vector(3 downto 0);
        y: out std_logic_vector(6 downto 0));
end Logic_Attack_Detector;

architecture behave of Logic_Attack_Detector is
   COMPONENT Attack_gen is
   port(clk,clr: in std_logic;
   config : in std_logic_vector(3 downto 0);
    Attack_Insert: out std_logic_vector(6 downto 0));
   end COMPONENT;
   
   COMPONENT Clock_Synth is
   port(clk,clr,a,b,c,d: in std_logic;
       ykk:in std_logic_vector(6 downto 0);
   y,yss: out std_logic_vector(6 downto 0));
   end COMPONENT;
   
   COMPONENT BENCHMARK_CKT1 is
   port(clk,clr,aa,ba,ca,da: in std_logic;
   ya: out std_logic);
   end COMPONENT;
   
   COMPONENT BENCHMARK_CKT2 is
   port(clk,clr,a,b,c,d: in std_logic;
   yu: out std_logic);
   end COMPONENT;    
   
   COMPONENT delay_detector is
    port(fin,fref : in std_logic;
        lock: out std_logic;
        up,down : out std_logic);
   end COMPONENT;
   
signal    ai:std_logic_vector(6 downto 0);
signal    yk,ys,ysk:std_logic_vector(6 downto 0);
signal    sg,tc1,tc2,tc3,tc4,tc5,tc6: std_logic;
signal    cnt: std_logic_vector(3 downto 0);
signal    cntt: integer;
signal    VCheck: string(1 to 10);
signal    sk1,sk2,sk3,sk4,sk5,sk6,skk: std_logic_vector(3 downto 0);
signal    yo2,yo3,locka,upa,downa,dnode:  std_logic;
begin
AttackGen   : Attack_gen port map(clk,clr,config,ai);
TestCkt     : Clock_Synth port map(clk,yk(6),a,b,c,d,yk,ys,ysk);  
TestCkt2    : BENCHMARK_CKT1 port map (clk,dnode,a,b,c,d,yo2);
TestCkt3    : BENCHMARK_CKT2 port map (clk,dnode,ys(6),b,ys(5),d,yo3);
Latency_Attack_detector    : delay_detector port map(yo2,yo3,locka,upa,downa);

-- Fetch Attack
tc1<=( config(0)) and (not config(1)) and (not config(2)) and (not config(3));
tc2<=(not config(0)) and ( config(1)) and (not config(2)) and (not config(3));
tc3<=(not config(0)) and (not config(1)) and ( config(2)) and (not config(3));
tc4<=(not config(0)) and (not config(1)) and (not config(2)) and ( config(3));
tc5<=(config(0)) and (config(1)) and (not config(2)) and ( not config(3));
tc6<=(not config(0)) and ( config(1)) and ( config(2)) and (not config(3));

FA:process(clk,clr)
begin
    if clr='1' then
        yk<="0000000";        
      elsif rising_edge(clk) then
          yk<=ai;
      end if;
end process FA;

-- Test Validator
TV: process(clk,clr)
begin
    if clr='1' then       
        cnt<="0000";
        elsif falling_edge(clk) then
            cnt<=cnt+1;
            sg<='1';
            if cnt>"0111" then
                sg<='0';
            end if;
        end if;
end process TV;    


AttackDetector: process(clk,clr,ysk,tc1)
begin
    if clr='1' or tc1='0' then       
        cntt<=0;
        sk1<="0000";
        elsif falling_edge(clk) then            
                cntt<=cntt+1;
                if cntt>10000 then
                    sk1<="0001";
                end if;
                       
                            
        end if;
end process AttackDetector;

pp:process(clk,clr,tc2)
begin
    if clr='1' or tc2='0'then
        sk2<="0000";
        elsif rising_edge(clk) then
         if (ys and (not ysk)) > "0000000" then
                sk2<="0010";
            end if; 
end if;
end process pp;

-- The below process acts as a positive edge triggered flip flop which detect the
-- occurence of attack insert triggered by the majority check AND-DECODER and reflect 
-- the changes in sk3
pp2:process(clk,clr,tc3)
begin
    if clr='1' or tc3='0' then
        sk3<="0000";
        elsif rising_edge(clk) then
                sk3<="0100";
      end if;
end process pp2;
-- The below process acts as a positive edge triggered flip flop which detect the
-- occurence of attack insert triggered by the majority check AND-DECODER and reflect 
-- the changes in sk4
pp3:process(clk,clr,tc4)
begin
    if clr='1' or tc4='0' then
        sk4<="0000";
        elsif rising_edge(clk) then
                sk4<="0101";
      end if;
end process pp3;

-- The below process acts as a positive edge triggered flip flop which detect the
-- occurence of attack insert triggered by the majority check AND-DECODER and reflect 
-- the changes in sk5

pp55:process(clk,clr,tc5)
begin
    if clr='1' or tc5='0' then
        sk5<="0000";
        elsif rising_edge(clk) then
                sk5<="0110";
      end if;
end process pp55;
-- The below process acts as a positive edge triggered flip flop which detect the
-- occurence of attack insert triggered by the majority check AND-DECODER and reflect 
-- the changes in sk6
pp66:process(clk,clr,tc6)
begin
    if clr='1' or tc6='0' then
        sk6<="0000";
        elsif rising_edge(clk) then
                sk6<="0111";
      end if;
end process pp66;
-- The Encoder below encodes the attacks inserted and make the LUT selection appropriatey
-- for making the notification

skk<=sk1 or sk2 or sk3 or sk4 or sk5 or sk6;
-- The clocked LUT (Look up Table) displays the attack names
AttackNotifier:process(clk,clr,skk)
begin
    if clr='1' then
        VCheck<="Normal****";
        elsif falling_edge(clk) then
            case skk is
                when "0001"=>VCheck<="ProbAttack";
                when "0010"=>VCheck<="CorrAttack";
                when "0100"=>VCheck<="forbidAttk";
                when "0101"=>VCheck<="ReplayATK*";
                when "0110"=>VCheck<="DeadNode**";
                when "0111"=>VCheck<="Side_Chan*";                                    
                when others=> VCheck<="Normal****";
            end case;
        end if;
    end process AttackNotifier;   
    y<=ysk;    
    dnode<=skk(1) and skk(2);                         
end behave;    



