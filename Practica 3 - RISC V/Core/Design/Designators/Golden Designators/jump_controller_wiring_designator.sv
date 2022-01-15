module jump_controller_wiring_designator (
    golden_interface wires
);

    assign wires.jump_controller_wiring.branch         = wires.main_controller_wiring.branch;
    assign wires.jump_controller_wiring.func_3_bits    = wires.alu_controller_wiring.func_3_bits;
    assign wires.jump_controller_wiring.zero           = wires.alu_wiring.zero;
    assign wires.jump_controller_wiring.alu_result     = wires.alu_wiring.result;
    
endmodule