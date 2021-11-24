/**

@param alu_option   Signal from main control
*/
module alu_controller(
    input   [6:0]   func_7_bits;
    input   [2:0]   func_3_bits;

    input   [3:0]   alu_option;     // Signal for deciding type of instruction

    output  [3:0]   alu_operation;  // Signal to the ALU
);

// Declare all the allowed operations
enum bit [3:0] {  
	ADD         = 4'b0000,
	SUB         = 4'b0001,
	AND         = 4'b0010,
	OR          = 4'b0011,
	XOR         = 4'b0100,
	U_LOW_EQ    = 4'b0101,
	S_LOW_EQ    = 4'b0110,
	U_HIGH_EQ   = 4'b0111,
	S_HIGH_EQ   = 4'b1000,
	U_LOWER     = 4'b1001,
	S_LOWER     = 4'b1010,
	U_HIGHER    = 4'b1011,
	S_HIGHER    = 4'b1100,
	SHIFT_LEFT  = 4'b1101,
	SHIFT_RIGHT = 4'b1110,
} operations;


always_comb begin
    case (alu_option)

        4'b0000: begin
            case (func_3_bits)

                // LUI
                3'b010: alu_operation = ADD;

                default: 
            endcase
        end

        4'b0010: begin
            case (func_3_bits)
                // ADDI
                3'b000: alu_operation = ADD;
                
                // SLTI
                3'b010: alu_operation = S_LOWER;
                
                // SLTIU
                3'b011: alu_operation = U_LOWER;
                
                // XORI
                3'b100: alu_operation = XOR;
                
                // ORI
                3'b110: alu_operation = OR;
                
                // ANDI
                3'b111: alu_operation = AND;
                default: 
            endcase
            
        end

        4'b0011: begin
            // AUIPC
            alu_operation = ADD;
        end

        4'b0100: begin
            case (func_3_bits)
                //SW
                3'b010: alu_operation = ADD;
                default: 
            endcase
        end

        4'b0110: begin

            if(func_7_bits[5] == 1'b0)begin
                case (func_3_bits)
                    // ADD
                    3'b000: alu_operation = ADD;

                    // SLT 
                    3'b010: alu_operation = S_LOWER;

                    // SLTU
                    3'b011: alu_operation = U_LOWER;

                    // XOR
                    3'b100: alu_operation = XOR;

                    // OR
                    3'b110: alu_operation = OR;

                    // AND
                    3'b111: alu_operation = AND;
                    default: 
                endcase
            end else begin  // func_7_bits[5] == 1'b1
                case (func_3_bits)
                    // SUB
                    3'b000: alu_operation = SUB;
                    default: 
                endcase
            end
            
        end

        4'b0111: begin
            // LUI
            3'b000: alu_operation = ADD;
        end

        4'b1100: begin
            case (func_3_bits)
                // BEQ
                3'b000: alu_operation = SUB;

                // BNE
                3'b001: alu_operation = XOR;
                default: 
            endcase
        end
        default: 
    endcase
end


endmodule