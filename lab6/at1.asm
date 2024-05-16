.data
    	A: .space 40000   	# Vetor A com capacidade para 10000 elementos de precisão simples (4 bytes cada)
    	B: .space 40000   	# Vetor B com capacidade para 10000 elementos de precisão simples (4 bytes cada)
    	newline: .asciiz "\n"   # String contendo apenas uma nova linha

.text
    Main:
    	li $v0, 5          	# Solicita ao usuário um inteiro
    	syscall
    	move $s0, $v0      	# Armazena o valor digitado (n) em $s0
    	move $a0, $s0      	# Passa n como argumento para o procedimento Media

    	li $s3, 0          	# Inicializa o índice i
    	sll $s0, $s0, 2    	# Calcula o deslocamento para o tamanho do vetor em bytes

    Loop1:
    	beq $s3, $s0, OutLoop1  # Verifica se o índice i ultrapassou o tamanho do vetor

    	li $v0, 6          	# Solicita ao usuário um float
    	syscall	
    	s.s $f0, A($s3)    	# Armazena o float lido em A[i]

    	li $v0, 6          	# Solicita ao usuário um float
    	syscall
    	s.s $f0, B($s3)    	# Armazena o float lido em B[i]

    	addi $s3, $s3, 4   	# Incrementa o índice i
    	j Loop1             	# Repete o loop

    OutLoop1:
    	jal Media           	# Chama o procedimento Media
    	j Exit             	 # Salta para a saída do programa

    Media:
    	li $s0, 0          	# Inicializa o índice i
    	move $s1, $a0      	# Move n para $s1
    	sll $s1, $s1, 2    	# Calcula o deslocamento para o tamanho do vetor em bytes

    Loop2:
    	beq $s0, $s1, OutLoop2  # Verifica se o índice i ultrapassou o tamanho do vetor

    	l.s $f0, A($s0)    	# Carrega A[i]
    	add.s $f1, $f1, $f0    	# Acumula A[i]

    	l.s $f0, B($s0)    	# Carrega B[i]
    	add.s $f2, $f2, $f0   	# Acumula B[i]

    	addi $s0, $s0, 4   	# Incrementa o índice i
    	j Loop2             	# Repete o loop

    OutLoop2:
    	mtc1 $a0, $f3      	# Move n para um registrador de ponto flutuante
    	cvt.s.w $f3, $f3   	# Converte n para ponto flutuante

    	div.s $f5, $f1, $f3    	# Calcula a média de A
    	div.s $f6, $f2, $f3    	# Calcula a média de B

    	li $v0, 4           	# Código para imprimir uma string
    	la $a0, newline     	# Carrega o endereço da nova linha
    	syscall             	# Chama a syscall para imprimir

    	li $v0, 2           	# Código para imprimir um float
    	mov.s $f12, $f5     	# Move a média de A para $f12
    	syscall             	# Chama a syscall para imprimir
	
    	li $v0, 4           	# Código para imprimir uma string
    	la $a0, newline     	# Carrega o endereço da nova linha
    	syscall             	# Chama a syscall para imprimir

    	li $v0, 2           	# Código para imprimir um float
    	mov.s $f12, $f6     	# Move a média de B para $f12
    	syscall             	# Chama a syscall para imprimir

    	jr $ra              	# Retorna ao chamador

Exit:
