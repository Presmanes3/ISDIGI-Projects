

class check_alu; //Todas las opciones aqui

    logic flag = 1'b0;
    task flag_check();
        if(!flag) $display("-------- LA ALU FUNCIONA CORRECTAMENTE --------");
    endtask

    task ADD();
        logic signed [31:0] ideal_res;
        ideal_res = testbench.sys_iff.A_alu+testbench.sys_iff.B_alu;
        ADD_CKECK: assert (ideal_res == testbench.sys_iff.result_alu) else begin flag=1; $info("ALU ADD ERROR");end
        if(ideal_res == 0) ZERO_CHECK_ADD: assert (testbench.sys_iff.zero_alu == 1'b1) else $info("Zero incorrect value");
    
    endtask

    task SUB();
        logic signed [31:0] ideal_res;
        ideal_res = testbench.sys_iff.A_alu-testbench.sys_iff.B_alu;
        SUB_CHECK: assert (ideal_res == testbench.sys_iff.result_alu) else begin flag=1; $info("ALU SUB ERROR");end
        if(ideal_res == 0) ZERO_CHECK_SUB: assert (testbench.sys_iff.zero_alu == 1'b1) else $info("Zero incorrect value");
    
    endtask

    task AND();
        logic signed [31:0] ideal_res;
        ideal_res = testbench.sys_iff.A_alu&testbench.sys_iff.B_alu;
        AND_CHECK: assert (ideal_res == testbench.sys_iff.result_alu) else begin flag=1; $info("ALU AND ERROR");end
        if(ideal_res == 0) ZERO_CHECK_AND: assert (testbench.sys_iff.zero_alu == 1'b1) else $info("Zero incorrect value");
    
    endtask

    task OR();
        logic signed [31:0] ideal_res;
        ideal_res = testbench.sys_iff.A_alu|testbench.sys_iff.B_alu;
        OR_CHECK: assert (ideal_res == testbench.sys_iff.result_alu) else begin flag=1; $info("ALU OR ERROR");end
        if(ideal_res == 0) ZERO_CHECK_OR: assert (testbench.sys_iff.zero_alu == 1'b1) else $info("Zero incorrect value");
    
    endtask

    task XOR();
        logic signed [31:0] ideal_res;
        ideal_res = testbench.sys_iff.A_alu^testbench.sys_iff.B_alu;
        XOR_CHECK: assert (ideal_res == testbench.sys_iff.result_alu) else begin flag=1; $info("ALU XOR ERROR");end
        if(ideal_res == 0) ZERO_CHECK_XOR: assert (testbench.sys_iff.zero_alu == 1'b1) else $info("Zero incorrect value");
    
    endtask
    
    task U_LOW_EQ();
        logic signed [31:0] ideal_res;
        ideal_res = testbench.sys_iff.A_alu<=testbench.sys_iff.B_alu;
        U_LOW_EQ_CHECK: assert (ideal_res == testbench.sys_iff.result_alu) else begin flag=1; $info("ALU U_LOW_EQ ERROR");end
        if(ideal_res) ZERO_CHECK_U_LOW_EQ: assert (testbench.sys_iff.zero_alu == 1'b0) else $info("Zero incorrect value");
    
    endtask

    task S_LOW_EQ();
        logic signed [31:0] ideal_res;
        ideal_res = $signed(testbench.sys_iff.A_alu)<= $signed(testbench.sys_iff.B_alu);
        S_LOW_EQ_CHECK: assert (ideal_res == testbench.sys_iff.result_alu) else begin flag=1; $info("ALU S_LOW_EQ ERROR");end
        if(ideal_res) ZERO_CHECK_S_LOW_EQ: assert (testbench.sys_iff.zero_alu == 1'b0) else $info("Zero incorrect value");
    
    endtask

    task U_HIGH_EQ();
        logic signed [31:0] ideal_res;
        ideal_res = testbench.sys_iff.A_alu>=testbench.sys_iff.B_alu;
        U_HIGH_EQ_CHECK: assert (ideal_res == testbench.sys_iff.result_alu) else begin flag=1; $info("ALU U_LOW_EQ ERROR");end
        if(ideal_res) ZERO_CHECK_U_HIGH_EQ: assert (testbench.sys_iff.zero_alu == 1'b0) else $info("Zero incorrect value");
    
    endtask

    task S_HIGH_EQ();
        logic signed [31:0] ideal_res;
        ideal_res = $signed(testbench.sys_iff.A_alu)>= $signed(testbench.sys_iff.B_alu);
        S_HIGH_EQ_CHECK: assert (ideal_res == testbench.sys_iff.result_alu) else begin flag=1; $info("ALU S_LOW_EQ ERROR");end
        if(ideal_res) ZERO_CHECK_S_HIGH_EQ: assert (testbench.sys_iff.zero_alu == 1'b0) else $info("Zero incorrect value");
    
    endtask

    task U_LOWER();
        logic signed [31:0] ideal_res;
        ideal_res = testbench.sys_iff.A_alu<testbench.sys_iff.B_alu;
        U_LOWER_EQ_CHECK: assert (ideal_res == testbench.sys_iff.result_alu) else begin flag=1; $info("ALU U_LOWER ERROR");end
        if(ideal_res) ZERO_CHECK_U_LOWER_EQ: assert (testbench.sys_iff.zero_alu == 1'b0) else $info("Zero incorrect value");
    endtask

    task S_LOWER();
        logic signed [31:0] ideal_res;
        ideal_res = $signed(testbench.sys_iff.A_alu)< $signed(testbench.sys_iff.B_alu);
        S_LOWER_CHECK: assert (ideal_res == testbench.sys_iff.result_alu) else begin flag=1; $info("ALU S_LOWER ERROR");end
        if(ideal_res) ZERO_CHECK_S_LOWER: assert (testbench.sys_iff.zero_alu == 1'b0) else $info("Zero incorrect value");
    endtask

    task U_HIGHER();
        logic signed [31:0] ideal_res;
        ideal_res = testbench.sys_iff.A_alu>testbench.sys_iff.B_alu;
        U_HIGHER_CHECK: assert (ideal_res == testbench.sys_iff.result_alu) else begin flag=1; $info("ALU U_HIGHER ERROR");end
        if(ideal_res) ZERO_CHECK_U_HIGHER: assert (testbench.sys_iff.zero_alu == 1'b0) else $info("Zero incorrect value");
    endtask

    task S_HIGHER();
        logic signed [31:0] ideal_res;
        ideal_res = $signed(testbench.sys_iff.A_alu)> $signed(testbench.sys_iff.B_alu);
        S_HIGHER_CHECK: assert (ideal_res == testbench.sys_iff.result_alu) else begin flag=1; $info("ALU S_HIGHER ERROR");end
        if(ideal_res) ZERO_CHECK_S_HIGHER: assert (testbench.sys_iff.zero_alu == 1'b0) else $info("Zero incorrect value");
    endtask

    task SHIFT_LEFT();
        logic signed [31:0] ideal_res;
        ideal_res = testbench.sys_iff.A_alu<<testbench.sys_iff.B_alu;
        SHIFT_LEFT_CHECK: assert (ideal_res == testbench.sys_iff.result_alu) else begin flag=1; $info("ALU SHIFT_LEFT ERROR");end
        if(ideal_res) ZERO_CHECK_SHIFT_LEFT: assert (testbench.sys_iff.zero_alu == 1'b0) else $info("Zero incorrect value");
    endtask

    task SHIFT_RIGHT_LOGIC();
        logic signed [31:0] ideal_res;
        ideal_res = testbench.sys_iff.A_alu>>testbench.sys_iff.B_alu;
        SHIFT_RIGHT_CHECK: assert (ideal_res == testbench.sys_iff.result_alu) else begin flag=1; $info("ALU SHIFT_RIGHT_LOGIC ERROR");end
        if(ideal_res) ZERO_CHECK_SHIFT_RIGHT: assert (testbench.sys_iff.zero_alu == 1'b0) else $info("Zero incorrect value");
    endtask

    task SHIFT_RIGHT_ARIT();
        logic signed [31:0] ideal_res;
        ideal_res = testbench.sys_iff.A_alu>>>testbench.sys_iff.B_alu;
        SHIFT_RIGH_ARITT_CHECK: assert (ideal_res == testbench.sys_iff.result_alu) else begin flag=1; $info("ALU SHIFT_RIGHT_ARIT ERROR");end
        if(ideal_res) ZERO_CHECK_SHIFT_RIGHT_ARIT: assert (testbench.sys_iff.zero_alu == 1'b0) else $info("Zero incorrect value");
    endtask

endclass



 
module test_alu();

    check_alu check_alu_instance;

    basic_task basic_task_instance();

    initial begin
        check_alu_instance = new ;
    end


    task tb_alu();
        begin
            @(testbench.sys_iff.ck)

            basic_task_instance.get_random_A_B();
            testbench.sys_iff.control_alu = 4'b0000;
            @(testbench.sys_iff.ck)
            check_alu_instance.ADD();

            @(testbench.sys_iff.ck)

            basic_task_instance.get_random_A_B();
            testbench.sys_iff.control_alu = 4'b0001;
            @(testbench.sys_iff.ck)
            check_alu_instance.SUB();

            @(testbench.sys_iff.ck)

            basic_task_instance.get_random_A_B();
            testbench.sys_iff.control_alu = 4'b0010;
            @(testbench.sys_iff.ck)
            check_alu_instance.AND();

            @(testbench.sys_iff.ck)

            basic_task_instance.get_random_A_B();
            testbench.sys_iff.control_alu = 4'b0011;
            @(testbench.sys_iff.ck)
            check_alu_instance.OR();

            @(testbench.sys_iff.ck)

            basic_task_instance.get_random_A_B();
            testbench.sys_iff.control_alu = 4'b0100;
            @(testbench.sys_iff.ck)
            check_alu_instance.XOR();

            @(testbench.sys_iff.ck)

            basic_task_instance.get_random_A_B();
            testbench.sys_iff.control_alu = 4'b0101;
            @(testbench.sys_iff.ck)
            check_alu_instance.U_LOW_EQ();

            @(testbench.sys_iff.ck)

            basic_task_instance.get_random_A_B();
            testbench.sys_iff.control_alu = 4'b0110;
            @(testbench.sys_iff.ck)
            check_alu_instance.S_LOW_EQ();

            @(testbench.sys_iff.ck)

            basic_task_instance.get_random_A_B();
            testbench.sys_iff.control_alu = 4'b0111;
            @(testbench.sys_iff.ck)
            check_alu_instance.U_HIGH_EQ();

            @(testbench.sys_iff.ck)

            basic_task_instance.get_random_A_B();
            testbench.sys_iff.control_alu = 4'b1000;
            @(testbench.sys_iff.ck)
            check_alu_instance.S_HIGH_EQ();

            @(testbench.sys_iff.ck)

            basic_task_instance.get_random_A_B();
            testbench.sys_iff.control_alu = 4'b1001;
            @(testbench.sys_iff.ck)
            check_alu_instance.U_LOWER();

            @(testbench.sys_iff.ck)

            basic_task_instance.get_random_A_B();
            testbench.sys_iff.control_alu = 4'b1010;
            @(testbench.sys_iff.ck)
            check_alu_instance.S_LOWER();

            @(testbench.sys_iff.ck)

            basic_task_instance.get_random_A_B();
            testbench.sys_iff.control_alu = 4'b1011;
            @(testbench.sys_iff.ck)
            check_alu_instance.U_HIGHER();

            @(testbench.sys_iff.ck)

            basic_task_instance.get_random_A_B();
            testbench.sys_iff.control_alu = 4'b1100;
            @(testbench.sys_iff.ck)
            check_alu_instance.S_HIGHER();

            @(testbench.sys_iff.ck)

            basic_task_instance.get_random_A_B();
            testbench.sys_iff.control_alu = 4'b1101;
            @(testbench.sys_iff.ck)
            check_alu_instance.SHIFT_LEFT();

            @(testbench.sys_iff.ck)

            basic_task_instance.get_random_A_B();
            testbench.sys_iff.control_alu = 4'b1110;
            @(testbench.sys_iff.ck)
            check_alu_instance.SHIFT_RIGHT_LOGIC();

            @(testbench.sys_iff.ck)

            basic_task_instance.get_random_A_B();
            testbench.sys_iff.control_alu = 4'b1111;
            @(testbench.sys_iff.ck)
            check_alu_instance.SHIFT_RIGHT_ARIT();

            @(testbench.sys_iff.ck)
            check_alu_instance.flag_check();

            

        end
    endtask

endmodule