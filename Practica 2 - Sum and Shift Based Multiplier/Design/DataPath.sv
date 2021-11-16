module DataPath 
#(parameter size = 8)
(
	input [size - 1 : 0] A, 
	input [size - 1 : 0] B, 
	input CLOCK, 
	input RESET, 

	input shifter_HI_shift_enable,
	input shifter_HI_load_enable,
	input shifter_HI_clear,

	input shifter_LO_shift_enable,
	input shifter_LO_load_enable,
	input shifter_LO_clear,

	input register_M_enable,
	input register_M_clear,

	input register_X_enable,
	input register_X_clear,

	input adder_enable,
	input [1:0] adder_mode,

	output [2 * size - 1 : 0] S,
	output [2 : 0] control
);


wire [size:0] 	adder_out;
wire [size - 1:0] 	register_M_out;
wire [size:0] 	shifter_HI_parallel_out;
wire [size-1:0] shifter_LO_parallel_out;
wire [1 : 0]	shifter_HI_serial_out;
wire [1 : 0]	shifter_LO_serial_out;
wire 			reg_X_out;

//wire [2*size + 2 - 1 : 0]			total_signal; 
// se usa para comporbar el hi-lo


//instanciación Adder												
adder 			#(.size(size + 1)) adder (	
						.clk				(CLOCK),
						.reset				(RESET),
						.operational_mode	(adder_mode), 
						.enable				(adder_enable),

						.input_from_reg_M	({register_M_out[size - 1],register_M_out}), 
						.input_from_reg_HI	(shifter_HI_parallel_out), 

						.out				(adder_out)
);

//instanciación Registro M
register	 	#(.size(size)) regigster_M (	
						.clk				(CLOCK),
						.reset				(RESET),
						.enable				(register_M_enable),
						.clear				(register_M_clear),

						.in					(B),

						.out				(register_M_out)
);

//instanciación Registro X						 
register 		#(.size(1)) register_X (
						.clk				(CLOCK),
						.reset				(RESET),
						.enable				(register_X_enable),
						.clear				(register_X_clear),

						.in					(shifter_LO_serial_out[1]),

						.out				(reg_X_out)
);

//instanciación Shifter Q	(HI)					
shiftRegister 	#(.size(size + 1)) shifter_HI (	
						.clk				(CLOCK),
						.reset				(RESET),
						.clear 				(shifter_HI_clear),

						.shift_enable		(shifter_HI_shift_enable), 
						.load_enable		(shifter_HI_load_enable),

						.serial_in			({shifter_HI_parallel_out[size], shifter_HI_parallel_out[size]}),
						.parallel_in		(adder_out), 

						.serial_out			(shifter_HI_serial_out),
						.parallel_out		(shifter_HI_parallel_out)
);
						 
//instanciación Shifter LO		
shiftRegister 	#(.size(size)) shifter_LO (	
						.clk				(CLOCK),
						.reset				(RESET),
						.clear 				(shifter_LO_clear),

						.shift_enable		(shifter_LO_shift_enable), 
						.load_enable		(shifter_LO_load_enable),

						.serial_in			(shifter_HI_serial_out),
						.parallel_in		(A), 

						.serial_out			(shifter_LO_serial_out),
						.parallel_out		(shifter_LO_parallel_out)
);
							

//Asignación salida S real						
assign S = {shifter_HI_parallel_out[size-1 : 0], shifter_LO_parallel_out};

assign control = {shifter_LO_serial_out, reg_X_out};

//assign total_signal = {shifter_HI_parallel_out, shifter_LO_parallel_out,  reg_X_out};



endmodule