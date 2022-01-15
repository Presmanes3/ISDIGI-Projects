module mux_mem_wiring_designator(
    golden_interface wires
);
    assign wires.mux_mem_wiring.input1 =   wires.alu_wiring.alu_result;
    assign wires.mux_mem_wiring.input2 =   wires.data_memory_wiring.alu_result_out;
    assign wires.mux_mem_wiring.select =   wires.main_controller_wiring.mem_to_reg;
endmodule 
