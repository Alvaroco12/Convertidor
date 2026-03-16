.data
numero: .word 45
numero2: .word 15
resultado: .word 0

.text
.globl main

main:
    lw t0, numero
    lw t1, numero2

    add t2, t0, t1
    mv a0, t2

    li a7, 1
    ecall

    li a7, 10
    ecall

