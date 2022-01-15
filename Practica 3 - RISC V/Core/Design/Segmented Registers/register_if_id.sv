
interface register_if_id_interface #(
    parameter data_bits = 32
);
    logic clk;
    logic pc_write_id_enable;

    logic  [data_bits - 1 : 0] pc_in;
    logic  [data_bits - 1 : 0] pc_out;

    logic  [data_bits - 1 : 0] instruction_in;
    logic  [data_bits - 1 : 0] instruction_out;

    logic flush_adder_enable;
    logic flush_pc_enable;
    logic pc_write_enable;
endinterface //register_if_id_interface

module register_if_id #(
    parameter data_bits = 32
) (
    register_if_id_interface reg_if_id_wiring
);

always_ff @( posedge reg_if_id_wiring.clk ) begin 
    if(reg_if_id_wiring.pc_write_id_enable) reg_if_id_wiring.pc_out <= reg_if_id_wiring.pc_in;

    reg_if_id_wiring.instruction_out <= reg_if_id_wiring.instruction_in;
end
    
endmodule