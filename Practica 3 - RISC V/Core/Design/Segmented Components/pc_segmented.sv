module PC
#(parameter size = 32)
(
	input clk,
	input reset,

	input flush_adder_enable,
	input flush_pc_enable,
	input pc_write_id_enable,

	input [size - 1 : 0] in,
	output reg [size - 1 : 0] out
);

always_ff @(posedge clk or negedge reset) begin
		if(!reset) 	out = 0;
		else begin
			if(pc_write_id_enable) out <= in;
		end
	end
endmodule 
