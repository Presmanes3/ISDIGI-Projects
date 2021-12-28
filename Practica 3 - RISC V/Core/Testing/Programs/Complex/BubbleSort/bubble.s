# ===== GENERATE NUMBERS ===== #
addi x10, x0, 3		# Number 1
sw x10, 0(x0)
addi x10, x0, 8		# Number 2
sw x10, 4(x0)
addi x10, x0, 3		# Number 3
sw x10, 8(x0)
addi x10, x0, 6		# Number 4
sw x10, 12(x0)	
addi x10, x0, 5		# Number 5
sw x10, 16(x0)
addi x10, x0, 25	# Number 6
sw x10, 20(x0)
addi x10, x0, 7		# Number 7
sw x10, 24(x0)
addi x10, x0, 24	# Number 8
sw x10, 28(x0)
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
	lw x6, 0(x9)	# Move numbers[x] to x6
    lw x7, 4(x9)	# Move numbers[x + 1] to x7
    
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
	sw x7, 0(x9)	# Save value from register x7 to x5 memory + 160h
    sw x6, 4(x9)	# Save value from register x6 to x5 memory + 164h
    addi x8, x8, 1	# Add '1' to total times swaped per loop
    beq x0, x0, CONTINUE_SORT	 #Continue

FINISH:
    addi x0, x0, 0