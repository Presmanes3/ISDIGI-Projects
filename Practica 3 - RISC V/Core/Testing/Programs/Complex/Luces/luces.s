#JUEGO DE LUCES DISEÑO


addi x13, x0, 1 #00000001 como referencia 

#Bucle hasta que inicia la secuencia con el start
B1:
sb x0, 1025(x0) #reinicia la salida a 00000000
lb x11, 1024(x0) #posición 1024; es la entrada
bne x11, x13, B1 #salta al bucle 1 (B1) si la entrada no es igual a 1

B2: #bucle del juego de luces

lb x11, 1024(x0) #posición 1024;  la entrada
bne x11,x13, B1 #si es = 1, continua el bucle, si no salta al inicio

addi x12, x0, 128 #(10000000)
sb x12 , 1025(x0)

lb x11, 1024(x0) #posición 1024;  la entrada
bne x11,x13, B1 #si es = 1, continua el bucle, si no salta al inicio

addi x12, x0, 64 #(01000000)
sb x12 , 1025(x0)

lb x11, 1024(x0) #posición 1024;  la entrada
bne x11,x13, B1 #si es = 1, continua el bucle, si no salta al inicio

addi x12, x0, 32 #(00100000)
sb x12 , 1025(x0)

lb x11, 1024(x0) #posición 1024;  la entrada
bne x11,x13, B1 #si es = 1, continua el bucle, si no salta al inicio

addi x12, x0, 16 #(00010000)
sb x12 , 1025(x0)

lb x11, 1024(x0) #posición 1024;  la entrada
bne x11,x13, B1 #si es = 1, continua el bucle, si no salta al inicio

addi x12, x0, 8 #(00001000)
sb x12 , 1025(x0)

lb x11, 1024(x0) #posición 1024;  la entrada
bne x11,x13, B1 #si es = 1, continua el bucle, si no salta al inicio

addi x12, x0, 4 #(00000100)
sb x12 , 1025(x0)

lb x11, 1024(x0) #posición 1024;  la entrada
bne x11,x13, B1 #si es = 1, continua el bucle, si no salta al inicio

addi x12, x0, 2 #(00000010)
sb x12 , 1025(x0)

lb x11, 1024(x0) #posición 1024;  la entrada
bne x11,x13, B1 #si es = 1, continua el bucle, si no salta al inicio

addi x12, x0, 1 #(00000001)
sb x12 , 1025(x0)

lb x11, 1024(x0) #posición 1024;  la entrada
bne x11,x13, B1 #si es = 1, continua el bucle, si no salta al inicio

addi x12, x0, 2 #(00000010)
sb x12 , 1025(x0)

lb x11, 1024(x0) #posición 1024;  la entrada
bne x11,x13, B1 #si es = 1, continua el bucle, si no salta al inicio

addi x12, x0, 4 #(00000100)
sb x12 , 1025(x0)

lb x11, 1024(x0) #posición 1024;  la entrada
bne x11,x13, B1 #si es = 1, continua el bucle, si no salta al inicio

addi x12, x0, 8 #(00001000)
sb x12 , 1025(x0)

lb x11, 1024(x0) #posición 1024;  la entrada
bne x11,x13, B1 #si es = 1, continua el bucle, si no salta al inicio

addi x12, x0, 16 #(00010000)
sb x12 , 1025(x0)

lb x11, 1024(x0) #posición 1024;  la entrada
bne x11,x13, B1 #si es = 1, continua el bucle, si no salta al inicio

addi x12, x0, 32 #(00100000)
sb x12 , 1025(x0)

lb x11, 1024(x0) #posición 1024;  la entrada
bne x11,x13, B1 #si es = 1, continua el bucle, si no salta al inicio

addi x12, x0, 64 #(01000000)
sb x12 , 1025(x0)

j B2









