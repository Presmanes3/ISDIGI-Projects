interface golden_interface;
    logic clk;
    logic reset;

    adder_interface             adder_sum_wiring();             // OK - REVIEWED
    adder_interface             adder_pc_wiring();              // OK - REVIEWED
    mux_2_input_interface       mux_pc_wiring();                // OK - REVIEWED
    memory_interface            data_memory_wiring();           // OK - REVIEWED
    jump_controller_interface   jump_controller_wiring();       // OK - REVIEWED
    pc_interface                pc_wiring();                    // OK - REVIEWED
    memory_interface            instruction_memory_wiring();    // OK - REVIEWED
    mux_3_input_interface       mux_alu1_wiring();              // OK - REVIEWED
    mux_2_input_interface       mux_alu2_wiring();              // OK - REVIEWED
    mux_2_input_interface       mux_mem_wiring();               // OK - REVIEWED
    imm_gen_interface           imm_gen_wiring();               // OK - REVIEWED
    register_bank_interface     register_bank_wiring();         // OK - REVIEWED
    main_controller_interface   main_controller_wiring();       // OK - REVIEWED
    alu_controller_interface    alu_controller_wiring();        // OK - REVIEWED
    ALU_interface               alu_wiring();                   // OK - REVIEWED
endinterface //golden_interface    
