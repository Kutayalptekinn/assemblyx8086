AHMET SEGMENT PARA 'VELI'
    X DB 5h
    N DB 6h
    T DW 1h 
    K DW  ?
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
          
    XOR AX,AX      
    MOV AL,X
    MOV K,AX
    MOV CX,WORD PTR N 
    MOV SI,1  
    MOV DX,0
    MOV AX,K
 L1:DIV SI 
    ADD T,AX
    MOV AX,K
    MUL X
    MOV K,AX    
    INC SI
    LOOP L1
    MOV AX,T
    
    
    
    BABA ENDP 
    ANA ENDS   
END BABA

    
    