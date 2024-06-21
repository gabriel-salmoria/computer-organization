.data
    MAX: .word 3
    block_size: .word 2
    A: .space 1024
    B: .space 1024

.text
				# Preencher a matriz A
    		la $a0, A     # Passa o endereço base da matriz A no registrador $a0
    		jal preencher     # Chama a função para preencher a matriz

		    # Preencher a matriz B
  		  la $a0, B     # Passa o endereço base da matriz B no registrador $a0
	  	  jal preencher     # Chama a função para preencher a matriz

				j main

		preencher:
    		move $t1, $a0       # Move o endereço base da matriz para $t1
    		li $t0, 0           # Inicializa o contador de elementos em 0
    		li $t2, 0           # Inicializa o índice da coluna em 0

		preencher_colunas:
    		li $t3, 0           # Inicializa o índice da linha em 0

		preencher_linhas:
  		  mtc1 $t0, $f0							      # Move o valor do contador para o registrador de ponto flutuante $f0
		    cvt.s.w $f0, $f0 							  # Converte o inteiro em ponto flutuante

		    mul $t4, $t3, 16 							  # Calcula o deslocamento da linha (linha * 16)
		    add $t4, $t4, $t2							  # Adiciona o deslocamento da coluna (linha * 16 + coluna)
		    sll $t4, $t4, 2							    # Multiplica o deslocamento por 4 (cada float tem 4 bytes)
		    add $t5, $t1, $t4							  # Calcula o endereço do elemento na matriz

		    swc1 $f0, 0($t5)						    # Armazena o valor do ponto flutuante no endereço calculado

    		addi $t0, $t0, 1  						  # Incrementa o contador
	   		addi $t3, $t3, 1	    					# Incrementa o índice da linha
		    bne $t3, 16, preencher_linhas  	# Se não percorreu todas as linhas, continue

    		addi $t2, $t2, 1						    # Incrementa o índice da coluna
    		bne $t2, 16, preencher_colunas  # Se não percorreu todas as colunas, continue

    		jr $ra              # Retorna para a chamada anterior


    main:
        # Inicializa MAX e block_size
        la   $t0, MAX
        lw   $s0, 0($t0)                 # s0 = MAX
        la   $t1, block_size
        lw   $s1, 0($t1)                 # s1 = block_size

        # Inicializa as variáveis
        li   $t0, 0                      # t0 = i
        li   $t1, 0                      # t1 = j
        li   $t2, 0                      # t2 = ii
        li   $t3, 0                      # t3 = jj
        
        j loop_jj

    add_i:
        # Incrementa i
        add $t0, $t0, $s1

    loop_i:
        bge  $t0, $s0, end               # if (i >= MAX)
        li   $t1, 0                      # j = 0
        
        j loop_j

    add_j:
        # Incrementa j
        add $t1, $t1, $s1

    loop_j:
        bge  $t1, $s0, add_i             # if (j >= MAX)
        move $t2, $t0                    # ii = i
        
        j loop_ii

    add_ii:
        # Incrementa ii
        addi $t2, $t2, 1

    loop_ii:
        # Comparar ii < i + block_size
        add $t4, $t0, $s1                # t4 = i + block_size
        bge  $t2, $t4, add_j             # if (ii >= i + block_size)
        move $t3, $t1                    # jj = j
        
        j loop_jj

    add_jj:
        # Incrementa jj
        addi $t3, $t3, 1

    loop_jj:
        # Comparar jj < j + block_size
        add $t5, $t1, $s1                # t5 = j + block_size
        bge  $t3, $t5, add_ii            # if (jj >= j + block_size)

        # Calcula index de A[ii][jj]
        mul  $t6, $t2, $s0               # t6 = ii * MAX
        add  $t6, $t6, $t3               # t6 = ii * MAX + jj

        # Calcula index de B[jj][ii]
        mul  $t7, $t3, $s0               # t7 = jj * MAX
        add  $t7, $t7, $t2               # t7 = jj * MAX + ii

        # Carrega A[ii][jj]
        la   $s2, A
        sll  $t6, $t6, 2                 # t6 = (ii * MAX + jj) * 4 (offset)
        add  $s2, $s2, $t6
        lwc1 $f0, 0($s2)                 # f0 = A[ii][jj]

        # Carrega B[jj][ii]
        la   $s3, B
        sll  $t7, $t7, 2                 # t7 = (jj * MAX + ii) * 4 (offset)
        add  $s3, $s3, $t7
        lwc1 $f1, 0($s3)                 # f1 = B[jj][ii]

        # f2 = A[ii][jj] + B[jj][ii]
        add.s $f2, $f0, $f1

        # Salva f2 em A[ii][jj]
        swc1 $f2, 0($s2)

        j add_jj

    end:
