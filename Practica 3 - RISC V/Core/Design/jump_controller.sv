module jump_controller (
    input branch,
    input [2:0] func_3_bits,
    input zero,

    output reg select
);



always_comb begin
    select = 1'b0;
    
    if(branch == 1'b1)begin
        case (func_3_bits)
            3'b000: begin
                if(zero == 1'b1) select = 1'b1;
            end
            3'b001: begin
                if(zero == 1'b0) select = 1'b1;
            end 

            default: select = 1'b0;
        endcase
    end
end
endmodule