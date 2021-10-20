`include "interface.sv"
`include "multiply_controler_classes/random.sv"
`include "multiply_controler_classes/basic_task.sv"

module multipli_control (system_iff sys_iff);

    //Inicializo asignador aleatorio
    RCSG random;

    basic_task bts;

    initial begin
        bts = new;
        bts.sys_iff = sys_iff;

        random = new;
        
        if (!randomInst.randomize()) begin
				$display("randomization failed");
				$finish();
			end
        
    end
endmodule