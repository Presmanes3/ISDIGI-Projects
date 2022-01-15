module reg_if_id_wiring_designator_segmented (
    segmented_interface wires
);

    assign wires.reg_if_id_wiring.clk               = wires.clk;
    assign wires.reg_if_id_wiring.pc_in             = wires.pc_wiring.out;
    assign wires.reg_if_id_wiring.instruction_in    = wires.instruction_memory_wiring.output_data;
endmodule