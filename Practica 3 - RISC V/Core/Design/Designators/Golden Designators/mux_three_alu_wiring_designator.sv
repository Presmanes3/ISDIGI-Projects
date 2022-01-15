module mux_three_alu_wiring_designator (
    golden_interface wires
);
    
    wires.mux_three_alu_wiring.input0 = wires.pc_wiring.out;
    wires.mux_three_alu_wiring.input1 = 32'd0;
    wires.mux_three_alu_wiring.input2 = wires.register_bank_wiring.read_data_1;
    wires.mux_three_alu_wiring.control = 2;
endmodule