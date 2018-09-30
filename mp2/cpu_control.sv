import rv32i_types::*; /* Import types defined in rv32i_types.sv */

module cpu_control
(
    /* Input and output port declarations */

	 /*Datapath Control*/
	 input clk,
	 input rv32i_opcode opcode,
	 input logic[2:0] funct3,
	 input logic[6:0] funct7,
	 input logic br_en,
	 
	 output logic [1:0] pcmux_sel,
	 output logic cmpmux_sel, 
	 output logic marmux_sel, 
	 output logic alumux1_sel,
	 output logic load_pc,
	 output logic load_mar,
	 output logic load_mdr,
	 output logic load_ir,
	 output logic load_regfile,
	 output logic load_mem_data_out,
	 output logic [2:0] regfilemux_sel,
	 output logic [2:0] alumux2_sel,
	 output alu_ops aluop,
	 output branch_funct3_t cmpop,
	 
	 /*Memory Signals*/
	 input mem_resp,
	 output logic mem_read,
	 output logic mem_write,
	 output rv32i_mem_wmask mem_byte_enable
);

enum int unsigned {
    /* List of states */
	 fetch1,
	 fetch2,
	 fetch3,
	 decode,
	 s_imm,
	 s_lui,
	 calc_addr,
	 s_auipc,
	 br,
	 ldr1,
	 ldr2,
	 str1,
	 str2,
	 s_jal,
	 s_jalr,
	 s_reg
} state, next_state;

