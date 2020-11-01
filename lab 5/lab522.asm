;lab5.asm (sign)

.MODEL SMALL
.STACK 100h
.DATA

;define variables

N   DW 11
Arr DW 1234h, 5678h, 0ff11h, 1111h, 2222h, 3333h, 4444h, 5555h, 6666h, 7777h, 8888h
Max DW 0
displayMaxsign DB 13,10, 'Max for sign array is:     ',13,10, '$'
displayMaxsignN DB 13,10, 'Max for sign array is:-   ',13,10, '$'
sixTeen  DW  16
result   DW  0
power    Dw  1
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
JG notswap
MOV AX,Arr[DI]
MOV Max,AX
notswap:
LOOP maximum

MOV DI,28
MOV CX, 4
;check if the number is negative or positive
CMP AX,0
JG convert

Negative:
NEG AX   ;two's complement if negative

;converts the number from hexadecimal to decimal
convert:
CWD
IDIV sixTeen 
MOV BX,AX
MOV AX,DX
CWD
IMUL power
ADD result,AX
MOV AX,power
;perform power of 16
CWD
IMUL sixTeen
MOV power,AX
MOV AX,BX
LOOP convert



CMP Max,0
JL displayNeg
;converts the the number to bits (and insert to display array)
;if the number is positive
displayPOS:
MOV AX,result
CWD
IDIV Ten
MOV result,AX
ADD DX,'0'
MOV displayMaxsign[DI],DL
DEC DI
CMP AX, 0
JNE displayPOS

;prints the display array
MOV AH,9
MOV DX,OFFSET displayMaxsign 
INT 21H 

JMP endlabel

;converts the the number to bits (and insert to display array)
;if the number is negative
displayNeg:

dispNegative:
MOV AX,result
CWD
IDIV Ten
MOV result,AX
ADD DX,'0'
MOV displayMaxsignN[DI],DL
DEC DI
CMP AX, 0
JNE dispNegative 

;prints the display array
MOV AH,9
MOV DX,OFFSET displayMaxsignN 
INT 21H

;end the program
endlabel:

MOV AH,4Ch
INT 21h

END