module mux_pc_wiring_designator(
    golden_interface wires
);

    assign wires.mux_pc_wiring.input1  = wires.adder_pc_wiring.out;
    assign wires.mux_pc_wiring.input2  = wires.adder_sum_wiring.out;
    assign wires.mux_pc_wiring.control = wires.jump_controler_wiring.select;
    

endmodule