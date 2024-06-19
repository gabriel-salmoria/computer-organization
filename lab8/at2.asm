.data
        MAX: .word 3                                            # Define MAX (size of the matrices)
        block_size: .word 2                                     # Define block size
        A: .float 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0   # Initialize matrix A   
        B: .float 9.0, 8.0, 7.0, 6.0, 5.0, 4.0, 3.0, 2.0, 1.0   # Initialize matrix B
                         
.text
    main:
        # Load MAX and block_size into registers
        la   $t0, MAX
        lw   $t1, 0($t0)                        # t1 = MAX
        la   $t2, block_size
        lw   $t3, 0($t2)                        # t3 = block_size

        # Initialize outer loop variables
        li   $t4, 0                                 # i = 0

    outer_loop_i:
        bge  $t4, $t1, end_outer_i  # if (i >= MAX) exit outer loop
        li   $t5, 0                                 # j = 0

    outer_loop_j:
        bge  $t5, $t1, end_outer_j  # if (j >= MAX) exit outer loop

        # Initialize inner loop variables
        move $t6, $t4                           # ii = i

    inner_loop_ii:
        bge  $t6, $t1, end_inner_ii # if (ii >= i + block_size) exit inner loop
        move $t7, $t5                           # jj = j

     inner_loop_jj:
        bge  $t7, $t1, end_inner_jj # if (jj >= j + block_size) exit inner loop

        # Calculate index for A[ii][jj] and B[jj][ii]
        mul  $t8, $t6, $t1                  # t8 = ii * MAX
        add  $t8, $t8, $t7                  # t8 = ii * MAX + jj

        mul  $t9, $t7, $t1                  # t9 = jj * MAX
        add  $t9, $t9, $t6                  # t9 = jj * MAX + ii

        # Load A[ii][jj]
        la   $t10, A
        sll  $t11, $t8, 2                   # t11 = (ii * MAX + jj) * 4 (word offset)
        add  $t10, $t10, $t11
        lwc1 $f0, 0($t10)                   # f0 = A[ii][jj]

        # Load B[jj][ii]
        la   $t12, B
        sll  $t13, $t9, 2                   # t13 = (jj * MAX + ii) * 4 (word offset)
        add  $t12, $t12, $t13
        lwc1 $f1, 0($t12)                   # f1 = B[jj][ii]

        # Add A[ii][jj] and B[jj][ii]
        add.s $f2, $f0, $f1                 # f2 = A[ii][jj] + B[jj][ii]

        # Store result back in A[ii][jj]
        swc1 $f2, 0($t10)

        # Increment jj
        addi $t7, $t7, 1
        j        inner_loop_jj

    end_inner_jj:
        # Increment ii
        addi $t6, $t6, 1
        j        inner_loop_ii

    end_inner_ii:
        # Increment j
        addi $t5, $t5, $t3
        j        outer_loop_j

    end_outer_j:
        # Increment i
        addi $t4, $t4, $t3
        j        outer_loop_i

    end_outer_i:
        # End of program
        li   $v0, 10                        # syscall to exit
        syscall
