# Register x5 will be used for 
# Register x12 will be used for memory offset
# Register x13 will be used for loop variable
# Register x14 will be used for total numbers to be computed

addi x14, x0, 10
addi x12, x0, 0

addi x5, x0, 1
addi x4, x0, 0

addi x13, x0, 0

sw x4, 100(x12)

addi x12, x12, 4 #incrementa contador posicion direccion
addi x13, x13, 1 #incrementa contador cadena

Loop:
sw  x5, 100(x12) # Save register x5 with current value into memory

addi x12, x12, 4 # Increment memory offset
addi x13, x13, 1 # Increment for loop variable

addi x7, x5, 0   # Temporally save x5 to x7
add x5, x5, x6   # Compute new value by adding x5 and x6
addi x6, x7, 0   # Move x7 to x6

beq x13, x14, Done # If Loop is finished, end the program
bne x13, x14, Loop # Otherwise compute a new number

Done:

addi x0, x0, 0