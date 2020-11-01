;targ1.asm

    .MODEL SMALL
    .STACK 100h
    .DATA
	
Ten        DW 10
Two        DW 2
Num        DW 0
Denom      DW 0
result     DW 0 

PromptStr DB ,13,10,'Enter first number 3 digits with leading zeros, if need be:',13,10,'$'
SecondStr DB ,13,10,'Enter second number 2 digits with leading zero, if need be:' ,13,10, '$'
resultStr DB ,13,10,'Round(xxx / xx) = XXX',13,10,'$'
zeroStr   DB ,13,10, 'Cannot divide by zero' ,13,10, '$'
errorMsg    DB ,13,10, 'Wrong input',13,10,'$'


                            ;
     .CODE
	 .386
     MOV AX,@DATA   ; DS can be written to only through a register
     MOV DS,AX      ; Set DS to point to data segment
	 
     MOV AH,9       ; Set print option for int 21h
     MOV DX,OFFSET PromptStr  ;  Set  DS:DX to point to PromptString
     INT 21h                ;  Print PromptString
	 
	 MOV AH,1
	 INT 21h
	 
	 
	 	 ; Read first digit
	 MOV resultStr[9],AL
	 SUB AL,'0' ;convert to number 
	 MOV AH,0
	 MUL Ten ;AX=AX*10
	 MOV Num,AX
	 MOV AX,0
	 
	  ; Read second digit
	  
	 MOV AH,1
	 INT 21h
	  
	 MOV resultStr[10],AL 
	 SUB AL,'0';convert to number 
	 MOV AH,0
	 ADD AX,Num
	 MUL Ten ;AX=AX*10
	 MOV Num,AX
	 
	 MOV AX,0
	 
	 ; Read third digit
	 
	 MOV AH,1
	 INT 21h
	 
	 MOV resultStr[11],AL
	 SUB AL,'0';convert to number 
	 MOV AH,0
	 ADD AX,Num
	 MOV Num,AX
	 
	
	 MOV AH,9       ; Set print option for int 21h
     MOV DX,OFFSET SecondStr  ;  Set  DS:DX to point to SecondStr
     INT 21h                ;  Print SecondStr
	 
	 ; Read first digit
	 MOV AH,1
	 INT 21h	  
	  
	 MOV resultStr[15],AL 
	 SUB AL,'0' ;convert to number 
	 MOV AH,0
	 MUL Ten ;AX=AX*10
	 MOV Denom,AX
	 MOV AX,0
	 
	 ; Read second digit
	 MOV AH,1
	 INT 21h
	 
	 MOV resultStr[16],AL
	 SUB AL,'0';convert to number 
	 MOV AH,0
	 ADD AX,Denom
	 MOV Denom,AX
	 
	 ;check if the digits are number and not characters
	 
	 CMP resultStr[9],'0'
	 JB errMsg
	 CMP resultStr[9],'9'
	 JA errMsg
	 CMP resultStr[10],'0'
	 JB errMsg
	 CMP resultStr[10],'9'
	 JA errMsg
	 CMP resultStr[11],'0'
	 JB errMsg
	 CMP resultStr[11],'9'
	 JA errMsg
	 CMP resultStr[15],'0'
	 JB errMsg
	 CMP resultStr[15],'9'
	 JA errMsg
	 CMP resultStr[16],'0'
	 JB errMsg
	 CMP resultStr[16],'9'
	 JA errMsg
	 
	 ;check if the denom is zero
	 
	 CMP denom,0
	 JE zero
	 
	 MOV AX, Num
     DIV Denom 	 
	 
	 MOV result,AX
	 MOV AX,DX
	 MUL Two
	 CMP AX,Denom
	 JGE Roundup
	 
	 MOV AX,result
	 JMP endprog
	 
Roundup:
     MOV AX,result
	 INC AX
	 MOV result,AX
	 JMP endprog
zero:	 
	  
	 MOV AH,9       ; Set print option for int 21h
     MOV DX,OFFSET zeroStr  ;  Set  DS:DX to point to zeroStr
     INT 21h  
	 JMP endlabel
	 
errMsg:
	 MOV AH,9       ; Set print option for int 21h
     MOV DX,OFFSET errorMsg  ;  Set  DS:DX to point to errorMsg
     INT 21h  
	 JMP endlabel
	 
endprog:
	 MOV DX,0
	 DIV Ten
	 ADD DX,'0'
	 MOV resultStr[23],DL
	 MOV DX,0
	 DIV Ten
	 ADD DX,'0'
	 MOV resultStr[22],DL
	 MOV DX,0
	 DIV Ten
	 ADD DX,'0'
	 MOV resultStr[21],DL
	 
     MOV AH,9       ; Set print option for int 21h
     MOV DX,OFFSET resultStr  ;  Set  DS:DX to point to resultStr
     INT 21h  
	 
endlabel:
	 MOV AH,4ch       ; Set print option for int 21h
     INT 21h 
	 
	 END
	 
	 
	 
	 
	 
	 
	 