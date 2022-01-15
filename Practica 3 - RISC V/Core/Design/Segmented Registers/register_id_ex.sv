//`include "./Small Registers/register_ex.sv"
//`include "./Small Registers/register_m.sv"
//`include "./Small Registers/register_wb.sv"

interface register_id_ex_interface #(
    parameter data_bits = 32
);

    logic clk;
    logic clear_pipeline;

    register_ex_interface   ex_wiring();
    register_m_interface    m_wiring();
    register_wb_interface   wb_wiring();

    logic [5 : 0] instruction_in;
    logic [5 : 0] instruction_out;

    logic  [data_bits - 1 : 0] pc_in;
    logic  [data_bits - 1 : 0] pc_out;

    logic  [data_bits - 1 : 0] read_data_1_in;
    logic  [data_bits - 1 : 0] read_data_1_out;

    logic  [data_bits - 1 : 0] read_data_2_in;
    logic  [data_bits - 1 : 0] read_data_2_out;

    logic  [data_bits - 1 : 0] immediate_gen_in;
    logic  [data_bits - 1 : 0] immediate_gen_out;

    logic  [4:0] instruction_11_7_in;
    logic  [4:0] instruction_11_7_out;

    logic  [2:0] instruction_14_12_in;
    logic  [2:0] instruction_14_12_out;

    logic   instruction_30_in;
    logic   instruction_30_out;
    
endinterface //reg_id_ex_interface

module register_id_ex #(
    parameter data_bits = 32
) (
    register_id_ex_interface reg_id_ex_wiring

);

assign reg_id_ex_wiring.m_wiring.n_enable_output  = reg_id_ex_wiring.clear_pipeline;
assign reg_id_ex_wiring.wb_wiring.n_enable_output = reg_id_ex_wiring.clear_pipeline;
assign reg_id_ex_wiring.ex_wiring.n_enable_output = reg_id_ex_wiring.clear_pipeline;

register_m register_m_instance(
    .wiring(reg_id_ex_wiring.m_wiring)
);

register_wb register_wb_instance(
    .wiring(reg_id_ex_wiring.wb_wiring)
);

register_ex register_ex_instance(
    .wiring(reg_id_ex_wiring.ex_wiring)
);

always_ff @( posedge reg_id_ex_wiring.clk ) begin

    if(!reg_id_ex_wiring.clear_pipeline)begin
        reg_id_ex_wiring.instruction_out         <= reg_id_ex_wiring.instruction_in;
        reg_id_ex_wiring.pc_out                  <= reg_id_ex_wiring.pc_in;
        reg_id_ex_wiring.read_data_1_out         <= reg_id_ex_wiring.read_data_1_in;
        reg_id_ex_wiring.read_data_2_out         <= reg_id_ex_wiring.read_data_2_in;
        reg_id_ex_wiring.immediate_gen_out       <= reg_id_ex_wiring.immediate_gen_in;
        reg_id_ex_wiring.instruction_11_7_out    <= reg_id_ex_wiring.instruction_11_7_in;
        reg_id_ex_wiring.instruction_14_12_out   <= reg_id_ex_wiring.instruction_14_12_in;
        reg_id_ex_wiring.instruction_30_out      <= reg_id_ex_wiring.instruction_30_in;
    end
end
    
endmodule