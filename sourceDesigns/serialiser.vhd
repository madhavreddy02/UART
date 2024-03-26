library ieee;
use ieee.std_logic_1164.all;
entity serialiser is 
generic
(
DATA_WIDTH : integer  ;
DEFAULT_STATE : std_logic
);
port 
(
clk : in std_logic;
rst : in std_logic;
load : in std_logic;
shiftEn : in std_logic;
din : in std_logic_vector ( DATA_WIDTH -1 downto 0);
dout : out std_logic
);
end entity;

architecture rtl of serialiser is 

signal shiftRegister : std_logic_vector(DATA_WIDTH -1 downto 0);

begin 

dout <= shiftRegister(0);
serialiser: process(rst,clk)
begin 
     if rst = '1' then 
	    shiftRegister <= (others => DEFAULT_STATE);
	 elsif rising_edge(clk) then 
	      if load = '1' then 
		      shiftRegister <= din;
		  elsif shiftEn = '1' then 		  
		      shiftRegister <= DEFAULT_STATE & shiftRegister(shiftRegister'left downto 1);  
		  end if;
	 end if;
end process;


end rtl;