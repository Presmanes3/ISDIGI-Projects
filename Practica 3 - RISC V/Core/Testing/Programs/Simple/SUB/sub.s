addi x1, x0, 1  # Move 1 to register x1

addi x0, x0, 1
addi x0, x0, 1
addi x0, x0, 1
addi x0, x0, 1
addi x0, x0, 1

addi x2, x0, 2  # Move 1 to register x2

addi x0, x0, 1
addi x0, x0, 1
addi x0, x0, 1
addi x0, x0, 1
addi x0, x0, 1

sub x3, x2, x1 # subb x1 to x2 move to x3

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