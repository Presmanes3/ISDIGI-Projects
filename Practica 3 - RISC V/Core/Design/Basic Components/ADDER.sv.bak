interface adder_interface#(
    parameter size = 32
);;
	logic [size - 1 : 0] input1;
	logic [size - 1 : 0] input2;
	logic [size - 1 : 0] out;

endinterface //ADDER



module ADDER
#(parameter size = 32)
( 
	adder_interface adder_wiring
);

always_comb adder_wiring.out = adder_wiring.input1 + adder_wiring.input2;   //ASIGNAMOS A RESULT LA SUMA DE LAS ENTRADAS

endmodule