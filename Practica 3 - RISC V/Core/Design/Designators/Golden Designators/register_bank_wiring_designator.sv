module register_bank_wiring_designator(
    segmented_interface wires
);
    assign wires.register_bank_wiring.clk                   = wires.clk;
    assign wires.register_bank_wiring.read_register_1_addr  = wires.instruction_memory_wiring.instruction_out[19 : 15]; 
    assign wires.register_bank_wiring.read_register_2_addr  = wires.instruction_memory_wiring.instruction_out[24 : 20];
    assign wires.register_bank_wiring.write_register_addr   = wires.instruction_memory_wiring.instruction_out[11 : 7];
    assign wires.register_bank_wiring.write_data            = wires.mux_mem_wiring.out;
    assign wires.register_bank_wiring.write_enable          = wires.main_controller_wiring.register_write;
endmodule
