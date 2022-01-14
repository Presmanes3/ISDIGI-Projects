module alu_wiring_designator(
    segmented_interface wires
);

assign wires.alu_wiring.alu_input_1= wires.mux_alu1_wiring.out;
assign wires.alu_wiring.alu_input_2= wires.mux_alu2_wiring.out;
assign wires.alu_wiring.alu_operation= wires.alu_controller_wiring.alu_operation;

endmodule