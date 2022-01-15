//`include "./Small Registers/register_wb.sv"
//`include "./Small Registers/register_m.sv"

interface register_ex_mem_interface #(
    parameter data_bits = 32
);
    logic clk;
    logic clear_pipeline;

    register_m_interface    m_wiring();
    register_wb_interface   wb_wiring();

    logic  [data_bits - 1 : 0] adder_sum_in;
    logic  [data_bits - 1 : 0] adder_sum_out;

    logic  [data_bits - 1 : 0] alu_result_in;
    logic  [data_bits - 1 : 0] alu_result_out;

    logic  [data_bits - 1 : 0] alu_zero_in;
    logic  [data_bits - 1 : 0] alu_zero_out;

    logic  [data_bits - 1 : 0] alu_read_data_2_in;
    logic  [data_bits - 1 : 0] alu_read_data_2_out;

    logic [2 : 0] func_3_bits_in;
    logic [2 : 0] func_3_bits_out;

    logic  [4:0] instruction_11_7_in;
    logic  [4:0] instruction_11_7_out;
endinterface //register_ex_mem_interface

module register_ex_mem #(
    parameter data_bits = 32
) (
    register_ex_mem_interface reg_ex_mem_wiring
);

// assign reg_ex_mem_wiring.m_wiring.n_enable_output   = reg_ex_mem_wiring.clear_pipeline;
// assign reg_ex_mem_wiring.wb_wiring.n_enable_output  = reg_ex_mem_wiring.clear_pipeline;

register_m register_m_instance(
    .wiring(reg_ex_mem_wiring.m_wiring)
);

register_wb register_wb_instance(
    .wiring(reg_ex_mem_wiring.wb_wiring)
);

assign reg_ex_mem_wiring.m_wiring.clk   = reg_ex_mem_wiring.clk;
assign reg_ex_mem_wiring.wb_wiring.clk  = reg_ex_mem_wiring.clk;

always_ff @( posedge reg_ex_mem_wiring.clk ) begin 
    if(!reg_ex_mem_wiring.clear_pipeline)begin
        reg_ex_mem_wiring.adder_sum_out           <= reg_ex_mem_wiring.adder_sum_in;
        reg_ex_mem_wiring.alu_result_out          <= reg_ex_mem_wiring.alu_result_in;
        reg_ex_mem_wiring.alu_zero_out            <= reg_ex_mem_wiring.alu_zero_in;
        reg_ex_mem_wiring.alu_read_data_2_out     <= reg_ex_mem_wiring.alu_read_data_2_in;
        reg_ex_mem_wiring.instruction_11_7_out    <= reg_ex_mem_wiring.instruction_11_7_in;
        reg_ex_mem_wiring.func_3_bits_out         <= reg_ex_mem_wiring.func_3_bits_in;
    end
end
    
endmodule