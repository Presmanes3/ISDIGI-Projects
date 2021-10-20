`include "scoreboard.sv"
`include "interface.sv"

module testbench(
    
);

// Instanciate the common system interface for signals
system_iff sys_iff();

// Instanciate scoreboard
scoreboard scoreboard_;

// Instanciate multipli control and link system interface
multipli_control multi_control_module(
    .sys_iff(sys_iff)
);

initial begin
    scoreboard_ = new();

    multi_control_module.bts.inicializar(); //ejecuto la task inicializar

end


endmodule