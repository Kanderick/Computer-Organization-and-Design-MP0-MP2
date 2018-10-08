library verilog;
use verilog.vl_types.all;
library work;
entity cmp is
    port(
        cmpop           : in     work.rv32i_types.branch_funct3_t;
        op1             : in     vl_logic_vector(31 downto 0);
        op2             : in     vl_logic_vector(31 downto 0);
        br_en           : out    vl_logic
    );
end cmp;
