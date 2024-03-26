library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity baudClkGenarator_tb is
end baudClkGenarator_tb;

architecture rtl of baudClkGenarator_tb is 
component baudClkGenarator is
generic
(
NUMBER_OF_CLOCKS : integer;
SYSTEM_CLOCK_FREQ : integer ;
BAUD_RATE : integer

);
Port
 (
 clk : in std_logic;
 rst : in std_logic;
 start : in std_logic;
 baudClk : out std_logic;
 ready : out std_logic
 );
end component;

signal clk : std_logic := '0';
signal rst : std_logic;
signal start : std_logic;
signal baudClk: std_logic;
signal ready: std_logic;
begin 
clk <= not clk after 10ns;
UUT: baudClkGenarator 
generic map
(
NUMBER_OF_CLOCKS  => 10,
SYSTEM_CLOCK_FREQ => 50000000 ,
BAUD_RATE         => 115200

)
Port map
 (
 clk => clk,
 rst => rst,
 start => start,
 baudClk => baudClk,
 ready => ready
 );
 
   main: process
   begin 
   rst <= '1';
   start <= '0';
   wait for 100ns;
   rst <= '0';
   wait until rising_edge(clk);
   start <= '1';
    wait until rising_edge(clk);
   start <= '0';
   wait;
   end process;


end rtl;
