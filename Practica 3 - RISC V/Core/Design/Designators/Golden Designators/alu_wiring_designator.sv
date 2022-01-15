module alu_wiring_designator(
    golden_interface wires
);

assign wires.alu_wiring.input1     = wires.mux_alu1_wiring.out;
assign wires.alu_wiring.input2     = wires.mux_alu2_wiring.out;
assign wires.alu_wiring.operation   = wires.alu_controller_wiring.alu_operation;

endmodule