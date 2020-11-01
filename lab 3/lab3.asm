; Lab3.asm
;
    .MODEL SMALL
    .STACK 100h
    .DATA
	
temp         DW 0	
Ten          DW 10
number       DW 0
sumnum       DW 0
reVSumnum    DW 0
PromptStr    DB 'Please enter (from 1000 up to 9999):',13,10,'$'
errMsg       DB '    Wrong',13,10,'$'
harshadMsg   DB '   Harshad Number',13,10,'$'
SpharshadMsg DB 'It Is Also A Special Harshad number',13,10,'$'
NoharshadMsg DB '    Is Not Harshad Numbers' ,13,10, '$'
resultStr    DB ,13,10, 'XXXX' ,13,10, '$'
                            ;
     .CODE
	 .386
     MOV AX,@DATA   ; DS can be written to only through a register
     MOV DS,AX      ; Set DS to point to data segment
	 

     MOV AH,9                 ; Set print option for int 21h
     MOV DX,OFFSET PromptStr  ;  Set  DS:DX to point to PromptString
     INT 21h                  ;  Print PromptStr
	 
	 ;scan character to AL
	 MOV AH,1
	 INT 21h
	 
	 MOV resultStr[2],AL ;build the num as a string
	 
	 
	 ; Read first digit
	 
	 SUB AL,'0'    ;convert to number 
	 MOV AH,0
	 MOV sumnum,AX
	 MUL Ten       ;AX=AX*10
	 MOV number,AX
	 MOV AX,0
	 
	  ; Read second digit
	  
	  ;scan character to AL
	 MOV AH,1
	 INT 21h
	 
	 MOV resultStr[3],AL ;build the num as a string
	 
	 SUB AL,'0'      ;convert to number 
	 MOV AH,0
	 ADD sumnum,AX
	 ADD AX,number   ;AX=AX+number
	 MUL Ten         ;AX=AX*10
	 MOV number,AX
	 
	 MOV AX,0
	 
	 ; Read third digit
	 
	 ;scan character to AL
	 MOV AH,1
	 INT 21h
	 
	 MOV resultStr[4],AL ;build the num as a string
	  
	 SUB AL,'0';convert to number 
	 MOV AH,0
	 ADD sumnum,AX
	 ADD AX,number    ;AX=AX+number
	 MUL Ten          ;AX=AX*10
	 MOV number,AX
	 
	 MOV AX,0
	 
	  ; Read fourth digit
	  
	  ;scan character to AL
	 MOV AH,1
	 INT 21h
	 
	 MOV resultStr[5],AL  ;build the num as a string
	 
	 
	 ;check if one of the digits is illegal
	 ;illegal is digit>=0 && digit<=9
	 CMP resultStr[2],'1'
	 JB endprog
	 CMP resultStr[2],'9'
	 JA endprog
	 CMP resultStr[3],'0'
	 JB endprog
	 CMP resultStr[3],'9'
	 JA endprog
	 CMP resultStr[4],'0'
	 JB endprog
	 CMP resultStr[4],'9'
	 JA endprog
	 CMP resultStr[5],'0'
	 JB endprog
	 CMP resultStr[5],'9'
	 JA endprog
	  
	 SUB AL,'0'    ;convert to number 
	 MOV AH,0
	 ADD sumnum,AX ;sumnum=sumnum+AX 
	 
	 ;check if the sum of digits is 1
	 

	 ADD AX,number
	 MOV number,AX
	 
	 CMP sumnum,9
	 JBE onedDigit
	  
	  ;check if the division is a fractions
	 MOV DX,0
	 DIV sumnum ;dx:ax=dx=שארית
	            ;ax=שלם
	 CMP DL,0
     JNE notharshad

	 ;building the reVSumnum 
	 
     MOV AX,sumnum
	 MOV DX,0
	 DIV Ten
	 MOV reVSumnum,DX
	 MOV DX,AX
	 MOV AX, reVSumnum
	 MOV temp,DX
	 MUL Ten
	 ADD AX,temp
	  
	 MOV reVSumnum,AX 
	 MOV AX,number
	 MOV DX,0
	 DIV reVSumnum
	 

	 CMP DL,0
     JE spharshad
	 
     JMP harshad

;print notharshad to screen	 

onedDigit:
     MOV AX,number
	 MOV DX,0
     DIV sumnum
	 CMP DL,0
     JE spharshad
		
notharshad:
	 MOV DX,OFFSET NoharshadMsg
	 MOV AH,9
	 INT 21h
	 JMP endprog1

;print harshad to screen	 
	 
harshad:		
     MOV DX,OFFSET harshadMsg
	 MOV AH,9
	 INT 21h
	 JMP endprog1
	 
;print spharshad to screen
	 
spharshad:
     MOV DX,OFFSET harshadMsg
	 MOV AH,9
	 INT 21h
	 MOV DX,OFFSET SpharshadMsg
	 MOV AH,9
	 INT 21h
	 JMP endprog1	

;print error msg to screen	 
	 
endprog:
	 MOV DX,OFFSET errMsg
	 MOV AH,9
	 INT 21h
	 
 ;end of the program
 
endprog1:
	 MOV AH,4Ch
	 INT 21h
	 END