always_comb
begin : state_actions
    /* Default output assignments */
	 load_pc = 1'b0;
	 load_ir = 1'b0;
	 load_regfile = 1'b0;
	 load_mar = 1'b0;
	 load_mdr = 1'b0;
	 load_mem_data_out = 1'b0;
	 pcmux_sel = 2'b0;
	 cmpop = branch_funct3_t'(funct3);
	 alumux1_sel = 1'b0;
	 alumux2_sel = 3'b0;
	 regfilemux_sel = 3'b0;
	 marmux_sel = 1'b0;
	 cmpmux_sel = 1'b0;
	 aluop = alu_ops'(funct3);
	 mem_read = 1'b0;
	 mem_write = 1'b0;
	 mem_byte_enable = 4'b1111;
	 
    /* Actions for each state */
	 case(state)
		default:;
		
		fetch1:
		begin
				load_mar = 1;
		end
		
		fetch2:
		begin
			mem_read = 1;
			load_mdr = 1;
		end
		
		fetch3:
		begin
			load_ir = 1;
		end
		
		decode:;
		
		s_imm:
		begin
			case(funct3)
			
				default:
				begin
					load_regfile = 1;
					load_pc = 1;
					aluop = alu_ops'(funct3);
				end
				
				slt:
				begin
					load_regfile = 1;
					load_pc = 1;
					cmpop = branch_funct3_t'(blt);
					regfilemux_sel = 1;
					cmpmux_sel = 1;
				end
				
				sltu:
				begin
					load_regfile = 1;
					load_pc = 1;
					cmpop = branch_funct3_t'(bltu);
					regfilemux_sel = 1;
					cmpmux_sel = 1;
				end
				
				sr:
				begin
					/*SRAI*/
					if (funct7[5] == 1)
					begin
						load_regfile = 1;
						load_pc = 1;
						aluop = alu_sra;
					end
					
					/*SRLI*/
					else
					begin
						load_regfile = 1;
						load_pc = 1;
						aluop = alu_srl;
					end
				end
			endcase
		end
		
		br:
		begin
			pcmux_sel = br_en;
			load_pc = 1;
			alumux1_sel = 1;
			alumux2_sel = 2;
			aluop = alu_add;
		end
		
		s_auipc:
		begin
			load_regfile = 1;
			alumux1_sel = 1;
			alumux2_sel = 1;
			aluop = alu_add;
			load_pc = 1;
		end
		
		s_lui:
		begin
			load_regfile = 1;
			load_pc = 1;
			regfilemux_sel = 2;
		end
		
		calc_addr:
		begin
			case(opcode)
				default:;
				
				/*LW*/
				op_load:
				begin
					aluop = alu_add;
					load_mar = 1;
					marmux_sel = 1;
				end
				
				/*SW*/
				op_store:
				begin
					alumux2_sel = 3;
					aluop = alu_add;
					load_mar = 1;
					load_mem_data_out = 1;
					marmux_sel = 1;
				end
			endcase
		end
		
		ldr1:
		begin
			load_mdr = 1;
			mem_read = 1;
		end
		
		ldr2:
		begin
			regfilemux_sel = 3;
			load_regfile = 1;
			load_pc = 1;
		end
		
		str1:
		begin
			mem_write = 1;
			case(funct3)
				default:;
				
				3'b000: mem_byte_enable = 4'b0001;
				
				3'b001: mem_byte_enable = 4'b0011;
			endcase
		end
		
		str2:
		begin
			load_pc = 1;
		end
		
		s_jal:
		begin
			alumux1_sel = 1;
			alumux2_sel = 4;
			pcmux_sel = 1;
			load_pc = 1;
			regfilemux_sel = 4;
			load_regfile = 1;
		end
		
		s_jalr:
		begin
			pcmux_sel = 2;
			load_pc = 1;
			regfilemux_sel = 4;
			load_regfile = 1;
		end
		
		s_reg:
		begin
			case(funct3)
			
				default:
				begin
					load_regfile = 1;
					load_pc = 1;
					alumux2_sel = 5;
					aluop = alu_ops'(funct3);
				end
				
				slt:
				begin
					load_regfile = 1;
					load_pc = 1;
					cmpop = branch_funct3_t'(blt);
					regfilemux_sel = 1;
				end
				
				sltu:
				begin
					load_regfile = 1;
					load_pc = 1;
					cmpop = branch_funct3_t'(bltu);
					regfilemux_sel = 1;
				end
				
				add:
				begin
					/*SUB*/
					if (funct7[5] == 1)
					begin
						load_regfile = 1;
						load_pc = 1;
						alumux2_sel = 5;
						aluop = alu_sub;
					end
					
					/*ADD*/
					else
					begin
						load_regfile = 1;
						load_pc = 1;
						alumux2_sel = 5;
						aluop = alu_add;
					end
				end
				
				sr:
				begin
					/*SRA*/
					if (funct7[5] == 1)
					begin
						load_regfile = 1;
						load_pc = 1;
						alumux2_sel = 5;
						aluop = alu_sra;
					end
					
					/*SRL*/
					else
					begin
						load_regfile = 1;
						load_pc = 1;
						alumux2_sel = 5;
						aluop = alu_srl;
					end
				end
			endcase
		end
		
	endcase
end

always_comb
begin : next_state_logic
    /* Next state information and conditions (if any)
     * for transitioning between states */
	next_state = state;
	case(state)
			default: next_state = fetch1;
			
			fetch1: next_state = fetch2;
			
			fetch2: if (mem_resp) next_state = fetch3;
			
			fetch3: next_state = decode;

			decode:
			begin
				case(opcode)
					default: $display("Unknown opcode");
					
					op_auipc: next_state = s_auipc;
					
					op_lui: next_state = s_lui;
					
					op_br: next_state = br;
					
					op_load, op_store: next_state = calc_addr;
					
					op_imm: next_state = s_imm;
					
					op_jal: next_state = s_jal;
					
					op_jalr: next_state = s_jalr;
					
					op_reg: next_state = s_reg;
				endcase
			end
			
			calc_addr:
			begin
				case(opcode)
					default:
					
					op_load: next_state = ldr1;
					
					op_store: next_state = str1;
				endcase
			end
			
			ldr1: if (mem_resp) next_state = ldr2;
			
			str1: if (mem_resp) next_state = str2;
	endcase
end

always_ff @(posedge clk)
begin: next_state_assignment
    /* Assignment of next state on clock edge */
	 state <= next_state;
end

endmodule : cpu_control
