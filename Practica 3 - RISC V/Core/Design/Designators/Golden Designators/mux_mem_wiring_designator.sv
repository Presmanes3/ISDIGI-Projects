module mux_mem_wiring_designator(
    golden_interface wires
);
    assign wires.mux_mem_wiring.input1  =   wires.alu_wiring.result;
    assign wires.mux_mem_wiring.input2  =   wires.data_memory_wiring.output_data;
    assign wires.mux_mem_wiring.control =   wires.main_controller_wiring.memory_to_register;
endmodule 
