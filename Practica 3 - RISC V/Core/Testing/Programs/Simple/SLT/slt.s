addi x1, x0, 1  # Move 1 to register x1

addi x0, x0, 1
addi x0, x0, 1
addi x0, x0, 1
addi x0, x0, 1
addi x0, x0, 1

addi x2, x0, 2  # Move 2 to register x2

addi x0, x0, 1
addi x0, x0, 1
addi x0, x0, 1
addi x0, x0, 1
addi x0, x0, 1

slt x3, x1, x2 # Compara el registro x1 y el x2 y si es menor x1 se almacena en x3 un 1 si no 0

addi x0, x0, 1
addi x0, x0, 1
addi x0, x0, 1
addi x0, x0, 1
addi x0, x0, 1

sw x3, 0(x0)  # Write x3 in memory pos 0

addi x0, x0, 1
addi x0, x0, 1
addi x0, x0, 1
addi x0, x0, 1
addi x0, x0, 1

addi x0, x0, 0
