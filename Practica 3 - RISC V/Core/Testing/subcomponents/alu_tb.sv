`include "../basic_task.sv" 


module test_alu(input [31:0] A, 
                 input [31:0] B,
                 input zero,
                 input [31:0] result);

    check_alu check_alu_instance;

    basic_task basic_task_instance();


    initial begin
        basic_task_instance.inicializar();
        basic_task_instance.reset();

        @(testbench.sys_iff.ck)

        basic_task_instance.get_random_A_B();
        testbench.sys_iff.control_alu = 4'b0000;
        @(testbench.sys_iff.ck)
        check_alu_instance.ADD(A, B, result, zero);

        @(testbench.sys_iff.ck)

        basic_task_instance.get_random_A_B();
        testbench.sys_iff.control_alu = 4'b0001;
        @(testbench.sys_iff.ck)
        check_alu_instance.SUB(A, B, result, zero);

        @(testbench.sys_iff.ck)

        basic_task_instance.get_random_A_B();
        testbench.sys_iff.control_alu = 4'b0010;
        @(testbench.sys_iff.ck)
        check_alu_instance.AND(A, B, result, zero);

        @(testbench.sys_iff.ck)

        basic_task_instance.get_random_A_B();
        testbench.sys_iff.control_alu = 4'b0011;
        @(testbench.sys_iff.ck)
        check_alu_instance.OR(A, B, result, zero);

        @(testbench.sys_iff.ck)

        basic_task_instance.get_random_A_B();
        testbench.sys_iff.control_alu = 4'b0100;
        @(testbench.sys_iff.ck)
        check_alu_instance.XOR(A, B, result, zero);

        @(testbench.sys_iff.ck)

        basic_task_instance.get_random_A_B();
        testbench.sys_iff.control_alu = 4'b0101;
        @(testbench.sys_iff.ck)
        check_alu_instance.COMPEQ(A, B, result, zero);

        @(testbench.sys_iff.ck)

        basic_task_instance.get_random_A_B();
        testbench.sys_iff.control_alu = 4'b0110;
        @(testbench.sys_iff.ck)
        check_alu_instance.COMP(A, B, result, zero);

        @(testbench.sys_iff.ck)

        $stop(); //SOLO PROVISIONAL
    end

endmodule

class check_alu; //Todas las opciones aqui // revisar si las operaciones son signed o unsigned


    logic signed [31:0] ideal_res;


    task ADD(int A, int B, int result, zero);

    begin
        ideal_res = A+B;
        //testbench.sys_iff.control_alu = 4'b0000;
        ADD_CKECK: assert (ideal_res == result) else $info("ALU ADD ERROR");
        if(ideal_res == 0) ZERO_CHECK_ADD: assert (zero == 1'b1) else $info("Zero incorrect value");
    end
    endtask

    task SUB(int A, int B, int result, zero);

    begin
        ideal_res = A-B;
        //testbench.sys_iff.control_alu = 4'b0001;
        SUB_CHECK: assert (ideal_res == result) else $info("ALU SUB ERROR");
        if(ideal_res == 0) ZERO_CHECK_SUB: assert (zero == 1'b1) else $info("Zero incorrect value");
    end
    endtask

    task AND(int A, int B, int result, zero);
   
    begin
        ideal_res = A&B;
        //testbench.sys_iff.control_alu = 4'b0010;
        AND_CHECK: assert (ideal_res == result) else $info("ALU AND ERROR");
        if(ideal_res == 0) ZERO_CHECK_AND: assert (zero == 1'b1) else $info("Zero incorrect value");
    end
    endtask

    task OR(int A, int B, int result, zero);
  
    begin
        ideal_res = A|B;
        //testbench.sys_iff.control_alu = 4'b0011;
        OR_CHECK: assert (ideal_res == result) else $info("ALU OR ERROR");
        if(ideal_res == 0) ZERO_CHECK_OR: assert (zero == 1'b1) else $info("Zero incorrect value");
    end
    endtask

    task XOR(int A, int B, int result, zero);
  
    begin
        ideal_res = A^B;
        //testbench.sys_iff.control_alu = 4'b0100;
        XOR_CHECK: assert (ideal_res == result) else $info("ALU XOR ERROR");
        if(ideal_res == 0) ZERO_CHECK_XOR: assert (zero == 1'b1) else $info("Zero incorrect value");
    end
    endtask
    
    task COMPEQ(int A, int B, int result, zero);
   
    begin
        ideal_res = A<=B;
        //testbench.sys_iff.control_alu = 4'b0101;
        COMPEQ_CHECK: assert (ideal_res == result) else $info("ALU COMPEQ ERROR");
        if(ideal_res) ZERO_CHECK_COMPEQ: assert (zero == 1'b0) else $info("Zero incorrect value");
    end
    endtask

    task COMP(int A, int B, int result, zero);
    
    begin
        ideal_res = A<B;
        //testbench.sys_iff.control_alu = 4'b0110;
        COMP_CHECK: assert (ideal_res == result) else $info("ALU COMP ERROR");
        if(A<B) ZERO_CHECK_COMP: assert (zero == 1'b0) else $info("Zero incorrect value");
    end
    endtask

endclass