----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/28/2024 08:06:31 PM
-- Design Name: 
-- Module Name: picture_top - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity picture_top is
Port ( 

clk :in std_logic;
vga_hs, vga_vs: out std_logic;
vga_r, vga_b: out std_logic_vector (4 downto 0);
vga_g: out std_logic_vector (5 downto 0)


);
end picture_top;

architecture Behavioral of picture_top is

component picture is 

port(

    clka : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)


);

end component;

component clock_div is 

port (
    clk: in std_logic;
    en: out std_logic 
);

end component; 

component pixel_pusher is 

port(

    clk, en, VS:in std_logic;
    pixel: in std_logic_vector (7 downto 0); 
    hcount : in std_logic_vector (9 downto 0);
    vid: in std_logic;
    R,B :out std_logic_vector (4 downto 0);
    G :out std_logic_vector (5 downto 0);
    addr: out std_logic_vector (17 downto 0)
);

end component; 

component vga_ctrl is 
    
Port ( 

clk, en: in std_logic; 
HS, VS, Vid: out std_logic;
hcountt: out std_logic_vector (9 downto 0);
vcountt: out std_logic_vector (9 downto 0)

);

end component; 

signal div : std_logic;
signal addr: std_logic_vector (17 downto 0) ;
signal pixel: std_logic_vector (7 downto 0) ;
signal vid, VS: std_logic;
signal hcount, vcount: std_logic_vector (9 downto 0);


begin

U0: clock_div 

port map(

clk => clk,
en => div

);

U1: picture 

port map (

    clka => clk, 
    addra => addr,
    douta => pixel
    

);

U2: pixel_pusher 

port map (

clk => clk,
en => div, 
pixel => pixel,
addr => addr, 
R => vga_r,
G => vga_g,
B => vga_b,
hcount => hcount,
vid => vid,
VS => VS

);

U3: vga_ctrl 

port map (

clk => clk,
en => div, 
HS => vga_hs,
VS => vga_vs, 
Vid => vid,
hcountt => hcount,
vcountt => vcount

);



end Behavioral;
