`include "multiply_controler_classes/random.sv"
`include "multiply_controler_classes/basic_task.sv"

module multipli_control ();

    //Inicializo asignador aleatorio
    RCSG random;

    basic_task bts;

    task get_random_values;

        if (!random.randomize()) begin
			$display("randomization failed");
			$finish();
		end

        sys_iff.A = random.A_;
        sys_iff.B = random.B_;

    endtask;


    initial begin
        bts = new;

        random = new;

        sys_iff.A = random.A_;
        sys_iff.A = random.B_;

    end
endmodule