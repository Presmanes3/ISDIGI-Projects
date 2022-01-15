module alu_controller_wiring_designator_segmented(

    segmented_interface wires

);

    assign wires.alu_controller_wiring.func_7_bits   =   wires.reg_id_ex_wiring.instruction_11_7_out;
    assign wires.alu_controller_wiring.func_3_bits   =   wires.reg_id_ex_wiring.instruction_14_12_out;
    assign wires.alu_controller_wiring.alu_option    =   wires.reg_id_ex_wiring.ex_wiring.alu_op_out;

endmodule 
