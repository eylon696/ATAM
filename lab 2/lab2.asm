;
;  hello1a.asm - send message 'Hello World!' to the screen.
;
    .MODEL SMALL
    .STACK 100h
    .DATA
	
DisplayString DB 'Please enter your grade:',13,10,'$'
DisplayGradeA DB 'Very Good',13,10,'$'
DisplayGradeB DB 'Good',13,10,'$'
DisplayGradeC DB 'Not Good',13,10,'$'
DisplayGradeF DB 'Very Bad. You Failed',13,10,'$'   
errorMsg DB ,13,10,'input Error',13,10,'$'
                         
     .CODE

     MOV AX,@DATA     ; DS can be written to only through a register
     MOV DS,AX        ; Set DS to point to data segment
     MOV AH,9         ; Set print option for int 21h
     MOV DX,OFFSET DisplayString  ;  Set  DS:DX to point to DisplayString
     INT 21h                ;  Print DisplayString
	 
     MOV AH,1                  ; DOS get character function #
     INT 21h                   ; Get a single character from keyboard
	
	 CMP AL,'A'                ; AL has input. Compare with 'A'
     JE  gradeA                ; If AL = 'A' then go to gradeA
     CMP AL,'B'                ; Compare with 'B'
     JE  gradeB                ; If AL = 'B' then go to gradeB
	 CMP AL,'C'
     JE  gradeC	 
	 CMP AL,'F'
	 JE  gradeF
	 
	 MOV  DX,OFFSET errorMsg
	 JMP  DisplayGrades
	 
gradeA:	 
     MOV DX,OFFSET DisplayGradeA
	 JMP DisplayGrades
gradeB:	 
     MOV DX,OFFSET DisplayGradeB
	 JMP DisplayGrades
gradeC:	 
     MOV DX,OFFSET DisplayGradeC
	 JMP DisplayGrades
gradeF:	 
     MOV DX,OFFSET DisplayGradeF
	 JMP DisplayGrades	 
	 
DisplayGrades:
	 MOV AH,9                         ; Set print option for int 21h
     INT 21h                          ; Print  chosen message
	 
     MOV AH,4Ch       ; Set terminate option for int 21h
     INT 21h       ; Return to DOS (terminate program)
     END 