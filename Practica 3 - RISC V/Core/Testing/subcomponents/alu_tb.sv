`include "../basic_task.sv" 


module test_alu(input [31:0] A, 
                 input [31:0] B,
                 output [3:0] alu_control,
                 input zero,
                 input [31:0] result);

    check_alu check_alu_instance;

    basic_task basic_task_instance();

    initial begin
        basic_task_instance.inicializar();
        basic_task_instance.reset();

        @(testbench.sys_iff.ck)

        basic_task_instance.get_random_A_B();
        check_alu_instance.ADD(A, B, result, alu_control, zero);

        @(testbench.sys_iff.ck)

        basic_task_instance.get_random_A_B();
        check_alu_instance.SUB(A, B, result, alu_control, zero);

        @(testbench.sys_iff.ck)

        basic_task_instance.get_random_A_B();
        check_alu_instance.AND(A, B, result, alu_control, zero);

        @(testbench.sys_iff.ck)

        basic_task_instance.get_random_A_B();
        check_alu_instance.OR(A, B, result, alu_control, zero);

        @(testbench.sys_iff.ck)

        basic_task_instance.get_random_A_B();
        check_alu_instance.XOR(A, B, result, alu_control, zero);

        @(testbench.sys_iff.ck)

        basic_task_instance.get_random_A_B();
        check_alu_instance.COMPEQ(A, B, result, alu_control, zero);

        @(testbench.sys_iff.ck)

        basic_task_instance.get_random_A_B();
        check_alu_instance.COMP(A, B, result, alu_control, zero);

        @(testbench.sys_iff.ck)

        $stop(); //SOLO PROVISIONAL
    end

endmodule

class check_alu; //Todas las opciones aqui // revisar si las operaciones son signed o unsigned

    task ADD(int A, int B, int result, alu_control, zero);

    begin
        alu_control = 4'b0000;
        ADD_CKECK: assert (A+B == result) else $info("ALU ADD ERROR");
        if(A+B == 0) ZERO_CHECK_ADD: assert (zero == 1'b1) else $info("Zero incorrect value");
    end
    endtask

    task SUB(int A, int B, int result, alu_control, zero);

    begin
        alu_control = 4'b0001;
        SUB_CHECK: assert (A-B == result) else $info("ALU SUB ERROR");
        if(A-B == 0) ZERO_CHECK_SUB: assert (zero == 1'b1) else $info("Zero incorrect value");
    end
    endtask

    task AND(int A, int B, int result, alu_control, zero);
   
    begin
        alu_control = 4'b0010;
        AND_CHECK: assert (A&B == result) else $info("ALU AND ERROR");
        if(A&B == 0) ZERO_CHECK_AND: assert (zero == 1'b1) else $info("Zero incorrect value");
    end
    endtask

    task OR(int A, int B, int result, alu_control, zero);
  
    begin
        alu_control = 4'b0011;
        OR_CHECK: assert (A|B == result) else $info("ALU OR ERROR");
        if(A|B == 0) ZERO_CHECK_OR: assert (zero == 1'b1) else $info("Zero incorrect value");
    end
    endtask

    task XOR(int A, int B, int result, alu_control, zero);
  
    begin
        alu_control = 4'b0100;
        XOR_CHECK: assert (A^B == result) else $info("ALU XOR ERROR");
        if(A^B == 0) ZERO_CHECK_XOR: assert (zero == 1'b1) else $info("Zero incorrect value");
    end
    endtask
    
    task COMPEQ(int A, int B, int result, alu_control, zero);
   
    begin
        alu_control = 4'b0101;
        COMPEQ_CHECK: assert (A<=B == result) else $info("ALU COMPEQ ERROR");
        if(A<=B) ZERO_CHECK_COMPEQ: assert (zero == 1'b0) else $info("Zero incorrect value");
    end
    endtask

    task COMP(int A, int B, int result, alu_control, zero);
    
    begin
        alu_control = 4'b0110;
        COMP_CHECK: assert (A<B == result) else $info("ALU COMP ERROR");
        if(A<B) ZERO_CHECK_COMP: assert (zero == 1'b0) else $info("Zero incorrect value");
    end
    endtask

endclass