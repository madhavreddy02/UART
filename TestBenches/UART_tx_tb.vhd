library ieee;
use ieee.std_logic_1164.all;
entity UART_tx_tb is 
generic
(
RS232_DATA_BITS : integer := 8;
SYSTEM_CLOCK_FREQ : integer := 50000000;
BAUD_RATE:integer := 115200
);
end entity;

architecture rtl of UART_tx_tb is 
component UART_tx is 
generic
(
RS232_DATA_BITS : integer;
SYSTEM_CLOCK_FREQ : integer;
BAUD_RATE:integer
);
port 
(
clk : in std_logic;
rst : in std_logic;
TxStart : in std_logic;
TxData : in  std_logic_vector (RS232_DATA_BITS -1 downto 0);
TxReady : out std_logic;
UART_tx_pin : out std_logic
);
end component;

signal clk :  std_logic:='0';
signal rst :  std_logic;
signal TxStart :  std_logic;
signal TxData :   std_logic_vector (RS232_DATA_BITS -1 downto 0);
signal TxReady :  std_logic;
signal UART_tx_pin :  std_logic;

begin
clk <= not clk after 10ns;

UUT:UART_tx 
generic map
(
RS232_DATA_BITS => RS232_DATA_BITS,
SYSTEM_CLOCK_FREQ => SYSTEM_CLOCK_FREQ ,
BAUD_RATE =>  BAUD_RATE
)
port map
(
clk => clk,
rst => rst,
TxStart => TxStart,
TxData => TxData,
TxReady => TxReady,
UART_tx_pin => UART_tx_pin
);

 TestProcess: process
 begin
     
	 rst <= '1';
	 TxStart <= '0';
	 TxData <= (others => '0');
	 wait for 100ns;
	 rst <= '0';
	 wait for 100ns;
	    wait until rising_edge(clk);
	     TxStart <= '1';
		 TxData <= x"AA";
		 wait until rising_edge(clk);
	     TxStart <= '0';
		 TxData <= x"00";
		
		
	 wait;
 end process;

end rtl;