;targ2.asm


.MODEL SMALL
.STACK 100h
.DATA

;define variables

Z          DD  0 
Ten        DD 10
Two        DD  2
Strprompt DB 'Enter number between -65535 and  65535 :',13,10, '$'
StrNum     DB '      $' 
Nodiv      DB 'has no solution below 1000$'
strz       DB 'z = $'
strDiv     DB ',x =      ,y =       ','$' 
sign       DB  ' $'
X          DD  0 
Y          DD  0
DIV1       DD  0
DIV2       DD  0
resx       DD  0
resy       DD  0

.CODE
.386
MOV AX,@DATA
MOV DS,AX

;prints Strprompt
MOV AH,9
MOV DX,OFFSET Strprompt
INT 21h

;scan character
MOV AH,1
INT 21h

;check if the number is positive or negative
MOV DI,0
MOV sign[0],AL
CMP AL,'-'
JNE Posnumber

;put the '-' sign in the StrNum string 
Negnumber:
MOV StrNum[DI],AL
MOV AH,1
INT 21h
INC DI

;builds the StrNum string and the number itself
Posnumber:
CMP AL,13   ;if the user typed enter
JE next
MOV StrNum[DI],AL
MOV AH,0
SUB EAX,'0'
ADD Z,EAX
MOV EAX,Z
MUL Ten
MOV Z,EAX
INC DI
MOV AH,1
INT 21h
JMP Posnumber

;divides the number in ten 
next:
MOV EDX,0
MOV EAX,Z
DIV Ten
MOV Z,EAX

;finds the dividers
MOV ECX,0
Dividers:
MOV EAX,Z
INC ECX
MOV EDX,0
DIV ECX
CMP ECX,Z
JE end1
CMP EDX,0
JNE Dividers

;calculating X and Y
MOV DIV1,EAX
MOV DIV2,ECX
ADD EAX,ECX
MOV EDX,0
DIV Two
CMP EDX,0
JNE Dividers

MOV X,EAX
SUB EAX,DIV2
MOV Y,EAX

;checking if X and Y are lower than 1000
CMP EAX,1000
JA Dividers
MOV EAX,X
CMP EAX,1000
JA Dividers

;check if the equation is correct 
MOV EAX,X
MUL X
MOV resx,EAX
MOV EAX,Y
MUL Y
MOV resy,EAX
SUB resx,EAX
MOV EAX,resx
CMP EAX,Z
JNE Dividers

;check if the number is negative or positive 
MOV AL,sign[0]
CMP AL,'-'
JNE disPos

MOV DI,9
MOV EAX,Y
;converts number to a string
convertNegY:
MOV EDX,0
DIV Ten
ADD EDX,'0'
MOV strDiv[DI],DL 
DEC DI
CMP EAX,0
JNE convertNegY
MOV DI,18
MOV EAX,X
convertNegX:
MOV EDX,0
DIV Ten
ADD EDX,'0'
MOV strDiv[DI],DL 
DEC DI
CMP EAX,0
JNE convertNegX

disPneg:
;prints strz
MOV AH,9
MOV DX,OFFSET strz
INT 21h

;prints StrNum
MOV AH,9
MOV DX,OFFSET StrNum
INT 21h
;prints strDiv
MOV AH,9
MOV DX,OFFSET strDiv
INT 21h

JMP endlabel

disPos:

MOV DI,9
MOV EAX,X
;converts number to a string
convertX:
MOV EDX,0
DIV Ten
ADD EDX,'0'
MOV strDiv[DI],DL 
DEC DI
CMP EAX,0
JNE convertX
MOV DI,18
MOV EAX,Y
convertY:
MOV EDX,0
DIV Ten
ADD EDX,'0'
MOV strDiv[DI],DL 
DEC DI
CMP EAX,0
JNE convertY

;prints strz
MOV AH,9
MOV DX,OFFSET strz
INT 21h
;prints StrNum
MOV AH,9
MOV DX,OFFSET StrNum
INT 21h
;prints strDiv
MOV AH,9
MOV DX,OFFSET strDiv
INT 21h

JMP endlabel

end1:
;prints StrNum
MOV AH,9
MOV DX,OFFSET StrNum
INT 21h
;prints Nodiv
MOV AH,9
MOV DX,OFFSET Nodiv
INT 21h

;end program
endlabel:
MOV AH,4Ch
INT 21h
END