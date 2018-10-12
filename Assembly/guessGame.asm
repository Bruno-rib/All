; Comment block below must be filled out completely for each assignment
; *************************************************************
; Student Name:		Bruno Silva Ribeiro
; COMSC-260 Fall 2018
; Date:		9/14/2018
; Assignment #3
; Version of Visual Studio used (2015)(2017):	2017
; Did program compile? Y
; Did program produce correct results? Y
; Is code formatted correctly including indentation, spacing and vertical alignment? Y
; Is every line of code commented? Y
;
; Estimate of time in hours to complete assignment:		6 hours
;
; In a few words describe the main challenge in writing this program:	
;			-RamdomRange produces a decimal and it took me a while to figure an easy way to change the register back to hex
;
; Short description of what program does:
;			-The program will generate a random number so a player can try to guess inside the range of A - F
;           -After imputing a number the program will instruct the player if answer is too high or too low
;           -All the messages are printed using a macro
;           -Program uses MessageBoxA dialogue window to ask if player wanna play again after guessed the answer right
;
; *************************************************************
; Reminder: each assignment should be the result of your
; individual effort with no collaboration with other students.
;
; Reminder: every line of code must be commented and formatted
; per the ProgramExpectations.pdf file on the class web site
;


.386								;identifies minimum CPU for this program

.MODEL flat,stdcall			        ;flat - protected mode program
									;stdcall - enables calling of MS_windows programs

;allocate memory for stack
;(default stack size for 32 bit implementation is 1MB without .STACK directive 
;  - default works for most situations)

.STACK 4096							;allocate 4096 bytes (1000h) for stack

;*******************MACROS********************************

;mPrtStr
;usage: mPrtStr nameOfString
;ie to display a 0 terminated string named message say:
;mPrtStr message

;Macro definition of mPrtStr. Wherever mPrtStr appears in the code
;it will  be replaced with 
mPrtStr  MACRO  arg1            ;arg1 is replaced by the name of string to be displayed
		 push edx				;save edx
         mov  edx, offset arg1  ;address of str to display should be in edx
         call WriteString       ;display 0 terminated string
         pop  edx				;restore edx
ENDM
;arg1 is replaced with message if that is the name of the string passed in.

;*************************PROTOTYPES*****************************

ExitProcess PROTO,
    dwExitCode:DWORD    ;exit to the operating system

ReadHex PROTO           ;Irvine code to read 32 bit hex number from console
                        ;and store it into eax

WriteString PROTO       ;Irvine code to write null-terminated string to output
                        ;edx points to string

RandomRange PROTO       ;Returns an unsigned pseudo-random 32-bit integer
                        ;in eax, between 0 and n-1. If n = 6h a random number
                        ;in the range 0-5 is generated.
                        ;
                        ;Input parameter: eax = n.

Randomize PROTO         ;Re-seeds the random number generator with the current time
                        ;in seconds

MessageBoxA PROTO,      ;MessageBoxA takes 4 parameters:
    handleOwn:DWORD,    ;1. window owner handle
    msgAdd:DWORD,       ;2. message address (zero terminated string)
    captionAdd:DWORD,   ;3. title address (zero terminated string)
    boxType:DWORD       ;4. which button(s) to display

;*************************CONSTANTS*****************************					
	
	LF		equ		0Ah	;ASCII Line Feed declared in a constant		

;************************DATA SEGMENT***************************

.data

    ;create strings with embedded line feeds
	msg1	byte	"Program 3 by Bruno Ribeiro", LF, 0		                        ;Title message for window and pop up
	msg2	byte	LF, "Guess a hex number in the range Ah - Fh.", LF, 0		    ;Instruction printed on console
    msg3    byte    "Guess: ", 0                                                    ;message before input
    msg4    byte    "High! (Guess lower)", LF, 0                                    ;Message for the if statement in case it needs a lower guess
    msg5    byte    "Low! (Guess higher)", LF, 0                                    ;Message for the if statement in case it needs a higher guess
    msg6    byte    "Correct! Play again?", 0                                       ;Message for pop up dialog

;************************CODE SEGMENT****************************

.code

main PROC
    
    ;block of code containing actions required outside outer loop
    mPrtStr msg1            ;call mPrtStr macro to print zero terminated string
    call    Randomize       ;seed the random number generator

;loop will keep iterating until the user chooses 'no' (outer loop)
loopTop:
    ;block of code required to set up the game for the guess
    mPrtStr msg2            ;call mPrtStr macro to print zero terminated string
    mov     eax, 6h         ;range to generate random numbers 0-5
    call    RandomRange     ;generate random number in range (stored in eax)
    mov     ebx, 0Ah        ;prepare ebx to store random number and add 10 to the value for A-F result
    add     ebx, eax        ;copy value to ebx so eax can be used for ReadHex 

;loop will keep iterating until the user guess the right number (inner loop)
loop2Top:
    ;block of code containing the guess game
    mPrtStr msg3            ;call mPrtStr macro to print zero terminated string
    call    ReadHex         ;read 32 bit hex number from console
                            ;and store it into eax
    cmp     al,bl           ;cmp al (user guess), to bl that stores the random number
    jb      Lower           ;if al > 2 then do not execute body of next if and jump to LOWER
    je      DONE            ;if guess right display the message box
    
;case that guess is higher the code just runs here
Higher:
    mPrtStr msg4            ;call mPrtStr macro to print zero terminated string
    jmp     loop2Top        ;give the player one more chance to guess it right

;another if else statement block in case that guess is lower
Lower:
    mPrtStr msg5            ;call mPrtStr macro to print zero terminated string
    jmp     loop2Top        ;give the player one more chance to guess it right
     
DONE:
    ;body of if that will be ignored if not equal;Display message box asking user question.
    invoke  MessageBoxA ,   ;call MessageBoxA Win32 API function
                       0,   ;0 indicates no window owner
               addr msg6,   ;address of message to be displayed in middle of msg box
               addr msg1,   ;caption to be displayed in title bar of msg box
                       4    ;display yes, no buttons in msg box
                            ;(6 returned in eax if user hits yes)
                            ;(7 returned in eax if user hits no)
    cmp     eax, 6          ;Did the user choose yes (6)?
    je      loopTop         ;If yes, loop game again.

	INVOKE	ExitProcess,0	;exit to dos: like C++ exit(0)

main ENDP					;end required
END main					;end required