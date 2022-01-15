module mux_alu2_wiring_designator(
    golden_interface wires
);
    assign wires.mux_alu2_wiring.input1 =   wires.register_bank_wiring.read_data_2;
    assign wires.mux_alu2_wiring.input2 =   wires.imm_gen_wiring.out;
    assign wires.mux_alu2_wiring.control =   wires.main_controller_wiring.alu_source;
endmodule 
