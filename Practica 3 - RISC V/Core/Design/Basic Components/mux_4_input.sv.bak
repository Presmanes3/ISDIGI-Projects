interface mux_4_input_interface# #(
    parameter bits = 32
);
    logic [bits - 1 : 0] input0;
    logic [bits - 1 : 0] input1;
    logic [bits - 1 : 0] input2;
    logic [bits - 1 : 0] input3;

    logic [1:0] control;

    logic [bits - 1 : 0] out;
endinterface //mux_4_input_interface 

module mux_4_input(
    mux_4_input_interface mux_4_input_wiring
)

    always_comb begin
        
        mux_4_input_wiring.out  =   0;

        case(mux_4_input_wiring.control)
            2'b00 : mux_4_input_wiring.out = mux_4_input_wiring.input0;
            2'b01 : mux_4_input_wiring.out = mux_4_input_wiring.input1;
            2'b10 : mux_4_input_wiring.out = mux_4_input_wiring.input2;
            2'b11 : mux_4_input_wiring.out = mux_4_input_wiring.input3;
        endcase
    end
endmodule
