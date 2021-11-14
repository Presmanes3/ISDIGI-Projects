module DataPath (A, B, CLOCK, RESET, S, accu_operatinal_mode_selector, shifter_X_enable, register_M_enable, shifter_LO_enable, shifter_HI_enable, shifter_LO_operational_mode, shifter_HI_operational_mode, shifter_X_clear, shifter_HI_clear, shifter_LO_clear, control);

parameter size = 8;

input CLOCK, RESET;
input logic [size-1:0] A, B;
output logic [2*size-1:0] S;

input [1:0] accu_operatinal_mode_selector;

input shifter_X_enable, register_M_enable, shifter_LO_enable, shifter_HI_enable;
input shifter_LO_operational_mode, shifter_HI_operational_mode;
input shifter_X_clear, shifter_HI_clear, shifter_LO_clear; 

wire [size:0] register_M_out;

wire [size:0] shifter_HI_parallel_in, shifter_HI_parallel_out; //cargas en paralelo

//división de salidas registro
wire shifter_HI_serial_in; 

assign shifter_HI_serial_in = shifter_HI_parallel_out[size];

wire [1:0] shifter_Hi_serial_out, outSLO;

wire [size-1:0] shifter_LO_parallel_out;

output [2:0] control;

wire [1:0] shifter_LO_serial_output;
wire qi, q1_minus_1; //entradas y salidas de X

//instanciación Registro M
registroM registroM (	.CLOCK(CLOCK),
						.RESET(RESET),
						.in_val(B), 
						.out_val(register_M_out),
						.enable(register_M_enable));
							
//instanciación Adder												
ADDER ADDER			(	.CLOCK(CLOCK),
						.RESET(RESET),
						.operational_mode(accu_operatinal_mode_selector),  
						.input_from_reg_M(register_M_out), 
						.input_from_reg_HI(shifter_HI_parallel_out), 
						.out(shifter_HI_parallel_in));

//instanciación Shifter Q	(HI)					
shifterHI shifterHI (	.CLOCK(CLOCK),
						.RESET(shifter_HI_clear),
						.mode(shifter_HI_operational_mode), 
						.enable(shifter_HI_enable), 
						.serial_data_in(shifter_HI_serial_in), 	
						.serial_data_out(shifter_Hi_serial_out),
						.parallel_data_in(shifter_HI_parallel_in), 
						.parallel_data_out(shifter_HI_parallel_out));
						 
//instanciación Shifter LO		
shifterLO shifterLO (	.CLOCK(CLOCK),
						.RESET(shifter_LO_clear),
						.mode(shifter_LO_operational_mode), 
						.enable(shifter_LO_enable), 
						.serial_data_in(shifter_Hi_serial_out), 
						.serial_data_out(shifter_LO_serial_output),
						.parallel_data_in(A), 
						.parallel_data_out(shifter_LO_parallel_out));
						 			 
//instanciación Registro X						 
registroX registroX (	.CLOCK(CLOCK),
						.RESET(shifter_X_clear),
						.enable(shifter_X_enable),
						.qi(shifter_LO_serial_output),
						.q1_minus_1(q1_minus_1));
							

//Asignación salida S real						
assign S = {shifter_HI_parallel_out[size-1 : 0], shifter_LO_parallel_out};


assign control = {shifter_LO_serial_output, q1_minus_1};





endmodule