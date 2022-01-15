module  reg_id_ex_regex_register_wiring_designator(
    segmented_interface wires
);
    assign wires.reg_id_ex_regex_wiring.alu_op_in [3:0]= wires.main_controller_wiring.alu_op_out [3:0];
    assign wires.reg_id_ex_regex_wiring.alu_src_in= wires.main_controller_wiring.alu_src_out;
    assign wires.reg_id_ex_regex_wiring.lui_src_in=  wires.main_controller_wiring.lui_src_out;
endmodule
