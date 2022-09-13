        ; -----------------------------------------------------------------------
        ; Calculates the sum of two read signed numbers and prints it on the screen.
        ; ANA 		: Main procedure
        ; PUT_STR 	: Prints the string with the end of 0 to the screen.
        ; PUTC 	: Prints the character in AL to the screen.
        ; GETC 	:Takes the character printed from the keyboard to AL.
        ; PUTN 	: Prints the number in AX to the screen. 
        ; GETN 	: Puts the number read from the keyboard in AX
        ; -----------------------------------------------------------------------
STACKSG 	SEGMENT PARA STACK 'STACK' 
    
	DW 32 DUP (?) 
	
STACKSG 	ENDS  



DATASG	SEGMENT PARA 'DATA' 
        
CR	EQU 13
LF	EQU 10 
MSG7 DB                    " ",0        
MSG6 DB CR, LF,            "->",0
MSG4	DB CR, LF,         'Enter the number of array elements: ',0
MSG5	DB CR, LF,         'Enter element', 0   
MSG1 DB CR, LF,            "1-) Press 1 to add array",0  
MSG2 DB CR, LF,            "2-) Press 2 to add element to existing array",0 
MSG3 DB CR, LF,            "3-) Press 3 to show the series with the links ",0
CIKIS DB CR, LF,           "4-) Press 4 to exit ", 0
HATA	DB CR, LF,         'Attention !!! You did not give a number, please log in again.!!!  ', 0
N	DW ?         
dizi    DW 100 DUP (?) 
dizi2   DW 100 DUP(?) 
mindis     DW ?   
MAX     DW ?     


DATASG 	ENDS   



CODESG 	SEGMENT PARA 'CODE' 
    
	ASSUME CS:CODESG, DS:DATASG, SS:STACKSG 
	    
     MENU PROC NEAR  
              
    MOV AX,OFFSET MSG1
    CALL PUT_STR           
    MOV AX,OFFSET MSG2
	CALL PUT_STR      
	MOV AX,OFFSET MSG3
	CALL PUT_STR    
    MOV AX,OFFSET CIKIS
	CALL PUT_STR 
	CALL GETN 
	
RET
MENU ENDP
     
     

 BABA   PROC FAR
    
    
           PUSH DS
           XOR AX,AX
           PUSH AX
           MOV AX, DATASG 
           MOV DS, AX 

        
    CALL MENU ;   sonuc ax te 
           
    CMP AX,1 
	JE J12 
	CMP AX,2 
	JNE AJ5  
    ADD CX,1 
    MOV BX,N
    ADD BX,1
    MOV N,BX 
	JMP J2
 AJ5:CMP AX,3 
	JE J31
	CMP AX,4 
	JE J41 
	
	J12:    MOV AX, OFFSET MSG4
           CALL PUT_STR			    
           CALL GETN  			         
           MOV N, AX      ;eleman sayisi ax'ten n'e aktariliyor
           XOR DI,DI      ;DI 0 laniyor
           MOV CX,N       ;eleman sayisi dongu icin cx'e aktariliyor
  J2:      MOV AX,OFFSET MSG5   ;dizi elemanlari icin mesaj
           CALL PUT_STR
           CALL GETN
           MOV dizi[DI],AX ;girilen dizi elemani axten dizinin ilk elemanina aktariliyor
           CMP DI,0 ;girilen dizi elemani dizinin ilk elemani ise en kucuk eleman
            ;indisi 0 olarak ve dizi2 nin ilk degeri de -1 olarak aktariliyor
           JNE  ILKDEGIL
           MOV mindis,DI ;en kucuk indis minimuma aktariliyor
           MOV dizi2[DI],-1  ;dizi2 nin ilk elemani -1 yapiliyor max eleman olarak kabul edildigi icin
           JMP INCDI ;ilk elemani yerlestirip di yi arttirip donguye tekrar giriyoruz
ILKDEGIL:   MOV SI,mindis ;girilen eleman dizinin ilk elemani degilse buradan devam ediyoruz ve minimum
                                                                    ; elemanin oldugu indisi si ya atiyoruz
           CMP dizi[SI],AX ;girilen elemanin dizinin en kucuk elemanindan kucuk mu oldugu kontrolunu yapiyoruz  
           JL L6   ;eger girilen eleman yeni en kucuk eleman degil ise l6 ya gidiyoruz
           MOV DX,mindis ;yeni en kucuk eleman bir onceki en kucuk elemani gosterecek sekilde linkleniyor 
           MOV dizi2[DI],DX
           MOV mindis,DI   ; yeni en kucuk elemanin indisini tutuyoruz
           JMP INCDI        ; di yi arttirip tekrar donguye giriyoruz
        J41:CMP AX,4 ; JMP OUT OF RANGE HATASI VERDIGI ICIN KONTROL
         JE J42 
      J31:   CMP AX,3     ; JMP OUT OF RANGE HATASI VERDIGI ICIN KONTROL
         JE J32 
         J11: CMP AX,1   ; JMP OUT OF RANGE HATASI VERDIGI ICIN KONTROL
         JE J12   
 L6:       MOV BX,mindis  ;girilen eleman ilk eleman degilse ve en kucuk eleman degilse buradan devam ediyoruz
                                                                         ;en kucuk indisi bx icine aliyorum

