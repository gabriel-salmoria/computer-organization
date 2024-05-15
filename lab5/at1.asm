.text
    	li $v0, 5         	# Carrega imediato: $v0 = 5 (syscall para ler um inteiro)
    	syscall           	# Executa a syscall

    	move $a0, $v0    	# Move $v0 (valor de entrada) para $a0 (registrador de argumento)

    	move $s0, $v0    	# Move $v0 (valor de entrada) para $s0 (registrador salvo)
    	addi $t0, $s0, -1 	# Adiciona imediato: $t0 = $s0 - 1

    for:
    	beq $t0, $zero, exit 	# Branch se igual: vai para exit se $t0 for 0
    	mult $s0, $t0       	# Multiplica: $s0 = $s0 * $t0
    	mflo $s0            	# Move de LO (resultado baixo) da multiplicação para $s0
    	addi $t0, $t0, -1   	# Adiciona imediato: $t0 = $t0 - 1
    	j for               	# Salta para o rótulo for (loop)

    exit:
    	move $a0, $s0    	# Move $s0 (resultado final) para $a0 (registrador de argumento)
    	li $v0, 1        	# Carrega imediato: $v0 = 1 (syscall para imprimir um inteiro)
    	syscall          	# Executa a syscall
