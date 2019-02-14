; Comment block below must be filled out completely for each assignment
; *************************************************************
; Student Name:		Bruno Silva Ribeiro
; COMSC-260 Fall 2018
; Date:		11/05/2018
; Assignment #6
; Version of Visual Studio used (2015)(2017):	2017
; Did program compile? Y
; Did program produce correct results? Y
; Is code formatted correctly including indentation, spacing and vertical alignment? Y
; Is every line of code commented? Y
;
; Estimate of time in hours to complete assignment:     I spent 3 days in this program 
;
; In a few words describe the main challenge in writing this program:	
;			- Maybe before starting these programs I should visualize what I am trying to accomplish before starting
;           - Rewriting code is the main problem
;
; Short description of what program does:
;			- program will perform a shifter using 3 different inputs a a single binary 
;			- program will print a number in binary by printing each different character DspBin
;			- program will shift a binary number with DoRightShift
;			- DoRightShift can be controlled with on off switch in case the coder want to shift or not
;
; *************************************************************
; Reminder: each assignment should be the result of your
; individual effort with no collaboration with other students.
;
; Reminder: every line of code must be commented and formatted
; per the ProgramExpectations.pdf file on the class web site
;

.386                            ;identifies minimum CPU for this program

.MODEL flat,stdcall             ;flat - protected mode program
                                ;stdcall - enables calling of MS_windows programs

;allocate memory for stack
;(default stack size for 32 bit implementation is 1MB without .STACK directive 
;  - default works for most situations)

.STACK 4096                     ;allocate 4096 bytes (1000h) for stack

mPrtChar  MACRO  arg1           ;arg1 is replaced by the name of character to be displayed
         push eax               ;save eax
         mov al, arg1           ;character to display should be in al
         call WriteChar         ;display character in al
         pop eax                ;restore eax
ENDM


mPrtStr macro   arg1            ;arg1 is replaced by the name of character to be displayed
         push edx               ;save eax
         mov edx, offset arg1   ;character to display should be in al
         call WriteString       ;display character in al
         pop edx                ;restore eax
ENDM

;*************************PROTOTYPES*****************************

ExitProcess PROTO,
    dwExitCode:DWORD    ;from Win32 api not Irvine to exit to dos with exit code

ReadChar PROTO          ;Irvine code for getting a single char from keyboard
				        ;Character is stored in the al register.
			            ;Can be used to pause program execution until key is hit.

WriteChar PROTO         ;Irvine code to write character stored in al to console

WriteDec PROTO          ;Irvine code to write number stored in eax
                        ;to console in decimal

WriteString PROTO		; write null-terminated string to output
                        ;EDX points to string

;************************  Constants  ***************************

    LF     equ           0Ah                ;ASCII Line Feed

    $parm1 EQU DWORD PTR [ebp + 8]          ;parameter 1
    $parm2 EQU DWORD PTR [ebp + 12]         ;parameter 2

;************************DATA SEGMENT***************************

.data

    ;inputs for testing the Shifter function
    inputA  byte 0,1,0,1,0,1,0,1                        ;inputA for shifter
    inputB  byte 0,0,1,1,0,0,1,1                        ;inputB for shifter
    inputC  byte 1,1,1,1,0,0,0,0                        ;enabler for shifter
    ARRAY_SIZE equ $ - inputC                           ;size of array in bytes

    ;numbers for testing DoRightShift
    nums   dword 10101010101010101010101010101010b      ;first binary to be shifted
           dword 01010101010101010101010101010101b      ;second binary to be shifted
           dword 11010101011101011101010101010111b      ;third binary to be shifted
    NUM_SIZE EQU $-nums                                 ;total bytes in the nums array

    NUM_OF_BITS EQU SIZEOF(DWORD) * 8                   ;Total bits for a dword

    ;You can add LFs to the strings below for proper output line spacing
    ;but do not change anything between the quotes "do not change".
    ;You can also combine messages where appropriate.

    ;I will be using a comparison program to compare your output to mine and
    ;the spacing must match exactly.

    endingMsg           byte "Hit any key to exit!", LF, 0                          ;greeting message to be printed to console

    titleMsg            byte "Program 6 by Bruno Ribeiro", LF, LF, 0                ;identity message to be printed

    testingShifterMsg   byte "Testing Shifter", LF, 0                               ;Intro message for shifter function
    enabledMsg          byte "(Shifting enabled C = 1, Disabled C = 0)", LF, 0      ;Explaining message for shifter

    testingDoRightShiftMsg byte LF, "Testing DoRightShift", LF, 0                   ;Intro message for DoRightShift function

    header          byte  "A B C | Output", LF, 0                                   ;tabular format information

    original        byte " Original", LF, 0                                         ;original input
    disableShift    byte " Disable Shift", LF, 0                                    ;Function using 0 for shift input
    enableShift     byte " Enable Shift", LF, 0                                     ;Function using 1 for shift
    shiftInst       byte " Shift Instruction", LF, LF, 0                            ;using shr
    barDivisor      byte " | ",0                                                    ;necessary for tabular format

    dashes byte "------------------------------------", LF, 0                       ;dashes to separate table

