.data
    MAX: .word 3
    
    A: .float 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0     
    B: .float 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0

.text
    main:
        # Inicializa MAX
        la   $t0, MAX
        lw   $s0, 0($t0)
        
        # Inicializa as Matrizes
        la   $s1, A
        la   $s2, B

        # Inicializa i,j
        li   $t0, 0  # i = 0
        li   $t1, 0  # j = 0
        
        j loop_j

    loop_i:
        addi $t0, $t0, 1
        bge  $t0, $s0, end   # if (i >= MAX)
        li   $t1, 0          # j = 0
        j loop_j

    loop_j:
        bge  $t1, $s0, loop_i  # if (j >= MAX)

        # Calcular índice para A[i][j]
        mul  $t4, $t0, $s0     # t4 = i * MAX
        add  $t4, $t4, $t1     # t4 = i * MAX + j
        sll  $t4, $t4, 2       # t4 = (i * MAX + j) * 4
        add  $t4, $t4, $s1     # t4 = A + (i * MAX + j) * 4
        lwc1 $f0, 0($t4)       # f0 = A[i][j]
        
        # Calcular índice para B[j][i]
        mul   $t5, $t1, $s0     # t5 = j * MAX
        
        add  $t5, $t5, $t0     # t5 = j * MAX + i
        sll  $t5, $t5, 2       # t5 = (j * MAX + i) * 4
        add  $t5, $t5, $s2     # t5 = B + (j * MAX + i) * 4
        lwc1 $f1, 0($t5)       # f1 = B[j][i]
        
        # Calcula A[i][j] + B[j][i]
        add.s $f2, $f0, $f1
        
        # Guarda o resultado em A[i][j]
        swc1 $f2, 0($t4)
        
        addi $t1, $t1, 1
        j loop_j

    end:
