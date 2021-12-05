
int longitud;

task actualizarCola; //modelo de FIFO no sistetizable (FUNCIONAL)
	begin
	
	if(!RESET_N)
		begin	
			DATA_OUT_FUNCIONAL = 0;
			cola.delete();
		end 
    else
		begin
	
		@(posedge CLOCK)
		if(!CLEAR_N)
		begin
			DATA_OUT_FUNCIONAL = 0;
			cola.delete();
		end else
		begin
	
		if(cola.size()==0) //la cola esta vacía
			begin
				if(WRITE) //solo podemos escribir, no podemos no escribir
					begin
						if(READ) 
							begin
								cola.push_back(DATA_IN);
								DATA_OUT_FUNCIONAL = cola.pop_front();
							end else
								begin
									cola.push_back(DATA_IN);
								end                 OJO HAY Q REVISAR
					end
			end else
				if(cola.size()==31) //la cola esta llena 
					begin
						if(WRITE)
							begin
								if(READ)
									begin
										cola.push_back(DATA_IN);
										DATA_OUT_FUNCIONAL = cola.pop_front();
									end
							end else
								begin
									if(!WRITE)
										begin
											if(READ)
												begin
													DATA_OUT_FUNCIONAL = cola.pop_front();
												end
										end
								end
					end else
						begin //la cola no esta ni llena ni vacía
							if(WRITE)
								begin
									if(READ)
										begin
											cola.push_back(DATA_IN);
											DATA_OUT_FUNCIONAL = cola.pop_front();
										end else
											begin
												cola.push_back(DATA_IN);
											end
								end else
									begin
										if(READ)
											begin
												DATA_OUT_FUNCIONAL = cola.pop_front();
											end
									end
						end
	   end
		end
	end

	longitud = cola.size();
	
endtask

------------------------------------------------------------------------------------------

//************************************************
DEFINO FIFO NO SISTETIZABLE

logic [7:0] cola [$:31];
reg [7:0] DATA_OUT_FUNCIONAL;

tengo que introducir con cola.push_back(<elemento>);
tengo que sacar elementos con <elemento>=cola.pop_front();

//compruebo tamaño con cola.size();






//**********************************************************************************

parameter d_width = 32;
parameter a_width = 1024;

[d_width-1:0]testbench.sys_iff.data;
[a_width-1:0]testbench.sys_iff.addres;

testbench.sys_iff.wren;


logic  [d_width-1:0]  mem[a_width-1:0];

[d_width-1:0]testbench.sys_iff.SPO;




