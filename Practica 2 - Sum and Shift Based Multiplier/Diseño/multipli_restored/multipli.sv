module multipli(CLOCK, RESET, END_MULT, A, B, S, START);
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

				 
				 
DataPath DataPath (.A(A), 
					.B(B), 
					.CLOCK(CLOCK), 
					.RESET(RESET), 
					.S(S), 
					.ACCU(ACCU), 
					.enableX(enableX), 
					.enableM(enableM), 
					.enableLO(enableLO), 
					.enableSHI(enableSHI), 
					.CARGA_LO(CARGA_LO), 
					.CARGA_SHI(CARGA_SHI), 
					.CARGA_X(CARGA_X),
					.clearX(clearX),
					.clearSHI(clearSHI), 
					.clearLO(clearLO),
					.control(CONTROL));
				 
				 











endmodule