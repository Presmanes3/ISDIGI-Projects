`include "interface.sv"
`include "multiply_controler_classes/random.sv"

module multipli_control (system_iff sys_iff);

    //Inicializo asignador aleatorio
    RCSG random;

    initial begin

        random = new;
        
        if (!randomInst.randomize()) begin
				$display("randomization failed");
				$finish();
			end

        random.sys_iff = sys_iff;
    end
endmodule