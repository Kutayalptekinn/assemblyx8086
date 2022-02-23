datasg SEGMENT PARA 'datasg' 
        
      
      tip DB ?
      
     a DB 17
     b DB 12
     c DB 12
     
     
                             
    datasg ENDS   


stacksg SEGMENT PARA STACK 'stacksg'
    
      DW 12 DUP(?)
    stacksg ENDS


codesg SEGMENT PARA 'codesg'   
      
      ASSUME SS:stacksg DS:datasg CS:codesg
      
      UCGEN PROC FAR  
                    
                    
                   
            PUSH DS
            XOR AX,AX  
            PUSH AX
            MOV AX,datasg
            MOV DS,AX   
            
          MOV AL,a
          MOV BL,b
          MOV CL,c
          CMP AL,BL
          JE J1
          CMP BL,CL
          JE J2
          CMP AL,CL
          JE J2
          MOV tip,3 
          JMP SON
          J1:CMP AL,CL
          JNE J2
          MOV tip,1
          JMP SON  
       J2:MOV tip,2 
          
          SON:MOV AL,tip
          
           
          
          
            
            
            
            
            
            
            
            
            
         
             
      
            
       RETF     
        
        
      UCGEN ENDP
      
    codesg ENDS  

 END UCGEN

