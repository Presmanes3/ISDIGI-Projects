interface register_ex_interface();
    logic clk;

    logic [3:0] alu_op_in;
    logic alu_src_in;
    logic lui_src_in;

    logic [3:0] alu_op_out;
    logic alu_src_out;
    logic lui_src_out;
endinterface //register_ex_interface


module register_ex (
    register_ex_interface wiring
);

always_ff @( posedge wiring.clk ) begin
    wiring.alu_op_out     <= wiring.alu_op_in;
    wiring.alu_src_out    <= wiring.alu_src_in;
    wiring.lui_src_out    <= wiring.lui_src_in;
end
    
endmodule