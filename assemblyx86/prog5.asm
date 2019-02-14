; Comment block below must be filled out completely for each assignment
; *************************************************************
; Student Name:		Bruno Silva Ribeiro
; COMSC-260 Fall 2018
; Date:		10/24/2018
; Assignment #5
; Version of Visual Studio used (2015)(2017):	2017
; Did program compile? Y
; Did program produce correct results? Y
; Is code formatted correctly including indentation, spacing and vertical alignment? Y
; Is every line of code commented? Y
;
; Estimate of time in hours to complete assignment:		16 hours (6 hours used to start a program and realize that DspDword was not working, then I restarted)
;
; In a few words describe the main challenge in writing this program:	
;			- I had trouble to picture what I was trying to program, I also tried to start instructions from page 1
;                   but I learned that page 5 had the instructions to start
;
; Short description of what program does:
;			- the program will check 2 arrays of operands and an array of signs
;			- the program will grab each operand per index and perform the operation according to the sign
;			- the program will print the answer if there is no overflow
;			- the program will detect an overflow and print a message
;
; *************************************************************
; Reminder: each assignment should be the result of your
; individual effort with no collaboration with other students.
;
; Reminder: every line of code must be commented and formatted
; per the ProgramExpectations.pdf file on the class web site
;


;Example of using DspDword to print an unsigned decimal number to the console
;
;All data in an assembly program is stored in binary.
;To output to the console the digits must be converted from binary
;to characters.
;This means that the program has to convert for example 123 to '1' '2' '3'.
;DspDword performs this conversion.

.386                        ;identifies minimum CPU for this program

.MODEL flat,stdcall         ;flat - protected mode program
                            ;stdcall - enables calling of MS_windows programs

;allocate memory for stack
;(default stack size for 32 bit implementation is 1MB without .STACK directive 
;  - default works for most situations)

.STACK 4096                 ;allocate 4096 bytes (1000h) for stack

;*******************MACROS********************************

;*************mPrtStr macro****************
;mPrtStr
;usage: mPrtStr nameOfString
;ie to display a 0 terminated string named message say:
;mPrtStr message

;Macro definition of mPrtStr. Wherever mPrtStr appears in the code
;it will  be replaced with 

mPrtStr  MACRO  arg1                    ;arg1 is replaced by the name of string to be displayed
		 push   edx				        ;save edx
         mov    edx, offset arg1        ;address of str to display should be in edx
         call   WriteString             ;display 0 terminated string
         pop    edx				        ;restore edx
ENDM

;*************mPrtChar macro****************
;mPrtChar - used to print single characters
;usage: mPrtChar character
;ie to display a 'm' say:
;mPrtChar 'm'

mPrtChar MACRO  arg1                    ;arg1 is replaced by the name of character to be displayed
         push   eax                     ;save eax
         mov    al, arg1                ;character to display should be in al
         call   WriteChar               ;display character in al
         pop    eax                     ;restore eax
ENDM

;*************************PROTOTYPES*****************************

ExitProcess PROTO,
    dwExitCode:DWORD    ;from Win32 api not Irvine to exit to dos with exit code

ReadChar PROTO          ;Irvine code for getting a single char from keyboard
				        ;Character is stored in the al register.
			            ;Can be used to pause program execution until key is hit.

WriteChar PROTO         ;write the character in al to the console

WriteString PROTO		; write null-terminated string to output
                        ;EDX points to string
     
;************************  Constants  ***************************

    LF     equ           0Ah                ;ASCII Line Feed

    $parm1 EQU DWORD PTR [ebp + 8]          ;parameter 1
    $parm2 EQU DWORD PTR [ebp + 12]         ;parameter 2

;************************DATA SEGMENT***************************

