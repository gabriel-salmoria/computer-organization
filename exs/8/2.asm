.data
	a: .word 4
	b: .word 10
	area: .word 0
	val: .word 0
.text
	jal Main
	j Exit
Main:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	lw $s0, a
	lw $s1, b
	move $a0, $s0
	move $a1, $s1
	jal Calculadora
	sw $v0, val
	
	lw $ra, 0($sp)
	addi $sp, $sp, +4
	jr $ra
	
Calculadora:
	mult $a0, $a1
	mflo $s3
	sw $s3, area 
	move $v0, $s3
	jr $ra
Exit:
	
	