;************************CODE SEGMENT****************************

.code

Main PROC                               ;begin main

    mPrtStr titleMsg                    ;print titleMsg to the console
    mPrtStr testingShifterMsg           ;print testinShifterMsg to the console
    mPrtStr enabledMsg                  ;print enabledMsg to the console
    mPrtStr dashes                      ;print dashes divisor to the console
    mPrtStr header                      ;print header tabular message to the console
    ;while loop to print out array
    ;iterate through the array until all bytes have been processed.

    mov         esi, 0                  ;esi is the offset from the beginning of the array.
                                    
loopTop:
    cmp         esi, ARRAY_SIZE         ;compare esi to the total bytes of the array
    jae         done                    ;if we have processed all bytes then done with first loop

    movzx       eax, inputA[esi]        ;copy the byte at [inputA + esi] into eax to be used on shifter
    call        WriteDec                ;print the number in eax
    mPrtChar    ' '                     ;print a space for logical format
    push        eax                     ;saves value of eax to be used on shifter

    movzx       ebx,inputB[esi]         ;copy the byte at [inputB + esi] into ebx to be used on shifter
    mov         eax, ebx                ;move value to eax to be printed with WriteDec
    call        WriteDec                ;print the number in eax
    mPrtChar    ' '                     ;print a space for logical format
    movzx       ecx,inputC[esi]         ;copy the byte at [inputC + esi] into ecx to be used on shifter
    mov         eax, ecx                ;move value to eax to be printed with WriteDec
    call        WriteDec                ;print the number in eax
    mPrtStr     barDivisor              ;print a barDivisor for logical format

    pop         eax                     ;restores value on eax to be used on shifter

    call        Shifter                 ;call shifte  function

    call        WriteDec                ;print the number in eax
    mPrtChar    LF                      ;print a line feed for logical format
    inc         esi                     ;esi  contains the offset from the beginning of the array.
                                        ;add 1 to esi   so that input + esi   points to the
                                        ;next element of the byte array
    jmp         loopTop                 ;repeat loop

done:                                   ;if entire array was printed then jump here

    mPrtStr     testingDoRightShiftMsg  ;intro message to shift right function printed with macro
    mPrtStr     dashes                  ;print macros for logical format
    xor         edx, edx                ;zeros the register to be used as counter
    
loopTop2nd:                             ;begin of second loop
    
    cmp         edx, 12                 ;check if the loop went through 3 times
    je          done2nd                 ;jump to done2nd if check above is true

    push        nums[edx]               ;push the first binary to be printed   
    call        DspBin                  ;prints in binary the number on the stack
    mPrtStr     original                ;message describing output    
    
    push        0                       ;1 to shift, 0 to disable shift
    push        nums[edx]               ;32 bit operand1
    call        DoRightShift            ;result in eax
    push        eax                     ;push the result from function DoRIghtShift to be printed
    call        DspBin                  ;print in binary the number saved on the stack
    mPrtStr     disableShift            ;message describing output

    push        1                       ;1 to shift, 0 to disable shift
    push        nums[edx]               ;32 bit operand1
    call        DoRightShift            ;result in eax
    push        eax                     ;push the result from function DoRIghtShift to be printed
    call        DspBin                  ;print in binary the number saved on the stack
    mPrtStr     enableShift             ;message describing output    

    mov         eax, nums[edx]          ;saves number to be shifted to eax
    shr         eax, 1                  ;instruction that shifts eax to the right
    push        eax                     ;push the result from instruction shr to be printed
    call        DspBin                  ;print in binary the number saved on the stack
    mPrtStr     shiftInst               ;message describing output  

    add         edx, 4                  ;adds the size of a resgister to edx to keep going the loop
    jmp         loopTop2nd              ;jumps back 
  
