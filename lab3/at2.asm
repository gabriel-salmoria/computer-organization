.data
	v: .word 11 2 3 14 15
	n: .word 5

.text
	lw $a0, n
	jal Soma
	j Exit
Soma:
	addi $sp, $sp -8
	sw $a0, 4($sp)
	sw $ra, 0($sp)
	
	li $t0, 1
	bne $a0, $t0, If
	
	lw $v0, v($zero)
	j EndIf
    If:
    	addi $a0, $a0, -1
    	jal Soma
    	sll $a0, $a0, 2
    	lw $t0, v($a0)
    	add $v0, $t0, $v0
     	
    EndIf:
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	addi $sp, $sp, 8
	jr $ra
Exit:
