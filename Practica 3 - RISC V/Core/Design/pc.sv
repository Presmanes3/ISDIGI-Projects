module PC
#(parameter size = 32)
(
	input clk,
	input reset,
	input [size - 1 : 0] in,
	output reg [size - 1 : 0] out
);

always_ff @(posedge clk or negedge reset) begin
		if(!reset) 	out = 0;
		else 		out <= in;
	end
endmodule 
