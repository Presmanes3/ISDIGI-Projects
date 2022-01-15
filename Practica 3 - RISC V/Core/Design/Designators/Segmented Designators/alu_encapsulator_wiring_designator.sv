module alu_encapsulator_wiring_designator_segmented(
    segmented_interface wires
);

assign wires.alu_encapsulator_wiring.register_data_1_in     =   wires.reg_id_ex_wiring.read_data_1_out;
assign wires.alu_encapsulator_wiring.register_data_2_in     =   wires.reg_id_ex_wiring.read_data_2_out;
assign wires.alu_encapsulator_wiring.immediate_gen          =   wires.reg_id_ex_wiring.immediate_gen_out;
assign wires.alu_encapsulator_wiring.forward_controller_1   =   2'b00;                                      // FORCE INPUT FROM read data 1
assign wires.alu_encapsulator_wiring.forward_controller_2   =   wires.reg_id_ex_wiring.ex_wiring.alu_src_out;
assign wires.alu_encapsulator_wiring.prev_result_from_mux   =   wires.reg_id_ex_wiring.immediate_gen_out;   // TODO adapt to risk
assign wires.alu_encapsulator_wiring.prev_result_from_reg   =   32'hXXXXXXXX;                               // TODO adapt to risk
assign wires.alu_encapsulator_wiring.alu_operation          =   wires.alu_controller_wiring.alu_operation;

endmodule