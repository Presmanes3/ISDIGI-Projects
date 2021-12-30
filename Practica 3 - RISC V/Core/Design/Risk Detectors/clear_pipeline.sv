module clear_pipeline(
    input branch_mux_mem,
    input jump_pc_mem,

    input clk,
    input reset,

    output reg clear_pipeline
);

always_ff @( posedge clk or negedge reset) begin
    clear_pipeline = 0;
    if(!reset) clear_pipeline = 0;
    else if(branch_mux_mem || jump_pc_mem) clear_pipeline = 1;
end
endmodule