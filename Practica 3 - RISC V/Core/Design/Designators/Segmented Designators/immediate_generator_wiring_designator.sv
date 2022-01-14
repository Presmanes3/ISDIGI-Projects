module immediate_generator_wiring_designator(
    segmented_interface wires
);
    assign wires.imm_gen_wiring.instruction = wires.reg_if_id_wiring.instruction_out;
endmodule
