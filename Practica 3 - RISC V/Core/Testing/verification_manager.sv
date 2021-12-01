`include "main_controller_verificator.sv"
// `include "alu_controller_verificator.sv"

class verification_manager;

    int total_cycles;

    logic [3:0] alu_option;
    
    // Instruction types instances
    main_controller_verificator type_r_main_ver;
    main_controller_verificator type_i_main_ver;
    main_controller_verificator type_load_main_ver;
    main_controller_verificator type_control_main_ver;
    main_controller_verificator type_storage_main_ver;

    // Alu controller
    // alu_controller_verificator type_r_alu_ver;

    task init;

        alu_option = 0;
        total_cycles = 0;

        type_r_main_ver          = new();
        type_i_main_ver          = new();
        type_load_main_ver       = new();
        type_control_main_ver    = new();
        type_storage_main_ver    = new();

        type_r_main_ver.configure("TYPE R INSTRUCTION",              0, 0, 0, 0, 0, 1, 2);
        type_i_main_ver.configure("TYPE I INSTRUCTION",              0, 0, 0, 0, 1, 1, 2);
        type_load_main_ver.configure("TYPE LOAD VERIFICATOR",        0, 1, 1, 0, 1, 1, 2);
        type_control_main_ver.configure("TYPE CONTROL VERIFICATOR",  1, 0, 0, 0, 0, 0, 2);
        type_storage_main_ver.configure("TYPE STORAGE VERIFICATOR",  0, 0, 0, 1, 1, 0, 2);
    endtask


    task update;

        alu_option = {phase_2_testbench.core.main_controller_opcode[6:4], phase_2_testbench.core.main_controller_opcode[2]};
        
        this.verify_main_controller();
    
    endtask //automatic

    task  verify_main_controller;
        case (alu_option)
            // Type LOAD
            4'b0000: begin 
                $display("Verifying type LOAD instruction");
                type_load_main_ver.check();
            end
            // Type I
            4'b0010: begin
                $display("Verifying type I instruction");
                type_i_main_ver.check();
            end
            // Type Storage
            4'b0100: begin
                $display("Verifying type STORAGE instruction");
                type_storage_main_ver.check();
            end
            // Type R
            4'b0110: begin 
                $display("Verifying type R instruction");
                type_r_main_ver.check();
            end
            // Type Control
            4'b1100: begin
                $display("Verifying type CONTROL instruction");
                type_control_main_ver.check();
            end
            default: $display("ERROR [ILLEGAL ALU OPTION] = [%b]", alu_option);
        endcase
    endtask 


endclass //className