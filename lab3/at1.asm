.data
	a: .word 4
	b: .word 5

.text
	lw $a0, a
	lw $a1, b
	jal Multiplicacao
	j Exit
	
Multiplicacao:
	addi $sp, $sp -8
	sw $a1, 4($sp)
	sw $ra, 0($sp)
	
	bne $a1, $zero, If
	
	li $v0, 0
	j EndIf
    If:
    	addi $a1, $a1, -1
    	jal Multiplicacao
    	add $v0, $a0, $v0
     	
    EndIf:
	lw $ra, 0($sp)
	lw $a1, 4($sp)
	addi $sp, $sp, 8
	jr $ra
Exit:
