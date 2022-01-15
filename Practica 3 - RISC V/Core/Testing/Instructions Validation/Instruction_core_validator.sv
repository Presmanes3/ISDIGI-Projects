`include "../../Design/core.sv"

module Instruction_core_validator #(
    parameter program_file = "ADD/add.mem"
    ) (
    input clk,
    input reset
);

    parameter file_path = {"Core/Testing/Programs/Simple/", program_file};

    core #(.program_file(file_path)) core(
        .clk(clk),
        .reset(reset)
    );

    int single_value = 0;
    int segmented_value = 0;

    task check();
        $display("==============================================================");
        $display("[TEST START] >>> %s", program_file);

        fork
            begin
                // Wait till the golden model finishes
                @(core.golden_core_wires.instruction_memory_wiring.output_data != 32'h00000013);
                $display("[SINGLE FINISHED]");
            end
            begin
                // Wait till the segmented model finishes
                 @(core.segmented_core_wires.instruction_memory_wiring.output_data != 32'h00000013); 
                $display("[SEGMENTED FINISHED]");
            end
        join

        $display("[CHECKING MEMORIES]");
        single_value    = core.golden_core.data_memory.data_pool[0];
        segmented_value = core.segmented_core.data_memory.data_pool[0];

        assert(single_value == segmented_value) else $info("[VALUE ERROR] SINGLE (%d) != SEGMENTED (%d)", single_value, segmented_value);

        $display("[TEST FINISH] >>> ", program_file);
        $display("==============================================================");
    endtask

    initial begin
        check();
    end

endmodule