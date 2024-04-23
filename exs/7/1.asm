.data
	A: .word 10
	B: .word 15
	C: .word 20
	D: .word 25
	E: .word 30
	F: .word 35
	G: .word 0 0 0 0
	H: .word 0 0 0 0
.text
	lw $s0, A
	lw $s1, B
	lw $s2, C
	lw $s3, D
	lw $s4, E
	lw $s5, F
	
	# G[0] = (A – (B + C) + F);
	add $t0, $s1, $s2
	sub $t0, $s0, $t0
	add $t0, $t0, $s5
	sw $t0, G($t1)
	
	# G[1] = E – (A – B) * (B – C);
	sub $t0, $s0, $s1
	sub $t1, $s1, $s2
	mult $t0, $t1
	mflo $t1
	sub $t0, $s4, $t1
	li $t1, 4
	sw $t0, G($t1)
	
	# G[2] = G[1] – C;
	sub $t0, $t0, $s2
	sll $t1, $t1, 1
	sw $t0, G($t1)
	
	# G[3] = G[2] + G[0];
	li $t3, 8
	lw $t0, G($t3)
	lw $t1, G($t4)
	add $t0, $t0, $t1
	li $t1, 12
	sw $t0, G($t1)
	
	# H[0] = B – C;
	sub $t0, $s1, $s2
	sw $t0, H($zero)
	
	# H[1] = A + C;
	add $t0, $s0, $s2
	li $t1, 4
	sw $t0, H($t1)
	
	# H[2] = B – C + G[3];
	sub $t0, $s1, $s2
	li $t2, 12
	lw $t1, G($t2)
	add $t0, $t0, $t1
	li $t1, 8
	sw $t0, H($t1)
	
	# H[3] = B – G[0] + D;
	sw $t0, G($zero)
	sub $t0, $s1, $t0
	add $t0, $t0, $s3
	li $t1, 12
	sw $t0, H($t1)	
	
	