.data

    ;use the following data for your program
    ;WARNING: do not display this file on a web page and then use copy and paste
    ;you must download this file by right clicking on the link
    ;then load it into visual studio and then copy the data 
    operand1    dword   -2147483600,-2147483648,-2147482612,-5, -2147483648,1062741823,2147483647,2147483547, 0, -94567 ,4352687,-2147483648,-249346713,-678, -2147483643,32125, -2147483648, -2147483648       ;array of values for operand1
    operators   byte    '-','-', '+','*','*', '*', '+', '%', '/',  '/', '+', '-','/', '%','-','*','/', '+'          ;array of values for signs
    operand2    dword   -200,545,12, 2, -8, 2, 10, -5635, 543,   383, 19786, 150,43981, 115,5,31185,365587,-10      ;array of values for operand2
    ARRAY_SIZE  equ     ($ - operand2)                                                                              ;size of array in bytes

    ;The ARRAY_SIZE constant should be defined immediately after the operand2 array otherwise the value contained in it will not be correct.

    ;Use the following messages if overflow is detected.
    ;Do not change the messages between the quotes.

    posOF       byte    "+++Positive Overflow Error+++",0                                                           ;message to print out for positive overflow
    negOF       byte    "---Negative Overflow Error---",0                                                           ;message to print out for negative overflow
    multOF      byte    "***Multiplication Overflow***",0                                                           ;message to print out for multiplication overflow
    equals      byte    " = ",0                                                                                     ;print equals
    titleMsg    byte    "Program 5 by Bruno Ribeiro",LF,LF,0                                                           ;Introduction message 

;************************CODE SEGMENT****************************

.code

Main PROC
    
    mPrtStr     titleMsg                ;prints intro message
    mov         ebx, 0                  ;zero counter for dword array
    mov         ecx, 0                  ;zero counter for byte array   

loopMain:                               ;begin of the loop

    cmp         ebx, ARRAY_SIZE         ;check to see if entire array has been checked by loop
    jae         endMain                 ;end if check above is true

    mov         eax, operand1[ebx]      ;set up the first operand to be printed on screen
    call        DspDword                ;print the number in eax
    mPrtChar    ' '                     ;space in between 

    mPrtChar    operators[ecx]          ;print operator from array
    mPrtChar    ' '                     ;space in between
    mov         eax, operand2[ebx]      ;set up the second operand to be printed on screen
    call        DspDword                ;print the number in eax

    mPrtStr     equals                  ;print equal sign with spaces around of it

    push        operand2[ebx]           ;push second operand to be used in function
    push        operand1[ebx]           ;push first operand to be used in function

    cmp         operators[ecx], '-'     ;compare the sign to call specific function
    je          subJump                 ;call function according to check above

    cmp         operators[ecx], '+'     ;compare the sign to call specific function
    je          addJump                 ;call function according to check above

    cmp         operators[ecx], '*'     ;compare the sign to call specific function
    je          mulJump                 ;call function according to check above

    jmp         divJump                 ;call function if all the checks above failed


subJump:

    call        doSub                   ;call doSub function
    ;check for overflow after subtraction
    cmp         operand1[ebx], 0        ;check if first operand was negative
    jg          printLoop               ;print value if check above is true
    cmp         operand2[ebx], 0        ;check if second operand was positive
    jl          printLoop               ;print value if check above is true
    or          eax, eax                ;set the flag as the sign of eax
    js          printLoop               ;print value if check above is negative
    mPrtStr     negOF                   ;print overflow message if all checks above failed
    jmp         printOver               ;jumps to finish the loop

addJump:
    call        doAdd                   ;call doAdd function

    cmp         operand1[ebx], 0        ;check if first operand was positive
    jl          addJump2                ;jumps to next check if true
    cmp         operand2[ebx], 0        ;check if first operand was positive
    jl          addJump2                ;jumps to next check if true
    or          eax, eax                ;set the flag as the sign of eax
    jns         addJump2                ;print value if check above is positive
    mPrtStr     posOF                   ;print overflow message if all checks above failed
    jmp         printOver               ;jumps to finish the loop

addJump2:
    
    cmp         operand1[ebx], 0        ;check if first operand was negative
    jg          printLoop               ;print value if check above is true
    cmp         operand2[ebx], 0        ;check if first operand was negative
    jg          printLoop               ;print value if check above is true
    or          eax, eax                ;set the flag as the sign of eax
    js          printLoop               ;print value if check above is negative
    mPrtStr     negOF                   ;print overflow message if all checks above failed
    jmp         printOver               ;jumps to finish the loop


