module mux_pc_wiring_designator(
    segmented_interface wires
);

    assign wires.mux_pc_wiring.input1  = wires.adder_pc_wiring.out;
    assign wires.mux_pc_wiring.input2  = wires.adder_sum_out;
    assign wires.mux_pc_wiring.control = wires.jump_controler_wiring.select;//no estoy seguro pero creo que sí de esta 
    

endmodule