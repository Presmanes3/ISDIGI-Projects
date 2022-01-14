interface main_controller_interface();
    logic [6:0] opcode; 

    logic hazard_mux_enable;

    logic reg branch;
    logic reg memory_read;
    logic reg memory_to_register;
    logic [3:0] alu_option;
    logic memory_write;
    logic alu_source;
    logic register_write;

    logic [1:0] AuipcLui;    

endinterface //main_controller_interface




/**
    @brief main controller circuit for controlling signals of the different modules

    @input opcode operational code

    @output branch
    @output memory_read signal for enabling memory read
    @output memory_to_register signal for selecting value from RAM memory or ALU output
    @output alu_option 
    @output memory_write signal for writing in memory
    @output alu_source signal for selecting source of ALU
    @output register_write signal for writing in register bank

    @outputAuipcLui

*/
module main_controller(
main_controller_interface main_controller_wiring
);


assign main_controller_wiring.alu_option = !hazard_mux_enable ? {main_controller_wiring.opcode[6:4], main_controller_wiring.opcode[2]} : 4'b0000;

always_comb begin

        main_controller_wiring.AuipcLui            = 2'b00;
        main_controller_wiring.alu_source          = 1'b0;
        main_controller_wiring.memory_to_register  = 1'b0;
        main_controller_wiring.memory_read         = 1'b0;
        main_controller_wiring.memory_write        = 1'b0;
        main_controller_wiring.register_write      = 1'b0;
        main_controller_wiring.branch              = 1'b0; 
		  
    if(!hazard_mux_enable)begin
        main_controller_wiring.AuipcLui = 2'b10;
        case (main_controller_wiring.alu_option)

            // Type LOAD
            4'b0000: begin
                main_controller_wiring.alu_source          = 1'b1;
                main_controller_wiring.memory_to_register  = 1'b1; 
                main_controller_wiring.memory_read         = 1'b1;
                main_controller_wiring.memory_write        = 1'b0;
                main_controller_wiring.register_write      = 1'b1; 
                main_controller_wiring.branch              = 1'b0; 
            end

            // Type I
            4'b0010: begin
                main_controller_wiring.alu_source          = 1'b1;
                main_controller_wiring.memory_to_register  = 1'b0;
                main_controller_wiring.memory_read         = 1'b0;
                main_controller_wiring.memory_write        = 1'b0;
                main_controller_wiring.register_write      = 1'b1;
                main_controller_wiring.branch              = 1'b0;
            end

            4'b0011: begin

            end

            // Type STORAGE
            4'b0100: begin
                main_controller_wiring.alu_source          = 1'b1;
                main_controller_wiring.memory_to_register  = 1'b0;
                main_controller_wiring.memory_read         = 1'b0;
                main_controller_wiring.memory_write        = 1'b1; 
                main_controller_wiring.register_write      = 1'b0;
                main_controller_wiring.branch              = 1'b0;
            end

            // Type R
            4'b0110: begin
                main_controller_wiring.alu_source          = 1'b0;
                main_controller_wiring.memory_to_register  = 1'b0;
                main_controller_wiring.memory_read         = 1'b0;
                main_controller_wiring.memory_write        = 1'b0;
                main_controller_wiring.register_write      = 1'b1;
                main_controller_wiring.branch              = 1'b0;
            end

            // Type Write in memory
            4'b0111: begin
                main_controller_wiring.alu_source          = 1'b0;
                main_controller_wiring.memory_to_register  = 1'b0;
                main_controller_wiring.memory_read         = 1'b0;
                main_controller_wiring.memory_write        = 1'b0;
                main_controller_wiring.register_write      = 1'b1;
                main_controller_wiring.branch              = 1'b0;
            end

            // Type CONDITIONAL JUMP
            4'b1100: begin
                main_controller_wiring.alu_source          = 1'b0;
                main_controller_wiring.memory_to_register  = 1'b0;
                main_controller_wiring.memory_read         = 1'b0;
                main_controller_wiring.memory_write        = 1'b0;
                main_controller_wiring.register_write      = 1'b0;
                main_controller_wiring.branch              = 1'b1;
            end
            default: begin
                main_controller_wiring.alu_source          = 1'b0;
                main_controller_wiring.memory_to_register  = 1'b0;
                main_controller_wiring.memory_read         = 1'b0;
                main_controller_wiring.memory_write        = 1'b0;
                main_controller_wiring.register_write      = 1'b0;
                main_controller_wiring.branch              = 1'b0;    
            end
        endcase
    end else begin
        controller_wiring.AuipcLui            = 2'b00;
        main_controller_wiring.alu_source          = 1'b0;
        main_controller_wiring.memory_to_register  = 1'b0;
        main_controller_wiring.memory_read         = 1'b0;
        main_controller_wiring.memory_write        = 1'b0;
        main_controller_wiring.register_write      = 1'b0;
        main_controller_wiring.branch              = 1'b0;    
    end
end

endmodule