done2nd:                                ;jump here if edx equals 12
    mPrtStr     endingMsg               ;instruction message to exit

    call        ReadChar                ;pause execution
	INVOKE      ExitProcess,0           ;exit to dos: like C++ exit(0)

Main ENDP                               ;end main

;************** DoRightShift - Shift a dword right by 1
;
;       ENTRY – operand 2 (enable,disable shift) and operand 1 (number to shift) are on the stack
;                         
;       EXIT  - EAX = shifted or non shifted number
;       REGS  - List registers you use
;
;       note: Before calling DoRightShift push operand 2 onto the stack and then push operand 1.
;
;	    note: DoRightShift calls the Shifter function to shift 1 bit.
;
;       to call DoRightShift in main function:
;                                   push  0 or 1            ;1 to shift, 0 to disable shift
;                                   push  numberToShift     ;32 bit operand1
;                                   call DoRightShift        ;result in eax
;
;       Note; at the end of this function use ret 8 (instead of just ret) to remove the parameters from the stack.
;                 Do not use add esp, 8 in the main function.
;--------------
;Do not access the arrays in main directly in the DoRightShift function. 
;The data must be passed into this function via the stack.
;Note: the DoRightShift function does not do any output. All the output is done in the main function
;
;Note: if shifting is disabled ($parm2 = 0) do not hardcode the return value to be
;equal to $parm1. If shifting is disabled you must still process all the bits
;through your Shifter function.
;
;In this function you will examine the bits from operand 1 in order from left to right using the BT instruction.

;See BT.asm on the class web site.

;You will use the BT instruction to copy the bits from operand 1 to the carry flag.
    
;Before the loop you will hardcode AL to 0 to account for the leftmost bit becoming 0
;during a right shift. 
    
;Before the loop you will also set bl to the value of bit 31 by using the following method:

;You will use the BT instruction to copy bit 31 to the carry flag then use a rotate instruction to copy the
;carry flag to the right end of bl.

;Then you will populate ecx with operand 2 which is the enable (1) or disable bit(0) then call the shifter function.

;after calling the shifter function you will transfer the return value from al to 
;the right end of the register you are using to accumulate shifted or non shifted bits which should have been initialized to 0.

;Then you will have a loop that will execute (NUM_OF_BITS - 1) times(31 times).
;You should use 0 as the terminating loop condition.

;The counter for the loop begins at NUM_OF_BITS - 1
;NOTE: you cannot use ecx for the counter since it contains the enable or disable bit.

;In the loop you will do the following:
;clear al and bl
;Use the BT instruction to copy the bit at position of the counter to the carry flag 
;and from the carry flag to the right end of al.

;Then use the BT instruction to copy the bit at position of the counter - 1 to the carry flag 
;and from the carry flag to the right end of bl.

;ecx should still be populated with the value of operand2 assigned before the loop.

;Then call the shifter function

;The bit returned by the Shifter function in eax should be copied to the carry flag using the BT instruction.
;You cannot use the BT instruction on a byte like al. You must use BT on a word (AX) or dword (EAX).

;then copy the bit from the carry flag using a rotate instruction to the right end
;of the register used to accumulate the shifted or non shifted bits.

;after the loop exits make sure the shifted or non shifted bits are in eax

;Each iteration of the loop should process the bits as follows:
    
;al = bit at position counter (shifted bit)
;bl = bit a position counter - 1 (original bit)
;
;
;		  Bit #	
;	counter | al  bl
;	    31	|  G  31   G = ground (since shr fill in on left with 0)
;	    30	| 31  30
;	    29	| 30  29
;	    28	| 29  28
;	    27	| 28  27
;	    26	| 27  26
; etc down to bit 1 (when counter is 0, the loop is done)
;       1   |  1   0


;You should save any registers whose values change in this function 
;using push and restore them with pop.
;
;The saving of the registers should
;be done at the top of the function and the restoring should be done at
;the bottom of the function.
;
;Note: do not save any registers that return a value (eax).
;
;Each line of the Shifter function must be commented and you must use the 
;usual indentation and formating like in the main function.
;
;Don't forget the "ret 8" instruction at the end of the function
;
;Do not delete this comment block. Every function should have 
;a comment block before it describing the function. FA18

