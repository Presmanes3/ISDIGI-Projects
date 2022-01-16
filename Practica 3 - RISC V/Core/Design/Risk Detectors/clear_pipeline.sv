interface clear_pipeline_interface;
    logic  branch_mux_mem;
    logic  jump_pc_mem;

    logic  clk;
    logic  reset;

    logic clear_pipeline;
endinterface //interfacename



module clear_pipeline(
    clear_pipeline_interface wiring
);

always_ff @( posedge wiring.clk or negedge wiring.reset) begin
    if(!wiring.reset) wiring.clear_pipeline <= 0;
    else if(wiring.branch_mux_mem || wiring.jump_pc_mem) wiring.clear_pipeline <= 1;
end
endmodule