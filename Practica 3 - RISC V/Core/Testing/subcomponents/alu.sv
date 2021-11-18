program test_alu(           
    input [31:0] A, B;
    input [4:0] alu_control;
    input CLK;
    output zero;
    output [31:0] result;
);
    logic OP_code

    initial begin
        //meto valores a la ALU y comparo los results
    end

endprogram: test_alu

class check_alu; //Todas las opciones aqui // revisar si las operaciones son signed o unsigned

    task suma_signed_A(A, B, result, zero, code);
        OP_code = 5'b00000;
        ALU_SUMA: assert (A+B == result) else $info("ALU suma de forma incorrecta");
    endtask

    task suma_signed_B(A, B, result, zero, code);
        OP_code = 5'b11111;
        ALU_SUMA: assert (A+B == result) else $info("ALU suma de forma incorrecta");
    endtask

    task BEQ(A, B, result, zero, code);
        OP_code = 5'b00010;
        ALU_BEQ: assert (A==B |=> 0 == zero) else $info("No detacta numeros iguales [BEQ]");
    endtask

    task BNE(A, B, result, zero, code);
        OP_code = 5'b10000;
        ALU_BNE: assert (A!=B |=> 1 == zero) else $info("No detacta numeros distintos [BNE]");
    endtask

    task menor(A, B, result, zero, code);
        OP_code = 5'b01000;
        ALU_menor: assert (A<B |=> __NO SE QUE PASA__) else $info("No detacta numeros A<B");
    endtask
    
    task menor_otra_opcion(A, B, result, zero, code);
        OP_code = 5'b01100;
        ALU_menor_otra_opcion: assert (A<B |=> __NO SE QUE PASA__) else $info("No detacta numeros A<B por el segundo camino");
    endtask

    task mayor(A, B, result, zero, code);
        OP_code = 5'b11010;
        ALU_mayor: assert (A>=B |=> __NO SE QUE PASA__) else $info("No detacta numeros A>=B");
    endtask

    task mayor_otra_opcion(A, B, result, zero, code);
        OP_code = 5'b11010;
        ALU_mayor_otra_opcion: assert (A>=B |=> __NO SE QUE PASA__) else $info("No detacta numeros A>=B por el segundo camino");
    endtask

    task OR(A, B, result, zero, code);
        OP_code = 5'b11000;
        OR: assert (A|B == result) else $info("Operacion OR incorrecta");
    endtask

    task AND(A, B, result, zero, code);
        OP_code = 5'b11100;
        AND: assert (A&B == result) else $info("Opercaion AND incorrecta");
    endtask

    task shift_left_i(A, B, result, zero, code);
        OP_code = 5'b00100;
        logic [30:0] newA = A[30:0];
        shift_left_i: assert ({newA,B} == result) else $info("Shift left incorrecto");
    endtask

    task shift_right_i(A, B, result, zero, code);
        OP_code = 5'b10100;
        logic [30:0] newA = A[30:0];
        shift_right_i: assert ({B,newA} == result) else $info("Shift right incorrecto");
    endtask

    task shift_right_arith(A, B, result, zero, code);
        OP_code = 5'b10110;
        logic [29:0] newA = A[29:0];
        shift_right_arith: assert ({A[31],B,newA} == result) else $info("Shift right incorrecto");
    endtask

endclass