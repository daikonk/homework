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
	li $t2, 0x00d3d3d3		# load light gray color
	la $t3, grid
	li $t4, 8192
	
	addi $t0, $t0, -36		# frameBuffer -36 for some reason

			
	loop:
		lb $a0, 0($t3)
		bne $a0, '#', end
		sw $t2, 0($t0)
		
		end:
		addi $t3, $t3, 2
		addi $t0, $t0, 4
		addi $t4, $t4, 1
		bnez $t4,  loop