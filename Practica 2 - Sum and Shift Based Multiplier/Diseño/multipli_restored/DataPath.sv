module DataPath (A, B, CLOCK, RESET, S, ACCU, enableX, enableM, enableLO, enableSHI, CARGA_LO, CARGA_SHI, CARGA_X, clearX, clearSHI, clearLO, control);

parameter tamano = 8;

input CLOCK, RESET;
input logic [tamano-1:0] A, B;
output logic [2*tamano-1:0] S;

input [1:0] ACCU;

input enableX, enableM, enableLO, enableSHI;
input CARGA_LO, CARGA_SHI, CARGA_X;
input clearX, clearSHI, clearLO; 

wire [tamano:0] selector;

wire [tamano:0] inPSHI, outPSHI; //cargas en paralelo

//división de salidas registro
wire outPSHI1; 
wire [tamano-1:0] outPSHI2;
assign outPSHI1 = outPSHI[tamano];
assign outPSHI2 = outPSHI[tamano-1:0];


wire [1:0] outSSHI, outSLO;

wire [tamano-1:0] outPLO;

output [2:0] control;

wire [1:0] qi1;
wire qi, qi_1; //entradas y salidas de X

//instanciación Registro M
registroM registroM (.CLOCK(CLOCK),
							.RESET(RESET),
							.In_multi(B), 
							.Out_multi(selector),
							.enableM(enableM));
							

//instanciación Adder												
ADDER ADDER				(.CLOCK(CLOCK),
							.RESET(RESET),
							.estado(ACCU),  
							.selector(selector), 
							.outSHI(outPSHI), 
							.inSHI(inPSHI));


							
							
							
//instanciación Shifter Q						
shifterQ shifterQ (.CLOCK(CLOCK),
						 .RESET(clearSHI),
						 .SHIFTn_LOAD(CARGA_SHI), 
						 .DIN_SERIAL(outPSHI1), 
						 .P(inPSHI), 
						 .Q(outPSHI),
						 .ENABLE(enableSHI), 	
						 .DOUT_SERIAL(outSSHI));
						 
//instanciación Shifter LO		
shifterLO shifterLO (.CLOCK(CLOCK),
						 .RESET(clearLO),
						 .SHIFTn_LOAD(CARGA_LO), 
						 .DIN(outSSHI), 
						 .P(A), 
						 .Q(outPLO),
						 .ENABLE(enableLO), 
						 .DOUT_SERIAL(qi1));	
						 
						 
						 
						 
//instanciación Registro X						 
registroX registroX (.CLOCK(CLOCK),
							.RESET(clearX),
							.enableX(enableX),
							.qi(qi1),
							.qi_1(qi_1));
							
							

//Asignación salida S							
assign S[2*tamano-1:tamano] = outPSHI2;
assign S[tamano-1:0] = outPLO;
assign control[2:1] = qi1;
assign control[0] = qi_1; 





endmodule