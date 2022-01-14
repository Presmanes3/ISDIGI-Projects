interface segmented_interface;

    logic clk;
    logic reset;

    hazar_detection_unit_interface  hazar_detection_unit_wiring();

    adder_sum_interface             adder_sum_wiring();             // 0 OK - REVIEWED
    adder_sum_interface             adder_pc_wiring();              // 1 OK - REVIEWED
    pc_interface                    pc_wiring();                    // 2 OK - REVIEWED
    memory_interface                instruction_memory_wiring();    // 3 OK - REVIEWED
    memory_interface                data_memory_wiring();           // 0 OK - REVIEWED
    register_bank_interface         register_bank_wiring();         // 1 OK - REVIEWED
    imm_gen_interface               imm_gen_wiring();               // 2 OK - REVIEWED
    alu_encapsulator_interface      alu_encapsulator_wiring();      // 3 OK - REVIEWED
    mux_2_input_interface           mux_mem_wiring();               // 1 OK - REVIEWED
    mux_2_input_interface           mux_pc_wiring();                // 2 OK - REVIEWED
    jump_controler_interface        jump_controler_wiring();        // 3 OK - 
    main_controller_interface       main_controller_wiring();       // 0 OK - REVIEWED
    alu_controller_interface        alu_controller_wiring();        // 1 OK - REVIEWED
    register_if_id_interface        reg_if_id_wiring();             // 2 OK 
    register_id_ex_interface        reg_id_ex_wiring();             // 3 OK
    register_ex_mem_interface       reg_ex_mem_wiring();            // 0 OK
    register_mem_wb_interface       reg_mem_wb_wiring();            // 1 OK - REVIEWED
endinterface