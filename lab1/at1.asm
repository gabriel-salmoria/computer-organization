# at1.asm
# Description: Calculates the mathematical expressions a = b + 35 and c = d – a + e.
#     Authors: Gustavo Nunes Viana(23100479) and Gabriel Salmoria(23100466).

.data
	A: .word 0
	B: .word 25
	C: .word 0
	D: .word 10
	E: .word 20

.text
# Register usage:
# $s0 - a
# $s1 - b
# $s1 -	c
# $s2 - d      	  
# $s3 - e	   

	# Loads the addresses of the global variables.
	la $t0, A
	la $t1, B
	la $t2, C
	la $t3, D
	la $t4, E
	
	# Loads the values of globals variables in registers.
	lw $s0, 0($t0)
	lw $s1, 0($t1)
	lw $s2, 0($t2)
	lw $s3, 0($t3)
	lw $s4, 0($t4)

	# Calculates a = b + 35; c = d – a + e;
	addi $s0, $s1, 35 # a = b + 35;
	sub $s2, $s3, $s0 # c = d - a;
	add $s2, $s2, $s4 # c = c + e;

	# Stores $s2 in the global c.
	sw $s2, 0($t2)
