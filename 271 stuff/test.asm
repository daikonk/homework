.data
test1: .asciiz "\n This is equal"
test2: .asciiz "\n This is not equal"


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

.text
main:
	la $t0, frameBuffer	# load frame buffer addres
	li $t1, 0x20000		# save 512*256 pixels
	la $t3, grid
	li $t4, 8192
	
	addi $t0, $t0, -36		# frameBuffer -36 for some reason

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
	
	addi $t0, $t0, 48
	bnez $t4, loop2
	
