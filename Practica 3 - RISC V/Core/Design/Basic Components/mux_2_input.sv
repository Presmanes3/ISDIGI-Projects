module mux_2_input
#(parameter size = 32)
(
	input [size - 1 : 0] input1,
	input [size - 1 : 0] input2,
	output reg [size - 1 : 0] out,
	input control
);

always_comb begin
		out = 0;
		case(control)
			0: 			out = input1; 
			1: 			out = input2;
			default: 	out = input1;
		endcase
	end
endmodule

