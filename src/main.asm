.data
menu_texto: .asciz "\n--- MENU DE CONVERTIDOR ---\n1. Decimal\n2. Binario\n3. Hexadecimal\n4. Salir\nOpcion: "   # texto del menu principal

pedir_decimal: .asciz "\nIntroduce un numero decimal: "                           # texto para pedir un numero decimal
pedir_binario: .asciz "\nIntroduce un numero binario: "                           # texto para pedir un numero binario
pedir_hexadecimal: .asciz "\nIntroduce un numero hexadecimal: "                   # texto para pedir un numero hexadecimal

texto_decimal: .asciz "\nDecimal: "                                               # texto para mostrar resultado en decimal
texto_binario: .asciz "\nBinario: "                                               # texto para mostrar resultado en binario
texto_hexadecimal: .asciz "\nHexadecimal: "                                       # texto para mostrar resultado en hexadecimal

numero: .word 1234                                                                # variable para guardar el valor interno del numero
buffer_binario: .space 33                                                         # espacio para guardar un binario escrito como texto
buffer_hexadecimal: .space 33                                                     # espacio para guardar un hexadecimal escrito como texto

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
    beq a0, t0, decimal         # si a0 es igual a t0, salta a la etiqueta decimal

    li t0, 2                    # mete en t0 un 2
    beq a0, t0, binario         # si a0 es igual a t0, salta a la etiqueta binario

    li t0, 3                    # mete en t0 un 3
    beq a0, t0, hexadecimal     # si a0 es igual a t0, salta a la etiqueta hexadecimal

    li t0, 4                    # mete en t0 un 4
    beq a0, t0, salir           # si a0 es igual a t0, salta a la etiqueta salir

    j menu                      # si mete otro numero, vuelve al menu

decimal:                        # etiqueta decimal
    lw t0, numero               # carga en t0 el valor guardado en numero

    mv a0, t0                   # mueve a a0 lo que haya en t0
    jal ra, imp_hexadecimal     # llama a la funcion imp_hexadecimal

    jal ra, imprimir_salto      # va a la funcion imprimir_salto

    mv a0, t0                   # mueve a a0 lo que haya en t0
    jal ra, imp_binario         # llama a la funcion imp_binario

    jal ra, imprimir_salto      # va a la funcion imprimir_salto

    j menu                      # vuelve al menu

binario:                        # etiqueta binario
    j menu

hexadecimal:                    #etiqueta hexadecimal
    j menu

binario_a_decimal:              #etiqueta binario a decimal
    ret

hexadecimal_a_decimal:          #etiqueta hexadecimal a decimal
    ret

imp_binario:                    # etiqueta imp_binario
    li a7, 35                   # mete en a7 el valor 35
    ecall                       # ejecuta la instruccion de a7, en este caso la 35 (imprimir binario)
    ret                         # vuelve a la posicion donde apunta ra

imp_hexadecimal:                # etiqueta imp_hexadecimal
    li a7, 34                   # mete en a7 el valor 34
    ecall                       # ejecuta la instruccion de a7, en este caso la 34 (imprimir hexadecimal)
    ret                         # vuelve a la posicion donde apunta ra

salir:                          # etiqueta salir
    li a7, 10                   # mete en a7 el valor 10
    ecall                       # ejecuta la instruccion de a7, en este caso la 10 (finalizar programa)

imprimir_salto:
    li a0, 10                   # mete en a0 un 10
    li a7, 11                   # mete en a7 un 11
    ecall                       # ejecuta la instruccion de a7, en este caso la 11 (imprimir caracter), 10 en ascii es salto de linea
    ret                         # vuelve a la posicion donde apunta ra (donde se llamo la funcion)