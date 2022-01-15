module main_controller_wiring_designator_segmented#(
    parameter data_bits=32
)(
    segmented_interface wires
);

    assign wires.main_controller_wiring.hazard_mux_enable   = 1'b0;

    assign wires.main_controller_wiring.opcode              = wires.reg_if_id_wiring.instruction_out[6:0];

endmodule 