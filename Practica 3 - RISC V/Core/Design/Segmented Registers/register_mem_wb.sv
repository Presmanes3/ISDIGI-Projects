//`include "./Small Registers/register_wb.sv"

interface register_mem_wb_interface #(
    parameter data_bits = 32
);
    logic clk;

    register_wb_interface wb_wiring();

    logic [data_bits - 1 : 0] alu_result_in;
    logic [data_bits - 1 : 0] data_memory_out_in;
    logic [4:0] instruction_11_7_in;

    logic [data_bits - 1 : 0] alu_result_out;
    logic [data_bits - 1 : 0] data_memory_out_out;
    logic [4:0] instruction_11_7_out;
endinterface //register_mem_wb_interface


module register_mem_wb #(
    parameter data_bits = 32
) (
    register_mem_wb_interface reg_mem_wb_wiring
);

assign reg_mem_wb_wiring.wb_wiring.n_enable_output = 1'b0;

register_wb register_wb_instance(
    .wiring(reg_mem_wb_wiring.wb_wiring)
);

always_ff @( posedge reg_mem_wb_wiring.clk ) begin
    reg_mem_wb_wiring.alu_result_out          <= reg_mem_wb_wiring.alu_result_in;
    reg_mem_wb_wiring.data_memory_out_out     <= reg_mem_wb_wiring.data_memory_out_in;
    reg_mem_wb_wiring.instruction_11_7_out    <= reg_mem_wb_wiring.instruction_11_7_in;
end
    
endmodule