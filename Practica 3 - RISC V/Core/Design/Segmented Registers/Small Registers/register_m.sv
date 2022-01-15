interface register_m_interface();
    logic clk;

    logic jump_pc_in;
    logic [4 : 0] instruction_func_in;
    logic force_jump_in;
    logic branch_in;
    logic mem_write_in;
    logic mem_read_in;

    logic jump_pc_out;
    logic [4 : 0] instruction_func_out;
    logic force_jump_out;
    logic branch_out;
    logic mem_write_out;
    logic mem_read_out;

endinterface //register_m_interface


module register_m (
    register_m_interface wiring
);

always_ff @( posedge wiring.clk ) begin 
    wiring.jump_pc_out          <= wiring.jump_pc_in;
    wiring.instruction_func_out <= wiring.instruction_func_in;
    wiring.force_jump_out       <= wiring.force_jump_in;
    wiring.branch_out           <= wiring.branch_in;
    wiring.mem_write_out        <= wiring.mem_write_in;
    wiring.mem_read_out         <= wiring.mem_read_in;
end
    
endmodule