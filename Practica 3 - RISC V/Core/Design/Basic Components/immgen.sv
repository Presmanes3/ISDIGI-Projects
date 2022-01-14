interface imm_gen_interface #(
    parameter size = 32
);
    logic  [size - 1 : 0]   instruction;
    logic  [size - 1 : 0]   out;
endinterface //imm_gen_interface


module imm_gen
#(parameter size = 32)
(
imm_gen_interface imm_gen_wiring

);
reg [19:0] sign_extention;

wire [6:0]  opcode;
wire [3:0]  alu_option;


assign opcode       = imm_gen_wiring.instruction[6:0];
assign alu_option   = {opcode[6:4], opcode[2]};

always_comb begin
    sign_extention  = 0;

    case(alu_option)
        // Type I
        4'b0010: begin
            sign_extention = {20{imm_gen_wiring.instruction[31]}};

            imm_gen_wiring.out[31:12]  = sign_extention; 
            imm_gen_wiring.out[11:0]   = imm_gen_wiring.instruction[31:20];
        end 
        // Type I
        4'b0000: begin
            sign_extention = {20{imm_gen_wiring.instruction[31]}};

            imm_gen_wiring.out[31:12]  = sign_extention; 
            imm_gen_wiring.out[11:0]   = imm_gen_wiring.instruction[31:20];
        end 
        // Type S 
        4'b1000: begin 
            sign_extention = {20{imm_gen_wiring.instruction[31]}};

            imm_gen_wiring.out[31:12]  = sign_extention;
            imm_gen_wiring.out[11:5]   = imm_gen_wiring.instruction[31:25];
            imm_gen_wiring.out[4:0]    = imm_gen_wiring.instruction[11:7];
        end

        4'b0100: begin 
            sign_extention = {20{imm_gen_wiring.instruction[31]}};

            imm_gen_wiring.out[31:12]  = sign_extention;
            imm_gen_wiring.out[11:5]   = imm_gen_wiring.instruction[31:25];
            imm_gen_wiring.out[4:0]    = imm_gen_wiring.instruction[11:7];
        end
        // Type SB
        4'b1100: begin 
            
            sign_extention = {20{imm_gen_wiring.instruction[31]}};

            imm_gen_wiring.out[31:12]  = sign_extention;
            imm_gen_wiring.out[11]     = imm_gen_wiring.instruction[7];
            imm_gen_wiring.out[10:5]   = imm_gen_wiring.instruction[30:25];
            imm_gen_wiring.out[4:1]    = imm_gen_wiring.instruction[11:8];
            imm_gen_wiring.out[0]      = 1'b0;
        end

    default: imm_gen_wiring.out = 0; 
    endcase
end
endmodule
