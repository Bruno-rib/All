; Comment block below must be filled out completely for each assignment
; *************************************************************
; Student Name:		Bruno Silva Ribeiro
; COMSC-260 Fall 2018
; Date:		9/14/2018
; Assignment #2
; Version of Visual Studio used (2015)(2017):	2017
; Did program compile? Y
; Did program produce correct results? $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
; Is code formatted correctly including indentation, spacing and vertical alignment? Y
; Is every line of code commented? Y
;
; Estimate of time in hours to complete assignment:		7 hours
;
; In a few words describe the main challenge in writing this program:	
;					*There were a lot details in each sentence of the assigment and to make sure I covered every detail it took me a while
;							to read as I was doing the program. I am also not very familiar yet with asm programs so to make sure it would compile
;							I went back and forth using the examples on the website.
;					*At some point my antivirus flagged my program as a virus and took me a while to fix it
;					
; Short description of what program does:
;					*Print an welcoming message and a goodbye message. Evaluates the expression 
;						num1 + num2 * num3 % (num4 - num5) / num6 ^ 2 - num7
;						and also prints the expression (in hex) to the console with the calculated result after the expression
;							
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

;*************************PROTOTYPES*****************************

WriteHex PROTO                      ;write the number stored in eax to the console as a hex number
									;before calling WriteHex put the number to write into eax

WriteString PROTO					;write null-terminated string to console
									;edx contains the address of the string to write
									;before calling WriteString put the address of the string to write into edx
									;e.g. mov edx, offset message
									;address of message is copied to edx

ExitProcess PROTO,dwExitCode:DWORD  ;exit to the operating system

ReadChar PROTO						;Irvine code for getting a single char from keyboard
									;Character is stored in the al register.
									;Can be used to pause program execution until key is hit.

WriteChar PROTO						;Irvine code for printing a single char to the console
									;Character to be printed must be in the al register
	
;*************************CONSTANTS*****************************					
	
	LF		equ		0Ah				;ASCII Line Feed declared in a constant		

;************************DATA SEGMENT***************************

.data

	;declaring size of the following variables
    num1    dword		0CB7FB84h	;declaring num1 to 0CB7FB84h
	num2    dword		547h		;declaring num2 to 547h
	num3    dword		0FA2C7h		;declaring num1 to 0FA2C7h
	num4    dword		0B7A25A9h	;declaring num1 to 0B7A25A9h
	num5    dword		0A34B46Bh	;declaring num1 to 0A34B46Bh
	num6    dword		94h			;declaring num1 to 94h
	num7    dword		1514ABCh	;declaring num1 to 1514ABCh

    ;create strings with embedded line feeds
	msg1		byte		"Program 2 by Bruno Ribeiro", LF, LF, 0		;set welcoming message to string msg1 (using CTE LF as line feed)
	msg2		byte		LF, LF, "Hit any key to exit!", 0			;set exit message to the string msg2 (using CTE LF as line feed)
	sign1		byte		"h+",0										;set string sign1
	sign2		byte		"h*",0										;set string sign2
	sign3		byte		"h%(",0										;set string sign3
	sign4		byte		"h-",0										;set string sign4
	sign5		byte		"h)/",0										;set string sign5
	sign6		byte		"h=",0										;set string sign6
	
;************************CODE SEGMENT****************************

.code

main PROC

    ;section containing first part of printed result to console
	mov	    edx, offset msg1		;edx sets to introduction message
	call	WriteString				;Print msg1 string to console
	mov     eax, num1				;eax = num1 to print on console
	call	WriteHex				;print num1 to console
	mov		edx, offset sign1		;edx set to "h+"
	call	WriteString				;print "h+" to the console
	mov     eax, num2				;eax = num2 to print on console
	call	WriteHex				;print num2 to console
	mov		edx, offset sign2		;edx set to "h*"
	call	WriteString				;print "h*" to the console
	mov     eax, num3				;eax = num3 to print on console
	call	WriteHex				;print num3 to console
	mov		edx, offset sign3		;edx set to "h%("
	call	WriteString				;print "h%(" to the console
	mov     eax, num4				;eax = num4 to print on console
	call	WriteHex				;print num4 to console
	mov		edx, offset sign4		;edx set to "h-"
	call	WriteString				;print "h-" to the console
	mov     eax, num5				;eax = num5 to print on console
	call	WriteHex				;print num5 to console
	mov		edx, offset sign5		;edx set to "h)/"
	call	WriteString				;print "h)/" to the console

	;populating registers with data to perform future calculations 
	;that are not allowed such as mem to mem num6 * num6
	mov     eax, num6				;eax = num6 (for square operation)
	mov     ebx, num4				;ebx = num4 (for subtraction operation) 
	
    ;performing the following operation
	;num1 + num2 * num3 % (num4 - num5) / num6 ^ 2 - num7
	mul		num6					;performing num6 * num6 and storing in eax
	call	WriteHex				;print num6 to console
	mov		edx, offset sign4		;edx set to "h-"
	call	WriteString				;print "h-" to the console
	mov		ecx, eax				;saves the result at ecx so eax is open to multiply again
	mov     eax, num7				;eax = num7 to print on console
	call	WriteHex				;print num7 to console
	sub		ebx, num5				;performing num4 - num5 and storing at ebx
	mov		eax, num2				;populates eax with num2 to multiply num3
	mul		num3					;performing num2 * num3 and storing in eax
	mov		edx, 0					;set edx to zero to perform division 
	div		ebx						;quotient in eax, remainder in edx (quotient ignored)
	mov		eax, edx				;in order to perform division remainder / squared
	mov		edx, 0					;set edx to zero to perform division
	div		ecx						;eax/ecx quotient saved in eax and remainder ignored edx
	add		eax, num1				;add num1 to the result so far
	sub		eax, num7				;subtract num7 from result to find the answer
  
	mov		edx, offset sign6		;edx set to "h="
	call	WriteString				;print "h=" to the console
	call    WriteHex				;Print number in eax to the console in hex
	mov		al, 'h'					;al = 'h'
	call	WriteChar				;print 'h' to console
	mov		edx, offset msg2		;edx sets to exit message
	call    WriteString				;Print msg2 string to console

	call    ReadChar				;Pause program execution while user inputs a non-displayed char
	INVOKE	ExitProcess,0			;exit to dos: like C++ exit(0)

main ENDP							;end required
END main							;end required