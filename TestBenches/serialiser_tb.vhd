library ieee;
use ieee.std_logic_1164.all;
entity serialiser_tb is
generic
( 
DATA_WIDTH : integer := 8;
DEFAULT_STATE : std_logic := '1'
);
end serialiser_tb;

architecture rtl of serialiser_tb is 

component  serialiser is 
generic 
(
DATA_WIDTH : integer ;
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
end component;
--constant DATA_WIDTH : integer := 8;	
signal clk :  std_logic:= '0';
signal rst :  std_logic;
signal load :  std_logic;
signal shiftEn :  std_logic;
signal din :  std_logic_vector ( DATA_WIDTH -1 downto 0);
signal dout :  std_logic;

begin 
clk <= not clk after 10ns; 

UUT : serialiser
generic map
(
DATA_WIDTH => DATA_WIDTH,
DEFAULT_STATE => '1'
)
port map
(
clk => clk,
rst => rst,
load => load,
shiftEn => shiftEn,
din => din,
dout => dout
);
 
    TestProcess : process
	 begin
	    rst <= '1';
		load <= '0';
		shiftEn<='0';
	    din <= (others => '0');
		wait for 100ns;
		rst <= '0';
		wait for 100ns;
		
		wait until rising_edge(clk);
		load <= '1';
		din <= x"AA";
		wait until rising_edge(clk);
		load <= '0';
		din <= (others => '0');
		
		
		for i in 0 to 7 loop 
		wait for  8.7us;
		wait until rising_edge(clk);
		shiftEn <= '1';
		wait until rising_edge(clk);
		shiftEn <= '0';
		end loop;
	 
	 
	 
	 
	 
	 wait;
	 end process;


end rtl;