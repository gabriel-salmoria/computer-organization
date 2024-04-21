.data
    	v: .word 11 2 3 14 15  # Array de números
    	n: .word 5             # Tamanho do array

.text
    	lw $a0, n             # Carrega o tamanho do array em $a0
    	jal Soma              # Chama a função Soma
    	j Exit                # Salta para o ponto de saída do programa

    Soma:
    	addi $sp, $sp, -8     # Aloca espaço na pilha para salvar $a0 e $ra
    	sw $a0, 4($sp)        # Salva o valor de $a0 na pilha
    	sw $ra, 0($sp)        # Salva o endereço de retorno na pilha

    	li $t0, 1             # Carrega o valor 1 em $t0
    	bne $a0, $t0, If      # Se $a0 não for igual a 1, salta para If

    	lw $v0, v($zero)      # Se $a0 for 1, carrega o primeiro elemento do array em $v0
    	j EndIf               # Salta para o final da função

    If:
    	addi $a0, $a0, -1     # Decrementa $a0
    	jal Soma              # Chama recursivamente a função Soma
    	sll $a0, $a0, 2       # Multiplica $a0 por 4 para calcular o deslocamento no array de palavras
    	lw $t0, v($a0)        # Carrega o elemento do array usando o deslocamento calculado
    	add $v0, $t0, $v0     # Soma o elemento atual do array com o resultado da chamada recursiva

    EndIf:
    	lw $ra, 0($sp)        # Restaura o endereço de retorno
    	lw $a0, 4($sp)        # Restaura o valor de $a0
    	addi $sp, $sp, 8      # Desaloca o espaço da pilha
    	jr $ra                # Retorna para o endereço de retorno

    Exit:
