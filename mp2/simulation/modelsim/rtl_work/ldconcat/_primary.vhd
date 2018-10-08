library verilog;
use verilog.vl_types.all;
entity ldconcat is
    port(
        mdr_out         : in     vl_logic_vector(31 downto 0);
        funct3          : in     vl_logic_vector(2 downto 0);
        ldconcat_out    : out    vl_logic_vector(31 downto 0)
    );
end ldconcat;
