module reg_ex_mem_wiring_designator_segmented (
    segmented_interface wires
);

assign wires.reg_ex_mem_wiring.adder_sum_in         =   wires.adder_sum_wiring.out;
assign wires.reg_ex_mem_wiring.alu_result_in        =   wires.alu_encapsulator_wiring.alu_result;
assign wires.reg_ex_mem_wiring.alu_zero_in          =   wires.alu_encapsulator_wiring.alu_zero;
assign wires.reg_ex_mem_wiring.alu_read_data_2_in   =   wires.reg_id_ex_wiring.read_data_2_out;
assign wires.reg_ex_mem_wiring.func_3_bits_in       =   wires.reg_id_ex_wiring.instruction_11_7_out;
assign wires.reg_ex_mem_wiring.instruction_11_7_in  =   wires.reg_id_ex_wiring.instruction_11_7_out;

assign wires.reg_ex_mem_wiring.m_wiring.jump_pc_in          = 0;
assign wires.reg_ex_mem_wiring.m_wiring.instruction_func_in = 0;
assign wires.reg_ex_mem_wiring.m_wiring.force_jump_in       = 0;
assign wires.reg_ex_mem_wiring.m_wiring.branch_in           = 0;
assign wires.reg_ex_mem_wiring.m_wiring.mem_write_in        = 0;
assign wires.reg_ex_mem_wiring.m_wiring.mem_read_in         = 0;

assign wires.reg_ex_mem_wiring.wb_wiring.reg_write_in   = 0;
assign wires.reg_ex_mem_wiring.wb_wiring.jump_rd_in     = 0;
assign wires.reg_ex_mem_wiring.wb_wiring.mem_to_reg_in  = 0;
endmodule