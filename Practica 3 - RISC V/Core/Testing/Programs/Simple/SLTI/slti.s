addi x1, x0, 1  # Move 1 to register x1

addi x0, x0, 1
addi x0, x0, 1
addi x0, x0, 1
addi x0, x0, 1
addi x0, x0, 1

slti x3, x1, 2 # Compares x1 and 2 move to x3

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
