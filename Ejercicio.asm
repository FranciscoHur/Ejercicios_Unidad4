.DATA

DATOS SEGMENT
    
    ;OP1 DB "1.OPERACIONES ARITMETICAS: $"
    OP2 DB "2.EL MAYOR DE TRES NUMEROS: $" 
    OP3 DB "3.SALIR$"
    SEL DB "SELECCIONA UNA DE LAS OPCIONES: $"
    
    MEN     DB "MENU DE OPCIONES$"
    ;TIT2    DB "OPERACIONES BASICAS$"
    TIT3    DB "MAYOR DE 3 NUMEROS$"
    
    OSUM    DB "1.OPERACION SUMA$"
    ORES    DB "2.OPERACION RESTA$"
    OMUL    DB "3.OPERACION MULTIPLICACION$"
    ODIV    DB "4.OPERACION DIVISION$"
    
    M1    DB "INGRESE PRIMER VALOR = $"
    M2    DB "INGRESE SEGUND VALOR = $"
    M3    DB "RESULTADO     = $"
    
    
    MSJ1 DB 'INGRESE TRES DIGITOS:', '$'
    RES1 DB 0AH,0DH,'EL DIGITO MAYOR ES:', '$'
    
    NUM1 DB 100 dup(" "),"$"
    NUM2 DB 100 dup(" "),"$"
    NUM3 DB 100 dup(" "),"$"
    
    SALTO DB 13,10," ",13,10,'$'
    
    OPC     DB ?
    VAR1    DB ?  
    VAR2    DB ?
    VAR3    DB ?
    ;AUX     DB ?
    ;TEMP1   DB ? 
    ;TEMP2   DB ? 
    ;CAD     DB 9 DUP (" "),"$"
    
    DATOS ENDS   

;MACROS

IMPRESION MACRO FILA, COLUMNA, MENSAJE
    
    MOV AH,02H
    MOV BH,0H
    MOV DH,FILA
    MOV DL,COLUMNA
    INT 10H 
    
    MOV AH,09H
    MOV DX,OFFSET MENSAJE
    INT 21H  
    
    IMPRESION ENDM 

;FIN MACROS

