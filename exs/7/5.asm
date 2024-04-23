.data
	a: .word 0
	b: .word 2
	c: .word 5
.text
	#li $v0, 5
	#syscall
	#sw $v0, a
	
	#li $v0, 5
	#syscall
	#sw $v0, b
	
	lw $s0, a
	lw $s1, b
	lw $s2, c
	
	# if (a > b) a = a + 1;
	#sle $t0, $s0, $s1
	#bne $t0, $zero, endif
	#addi $s0, $s0, 1
	#sw $s0, a
	#endif: 
	
	
	# if (a ≥ b) b = b + 1;
	#slt $t0, $s0, $s1 
	#bne $t0, $zero, endif
	#addi $s1, $s1, 1
	#sw $s1, b
	#endif:
	
	
	# if (a ≤ b) a = a + 1;
	#sgt $t0, $s0, $s1
	#bne $t0, $zero, endif
	#addi $s0, $s0, 1
	#sw $s0, a
	#endif:
	
	
	# if (a == b) b = a;
	#bne $s0, $s1, endif
	#sw $s0, b
	#endif:
	
	
	# if (a < b) a = a + 1;
	# else b = b + 1;
	#slt $t0, $s0, $s1
	#beq $t0, $zero, else
	#addi $s0, $s0, 1
	#sw $s0, a
	#j endif
	#else:
	#addi $s1, $s1, 1
	#sw $s1, b
	#endif:
	
	
	# a = 0; b = 0; c = 5;
	# while (a < c){ a = a+ 1; b = b + 2;}
	#while:
	#slt $t0, $s0, $s2
	#beq $t0, $zero, endwhile
	#addi $s0, $s0, 1
	#sw $s0, a
	#addi $s1, $s1, 2
	#sw $s1, b
	#j while
	#endwhile:
	
	
	# a = 1; b = 2;
	# for (i = 0; i < 5; i ++){a = b + 1;b = b + 3;}	
	#for:
	#slti $t0, $t1, 5
	#beq $t0, $zero, outfor
	
	#addi $s0, $s1, 1
	#sw $s0, a
	#addi $s1, $s1, 3
	#sw $s1, b
	
	#addi $t1, $t1, 1
	#j for
	#outfor:
	
	
	# switch(a){case 1:b = c + 1;break; case 2:b = c + 2;break; default:b = c; break;}
	beq $s0, 1, c1
	beq $s0, 2, c2
	
	# passar o conteduo de c para b
	move $s1, $s2
	j break
	c1:
	addi $s1, $s2, 1
	j break
	c2:
	addi $s1, $s2, 2
	j break	
	break:
	sw $s1, b 
	
	
	
	
	
	
