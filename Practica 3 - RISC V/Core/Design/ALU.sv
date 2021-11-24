/**
	@brief ALU module in charge of doing the operation between registers
*/
module ALU (
	input [31:0] input1,
	input [31:0] input2,

	input [3:0] operation,

	output reg [31:0] operation_result,
	output Zero
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
	SHIFT_RIGHT_ARIT 	= 4'b1111,
} operations;

// Assign the value for zero wire
assign Zero = (operation_result == 0) ? 1'b1 : 1'b0;

always_comb begin
  case(operation)
    	ADD:  	operation_result  	= input1 + 	input2;   						// add i2 to i1

    	SUB:  	operation_result  	= input1 - 	input2;  						// substract i2 to i1
         
    	AND:  	operation_result  	= input1 & 	input2;    						// AND i1 with i2
      
    	OR:		operation_result  	= input1 | 	input2;     					// OR i1 with i2
      
    	XOR:	operation_result  	= input1 ^  input2;   						// XOR i1 with i2
      
    	U_LOW_EQ:	operation_result	= input1 <= input2;						// Compare i1 <= i2 unsigned

      	S_LOW_EQ:   operation_result    = $signed(input1) <= $signed(input2);	// Compare i1 <= i2 signed

		U_HIGH_EQ:	operation_result 	= input1 >= input2;						// Compare i1 >= i2 unsigned

		S_HIGH_EQ:	operation_result 	= $signed(input1) >= $signed(input2);	// Compare i1 >= i2 signed

      	U_LOWER:    operation_result    = input1 < input2;						// Compare i1 < i2 unsigned

      	S_LOWER:    operation_result    = $signed(input1) < $signed(input2);	// Compare i1 < i2 signed

		U_HIGHER:   operation_result    = input1 > input2;						// Compare i1 > i2 unsigned

      	S_HIGHER:   operation_result    = $signed(input1) > $signed(input2);	// Compare i1 > i2 signed

		SHIFT_LEFT:	operation_result 	= input1 << input2;						// Shift left input2 times

		SHIFT_RIGHT_LOGIC:	operation_result = input1 >> input2;				// Shift right input2 times

		SHIFT_RIGHT_ARIT:	operation_result = input1 >>> input2;				// Shift right with sign extension
      
    	default: 	operation_result 	= 0;
  endcase
end

    
endmodule