library ieee;
use ieee.std_logic_1164.all;
entity UART_tx is 
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
end entity;

architecture rtl of UART_tx is 

component serialiser is 
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
end component;

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
signal TxPacket : std_logic_vector(RS232_DATA_BITS + 1 downto 0);
signal baudClk : std_logic;

begin
 
TxPacket <= '1'&TxData&'0';

 UART_Serialiser_INST: serialiser 
generic map
(
DATA_WIDTH  => RS232_DATA_BITS + 2 ,
DEFAULT_STATE => '1'
)
port map
(
clk => clk,
rst => rst,
load => TxStart,
shiftEn => baudClk,
din => TxPacket,
dout => UART_tx_pin 
);


UART_BIT_TIMING_INST: baudClkGenarator 
generic map
(
NUMBER_OF_CLOCKS  => RS232_DATA_BITS + 2,
SYSTEM_CLOCK_FREQ  => SYSTEM_CLOCK_FREQ,
BAUD_RATE  => BAUD_RATE

)
Port map
 (
 clk => clk,
 rst => rst,
 start => TxStart,
 baudClk => baudClk,
 ready => TxReady
 );


end rtl;