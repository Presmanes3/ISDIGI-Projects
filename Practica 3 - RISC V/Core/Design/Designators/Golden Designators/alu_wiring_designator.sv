module alu_wiring_designator(
    golden_interface wires
);

assign wires.alu_wiring.alu_input_1= wires.mux_alu1_wiring.out;
assign wires.alu_wiring.alu_input_2= wires.mux_three_alu_wiring.out;
assign wires.alu_wiring.alu_operation= wires.alu_controller_wiring.alu_operation;

endmodule