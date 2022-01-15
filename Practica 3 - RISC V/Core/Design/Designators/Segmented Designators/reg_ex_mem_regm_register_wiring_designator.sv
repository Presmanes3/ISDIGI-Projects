module  reg_ex_mem_regm_register_wiring_designator(
    segmented_interface wires
);
    assign wires.reg_ex_mem_regm_wiring.jump_pc_in= wires.reg_id_ex_regm_wiring.jump_pc_out;
    assign wires.reg_ex_mem_regm_wiring.instruction_func_in [4:0]= wires.reg_id_ex_regm_wiring.instruction_func_in[4:0];
    assign wires.reg_ex_mem_regm_wiring.force_jump_in= wires.reg_id_ex_regm_wiring.force_jump_out;
    assign wires.reg_ex_mem_regm_wiring.branch_in= wires.reg_id_ex_regm_wiring.branch_out;
    assign wires.reg_ex_mem_regm_wiring.mem_write_in= wires.reg_id_ex_regm_wiring.mem_write_out;
    assign wires.reg_ex_mem_regm_wiring.mem_read_in= wires.reg_id_ex_regm_wiring.mem_read_out;

endmodule