;lab4 targil 2

.MODEL SMALL
.STACK 100h
.DATA


ARR1  DD  25,15,20,30 
ARR2  DD 4 DUP(?)
Eight DD 8
Four  DD 4
Ten   DD 10 
Avg   DD 0
temp  DD 0

displayAvgDig DB 'The right digit of the avg is : x' ,13,10, '$'
displayOnes DB 'The Ones digit of ARR2[3] is : x' ,13,10, '$'

.CODE
.386

    MOV AX,@DATA
	MOV DS,AX
	
	
	MOV EDX,0
	MOV EAX, ARR1[12]
	MOV temp , EAX
	MUL temp ;eax=eax*30
	MUL temp ;eax=eax*30
	MOV ARR2[0],EAX
	
	MOV EDX,0
	MOV EAX,ARR1[8]
	MOV temp,EAX
	MUL temp ;eax=eax*eax
	MUL temp ;eax=eax*eax
	MOV ARR2[4],EAX
	
	MOV EDX,0
	MOV EAX,ARR1[4]
	MOV temp , EAX
	MUL temp ;eax=eax*eax
	MUL temp ;eax=eax*eax
	MOV ARR2[8],EAX
	
	MOV EDX,0
	MOV EAX,ARR1[0]
	MOV temp , EAX
	MUL temp ;eax=eax*eax
	MUL temp ;eax=eax*eax
	MOV ARR2[12],EAX
	
	MOV EAX,ARR2[0]
	MOV EDX,0
	DIV Eight
	MOV ARR2[0],EAX
	
	MOV EAX,ARR2[4]
	MOV EDX,0
	DIV Eight
	MOV ARR2[4],EAX
	
	
	MOV EAX,ARR2[8]
	MOV EDX,0
	DIV Eight
	MOV ARR2[8],EAX
	
	MOV EAX,ARR2[12]
	MOV EDX,0
	DIV Eight
	MOV ARR2[12],EAX
	
	MOV EAX,ARR2[0]
	MOV Avg,EAX
	
	MOV EAX,ARR2[4]
	ADD Avg,EAX
	
	MOV EAX,ARR2[8]
	ADD Avg,EAX
	
	MOV EAX,ARR2[12]
	ADD Avg,EAX
	
	MOV EAX,Avg
	MOV EDX,0
	DIV Four
	MOV Avg,EAX
	
	MOV EDX,0
	DIV Ten
	MOV Avg,EDX
	
	ADD DL,'0'
	MOV displayAvgDig[32], DL
	MOV AH,9
	MOV DX,OFFSET displayAvgDig
	INT 21h
	
	MOV EAX,temp
	MOV EDX, 0
	DIV Ten
	ADD DL,'0'
	MOV displayOnes[31], DL
	MOV AH,9
	MOV DX,OFFSET displayOnes
	INT 21h
	
	
	MOV AH,4Ch
	INT 21h
	
	END
	
