module jump_controler_wiring_designator(
    segmented_interface wires
);

assign wires.jump_controler_wiring.branch       = wires.reg_ex_mem_wiring.m_wiring.branch;
assign wires.jump_controler_wiring.func_3_bits  = wires.reg_ex_mem_wiring.func_3_bits_out;
assign wires.jump_controler_wiring.alu_result   = wires.reg_ex_mem_wiring.alu_result_out;
assign wires.jump_controler_wiring.zero         = wires.reg_ex_mem_wiring.alu_zero_out;

endmodule