mulJump:
    call        doMul                   ;call doMul function
    jno         printLoop               ;prints value if no overflow is detected
    mPrtStr     multOF                  ;print overflow message if all checks above failed
    jmp         printOver               ;jumps to finish the loop
    

divJump:
    call        doDiv                   ;call doMul function
    cmp         operators[ecx], '/'     ;decide which value to print according to sign
    je          printLoop               ;print eax if division sign
    mov         eax, edx                ;print edx value if % sign

printLoop:

    call        DspDword                ;print the number in eax

printOver:
    mPrtChar    LF                      ;jump to the next line
    add         ebx, 4                  ;add the counter for dword array
    add         ecx, 1                  ;add the counter for byte array
    jmp         loopMain                ;repeats the loop

endMain:                                ;jump here if loop is over
    call        ReadChar                ;pause execution
	INVOKE      ExitProcess,0           ;exit to dos: like C++ exit(0)
Main ENDP


;************** DspDword - display DWORD in decimal
;
;
;       ENTRY - eax contains unsigned number to display
;       EXIT  - none
;       REGS  - EAX,EBX,EDX,ESI,EFLAGS
;
;       To call DspDword: populate eax with number to print then call DspDword
;
;           mov  eax, 8954
;           call DspDword
;           
;
;       DspDword was originally written by Paul Lou and Gary Montante to display a
;       64 bit number and to use stack parameters.
;       It was modified to pass a parameter via register and to 
;       work with 32 bits and Irvine library by Fred Kennedy
;       FA18
;
;-------------- Input Parameters
        
    ;byte array beginning = ebp - 1
    ;ebp           ebp + 0
    ;ret address   ebp + 4
    

    ; 0FDCh | eax            [ebp - 28] <--ESP
    ; 0FE0h | edx            [ebp - 24]
    ; 0FE4h | ebx            [ebp - 20]
    ; 0FE8h | esi            [ebp - 16]
    ; 0FECh |  ?             [ebp - 12]
    ; 0FEDh |  ?             [ebp - 11]
    ; 0FEEh | '0'            [ebp - 10]
    ; 0FEFh | '0'            [ebp - 9]
    ; 0FF0h | '0'            [ebp - 8]
    ; 0FF1h | '0'            [ebp - 7]
    ; 0FF2h | '0'            [ebp - 6]
    ; 0FF3h | '0'            [ebp - 5]
    ; 0FF4h | '8'            [ebp - 4]
    ; 0FF5h | '9'            [ebp - 3]
    ; 0FF6h | '5'            [ebp - 2]
    ; 0FF7h | '4'            [ebp - 1]
    ; 0FF8h | ebp            [ebp + 0]  <--EBP
    ; 0FFCh | return address [ebp + 4]
    ; 1000h | 




    ;digits are peeled off and put on stack in reverse order (right to left)
    
DspDword proc
    push    ebp                     ;save ebp to stack
    mov     ebp,esp                 ;save stack pointer
    sub     esp,12                  ;allocate 12 bytes for byte array
                                    ;note: must be an increment of 4
                                    ;otherwise WriteChar will  not work
    push    esi                     ;save esi to stack
    push    ebx                     ;save ebx to stack
    push    edx                     ;save edx to stack
    push    eax                     ;save eax to stack

    mov     esi,-1                  ;esi = offset of beginning of byte array from ebp 
    mov 	ebx,10                  ;ebx = divisor for peeling off decimal digits

    or      eax, eax                ;checks sign of eax and sets the flag
    jns     next_digit              ;jmp if not signed
    mPrtChar '-'                    ;print negative
    neg     eax                     ;perform 2's complement to reverse number to original
    

