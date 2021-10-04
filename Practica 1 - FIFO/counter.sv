

module counter(
					// Inputs
					CLK,
					RST_N,
					ENABLE,
					
					// Outputs
					END_COUNT,
					OUT,
					
					MODE
					);
					
`include "MathFun.vh"

					
input CLK;
input RST_N;
input ENABLE;
input MODE;


output END_COUNT;


parameter final_value = 0;
parameter n	= CLogB2(final_value - 1);		

output reg [n - 1 : 0] OUT;	


always @(posedge CLK or negedge RST_N)
	if(!RST_N)
		OUT <= 0;
	else if(ENABLE)begin
		if(MODE == 1)
			OUT <= OUT + 1;
		else
			OUT <= OUT - 1;
	end
	
assign END_COUNT = (OUT == (final_value - 1) ? 1 : 0);

					
					
endmodule