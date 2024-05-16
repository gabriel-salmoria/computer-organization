.data
    	newline: .asciiz "\n"   # String contendo apenas uma nova linha

.text
    	li $v0, 5          	# Solicita ao usuário um inteiro
    	syscall
    	move $s0, $v0      	# Armazena o valor digitado (n) em $s0

    Loop:
        beq $s1, $s0, OutLoop   # Verifica se s1 (índice do loop) é igual a n

        li $v0, 6          	# Solicita ao usuário um float
        syscall
        add.s $f1, $f1, $f0    	# Acumula o valor do float em $f1

        li $v0, 6          	# Solicita ao usuário um float
        syscall
        add.s $f2, $f2, $f0    	# Acumula o valor do float em $f2

        addi $s1, $s1, 1   	# Incrementa o índice do loop
        j Loop             	# Repete o loop

    OutLoop:
        mtc1 $s0, $f3      	# Move o valor de n para $f3
        cvt.s.w $f3, $f3   	# Converte o valor de n para float em $f3

        div.s $f5, $f1, $f3    	# Calcula a média de $f1 dividido por n
        div.s $f6, $f2, $f3    	# Calcula a média de $f2 dividido por n

        # Exibe uma nova linha
        li $v0, 4           	# Código para imprimir uma string
        la $a0, newline     	# Carrega o endereço da nova linha
        syscall             	# Chama a syscall para imprimir

        li $v0, 2           	# Código para imprimir um float
        mov.s $f12, $f5     	# Move a média de $f1 para $f12
        syscall             	# Chama a syscall para imprimir

        # Exibe uma nova linha
        li $v0, 4           	# Código para imprimir uma string
        la $a0, newline     	# Carrega o endereço da nova linha
        syscall             	# Chama a syscall para imprimir

        li $v0, 2           	# Código para imprimir um float
        mov.s $f12, $f6     	# Move a média de $f2 para $f12
        syscall             	# Chama a syscall para imprimir