;each time through loop peel off one digit (division by 10),
;(the digit peeled off is the remainder after division by 10)
;convert the digit to ascii and store the digit on the stack
;in reverse order: 8954 stored as 4598
next_digit:

    mov      edx,0                  ; before edx:eax / 10, set edx to 0 
    div      ebx                    ; eax = quotient = dividend shifted right
                                    ; edx = remainder = digit to print.
                                    ; next time through loop quotient becomes
                                    ; new dividend.
    add      dl,'0'                 ; convert digit to ascii character: i.e. 1 becomes '1'
    mov      [ebp+esi],dl           ; Save converted digit to buffer on stack
    dec      esi                    ; Move down in stack to next digit position
    cmp      esi, -10               ; only process 10 digits
    jge      next_digit             ; repeat until 10 digits on stack
                                    ; since working with a signed number, use jge not jae

    inc      esi                    ; when above loop ends we have gone 1 byte too far
                                    ; so back up one byte

;loop to display all digits stored in byte array on stack
DISPLAY_NEXT_DIGIT:      
    cmp      esi,-1                 ; are we done processing digits?
    jg       DONE10                 ; repeat loop as long as esi <= -1
    mPrtChar byte ptr[ebp+esi]      ; print digit
    inc      esi                    ; esi = esi + 1: if esi = -10 then esi + 1 = -9
    jmp      DISPLAY_NEXT_DIGIT     ; repeat
DONE10:
    
    pop      eax                    ; eax restored to original value
    pop      edx                    ; edx restored to original value
    pop      ebx                    ; ebx restored to original value
    pop      esi                    ; esi restored to original value

    mov      esp,ebp                ;restore stack pointer which removes local byte array
    pop      ebp                    ;restore ebp to original value
    ret                             ;restore address on stack
DspDword endp

;************** doAdd - dword addition
;
; ENTRY – operand 1 and operand 2 are on the stack
;
; EXIT - EAX = result (operand 1 + operand 2) (any carry is ignored so the answer must fit in 32 bits)
; REGS - List registers changed in this function
;
; note: Before calling doAdd push operand 2 onto the stack and then push operand 1.
;
;
; to call doAdd in main function:
; push 5 ;32 bit operand2
; push 3 ;32 bit operand1
; call doAdd ;3 + 5 = 8 (answer in eax)
;
; Remove parameters by using ret 8 rather than just ret at the end of this function
;
;--------------
;Add operand1 to operand2 and store the answer in EAX
;Note: any carry is ignored so the answer must fit in 32 bits
;Note you must keep the operands in the correct order: op1+op2 not op2+op1.


doAdd proc

    push	ebp	                ;Save original value of EBP on stack
	mov	    ebp,esp	            ;EBP= address of original EBP on stack (00f8)
			                    ; Aim at a fixed location on the stack so
			                    ;   we can access other stack locations
                                ;   relative to this location!

    ;brackets [ ] below are needed to dereference the address
    ;this is like *ptr in C++
    mov     eax, $parm1         ; mov first parameter into eax
    add     eax, $parm2         ; add second to first eax = parm1 + parm2

  
	pop     ebp                 ;restore ebp

    ret     8                   ;option for removing 2 dword parameters from stack
                                ;can use this instead of add esp, 8 in main

doAdd endp



;************** doMult - signed dword multiplication
;
; ENTRY - operand 1 and operand 2 are on the stack
;
; EXIT - EDX:EAX = result (operand 1 * operand 2)
; (for this assignment the product is assumed to fit in EAX and EDX is ignored)
;
; REGS - List registers changed in this function
;
; note: Before calling doMult push operand 2 onto the stack and then push operand 1.
;
; to call doMult in main function:
; push 3 ;32 bit operand2
; push 2 ;32 bit operand1
; call doMult ; 2 * 3 = 6 (answer in eax)
;
; Remove parameters by using ret 8 rather than just ret at the end of this function
;--------------
;Take operand1 times operand2 using signed multiplication and the result is returned in EDX:EAX.
;Note: this function does signed multiplication not unsigned. See imul.asm on the class web site.
;Only use the single operand version of imul.
;Please note that this program assumes the product fits in EAX. If part of the produce is in EDX, it is ignored.
;Note you must keep the operands in the correct order: op1*op2 not op2*op1.

