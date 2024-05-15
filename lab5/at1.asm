.text

	li $v0, 5
	syscall 
  move $a0, $v0
	
  	move $s0, $v0
  	addi $t0, $s0, -1
  
  for:
    beq $t0, $zero, exit
    mult $s0, $t0
    mflo $s0
    addi $t0, $t0, -1
    
    j for

  exit:
  
  	move $a0, $s0
  	li $v0, 1
  	syscall