L0:        CMP BX,0   ; bx 0 dan kucukse yani -1 se donguye girmeden cikacak ve degisimi yapacak
           JL L5
           CMP dizi[BX],AX ;eklenen elemanin en kucuk elemanla kontrolunu yapiyorum buyuk oldukca bir sonraki
           ;                                                                  en kucuk elemana yonlendiriyorum
           JNLE L5
           MOV SI,BX  ;bir onceki en kucuk indisi kaybetmemek icin tutuyorum ve indisi en kucuk elemandan bir
           ;                                                                  sonraki elemana yonlendiriyorum
           MOV BX,dizi2[BX]  ;yeni en kucuk elemanin indisi bir onceki linkin indisi olarak belirleniyor
           JMP L0
L5:        MOV dizi2[DI],BX;yeni elemanin linki kendisinden bir buyuk elemanin indisine ayarlaniyor
           MOV dizi2[SI],DI ;kaybetmemek icin tuttugumuz bir onceki indis ise yeni elemanin indisini gosteriyor
                   
                   
INCDI:       ADD DI,2 
             LOOP J2
             CALL elemanlariyazdir
             CALL MENU  ; sonuc ax te
             
    CMP AX,1 
	JE J11 
	CMP AX,2 
	JNE J5  
    ADD CX,1 
    MOV BX,N
    ADD BX,1
    MOV N,BX 
	JMP J2
 J5:CMP AX,3 
	JE J32
	CMP AX,4 
	JE J42  

            
              
  J42:   
        		        
        RETF  
        
        
BABA 	ENDP 
           
             
           
 elemanlariyazdir PROC NEAR  
        
                  
   J32:  MOV AX,OFFSET MSG6   ;satir atlamak icin
        CALL PUT_STR
        
       MOV AX,OFFSET MSG6   ;satir atlamak icin
        CALL PUT_STR
     
     XOR BX,BX			    
        MOV CX, N
     L7:MOV AX, dizi[BX]    			    			    
        CALL PUTN  
        MOV AX,OFFSET MSG7   ;sutun atlamak icin
        CALL PUT_STR
        ADD BX,2
        LOOP L7 
        
        MOV AX,OFFSET MSG6   ;satir atlamak icin
        CALL PUT_STR
         
        XOR BX,BX			    
        MOV CX, N
        L8:MOV AX, dizi2[BX]
        CMP AX,-1
        JE J8 
        SHR AX,1   			    			    
    J8: CALL PUTN
    MOV AX,OFFSET MSG7   ;sutun atlamak icin
        CALL PUT_STR 
        ADD BX,2
        LOOP L8	 
        
        MOV AX,OFFSET MSG7   ;sutun atlamak icin
        CALL PUT_STR
           
        
	          RET
  elemanlariyazdir ENDP 
            
            
            
            

GETC	PROC NEAR
        ;------------------------------------------------------------------------
        ; Klavyeden basilan karakteri AL yazmacina alir ve ekranda gosterir. 
        ; islem sonucunda sadece AL etkilenir. 
        ;------------------------------------------------------------------------
        MOV AH, 1h
        INT 21H
        RET 
GETC	ENDP 

PUTC	PROC NEAR
        ;------------------------------------------------------------------------
        ; AL yazmacindaki degeri ekranda gosterir. DL ve AH degisiyor. AX ve DX 
        ; yazmaclarinin degerleri korumak icin PUSH/POP yapilir. 
        ;------------------------------------------------------------------------
        PUSH AX
        PUSH DX
        MOV DL, AL
        MOV AH,2
        INT 21H
        POP DX
        POP AX
        RET 
PUTC 	ENDP 

GETN 	PROC NEAR
        ;------------------------------------------------------------------------
        ; Klavyeden basilan sayiyi okur, sonucu AX yazmaci uzerinden dondurur. 
        ; DX: sayinin isaretli olup/olmadigini belirler. 1 (+), -1 (-) demek 
        ; BL: hane bilgisini tutar 
        ; CX: okunan sayinin islenmesi sirasindaki ara degeri tutar. 
        ; AL: klavyeden okunan karakteri tutar (ASCII)
        ; AX zaten donen degeri olarak degismek durumundadir. Ancak diger 
        ; yazmaclarin onceki degerleri korunmalidir. 
        ;------------------------------------------------------------------------
        PUSH BX
        PUSH CX
        PUSH DX
GETN_START:
        MOV DX, 1	                        ; sayinin simdilik + oldugunu varsayalim 
        XOR BX, BX 	                        ; okuma yapmadi Hane 0 olur. 
        XOR CX,CX	                        ; ara toplam degeri de 0 dir. 
NEW:
        CALL GETC	                        ; klavyeden ilk degeri AL ye oku. 
        CMP AL,CR 
        JE FIN_READ	                        ; Enter tusuna basilmis ise okuma biter
        CMP  AL, '-'	                    ; AL ,'-' mi geldi ? 
        JNE  CTRL_NUM	                    ; gelen 0-9 arasinda bir sayi mi?
