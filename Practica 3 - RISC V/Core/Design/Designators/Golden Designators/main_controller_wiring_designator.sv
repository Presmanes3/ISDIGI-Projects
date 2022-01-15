module main_controller_wiring_designator#(
    parameter data_bits=32
)(
    golden_interface wires
);

    assign wires.main_controller_wiring.hazard_mux_enable = 1'b0;
    assign wires.main_controller_wiring.opcode = wires.instruction_memory_wiring.output_data[6:0];

endmodule 