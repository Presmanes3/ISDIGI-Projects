interface golden_interface;

    logic clk;
    logic reset;

    adder_interface             adder_sum_wiring();
    adder_interface             adder_pc_wiring();
    mux_2_input_interface       mux_pc_wiring();
    memory_interface            data_memory_wiring();
    jump_controller_interface   jump_controller_wiring();
    pc_interface                pc_wiring();
    memory_interface            instruction_memory_wiring();
    mux_alu1_interface          mux_alu1_wiring();
    imm_gen_interface           imm_gen_wiring();
    register_bank_interface     register_banck_wiring();
    main_controller_interface   main_controller_wiring();
    alu_controller_interface    alu_controller_wiring();
    ALU_interface               alu_wiring();
endinterface //golden_interface    
