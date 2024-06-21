.data
    MAX: .word 16
    
    A: .space 1024
    B: .space 1024

.text
				# Preencher a matriz A
    		la $a0, A     # Passa o endereço base da matriz A no registrador $a0
    		lw $a1, MAX
    		jal preencher     # Chama a função para preencher a matriz

		    # Preencher a matriz B
  		  la $a0, B     # Passa o endereço base da matriz B no registrador $a0
  		  lw $a1, MAX
	  	  jal preencher     # Chama a função para preencher a matriz

				j main

		preencher:
    		move $t1, $a0       # Move o endereço base da matriz para $t1
    		move $s0, $a1
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
		    bne $t3, $s0, preencher_linhas  	# Se não percorreu todas as linhas, continue

    		addi $t2, $t2, 1						    # Incrementa o índice da coluna
    		bne $t2, $s0, preencher_colunas  # Se não percorreu todas as colunas, continue

    		jr $ra              # Retorna para a chamada anterior



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