doMul proc

    push	ebp	                ;Save original value of EBP on stack
	mov	    ebp,esp	            ;EBP= address of original EBP on stack (00f8)
			                    ; Aim at a fixed location on the stack so
			                    ;   we can access other stack locations
                                ;   relative to this location!

    ;brackets [ ] below are needed to dereference the address
    ;this is like *ptr in C++
    mov     eax, $parm1         ; move first parameter into eax
    imul    $parm2              ; mul second to first eax = parm1 * parm2


	pop     ebp                 ;restore ebp

    ret     8                   ;removing 2 dword parameters from stack

doMul endp

;************** doDiv - signed dword / dword division
;
; ENTRY - operand 1(dividend) and operand 2(divisor) are on the stack
;
; EXIT - EAX = quotient
; EDX = remainder
; REGS - List registers changed in this function
;
; note: Before calling doDiv push operand 2(divisor) onto the stack and then push operand 1(dividend).
;
; to call doDiv in main function:
; push 4 ;32 bit operand2 (Divisor)
; push 13 ;32 bit operand1 (Dividend)
; call doDiv ;13/ 4 = 3 R1 (3 = quotient in eax, 1 = remainder in edx )
;
; Remove parameters by using ret 8 rather than just ret at the end of this function
;--------------
;Take operand1 /operand 2 and the quotient is returned in EAX and the
; remainder is returned in EDX.
;doDiv does signed division. See idiv.asm on the class web site.
;Note: since we are doing signed division you should sign extend parameter 1 into edx using CDQ instead of zeroing out edx
;Note: after calling doDiv for the modulus operation (%) look at the value that is returned in edx which is the remainder. doDiv does not process the modulus operator. 

doDiv proc

    push	ebp	                ;Save original value of EBP on stack
	mov	    ebp,esp	            ;EBP= address of original EBP on stack (00f8)
			                    ; Aim at a fixed location on the stack so
			                    ;   we can access other stack locations
                                ;   relative to this location!

    ;brackets [ ] below are needed to dereference the address
    ;this is like *ptr in C++
    mov     eax, $parm1         ; move first parameter into eax
    cdq                         ; EDX = FFFFFFFF (sign extend eax into edx)
    idiv    $parm2              ; div second to first eax = parm1 / parm2

	pop     ebp                 ;restore ebp
    ret     8                   ;removing 2 dword parameters from stack
                                

doDiv endp

;************** doSub - dword subtraction
;
; ENTRY - operand 1 and operand 2 are pushed on the stack
;
; EXIT -EAX = result (operand 1 - operand 2)
; REGS - List registers changed in this function
;
; note: Before calling doSub push operand 2 onto the stack and then push operand 1.
;
; to call doSub in main function:
; push 5 ;32 bit operand2
; push 7 ;32 bit operand1
; call doSub ;7 – 5 = 2 (answer in eax)
;
; Remove parameters by using ret 8 rather than just ret at the end of this function
;--------------
;The same circuits can be used for addition and subtraction because negative numbers are stored in 2’s complement form
;You can do a subtraction by doing a twos complement and then addition.
;To prove that this is true do not use the sub instruction in doSub but use the following method to do the subtraction:
; do a two’s complement (neg instruction) on operand 2 then add operand 1 + operand 2 and store the answer in EAX.

doSub proc

    push	ebp	                ;Save original value of EBP on stack
	mov	    ebp,esp	            ;EBP= address of original EBP on stack (00f8)
			                    ; Aim at a fixed location on the stack so
			                    ;   we can access other stack locations
                                ;   relative to this location!

    ;brackets [ ] below are needed to dereference the address
    ;this is like *ptr in C++
    mov     eax, $parm1         ; saves parm1 to eax
    neg     $parm2              ; 2's complement on parm2
    add     eax, $parm2         ; sub second to first eax = parm1 - parm2

	pop     ebp                 ;restore ebp

    ret     8                   ;removing 2 dword parameters from stack

doSub endp

END Main