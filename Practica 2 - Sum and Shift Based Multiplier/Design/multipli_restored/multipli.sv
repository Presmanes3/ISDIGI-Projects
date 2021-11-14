module multipli(CLOCK, RESET, END_MULT, A, B, S, START);

// Define the size of the registers A and B
parameter tamano=8;

input CLOCK, RESET;
input logic START;
input logic [tamano-1:0] A, B;
output logic [2*tamano-1:0] S;
output logic END_MULT;

wire [1:0] accu_operational_mode_selector;

wire shifter_X_enable, register_M_enable, shifter_LO_enable, shifter_HI_enable;
wire shifter_LO_operational_mode, shifter_HI_operational_mode;

wire shifter_X_clear, shifter_HI_clear, shifter_LO_clear;

wire [2:0] control;

FSM ControlPath (	.CLK(CLOCK),
					.RESET(RESET),
					.START(START), 
					.shifter_LO_operational_mode(shifter_LO_operational_mode), 
					.shifter_HI_operational_mode(shifter_HI_operational_mode),
					.shifter_X_enable(shifter_X_enable), 
					.shifter_LO_enable(shifter_LO_enable), 
					.shifter_HI_enable(shifter_HI_enable), 
					.shifter_X_clear(shifter_X_clear),		
					.shifter_HI_clear(shifter_HI_clear),		
					.shifter_LO_clear(shifter_LO_clear),		
					.accu_operational_mode_selector(accu_operational_mode_selector),		
					.control(control), 			
					.register_M_enable(register_M_enable),
					.end_mult(END_MULT)); 

				 
				 
DataPath DataPath (	.A(A), 
					.B(B), 
					.CLOCK(CLOCK), 
					.RESET(RESET), 
					.S(S), 
					.accu_operatinal_mode_selector(accu_operational_mode_selector), 
					.shifter_X_enable(shifter_X_enable), 
					.register_M_enable(register_M_enable), 
					.shifter_LO_enable(shifter_LO_enable), 
					.shifter_HI_enable(shifter_HI_enable), 
					.shifter_LO_operational_mode(shifter_LO_operational_mode), 
					.shifter_HI_operational_mode(shifter_HI_operational_mode), 
					.shifter_X_clear(shifter_X_clear),
					.shifter_HI_clear(shifter_HI_clear), 
					.shifter_LO_clear(shifter_LO_clear),
					.control(control));
endmodule