; Comment block below must be filled out completely for each assignment
; *************************************************************
; Student Name:		Bruno Silva Ribeiro
; COMSC-260 Fall 2018
; Date:		12/01/2018
; Assignment #8
; Version of Visual Studio used (2015)(2017):	2017
; Did program compile? Y
; Did program produce correct results? Y
; Is code formatted correctly including indentation, spacing and vertical alignment? Y
; Is every line of code commented? Y
;
; Estimate of time in hours to complete assignment:     4 hours 
;
; In a few words describe the main challenge in writing this program:	
;			- Easy and chronological instructions. The if else statements were tricky but I 
;               did not repeatedly got stuck like programs #5, #6, #7. Therefore it made 
;               things much easier and enjoyable
;
; Short description of what program does:
;			- Program creates and initializes a struct to perform math operations
;           - Each struct has the form of (operator, operand1, operand2)
;           - Program will pring each Expression struct in a tabular and organized format
;           - Expressions performed by struct can do float point arithmetic
;
; *************************************************************
; Reminder: each assignment should be the result of your
; individual effort with no collaboration with other students.
;
; Reminder: every line of code must be commented and formatted
; per the ProgramExpectations.pdf file on the class web site
;

.586      ;identifies minimum CPU for this program

.MODEL flat,stdcall             ;flat - protected mode program
                                ;stdcall - enables calling of MS_windows programs

;allocate memory for stack
;(default stack size for 32 bit implementation is 1MB without .STACK directive 
;  - default works for most situations)

.STACK 4096                     ;allocate 4096 bytes (1000h) for stack

;*******************MACROS********************************

;NOTE: Use the macros below to print strings, single chars and decimal numbers
;Do not define any other macros.

;mPrtStr will print a zero terminated string to the soncole
mPrtStr  MACRO  arg1            ;arg1 is replaced by the name of string to be displayed
         push edx               ;save edx
         mov edx, offset arg1   ;address of str to display should be in dx
         call WriteString       ;display 0 terminated string
         pop edx                ;restore edx
ENDM

;mPrtChar will print a single char to the console
mPrtChar MACRO  arg1            ;arg1 is replaced by char to be displayed
         push eax               ;save eax
         mov  al, arg1          ;al = char to display
         call WriteChar         ;display char to console
         pop  eax               ;restore eax
ENDM

;mPrtDec will print a dec number to the console
mPrtDec  MACRO  arg1            ;arg1 is replaced by the name of string to be displayed
         push eax               ;save eax
         mov  eax, arg1         ;eax = dec num to print
         call WriteDec          ;display dec num to console
         pop  eax               ;restore eax
ENDM

;*************************PROTOTYPES*****************************

ExitProcess PROTO,
    dwExitCode:DWORD    ;from Win32 api not Irvine to exit to dos with exit code

ReadChar PROTO          ;Irvine code for getting a single char from keyboard
				        ;Character is stored in the al register.
			            ;Can be used to pause program execution until key is hit.

WriteDec PROTO          ;Irvine code to write number stored in eax
                        ;to console in decimal

WriteString PROTO		;Irvine code to write null-terminated string to output
                        ;EDX points to string

WriteChar PROTO         ;write the character in al to the console

;To call SetFloatPlaces, SetFieldWidth or DspFloat in your program you must first include
;kennedyDspFloat.lib in your project

SetFloatPlaces PROTO    ;sets the number of places a float should round to while printing 
                        ;The default place is 1.
                        ;populate ecx with the number of places to round a floating point num to
                        ;then call SetFloatPlaces.
                        ;If the places to round to  is 2 then 7.466
                        ;would display as 7.47 after calling DspFloat
                        ;The places to round to does not change unless
                        ;you call SetFloatPlaces again.

DspFloat PROTO          ;prints a float in st(0) to the console formatted to a field width and rounding places.
                        ;DspFloat pops the floating point stack.
                        ;DspFloat does not check if the number is a valid float.

SetFieldWidth PROTO     ;Set the space a float should occupy when printed.
                        ;Populate ecx with the total space you want want a displayed float to occupy.
                        ;Use this to help right justify a displayed float to line up a column of numbers vertically
                        ;The default field width is 0.
                        ;To change the field width from the default call SetFieldWidth before calling DspFloat.
                       
;************************  Constants  ***************************

    LF       equ     0Ah                   ; ASCII Line Feed

;************************  Structs  ***************************

    ;NOTE: before you do anything else you must define the EXPRESSION struct
    ;as described below.

    ;structure definition
    ;structure definition below does not allocate memory but is just a pattern
    ;EXPRESSION defines a type
    ;The EXPRESSION struct contains information for one expression
    ;operand1 operator operand2 (5.6 + 2.1)

    EXPRESSION      struct
        operator    byte    ?       ; operator
        align       real8           ; for best performance align on struct member data type size
        operand1    real8   ?       ; operand1
        operand2    real8   ?       ; operand2
    EXPRESSION      ends

    ;************************DATA SEGMENT***************************

