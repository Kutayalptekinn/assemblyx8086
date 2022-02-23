AHMET SEGMENT PARA 'VELI'
    
    B DW 50h
    A DW 6h
    C DW  ?
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
    
    
    
     MOV BX,B     
    MOV AX,A
    CMP AX,B
    JAE L1 
    XCHG AX,B
    MOV A,AX  
       L2:
    L1 : MOV DX,0
     DIV B 
    
    CMP DX,0
    JE  SON  
    MOV AX,B
    MOV BX,DX  
    JMP L2
    SON: MOV B,BX
    
    
    
    
    
    
    
    
    BABA ENDP 
    ANA ENDS   
END BABA

    
    