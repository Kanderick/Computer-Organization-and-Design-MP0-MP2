import rv32i_types::*;

module datapath
(
    input clk,

    /* control signals */
    input pcmux_sel,
    input load_pc,

    /* declare more ports here */
	 input cmpmux_sel, 
	 input marmux_sel, 
	 input alumux1_sel,
	 input load_mar, 
	 input load_mdr, 
	 input load_ir, 
	 input load_regfile,
	 input load_mem_data_out,
	 input rv32i_word mem_rdata,
	 input [1:0] regfilemux_sel,
	 input [1:0] alumux2_sel,
	 input alu_ops aluop,
	 input branch_funct3_t cmpop,
	 
	 
	 output rv32i_word mem_address,
	 output logic [2:0] out_funct3,
	 output logic [6:0] out_funct7,
	 output rv32i_opcode out_opcode,
	 output rv32i_word mem_wdata,
	 output logic out_br_en
	 
);

/* declare internal signals */
rv32i_word pcmux_out;
rv32i_word pc_out;
rv32i_word alu_out;
rv32i_word pc_plus4_out;

rv32i_word i_imm, s_imm, b_imm, u_imm, j_imm;
rv32i_reg rs1, rs2, rd;
rv32i_word rs2_out, cmpmux_out; /*for cmpmux*/
rv32i_word marmux_out;	/*for MAR*/
rv32i_word mdr_out;
rv32i_word regfilemux_out;
rv32i_word rs1_out;
rv32i_word alumux1_out, alumux2_out;







/*cmpmux*/
mux2 #(.width(32)) cmpmux
(
.sel(cmpmux_sel),
.a(rs2_out),
.b(i_imm),
.f(cmpmux_out)
);

/*
 * PC
 */
mux2 #(.width(32)) pcmux
(
    .sel(pcmux_sel),
    .a(pc_plus4_out),
    .b(alu_out),
    .f(pcmux_out)
);

add4 #(.width(32)) pc_add4
(
	.a(pc_out),
	.f(pc_plus4_out)
);

pc_register #(.width(32)) pc
(
    .clk,
    .load(load_pc),
    .in(pcmux_out),
    .out(pc_out)
);

/*MAR*/

mux2 #(.width(32)) marmux
(
	.sel(marmux_sel),
	.a(pc_out),
	.b(alu_out),
	.f(marmux_out)
);

register #(.width(32)) mar
(
	.clk,
	.load(load_mar),
	.in(marmux_out),
	.out(mem_address)
);

/*MDR*/
register #(.width(32)) mdr
(
	.clk,
	.load(load_mdr),
	.in(mem_rdata),
	.out(mdr_out)
);

/*mem_data_out*/
register #(.width(32)) mem_data_out
(
	.clk,
	.load(load_mem_data_out),
	.in(rs2_out),
	.out(mem_wdata)
);

/*IR*/
ir IR
(
	.clk,
	.load(load_ir),
	.in(mdr_out),
	.funct3(out_funct3),
	.funct7(out_funct7),
	.opcode(out_opcode),
	.i_imm,
	.s_imm,
	.b_imm,
	.u_imm,
	.j_imm,
	.rs1,
	.rs2,
	.rd
);

/*REGFILE*/
mux4 #(.width(32)) regfilemux
(
	.sel(regfilemux_sel),
	.a(alu_out),
	.b({31'h00000000, out_br_en}),
	.c(u_imm),
	.d(mdr_out),
	.f(regfilemux_out)
);

regfile regfile
(
	.clk,
	.load(load_regfile),
	.in(regfilemux_out),
	.src_a(rs1),
	.src_b(rs2),
	.dest(rd),
	.reg_a(rs1_out),
	.reg_b(rs2_out)
);

/*ALU*/

mux2 #(.width(32)) alumux1
(
	.sel(alumux1_sel),
	.a(rs1_out),
	.b(pc_out),
	.f(alumux1_out)
);

mux4 #(.width(32)) alumux2
(
	.sel(alumux2_sel),
	.a(i_imm),
	.b(u_imm),
	.c(b_imm),
	.d(s_imm),
	.f(alumux2_out)
);

alu the_alu
(
	.aluop,
	.a(alumux1_out),
	.b(alumux2_out),
	.f(alu_out)
);

/*CMP*/
cmp the_cmp
(
	.cmpop,
	.op1(rs1_out),
	.op2(cmpmux_out),
	.br_en(out_br_en)
);

endmodule : datapath
