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
  ADD     = 4'b0000,
  SUB     = 4'b0001,
  AND     = 4'b0010,
  OR      = 4'b0011,
  XOR     = 4'b0100,
  COMPEQ  = 4'b0101,
  COMP    = 4'b0110
} operations;

// Assign the value for zero wire
assign Zero = (operation_result == 0) ? 1'b1 : 1'b0;

always_comb begin
  case(operation)
    	ADD:  		operation_result  	= input1 + 	input2;   

    	SUB:  		operation_result  	= input1 - 	input2;  
         
    	AND:  		operation_result  	= input1 & 	input2;    
      
    	OR:   		operation_result  	= input1 | 	input2;     
      
    	XOR:  		operation_result  	= input1 ^  input2;     
      
    	COMP: 		operation_result	= input1 <	input2;
      
    	COMPEQ: 	operation_result	= input1 <= input2;
      
    	default: 	operation_result 	= 0;
  endcase
end

    
endmodule