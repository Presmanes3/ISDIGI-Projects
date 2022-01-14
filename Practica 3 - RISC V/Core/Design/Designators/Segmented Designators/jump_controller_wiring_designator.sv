module jump_controler_designator(
    segmented_interface wires
);

assign wires.jump_controler_wiring.branch       = wires.main_controller_wiring.branch;
assign wires.jump_controler_wiring.func_3_bits  = wires.alu_controler_wiring.func_3_bits;
assign wires.jump_controler_wiring.alu_result   = wires.reg_ex_mem_wiring.alu_result_out;
assign wires.jump_controler_wiring.zero         = wires.reg_ex_mem_wiring.alu_zero_out;

endmodule