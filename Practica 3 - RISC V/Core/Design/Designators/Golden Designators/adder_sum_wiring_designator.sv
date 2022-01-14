module adder_sum_wiring_designator(
    segmented_interface wires
);

assign wires.adder_sum_wiring.input1 = wires.pc_wiring.out;
assign wires.adder_sum_wiring.input2 = wires.imm_gen_wiring.out;

endmodule
