interface jump_controller_interface;
    logic branch;
    logic [2:0] func_3_bits;
    logic zero;
    logic [31:0] alu_result;
    logic select;
endinterface //jump_controller_interface


module jump_controller (
    jump_controller_interface jump_controller_wiring
);

always_comb begin
    jump_controller_wiring.select = 1'b0;
    
    if(jump_controller_wiring.branch == 1'b1)begin
        case (jump_controller_wiring.func_3_bits)
            // BEQ
            3'b000: begin
                if(jump_controller_wiring.zero == 1'b1) jump_controller_wiring.select = 1'b1;
            end
            // BNE
            3'b001: begin
                if(jump_controller_wiring.zero == 1'b0) jump_controller_wiring.select = 1'b1;
            end 
            // BLT
            3'b100: begin
                if(jump_controller_wiring.alu_result == 32'd1) jump_controller_wiring.select = 1'b1;
            end 
            // BGE
            3'b101: begin
                if(jump_controller_wiring.alu_result == 32'd0) jump_controller_wiring.select = 1'b1;
            end 
            // BLTU
            3'b110: begin
                if(jump_controller_wiring.alu_result == 32'd1) jump_controller_wiring.select = 1'b1;
            end 
            // BGEU
            3'b111: begin
                if(jump_controller_wiring.alu_result == 32'd0) jump_controller_wiring.select = 1'b1;
            end 

            default: jump_controller_wiring.select = 1'b0;
        endcase
    end
end
endmodule