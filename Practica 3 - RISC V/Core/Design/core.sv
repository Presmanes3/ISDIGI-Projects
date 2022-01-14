module core (
    logic clk,
    logic reset
);

    // Instanciate main interfaces for wires
    golden_interface golden_core_wires();
    segmented_interface segmented_core_wires();

    // Designator instances for segmented core
    adder_sum_wiring_designator             adder_sum_wiring_designator             (segmented_core_wires);
    adder_pc_wiring_designator              adder_pc_wiring_designator              (segmented_core_wires);
    pc_wiring_designator                    pc_wiring_designator                    (segmented_core_wires);
    instruction_memory_wiring_designator    instruction_memory_wiring_designator    (segmented_core_wires);
    data_memory_wiring_designator           data_memory_wiring_designator           (segmented_core_wires);
    register_bank_wiring_designator         register_bank_wiring_designator         (segmented_core_wires);
    imm_gen_wiring_designator               imm_gen_wiring_designator               (segmented_core_wires);
    alu_encapsulator_wiring_designator      alu_encapsulator_wiring_designator      (segmented_core_wires);
    mux_mem_wiring_designator               mux_mem_wiring_designator               (segmented_core_wires);
    mux_pc_wiring_designator                mux_pc_wiring_designator                (segmented_core_wires);
    jump_controller_wiring_designator       jump_controller_wiring_designator       (segmented_core_wires);
    main_controller_wiring_designator       main_controller_wiring_designator       (segmented_core_wires);
    alu_controller_wiring_designator        alu_controller_wiring_designator        (segmented_core_wires);
    reg_if_id_wiring_designator             reg_if_id_wiring_designator             (segmented_core_wires);
    reg_id_ex_wiring_designator             reg_id_ex_wiring_designator             (segmented_core_wires);
    reg_ex_mem_wiring_designator            reg_ex_mem_wiring_designator            (segmented_core_wires);
    reg_mem_wb_wiring_designator            reg_mem_wb_wiring_designator            (segmented_core_wires);

    // Designator instances for golden core

    // Instanciate the cores
    golden_model_core goden_core        (golden_core_wires);
    segmented_model_core segmented_core (segmented_core_wires);


endmodule