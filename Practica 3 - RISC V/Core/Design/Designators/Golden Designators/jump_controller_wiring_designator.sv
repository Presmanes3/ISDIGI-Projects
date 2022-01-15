module jump_controller_wiring_designator (
    golden_interface wires
);

    wires.jump_controller_wiring.branch         = wires.main_controller_wiring.branch;
    wires.jump_controller_wiring.func_3_bits    = wires.alu_controller_wiring.func_3_bits;
    wires.jump_controller_wiring.zero           = wires.alu_wiring.zero;
    wires.jump_controller_wiring.alu_result     = wires.alu_wiring.result;
    
endmodule