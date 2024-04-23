.data
	input1: .asciiz "Primeiro:"
	n1: .word 0
	input2: .asciiz "Segundo:"
	n2: .word 0
.text
	jal Main
	j Exit

Main:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	jal Soma
	
	move $a0, $v0
	li $v0, 1
	syscall
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
Leitura:
	addi $sp, $sp, -4
	sw $a0, 0($sp)
	
	li $v0, 4
	la $a0, input1
	syscall
	li $v0, 5
	syscall 
	sw $v0, n1
	li $v0, 4 
	la $a0, input2
	syscall
	li $v0, 5
	syscall 
	sw $v0, n2
	
	lw $a0, 0($sp)
	addi $sp, $sp, 4
	jr $ra

Soma:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	jal Leitura
	lw $t0, n1
	lw $t1, n2
	add $v0, $t0, $t1
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
Exit:
	
	
	
	