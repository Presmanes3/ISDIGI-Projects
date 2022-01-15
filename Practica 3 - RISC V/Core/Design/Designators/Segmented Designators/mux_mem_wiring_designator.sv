module mux_mem_wiring_designator(

segmented_interface wires

);

assign wires.mux_mem_wiring.input1 =   wires.reg_mem_wb_wiring.alu_result_out;
assign wires.mux_mem_wiring.input2 =   wires.reg_mem_wb_wiring.data_memory_out_out;
assign wires.mux_mem_wiring.select =   wires.reg_mem_wb_wiring.mem_to_reg_out;

endmodule 
