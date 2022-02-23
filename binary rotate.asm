datasg SEGMENT PARA 'datasg' 
    
     a DB 01101001B     
    datasg ENDS   


stacksg SEGMENT PARA STACK 'stacksg'
    
      DW 12 DUP(?)
    stacksg ENDS


codesg SEGMENT PARA 'codesg'   
      
      ASSUME SS:stacksg DS:datasg CS:codesg
      
      ANA PROC FAR  
                    
                    
                   
            PUSH DS
            XOR AX,AX  
            PUSH AX
            MOV AX,datasg
            MOV DS,AX 
            
            
             MOV AL,a 
             ROL AL,1
             JC L1
             MOV AH,0
             JMP L2
             L1: MOV AH,0FFh
             L2: ROR AL,1
             
      
            
       RETF     
        
        
      ANA ENDP
      
    codesg ENDS  

 END ANA