DoRightShift proc                       ;Begin DoRightShift

    push	ebp	                        ;Save original value of EBP on stack
	mov	    ebp, esp	                ;EBP= address of original EBP on stack (00f8)
			                            ; Aim at a fixed location on the stack so
			                            ;   we can access other stack locations
                                        ;   relative to this location!
    push    ebx	                        ;saves ebx to be used in main
    push    ecx	                        ;saves ecx to be used in main
    push    edx	                        ;saves edx to be used in main
    push    edi	                        ;saves edi to be used in main

    xor     edi, edi	                ;clears edi to zero
    xor     eax, eax	                ;clears eax to zero
    xor     ebx, ebx	                ;clears ebx to zero

    mov     edx,  NUM_OF_BITS - 1       ;set edx as counter to 31
    bt      $parm1, edx                 ;copy bit in $parm1 at position in edx to carry flag
    rcl     ebx, 1                      ;copy carry flag to right end of bl


    mov     ecx,  $parm2                ;saves parameter passed in main to be used on shifter
    call    Shifter                     ;call function Shifter
    bt      eax, 0                      ;copy bit in eax at position in 0 to carry flag
    rcl     edi, 1                      ;copy carry flag to right end of edi

loopTopRS:                              ;start the loop
    xor     al, al                      ;clear al register
    xor     bl, bl                      ;clear bl register
    bt      $parm1, edx                 ;copy bit in $parm1 at position in edx to carry flag
    rcl     eax, 1                      ;copy carry flag to right end of al

    dec     edx                         ;edx--

    bt      $parm1, edx                 ;copy bit in $parm1 at position in edx to carry flag
    rcl     ebx, 1                      ;copy carry flag to right end of bl

    call    Shifter                     ;call function Shifter

    bt      eax, 0                      ;copy bit in eax at position in 0 to carry flag
    rcl     edi, 1                      ;copy carry flag to right end of edi

    cmp     edx, 1                      ;check if went through entire binary list of digits
    jge     loopTopRS                   ;repeat loop

    mov     eax, edi                    ;save number from edi to eax to be printed by DspBin

    pop     edi                         ;restore register to be used on main
    pop     edx                         ;restore register to be used on main
    pop     ecx                         ;restore register to be used on main
    pop     ebx                         ;restore register to be used on main
    pop     ebp                         ;restore register to be used on main

    ret     8                           ;clear 2 parameters from the stack and returns to main

DoRightShift endp                       ;end DoRightShift

;************** Shifter – Simulate a partial shifter circuit per the circuit diagram in the pdf file.  
;  Shifter will simulate part of a shifter circuit that will input 
;  3 bits and output a shifted or non-shifted bit.
;
;
;   CL--------------------------
;              |               |    
;              |               |     
;              |    AL        NOT    BL
;              |     |         |     |
;              --AND--         --AND--
;                 |                |
;                 --------OR--------
;                          |
;                          AL
;
; NOTE: To implement the NOT gate use XOR to flip a single bit.
;
; Each input and output represents one bit.
;
;  Note: do not access the arrays in main directly in the Adder function. 
;        The data must be passed into this function via the required registers below.
;
;       ENTRY - AL = input bit A 
;               BL = input bit B
;               CL = enable (1) or disable (0) shift
;       EXIT  - AL = shifted or non-shifted bit
;       REGS  -  (list registers you use)
;
;       For the inputs in the input columns you should get the 
;       output in the output column below.
;
;The chart below shows the output for 
;the given inputs if shifting is enabled (cl = 1)
;If shift is enabled (cl = 1) then output should be the shifted bit (al).
;In the table below shifting is enabled (cl = 1)
;
;        input      output
;     al   bl  cl |   al 
;--------------------------
;      0   0   1  |   0 
;      1   0   1  |   1 
;      0   1   1  |   0 
;      1   1   1  |   1   
;
;The chart below shows the output for 
;the given inputs if shifting is disabled (cl = 0)
;If shift is disabled (cl = 0) then the output should be the non-shifted bit (B).

;        input      output
;     al   bl  cl |   al 
;--------------------------
;      0   0   0  |   0 
;      1   0   0  |   0 
;      0   1   0  |   1 
;      1   1   0  |   1   

