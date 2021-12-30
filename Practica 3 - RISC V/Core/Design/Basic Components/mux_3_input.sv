module mux_3_input
#(parameter size = 32)
(
	input [size - 1 : 0] input0,
	input [size - 1 : 0] input1,
	input [size - 1 : 0] input2,
	output reg [size - 1 : 0] out,
	input [1:0] control
);

always_comb begin
		out = 0;
		case(control)
			2'b00: 		out = input0; 
			2'b01: 		out = input1;
			2'b10: 		out = input2;
			default: 	out = input0;
		endcase
	end
endmodule
