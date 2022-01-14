module reg_ex_mem_wiring_designator(
    segmented_interface wires
);

assign wires.reg_ex_mem_wiring.adder_sum_in= wires.adder_sum_wiring.out;
assign wires.reg_ex_mem_wiring.alu_result= wires.alu_encapsulator_wiring.alu_result;
assign wires.reg_ex_mem_wiring.reg_ex_mem_alu_zero_in=wires.alu_encapsulator_wiring.alu_zero;
assign wires.reg_ex_mem_wiring.alu_read_data_2_in=wires.reg_id_ex_wiring.read_data_2_out;
assign wires.reg_ex_mem_wiring.instruction_11_7_in=wires.reg_id_ex_wiring.instruction_11_7_out;

endmodule