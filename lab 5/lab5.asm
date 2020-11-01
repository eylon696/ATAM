;lab5.asm (unsign)

.MODEL SMALL
.STACK 100h
.DATA

;define variables

N   DW 11
Arr DW 1234h, 5678h, 0ff11h, 1111h, 2222h, 3333h, 4444h, 5555h, 6666h, 7777h, 8888h
Max DW 0
displayMaxunsign DB 13,10, 'Max for unsign array is:     ',13,10, '$'
sixTeen  DW  16
result   DW  0
power    DW  1
Ten      DW 10


.CODE
.386

MOV AX,@DATA
MOV DS,AX

;find the maximum number in the array

MOV DI,0
MOV AX,Arr[DI]


MOV CX,N
DEC CX
maximum:
ADD DI, 2
CMP AX,Arr[DI]
JA notswap
MOV AX,Arr[DI]
MOV Max,AX
notswap:
LOOP maximum

;converts the number from hexadecimal to decimal

MOV CX, 4
convert:
MOV DX,0
DIV sixTeen 
MOV BX,AX
MOV AX,DX
MOV DX,0
MUL power
ADD result,AX
;perform power of 16
MOV AX,power
MUL sixTeen
MOV power,AX
MOV AX,BX
LOOP convert

;converts the the number to bits (and insert to display array)

MOV DI,30
con:
MOV AX,result
MOV DX,0
DIV Ten
MOV result,AX
ADD DX,'0'
MOV displayMaxunsign[DI],DL
DEC DI
CMP AX, 0
JNE con 

;prints the display array
MOV AH,9
MOV DX,OFFSET displayMaxunsign
INT 21H

;end the program
MOV AH,4Ch
INT 21h

END


