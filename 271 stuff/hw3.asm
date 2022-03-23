# Author:	Your name
# Date:		July 11, 2021
# Description:	Homework #3: Find 2D array content by row/col

.data
askrow:	.asciiz	"Enter row in the range [0..2]: "
askcol:	.asciiz	"Enter column in the range [0..4]: "
print:	.asciiz	"array[row][col] = "

# array initialization
array:
	.word	  1, 2, 3, 4, 5
	.word	  6, 7, 8, 9,10
	.word	  11,12,13,14,15

.text
# a0 array, a1 col index, a2 row index, a3 col size
	main:
		
		# get row
		li $v0, 4
		la $a0, askrow
		syscall
		
		li $v0, 5
		syscall
		
		move $a1, $v0
		
		# get col
		li $v0, 4
		la $a0, askcol
		syscall
		
		li $v0, 5
		syscall
		
		move $a2, $v0
		
		# load base address and ncol
		la $a0, array
		jal arrAddress
		move $a0, $v0
		li $v0, 1
		syscall
		
		# End of program
		li $v0, 10
		syscall
	
	arrAddress:
		li $v0, 0
		mul $t1, $a2, 5
		add $t1, $t1, $a1
		sll $t1, $t1, 2
		add $t1, $t1, $a0
		move $v0, $t1
	jr $ra