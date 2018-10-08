module data_logic
(
	input [255:0] data_out,
	input [4:0] index,
	input [3:0] mem_byte_enable,
	input [31:0] mem_wdata,
	
	output logic [31:0] mem_rdata,
	output logic [255:0] data_cache
);

	logic [2:0] index_word;
	logic [1:0] index_byte;
	logic [31:0] data_shifted;
	logic [255:0] data_out_temp;
	
assign index_word = index[4:2];
assign index_byte = index[1:0];
assign data_shifted = data_out[(index_word*32 + 31)-:32];
//assign data_out_temp = data_out;

always_comb
begin
	data_cache = data_out;
	
	if (index_byte == 2'b00)
	begin
		mem_rdata = data_shifted;
		if (mem_byte_enable == 4'b0001)
		begin
			data_cache[((index+1)*8-1)-:8] = mem_wdata[7:0];
		end
		
		else if (mem_byte_enable == 4'b0011)
		begin
			data_cache[((index+2)*8-1)-:16] = mem_wdata[15:0];	
		end
		
		else if (mem_byte_enable == 4'b1111)
		begin
			data_cache[((index+4)*8-1)-:32] = mem_wdata;
		end
		
		else
		begin
		end
	end
	
	else if (index_byte == 2'b01)
	begin
		mem_rdata = data_shifted >> 8;
		if (mem_byte_enable == 4'b0001)
		begin
			data_cache[((index+1)*8-1)-:8] = mem_wdata[7:0];
		end
		
		else
		begin
		end
	end
	
	else if (index_byte == 2'b10)
	begin
		mem_rdata = data_shifted >> 16;
		if (mem_byte_enable == 4'b0001)
		begin
			data_cache[((index+1)*8-1)-:8] = mem_wdata[7:0];
		end
		
		else if (mem_byte_enable == 4'b0011)
		begin
			data_cache[((index+2)*8-1)-:16] = mem_wdata[15:0];
		end
		
		else
		begin
		end
	end
	
	else if (index_byte == 2'b11)
	begin
		mem_rdata = data_shifted >> 24;
		if (mem_byte_enable == 4'b0001)
		begin
			data_cache[((index+1)*8-1)-:8] = mem_wdata[7:0];
		end
		
		else
		begin
		end
	end
	
	else
	begin
		mem_rdata = data_shifted;
	end
	
	/*
	if (index_byte == 2'b00 && mem_byte_enable == 4'b1111)
	begin
		mem_rdata = data_shifted;
		data_cache[((index+4)*8-1)-:32] = mem_wdata;
	end
	
	else if (index_byte == 2'b00 && mem_byte_enable == 4'b0001)
	begin
		mem_rdata = data_shifted;
		data_cache[((index+1)*8-1)-:8] = mem_wdata[7:0];
	end
	
	else if (index_byte == 2'b00 && mem_byte_enable == 4'b0011)
	begin
		mem_rdata = data_shifted;
		data_cache[((index+2)*8-1)-:16] = mem_wdata[15:0];	
	end
	
	else if (index_byte == 2'b01)
	begin
		mem_rdata = data_shifted >> 8;
		data_cache[((index+1)*8-1)-:8] = mem_wdata[7:0];
	end
	
	else if (index_byte == 2'b10 && mem_byte_enable == 4'b0001)
	begin
		mem_rdata = data_shifted >> 16;
		data_cache[((index+1)*8-1)-:8] = mem_wdata[7:0];
	end
	
	else if (index_byte == 2'b10 && mem_byte_enable == 4'b0011)
	begin
		mem_rdata = data_shifted >> 16;
		data_cache[((index+2)*8-1)-:16] = mem_wdata[15:0];	
	end
	
	else if (index_byte == 2'b11)
	begin
		mem_rdata = data_shifted >> 24;
		data_cache[((index+1)*8-1)-:8] = mem_wdata[7:0];
	end
	
	else
	begin
		mem_rdata = data_shifted;
	end
	*/
	
	/*
	case (index_byte)
		default:
		begin
			mem_rdata = data_shifted;
			case (mem_byte_enable)
				default:
				begin
					data_cache[((index+4)*8-1)-:32] = mem_wdata;
					
					//data_out_temp[((index+4)*8-1)-:32] = mem_wdata;
					//data_cache = data_out_temp;
					
					
					if ((index+4)*8 > 255)
						data_cache = {mem_wdata, data_out_temp[index*8-1:0]};
					else if (index*8-1 < 0)
						data_cache = {data_out[255:(index+4)*8], mem_wdata};
					else
						data_cache = {data_out[255:(index+4)*8], mem_wdata, data_out[index*8-1:0]};
					
				end
				
				4'b0001:
				begin
					data_cache[((index+1)*8-1)-:8] = mem_wdata[7:0];
					
					//data_out_temp[((index+1)*8-1)-:8] = mem_wdata[7:0];
					//data_cache = data_out_temp;
					
					if ((index+1)*8 > 255)
						data_cache = {mem_wdata[7:0], data_out[index*8-1:0]};
					else if (index*8-1 < 0)
						data_cache = {data_out[255:(index+1)*8], mem_wdata[7:0]};
					else
						data_cache = {data_out[255:(index+1)*8], mem_wdata[7:0], data_out[index*8-1:0]};
					
				end
				
				4'b0011:
				begin
					data_cache[((index+2)*8-1)-:16] = mem_wdata[15:0];	

					//data_out_temp[((index+2)*8-1)-:16] = mem_wdata[15:0];
					//data_cache = data_out_temp;
					
					if ((index+2)*8 > 255)
						data_cache = {mem_wdata[15:0], data_out[index*8-1:0]};
					else if (index*8-1 < 0)
						data_cache = {data_out[255:(index+2)*8], mem_wdata[15:0]};
					else
						data_cache = {data_out[255:(index+2)*8], mem_wdata[15:0], data_out[index*8-1:0]};
					
				end
			endcase
		end
		
		2'b01:
		begin
			mem_rdata = data_shifted >> 8;
			
			data_cache[((index+1)*8-1)-:8] = mem_wdata[7:0];
			
			//data_out_temp[((index+1)*8-1)-:8] = mem_wdata[7:0];
			//data_cache = data_out_temp;
			
			if ((index+1)*8 > 255)
				data_cache = {mem_wdata[7:0], data_out[index*8-1:0]};
			else if (index*8-1 < 0)
				data_cache = {data_out[255:(index+1)*8], mem_wdata[7:0]};
			else
				data_cache = {data_out[255:(index+1)*8], mem_wdata[7:0], data_out[index*8-1:0]};
			
		end
		
		2'b10:
		begin
			mem_rdata = data_shifted >> 16;
			case (mem_byte_enable)
				default:
				begin
					data_cache[((index+1)*8-1)-:8] = mem_wdata[7:0];
					
					//data_out_temp[((index+1)*8-1)-:8] = mem_wdata[7:0];
					//data_cache = data_out_temp;
					
					if ((index+1)*8 > 255)
						data_cache = {mem_wdata[7:0], data_out[index*8-1:0]};
					else if (index*8-1 < 0)
						data_cache = {data_out[255:(index+1)*8], mem_wdata[7:0]};
					else
						data_cache = {data_out[255:(index+1)*8], mem_wdata[7:0], data_out[index*8-1:0]};
					
				end
				
				4'b0011:
				begin
					data_cache[((index+2)*8-1)-:16] = mem_wdata[15:0];
					
					//data_out_temp[((index+2)*8-1)-:16] = mem_wdata[15:0];
					//data_cache = data_out_temp;
					
					if ((index+2)*8 > 255)
						data_cache = {mem_wdata[15:0], data_out[index*8-1:0]};
					else if (index*8-1 < 0)
						data_cache = {data_out[255:(index+2)*8], mem_wdata[15:0]};
					else
						data_cache = {data_out[255:(index+2)*8], mem_wdata[15:0], data_out[index*8-1:0]};
					
				end
			endcase
		end
		
		2'b11:
		begin
			mem_rdata = data_shifted >> 24;
			
			data_cache[((index+1)*8-1)-:8] = mem_wdata[7:0];
			
			//data_out_temp[((index+1)*8-1)-:8] = mem_wdata[7:0];
			//data_cache = data_out_temp;
			
			if ((index+1)*8 > 255)
				data_cache = {mem_wdata[7:0], data_out[index*8-1:0]};
			else if (index*8-1 < 0)
				data_cache = {data_out[255:(index+1)*8], mem_wdata[7:0]};
			else
				data_cache = {data_out[255:(index+1)*8], mem_wdata[7:0], data_out[index*8-1:0]};
			
		end
	endcase
	*/
end

endmodule : data_logic