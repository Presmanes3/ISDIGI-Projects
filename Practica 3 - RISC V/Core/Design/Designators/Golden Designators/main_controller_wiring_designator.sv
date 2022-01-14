module main_controller_wiring_designator#(
    parameter data_bits=32
)(
segmented_interface wires
);

assign wires.main_controller_wiring.opcode = wires.instruction_memory_wiring.out[6:0];

endmodule 