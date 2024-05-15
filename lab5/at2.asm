.text
    	li $v0, 5         	# Carrega imediato: $v0 = 5 (syscall para ler um inteiro)
    	syscall           	# Executa a syscall 
    	move $a0, $v0     	# Move $v0 (valor de entrada) para $a0 (registrador de argumento)

    	jal Fatorial      	# Chama a função Fatorial

    	move $a0, $v0     	# Move $v0 (resultado do fatorial) para $a0 (registrador de argumento)
    	li $v0, 1         	# Carrega imediato: $v0 = 1 (syscall para imprimir um inteiro)
    	syscall           	# Executa a syscall

    	j Exit            	# Salta para o rótulo Exit

    Fatorial:
    	addi $sp, $sp, -8  	# Aloca espaço na pilha para armazenar $a0 e $ra
    	sw $a0, 4($sp)     	# Salva $a0 na pilha
    	sw $ra, 0($sp)     	# Salva $ra na pilha

    	beq $a0, $zero, EndIf  	# Se $a0 for zero, vai para EndIf

    	li $v0, 1              	# Carrega imediato: $v0 = 1 (para uso na multiplicação)
    
    If:
        addi $a0, $a0, -1  	# Decrementa $a0
        jal Fatorial        	# Chama a função Fatorial recursivamente
        addi $a0, $a0, 1   	# Restaura $a0
        mult $a0, $v0      	# Multiplica $a0 pelo resultado do fatorial recursivo
        mflo $v0           	# Move o resultado da multiplicação para $v0
        j EndIf            	# Salta para EndIf

    EndIf:
    	lw $ra, 0($sp)    	# Carrega $ra da pilha
    	lw $a0, 4($sp)    	# Carrega $a0 da pilha
    	addi $sp, $sp, 8  	# Desaloca espaço na pilha
    	jr $ra            	# Retorna para a chamada anterior (retorna de função)

    Exit:
