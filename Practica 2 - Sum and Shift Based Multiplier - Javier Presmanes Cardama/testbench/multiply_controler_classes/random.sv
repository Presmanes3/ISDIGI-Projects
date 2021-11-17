<<<<<<< HEAD:Practica 2 - Sum and Shift Based Multiplier/testbench/multiply_controler_classes/random.sv
// RANDOM GENERATOR of A and B
`include "../interface.sv"

class RCSG #(int size);
	rand bit signed [size -1:0]  A_;
    rand bit signed [size -1:0]  B_;

    //Defino algunas constrains 
    
    constraint pos_pos {A_ > 0; B_ > 0;};
    constraint neg_neg {A_ < 0; B_ < 0;};
    constraint pos_neg {A_ > 0; B_ < 0;};
    constraint neg_pos {A_ < 0; B_ > 0;};
    
=======
// RANDOM GENERATOR of A and B
`include "../interface.sv"

class RCSG #(int size);
	rand bit signed [size -1:0]  A_;
    rand bit signed [size -1:0]  B_;

    //Defino algunas constrains 
    ///*
    constraint pos_pos {A_ > 0; B_ > 0;};
    constraint neg_neg {A_ < 0; B_ < 0;};
    constraint pos_neg {A_ > 0; B_ < 0;};
    constraint neg_pos {A_ < 0; B_ > 0;};
    //*/
>>>>>>> Tarea3:Practica 2 - Sum and Shift Based Multiplier - Javier Presmanes Cardama/testbench/multiply_controler_classes/random.sv
endclass