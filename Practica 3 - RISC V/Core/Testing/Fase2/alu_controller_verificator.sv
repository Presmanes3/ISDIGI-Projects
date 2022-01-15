class alu_controller_verificator;
    
    string name;
    logic [6:0] func_7_bits;
    logic [2:0] func_3_bits;
    logic [3:0] alu_operation;


    task taskName(
        string name,
        logic [6:0] func_7_bits,
        logic [2:0] func_3_bits,
        logic [3:0] alu_operation
    );
       $display("===== CONFIGURATION FOR %s =====  
        [FUNC 7 BITS] [FUNC 3 BITS] [ALU OPERATION] 
        [  %d  ] [    %d     ] [         %d       ] ",
        this.name, 
        this.func_7_bits,
        this.func_3_bits,
        this.alu_operation);

    endtask 


    task check();
        assert (phase_2_testbench.core.alu_controller_alu_operation == this.alu_operation) 
        else   $display("ERROR [ALU_OPERATION] NOT CORRECT");

        if(this.func_7_bits != 7'bxxxxxxx) begin
            assert (phase_2_testbench.core.alu_controller_func_7_bits == this.func_7_bits) 
            else   $display("ERROR [FUNC_7_BITS] NOT CORRECT");
        end

        if(this.func_3_bits != 3'bxxx)begin
            assert (phase_2_testbench.core.alu_controller_func_3_bits == this.func_3_bits) 
            else   $display("ERROR [FUNC_3_BITS] NOT CORRECT");
        end
    endtask 
endclass //alu_controller_verificator