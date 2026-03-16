.data
menu_texto: .asciz "\n--- MENU DE CONVERTIDOR, QUE QUIERES HACER?---\n1. Introducir decimal\n2. Salir\nOpcion: "   # texto del menu
numero: .word 45                # variable numero con valor 45

.text                           # seccion de codigo
.globl main                     # indica que main es la etiqueta principal del programa

main:                           # etiqueta main

menu:                           # etiqueta menu
    la a0, menu_texto           # carga en a0 la direccion del texto menu_texto
    li a7, 4                    # mete en a7 el valor 4
    ecall                       # ejecuta la instruccion de a7, en este caso la 4 (imprimir string)

    li a7, 5                    # mete en a7 el valor 5
    ecall                       # ejecuta la instruccion de a7, en este caso la 5 (leer entero), el numero se guarda en a0

    li t0, 1                    # mete en t0 un 1
    beq a0, t0, decimal          # si a0 es igual a t0, salta a la etiqueta decimal

    li t0, 2                    # mete en t0 un 2
    beq a0, t0, salir           # si a0 es igual a t0, salta a la etiqueta salir

    j menu                      # si no ha metido ni 1 ni 2, vuelve al menu

decimal:                         # etiqueta probar
    lw t0, numero               # carga en t0 el valor guardado en numero
    mv a0, t0                   # mueve a a0 lo que haya en t0

    li a7, 34                   # mete en a7 el valor 34
    ecall                       # ejecuta la instruccion de a7, en este caso la 34 (imprimir hexadecimal)

    li a0, 10                   # mete en a0 un 10
    li a7, 11                   # mete en a7 un 11
    ecall                       # ejecuta la instruccion de a7, en este caso la 11 (imprimir caracter), 10 en ascii es salto de linea

    mv a0, t0                   # mueve a a0 lo que haya en t0
    li a7, 35                   # mete en a7 el valor 35
    ecall                       # ejecuta la instruccion de a7, en este caso la 35 (imprimir binario)

    li a0, 10                   # mete en a0 un 10
    li a7, 11                   # mete en a7 un 11
    ecall                       # ejecuta la instruccion de a7, en este caso la 11 (imprimir caracter), 10 en ascii es salto de linea

    j menu                      # vuelve al menu

salir:                          # etiqueta salir
    li a7, 10                   # mete en a7 el valor 10
    ecall                       # ejecuta la instruccion de a7, en este caso la 10 (finalizar programa)