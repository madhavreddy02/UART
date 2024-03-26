----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.03.2024 21:34:04
-- Design Name: 
-- Module Name: baudClkGenarator - Behavioral
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

entity baudClkGenarator is
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
end baudClkGenarator;

architecture Behavioral of baudClkGenarator is
constant BIT_PERIOD : integer := SYSTEM_CLOCK_FREQ/BAUD_RATE;
signal bitPeriodCounter : integer range 0 to BIT_PERIOD;
signal clockLeft : integer range 0 to NUMBER_OF_CLOCKS;

begin
baudClkGenarator: process(rst,clk)
begin
if rst='1' then 
     bitPeriodCounter <= 0;
     baudClk <= '0';
else 
     if (rising_edge(clk)) then
     if (clockLeft > 0) then 
        if(BIT_PERIOD=bitPeriodCounter) then 
            bitPeriodCounter <= 0;
            baudClk <= '1';
        else
            bitPeriodCounter <= bitPeriodCounter + 1;
            baudClk <= '0';
        end if;
     else 
          bitPeriodCounter <= 0;
          baudClk <= '0';
     end if;  
     end if;
end if;
end process;

BeginOrEndBaudClk: process(rst,clk)
begin
if rst='1' then
    clockLeft <= 0;
else 
     if (rising_edge(clk)) then
        if(start = '1') then 
        clockLeft <= NUMBER_OF_CLOCKS;
        elsif (baudClk = '1') then 
        clockLeft <= clockLeft - 1;
        end if;
     end if;
end if;
end process;

genarateReady: process(rst,clk)
begin 
     if rst = '1' then 
        ready <= '0';
     elsif rising_edge(clk) then 
        if start = '1' then 
           ready <= '0';
        elsif clockLeft = 0 then 
           ready <= '1';
        end if;
     end if;
end process;
end Behavioral;
