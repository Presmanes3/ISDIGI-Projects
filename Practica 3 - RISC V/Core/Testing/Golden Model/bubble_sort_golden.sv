class bubble_golden;

    int current_number;
    int prev_number;

    logic [7:0][7:0] numeros;
    int N = 7;
    int i=0;
    int j=1;


    // numeros en orden: 3 8 3 6 5 25 7 24
    // numero de numeros (N-1) = 7

    task init;
        numeros[0] = 3;
        numeros[1] = 8;
        numeros[2] = 3;
        numeros[3] = 6;
        numeros[4] = 5;
        numeros[5] = 25;
        numeros[6] = 7;
        numeros[7] = 24;
    endtask

    task compute_new_number;
        if(i<8) //Se llega al resultado como mucho en N-1 ciclos
            begin  
                for (j = 1; j < 8; j = j+1) begin 
                    current_number = numeros[j];
                    prev_number = numeros[j-1];

                    if(current_number < prev_number) begin
                        numeros[j-1] = current_number;
                        numeros[j] = prev_number;
                    end
                end
                i = i+1;
            end
    endtask 

endclass