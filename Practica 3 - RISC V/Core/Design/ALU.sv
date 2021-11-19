module ALU (input1,input2,ALUresult,Zero,ALUop);
input [31:0] input1,input2;
output logic [31:0] ALUresult;
output logic Zero;
input [3:0] ALUop;
localparam [2:0] ADD= 3'b000, SUB=3'b001,AND=3'b010,OR=3'b011,XOR=3'b100,COMPEQ=3'b101, COMP=3'b110;
always_ff begin
ALUresult=0;
Zero=0;

case(ALUop)
    ADD: begin
        ALUresult= input1+ input2;
        if(ALUresult==0) 
          Zero=1'b1;
         else 
          Zero=1'b0;    
    end 

    SUB: begin 
        ALUresult= input1- input2;
        if(ALUresult==0) 
            Zero=1'b1;
        else 
            Zero=1'b0;    
    end    
    AND: begin
      ALUresult=input1 & input2;
      if(ALUresult==0)
        Zero=1'b1;
      else
        Zero=1'b0;       
    end
    OR: begin
        ALUresult=input1 | input2;
      if(ALUresult==0)
        Zero=1'b1;
      else
        Zero=1'b0;       
    end
     XOR: begin
        ALUresult=input1 ^  input2;
      if(ALUresult==0)
        Zero=1'b1;
      else
        Zero=1'b0;       
    end
    COMP: begin
		ALUresult=input1<input2;
    end 
    COMPEQ: begin
		ALUresult=input1<=input2;
     end  
    default: begin
        Zero=1'b1;
    end
endcase
    end



    
endmodule