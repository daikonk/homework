.data
frameBuffer: 	.space 0x80000

grid:
	.ascii "# # # # # # # # # # # # # # # # # # # #\n"
	.ascii "# 0         x               #         #\n"
	.ascii "#   # # # # # # # # #   #   #   #     #\n"
	.ascii "#         #             #   # # #   # #\n"
	.ascii "# # # #   #   # # # # # #   #         #\n"
	.ascii "#         #   #   #         #   # #   #\n"
	.ascii "#   # #   #   #   #   # # # #   #     #\n"
	.ascii "#     #     y     #             #   # #\n"
	.ascii "# #   # # # # #   # # # #   # # #     #\n"
	.ascii "#     #       #   #         #   # # # #\n"
	.ascii "#   # #   #   #   # # # #   #   Y     #\n"
	.ascii "#         #   #   #         #   # #   #\n"
	.ascii "# # # # # #   #   #   # # # #   #     #\n"
	.ascii "#   #         #   #     # X     #   # #\n"
	.ascii "#       #   # #   # #   #   # # #     #\n"
	.ascii "#   # # #   #           #   #   # #   #\n"
	.ascii "#   #       # # # # # # #   #         #\n"
	.ascii "#   # # # # #   #       #   #   # # # #\n"
	.ascii "#                   #       #         #\n"
	.ascii "# # # # # # # # # # # # # # # # # # # #\n"


#test1:		.asciiz "LOOP2\n"
#test2:		.asciiz "LOOP1\n"

wasdToMove: 	.asciiz "\n\n\nINPUT WASD TO MOVE: "
userPos: 	.asciiz "\nPOS : "
keyInventory: 	.asciiz "\nKEYS IN INVENTORY : "
xTrue: 		.asciiz "X  "
yTrue: 		.asciiz "Y"
space: 		.asciiz " "
lineBreak:	.asciiz "\n"

pos: 		.word 1, 1
newPos:		.word 0, 0
keyVal: 	.word 0, 0
doMove:		.word 0

.text	
main:
	
	while:
		beq $s1, 'q', exit	# test if userInput ($s1) is 'q'
		beq $s2, 1, exit	# test if isWin ($s2) is true (1)
		
		jal printGrid		# will replace bottom block of code to translate ascii -> bitmap
		
		la $a0, grid		# prints grid
		li $v0, 4
		syscall
		move $s0, $a0		# moves grid ($a0) address to $s0
		
		la $a0, wasdToMove	# prompts for character that gets stored in $s1
		li $v0, 4
		syscall
		li $v0, 12		
		syscall
		move $s1, $v0
		
		jal Move
		
		la $a0, userPos		# Prints position
		li $v0, 4
		syscall

		la $t0, pos		# pos address set to $t0
		li $v0, 1		# prints pos[0] and pos[1]
		lw $a0, ($t0)		
		syscall
		la $a0, space
		li $v0, 4
		syscall
		li $v0, 1
		lw $a0, 4($t0)
		syscall
		
		la $a0, keyInventory 	# print keyVals menu
		li $v0, 4
		syscall
		
		la $t0, keyVal
		lw $t1, ($t0)
		lw $t2, 4($t0)
		
		blt $t1, 1, xSkip	# print X if keyVals[0] >= 1
		la $a0, xTrue
		li $v0, 4
		syscall
		xSkip:
		
		blt $t2, 1, ySkip	# print Y if keyVals[1] >= 1
		la $a0, yTrue
		syscall
		ySkip:
		
		la $a0, lineBreak
		li $v0, 4
		syscall
		li $v0, 4
		syscall
		
		la $t0, pos		# loads $t1 and $t2 with pos[0] and pos[1]
		lw $t1, ($t0)
		lw $t2, 4($t0)
		bne $t1, 18, noWin	# tests if pos[0] and pos [1] == 18
		bne $t2, 18, noWin
		addi $s2, $zero, 1
		noWin:
		
		j while
		
