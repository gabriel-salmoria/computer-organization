.data
    newline: .asciiz "\n"   # String contendo apenas uma nova linha

.text
    Main:
        li $v0, 5           # Solicita ao usuário um inteiro
        syscall
        move $s0, $v0       # Armazena o valor digitado (n) em $s0
        
        move $a0, $s0       # Passa n como argumento para o procedimento Media
        li $t0, 4           # Cada elemento é um float (4 bytes)
        mul $a0, $a0, $t0   # Calcula o tamanho necessário em bytes

        # Aloca espaço para o vetor A
        li $v0, 9           # Syscall para alocação de memória
        move $a0, $a0       # Número de bytes a serem alocados
        syscall
        move $t1, $v0       # Endereço do vetor A

        # Aloca espaço para o vetor B
        li $v0, 9           # Syscall para alocação de memória
        move $a0, $a0       # Número de bytes a serem alocados
        syscall
        move $t2, $v0       # Endereço do vetor B

        li $s3, 0           # Inicializa o índice i

    Loop1:
        beq $s3, $s0, OutLoop1  # Verifica se o índice i ultrapassou o tamanho do vetor

        li $v0, 6           # Solicita ao usuário um float
        syscall
        sll $t3, $s3, 2     # Calcula o deslocamento para o índice atual
        add $t4, $t1, $t3   # Calcula o endereço de A[i]
        s.s $f0, 0($t4)     # Armazena o float lido em A[i]

        li $v0, 6           # Solicita ao usuário um float
        syscall
        add $t4, $t2, $t3   # Calcula o endereço de B[i]
        s.s $f0, 0($t4)     # Armazena o float lido em B[i]

        addi $s3, $s3, 1    # Incrementa o índice i
        j Loop1             # Repete o loop

    OutLoop1:
        move $a0, $s0       # Passa n como argumento para o procedimento Media
        move $a1, $t1       # Passa o endereço base de A
        move $a2, $t2       # Passa o endereço base de B
        jal Media           # Chama o procedimento Media
        j Exit              # Salta para a saída do programa

    Media:
        li $s0, 0           # Inicializa o índice i
        move $s1, $a0       # Move n para $s1
        move $t1, $a1       # Endereço base de A
        move $t2, $a2       # Endereço base de B
        # Inicializa a soma de A e B com 0.0
        li $t5, 0
        mtc1 $t5, $f1
        mtc1 $t5, $f2

    Loop2:
        beq $s0, $s1, OutLoop2  # Verifica se o índice i ultrapassou o tamanho do vetor

        sll $t3, $s0, 2     # Calcula o deslocamento para o índice atual
        add $t4, $t1, $t3   # Calcula o endereço de A[i]
        l.s $f0, 0($t4)     # Carrega A[i]
        add.s $f1, $f1, $f0 # Acumula A[i]

        add $t4, $t2, $t3   # Calcula o endereço de B[i]
        l.s $f0, 0($t4)     # Carrega B[i]
        add.s $f2, $f2, $f0 # Acumula B[i]

        addi $s0, $s0, 1    # Incrementa o índice i
        j Loop2             # Repete o loop

    OutLoop2:
        mtc1 $a0, $f3       # Move n para um registrador de ponto flutuante
        cvt.s.w $f3, $f3    # Converte n para ponto flutuante

        div.s $f5, $f1, $f3 # Calcula a média de A
        div.s $f6, $f2, $f3 # Calcula a média de B

        li $v0, 4           # Código para imprimir uma string
        la $a0, newline     # Carrega o endereço da nova linha
        syscall             # Chama a syscall para imprimir

        li $v0, 2           # Código para imprimir um float
        mov.s $f12, $f5     # Move a média de A para $f12
        syscall             # Chama a syscall para imprimir

        li $v0, 4           # Código para imprimir uma string
        la $a0, newline     # Carrega o endereço da nova linha
        syscall             # Chama a syscall para imprimir

        li $v0, 2           # Código para imprimir um float
        mov.s $f12, $f6     # Move a média de B para $f12
        syscall             # Chama a syscall para imprimir

        jr $ra              # Retorna ao chamador

Exit:
