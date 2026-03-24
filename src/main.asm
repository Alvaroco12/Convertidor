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
    la a0, pedir_decimal        # carga en a0 la direccion del texto pedir_decimal
    li a7, 4                    # mete en a7 el valor 4
    ecall                       # ejecuta la instruccion de a7, en este caso la 4 (imprimir string)

    li a7, 5                    # mete en a7 el valor 5
    ecall                       # ejecuta la instruccion de a7, en este caso la 5 (leer entero)

    la t1, numero               # carga en t1 la dirección de memoria de la variable numero
    sw a0, 0(t1)                # guarda lo que haya en a0 en la direccion de memoria de numero
    mv t0, a0                   # mueve a t0 el numero que ha metido el usuario

    mv a0, t0                   # mueve a a0 lo que haya en t0
    jal ra, imp_hexadecimal     # llama a la funcion imp_hexadecimal

    jal ra, imprimir_salto      # llama a la funcion imprimir_salto

    mv a0, t0                   # mueve a a0 lo que haya en t0
    jal ra, imp_binario         # llama a la funcion imp_binario

    jal ra, imprimir_salto      # llama a la funcion imprimir_salto

    j menu                      # vuelve al menu

binario:                        # etiqueta binario
    la a0, pedir_binario        # carga en a0 la direccion del texto pedir_binario
    li a7, 4                    # mete en a7 el valor 4
    ecall                       # ejecuta la instruccion de a7, en este caso la 4 (imprimir string)

    la a0, buffer_binario       # carga en a0 la direccion del buffer_binario
    li a1, 33                   # mete en a1 el tamaño maximo del buffer
    li a7, 8                    # mete en a7 el valor 8
    ecall                       # ejecuta la instruccion de a7, en este caso la 8 (leer string)

    la a0, buffer_binario       # carga en a0 la direccion del texto guardado en buffer_binario
    jal ra, binario_a_decimal   # llama a la funcion binario_a_decimal y deja el resultado decimal en t0

    la t1, numero               # carga en t1 la direccion de memoria de la variable numero
    sw t0, 0(t1)                # guarda en numero el resultado decimal que ha quedado en t0

    la a0, texto_decimal        # carga en a0 la direccion del texto texto_decimal
    li a7, 4                    # mete en a7 el valor 4
    ecall                       # ejecuta la instruccion de a7, en este caso la 4 (imprimir string)

    mv a0, t0                   # mueve a a0 lo que haya en t0
    li a7, 1                    # mete en a7 el valor 1
    ecall                       # ejecuta la instruccion de a7, en este caso la 1 (imprimir entero decimal)

    jal ra, imprimir_salto      # llama a la funcion imprimir_salto

    mv a0, t0                   # mueve a a0 lo que haya en t0
    jal ra, imp_hexadecimal     # llama a la funcion imp_hexadecimal

    jal ra, imprimir_salto      # llama a la funcion imprimir_salto

    j menu                      # vuelve al menu

hexadecimal:                    #etiqueta hexadecimal
    la a0, pedir_hexadecimal    # carga en a0 la direccion del texto pedir_hexadecimal
    li a7, 4                    # mete en a7 el valor 4
    ecall                       # ejecuta la instruccion de a7, en este caso la 4 (imprimir string)

    la a0, buffer_hexadecimal   # carga en a0 la direccion del buffer_hexadecimal
    li a1, 33                   # mete en a1 el tamaño maximo del buffer
    li a7, 8                    # mete en a7 el valor 8
    ecall                       # ejecuta la instruccion de a7, en este caso la 8 (leer string)

    la a0, buffer_hexadecimal   # carga en a0 la direccion del texto guardado en buffer_hexadecimal
    jal ra, hexadecimal_a_decimal   # llama a la funcion hexadecimal_a_decimal y deja el resultado decimal en t0

    la t1, numero               # carga en t1 la direccion de memoria de la variable numero
    sw t0, 0(t1)                # guarda en numero el resultado decimal que ha quedado en t0

    la a0, texto_decimal        # carga en a0 la direccion del texto texto_decimal
    li a7, 4                    # mete en a7 el valor 4
    ecall                       # ejecuta la instruccion de a7, en este caso la 4 (imprimir string)

    mv a0, t0                   # mueve a a0 lo que haya en t0
    li a7, 1                    # mete en a7 el valor 1
    ecall                       # ejecuta la instruccion de a7, en este caso la 1 (imprimir entero decimal)

    jal ra, imprimir_salto      # llama a la funcion imprimir_salto

    mv a0, t0                   # mueve a a0 lo que haya en t0
    jal ra, imp_binario         # llama a la funcion imp_binario

    jal ra, imprimir_salto      # llama a la funcion imprimir_salto

    j menu                      # vuelve al menu

