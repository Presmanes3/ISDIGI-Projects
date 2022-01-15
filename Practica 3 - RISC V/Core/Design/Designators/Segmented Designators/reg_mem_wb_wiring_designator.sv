module reg_mem_wb_wiring_designator_segmented (

segmented_interface wires

);

assign wires.reg_mem_wb_wiring.clk                  =   wires.clk;
assign wires.reg_mem_wb_wiring.alu_result_in        =   wires.reg_ex_mem_wiring.alu_result_out;
assign wires.reg_mem_wb_wiring.data_memory_out_in   =   wires.data_memory_wiring.output_data;
assign wires.reg_mem_wb_wiring.instruction_11_7_in  =   wires.reg_ex_mem_wiring.instruction_11_7_out;

assign wires.reg_mem_wb_wiring.clk                      = wires.clk;
assign wires.reg_mem_wb_wiring.wb_wiring.reg_write_in   = wires.reg_ex_mem_wiring.wb_wiring.reg_write_out;
assign wires.reg_mem_wb_wiring.wb_wiring.jump_rd_in     = wires.reg_ex_mem_wiring.wb_wiring.jump_rd_out;
assign wires.reg_mem_wb_wiring.wb_wiring.mem_to_reg_in  = wires.reg_ex_mem_wiring.wb_wiring.mem_to_reg_out;
endmodule 
