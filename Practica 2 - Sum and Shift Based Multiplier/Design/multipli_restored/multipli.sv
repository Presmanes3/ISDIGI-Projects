module multipli(CLOCK, RESET, END_MULT, A, B, S, START);

// Define the size of the registers A and B
parameter tamano=8;

input CLOCK, RESET;
input logic START;
input logic [tamano-1:0] A, B;
output logic [2*tamano-1:0] S;
output logic END_MULT;

wire [1:0] ACCU;

wire enableX, enableM, enableLO, enableSHI;
wire CARGA_LO, CARGA_SHI, CARGA_X;

wire clearX, clearSHI, clearLO;

wire [2:0] CONTROL;

FSM control (.CLK(CLOCK),
				 .RESET(RESET),
				 .START(START), 
				 .CARGA_LO(CARGA_LO), 
				 .CARGA_SHI(CARGA_SHI),
				 .CARGA_X(CARGA_X), 
				 .enableX(enableX), 
				 .enableLO(enableLO), 
				 .enableSHI(enableSHI), 
				 .clearX(clearX),		
				 .clearSHI(clearSHI),		
				 .clearLO(clearLO),		
				 .ACCU(ACCU),		
				 .CONTROL(CONTROL), 			
				 .enableM(enableM),
				 .FINMULT(END_MULT)); 

				 
				 
DataPath DataPath (	.A(A), 
					.B(B), 
					.CLOCK(CLOCK), 
					.RESET(RESET), 
					.S(S), 
					.accu_operatinal_mode_selector(ACCU), 
					.shifter_X_enable(enableX), 
					.register_M_enable(enableM), 
					.shifter_LO_enable(enableLO), 
					.shifter_HI_enable(enableSHI), 
					.shifter_LO_operational_mode(CARGA_LO), 
					.shifter_HI_operational_mode(CARGA_SHI), 
					.CARGA_X(CARGA_X),
					.shifter_X_clear(clearX),
					.shifter_HI_clear(clearSHI), 
					.shifter_LO_clear(clearLO),
					.control(CONTROL));
endmodule