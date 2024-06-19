.data
    	MAX: .word 3                  # Define MAX (size of the matrices)
    	A: .float 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0    # Initialize matrix A     
    	B: .float 9.0, 8.0, 7.0, 6.0, 5.0, 4.0, 3.0, 2.0, 1.0   # Initialize matrix B
             
.text
    main:
    	# Load MAX into register
    	la   $t0, MAX
    	lw   $t1, 0($t0)           # t1 = MAX

    	# Initialize loop variables
    	li   $t2, 0                # i = 0

    outer_loop:
    	bge  $t2, $t1, end_outer   # if (i >= MAX) exit outer loop
    	li   $t3, 0                # j = 0

    inner_loop:
    	bge  $t3, $t1, end_inner   # if (j >= MAX) exit inner loop

    	# Calculate index for A[i][j] and B[j][i]
    	mul  $t4, $t2, $t1         # t4 = i * MAX
    	add  $t4, $t4, $t3         # t4 = i * MAX + j

   	 mul  $t5, $t3, $t1         # t5 = j * MAX
    	add  $t5, $t5, $t2         # t5 = j * MAX + i

    	# Load A[i][j]
    	la   $t6, A
    	sll  $t7, $t4, 2           # t7 = (i * MAX + j) * 4 (word offset)
    	add  $t6, $t6, $t7
    	lwc1 $f0, 0($t6)           # f0 = A[i][j]

    	# Load B[j][i]
    	la   $t8, B
    	sll  $t9, $t5, 2           # t9 = (j * MAX + i) * 4 (word offset)
    	add  $t8, $t8, $t9
	    lwc1 $f1, 0($t8)           # f1 = B[j][i]

    	# Add A[i][j] and B[j][i]
   	add.s $f2, $f0, $f1        # f2 = A[i][j] + B[j][i]

    	# Store result back in A[i][j]
    	swc1 $f2, 0($t6)

    	# Increment j
    	addi $t3, $t3, 1
    	j    inner_loop

    end_inner:
    	# Increment i
    	addi $t2, $t2, 1
    	j    outer_loop

    end_outer:
    	# End of program
    	li   $v0, 10               # syscall to exit
    	syscall
