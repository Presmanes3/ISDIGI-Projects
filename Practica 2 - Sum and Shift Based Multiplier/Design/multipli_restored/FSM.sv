module FSM (CLK,RESET,START, shifter_LO_operational_mode, shifter_HI_operational_mode, shifter_X_enable, shifter_LO_enable, shifter_HI_enable, shifter_X_clear,shifter_HI_clear,shifter_LO_clear,accu_operational_mode_selector,control,register_M_enable,end_mult);

parameter n=8;
parameter M = $clog2(n);

input CLK;

input RESET;

wire [3:0] COUNT;
 
input START;

input [2:0] control;

reg counter_enable;

output reg end_mult;

output reg [1:0] accu_operational_mode_selector;

output reg shifter_LO_operational_mode,shifter_HI_operational_mode;

output reg register_M_enable, shifter_X_enable, shifter_HI_enable, shifter_LO_enable;

output reg shifter_HI_clear, shifter_X_clear, shifter_LO_clear;

reg counter_clear;


reg[3:0] state;


parameter [2:0] Idle = 3'b001, Inicio = 3'b010, OP = 3'b011, SHIFT = 3'b100, NOTIFY = 3'b101;

contador    contador(	.enable(counter_enable),
                     	.clk(CLK),
						.reset(RESET),
						.count(COUNT), 
						.clear(counter_clear));


always_ff @ (posedge CLK, negedge RESET)

  begin
if(!RESET) state <= Idle;
else
 
   begin
case(state)
	Idle : 
		begin if(START) state <= Inicio; 
		else state <= Idle; 
	end

	Inicio :
		begin 
		state <= OP;
		end

	OP : 
		begin 
		state <= SHIFT; 
		end

	SHIFT : 
		begin if(COUNT == n) 
			state <= NOTIFY; 
		else state <= OP; 
		end

	NOTIFY : 
		begin if(!START) 
			state <= Idle; 
		else 
			state <= NOTIFY; 
		end
	default: state<=Idle;
endcase
 
end
end
always_comb
	begin
	case(state)

	Idle : begin
		end_mult = 1'b0;
	end

	Inicio : begin  
		counter_enable = 1'b0;
		counter_clear = 1'b0;

		shifter_LO_enable = 1'b1;
		register_M_enable  = 1'b1;

		shifter_X_clear = 1'b0;
	end

	OP: begin
		counter_clear = 1'b1;
		counter_enable = 1'b1;

		if(!(control == 3'b000 || control == 3'b111))begin

			shifter_HI_operational_mode = 1'b1;
			shifter_HI_enable = 1'b1;

			if(control[1]^control[0] == 1'b1) begin
				if(control[2] == 1'b1) begin
					accu_operational_mode_selector = 2'b01;
				end else begin
					accu_operational_mode_selector = 2'b00;
				end
			end else begin
				if(control[2] == 1'b1) begin
					accu_operational_mode_selector = 2'b11;
				end else begin
					accu_operational_mode_selector = 2'b10;
				end
			end
		end 

		end

	SHIFT: begin
		counter_clear = 1'b1;

		shifter_LO_operational_mode=1'b0;
		shifter_HI_operational_mode=1'b0;

		shifter_HI_enable = 1'b1;
		shifter_LO_enable =1'b1;
		shifter_X_enable =1'b1;

		counter_enable = 1'b0;
	end

	NOTIFY: begin

		end_mult = 1'b1;
	end
endcase
end
endmodule 