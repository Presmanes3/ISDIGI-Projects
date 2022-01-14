module mux_pc_wiring_designator(
    segmented_interface wires
);

    assign wires.mux_pc_wiring.input1  = wires.adder_pc_wiring.out;
    assign wires.mux_pc_wiring.input2  = wires.reg_ex_mem_wiring.adder_sum_out;
    assign wires.mux_pc_wiring.control = wires.jump_controler_wiring.select;
    

endmodule