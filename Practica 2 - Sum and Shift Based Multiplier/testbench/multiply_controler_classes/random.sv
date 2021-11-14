// RANDOM GENERATOR of A and B
`include "../interface.sv"

class RCSG #(int size);
	rand bit [size -1:0]  A_;
    rand bit [size -1:0]  B_;
endclass