interface FIFO_IFF;
	// Declare inputs
	logic [7:0] DATA_IN;
	logic READ;
	logic WRITE;
	logic CLEAR_N;
	logic RESET_N;
	logic CLK;

	// Declare outputs
	logic [7:0] DATA_OUT;
	logic F_FULL_N;			// Used to indicate that FIFO is full
	logic F_EMPTY_N;			// Used to indicate that FIFO is empty
	logic [4:0] USE_DW;		// Used to indicate how many elements are in use

endinterface


module FIFO_32_8(
	FIFO_IFF fifo_iff
	);
						
						
typedef enum bit[1:0] {EMPTY = 2'b00, OTHER = 2'b01, FULL = 2'b10} STATES;

STATES current_state 	= EMPTY;
STATES next_state		= EMPTY;

// ====== COUNTER W REGISTERS ===== //
reg counter_w_end;
reg counter_w_enable = 1'b0;;
reg [4:0]counter_w_current_value;

// ====== COUNTER R REGISTERS ===== //
reg counter_r_end;
reg counter_r_enable 				= 1'b0;
reg [4:0]counter_r_current_value;

// ====== COUNTER DW REGISTERS ===== //
reg use_dw_end;
reg counter_dw_enable 	= 1'b0;

reg counter_dw_mode 	= 1'b1;

// ===== CONCATENATION WRITE-READ INPUTS ===== //
wire [1:2] read_write_conc;

assign read_write_conc = {fifo_iff.WRITE, fifo_iff.READ};

// ===== RESET CONTROLLER ===== //
reg reset_sinc	= 1'b1;
reg reset_asinc	= 1'b1;

wire reset_controller;

assign reset_controller = reset_sinc && reset_asinc;

// ===== ACTIVATION FLAGS ===== //
wire flag_use_dw_31;
assign flag_use_dw_31 = fifo_iff.USE_DW == 31;

wire flag_use_dw_1;
assign flag_use_dw_1 = fifo_iff.USE_DW == 1;

// ===== OTHERS ===== //
wire [7:0] ram_data_out;
reg output_selector = 1'b0;



// output_selector == 0 > DATA_IN
// output_selector == 1 > ram_data_out 
mux21 out_mux(
					.IN_0(fifo_iff.DATA_IN),
					.IN_1(ram_data_out),
					.CLK(fifo_iff.CLK),
					.SELECT(output_selector),
					.OUT(fifo_iff.DATA_OUT)
					);
					
defparam out_mux.size = 8;

// Instanciate the data path 
counter counter_w (
						.CLK(fifo_iff.CLK),
						.RST_N(reset_controller),
						.ENABLE(counter_w_enable),
						.END_COUNT(counter_w_end),
						.OUT(counter_w_current_value),
						.MODE(1'b1)								// Force mode to up-counter
						);
defparam counter_w.final_value = 32;

counter counter_r (
						.CLK(fifo_iff.CLK),
						.RST_N(reset_controller),
						.ENABLE(counter_r_enable),
						.END_COUNT(counter_r_end),
						.OUT(counter_r_current_value),
						.MODE(1'b1)								// Force mode to up-counter
						);
defparam counter_r.final_value = 32;

counter use_dw (
						.CLK(fifo_iff.CLK),
						.ENABLE(counter_dw_enable),
						.RST_N(reset_controller),
						.END_COUNT(use_dw_end),
						.OUT(fifo_iff.USE_DW),
						.MODE(counter_dw_mode)
						);
defparam use_dw.final_value = 32;

RAM_DP	#(.mem_depth(32),  .size(8)) PILA
				  (.data_in(fifo_iff.DATA_IN),
					.wren (fifo_iff.WRITE),
					.clock(fifo_iff.CLK),
					.rden(fifo_iff.READ),
					.data_out(ram_data_out),
					.rdaddress(counter_r_current_value),
					.wraddress(counter_w_current_value)
					);
					
always @(negedge fifo_iff.RESET_N or posedge fifo_iff.CLK)begin
	reset_asinc = 1;
	
	if(!fifo_iff.RESET_N)begin
		current_state 		= EMPTY;
		reset_asinc = 0;
	end
	else begin
		
		current_state		= next_state;
	end
end
	

//, read_write_conc, flag_use_dw_31, flag_use_dw_1
always @( current_state, read_write_conc, flag_use_dw_31, flag_use_dw_1 ) begin

	next_state = current_state;
	reset_sinc = 1;

	counter_r_enable 	= 0;
	counter_w_enable 	= 0;
	counter_dw_enable 	= 0;

	if(fifo_iff.CLEAR_N == 0)begin 
		reset_sinc = 0;
	end
	
	case(current_state)
		EMPTY: begin
			fifo_iff.F_EMPTY_N = 1'b0;
			fifo_iff.F_FULL_N = 1'b1;
			
			case(read_write_conc)
			
				// WRITE = 0 || READ = 0
				2'b00: 	begin
					next_state 			= EMPTY;
				end		
					
				// WRITE = 0 || READ = 1
				2'b01:	begin
					next_state 			= EMPTY;
				end
				
				// WRITE = 1 || READ = 0
				2'b10:begin			
					counter_w_enable 	= 1;
					counter_dw_mode		= 1;
					counter_dw_enable 	= 1;
					next_state 			= OTHER;
				end
				
				
				// WRITE = 1 || READ = 1
				2'b11:begin			
					next_state 			= EMPTY;
					
					output_selector 	= 1;
				end
			
				default:begin 
				end
				
			endcase
		end
		
		OTHER: begin
			fifo_iff.F_EMPTY_N = 1'b1;
			fifo_iff.F_FULL_N = 1'b1;
			
			case(read_write_conc)
			
				// WRITE = 0 || READ = 0
				2'b00:	next_state 	= OTHER;

				// WRITE = 0 || READ = 1
				2'b01:begin			
					counter_r_enable 	= 1;
					counter_dw_mode		= 0;	// Substract mode
					counter_dw_enable 	= 1;
					
					if(flag_use_dw_1 == 1)
						next_state 		= EMPTY;
					else 
						next_state 		= OTHER;
					
					output_selector 	= 1;
				end
				
				// WRITE = 1 || READ = 0
				2'b10:begin			
					counter_w_enable 	= 1;
					counter_dw_mode		= 1;	// Add mode
					counter_dw_enable 	= 1;
					
					if(flag_use_dw_31 == 31)
						next_state 		= FULL;
					else
						next_state 		= OTHER;
					
				end
				
				// WRITE = 1 || READ = 1
				2'b11:begin			
					counter_r_enable  	= 1;
					counter_w_enable 	= 1;
					output_selector 	= 1;
					
					next_state 			= OTHER;
				end
				
				default:begin
				end
			
			endcase
		end
		
		FULL: begin
			fifo_iff.F_EMPTY_N = 1'b1;
			fifo_iff.F_FULL_N = 1'b0;
			
			case(read_write_conc)
			
				// WRITE = 0 || READ = 0
				2'b00:	next_state = FULL;			
					
				
				// WRITE = 0 || READ = 1
				2'b01:begin			
					counter_r_enable 	= 1;
					counter_dw_enable 	= 1;
					counter_dw_mode		= 0;	// Substract mode
					
					output_selector 	= 1;
					next_state 			= OTHER;
				end
				
				// WRITE = 1 || READ = 0
				2'b10:	next_state 	= FULL;		
				
				// WRITE =v 1 || READ = 1
				2'b11:begin			
					counter_r_enable 	= 1;
					counter_w_enable  	= 1;
					
					output_selector 	= 1;
					
					next_state 			= FULL;
				end
			
			endcase	
		end
		
		default: begin
			fifo_iff.F_EMPTY_N 	= 1'b0;
			fifo_iff.F_FULL_N 	= 1'b1;
			
			next_state 	= EMPTY;
		end
	endcase


end						
endmodule



















