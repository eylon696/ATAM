; lab4.asm

.MODEL SMALL
.STACK 100h
.DATA

	
    ARR1 DB 4 DUP(0)
    ARR2 DB 4 DUP(0)
	N    DB 4
	Two  DW 2
	
.CODE
    MOV AX, @DATA
	MOV DS, AX
	
	MOV AX,0
	
	MOV AL,N
	MUL Two
	MOV ARR2[0],AL
	ADD AL,'0'
	MOV ARR1[0],AL
	
	MOV AX,0
	
	MOV AL,N
	DEC AL
	MUL Two
	MOV ARR2[1],AL
	ADD AL,'0'
	MOV ARR1[1],AL
	
	MOV AX,0
	
	MOV AL,N
	DEC AL
	DEC AL
	MUL Two
	MOV ARR2[2],AL
	ADD AL,'0'
	MOV ARR1[2],AL
	
	MOV AX,0
	
	MOV AL,N
	DEC AL
	DEC AL
	DEC AL
	MUL Two
	MOV ARR2[3],AL
	ADD AL,'0'
	MOV ARR1[3],AL

	MOV AH, 4Ch
	INT 21h
	END