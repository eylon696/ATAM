;lab8
;HardEven(arr1, arr2, N);
;         BP+4, BP+6, BP+8

.MODEL SMALL
.STACK 100h
.DATA

;defines variables
COUNTER DW 0
TEN     DW 10

.CODE
_HardEven PROC NEAR
PUBLIC _HardEven
PUSH BP         ;save the register BP
MOV BP,SP       ;the BP register will point to the top of the stack

PUSH DI         ;save the register DI
MOV DI,[BP+4]   ;DI = &arr1[0]
PUSH SI         ;save the register DI
MOV SI,[BP+6]   ;SI = &arr2[0]
MOV CX,[BP+8]   ;CX = size
MOV COUNTER, 0  ;Initialization of the variable COUNTER

;A loop within a loop that takes a number and checks if 
;each digit is a parity digit if all the digits are a parity 
; the counter increases by 1

L1:
MOV AX,[DI]
L2:
CWD
IDIV TEN
TEST DX,1
JNZ next
CMP AX,0
JNE L2
INC COUNTER
MOV AX,[DI]
MOV [SI],AX
ADD SI,2
next:
ADD DI,2
LOOP L1

MOV AX,COUNTER

;pop registers from the stack
POP SI
POP DI
POP BP

;end of procedure 
RET
_HardEven ENDP 
END

