----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/27/2024 04:27:31 PM
-- Design Name: 
-- Module Name: vga_ctrl - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vga_ctrl is
Port ( 

clk, en: in std_logic; 
HS, VS, Vid: out std_logic;
hcountt: out std_logic_vector (9 downto 0);
vcountt: out std_logic_vector (9 downto 0)

);
end vga_ctrl;

architecture Behavioral of vga_ctrl is

signal hcount :std_logic_vector (9 downto 0) := (others => '0');
signal vcount :std_logic_vector (9 downto 0) := (others => '0');


begin

process(clk)
begin 
    if(rising_edge(clk)) then 
    
        if( en = '1' ) then 
            
            if ( unsigned(hcount) < 800) then 
                
                hcount <= std_logic_vector (unsigned(hcount) + 1);
                
                if ( unsigned(hcount) >  654 and unsigned(hcount) < 751) then 
                
                    HS <= '0';
                    
                else  
                
                    HS <= '1';
                    
                end if; 
                    
            else 
            
            vcount <= std_logic_vector (unsigned(vcount) +1);
                
            
            if ( unsigned(vcount) < 525) then 
            
                
                    if(unsigned(vcount) > 488 and unsigned(vcount) < 491) then
                    
                        VS <= '0';
                        
                    else 
                    
                        VS <= '1';
                        
                    end if;
                    
                hcount <= (others => '0');
                
            else
            
                vcount <= (others => '0');
                
            end if;  
            
       end if;
       
       
   end if; 
   
   
end if; 
   
end process; 
            

process(clk) 

begin 

    if (rising_edge (clk)) then 
    

    if ( unsigned(hcount) < 639 and unsigned(vcount) < 480) then 
    
         vid <= '1';
         
    else 
    
         vid <= '0';
         
    end if; 
    
    end if; 
    
end process; 
        
hcountt <= hcount;
vcountt <= vcount; 

end Behavioral;
