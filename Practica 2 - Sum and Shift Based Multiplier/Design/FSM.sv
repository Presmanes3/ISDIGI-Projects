module FSM 
#(parameter size = 8)
(
	input CLOCK,
	input RESET,
	input START,

	input [2 : 0] control,

	output reg shifter_HI_shift_enable,
	output reg shifter_HI_load_enable,
	output reg shifter_HI_clear,

	output reg shifter_LO_shift_enable,
	output reg shifter_LO_load_enable,
	output reg shifter_LO_clear,

	output reg register_M_enable,
	output reg register_M_clear,

	output reg register_X_enable,
	output reg register_X_clear,

	output reg adder_enable,
	output reg [1 : 0] adder_mode,

	output reg END_MULT
);


parameter mod = $clog2(size);
wire [mod:0] count_value;

reg counter_enable;
reg counter_clear;


reg[3:0] state;


localparam [2:0] IDLE = 3'b001, INICIO = 3'b010, OP = 3'b011, SHIFT = 3'b100, NOTIFY = 3'b101;

contador    #(.size(size)) contador(	.enable(counter_enable),
                     	.clk(CLOCK),
						.reset(RESET),
						.count(count_value), 
						.clear(counter_clear));


always_ff @ (posedge CLOCK or negedge RESET) begin
	if(!RESET) state <= IDLE;
	else begin
		case(state)
			IDLE : begin 
				if(START) 	state <= INICIO; 
				else 		state <= IDLE; 
			end

			INICIO : begin 
				state <= OP;
			end

			OP : begin 
				state <= SHIFT; 
			end

			SHIFT :begin 
				if(count_value == size) state <= NOTIFY; 
				else 					state <= OP; 
			end

			NOTIFY :  begin 
				if(!START) 	state <= IDLE; 
				else 		state <= NOTIFY; 
			end
			default: 		state <= IDLE;
		endcase
 
	end
end
always_comb begin
			shifter_HI_shift_enable = 1'b0;
			shifter_HI_load_enable 	= 1'b0;
			shifter_HI_clear 		= 1'b0;

			shifter_LO_shift_enable = 1'b0;
			shifter_LO_load_enable 	= 1'b0;
			shifter_LO_clear 		= 1'b0;

			register_M_enable 		= 1'b0;
			register_M_clear 		= 1'b0;

			register_X_enable 		= 1'b0;
			register_X_clear 		= 1'b0;

			adder_enable 			= 1'b0;
			adder_mode 				= 1'b0;

			END_MULT 				= 1'b0;

			counter_clear			= 1'b0;
			counter_enable			= 1'b0;
	case(state)

		IDLE : begin
				shifter_HI_shift_enable = 1'b0;
				shifter_HI_load_enable 	= 1'b0;
				shifter_HI_clear 		= 1'b0;

				shifter_LO_shift_enable = 1'b0;
				shifter_LO_load_enable 	= 1'b0;
				shifter_LO_clear 		= 1'b0;

				register_M_enable 		= 1'b0;
				register_M_clear 		= 1'b0;

				register_X_enable 		= 1'b0;
				register_X_clear 		= 1'b0;

				adder_enable 			= 1'b0;
				adder_mode 				= 1'b0;

				END_MULT 		= 1'b0;
		end

		INICIO : begin  
				shifter_HI_shift_enable = 1'b0;
				shifter_HI_load_enable 	= 1'b0;
				shifter_HI_clear 		= 1'b0;

				shifter_LO_shift_enable = 1'b0;
				shifter_LO_load_enable 	= 1'b1;
				shifter_LO_clear 		= 1'b1;

				register_M_enable 		= 1'b1;
				register_M_clear 		= 1'b1;

				register_X_enable 		= 1'b0;
				register_X_clear 		= 1'b0;

				adder_enable 			= 1'b0;
				adder_mode 				= 1'b0;

				END_MULT 				= 1'b0;
		end

		OP: begin

				shifter_HI_shift_enable = 1'b0;
				shifter_HI_clear 		= 1'b1;
				

				shifter_LO_shift_enable = 1'b0;
				shifter_LO_load_enable 	= 1'b0;
				shifter_LO_clear 		= 1'b1;

				register_M_enable 		= 1'b0;
				register_M_clear 		= 1'b1;

				register_X_enable 		= 1'b0;
				register_X_clear 		= 1'b1;

				adder_enable 			= 1'b0;
				adder_mode 				= 1'b0;

				END_MULT 				= 1'b0;

				counter_clear			= 1'b1;
				counter_enable			= 1'b1;

			if(!(control == 3'b000 || control == 3'b111)) begin

				shifter_HI_load_enable 	= 1'b1;
				
			
				adder_enable = 1'b1;

				if( control[1] ^ control[0] == 1'b1) begin
					if(control[2] == 1'b1) 	adder_mode = 2'b01;
					else 					adder_mode = 2'b00;
				
				end else begin
					if(control[2] == 1'b1) 	adder_mode = 2'b11;
					else 					adder_mode = 2'b10;
				end
			end 
		end

		SHIFT: begin
			shifter_HI_shift_enable = 1'b1;
			shifter_HI_load_enable 	= 1'b0;
			shifter_HI_clear 		= 1'b1;

			shifter_LO_shift_enable = 1'b1;
			shifter_LO_load_enable 	= 1'b0;
			shifter_LO_clear 		= 1'b1;

			register_M_enable 		= 1'b0;
			register_M_clear 		= 1'b1;

			register_X_enable 		= 1'b1;
			register_X_clear 		= 1'b1;

			adder_enable 			= 1'b0;
			adder_mode 				= 1'b0;

			END_MULT 				= 1'b0;

			counter_clear			= 1'b1;
			counter_enable			= 1'b0;
		end

		NOTIFY: begin
			shifter_HI_shift_enable = 1'b0;
			shifter_HI_load_enable 	= 1'b0;
			shifter_HI_clear 		= 1'b1;

			shifter_LO_shift_enable = 1'b0;
			shifter_LO_load_enable 	= 1'b0;
			shifter_LO_clear 		= 1'b1;

			register_M_enable 		= 1'b0;
			register_M_clear 		= 1'b1;

			register_X_enable 		= 1'b0;
			register_X_clear 		= 1'b1;

			adder_enable 			= 1'b0;
			adder_mode 				= 1'b0;

			END_MULT 				= 1'b1;

			counter_clear			= 1'b1;
			counter_enable			= 1'b0;
		end
		default: begin
			shifter_HI_shift_enable = 1'b0;
			shifter_HI_load_enable 	= 1'b0;
			shifter_HI_clear 		= 1'b0;

			shifter_LO_shift_enable = 1'b0;
			shifter_LO_load_enable 	= 1'b0;
			shifter_LO_clear 		= 1'b0;

			register_M_enable 		= 1'b0;
			register_M_clear 		= 1'b0;

			register_X_enable 		= 1'b0;
			register_X_clear 		= 1'b0;

			adder_enable 			= 1'b0;
			adder_mode 				= 1'b0;

			END_MULT 				= 1'b0;

			counter_clear			= 1'b0;
			counter_enable			= 1'b0;
		end
	endcase
end


// Check that end multiplication is set to high every 2 + size clock cycles when start is set to 1
realizar_mult:assert property (@(posedge CLOCK) disable iff(RESET==1'b0) START |-> ##(2+size) END_MULT==1'b1 ) else $error("CHEQUEO FSM: la multiplicación no dura los procesos que debería"); 

endmodule 