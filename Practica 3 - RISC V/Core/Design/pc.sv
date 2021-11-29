module PC
#(parameter size = 32)
(
	input clk,
	input reset,
	input [size - 1 : 0] in,
	output reg [size - 1 : 0] out
);

always @(posedge clk or negedge reset)
	begin
		if(!reset) begin
			out <= 0;
		end else begin
			out <= in;
		end
	end
endmodule 
