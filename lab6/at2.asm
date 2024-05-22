.data
    newline: .asciiz "\n"   # String contendo apenas uma nova linha

.text
    .globl main

main:
    li $v0, 5           # Solicita ao usuário um inteiro
    syscall
    move $s0, $v0       # Armazena o valor digitado (n) em $s0

    li $t5, 0           # Inicializa a soma de A com 0
    mtc1 $t5, $f1
    mtc1 $t5, $f2       # Inicializa a soma de B com 0
    li $s3, 0           # Inicializa o índice i

Loop:
    beq $s3, $s0, OutLoop  # Verifica se o índice i ultrapassou o tamanho do vetor

    li $v0, 6           # Solicita ao usuário um float
    syscall
    add.s $f1, $f1, $f0 # Acumula o valor lido em A

    li $v0, 6           # Solicita ao usuário um float
    syscall
    add.s $f2, $f2, $f0 # Acumula o valor lido em B

    addi $s3, $s3, 1    # Incrementa o índice i
    j Loop              # Repete o loop

OutLoop:
    move $a0, $s0       # Passa n como argumento para o procedimento Media
    jal Media           # Chama o procedimento Media
    j Exit              # Salta para a saída do programa

Media:
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
    li $v0, 10          # Código para encerrar o programa
    syscall             # Chama a syscall para encerrar
