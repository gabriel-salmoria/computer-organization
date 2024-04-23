.data
	base: .word 2
	expoente: .word 5
.text
	lw $a0, base
	lw $a1, expoente
	jal Pow
	j Exit	
Pow:
	addi $sp, $sp, -4
	sw $s0, 0($sp)
	li $s0, 1
		
    Loop:
    	slt $t2, $t0, $a1
	beq $t2, $zero, OutLoop
	mult $s0, $a0
	mflo $s0
	addi $t0, $t0, 1
	j Loop
	
    OutLoop:
	move $v0, $s0 
	jr $ra
	
Exit: