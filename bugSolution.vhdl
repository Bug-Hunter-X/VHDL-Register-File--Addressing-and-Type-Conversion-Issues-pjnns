```vhdl
ENTITY register_file_fixed IS
  GENERIC (data_width : INTEGER := 32; address_width : INTEGER := 5);
  PORT (
    clk : IN STD_LOGIC;
    wr_en : IN STD_LOGIC;
    wr_addr : IN STD_LOGIC_VECTOR(address_width-1 DOWNTO 0);
    wr_data : IN STD_LOGIC_VECTOR(data_width-1 DOWNTO 0);
    rd_addr1 : IN STD_LOGIC_VECTOR(address_width-1 DOWNTO 0);
    rd_addr2 : IN STD_LOGIC_VECTOR(address_width-1 DOWNTO 0);
    rd_data1 : OUT STD_LOGIC_VECTOR(data_width-1 DOWNTO 0);
    rd_data2 : OUT STD_LOGIC_VECTOR(data_width-1 DOWNTO 0);
    error : OUT STD_LOGIC  -- Added error signal
  );
END ENTITY;

ARCHITECTURE behavioral OF register_file_fixed IS
  TYPE register_array IS ARRAY (0 TO (2**address_width)-1) OF STD_LOGIC_VECTOR(data_width-1 DOWNTO 0);
  SIGNAL registers : register_array := (OTHERS => (OTHERS => '0'));
  SIGNAL wr_addr_int : INTEGER;
  SIGNAL rd_addr1_int : INTEGER;
  SIGNAL rd_addr2_int : INTEGER;
BEGIN
  --Convert addresses to integers and check the range
  wr_addr_int <= to_integer(unsigned(wr_addr));
  rd_addr1_int <= to_integer(unsigned(rd_addr1));
  rd_addr2_int <= to_integer(unsigned(rd_addr2));

  error <= '1' WHEN (wr_addr_int >= (2**address_width) OR rd_addr1_int >= (2**address_width) OR rd_addr2_int >= (2**address_width)) ELSE '0';

  register_process : PROCESS (clk)
  BEGIN
    IF rising_edge(clk) THEN
      IF wr_en = '1' AND wr_addr_int < (2**address_width) THEN
        registers(wr_addr_int) <= wr_data;
      END IF;
    END IF;
  END PROCESS;

  rd_data1 <= registers(rd_addr1_int) WHEN rd_addr1_int < (2**address_width) ELSE (others => '0');
  rd_data2 <= registers(rd_addr2_int) WHEN rd_addr2_int < (2**address_width) ELSE (others => '0');
END ARCHITECTURE; 
```