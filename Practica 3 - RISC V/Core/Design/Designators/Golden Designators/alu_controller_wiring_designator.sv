module alu_controller_wiring(

    golden_interface wires

);

    assign wires.alu_controller_wiring.func_7_bits   =   wires.memory_wiring.output_data[31:25];
    assign wires.alu_controller_wiring.func_3_bits   =   wires.memory_wiring.output_data[14:12];
    assign wires.alu_controller_wiring.alu_option    =   wires.main_controller_wiring.alu_option;

endmodule 