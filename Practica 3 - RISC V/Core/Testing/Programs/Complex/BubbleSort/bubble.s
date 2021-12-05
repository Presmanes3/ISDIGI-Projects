# ===== GENERATE NUMBERS ===== #
addi x10, x0, 3		# Number 1
sw x10, 160(x0)
addi x10, x0, 8		# Number 2
sw x10, 164(x0)
addi x10, x0, 3		# Number 3
sw x10, 168(x0)
addi x10, x0, 6		# Number 4
sw x10, 172(x0)	
addi x10, x0, 5		# Number 5
sw x10, 176(x0)
addi x10, x0, 25	# Number 6
sw x10, 180(x0)
addi x10, x0, 7		# Number 7
sw x10, 184(x0)
addi x10, x0, 24	# Number 8
sw x10, 188(x0)
# ==================== #

# x4 will contain the total amount of numbers
# x5 will contain the current loop value
# x6, x7 will be used as temporal registers for comparison
# x8 will contain the number of swaps per loop
# x9  will contain the memory offsset

addi x4, x0, 7	# Tell the program that there are 8 numbers to be ordered
addi x5, x0, 0	# Initialize register 5 to 0
addi x6, x0, 0	# Initialize register 6 to 0
addi x7, x0, 0 	# Initialize register 7 to 0
addi x8, x0, 0 	# Initialize register 8 to 0
addi x9, x0, 0 	# Initialize register 8 to 0



MAIN_LOOP:
	beq x4, x5, CHECK_ALL_SORTED	# If loop has finished move to "check all sorted"
SORT:
	lw x6, 160(x9)	# Move numbers[x] to x6
    lw x7, 164(x9)	# Move numbers[x + 1] to x7
    
    blt x7, x6, SWAP	# If x7 < x6 then SWAP
CONTINUE_SORT:
	addi x5, x5, 1	# Add an iteration
    addi x9, x9, 4	# Add 4 to offset
    beq x0, x0, MAIN_LOOP

CHECK_ALL_SORTED:
	bne x8, x0, FINISH	# If no swaps have been done, program is finished
    addi x5, x0, 0		# Else reset x4 and sort again
    addi x9, x0, 0		# Reset memory offset
    addi x8, x0, 0 		# Reset times swapt
	beq x0, x0, SORT
    
SWAP:
	sw x7, 160(x9)	# Save value from register x7 to x5 memory + 160h
    sw x6, 164(x9)	# Save value from register x6 to x5 memory + 164h
    addi x8, x8, 1	# Add '1' to total times swaped per loop
    beq x0, x0, CONTINUE_SORT	 #Continue

FINISH:



#addi x10, x0, 0
#addi x12, x13, 1
#addi x10, x10, 1 # i=1


#Loop1: #for1
#beq x10, x12, F1 #compara i con N
#addi x10, x10, 1 #incrementa i
#addi x11, x0, 0 # j = 0
#addi x15, x0, 0 
#addi x16, x0, 0

#Loop2: #for2
#beq x11, x13, Loop1 #compara j con N-1
#addi x11, x11, 1 #incrementa j

#addi x14, x11, 1 #j+1

#addi x15, x15, 4
#addi x16, x15, 4

#lw x5, 156(x15) # obtener N
#lw x6, 156(x16) # obtener N+1

#bge x5, x6, IF  #j>j+1
#j Loop2 #j<j+1
#IF: 
#beq x5, x6, Loop2 #j = j+1

#addi x7, x5, 0 #temp=lista[j]
#addi x5, x6, 0 #lista[j]=lista[j+1]
#addi x6, x7, 0 #lista[j+1]=temp

#sw x5, 156(x15) #almacenar N
#sw x6, 156(x16) #almacenar N+1

#j Loop2 #continua 2for


#F1: #fin