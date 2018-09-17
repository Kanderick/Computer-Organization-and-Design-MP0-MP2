module ldconcat
(
	input [31:0] mdr_out,
	input [2:0] funct3,
	output logic [31:0] ldconcat_out
);

always_comb
begin
	case (funct3)
		default: ldconcat_out = mdr_out;
		
		3'b000: ldconcat_out = {{24{mdr_out[7]}}, mdr_out[7:0]};
		
		3'b001: ldconcat_out = {{16{mdr_out[15]}}, mdr_out[15:0]};
		
		3'b100: ldconcat_out = {{24'h000000}, mdr_out[7:0]};
		
		3'b101: ldconcat_out = {{16'h0000}, mdr_out[15:0]};
	endcase
end


endmodule : ldconcat