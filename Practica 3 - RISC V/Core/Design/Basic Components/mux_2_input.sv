
interface mux_2_input_interface #(
	parameter size = 32
);
    logic [size - 1 : 0] input1;
	logic [size - 1 : 0] input2;
	logic [size - 1 : 0] out;
	logic control;
endinterface //mux_2_input_interface


module mux_2_input
#(parameter size = 32)
(
	mux_2_input_interface mux_2_input_wiring
);

always_comb begin
		mux_2_input_wiring.out = 0;
		case(mux_2_input_wiring.control)
			0: 			mux_2_input_wiring.out = mux_2_input_wiring.input1; 
			1: 			mux_2_input_wiring.out = mux_2_input_wiring.input2;
			default: 	mux_2_input_wiring.out = mux_2_input_wiring.input1;
		endcase
	end
endmodule

