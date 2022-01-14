module reg_id_ex_wiring_designator(
    segmented_interface wires
);

assign wires.reg_id_ex_wiring.pc_in= wires.reg_if_id_wiring.pc_out;
assign wires.reg_id_ex_wiring.read_data_1_in= wires.register_bank_wiring.read_data_1;
assign wires.reg_id_ex_wiring.read_data_2_in= wires.register_bank_wiring.read_data_2;
assign wires.reg_id_ex_wiring.immediate_gen_in= wires.imm_gen_wiring.instruction_out;
assign wires.reg_id_ex_wiring.instruction_11_7_in= wires.reg_if_id_wiring.instruction_out[11:7];
assign wires.reg_id_ex_wiring.instruction_14_12_in= wires.reg_if_id_wiring.instruction_out[14:12];
assign wires.reg_id_ex_wiring.instruction_30_in= wires.reg_if_id_wiring.instruction_out[30];
assign wires.reg_id_ex_wiring.instruction_in= wires.reg_if_id_wiring.instruction_out;


endmodule