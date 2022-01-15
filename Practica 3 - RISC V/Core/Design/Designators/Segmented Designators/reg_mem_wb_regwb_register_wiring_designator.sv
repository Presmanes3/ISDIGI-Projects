module  reg_mem_wb_regwb_register_wiring_designator(
    segmented_interface wires
);
    assign wires.reg_mem_wb_regwb_wiring.reg_write_in=  wires.reg_ex_mem_regwb_wiring.reg_write_out;
    assign wires.reg_mem_wb_regwb_wiring.jump_rd_in= wires.reg_ex_mem_regwb_wiring.jump_rd_out;
    assign wires.reg_mem_wb_regwb_wiring.mem_to_reg_in= wires.reg_ex_mem_regwb_wiring.mem_to_reg_out;

endmodule