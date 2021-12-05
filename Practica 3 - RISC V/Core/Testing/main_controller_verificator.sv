class main_controller_verificator;

    string name;
    logic branch;
    logic memory_read;
    logic memory_to_register;
    logic memory_write;
    logic alu_source;
    logic register_write;
    logic [1:0] AuipcLui;
    
    
    function configure(
        string name,
        logic branch,
        logic memory_read,
        logic memory_to_register,
        logic memory_write,
        logic alu_source,
        logic register_write,
        logic [1:0] AuipcLui
    );
        this.name               = name;
        this.branch             = branch;
        this.memory_read        = memory_read;
        this.memory_to_register = memory_to_register;
        this.memory_write       = memory_write;
        this.alu_source         = alu_source;    
        this.register_write     = register_write;    
        this.AuipcLui           = AuipcLui;

        $display("===== CONFIGURATION FOR %s =====  
[BRANCH] [MEMORY_READ] [MEMORY_TO_REGISTER] [MEMORY_WRITE] [ALU_SOURCE] [REGISTER_WRITE] [AUIPCLUI]
[  %d  ] [    %d     ] [         %d       ] [     %d     ] [    %d    ] [      %d      ] [   %d   ]",
this.name, 
this.branch, 
this.memory_read, 
this.memory_to_register,
this.memory_write,
this.alu_source,
this.register_write,
this.AuipcLui
        );
    endfunction

    task check;

        assert (phase_2_testbench.core.main_controller_branch == this.branch)
        else $info("ERROR [BRANCH] BIT VALUE");

        assert (phase_2_testbench.core.main_controller_memory_read == this.memory_read)
        else $info("ERROR [MEMORY_READ] BIT VALUE");

        assert (phase_2_testbench.core.main_controller_memory_to_register == this.memory_to_register)
        else $info("ERROR [MEMORY_TO_REGISTER] BIT VALUE");

        assert (phase_2_testbench.core.main_controller_memory_write == this.memory_write)
        else $info("ERROR [MEMORY_WRITE] BIT VALUE");

        assert (phase_2_testbench.core.main_controller_alu_source == this.alu_source)
        else $info("ERROR [ALU_SOURCE] BIT VALUE");

        assert (phase_2_testbench.core.main_controller_register_write == this.register_write)
        else $info("ERROR [REGISTER_WRITE] BIT VALUE");

        assert (phase_2_testbench.core.main_controller_AuipcLui == this.AuipcLui)
        else $info("ERROR [AUIPCLUI] BIT VALUE");
        
    endtask 
endclass 