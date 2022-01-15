module reg_id_ex_wiring_designator_segmented (
    segmented_interface wires
);

assign wires.reg_id_ex_wiring.clk                   = wires.clk;
assign wires.reg_id_ex_wiring.pc_in                 = wires.reg_if_id_wiring.pc_out;
assign wires.reg_id_ex_wiring.read_data_1_in        = wires.register_bank_wiring.read_data_1;
assign wires.reg_id_ex_wiring.read_data_2_in        = wires.register_bank_wiring.read_data_2;
assign wires.reg_id_ex_wiring.immediate_gen_in      = wires.imm_gen_wiring.out;
assign wires.reg_id_ex_wiring.instruction_11_7_in   = wires.reg_if_id_wiring.instruction_out[11:7];
assign wires.reg_id_ex_wiring.instruction_14_12_in  = wires.reg_if_id_wiring.instruction_out[14:12];
assign wires.reg_id_ex_wiring.instruction_30_in     = wires.reg_if_id_wiring.instruction_out[30];
assign wires.reg_id_ex_wiring.instruction_in        = wires.reg_if_id_wiring.instruction_out;

assign wires.reg_id_ex_wiring.ex_wiring.alu_op_in   = 0;
assign wires.reg_id_ex_wiring.ex_wiring.alu_src_in  = 0;
assign wires.reg_id_ex_wiring.ex_wiring.lui_src_in  = 0;

assign wires.reg_id_ex_wiring.m_wiring.jump_pc_in          = 0;
assign wires.reg_id_ex_wiring.m_wiring.instruction_func_in = 0;
assign wires.reg_id_ex_wiring.m_wiring.force_jump_in       = 0;
assign wires.reg_id_ex_wiring.m_wiring.branch_in           = 0;
assign wires.reg_id_ex_wiring.m_wiring.mem_write_in        = 0;
assign wires.reg_id_ex_wiring.m_wiring.mem_read_in         = 0;

assign wires.reg_id_ex_wiring.wb_wiring.reg_write_in   = 0;
assign wires.reg_id_ex_wiring.wb_wiring.jump_rd_in     = 0;
assign wires.reg_id_ex_wiring.wb_wiring.mem_to_reg_in  = 0;
assign wires.reg_id_ex_wiring.wb_wiring.reg_write_in   = 0;

endmodule