/**

@param alu_option   Signal from main control
*/
interface alu_controler_interface;
    logic [6:0] func_7_bits;
    logic [2:0] func_3_bits;
    logic [3:0] alu_option;
    logic [3:0] alu_operation;
endinterface //interfacename


module alu_controller(
    alu_controler_interface alu_controler_wiring
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
    case (alu_controler_wiring.alu_option)

        4'b0000: begin
            case (alu_controler_wiring.func_3_bits)

                // LUI
                3'b010: alu_controler_wiring.alu_operation = ADD;

                default: alu_controler_wiring.alu_operation = ADD;
            endcase
        end

        4'b0010: begin
            case (alu_controler_wiring.func_3_bits)
                // ADDI
                3'b000: alu_controler_wiring.alu_operation = ADD;
                
                // SLTI
                3'b010: alu_controler_wiring.alu_operation = S_LOWER;
                
                // SLTIU
                3'b011: alu_controler_wiring.alu_operation = U_LOWER;
                
                // XORI
                3'b100: alu_controler_wiring.alu_operation = XOR;
                
                // ORI
                3'b110: alu_controler_wiring.alu_operation = OR;
                
                // ANDI
                3'b111: alu_controler_wiring.alu_operation = AND;

                // SLLI
                3'b001: alu_controler_wiring.alu_operation = SHIFT_LEFT;

                3'b101: begin
                    // SRLI
                    if(alu_controler_wiring.func_7_bits[5]) alu_controler_wiring.alu_operation = SHIFT_RIGHT_LOGIC;

                    // SRAI
                    else alu_controler_wiring.alu_operation = SHIFT_RIGHT_ARIT;
                end

                default: alu_controler_wiring.alu_operation = ADD;
            endcase
            
        end

        4'b0011: begin
            // AUIPC
            alu_controler_wiring.alu_operation = ADD;
        end

        4'b0100: begin
            case (alu_controler_wiring.func_3_bits)
                //SW
                3'b010: alu_controler_wiring.alu_operation = ADD;
                default: alu_controler_wiring.alu_operation = ADD;
            endcase
        end

        4'b0110: begin

            if(alu_controler_wiring.func_7_bits[5] == 1'b0)begin
                case (func_3_bits)
                    // ADD
                    3'b000: alu_controler_wiring.alu_operation = ADD;

                    // SLL
                    3'b001: alu_controler_wiring.alu_operation = SHIFT_LEFT;

                    // SLT 
                    3'b010: alu_controler_wiring.alu_operation = S_LOWER;

                    // SLTU
                    3'b011: alu_controler_wiring.alu_operation = U_LOWER;

                    // XOR
                    3'b100: alu_controler_wiring.alu_operation = XOR;

                    // SRL
                    3'b101: alu_controler_wiring.alu_operation = SHIFT_RIGHT_LOGIC;

                    // OR
                    3'b110: alu_controler_wiring.alu_operation = OR;

                    // AND
                    3'b111: alu_controler_wiring.alu_operation = AND;
                    default: alu_controler_wiring.alu_operation = ADD;
                endcase
            end else begin  // func_7_bits[5] == 1'b1
                case (alu_controler_wiring.func_3_bits)
                    // SUB
                    3'b000: alu_controler_wiring.alu_operation = SUB;

                    // SRA
                    3'b101: alu_controler_wiring.alu_operation = SHIFT_RIGHT_ARIT;
                    default: alu_controler_wiring.alu_operation = ADD;
                endcase
            end
            
        end

        4'b0111: begin
            case (alu_controler_wiring.func_3_bits)
                // LUI
                3'b000: alu_controler_wiring.alu_operation = ADD;
                default: alu_controler_wiring.alu_operation = ADD;
            endcase
        end

        4'b1100: begin
            case (alu_controler_wiring.func_3_bits)
                // BEQ
                3'b000: alu_controler_wiring.alu_operation = SUB;

                // BNE
                3'b001: alu_controler_wiring.alu_operation = XOR;

                // BLT 
                3'b100: alu_controler_wiring.alu_operation = S_LOWER;

                // BGE
                3'b101: alu_controler_wiring.alu_operation = S_HIGH_EQ;

                // BLTU
                3'b110:alu_controler_wiring. alu_operation = U_LOWER;

                // BGEU
                3'b111: alu_controler_wiring.alu_operation = U_HIGH_EQ;
                default: alu_controler_wiring.alu_operation = ADD;
            endcase
        end

        4'b1101:begin
            // JAL y JALR
            alu_controler_wiring.alu_operation = ADD;
        end
        default: alu_controler_wiring.alu_operation = ADD;
    endcase
end


endmodule