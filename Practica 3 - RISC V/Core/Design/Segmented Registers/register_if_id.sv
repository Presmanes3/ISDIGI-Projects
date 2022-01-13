module register_if_id #(
    parameter data_bits = 32
) (

    input clk,
    input pc_write_id_enable,

    input       [data_bits - 1 : 0] pc_in,
    output reg  [data_bits - 1 : 0] pc_out,

    input       [data_bits - 1 : 0] instruction_in,
    output reg  [data_bits - 1 : 0] instruction_out,

    input flush_adder_enable,
    input flush_pc_enable,
    input pc_write_enable
);

always_ff @( posedge clk ) begin 
    if(pc_write_id_enable) pc_out <= pc_in;
    instruction_out <= instruction_in;
end
    
endmodule