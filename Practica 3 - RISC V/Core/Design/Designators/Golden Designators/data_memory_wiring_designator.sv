module  data_memory_wiring_designator#(
    parameter data_bits = 32  
)(
    golden_interface wires
);
assign wires.data_memory_wiring.clk          =   wires.clk;
assign wires.data_memory_wiring.read_address =   wires.alu_wiring.alu_result[data_bits - 1 : 2];
assign wires.data_memory_wiring.input_data   =   wires.register_bank_wiring.read_data_2;
assign wires.data_memory_wiring.write_enable =   wires.main_controller_wiring.memory_write;
assign wires.data_memory_wiring.read_enable  =   wires.main_controller_wiring.memory_read;

endmodule