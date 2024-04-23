.data
	v: .space 24
.text
	li $s0, 1
	
	# 2
	if:
	beq $s0, 5, outif
	addi $s0, $s0, 1
	j if
	outif:
	li $s0, 0
	
	# 3
	li $t0, 1
	sw $t0, v($t1)
	addi $t1, $t1, 4
	
	li $t0, 3
	sw $t0, v($t1)
	addi $t1, $t1, 4
	
	li $t0, 2
	sw $t0, v($t1)
	addi $t1, $t1, 4
	
	li $t0, 1
	sw $t0, v($t1)
	addi $t1, $t1, 4
	
	li $t0, 4
	sw $t0, v($t1)
	addi $t1, $t1, 4
	
	li $t0, 5
	sw $t0, v($t1)
	addi $t1, $t1, 4
	
	# 4
	