NEGATIVE:
        MOV DX, -1	                        ; - basildi ise sayi negatif, DX=-1 olur
        JMP NEW		                        ; yeni haneyi al
CTRL_NUM:
        CMP AL, '0'	                        ; sayinin 0-9 arasinda oldugunu kontrol et.
        JB error 
        CMP AL, '9'
        JA error		                    ; degil ise HATA mesaji verilecek
        SUB AL,'0'	                        ; rakam alindi, haneyi toplama dâhil et 
        MOV BL, AL	                        ; BL ye okunan haneyi koy 
        MOV AX, 10 	                        ; Haneyi eklerken *10 yapilacak 
        PUSH DX		                        ; MUL komutu DX i bozar isaret için saklanmali
        MUL CX		                        ; DX:AX = AX * CX
        POP DX		                        ; isareti geri al 
        MOV CX, AX	                        ; CX deki ara deger *10 yapildi 
        ADD CX, BX 	                        ; okunan haneyi ara degere ekle 
        JMP NEW 		                    ; klavyeden yeni basilan degeri al 
ERROR:
        MOV AX, OFFSET HATA 
        CALL PUT_STR	                    ; HATA mesajini goster 
        JMP GETN_START                      ; o ana kadar okunanlari unut yeniden sayi almaya basla 
FIN_READ:
        MOV AX, CX	                        ; sonuç AX uzerinden donecek 
        CMP DX, 1	                        ; İsarete gore sayiyi ayarlamak lazim 
        JE FIN_GETN
        NEG AX		                        ; AX = -AX
FIN_GETN:
        POP DX
        POP CX
        POP DX
        RET 
GETN 	ENDP 

PUTN 	PROC NEAR
        ;------------------------------------------------------------------------
        ; AX de bulunan sayiyi onluk tabanda hane hane yazdirir. 
        ; CX: haneleri 10 a bolerek bulacagiz, CX=10 olacak
        ; DX: 32 bolmede isleme dâhil olacak. Soncu etkilemesin diye 0 olmali 
        ;------------------------------------------------------------------------
        PUSH CX
        PUSH DX 	
        XOR DX,	DX 	                        ; DX 32 bit bolmede soncu etkilemesin diye 0 olmali 
        PUSH DX		                        ; haneleri ASCII karakter olarak yiginda saklayacagiz.
                                            ; Kaç haneyi alacagimizi bilmedigimiz için yigina 0 
                                            ; degeri koyup onu alana kadar devam edelim.
        MOV CX, 10	                        ; CX = 10
        CMP AX, 0
        JGE CALC_DIGITS	
        NEG AX 		                        ; sayi negatif ise AX pozitif yapilir. 
        PUSH AX		                        ; AX sakla 
        MOV AL, '-'	                        ; isareti ekrana yazdir. 
        CALL PUTC
        POP AX		                        ; AX i geri al 
        
CALC_DIGITS:
        DIV CX  		                    ; DX:AX = AX/CX  AX = bolum DX = kalan 
        ADD DX, '0'	                        ; kalan degerini ASCII olarak bul 
        PUSH DX		                        ; yigina sakla 
        XOR DX,DX	                        ; DX = 0
        CMP AX, 0	                        ; bolen 0 kaldi ise sayinin islenmesi bitti demek
        JNE CALC_DIGITS	                    ; islemi tekrarla 
        
DISP_LOOP:
                                            ; yazilacak tum haneler yiginda. En anlamli hane ustte 
                                            ; en az anlamli hane en alta ve onu altinda da 
                                            ; sona vardigimizi anlamak için konan 0 degeri var. 
        POP AX		                        ; sirayla degerleri yigindan alalim
        CMP AX, 0 	                        ; AX=0 olursa sona geldik demek 
        JE END_DISP_LOOP 
        CALL PUTC 	                        ; AL deki ASCII degeri yaz
        JMP DISP_LOOP                       ; isleme devam
        
END_DISP_LOOP:
        POP DX 
        POP CX
        RET
PUTN 	ENDP 

PUT_STR	PROC NEAR
        ;------------------------------------------------------------------------
        ; AX de adresi verilen sonunda 0 olan dizgeyi karakter karakter yazdirir.
        ; BX dizgeye indis olarak kullanilir. Önceki degeri saklanmalidir. 
        ;------------------------------------------------------------------------
	PUSH BX 
        MOV BX,	AX			            ; Adresi BXe al 
        MOV AL, BYTE PTR [BX]	        ; ALde ilk karakter var 
PUT_LOOP:   
        CMP AL,0		
        JE  PUT_FIN 			        ; 0 geldi ise dizge sona erdi demek
        CALL PUTC 			            ; ALdeki karakteri ekrana yazar
        INC BX 				            ; bir sonraki karaktere gecerç
        MOV AL, BYTE PTR [BX]
        JMP PUT_LOOP			        ; yazdirmaya devam 
PUT_FIN:
	POP BX
	RET 
PUT_STR	ENDP

CODESG 	ENDS 
	END BABA
