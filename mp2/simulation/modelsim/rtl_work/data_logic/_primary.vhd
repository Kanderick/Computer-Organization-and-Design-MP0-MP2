library verilog;
use verilog.vl_types.all;
entity data_logic is
    port(
        data_out        : in     vl_logic_vector(255 downto 0);
        index           : in     vl_logic_vector(4 downto 0);
        mem_byte_enable : in     vl_logic_vector(3 downto 0);
        mem_wdata       : in     vl_logic_vector(31 downto 0);
        mem_rdata       : out    vl_logic_vector(31 downto 0);
        data_cache      : out    vl_logic_vector(255 downto 0)
    );
end data_logic;
