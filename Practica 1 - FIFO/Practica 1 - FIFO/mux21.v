module mux21(
				IN_0,
				IN_1,
				
				OUT,
				
				SELECT
		
				);
				
parameter size = 8;

input [size - 1 : 0] IN_0;	
input [size - 1 : 0] IN_1;	
input SELECT;
				
output [size - 1 : 0] OUT;

assign OUT = (SELECT == 1) ? IN_0 : IN_1;
				
endmodule