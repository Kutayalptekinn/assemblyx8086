AHMET SEGMENT PARA 'VELI'
    
    A DB 11100000B
 
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
    
    
    
    MOV AL,A
    MOV CX,8
    L1:SHL AL,1
    RCR AH,1 
     LOOP L1 
     
    
    
    
    
    
    
    
    
    
    BABA ENDP 
    ANA ENDS   
END BABA

    
    