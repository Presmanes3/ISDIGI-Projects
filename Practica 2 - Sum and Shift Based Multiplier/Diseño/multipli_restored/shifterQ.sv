

module shifterQ (SHIFTn_LOAD, DIN_SERIAL, P, Q, CLOCK, RESET, ENABLE, DOUT_SERIAL);

parameter tamano=8;

input CLOCK, RESET, SHIFTn_LOAD, ENABLE, DIN_SERIAL;

input [tamano:0] P;

output reg [tamano:0] Q;

output [1:0] DOUT_SERIAL;


integer k; 

always @ (posedge CLOCK, negedge RESET)
	begin
	if ( !RESET )
		Q <= 0;
	else if ( SHIFTn_LOAD )
		Q <= P;
	else if (ENABLE)
		begin
			for ( k=0; k<tamano-1; k=k+1)
			Q[k] <= Q[k+1];
			Q[tamano-1] <= DIN_SERIAL;
		end 
		else Q <= 0;
	end
	
 
assign DOUT_SERIAL = Q[1:0];


endmodule