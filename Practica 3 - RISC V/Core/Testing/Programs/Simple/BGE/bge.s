addi x1, x0, 2  # Move 2 to register x1

addi x0, x0, 1
addi x0, x0, 1
addi x0, x0, 1
addi x0, x0, 1
addi x0, x0, 1

addi x2, x0, 1  # Move 1 to register x2

addi x0, x0, 1
addi x0, x0, 1
addi x0, x0, 1
addi x0, x0, 1
addi x0, x0, 1

bge x1, x2, Done # BGE Compara si x1 es mayor o igual que x2 y si es así salta a Done

addi x0, x0, 1
addi x0, x0, 1
addi x0, x0, 1
addi x0, x0, 1
addi x0, x0, 1

Done:
addi x3, x0, 1

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
