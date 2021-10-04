module tb_FIFO(
    
);

`timescale 1ns/1ps

parameter T = 20;

// Declare inputs
reg [7:0] DATA_IN;
reg READ;
reg WRITE;
reg CLEAR_N;
reg RESET_N;
reg CLK;

// Declare outputs
wire [7:0] DATA_OUT;
wire F_FULL_N;			// Used to indicate that FIFO is full
wire F_EMPTY_N;			// Used to indicate that FIFO is empty
wire [4:0] USE_DW;		// Used to indicate how many elements are in use


FIFO_32_8 DUV(
    .*
);


initial begin
    $display("Your clock period will be %s ns", T);

    // Set initial values for registers
    DATA_IN = 8'b00000000;
    READ    = 1'b0;
    WRITE   = 1'b0;
    CLEAR_N = 1'b0;
    RESET_N = 1'b0;  
    CLK = 1'b0;

    // Reset and clear the system
    reset_system();
    clear_system();

    // Try writing 1 element
    write_1_element(8'b00000001);
    write_1_element(8'b00000010);
    write_1_element(8'b00000100);
    write_1_element(8'b00001000);
    $stop;

end

task write_1_element(reg [7:0] value_to_read);
    DATA_IN = value_to_read;
    WRITE   = 1'b1;
    #(T/2);
    WRITE   = 1'b0;
    #(T/2);
endtask

task read_1_element();

endtask

task reset_system();
    RESET_N = 1'b0;

    #(T/2);

    RESET_N = 1'b1;

    #(T/2);
endtask

task clear_system();
    CLEAR_N = 1'b0;

    #(T/2);

    CLEAR_N = 1'b1;

    #(T/2);
endtask



always #T CLK =~ CLK; //now you create your cyclic clock


    
endmodule