

module shifterLO (mode, serial_data_in, parallel_data_in, parallel_data_out, CLOCK, RESET, enable, serial_data_out);

parameter size=8;

input CLOCK, RESET, mode, enable;

input [size-1:0] parallel_data_in;
input [1:0] serial_data_in;

output reg [size-1:0] parallel_data_out;

output [1:0] serial_data_out;


// If mode == 0 : Serial
// If mode == 1 : parallel_data_inarallel

integer k; 

always @ (posedge CLOCK, negedge RESET)
	begin
	if ( !RESET )
		parallel_data_out <= 0;
	else if (enable)
		begin
			if(mode == 1'b1)begin
				parallel_data_out <= parallel_data_in;	
			end else begin
				for ( k = 0; k < size - 1; k = k + 1) parallel_data_out[k] <= parallel_data_out[k+1];

				parallel_data_out[size : size - 1] <= serial_data_in;
			end
		end 
	end

assign serial_data_out = parallel_data_out[1:0];

endmodule