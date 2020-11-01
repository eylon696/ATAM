;lab6.asm

.MODEL SMALL
.STACK 100h
.DATA

;define variables

StrPost   DB 'Enter a postfix expression:',13,10,'$'
num1      DW ?
num2      DW ?
res       DW 0
resultStr DB ,13,10,'      ',13,10,'$'
Ten       DW 10

.CODE

MOV AX,@DATA
MOV DS,AX

;prints StrPost
MOV AH,9
MOV DX,OFFSET StrPost
INT 21h

MOV DI,7
;scan numbers and operators and placing the numbers in a stack
scan:
MOV AH,1
INT 21h
CMP AL,13
JE next
CMP AL,' '
JE scan
CMP AL,'/'
JE stackpopdiv
CMP AL,'*'
JE stackpopmul
CMP AL,'-'
JE stackpopsub
CMP AL,'+'
JE stackpopadd
MOV AH,0
SUB AL,'0'
PUSH AX
JMP scan

;perform division between two numbers
stackpopdiv:
POP num1
POP num2
MOV AX,num2
MOV DX,0
DIV num1
PUSH AX
JMP scan
;perform multiplication between two numbers
stackpopmul:
POP num1
POP num2
MOV AX,num1
MUL num2
PUSH AX
JMP scan
;perform subtraction between two numbers
stackpopsub:
MOV AX,0
POP num1
POP num2
MOV AX,num1
SUB num2,AX
PUSH num2
JMP scan
;perform addition between two numbers
stackpopadd:
MOV AX,0
POP num1
POP num2
MOV AX,num1
ADD AX,num2
PUSH AX
JMP scan

;pop the value from the stack to AX
next:
POP AX 
;a loop that builds the number in a string 
next1:
MOV DX,0
DIV Ten
ADD DX,'0'
MOV resultStr[DI],DL
DEC DI
CMP AX,0
JNE next1

;prints resultStr
MOV AH,9
MOV DX,OFFSET resultStr
INT 21h

;end program
MOV AH,4Ch
INT 21h
END