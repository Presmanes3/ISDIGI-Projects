addi x1, x0, 1  # Move 1 to register x1

addi x0, x0, 1
addi x0, x0, 1
addi x0, x0, 1
addi x0, x0, 1
addi x0, x0, 1

jal x1, Done # JAL Asigna al registro x1 el valor de PC+4 y salta a la etiqueta DONE

addi x0, x0, 1
addi x0, x0, 1
addi x0, x0, 1
addi x0, x0, 1
addi x0, x0, 1

Done:

addi x0, x0, 1
addi x0, x0, 1
addi x0, x0, 1
addi x0, x0, 1
addi x0, x0, 1

sw x1, 0(x0)  # Write x1 in memory pos 0

addi x0, x0, 1
addi x0, x0, 1
addi x0, x0, 1
addi x0, x0, 1
addi x0, x0, 1

addi x0, x0, 0
