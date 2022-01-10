`include "./Small Registers/register_wb.sv"

module register_mem_wb #(
    parameter data_bits = 32
) (

    input clk,

    register_wb_interface wb_wiring,

    input [data_bits - 1 : 0] alu_result_in,
    input [data_bits - 1 : 0] data_memory_out_in,
    input [4:0] instruction_11_7_in,

    output reg [data_bits - 1 : 0] alu_result_out,
    output reg [data_bits - 1 : 0] data_memory_out_out,
    output reg [4:0] instruction_11_7_out

);

assign wb_wiring.n_enable_output = 1'b0;

register_wb register_wb_instance(
    .wiring(wb_wiring)
);

always_ff @( posedge clk ) begin
    alu_result_out          <= alu_result_in;
    data_memory_out_out     <= data_memory_out_in;
    instruction_11_7_out    <= instruction_11_7_in;
end
    
endmodule