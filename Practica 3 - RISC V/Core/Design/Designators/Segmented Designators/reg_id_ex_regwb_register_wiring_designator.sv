module  reg_id_ex_regwb_register_wiring_designator(
    segmented_interface wires
);
    assign wires.reg_id_ex_regwb_wiring.reg_write_in= wires.main_controller_wiring.reg_write_out;
    assign wires.reg_id_ex_regwb_wiring.jump_rd_in= wires.main_controller_wiring.jump_rd_out;
    assign wires.reg_id_ex_regwb_wiring.mem_to_reg_in= wires.main_controller_wiring.mem_to_reg_out;

endmodule