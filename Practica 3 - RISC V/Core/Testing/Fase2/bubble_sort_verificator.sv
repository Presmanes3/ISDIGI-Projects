// `include "../../Design/golden_model_core.sv"
`include "./bubble_sort_test.sv"

// `include "../../Design/Designators/Golden Designators/adder_pc_wiring_designator.sv"
// `include "../../Design/Designators/Golden Designators/adder_sum_wiring_designator.sv"
// `include "../../Design/Designators/Golden Designators/alu_controller_wiring_designator.sv"
// `include "../../Design/Designators/Golden Designators/alu_wiring_designator.sv"
// `include "../../Design/Designators/Golden Designators/data_memory_wiring_designator.sv"
// `include "../../Design/Designators/Golden Designators/imm_gen_wiring_designator.sv"
// `include "../../Design/Designators/Golden Designators/instruction_memory_wiring_designator.sv"
// `include "../../Design/Designators/Golden Designators/jump_controller_wiring_designator.sv"
// `include "../../Design/Designators/Golden Designators/main_controller_wiring_designator.sv"
// `include "../../Design/Designators/Golden Designators/mux_alu1_wiring_designator.sv"
// `include "../../Design/Designators/Golden Designators/mux_alu2_wiring_designator.sv"
// `include "../../Design/Designators/Golden Designators/mux_pc_wiring_designator.sv"
// `include "../../Design/Designators/Golden Designators/pc_wiring_designator.sv"
// `include "../../Design/Designators/Golden Designators/register_bank_wiring_designator.sv"

module bubble_sort_verificator#(
    parameter CLK_PERIOD = 20
    )(
    input clk,
    input reset
);
    // Create the interface for golden model uP
    golden_interface golden_core_wires();

    assign golden_core_wires.clk    = clk;
    assign golden_core_wires.reset  = reset;

    // Wire all the connections of the core
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

    golden_model_core #(.program_file("Core/Testing/Programs/Complex/BubbleSort/bubble.mem")) core(.wires(golden_core_wires));

    defparam core.sintetizable = 1'b0;

    bubble_test bubble_duv;

    reg test_finished = 0;

    initial begin
        bubble_duv = new();
        bubble_duv.init();
        
        Phase2_testbench.reset_();

        // Wait until program end to check
        @(golden_core_wires.instruction_memory_wiring.output_data == 32'h00000013)

        bubble_duv.check();

        test_finished = 1;
    
    end
endmodule