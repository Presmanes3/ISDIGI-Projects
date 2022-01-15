class fibonnaci_golden;

    int current_number;
    int prev_number;

    task init;
        this.prev_number = 0;
        this.current_number = 1;
    endtask

    task compute_new_number;
        int temporal = this.current_number;
        this.current_number = this.prev_number + this.current_number;
        this.prev_number = temporal;
    endtask
endclass
