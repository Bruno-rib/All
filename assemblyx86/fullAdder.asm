; Comment block below must be filled out completely for each assignment
; *************************************************************
; Student Name:		Bruno Silva Ribeiro
; COMSC-260 Fall 2018
; Date:		10/1/2018
; Assignment #4
; Version of Visual Studio used (2015)(2017):	2017
; Did program compile? Y
; Did program produce correct results? Y
; Is code formatted correctly including indentation, spacing and vertical alignment? Y
; Is every line of code commented? Y
;
; Estimate of time in hours to complete assignment:		8 hours
;
; In a few words describe the main challenge in writing this program:	
;			-Getting the program to display correct results, then switch the program around to use and return correct registers
;
; Short description of what program does:
;			- The program will have a function that will simulate an adder for a single bit
;			- It will receive 3 arrays and use a while loop to add each array index and take care of carry
;			- As the program adds it will also display on screen with macro
;			- The program will maintain the values of any non necessary registers by using push and pop inside function
;
; *************************************************************
; Reminder: each assignment should be the result of your
; individual effort with no collaboration with other students.
;
; Reminder: every line of code must be commented and formatted
; per the ProgramExpectations.pdf file on the class web site
;

.386      ;identifies minimum CPU for this program

.MODEL flat,stdcall    ;flat - protected mode program
                       ;stdcall - enables calling of MS_windows programs

;allocate memory for stack
;(default stack size for 32 bit implementation is 1MB without .STACK directive 
;  - default works for most situations)

.STACK 4096            ;allocate 4096 bytes (1000h) for stack

;Irvine32.lib contains the code for DumpRegs and many other Irvine
;functions


;*******************MACROS********************************

;mPrtStr
;usage: mPrtStr nameOfString
;ie to display a 0 terminated string named message say:
;mPrtStr message

;Macro definition of mPrtStr. Wherever mPrtStr appears in the code
;it will  be replaced with 

mPrtStr  MACRO  arg1            ;arg1 is replaced by the name of string to be displayed
         push edx               ;saves edx
         mov edx, offset arg1   ;address of str to display should be in dx
         call WriteString       ;display 0 terminated string
         pop edx                ;restores edx
ENDM



;*************************PROTOTYPES*****************************

ExitProcess PROTO,
    dwExitCode:DWORD    ;from Win32 api not Irvine to exit to dos with exit code


WriteDec PROTO          ;Irvine code to write number stored in eax
                        ;to console in decimal

ReadChar PROTO          ;Irvine code for getting a single char from keyboard
				        ;Character is stored in the al register.
			            ;Can be used to pause program execution until key is hit.

WriteChar PROTO         ;write the character in al to the console

WriteString PROTO		;Irvine code to write null-terminated string to output
                        ;EDX points to string

                     
;************************  Constants  ***************************

    LF                  equ     0Ah                                 ;ASCII Line Feed
    
;************************DATA SEGMENT***************************

.data
    inputAnum           byte 0,0,0,0,1,1,1,1                        ;Declares array inputAnum
    inputBnum           byte 0,0,1,1,0,0,1,1                        ;Declares array inputBnum
    carryInNum          byte 0,1,0,1,0,1,0,1                        ;Declares array carryInNum
    ARRAY_SIZE          equ $-carryInNum                            ;Keeps track of the size of the array to be used during the loop     

    endingMsg           byte LF,LF,"Hit any key to exit!",0         ;Instructions as a last message printed
    
    titleMsg            byte "Program 4 by Bruno Ribeiro",LF,0      ;Introduction message

    testingAdderMsg     byte LF," Testing Adder",0                  ;Name of the program

    inputA              byte LF,LF,"   Input A: ",0                 ;Presents the value linked to inputAnum array
    inputB              byte LF,"   Input B: ",0                    ;Presents the value linked to inputBnum array
    carryin             byte LF,"  Carry in: ",0                    ;Presents the value linked to carryInNum array
    sum                 byte LF,"       Sum: ",0                    ;Presents the value of summing the 3 digits of each array 
    carryout            byte LF," Carry Out: ",0                    ;Presents the value of the carryOut from summing the 3 arrays

    dashes              byte LF," ------------",0                   ;Separates Blocks of data


;************************CODE SEGMENT****************************

.code

main PROC                           ;begin main

    mov     esi, 0                  ;esi   is the offset from the beginning of the array.
    mPrtStr titleMsg                ;Print Title message using macro
    mPrtStr dashes                  ;Print dashes using macro
    mPrtStr testingAdderMsg         ;Print Testing message using macro
    mPrtStr dashes                  ;Print dashes using macro
                                                              
