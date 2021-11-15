module multipli
#(parameter size = 8)
(
	input CLOCK, 
	input RESET, 
	input START,
	
	input [size - 1 : 0] A,
	input [size - 1 : 0] B,


	output logic [2 * size - 1 : 0] S,
	output END_MULT
);

wire shifter_HI_shift_enable;
wire shifter_HI_load_enable;
wire shifter_HI_clear;

wire shifter_LO_shift_enable;
wire shifter_LO_load_enable;
wire shifter_LO_clear;

wire register_M_enable;
wire register_M_clear;

wire register_X_enable;
wire register_X_clear;

wire adder_enable;
wire [1 : 0] adder_mode;
wire [2 : 0] control;

FSM #(.size(size)) ControlPath (	
					.CLOCK(CLOCK),
					.RESET(RESET),
					.START(START),

					.control(control),

					.shifter_HI_shift_enable(shifter_HI_shift_enable),
					.shifter_HI_load_enable(shifter_HI_load_enable),
					.shifter_HI_clear(shifter_HI_clear),

					.shifter_LO_shift_enable(shifter_LO_shift_enable),
					.shifter_LO_load_enable(shifter_LO_load_enable),
					.shifter_LO_clear(shifter_LO_clear),

					.register_M_enable(register_M_enable),
					.register_M_clear(register_M_clear),

					.register_X_enable(register_X_enable),
					.register_X_clear(register_X_clear),

					.adder_enable(adder_enable),
					.adder_mode(adder_mode),

					.END_MULT(END_MULT)
); 
				 
DataPath #(.size(size)) DataPath (	
					.CLOCK(CLOCK),
					.RESET(RESET),

					.A(A),
					.B(B),

					.shifter_HI_shift_enable(shifter_HI_shift_enable),
					.shifter_HI_load_enable(shifter_HI_load_enable),
					.shifter_HI_clear(shifter_HI_clear),

					.shifter_LO_shift_enable(shifter_LO_shift_enable),
					.shifter_LO_load_enable(shifter_LO_load_enable),
					.shifter_LO_clear(shifter_LO_clear),

					.register_M_enable(register_M_enable),
					.register_M_clear(register_M_clear),

					.register_X_enable(register_X_enable),
					.register_X_clear(register_X_clear),
					
					.adder_enable(adder_enable),
					.adder_mode(adder_mode),

					.S(S),

					.control(control)
);
endmodule