binario_a_decimal:              #etiqueta binario a decimal
    li t0, 0                    # mete en t0 un 0, aqui se va a ir guardando el resultado decimal

bucle_binario:                  # etiqueta del bucle
    lb t1, 0(a0)                # carga en t1 el caracter actual del texto al que apunta a0

    beq t1, zero, fin_binario   # si t1 vale 0, significa fin de cadena y termina la funcion

    li t2, 10                   # mete en t2 un 10
    beq t1, t2, fin_binario     # si t1 es salto de linea, termina la funcion

    addi t1, t1, -48            # convierte el caracter ascii en numero, '0' pasa a 0 y '1' pasa a 1

    li t2, 2                    # mete en t2 un 2
    mul t0, t0, t2              # multiplica el resultado actual por 2

    add t0, t0, t1              # suma al resultado el bit actual

    addi a0, a0, 1              # avanza a0 al siguiente caracter del texto

    j bucle_binario             # vuelve al principio del bucle

fin_binario:                    # etiqueta final de la funcion
    ret                         # vuelve a la posicion donde apunta ra

hexadecimal_a_decimal:          # etiqueta hexadecimal a decimal
    li t0, 0

bucle_hexadecimal:
    lb t1, 0(a0)

    beq t1, zero, fin_hexadecimal

    li t2, 10
    beq t1, t2, fin_hexadecimal

    li t2, 48
    blt t1, t2, fin_hexadecimal

    li t2, 57
    ble t1, t2, digito_numero

    li t2, 65
    blt t1, t2, comprobar_minuscula

    li t2, 70
    ble t1, t2, digito_mayuscula

comprobar_minuscula:
    li t2, 97
    blt t1, t2, fin_hexadecimal

    li t2, 102
    ble t1, t2, digito_minuscula

    j fin_hexadecimal

digito_numero:
    addi t1, t1, -48
    j acumular_hexadecimal

digito_mayuscula:
    addi t1, t1, -55
    j acumular_hexadecimal

digito_minuscula:
    addi t1, t1, -87

acumular_hexadecimal:
    li t2, 16
    mul t0, t0, t2

    add t0, t0, t1

    addi a0, a0, 1

    j bucle_hexadecimal

fin_hexadecimal:
    ret

imp_binario:                    # etiqueta imp_binario
    mv t1, a0                   # guarda en t1 el numero que ha llegado a la funcion

    la a0, texto_binario        # carga en a0 la direccion del texto texto_binario
    li a7, 4                    # mete en a7 el valor 4
    ecall                       # ejecuta la instruccion de a7, en este caso la 4 (imprimir string)

    mv a0, t1                   # vuelve a mover a a0 el numero que se habia guardado en t1
    li a7, 35                   # mete en a7 el valor 35
    ecall                       # ejecuta la instruccion de a7, en este caso la 35 (imprimir binario)

    ret                         # vuelve a la posicion donde apunta ra

imp_hexadecimal:                # etiqueta imp_hexadecimal
    mv t1, a0                   # guarda en t1 el numero que ha llegado a la funcion

    la a0, texto_hexadecimal    # carga en a0 la direccion del texto texto_hexadecimal
    li a7, 4                    # mete en a7 el valor 4
    ecall                       # ejecuta la instruccion de a7, en este caso la 4 (imprimir string)

    mv a0, t1                   # vuelve a mover a a0 el numero que se habia guardado en t1
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