loopTop: 
    
    cmp     esi, ARRAY_SIZE         ;compare esi to the total bytes of the array
    jae     done                    ;if we have processed all bytes then done


    mPrtStr inputA                  ;Print inputA message using macro
    movzx   eax, inputAnum[esi]     ;Saves the number on the inputAnum array related to esi position on eax to print
    call    writeDec                ;Print number on eax
    mPrtStr inputB                  ;Print inputB message using macro
    movzx   eax, inputBnum[esi]     ;Saves the number on the inputBnum array related to esi position on eax to print
    call    writeDec                ;Print number on eax
    mPrtStr carryin                 ;Print carryin meassage using macro
    movzx   eax, carryInNum[esi]    ;Saves the number on the carryInNum array related to esi position on eax to print
    call    writeDec                ;Print number on eax
    mPrtStr dashes                  ;Print Dashes message using macro

    
    movzx   eax, inputAnum[esi]     ;Saves the number on the inputAnum array related to esi position to eax to be used on Adder function
    movzx   ebx, inputBnum[esi]     ;Saves the number on the inputBnum array related to esi position to ebx to be used on Adder function
    movzx   ecx, carryInNum[esi]    ;Saves the number on the carryInNum array related to esi position to ecx to be used on Adder function
    call    Adder                   ;Call function Adder

    mPrtStr sum                     ;Print sum message using macro
    call    writeDec                ;Print current sum saved on eax inside the function
    mPrtStr carryout                ;Print carryout message using macro
    mov     eax, ecx                ;Move cl value holding carryOut from the function to eax
    call    writeDec                ;Print current eax value 

    inc     esi                     ;Increase eax before repeating the loop                                          
    jmp     loopTop                 ;repeat

done:
    mPrtStr endingMsg               ;Print endingMsg message using macro
    call    ReadChar                ;pause execution
    INVOKE	ExitProcess,0           ;Exit

main ENDP                           ;end main


;************** Adder – Simulate a full Adder circuit  
;  Adder will simulate a full Adder circuit that will add together 
;  3 input bits and output a sum bit and a carry bit
;
;    Each input and output represents one bit.
;
;  Note: do not access the arrays in main directly in the Adder function. 
;        The data must be passed into this function via the required registers below.
;
;       ENTRY - EAX = input bit A 
;               EBX = input bit B
;               ECX = Cin (carry in bit)
;       EXIT  - EAX = sum bit
;               ECX = carry out bit
;       REGS  -  (list registers you use)
;
;       For the inputs in the input columns you should get the 
;       outputs in the output columns below:
;
;        input                  output
;     eax  ebx   ecx   =      eax     ecx
;      A  + B +  Cin   =      Sum     Cout
;      0  + 0 +   0    =       0        0
;      0  + 0 +   1    =       1        0
;      0  + 1 +   0    =       1        0
;      0  + 1 +   1    =       0        1
;      1  + 0 +   0    =       1        0
;      1  + 0 +   1    =       0        1
;      1  + 1 +   0    =       0        1
;      1  + 1 +   1    =       1        1
;
;   Note: the Adder function does not do any output. 
;         All the output is done in the main function.
;
;Do not change the name of the Adder function.
;
;See additional specifications for the Adder function on the 
;class web site.
;
;You should use AND, OR and XOR to simulate the full adder circuit.
;
;You should save any registers whose values change in this function 
;using push and restore them with pop.
;
;The saving of the registers should
;be done at the top of the function and the restoring should be done at
;the bottom of the function.
;
;Note: do not save any registers that return a value (ecx and eax).
;
;Each line of the Adder function must be commented and you must use the 
;usual indentation and formating like in the main function.
;
;Don't forget the "ret" instruction at the end of the function
;
;Do not delete this comment block. Every function should have 
;a comment block before it describing the function. FA16

;"Adder" procedure.
Adder proc

    push    edx             ;save the value from register edx to be restored  
    push    ebx             ;save the value from register ebx to be restored  
           
    mov     dl, al          ;save al so can be used also on and gate
    xor     al, bl          ;perform first xor gate
    and     bl, dl          ;perform first and gate

    mov     dl, al          ;save al value to be used on second and gate
    xor     al, cl          ;second xor gate and saves the sum al
    and     cl, dl          ;perform second and gate
       
    or      cl, bl          ;perform last or gate and saves the carry to cl
    
    pop     ebx             ;restore ebx
    pop     edx             ;restore ecx
    ret

Adder endp                  ;end of function
END main                    ;end of program