module core #(
        parameter program_file  = ""
)(
    input clk,
    input reset
);

    // Instanciate main interfaces for wires
    //golden_interface golden_core_wires();
    segmented_interface segmented_core_wires();
	 
	 
	 assign segmented_core_wires.clk = clk;
	 assign segmented_core_wires.reset = reset;

    // Designator instances for segmented core
    adder_sum_wiring_designator             adder_sum_wiring_designator             (.wires(segmented_core_wires));
    adder_pc_wiring_designator              adder_pc_wiring_designator              (.wires(segmented_core_wires));
    pc_wiring_designator                    pc_wiring_designator                    (.wires(segmented_core_wires));
    instruction_memory_wiring_designator    instruction_memory_wiring_designator    (.wires(segmented_core_wires));
    data_memory_wiring_designator           data_memory_wiring_designator           (.wires(segmented_core_wires));
    register_bank_wiring_designator         register_bank_wiring_designator         (.wires(segmented_core_wires));
    immediate_generator_wiring_designator   immediate_generator_wiring_designator   (.wires(segmented_core_wires));
    alu_encapsulator_wiring_designator      alu_encapsulator_wiring_designator      (.wires(segmented_core_wires));
    mux_mem_wiring_designator               mux_mem_wiring_designator               (.wires(segmented_core_wires));
    mux_pc_wiring_designator                mux_pc_wiring_designator                (.wires(segmented_core_wires));
    jump_controller_wiring_designator       jump_controller_wiring_designator       (.wires(segmented_core_wires));
    main_controller_wiring_designator       main_controller_wiring_designator       (.wires(segmented_core_wires));
    alu_controller_wiring_designator        alu_controller_wiring_designator        (.wires(segmented_core_wires));
    reg_if_id_wiring_designator             reg_if_id_wiring_designator             (.wires(segmented_core_wires));
    reg_id_ex_wiring_designator             reg_id_ex_wiring_designator             (.wires(segmented_core_wires));
    reg_ex_mem_wiring_designator            reg_ex_mem_wiring_designator            (.wires(segmented_core_wires));
    reg_mem_wb_wiring_designator            reg_mem_wb_wiring_designator            (.wires(segmented_core_wires));

    //Designator instances for golden core
    adder_sum_wiring_designator             adder_sum_wiring_designator             (.wires(golden_core_wires));
    adder_pc_wiring_designator              adder_pc_wiring_designator              (.wires(golden_core_wires));
    pc_wiring_designator                    pc_wiring_designator                    (.wires(golden_core_wires));
    instruction_memory_wiring_designator    instruction_memory_wiring_designator    (.wires(golden_core_wires));
    data_memory_wiring_designator           data_memory_wiring_designator           (.wires(golden_core_wires));
    register_bank_wiring_designator         register_bank_wiring_designator         (.wires(golden_core_wires));
    imm_gen_wiring_designator               imm_gen_wiring_designator               (.wires(golden_core_wires));
    alu_wiring_designator                   alu_wiring_designator                   (.wires(golden_core_wires));
    mux_mem_wiring_designator               mux_mem_wiring_designator               (.wires(golden_core_wires));
    mux_three_alu_wiring_designator         mux_three_alu_wiring_designator         (.wires(golden_core_wires));
    mux_mem_wiring_designator               mux_mem_wiring_designator               (.wires(golden_core_wires));
    mux_pc_wiring_designator                mux_pc_wiring_designator                (.wires(golden_core_wires));
    jump_controller_wiring_designator       jump_controller_wiring_designator       (.wires(golden_core_wires));
    main_controller_wiring_designator       main_controller_wiring_designator       (.wires(golden_core_wires));
    alu_controller_wiring_designator        alu_controller_wiring_designator        (.wires(golden_core_wires));

    // Instanciate the cores
    golden_model_core   #(.program_file(program_file))  goden_core    (.wires(golden_core_wires));
    segmented_core      #(.program_file(program_file))  segmented_core(.wires(segmented_core_wires));


endmodule