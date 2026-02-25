.data
prompt: .string "Dime un numero: "
nl:     .string "\n"

.text
.globl main
main:
    # imprimir prompt
    la a0, prompt
    li a7, 4          # print string
    ecall

    # leer int
    li a7, 5          # read int
    ecall             # devuelve el numero en a0

    # imprimir el int (ya está en a0)
    li a7, 1          # print int
    ecall

    # salto de linea
    la a0, nl
    li a7, 4
    ecall

    # salir
    li a7, 10         # exit
    ecall