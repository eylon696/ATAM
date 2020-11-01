;lab12.asm
;double find_delta1(double (*f)(double),double x0, double eps)
;                          BP+4           BP+6        BP+14  
;extern find_delta2(double (*f)(double),double x1, double x2,double h, double eps)
;                             BP+4           BP+6     BP+14    BP+22    BP+30 

.MODEL SMALL
.STACK 100h
.DATA

delta  DQ 0
two    DQ 2.0
X      DQ ?
temp   DQ ?
num    DW 0
i      DW 0
mindel DQ ?


.CODE
.386
.387
_find_delta1 PROC NEAR
PUBLIC _find_delta1
;save registers
PUSH BP
MOV BP,SP

FLD QWORD PTR [BP+6] ;st(0)=x0
FABS                 ;ABS(st(0)=x0)
FSTP delta           ;delta=x0,st(0)=empty
L1:
FLD delta            ;st(0)=delta
FDIV two             ;st(0)=delta/2.0
FST delta            ;delta=delta/2, st(0) = empty
FLD QWORD PTR [BP+6] ;st(0)=x0,st(1)=delta/2
FADD                 ;st(0)=x0+(delta/2), st(1)= empty
FSTP X               ;X=x0+(delta/2),st(0)= empty

PUSH X                  
CALL [BP+4]           ;st(0)=f(x)
POP temp
PUSH QWORD PTR [BP+6]
CALL [BP+4]           ;st(0)=f(x0),st(1)=f(x)
POP temp
FSUB                 ;st(0)=f(x)-f(x0),st(1)=empty
FABS                 ;ABS(st(0))
FLD QWORD PTR [BP+14];ST(0)= eps, st(1)=|f(x)-f(x0)|
FCOMPP               ;eps -|f(x)-f(x0)|
FSTSW AX
SAHF
JA end1
JMP L1

end1:
FLD delta            ;st(0)=delta
POP BP

RET
_find_delta1 ENDP


_find_delta2 PROC NEAR
PUBLIC _find_delta2
;save registers
PUSH BP
MOV BP,SP
FSTP temp            ;st(0)=empty
L2:
FLD QWORD PTR [BP+22] ;st(0)=h
FIMUL num             ;st(0)num*h , st(1)=empty
FLD QWORD PTR [BP+6]  ;st(0)=x1 ,st(1)=num*h
FADD                  ;st(0)=x1+(num*h) , st(1)=empty
FCOM QWORD PTR [BP+14];x1+(num*h)-x2
FSTSW AX
SAHF
JA end2
FSTP temp             ;temp=st(0)=x1+(num*h) , st(0)=empty
PUSH QWORD PTR [BP+30]
PUSH QWORD PTR temp
PUSH WORD  PTR [BP+4]
CALL _find_delta1     ;st(0)=delta, st(1)=empty
ADD SP,18
MOV AX,i
CMP AX,0
JE firsti
INC num
INC i
FCOM mindel           ;detla-mindelta
FSTSW AX
SAHF
JA L2
FSTP mindel          ;mindelta=delta , st(0)=empty
JMP L2
firsti:
FSTP mindel          ;mindel=delta , st(0)=empty
INC i
INC num
JMP L2

end2:
FSTP temp
FLD mindel

POP BP
RET
_find_delta2 ENDP
END