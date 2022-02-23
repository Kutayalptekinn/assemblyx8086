datasg SEGMENT PARA 'datasg' 
        
      
      
     S DW ? 
     N DW 4
     dizi DB 12,13,15,14
     
     
     
     
                             
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
                       
           MOV CX,N
           DEC CX           
           XOR BX,BX
           XOR SI,SI
          CMPR: CMP BX,0
           JNE SONIF
           CMP SI,CX
           JGE SONIF 
           MOV DL,dizi[SI+1]
           CMP dizi[SI],DL 
           JLE ART
           MOV BX,1
           ART:INC SI
           JMP CMPR 
           SONIF:CMP BX,0
           JE L1
           MOV S,0
           JMP SON
           L1:MOV S,1
           SON:MOV AX,S
                    
            

          
           
          
          
            
            
            
            
            
            
            
            
            
         
             
      
            
       RETF     
        
        
      UCGEN ENDP
      
    codesg ENDS  

 END UCGEN

