;lab9.asm
;extern void sum_col(int n, int m, long int *matrix[], long int new_col[])
;                     BP+6   BP+8   BP+10                 BP+14
.MODEL LARGE
.STACK 100h
.DATA
;defines variables
sum  DD 0
temp DW 0
four DW 4
num  DW 0
.CODE
.386
_sum_col PROC FAR
PUBLIC _sum_col

PUSH BP         ;save the register BP
MOV BP,SP       ;the BP register will point to the top of the stack
;save the registers in the stack
PUSH SI
PUSH DI
PUSH ES
PUSH FS
PUSH BX

MOV CX,word ptr[BP + 6]    ;CX=n
MOV DX,word ptr[BP + 8]    ;DX=m
MOV SI,word ptr [BP + 10]  ;SI=matrix off
MOV ES,word ptr [BP + 12]  ;ES=matrix seg

MOV DI,0
MOV temp,CX ;save the size of the columns

L1:
CMP DX,0 ;the loop ends if DX(m reaches 0)
JE next
MOV CX,temp ;initializing CX to n,m times
MOV sum,0

;calculates the sum of a coulmn
L2:
MOV BX,WORD PTR ES:[SI]  ;CX=m
MOV FS,WORD PTR ES:[SI+2]
MOV EAX,DWORD PTR FS:[BX+DI]
ADD sum,EAX
MOV EAX,sum
ADD SI,four
LOOP L2

MOV FS,[BP + 16] ;FS = new_col seg
MOV SI,[BP + 14] ;SI=new_col off
MOV BX,num
MOV FS:[SI+BX],EAX  ;move the sum of a coulmn to the new_col
ADD num,4
ADD DI, 4
MOV ES,WORD PTR[BP+12]    ;ES=matrix seg
MOV SI,WORD PTR[BP + 10]  ;SI=matrix off
DEC DX
JMP L1

next:
;pop registers from the stack
POP BX
POP FS
POP ES
POP DI
POP SI
POP BP

;end of procedure 
RET
_sum_col ENDP 
END