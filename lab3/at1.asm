.data
    	a: .word 4   	    # Define uma variável a com o valor 4
    	b: .word 5          # Define uma variável b com o valor 5

.text
    	lw $a0, a           # Carrega o valor de a em $a0
    	lw $a1, b           # Carrega o valor de b em $a1
    	jal Multiplicacao   # Chama a função Multiplicacao
    	j Exit       	    # Salta para o ponto de saída do programa

    Multiplicacao:
    	addi $sp, $sp, -8   # Aloca espaço na pilha para salvar $a1 e $ra
    	sw $a1, 4($sp)      # Salva o valor de $a1 na pilha
    	sw $ra, 0($sp)      # Salva o endereço de retorno na pilha
    
    	bne $a1, $zero, If  # Se $a1 não for zero, salta para If
    
    	li $v0, 0           # Se $a1 for zero, define $v0 como 0 (caso base)
   	j EndIf             # Salta para o final da função
    If:	
   	addi $a1, $a1, -1   # Decrementa $a1
  	jal Multiplicacao   # Chama recursivamente a função Multiplicacao
  	add $v0, $a0, $v0   # Soma $a0 com o resultado da chamada recursiva
    
    EndIf:
    	lw $ra, 0($sp)      # Restaura o endereço de retorno
    	lw $a1, 4($sp)      # Restaura o valor de $a1
    	addi $sp, $sp, 8    # Desaloca o espaço da pilha
    	jr $ra              # Retorna para o endereço de retorno
    Exit:
