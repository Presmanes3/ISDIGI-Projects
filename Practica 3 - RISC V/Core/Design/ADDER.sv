module ADDER
#(parameter size = 32)
( 	input [size - 1 : 0] input1,
	input [size - 1 : 0] input2,
	output reg [size - 1 : 0] out
);

always_comb out = input1 + input2;   //ASIGNAMOS A RESULT LA SUMA DE LAS ENTRADAS

endmodule