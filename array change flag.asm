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
            
            
            PUSHF
            LAHF 
            XOR AH,40H
            POPF
            SAHF
             
      
            
       RETF     
        
        
      ANA ENDP
      
    codesg ENDS  

 END ANA

