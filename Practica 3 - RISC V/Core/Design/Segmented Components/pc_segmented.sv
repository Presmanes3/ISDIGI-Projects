interface pc_interface;
    logic [31:0] in;
	logic [31:0] out;
	logic pc_write_id_enable;
	logic clk;
	logic reset;
endinterface //pc_interface


module PC
#(parameter size = 32)
(
	pc_interface pc_wiring
);

always_ff @(posedge pc_wiring.clk or negedge pc_wiring.reset) begin
		if(!pc_wiring.reset) 	pc_wiring.out = 0;
		else begin
			if(pc_wiring.pc_write_id_enable) pc_wiring.out <= pc_wiring.in;
		end
	end
endmodule 
