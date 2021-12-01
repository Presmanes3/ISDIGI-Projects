
/**
    @brief main controller circuit for controlling signals of the different modules

    @input opcode operational code

    @output branch
    @output memory_read signal for enabling memory read
    @output memory_to_register signal for selecting value from RAM memory or ALU output
    @output alu_option 
    @output memory_write signal for writing in memory
    @output alu_source signal for selecting source of ALU
    @output register_write signal for writing in register bank

    @outputAuipcLui

*/
module main_controller(

    input [6:0] opcode,

    output reg branch,
    output reg memory_read,
    output reg memory_to_register,
    output [3:0] alu_option,
    output reg memory_write,
    output reg alu_source,
    output reg register_write,

    output reg [1:0] AuipcLui    
);


assign alu_option = {opcode[6:4], opcode[2]};

always_comb begin
    AuipcLui = 2'b10;
    case (alu_option)

        // Type LOAD
        4'b0000: begin
            alu_source          = 1'b1;
            memory_to_register  = 1'b1; 
            memory_read         = 1'b1;
            memory_write        = 1'b0;
            register_write      = 1'b1; 
            branch              = 1'b0; 
        end

        // Type I
        4'b0010: begin
            alu_source          = 1'b1;
            memory_to_register  = 1'b0;
            memory_read         = 1'b0;
            memory_write        = 1'b0;
            register_write      = 1'b1;
            branch              = 1'b0;
        end

        4'b0011: begin

        end

        // Type STORAGE
        4'b0100: begin
            alu_source          = 1'b1;
            memory_to_register  = 1'b0;
            memory_read         = 1'b0;
            memory_write        = 1'b1; 
            register_write      = 1'b0;
            branch              = 1'b0;
        end

        // Type R
        4'b0110: begin
            alu_source          = 1'b0;
            memory_to_register  = 1'b0;
            memory_read         = 1'b0;
            memory_write        = 1'b0;
            register_write      = 1'b1;
            branch              = 1'b0;
        end

        4'b0111: begin

        end

        // Type CONDITIONAL JUMP
        4'b1100: begin
            alu_source          = 1'b0;
            memory_to_register  = 1'b0;
            memory_read         = 1'b0;
            memory_write        = 1'b0;
            register_write      = 1'b0;
            branch              = 1'b1;
        end
        default: begin
            alu_source          = 1'b0;
            memory_to_register  = 1'b0;
            memory_read         = 1'b0;
            memory_write        = 1'b0;
            register_write      = 1'b0;
            branch              = 1'b0;    
        end
    endcase
end

endmodule