.data

    ;NOTE: do not change the strings below except to add LFs for line spacing
    ;and to change my name to your name.

    heading                     byte   "Program 8 by Bruno Ribeiro", LF, LF, 0                                              ; Intro message
    equals                      byte    " =",0                                                                              ; equal message

    sizeofEXPRESSIONmsg         byte LF,"    The size of an EXPRESSION struct in bytes is: ",0                              ; Size Expression message
    sizeofexpressionsArrayMsg   byte LF,"   The size of the expressions array in bytes is: ",0                              ; Size of Expression array
    numOfexpressionsMsg         byte LF,"The number of EXPRESSION structs in the array is: ",0                              ; Amount of Expression Structs  

    ;expressions is an array of EXPRESSION structs initialized with data
    ;The order in the struct is operator, operand1, operand2
    ;NOTE: Do not change the data in the array.

    align real8                                                                                                             ;align the first struct on a real8 boundary
    expressions EXPRESSION {'+',-35.56,10.089},{'/',78.45,104.34},{'*',5674.32,-10.56},{'-',678.12,789.77},{'/',0.0,104.34} ;definition of values
    
    ;EXPRESSION_COUNT will be equal to the number of EXPRESSION structs in the array
    ;You should use EXPRESSION_COUNT when you print out the number of structs in the array
    EXPRESSION_COUNT equ lengthof expressions

    ;TOTAL_SIZE will be equal to the total bytes in the array
    ;You should use TOTAL_SIZE as the termination condition for the loop in main
    TOTAL_SIZE equ sizeof expressions

;************************CODE SEGMENT****************************

.code

Main PROC

    ;change number of places to round to
    mov         ecx, 2                                  ;ecx contains the number of places to round to
    call        SetFloatPlaces                          ;set the places for DspFloat round to
                                                        ;rounding will not change until SetFloatPlaces called again
    mPrtStr     heading                                 ;print heading message to console

    xor         ebx,ebx                                 ;initialize loop variable to 0
looptop:
    cmp         ebx,TOTAL_SIZE                          ;cmp ebx to the size of the expressions array
    jae         done                                    ;if ebx >= size of the expressions array then done

    mov         ecx, 8                                  ;ecx contains field width
    call        SetFieldWidth                           ;set field width for DspFloat to line up floats vertically
                                                        ;field width will not change until SetFieldWidth called again
    fld         expressions[ebx].operand1               ;push float onto floating point stack
    call        DspFloat                                ;print float            
    mPrtChar    ' '                                     ;print single space to console
    mPrtChar    expressions[ebx].operator               ;print operator to console

    mov         ecx, 7                                  ;ecx contains field width
    call        SetFieldWidth                           ;set field width for DspFloat to line up floats vertically
                                                        ;field width will not change until SetFieldWidth called again
    fld         expressions[ebx].operand2               ;push float onto floating point stack
    call        DspFloat                                ;print float on st(0)
    mPrtStr     Equals                                  ;print heading message to console
    fld         expressions[ebx].operand1               ;push float onto floating point stack 
    
    
    cmp         expressions[ebx].operator, '+'          ;check operator to perform on the expression
    jnz         subt                                    ;jump to next if/else if check above is false
    fadd        expressions[ebx].operand2               ;operand1 as source and operand2 as destination
    jmp         printThis                               ;perform the jump to print number saved on st(0)

subt:  
    cmp         expressions[ebx].operator, '-'          ;check operator to perform on the expression
    jnz         divi                                    ;jump to next if/else if check above is false
    fsub        expressions[ebx].operand2               ;operand1 as source and operand2 as destination
    jmp         printThis                               ;perform the jump to print number saved on st(0)

divi: 
    cmp         expressions[ebx].operator, '/'          ;check operator to perform on the expression
    jnz         multi                                   ;jump to next if/else if check above is false
    fdiv        expressions[ebx].operand2               ;operand1 as source and operand2 as destination  
    jmp         printThis                               ;perform the jump to print number saved on st(0)

multi:
    fmul        expressions[ebx].operand2               ;operand1 as source and operand2 as destination   

printThis:
    mov         ecx, 10                                 ;ecx contains field width
    call        SetFieldWidth                           ;set field width for DspFloat to line up floats vertically
                                                        ;field width will not change until SetFieldWidth called again
    call        DspFloat                                ;print float on st(0)   
    mPrtChar    LF                                      ;print new line to console
    add         ebx, sizeof EXPRESSION                  ;add size of EXPRESSION struct to ebx to address next
                                                        ;struct in EXPRESSION array
    jmp         looptop                                 ;repeat loop

done:
    xor         eax, eax                                ;clear eax register
    mPrtStr     sizeofexpressionsArrayMsg               ;print total size of the array to console
    mov         al, TOTAL_SIZE                          ;save the value on al to be printed
    call        WriteDec                                ;print value saved on al
    mPrtStr     sizeofEXPRESSIONmsg                     ;print size of an expression to console
    mov         al, sizeof EXPRESSION                   ;save the value on al to be printed
    call        WriteDec                                ;print value saved on al
    mPrtStr     numOfexpressionsMsg                     ;print number of expressions to console
    mov         al, EXPRESSION_COUNT                    ;save the value on al to be printed
    call        WriteDec                                ;print value saved on al

    call        ReadChar                                ;pause execution
	INVOKE      ExitProcess,0                           ;exit to dos: like C++ exit(0)

Main ENDP

END Main
