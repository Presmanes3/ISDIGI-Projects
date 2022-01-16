`include "./Basic Components/memory.sv"
`include "./Basic Components/register_bank.sv"
`include "./Controllers/main_controller.sv"
`include "./Controllers/alu_controller.sv"
`include "./Segmented Components/pc_segmented.sv"
`include "./Basic Components/ADDER.sv"
`include "./Basic Components/immgen.sv"
`include "./Basic Components/mux_2_input.sv"
`include "./Basic Components/mux_3_input.sv"
`include "./Basic Components/jump_controller.sv"

`include "./Segmented Registers/register_ex_mem.sv"
`include "./Segmented Registers/register_id_ex.sv"
`include "./Segmented Registers/register_if_id.sv"
`include "./Segmented Registers/register_mem_wb.sv"

`include "./Risk Detectors/clear_pipeline.sv"
`include "./Risk Detectors/data_forwarding.sv"
`include "./Risk Detectors/hazard_detection_unit.sv"

`include "./Segmented Components/ALU_encapsulator.sv"
`include "./segmented_interface.sv"

module segmented_core
#(
    parameter sintetizable = 1'b0,
    parameter data_bits = 32,
    parameter memory_size = 1024,
    parameter memory_address_bits = $clog2(memory_size),
    parameter program_file  = ""
)
(
    segmented_interface wires
);


    ADDER ADDER_SUM (                  
        .adder_wiring               (wires.adder_sum_wiring)    
    );

    ADDER ADDER_PC (                 
        .adder_wiring               (wires.adder_pc_wiring)  
    );

    mux_2_input mux_pc (  
        .mux_2_input_wiring         (wires.mux_pc_wiring)   
    );
   
    PC PC (
        .pc_wiring                  (wires.pc_wiring)
    );

    jump_controller jump_controller(
        .jump_controller_wiring      (wires.jump_controller_wiring)
    );

    alu_encapsulator alu_encapsulator(
        .alu_encapsulator_wiring    (wires.alu_encapsulator_wiring)
    );

    memory data_memory (         
        .memory_wiring              (wires.data_memory_wiring)
    );
    defparam data_memory.sintetizable = sintetizable;

    memory #(.input_file(program_file), .charge_file(1'b1)) instruction_memory  (
        .memory_wiring              (wires.instruction_memory_wiring)
    );
    defparam instruction_memory.sintetizable = sintetizable;

    mux_2_input mux_mem (                        
        .mux_2_input_wiring         (wires.mux_mem_wiring)
    );

    register_bank register_bank (
        .register_bank_wiring       (wires.register_bank_wiring)
    );
    defparam register_bank.sintetizable = sintetizable;

    imm_gen imm_gen (
        .imm_gen_wiring             (wires.imm_gen_wiring)
    );
                
    // Instanciate the control module
    main_controller controller(
        .main_controller_wiring     (wires.main_controller_wiring)
    );

    alu_controller alu_control(
        .alu_controller_wiring       (wires.alu_controller_wiring)
    );

    // ========== ========== REGISTERS ========== ========== //

    register_if_id register_if_id(
       .reg_if_id_wiring       (wires.reg_if_id_wiring)
    );

    register_id_ex register_id_ex(
       .reg_id_ex_wiring       (wires.reg_id_ex_wiring)
    );

    register_ex_mem register_ex_mem(
       .reg_ex_mem_wiring      (wires.reg_ex_mem_wiring)
    );

    register_mem_wb register_mem_wb(
       .reg_mem_wb_wiring      (wires.reg_mem_wb_wiring)
    );

    // ========== ========== RISK DETECTORS ========== ========== //

    hazard_detection_unit hazard_detection_unit(
       .wiring                 (wires.hazard_detection_unit_wiring)
    );

    clear_pipeline clear_pipeline(
        .wiring                 (wires.clear_pipeline_wiring)
    );

    data_forwarding data_forwarding(
        .wiring                 (wires.data_forwarding_wiring)
    );
endmodule



