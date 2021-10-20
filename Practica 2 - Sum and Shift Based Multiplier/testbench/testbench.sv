`include "scoreboard.sv"
`include "interface.sv"

module testbench(
    
);

// Instanciate the common system interface for signals
system_iff sys_iff();

defparam sys_iff.A_bits = 8;
defparam sys_iff.B_bits = 8;

// Instanciate scoreboard
scoreboard scoreboard_;

// Instanciate multipli control and link system interface
multipli_control multi_control_module(
);

initial begin
    scoreboard_ = new();


    multi_control_module.bts.inicializar(); //ejecuto la task inicializar

end


endmodule