`include "scoreboard.sv"
`include "interface.sv"
`include "DUV/multipli_parallel.sv"
`include "../Design/multipli_restored/multipli.sv"

module testbench();

`timescale 1ns/100ps

localparam T = 20;

// Instanciate the common system interface for signals
system_iff sys_iff();

parameter size = 8;

defparam sys_iff.A_bits = size;
defparam sys_iff.B_bits = size;

// Instanciate scoreboard
scoreboard #(size)  scoreboard_;

// Instanciate multipli control and link system interface
multipli_control multi_control_module(
);

defparam multi_control_module.size = size;

int tries = 0;


// ========== IDEAL VERIFICATION MODEL ========== //
// multipli_parallel multipli_model(
//                 .CLOCK(sys_iff.CLK), 
//                 .RESET(sys_iff.RESET_N), 
//                 .END_MULT(sys_iff.fin_mult), 
//                 .A(sys_iff.A), 
//                 .B(sys_iff.B), 
//                 .S(sys_iff.S_real), 
//                 .START(sys_iff.start)
// );

// ========== REAL VERIFICATION MODEL ========== //
multipli #(.size(size)) multipli_model(
                .CLOCK(sys_iff.CLK), 
                .RESET(sys_iff.RESET_N), 
                .END_MULT(sys_iff.fin_mult), 
                .A(sys_iff.A), 
                .B(sys_iff.B), 
                .S(sys_iff.S_real), 
                .START(sys_iff.start)   
);

initial begin
    // RUN VVERIFICATION TESTS
    scoreboard_ = new;

    multi_control_module.bts.inicializar();
    multi_control_module.bts.reset();

    sys_iff.comparing = 1'b0;

    // simple_debug(45, 96);
    // simple_debug(-45, 96);
    // simple_debug(45, -96);
    // simple_debug(-45, -96);
    model_verification();

    $stop();

end

task simple_debug(int A__, int B__);
    sys_iff.start = 1'b0;

    @(negedge sys_iff.CLK)                                           //Solo cambio valores en los negedge
   
    sys_iff.A = $signed(A__);
    sys_iff.B = $signed(B__);

    @(negedge sys_iff.CLK)

    multi_control_module.rango_valores_grupos_inst.sample();         //Calculo el coverage
    multi_control_module.rango_valores_inst.sample();

    sys_iff.start = 1'b1;                                            //Empiece a calcular la multi

    scoreboard_.multiply();

    @(posedge sys_iff.CLK)

    @(posedge sys_iff.fin_mult)                                      //Esperamos a que termine la multi
                
    @(negedge sys_iff.CLK)
    @(negedge sys_iff.CLK)

    sys_iff.comparing = 1'b1;
    scoreboard_.compare_outputs();                                   //Comparamos los resultados
    #2;
    sys_iff.comparing = 1'b0;

    @(posedge sys_iff.CLK)

    multi_control_module.bts.reset();

    tries = tries + 1;
endtask

// Task for model verification 
task model_verification();
        do
        begin
            sys_iff.start = 1'b0;
            $display("TRY [%d] >>> COVERAGE [%f]", tries ,multi_control_module.rango_valores_inst.get_inst_coverage());

            if(tries >= 200) begin
                $display("NUMBER OF TRIES EXCEEEDED!");
                break;
            end

            @(negedge sys_iff.CLK)                                           //Solo cambio valores en los negedge
            multi_control_module.get_random_values();                        //Conseguir valores aleatorios

            @(negedge sys_iff.CLK)

            multi_control_module.rango_valores_grupos_inst.sample();         //Calculo el coverage
            multi_control_module.rango_valores_inst.sample();

            sys_iff.start = 1'b1;                                            //Empiece a calcular la multi

            scoreboard_.multiply();

            @(posedge sys_iff.CLK)

            @(posedge sys_iff.fin_mult)                                      //Esperamos a que termine la multi
                
            @(negedge sys_iff.CLK)
            @(negedge sys_iff.CLK)

            sys_iff.comparing = 1'b1;
            scoreboard_.compare_outputs();                                   //Comparamos los resultados
            #2;
            sys_iff.comparing = 1'b0;

            @(posedge sys_iff.CLK)

            multi_control_module.bts.reset();

            tries = tries + 1;

        end
    while (multi_control_module.rango_valores_inst.get_inst_coverage() <= 90);
endtask

always  begin
    #(T/2)
    sys_iff.CLK = ~sys_iff.CLK;
end

always @(negedge sys_iff.RESET_N) begin
    sys_iff.S_ideal = 0;
end


endmodule