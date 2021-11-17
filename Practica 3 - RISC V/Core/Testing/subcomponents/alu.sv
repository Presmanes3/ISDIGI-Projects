program test_alu(           
    input [31:0] A, B;
    input [4:0] alu_control;
    input CLK;
    output zero;
    output [31:0] result;
);
    logic OP_code

    initial begin
        //meto valores a la ALU y comparo los resultados
    end

endprogram: test_alu

class check_alu; //Todas las opciones aqui // revisar si las operaciones son signed o unsigned

    task suma_signed_A(A, B, resultado, code, CLK);
        OP_code = 5'b00000;
        ALU_SUMA: assert (A+B == resultado) else $info("ALU suma de forma incorrecta");
    endtask

    task suma_signed_B(A, B, resultado, code, CLK);
        OP_code = 5'b11111;
        ALU_SUMA: assert (A+B == resultado) else $info("ALU suma de forma incorrecta");
    endtask
    
endclass