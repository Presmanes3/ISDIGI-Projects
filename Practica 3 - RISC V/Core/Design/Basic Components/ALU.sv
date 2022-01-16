interface ALU_interface();
	logic [31:0] input1;
	logic [31:0] input2;

	logic [3:0] operation;

	logic [31:0] result;
	logic zero;
endinterface//ALU_interface

module ALU (
	ALU_interface alu_wiring	
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

// Assign the value for zero wire
assign alu_wiring.zero = (alu_wiring.result == 0) ? 1'b1 : 1'b0;

always_comb begin
  case(alu_wiring.operation)
    	ADD:  	alu_wiring.result  	= alu_wiring.input1 + 	alu_wiring.input2;   						// add i2 to i1

    	SUB:  	alu_wiring.result  	= alu_wiring.input1 - 	alu_wiring.input2;  						// substract i2 to i1
         
    	AND:  	alu_wiring.result  	= alu_wiring.input1 & 	alu_wiring.input2;    						// AND i1 with i2
      
    	OR:		alu_wiring.result  	= alu_wiring.input1 | 	alu_wiring.input2;     					// OR i1 with i2
      
    	XOR:	alu_wiring.result  	= alu_wiring.input1 ^  alu_wiring.input2;   						// XOR i1 with i2
      
    	U_LOW_EQ:	alu_wiring.result	= alu_wiring.input1 <= alu_wiring.input2;						// Compare i1 <= i2 unsigned

      	S_LOW_EQ:   alu_wiring.result    = $signed(alu_wiring.input1) <= $signed(alu_wiring.input2);	// Compare i1 <= i2 signed

		U_HIGH_EQ:	alu_wiring.result 	= alu_wiring.input1 >= alu_wiring.input2;						// Compare i1 >= i2 unsigned

		S_HIGH_EQ:	alu_wiring.result 	= $signed(alu_wiring.input1) >= $signed(alu_wiring.input2);	// Compare i1 >= i2 signed

      	U_LOWER:    alu_wiring.result    = alu_wiring.input1 < alu_wiring.input2;						// Compare i1 < i2 unsigned

      	S_LOWER:    alu_wiring.result    = $signed(alu_wiring.input1) < $signed(alu_wiring.input2);	// Compare i1 < i2 signed

		U_HIGHER:   alu_wiring.result    = alu_wiring.input1 > alu_wiring.input2;						// Compare i1 > i2 unsigned

      	S_HIGHER:   alu_wiring.result    = $signed(alu_wiring.input1) > $signed(alu_wiring.input2);	// Compare i1 > i2 signed

		SHIFT_LEFT:	alu_wiring.result 	= alu_wiring.input1 << alu_wiring.input2;						// Shift left alu_wiring.input2 times

		SHIFT_RIGHT_LOGIC:	alu_wiring.result = alu_wiring.input1 >> alu_wiring.input2;				// Shift right input2 times

		SHIFT_RIGHT_ARIT:	alu_wiring.result = alu_wiring.input1 >>> alu_wiring.input2;				// Shift right with sign extension
      
    	default: 	alu_wiring.result 	= 0;
  endcase
end

    
endmodule