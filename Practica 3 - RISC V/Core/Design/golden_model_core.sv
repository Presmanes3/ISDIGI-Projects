`include "./Basic Components/memory.sv"
`include "./Basic Components/register_bank.sv"
`include "./Controllers/main_controller.sv"
`include "./Controllers/alu_controller.sv"
`include "./Golden Components/pc_golden.sv"
`include "./Basic Components/ADDER.sv"
`include "./Basic Components/immgen.sv"
`include "./Basic Components/mux_2_input.sv"
`include "./Basic Components/mux_3_input.sv"
`include "./Basic Components/jump_controller.sv"
`include "./golden_interface.sv"
`include "./Autochecks/golden_model_autochecks.sv"


module golden_model_core 
#(
    parameter sintetizable = 1'b0,
    parameter data_bits = 32,
    parameter memory_size = 1024,
    parameter memory_address_bits = $clog2(memory_size),
    parameter program_file  = ""
)
(
    golden_interface wires
); 

    // Configure Adders and PC
    
    ADDER ADDER_SUM (                  
        .adder_wiring   (wires.adder_sum_wiring)    
    );

    ADDER ADDER_PC (                 
        .adder_wiring   (wires.adder_pc_wiring)  
    );

    mux_2_input mux_pc (  
        .mux_2_input_wiring (wires.mux_pc_wiring)   
    );

    PC PC (
        .pc_wiring  (wires.pc_wiring)
    );

    jump_controller jump_controller(
        .jump_controller_wiring (wires.jump_controller_wiring)
    );

    ALU ALU (                      
        .alu_wiring (wires.alu_wiring)
    );

    memory data_memory (         
        .memory_wiring  (wires.data_memory_wiring)
    );
    

    memory #(.input_file(program_file), .charge_file(1'b1)) instruction_memory  (
        .memory_wiring  (wires.instruction_memory_wiring)
    );

    mux_3_input mux_alu1 (
        .mux_3_input_wiring (wires.mux_alu1_wiring)
    );

    mux_2_input mux_alu2(                   
        .mux_2_input_wiring (wires.mux_alu2_wiring)
    );
    
    mux_2_input mux_mem (                        
        .mux_2_input_wiring (wires.mux_mem_wiring)
    );

    register_bank register_bank (
        .register_bank_wiring   (wires.register_bank_wiring)
    );
    

    imm_gen imm_gen (
        .imm_gen_wiring (wires.imm_gen_wiring)
    );
                
    // Instanciate the control module
    main_controller controller(
    .main_controller_wiring (wires.main_controller_wiring)
    );
    
    alu_controller alu_control(
        .alu_controller_wiring  (wires.alu_controller_wiring)
    );

    golden_model_autochecks golden_model_autochecks(
        .wires  (wires)
    );

    defparam data_memory.sintetizable           = sintetizable;
    defparam instruction_memory.sintetizable    = sintetizable;
    defparam register_bank.sintetizable         = sintetizable;
endmodule