CODIGO SEGMENT 
    
    INICIO:
    
    ASSUME DS:DATOS, CS:CODIGO
    
    MOV AX, DATOS
    MOV DS, AX
    
    MOV SI,0
    MOV AX,@DATA
    MOV DS,AX
   
    
    ;PREPARAMOS PANTALLA
    
    MOV AH,06H
    MOV AL,00H
    MOV BH,30
    MOV CX,0000H
    MOV DX,184FH
    INT 10H 
    
    ;OPCIONES DE MENU
    
    ;         FILA COLUMNA
    
    ;PRINT    DH   DL   OPCIONES
    
    IMPRESION 02H, 00H, MEN      
    ;IMPRESION 04H, 00H, OP1
    IMPRESION 06H, 00H, OP2   
    IMPRESION 08H, 00H, OP3
    IMPRESION 0AH, 00H, SEL
    
    ;LEER TECLADO
    MOV AH,01H
    INT 21H
    
    SUB AL, 30H
    MOV OPC, AL 
    
    ; COMPARACIONES
    
    ;CMP OPC,1
    
    ;JE OPMEN2
    
    CMP OPC,2
    
    JE OPMEN3
    
    CMP OPC,3
    
    JMP SALIR
 
    
    ;OPMEN2:
    
                 MOV AH, 00H 
                 MOV AL, 03H
                 INT 10H 
    
                 MOV AH,06H
                 MOV AL,00H
                 MOV BH,30
                 MOV CX,0000H
                 MOV DX,184FH
                 INT 10H
                 
                 ;PREPARAR PANTALLA
                 
                 ;IMPRESION 00H, 18H, TIT2
                 
                 IMPRESION 02H, 00H, OSUM      
                 IMPRESION 04H, 00H, ORES
                 IMPRESION 06H, 00H, OMUL  
                 IMPRESION 08H, 00H, ODIV
                 IMPRESION 0AH, 00H, SEL
                 
                 ;LEER TECLADO
                 MOV AH,01H
                 INT 21H
    
                 SUB AL, 30H
                 MOV OPC, AL
                 
    OPMEN3:
    
                 MOV AH, 00H 
                 MOV AL, 03H
                 INT 10H 
    
                 MOV AH,06H
                 MOV AL,00H
                 MOV BH,30
                 MOV CX,0000H
                 MOV DX,184FH
                 INT 10H
                 
                 ;PREPARAR PANTALLA
                 
                 IMPRESION 00H,20H, TIT3
                 IMPRESION 02H,00H, MSJ1
                 
                 CALL SALTODELINEA;SE LLAMA AL METODO SALTODELINEA

                 CALL INGRESARCARACTER ;SE LLAMA AL METODO INGRESARCARACTER
                
                 MOV NUM1,AL ;GUARDAR EL NUMERO UNO AL
                
                                
                 CALL SALTODELINEA
                                
                 CALL INGRESARCARACTER
                                
                 MOV NUM2,AL
                
                                
                 CALL SALTODELINEA
                                
                 CALL INGRESARCARACTER
                                 
                 MOV NUM3,AL
                
                                
                 CALL SALTODELINEA
                
                ;COMPARAR NUMEROS INGRESADOS
                
                 MOV AH,NUM1
                 MOV AL,NUM2
                 CMP AH,AL ;COMPARAR EL PRIMER Y SEGUNDO DIGITO O NUMERO
                
                 JA compara-1-3 ;SI EL PRIMER NUMERO ES MAYOR, AHORA COMPARA CON EL TERCERO
                 JMP compara-2-3 ;SI EL PRIMER NUMERO NO ES MAYOR, AHORA COMPARA EL NUMERO DOS Y TRES
                
                 compara-1-3:
                 MOV AL,NUM3 ;AH=PRIMER NUMERO, AL=TERCER NUMERO
                 CMP AH,AL ;COMPARA EL PRIMER NUMERO CON EL TERCERO
                 JA MAYOR_1 ;SI EL NUMERO ES MAYOR QUE EL TERCERO, ENTONCES EL PRIMERO ES MAYOR QUE LOS TRES
                
                 compara-2-3:
                 MOV AH,NUM2
                 MOV AL,NUM3
                 CMP AH,AL ;COMPARAR NUMERO DOS Y TRES
                 JA MAYOR_2 ;SI EL DOS ES MAYOR, SE VA AL METODO PARA IMPRIMIR
                 JMP MAYOR_3 ;SI EL DOS NO ES MAYOR, ENTONCES EL TRES ES MAYOR
                
                 
                 MAYOR_1:
                
                 CALL NUMEROMAYOR ;LLAMA AL METODO NUMEROMAYOR
                
                 MOV DX, OFFSET NUM1
                 MOV AH,09H
                 INT 21H
                 JMP EXIT
                
                 MAYOR_2:
                 CALL NUMEROMAYOR
                
                 MOV DX,OFFSET NUM2
                 MOV AH,09H
                 INT 21H
                 JMP EXIT
                 
                 MAYOR_3:
                 CALL NUMEROMAYOR
                
                 MOV DX,OFFSET NUM3
                 MOV AH,09H
                 INT 21H
                 JMP EXIT
                
                 ;METODOS
                
                 NUMEROMAYOR:
                 MOV DX,OFFSET RES1 ;IMPRIME EL DIGITO MAYOR ES:
                 MOV AH,09H
                 INT 21H
                
                 RET
                 INGRESARCARACTER:
                 MOV AH,01H;PEDIR O INGRESAR CARACTER
                 INT 21H
                 RET
                
                 SALTODELINEA:
                 MOV DX,OFFSET SALTO ;SALTO
                 MOV AH,09H
                 INT 21H
                 RET
           
                
                 EXIT:
                 MOV AH,0AH
                 INT 21H
                 JMP INICIO 
                 ENDS
                 
                 
                 
    SALIR:
    MOV AH, 4CH
    INT 21H
    
    
                                 
    ;CODIGO ENDS

END INICIO       
