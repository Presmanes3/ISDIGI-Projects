module basic_fifo_tasks(
	FIFO_IFF fifo_iff
);

`timescale 1ns/1ps

parameter T = 20;       // Time unit in ps

// Declare logicisters for tasks
logic [7:0] DATA_IN_;
logic READ_;
logic WRITE_;
logic CLEAR_N_;
logic RESET_N_;
logic CLK_;

// Assignmets for wires
assign fifo_iff.DATA_IN 	= DATA_IN_;
assign fifo_iff.READ 		= READ_;
assign fifo_iff.WRITE 		= WRITE_;
assign fifo_iff.CLEAR_N 	= CLEAR_N_;
assign fifo_iff.RESET_N 	= RESET_N_;
assign fifo_iff.CLK 		= CLK_;


// Declare basic tasks
task init();
	RESET_N_ 	= 0;
	DATA_IN_ 	= 8'b00000000;
	READ_ 		= 0;
	WRITE_ 		= 0;
	CLEAR_N_	= 1;
	RESET_N_ 	= 1;
	CLK_	 	= 0; 

	#T;
endtask

// Reset the system async
task reset();
	#0 RESET_N_ 	= 0;
	#1 RESET_N_ 	= 1;
endtask

// Reset the system with CLK posedge
task clear();
	CLEAR_N_ 	= 0;
	@(posedge CLK_);
	CLEAR_N_ 	= 1;
endtask

// Enable read logic
task enable_read();
    READ_ 	= 1;
endtask

// Disable read logic
task disable_read();
    READ_ 	= 0;
endtask

// Enable write logic
task enable_write();
	WRITE_	= 1;
endtask

// Disable write logic
task disable_write();
	WRITE_	= 0;
endtask

task write([7:0] data);
	DATA_IN_ = data;
	enable_write();

	@(posedge CLK_);

	disable_write();

	@(negedge CLK_);
endtask

task read();
	enable_read();

	@(posedge CLK_);

	disable_read();

	@(negedge CLK_);
endtask

// Define clock source
always #(T/2) CLK_ =~ CLK_; //now you create your cyclic clock
    
endmodule