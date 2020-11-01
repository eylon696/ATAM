;lab11a.asm
;extern float vector_length(float arr[], int n);
;                           BP+4         BP+6

.MODEL SMALL
.STACK 100h
.DATA

.CODE
.386
.387 

_vector_length PROC NEAR
PUBLIC _vector_length

;save registers
PUSH BP
MOV BP,SP
PUSH DI

MOV DI,[BP+4] ;DI = arr
MOV CX,[BP+6] ;CX = n
FLDZ ;ST(0)=0
;LOOP L1 - sum of num in power of 2
L1:
FLD DWORD PTR [DI];ST(0)=[DI]
FLD DWORD PTR [DI];ST(1)=[DI]
FMUL;ST(0)=ST(0)*ST(1)
FADD;ST(0)=ST(0)+ST(1)
ADD DI,4
LOOP L1

FSQRT ;st(0)=sqrt(st(0))

POP DI
POP BP

RET
_vector_length ENDP
END