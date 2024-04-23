.data
	f: .word 0
	g: .word 0
	h: .word 0
	i: .word 0
	j: .word 0

.text
Main:
	li $v0, 5
	syscall
	sw $v0, g
	
	li $v0, 5
	syscall
	sw $v0, h
	
	li $v0, 5
	syscall
	sw $v0, i
	
	li $v0, 5
	syscall
	sw $v0, j
	
	lw $a0, g
	lw $a1, h
	lw $a2, i
	lw $a3, j
	
	jal Calcula
	
	j MainExit
	
Calcula:
	add $t0, $a0, $a1
	add $t1, $a2, $a3
	sub $v0, $t0, $t1
	sw $v0, f
	jr $ra

MainExit:
	