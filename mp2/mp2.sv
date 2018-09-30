module mp2
(
	input clk,
	
	/*Signals interacting with Physical Memory*/
	input [255:0] pmem_rdata,
	input pmem_resp,
	
	output logic [31:0] pmem_address,
	output logic [255:0] pmem_wdata,
	output logic pmem_read,
	output logic pmem_write
);

/*Internal Signals*/
	logic mem_resp;
	logic [31:0] mem_rdata;
	logic mem_read;
	logic mem_write;
	logic [3:0] mem_byte_enable;
	logic [31:0] mem_address;
	logic [31:0] mem_wdata;
	
cpu cpu
(
	.*
);

cache cache
(
	.*
);

endmodule : mp2