module adder_sum_wiring_designator(
    segmented_interface wires
);

assign wires.adder_sum_wiring.input1 = wires.reg_id_ex_wiring.pc_out;
assign wires.adder_sum_wiring.input2 = wires.reg_id_ex_wiring.immediate_gen_out;

endmodule
