library verilog;
use verilog.vl_types.all;
entity pmem_address_logic is
    port(
        lru             : in     vl_logic;
        tag_0           : in     vl_logic_vector(23 downto 0);
        tag_1           : in     vl_logic_vector(23 downto 0);
        set             : in     vl_logic_vector(2 downto 0);
        pmem_addr_sel   : in     vl_logic;
        mem_address     : in     vl_logic_vector(31 downto 0);
        pmem_address    : out    vl_logic_vector(31 downto 0)
    );
end pmem_address_logic;
