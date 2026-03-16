.data                   # seccion de datos
numero: .word 3         # crea variable numero y la inicializa en 3

.text                   # seccion de codigo
.globl main             # indica que globl (inicio del programa), es la etiqueta main

main:                   # etiqueta main

    lw t0, numero       # carga en t0, lo que haya en numero
    mv a0, t0           # mueve a a0, lo que haya en t0

    li a7, 34           # mete en a7, el valor 34
    ecall               # ejecuta la instruccion de a7, en este caso la 34 (imprimir hexadecimal)

    li a0, 10           # mete en a0 un 10
    li a7, 11           # mete en a7 un 11
    ecall               # ejecuta la instruccion de a7, en este caso la 11 (imprimir caracter), 10 en ascii es salto de linea

    mv a0, t0           # mueve a a0, lo que haya en t0
    li a7, 35           # mete en a7, el valor 35
    ecall               # ejecuta la instruccion de a7, en este caso la 34 (imprimir binario)


salir:
    li a7, 10           # mete en a7, el valor 10
    ecall               # ejecuta la instruccion de a7, en este caso la 10 (finalizar programa)