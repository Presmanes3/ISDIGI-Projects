
interface register_wb_interface();
    logic clk;

    logic reg_write_in;
    logic jump_rd_in;
    logic mem_to_reg_in;

    logic reg_write_out;
    logic jump_rd_out;
    logic mem_to_reg_out;
endinterface //register_wb_interface


module register_wb (
    register_wb_interface wiring
);

always_ff @( posedge wiring.clk ) begin 
    wiring.reg_write_out     <= wiring.reg_write_in;
    wiring.jump_rd_out       <= wiring.jump_rd_in;
    wiring.mem_to_reg_out    <= wiring.mem_to_reg_in;
end
    
endmodule