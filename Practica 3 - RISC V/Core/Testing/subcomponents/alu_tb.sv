`include "../basic_task.sv" //para llamar al random

program test_alu(input A, 
                 input B,
                 input alu_control,
                 input CLK,
                 input zero,
                 input result);

    initial begin
        basic_task.inicializar();
        basic_task.reset();
        basic_task.get_random_A_B();
        check_alu.suma_signed_A(A, B, result, alu_control, CLK, zero);
    end

endprogram

class check_alu; //Todas las opciones aqui // revisar si las operaciones son signed o unsigned

    task suma_signed_A(A, B, result, alu_control, CLK, zero);
        alu_control = 5'b00000;
        ALU_SUMA: assert (A+B == result) else $info("ALU suma de forma incorrecta");
    endtask

    task suma_signed_B(A, B, result, alu_control, CLK, zero);
        alu_control = 5'b11111;
        ALU_SUMA: assert (A+B == result) else $info("ALU suma de forma incorrecta");
    endtask

    task BEQ(A, B, result, alu_control, CLK, zero);
        alu_control = 5'b00010;
        ALU_BEQ: assert (A==B && 0 == zero) else $info("No detacta numeros iguales [BEQ]");
    endtask

    task BNE(A, B, result, alu_control, CLK, zero);
        alu_control = 5'b10000;
        ALU_BNE: assert (A!=B && 1 == zero) else $info("No detacta numeros distintos [BNE]");
    endtask

    task menor(A, B, result, alu_control, CLK, zero);
        alu_control = 5'b01000;
        ALU_menor: assert (A<B == result) else $info("No detacta numeros A<B");
    endtask
    
    task menor_otra_opcion(A, B, result, alu_control, CLK, zero);
        alu_control = 5'b01100;
        ALU_menor_otra_opcion: assert (A<B == result) else $info("No detacta numeros A<B por el segundo camino");
    endtask

    task mayor(A, B, result, alu_control, CLK, zero);
        alu_control = 5'b11010;
        ALU_mayor: assert (A>=B == result) else $info("No detacta numeros A>=B");
    endtask

    task mayor_otra_opcion(A, B, result, alu_control, CLK, zero);
        alu_control = 5'b11010;
        ALU_mayor_otra_opcion: assert (A>=B == result) else $info("No detacta numeros A>=B por el segundo camino");
    endtask

    task OR(A, B, result, alu_control, CLK, zero);
        alu_control = 5'b11000;
        OR: assert (A|B == result) else $info("Operacion OR incorrecta");
    endtask

    task AND(A, B, result, alu_control, CLK, zero);
        alu_control = 5'b11100;
        AND: assert (A&B == result) else $info("Opercaion AND incorrecta");
    endtask

    task shift_left_i(A, B, result, alu_control, CLK, zero);
        alu_control = 5'b00100;
        shift_left_i: assert ({A[30:0],B[0]} == result) else $info("Shift left incorrecto");
    endtask

    task shift_right_i(A, B, result, alu_control, CLK, zero);
        alu_control = 5'b10100;
        shift_right_i: assert ({B[0],A[30:0]} == result) else $info("Shift right incorrecto");
    endtask

    task shift_right_arith(A, B, result, alu_control, CLK, zero);
        alu_control = 5'b10110;
        shift_right_arith: assert ({A[31],B[0],A[29:0]} == result) else $info("Shift right incorrecto");
    endtask

endclass