
.text
	li $v0, 5
	syscall 
	move $a0, $v0
	
	jal Fatorial
	
	move $a0, $v0
	li $v0, 1
	syscall
	
	j Exit
	
Fatorial:
	addi $sp, $sp -8
	sw $a0, 4($sp)
	sw $ra, 0($sp)
	
	beq $a0, $zero, EndIf
	
	li $v0, 1
	
    If:
    	addi $a0, $a0, -1
    	jal Fatorial
    	addi $a0, $a0, 1
    	mult $a0, $v0
    	mflo $v0
     	
    EndIf:
    
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	addi $sp, $sp, 8
	jr $ra
Exit:
