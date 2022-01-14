module immediate_generator_wiring_designator(
    golden_interface wires
);
    assign wires.imm_gen_wiring.input = wires.instruction_memory_wiring.output;
endmodule
<