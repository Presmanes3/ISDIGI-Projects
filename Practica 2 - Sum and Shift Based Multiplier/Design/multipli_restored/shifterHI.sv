
module shifterHI (mode, serial_data_in, parallel_data_in, parallel_data_out, CLOCK, RESET, enable, serial_data_out);

parameter size=8;

input CLOCK, RESET, mode, enable, serial_data_in;

input [size:0] parallel_data_in;

output reg [size:0] parallel_data_out;

output [1:0] serial_data_out;

// If mode == 0 : Serial
// If mode == 1 : Parallel

integer k; 

always @ (posedge CLOCK, negedge RESET)
	begin
	if ( !RESET )
		parallel_data_out <= 0;
	else begin
		if (enable == 1'b1) begin
			if(mode)begin
				parallel_data_out = parallel_data_in;
			end else begin 

				for ( k = 0; k < size  ; k++) begin
					parallel_data_out[k] = parallel_data_out[k+1];
				end

				parallel_data_out[size] = serial_data_in;
			end
		end 
		else parallel_data_out = 0;
	end
	end
	
 
assign serial_data_out = parallel_data_out[1:0];

endmodule