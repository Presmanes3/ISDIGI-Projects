`include "./Designators/Golden Designators/adder_pc_wiring_designator.sv"
`include "./Designators/Golden Designators/adder_sum_wiring_designator.sv"
`include "./Designators/Golden Designators/alu_controller_wiring_designator.sv"
`include "./Designators/Golden Designators/alu_wiring_designator.sv"
`include "./Designators/Golden Designators/data_memory_wiring_designator.sv"
`include "./Designators/Golden Designators/imm_gen_wiring_designator.sv"
`include "./Designators/Golden Designators/instruction_memory_wiring_designator.sv"
`include "./Designators/Golden Designators/jump_controller_wiring_designator.sv"
`include "./Designators/Golden Designators/main_controller_wiring_designator.sv"
`include "./Designators/Golden Designators/mux_alu1_wiring_designator.sv"
`include "./Designators/Golden Designators/mux_alu2_wiring_designator.sv"
`include "./Designators/Golden Designators/mux_pc_wiring_designator.sv"
`include "./Designators/Golden Designators/pc_wiring_designator.sv"
`include "./Designators/Golden Designators/register_bank_wiring_designator.sv"

`include "./Designators/Segmented Designators/adder_pc_wiring_designator.sv"
`include "./Designators/Segmented Designators/adder_sum_wiring_designator.sv"
`include "./Designators/Segmented Designators/alu_controller_wiring_designator.sv"
`include "./Designators/Segmented Designators/alu_encapsulator_wiring_designator.sv"
`include "./Designators/Segmented Designators/data_memory_wiring_designator.sv"
`include "./Designators/Segmented Designators/immediate_generator_wiring_designator.sv"
`include "./Designators/Segmented Designators/main_controller_wiring_designator.sv"
`include "./Designators/Segmented Designators/mux_mem_wiring_designator.sv"
`include "./Designators/Segmented Designators/mux_pc_wiring_designator.sv"
`include "./Designators/Segmented Designators/pc_wiring_designator.sv"
`include "./Designators/Segmented Designators/jump_controller_wiring_designator.sv"
`include "./Designators/Segmented Designators/instruction_memory_wiring_designator.sv"
`include "./Designators/Segmented Designators/reg_id_ex_wiring_designator.sv"
`include "./Designators/Segmented Designators/reg_if_id_wiring_designator.sv"
`include "./Designators/Segmented Designators/reg_ex_mem_wiring_designator.sv"
`include "./Designators/Segmented Designators/reg_mem_wb_wiring_designator.sv"
`include "./Designators/Segmented Designators/register_bank_wiring_designator.sv"

module core #(
        parameter program_file  = ""
)(
    input clk,
    input reset
);

    // Instanciate main interfaces for wires
    golden_interface golden_core_wires();
    segmented_interface segmented_core_wires();
	 
	 
	assign segmented_core_wires.clk = clk;
	assign segmented_core_wires.reset = reset;

    assign golden_core_wires.clk = clk;  
    assign golden_core_wires.reset = reset;

    // Designator instances for segmented core
    adder_sum_wiring_designator_segmented             adder_sum_wiring_designator_segmented               (.wires(segmented_core_wires));
    adder_pc_wiring_designator_segmented              adder_pc_wiring_designator_segmented                (.wires(segmented_core_wires));
    pc_wiring_designator_segmented                    pc_wiring_designator_segmented                      (.wires(segmented_core_wires));
    instruction_memory_wiring_designator_segmented    instruction_memory_wiring_designator_segmented      (.wires(segmented_core_wires));
    data_memory_wiring_designator_segmented           data_memory_wiring_designator_segmented             (.wires(segmented_core_wires));
    register_bank_wiring_designator_segmented         register_bank_wiring_designator_segmented           (.wires(segmented_core_wires));
    immediate_generator_wiring_designator_segmented   immediate_generator_wiring_designator_segmented     (.wires(segmented_core_wires));
    alu_encapsulator_wiring_designator_segmented      alu_encapsulator_wiring_designator_segmented        (.wires(segmented_core_wires));
    mux_mem_wiring_designator_segmented               mux_mem_wiring_designator_segmented                 (.wires(segmented_core_wires));
    mux_pc_wiring_designator_segmented                mux_pc_wiring_designator_segmented                  (.wires(segmented_core_wires));
    jump_controller_wiring_designator_segmented       jump_controller_wiring_designator_segmented         (.wires(segmented_core_wires));
    main_controller_wiring_designator_segmented       main_controller_wiring_designator_segmented         (.wires(segmented_core_wires));
    alu_controller_wiring_designator_segmented        alu_controller_wiring_designator_segmented          (.wires(segmented_core_wires));
    reg_if_id_wiring_designator_segmented             reg_if_id_wiring_designator_segmented               (.wires(segmented_core_wires));
    reg_id_ex_wiring_designator_segmented             reg_id_ex_wiring_designator_segmented               (.wires(segmented_core_wires));
    reg_mem_wb_wiring_designator_segmented            reg_mem_wb_wiring_designator_segmented              (.wires(segmented_core_wires));
    reg_ex_mem_wiring_designator_segmented            reg_ex_mem_wiring_designator_segmented              (.wires(segmented_core_wires));  
    //Designator instances for golden core
    adder_sum_wiring_designator             adder_sum_wiring_designator             (.wires(golden_core_wires));
    adder_pc_wiring_designator              adder_pc_wiring_designator              (.wires(golden_core_wires));
    pc_wiring_designator                    pc_wiring_designator                    (.wires(golden_core_wires));
    instruction_memory_wiring_designator    instruction_memory_wiring_designator    (.wires(golden_core_wires));
    data_memory_wiring_designator           data_memory_wiring_designator           (.wires(golden_core_wires));
    register_bank_wiring_designator         register_bank_wiring_designator         (.wires(golden_core_wires));
    immediate_generator_wiring_designator   immediate_generator_wiring_designator   (.wires(golden_core_wires));
    alu_wiring_designator                   alu_wiring_designator                   (.wires(golden_core_wires));
    mux_mem_wiring_designator               mux_mem_wiring_designator               (.wires(golden_core_wires));
    mux_alu1_wiring_designator              mux_alu1_wiring_designator              (.wires(golden_core_wires));
    mux_alu2_wiring_designator              mux_alu2_wiring_designator              (.wires(golden_core_wires));
    mux_pc_wiring_designator                mux_pc_wiring_designator                (.wires(golden_core_wires));
    jump_controller_wiring_designator       jump_controller_wiring_designator       (.wires(golden_core_wires));
    main_controller_wiring_designator       main_controller_wiring_designator       (.wires(golden_core_wires));
    alu_controller_wiring_designator        alu_controller_wiring_designator        (.wires(golden_core_wires));

    // Instanciate the cores
    golden_model_core   #(.program_file(program_file))  golden_core     (.wires(golden_core_wires));
    segmented_core      #(.program_file(program_file))  segmented_core  (.wires(segmented_core_wires));


    defparam golden_core.sintetizable = 1'b0;
    defparam golden_core.sintetizable = 1'b0;

endmodule