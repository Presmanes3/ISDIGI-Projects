/**

@param alu_option   Signal from main control
*/
module alu_controller(
    input   [6:0]   func_7_bits,
    input   [2:0]   func_3_bits,

    input   [3:0]   alu_option,     // Signal for deciding type of instruction

    output  reg [3:0]   alu_operation  // Signal to the ALU
);

// Declare all the allowed operations
enum bit [3:0] {  
	ADD         		= 4'b0000,
	SUB         		= 4'b0001,
	AND         		= 4'b0010,
	OR          		= 4'b0011,
	XOR         		= 4'b0100,
	U_LOW_EQ    		= 4'b0101,	// NOT NEEDED
	S_LOW_EQ    		= 4'b0110,	// NOT NEEDED
	U_HIGH_EQ   		= 4'b0111,
	S_HIGH_EQ   		= 4'b1000,
	U_LOWER     		= 4'b1001,
	S_LOWER     		= 4'b1010,
	U_HIGHER    		= 4'b1011,
	S_HIGHER    		= 4'b1100,
	SHIFT_LEFT  		= 4'b1101,
	SHIFT_RIGHT_LOGIC 	= 4'b1110,
	SHIFT_RIGHT_ARIT 	= 4'b1111
} operations;


always_comb begin
    case (alu_option)

        4'b0000: begin
            case (func_3_bits)

                // LUI
                3'b010: alu_operation = ADD;

                default: alu_operation = ADD;
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

                // SLLI
                3'b001: alu_operation = SHIFT_LEFT;

                // SRLI
                3'b101: begin
                    if(func_7_bits) alu_operation = SHIFT_RIGHT_LOGIC;
                    else alu_operation = SHIFT_RIGHT_ARIT;
                end
                
                default: alu_operation = ADD;
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
                default: alu_operation = ADD;
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
                    default: alu_operation = ADD;
                endcase
            end else begin  // func_7_bits[5] == 1'b1
                case (func_3_bits)
                    // SUB
                    3'b000: alu_operation = SUB;
                    default: alu_operation = ADD;
                endcase
            end
            
        end

        4'b0111: begin
            case (func_3_bits)
                // LUI
                3'b000: alu_operation = ADD;
                default: alu_operation = ADD;
            endcase
        end

        4'b1100: begin
            case (func_3_bits)
                // BEQ
                3'b000: alu_operation = SUB;

                // BNE
                3'b001: alu_operation = XOR;

                // BLT 
                3'b100: alu_operation = S_LOWER;

                // BGE
                3'b101: alu_operation = S_HIGH_EQ;

                // BLTU
                3'b110: alu_operation = U_LOWER;

                // BGEU
                3'b111: alu_operation = U_HIGH_EQ;
                default: alu_operation = ADD;
            endcase
        end
        default: alu_operation = ADD;
    endcase
end


endmodule