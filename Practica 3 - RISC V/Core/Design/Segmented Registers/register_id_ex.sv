`include "./Small Registers/register_ex.sv"
`include "./Small Registers/register_m.sv"
`include "./Small Registers/register_wb.sv"

module register_id_ex #(
    parameter data_bits = 32
) (

    input clk,

    register_ex_interface ex_wiring,
    register_m_interface m_wiring,
    register_wb_interface wb_wiring,

    input       [5 : 0] instruction_in,
    output  reg [5 : 0] instruction_out,

    input       [data_bits - 1 : 0] pc_in,
    output reg  [data_bits - 1 : 0] pc_out,

    input       [data_bits - 1 : 0] read_data_1_in,
    output reg  [data_bits - 1 : 0] read_data_1_out,

    input       [data_bits - 1 : 0] read_data_2_in,
    output reg  [data_bits - 1 : 0] read_data_2_out,

    input       [data_bits - 1 : 0] immediate_gen_in,
    output reg  [data_bits - 1 : 0] immediate_gen_out,

    input       [data_bits - 1 : 0] instruction_11_7_in,
    output reg  [data_bits - 1 : 0] instruction_11_7_out,

    input       [data_bits - 1 : 0] instruction_30_12_in,
    output reg  [data_bits - 1 : 0] instruction_30_12_out

);

register_m register_m_instance(
    .wiring(m_wiring)
);

register_wb register_wb_instance(
    .wiring(wb_wiring)
);

register_ex register_ex_instance(
    .wiring(ex_wiring)
);

always_ff @( posedge clk ) begin
    instruction_out         <= instruction_in;
    pc_out                  <= pc_in;
    read_data_1_out         <= read_data_1_in;
    read_data_2_out         <= read_data_2_in;
    immediate_gen_out       <= immediate_gen_in;
    instruction_11_7_out    <= instruction_11_7_in;
    instruction_30_12_out   <= instruction_30_12_in;
end
    
endmodule