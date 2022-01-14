interface mux_3_input_interface#(parameter size = 32);

	logic [size - 1 : 0] input0;
	logic [size - 1 : 0] input1;
	logic [size - 1 : 0] input2;
	logic [size - 1 : 0] out;
	logic [1:0] control;

endinterface //mux_3_input_interface

module mux_3_input
#(parameter size = 32)
(
mux_3_input_interface mux_3_input_wiring
);

always_comb begin
		mux_3_input_wiring.out = 0;
		case(mux_3_input_wiring.control)
			2'b00: 		mux_3_input_wiring.out = mux_3_input_wiring.input0; 
			2'b01: 		mux_3_input_wiring.out = mux_3_input_wiring.input1;
			2'b10: 		mux_3_input_wiring.out = mux_3_input_wiring.input2;
			default: 	mux_3_input_wiring.out = mux_3_input_wiring.input0;
		endcase
	end
endmodule