;
;Note: the Shifter function does not do any output to the console.All the output is done in the main function
;
;Do not access the arrays in main directly in the shifter function. 
;The data must be passed into this function via the required registers.
;
;Do not change the name of the Shifter function.
;
;See additional specifications for the Shifter function on the 
;class web site.
;
;You should use AND, OR and XOR to simulate the shifter circuit.
;
;Note: to flip a single bit use XOR do not use NOT.
;
;You should save any registers whose values change in this function 
;using push and restore them with pop.
;
;The saving of the registers should
;be done at the top of the function and the restoring should be done at
;the bottom of the function.
;
;Note: do not save any registers that return a value (eax).
;
;Each line of this function must be commented and you must use the 
;usual indentation and formating like in the main function.
;
;Don't forget the "ret" instruction at the end of the function
;
;Do not delete this comment block. Every function should have 
;a comment block before it describing the function. FA18

Shifter proc                ;start Shifter function

    push    ebx             ;saves register to be used after function is done 
    push    ecx             ;saves register to be used after function is done

    and     al, cl          ;and value from al with cl
    xor     cl, 00000001b   ;flip the bit
    and     bl, cl          ;and value from bl with cl
    or      al, bl          ;or value from al with cl

    pop     ecx             ;restore register to be used in main
    pop     ebx             ;restore register to be used in main


	ret                     ;return main

Shifter endp                ;end Shifter function

;************** DspBin - display a Dword in binary including leading zeros
;
;       ENTRY –operand1, the number to print in binary, is on the stack
;
;       For Example if parm1 contained contained AC123h the following would print:
;                00000000000010101100000100100011
;       For Example if parm1 contained 0005h the following would print:
;                00000000000000000000000000000101
;
;       EXIT  - None
;       REGS  - List registers you use
;
; to call DspBin:
;               push 1111000110100b    ;number to print in binary is on the stack
;               call DspBin            ; 00000000000000000001111000110100 should print
;     
;       Note: leading zeros do print
;       Note; at the end of this function use ret 4 (instead of just ret) to remove the parameter from the stack
;                 Do not use add esp, 4 in the main function.
;--------------

    ;You should have a loop that will do the following:
    ;The loop should execute NUM_OF_BITS times(32 times) times so that all binary digits will print including leading 0s.
    ;You should use the NUM_OF_BITS constant as the terminating loop condition and not hard code it.
    
    ;You should start at bit 31 down to and including bit 0 so that the digits will 
    ;   print in the correct order, left to right.
    ;Each iteration of the loop will print one binary digit.

    ;Each time through the loop you should do the following:
    
    ;You should use the BT instruction to copy the bit starting at position 31 to the carry flag 
    ;   then use a rotate command to copy the carry flag to the right end of al.

    ;then convert the 1 or 0 to a character ('1' or '0') and print it with WriteChar.
    ;You should keep processing the number until all 32 bits have been printed from bit 31 to bit 0. 
    
    ;Efficiency counts.

    ;DspBin just prints the raw binary number.

    ;No credit will be given for a solution that uses mul, imul, div or idiv. 
    ;
    ;You should save any registers whose values change in this function 
    ;using push and restore them with pop.
    ;
    ;The saving of the registers should
    ;be done at the top of the function and the restoring should be done at
    ;the bottom of the function.
    ;
    ;Each line of this function must be commented and you must use the 
    ;usual indentation and formating like in the main function.
    ;
    ;Don't forget the "ret 4" instruction at the end of the function
    ;
    ;
    ;Do not delete this comment block. Every function should have 
    ;a comment block before it describing the function. FA17

DspBin proc                         ;start DspBin function
    

    push	ebp	                    ;Save original value of EBP on stack
	mov	    ebp,esp	                ;EBP= address of original EBP on stack (00f8)
			                        ; Aim at a fixed location on the stack so
			                        ;   we can access other stack locations
                                    ;   relative to this location!
    push    ecx                     ;saves ecx to be used after function

    mov     ecx,  NUM_OF_BITS - 1   ;uses ecx as a counter to 31
    
loopTop2:                           ;start of loop
    xor     eax, eax                ;clear eax
    bt      $parm1, ecx             ;copy bit in num at position in ecx to carry flag
    rcl     eax,1                   ;copy carry flag to right end of al
    or      al, 00110000b           ;makes the binary number a ASCII number to be printed
    call    writeChar               ;prints al
    dec     ecx                     ;ecx--
    cmp     ecx, 0                  ;keep looping while ecx is not zero
    jge     loopTop2                ;jump if check above is false

    pop     ecx                     ;restore register to be used in main
    pop     ebp                     ;restore register to be used in main

    ret     4                       ;returns and clears parameter

DspBin endp                         ;end DspBin function

END Main