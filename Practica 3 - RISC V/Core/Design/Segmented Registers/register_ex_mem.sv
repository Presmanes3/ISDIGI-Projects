`include "./Small Registers/register_wb.sv"
`include "./Small Registers/register_m.sv"

module register_ex_mem #(
    parameter data_bits = 32
) (
    input clk,
    input clear_pipeline,

    register_m_interface    m_wiring,
    register_wb_interface   wb_wiring,

    input       [data_bits - 1 : 0] adder_sum_in,
    output reg  [data_bits - 1 : 0] adder_sum_out,

    input       [data_bits - 1 : 0] alu_result_in,
    output reg  [data_bits - 1 : 0] alu_result_out,

    input       [data_bits - 1 : 0] alu_read_data_2_in,
    output reg  [data_bits - 1 : 0] alu_read_data_2_out,

    input       [4:0] instruction_11_7_in,
    output reg  [4:0] instruction_11_7_out
);

assign m_wiring.n_enable_output = clear_pipeline;
assign wb_wiring.n_enable_output = clear_pipeline;

register_m register_m_instance(
    .wiring(m_wiring)
);

register_wb register_wb_instance(
    .wiring(wb_wiring)
);

always_ff @( posedge clk ) begin 
    if(!clear_pipeline)begin
        adder_sum_out           <= adder_sum_in;
        alu_result_out          <= alu_result_in;
        alu_read_data_2_out     <= alu_read_data_2_in;
        instruction_11_7_out    <= instruction_11_7_in;
    end
end
    
endmodule