Move:
	la $t0, doMove			# sets doMove to 0 (false)
	sw $zero, ($t0)
	
	la $t0, newPos
	lw $t1, ($t0)
	lw $t2, 4($t0)
	la $t3, pos
	lw $t4, ($t3)
	lw $t5, 4($t3)
	
	bne $s1, 'w', wSkip		# switch statement for WASD inputs
	addi $t1, $t4, 0
	subi $t2, $t5, 1
	lw $t6, doMove
	addi $t6, $zero, 1
	sw $t6, doMove
	wSkip:
	
	bne $s1, 'a', aSkip
	subi $t1, $t4, 1
	addi $t2, $t5, 0
	lw $t6, doMove
	addi $t6, $zero, 1
	sw $t6, doMove
	aSkip:
	
	bne $s1, 's', sSkip
	addi $t1, $t4, 0
	addi $t2, $t5, 1
	lw $t6, doMove
	addi $t6, $zero, 1
	sw $t6, doMove
	sSkip:
	
	bne $s1, 'd', dSkip
	addi $t1, $t4, 1
	addi $t2, $t5, 0
	lw $t6, doMove
	addi $t6, $zero, 1
	sw $t6, doMove
	dSkip:
	
	addi $t6, $zero, 0
	move $s6, $t1
	move $s7, $t2
	
	sll $t1, $t1, 1			# gets char at newPos in grid and stores to $t6
	mul $t2, $t2, 40		# $t1 stores newPos in grid address
	add $t1, $t1, $t2
	add $t1, $t1, $s0
	lb $t6, ($t1)
	
	sll $t4, $t4, 1			# gets char at pos in grid and stores to $t7
	mul $t5, $t5, 40		# $t4 stores pos in grid address
	add $t4, $t4, $t5
	add $t4, $t4, $s0
	lb $t7, ($t4)
	
	li $t9, 1
	la $t8, keyVal
	lw $s3, ($t8)
	lw $s4, 4($t8)
	bne $t6, 'x', xxSkip		# play sound for collect if conditionals true
	sw $t9, ($t8)
	j moveOn
	xxSkip:
	bne $t6, 'X', XSkip		# play sound for unlock if conditionals true
	bne $s3, 1, XSkip
	sw $zero, ($t8)
	j moveOn
	XSkip:
	bne $t6, 'y', yySkip		# play sound for collect if conditionals true
	sw $t9, 4($t8)
	j moveOn
	yySkip:
	bne $t6, 'Y', YSkip		# play sound for unlock if conditionals true
	bne $s4, 1, YSkip
	sw $zero, 4($t8)
	j moveOn
	YSkip:
	bne $t6, ' ', switch2exit	# if char at newPos is ' ', set newPos to player and pos to ' '
	moveOn:
	li $t8, ' '
	sb $t8, ($t4)
	sb $t7, ($t1)
	la $t0, pos
	sw $s6, ($t0)
	sw $s7, 4($t0)
	switch2exit:
	
	
	addi $t0, $zero, 0
	addi $t1, $zero, 0
	addi $t2, $zero, 0
	addi $t3, $zero, 0
	addi $t4, $zero, 0
	addi $t5, $zero, 0
	addi $t6, $zero, 0
	addi $t7, $zero, 0
	addi $t8, $zero, 0
	addi $t9, $zero, 0
	addi $s3, $zero, 0
	addi $s4, $zero, 0
	addi $s6, $zero, 0
	addi $s7, $zero, 0
	
	jr $ra
	
printGrid:
	la $t0, frameBuffer		# load frame buffer address
	#li $t1, 0x20000			# save 512*256 pixels
	la $t3, grid
	li $t4, 8192
	
	#addi $t0, $t0, -700		# frameBuffer -36 for some reason

	loop2:
		li $t5, 20
		loop1:
			lb $a0, 0($t3)
			bne $a0, '#', notWall
			li $t2, 0x00d3d3d3
			sw $t2, 0($t0)
			notWall:
			bne $a0, '0', notPlayer
			li $t2, 0x00f44336
			sw $t2, 0($t0)
			notPlayer:
			bne $a0, 'x', notXKey
			li $t2, 0x0093c47d
			sw $t2, 0($t0)
			notXKey:
			bne $a0, 'y', notYKey
			li $t2, 0x008e7cc3
			sw $t2, 0($t0)
			notYKey:
			bne $a0, 'X', notXDoor
			li $t2, 0x0038761d
			sw $t2, 0($t0)
			notXDoor:
			bne $a0, 'Y', notYDoor
			li $t2, 0x00351c75
			sw $t2, 0($t0)
			notYDoor:
			addi $t3, $t3, 2
			addi $t0, $t0, 4
			addi $t4, $t4, -1
			addi $t5, $t5, -1
			bnez $t5,  loop1
			
			#la $t6, test1
			#li $v0, 4
			#syscall
			
			
	
	addi $t0, $t0, 48
	bnez $t4, loop2
	
	#la $t6, test2
	#li $v0, 4
	#syscall
	
	jr $ra

# generateMaze:

	# jr $ra

exit:
	
	li $v0, 10
	syscall

