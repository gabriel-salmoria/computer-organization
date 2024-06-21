.data
matrix: .space 256  # Espaço para a matriz 16x16 (16*16*1 byte = 256 bytes)

.text

main:
    # Registradores:
    # $t0: Contador de elementos (de 0 a 255)
    # $t1: Endereço base da matriz
    # $t2: Índice da linha
    # $t3: Índice da coluna

    la $t1, matrix      # Carrega o endereço base da matriz
    li $t0, 0           # Inicializa o contador de elementos em 0
    li $t3, 0           # Inicializa o índice da linha em 0

loop_rows:
    li $t2, 0           # Inicializa o índice da coluna em 0

loop_cols:
    mul $t4, $t3, 16    # Calcula o deslocamento da linha (linha * 16)
    add $t4, $t4, $t2   # Adiciona o deslocamento da coluna (linha * 16 + coluna)
    add $t5, $t1, $t4   # Calcula o endereço do elemento na matriz
    sb $t0, 0($t5)      # Armazena o valor do contador no endereço calculado (1 byte)

    addi $t0, $t0, 1    # Incrementa o contador
    addi $t2, $t2, 1    # Incrementa o índice da coluna
    bne $t2, 16, loop_cols  # Se não percorreu todas as colunas, continue

    addi $t3, $t3, 1    # Incrementa o índice da linha
    bne $t3, 16, loop_rows  # Se não percorreu todas as linhas, continue