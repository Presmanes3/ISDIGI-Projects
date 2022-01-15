module jump_controller_wiring_designator_segmented(
    segmented_interface wires
);

assign wires.jump_controller_wiring.branch       = wires.reg_ex_mem_wiring.m_wiring.branch_out;
assign wires.jump_controller_wiring.func_3_bits  = wires.reg_ex_mem_wiring.func_3_bits_out;
assign wires.jump_controller_wiring.alu_result   = wires.reg_ex_mem_wiring.alu_result_out;
assign wires.jump_controller_wiring.zero         = wires.reg_ex_mem_wiring.alu_zero_out;

endmodule