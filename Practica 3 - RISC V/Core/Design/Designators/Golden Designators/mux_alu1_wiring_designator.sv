module mux_alu1_wiring_designator(
    golden_interface wires
);

    assign wires.mux_alu1_wiring.input0 = wires.pc_wiring.out;
    assign wires.mux_alu1_wiring.input1 = 32'd0;
    assign wires.mux_alu1_wiring.input2 = wires.register_bank_wiring.read_data_1;
    assign wires.mux_alu1_wiring.control = 2;
endmodule 
