module FSM (CLK,RESET,START, CARGA_LO, CARGA_SHI,CARGA_X, enableX, enableLO, enableSHI, clearX,clearSHI,clearLO,ACCU,CONTROL,enableM,FINMULT);

parameter n=8;
parameter M = $clog2(n);

input CLK;

input RESET;

wire [3:0] COUNT;
 
input START;

input [2:0] CONTROL;

wire enableCOUNT;

output reg FINMULT;

output reg [1:0] ACCU;

output reg CARGA_X,CARGA_LO,CARGA_SHI;

output reg enableM,enableX,enableSHI,enableLO;

output reg clearSHI,clearX,clearLO;

wire clear_CUENTA;


reg[3:0] Estado;


parameter [2:0] Idle = 3'b001, Inicio = 3'b010, OP = 3'b011, SHIFT = 3'b100, NOTIFY = 3'b101;

contador    contador(.enable(enableCOUNT),
                     .clk(CLK),
							.reset(RESET),
							.count(COUNT), 
							.clear(clear_CUENTA));


always_ff @ (posedge CLK, negedge RESET)

  begin
if(!RESET) Estado <= Idle;
else
 
   begin
case(Estado)
Idle : 
begin if(START) Estado <= Inicio; 
else Estado <= Idle; 
end

Inicio :
	begin 
	Estado <= OP;
	end

OP : 
	begin 
	Estado <= SHIFT; 
	end

SHIFT : 
	begin if(COUNT==n) 
		Estado <= NOTIFY; 
	else Estado <= OP; 
	end

NOTIFY : 
begin if(!START) 
	Estado <= Idle; 
else 
	Estado <= NOTIFY; 
end
default: Estado<=Idle;
endcase
 
end
end
always_comb
	begin
	case(Estado)
	Idle : begin

		FINMULT = 1'b0;
		ACCU = 2'b00;

		enableX =1'b0;
		enableLO =1'b0;
		enableSHI = 1'b0;
		enableM = 1'b1;

		CARGA_X= 1'b0;
		CARGA_LO=1'b0;
		CARGA_SHI=1'b0;

		clearX = 1'b0;
		clearSHI=1'b0;
		clearLO=1'b0;

		enableCOUNT = 1'b0;
		clear_CUENTA = 1'b1;


end

	Inicio : begin  

		FINMULT = 1'b0;
		ACCU = 2'b00;

		enableX =1'b0;
		enableLO =1'b1;
		enableSHI = 1'b0;
		enableM = 1'b1;
	
		CARGA_X= 1'b0;
		CARGA_LO=1'b1;
		CARGA_SHI=1'b0;

		clearX = 1'b0;
	   clearSHI=1'b0;
		clearLO=1'b1;
	
		enableCOUNT = 1'b0;
		clear_CUENTA = 1'b0;

end

	OP: begin

		FINMULT = 1'b0;
		enableCOUNT = 1'b1;

		clearX = 1'b1;
		clearSHI=1'b1;
		clearLO=1'b1;

		CARGA_X= 1'b0;
		CARGA_LO=1'b0;

		enableX =1'b0;
		enableLO =1'b0;
		enableM = 1'b1;
		clear_CUENTA = 1'b1;

			if(!(CONTROL == 3'b000 || CONTROL == 3'b111))begin

		CARGA_SHI=1'b1;
		enableSHI = 1'b1;

		if(CONTROL[1]^CONTROL[0]) begin
			if(CONTROL[2]) begin
				ACCU = 2'b01;
			end else begin
				ACCU = 2'b00;
			end
		end else begin
		if(CONTROL[2]) begin
			ACCU = 2'b11;
		end else begin
			ACCU = 2'b10;
		end
		end
		end else begin

		CARGA_SHI=1'b0;
		enableSHI=1'b0;
		ACCU = 2'b00;
		end
		end

	SHIFT: begin

		FINMULT = 1'b0;
		ACCU = 2'b00;
		clear_CUENTA = 1'b1;

		CARGA_X= 1'b0;
		CARGA_LO=1'b0;
		CARGA_SHI=1'b0;

		enableM = 1'b1;
		enableX =1'b1;
		enableLO =1'b1;
		enableSHI = 1'b1;

		clearX = 1'b1;
		clearSHI=1'b1;
		clearLO=1'b1;

		enableCOUNT = 1'b0;

	end

	NOTIFY: begin

		FINMULT = 1'b1;
		ACCU = 2'b00;
		clear_CUENTA = 1'b1;


		enableM = 1'b1;
		enableX =1'b0;
		enableLO =1'b0;
		enableSHI = 1'b0;

		CARGA_X= 1'b0;
		CARGA_LO=1'b0;
		CARGA_SHI=1'b0;

		clearX = 1'b1;
		clearSHI=1'b1;
		clearLO=1'b1;

		enableCOUNT = 1'b0;

end
endcase
end
endmodule 