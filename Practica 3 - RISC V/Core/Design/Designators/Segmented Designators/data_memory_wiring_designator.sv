module  data_memory_wiring_designator#(
    parameter data_bits = 32  
)(
    segmented_interface wires
);
assign wires.memory_wiring.clk          =   wires.clk;
assign wires.memory_wiring.read_address =   wires.reg_ex_mem_wiring.alu_result_out[data_bits - 1 : 2];
assign wires.memory_wiring.input_data   =   wires.reg_ex_mem_wiring.alu_read_data_2_out;
assign wires.memory_wiring.write_enable =   wires.reg_ex_mem_wiring.m_wiring.mem_write_out;
assign wires.memory_wiring.read_enable  =   wires.reg_ex_mem_wiring.m_wiring.mem_read_out;

endmodule