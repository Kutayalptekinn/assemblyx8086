AHMET SEGMENT PARA 'VELI'
    
    A DB 1,2,3,5
 
AHMET ENDS
MEHMET SEGMENT PARA STACK 'MUHITTIN'
    DW 20   DUP(?)
MEHMET ENDS
ANA SEGMENT PARA 'TACETTIN'
    ASSUME SS:MEHMET,DS:AHMET,CS:ANA 
    
    BABA PROC FAR 
        
     
    PUSH DS
    XOR AX,AX
    PUSH AX 
    MOV AX,AHMET
    MOV DS,AX 
    
    LEA DI,A
    CLD
    MOV CX,4
    MOV AL,3
    REPNE SCASB
    CMP CX,0
    JE SON
    STD 
    SON:    
    
    
    
     
    
    
    
    
 
    
    
    
    
    
    
    
    
    
    BABA ENDP 
    ANA ENDS   
END BABA

    
    