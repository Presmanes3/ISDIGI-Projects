`include "../Design/core.sv"

class core_test;

    // Cargo el modulo core con el tb de fibonnaci
    core #(.program_file("Core/Testing/Programs/Complex/Fibonnaci/fibo_20.mem")) core(
        .clk(testbench.sys_iff.ck),
        .reset(testbench.sys_iff.RESET_N)
    );


    task fibo_test();

    int control = 0;
    int Nmax_num = 20;
    int dir_ini_core = 5;
    int dir_ini_DUV = 5;

        fork
            begin
                @(core.instruction_memory_output_data != 32'h00000013)
                control++;
            end
            begin
                @(Intruccion en la que acabe el real)
                control++;
            end
        join

    @(control = 2)

    integer txt;
    txt = $open("fibbonaci.txt","w");
    int ideal_valor;
    int duv_valor;

    for (i = 0; i<Nmax_num-1; i++) begin
        ideal_valor = core.register_bank.reg_pool[dir_ini_core+i];
        real_valor = elemento.a.usar[dir_ini_DUV+i];

        $fwrite(txt,"%d, %d\n",ideal_valor, real_valor);
        
        assert (ideal_valor == real_valor) else $info("El elemento numero ",i," de fibonaci NO COINCIDE");
    end 

    $close(txt);

    endtask




endclass