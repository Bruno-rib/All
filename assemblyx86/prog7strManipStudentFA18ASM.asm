;Programmer name: 
;Bruno Silva Ribeiro


;The uses directive after PROC automatically pushes the registers
;listed at the beginning of your function
;and automatically pops them at the end of the function.

;In the given functions: 

;To allocate memory for a local variable use the "local" directive
;(see StrInsert below)

.486

.model flat, stdcall

MAX_LEN EQU 0FFFFFFFFh

.code

;StrLenAsm - find the lenght of a 0 terminated string not including terminating 0
;    entry: strAdd contains address of string to find length of
;     exit: eax contains the string length
;
;    example: length of "hello",0 is 5
;
;  To call StrLen from another assembly function, push the argument on the
;  stack and then call StrLen.
;       assume esi stores the address of the string to find the length of:
;          push esi
;          call StrLen  ;length is returned in eax
;          ;no stack cleanup needed
;
;  No stack cleanup needed after calling StrLen. StrLen automatically
;  adjusts stack pointer after it finishes.
;

StrLenAsm PROC uses edi,    ;save edi
           strAdd:DWORD     ;address of string to find length of

    mov edi, strAdd         ;edi = address of string to get length of
    xor eax,eax             ;eax to hold length so 0 it out

looptop:
    cmp byte ptr [edi],0    ;have we reached the end of the string yet?
    je doneStrLen           ;Yes, done
    inc edi                 ;no, increment to next character
    inc eax                 ;and increment length
    jmp looptop             ;repeat

doneStrLen:                 ;jump if equal

ret                         ;return to caller

StrLenAsm ENDP              ;end of StrLenAsm
;

;----------------------------------------------
;StrCpyAsm - Copy  zero terminated string2 (including terminating 0) 
;            to zero terminated string1
;             
;   entry: str1Add contains the address of string1
;          str2Add contains the address of string2
;   exit:  NONE (no return value)
;
;   example: char str1[]= {'h','e','l','l','o',' ','w','o','r','l','d',0};
;            char str2[]= {'G','o','o','d','-','b','y','e',0};
;
;            StrCpyAsm(str1,str2); 
;            after copy str1 contains: 'G','o','o','d','-','b','y','e',0,'l','d',0
;
;  No stack cleanup needed after calling StrCpyAsm. StrCpyAsm automatically
;  adjusts stack pointer after it finishes.
;
;   To call StrCpyAsm from an asm function use:
;       
;       push str2Add ;address of string 2
;       push str1Add ;address of string 1
;       call StrCpyAsm
;       ;no add esp, 8 needed because stack cleaup automatically done
;
;   Note: the parameters below (str1Add and str2Add) contain the address of the 
;         strings you want to work with. To transfer those addesses to a register
;         just use mov reg, str1Add 
;         Do not use mov reg, offset str1Add and 
;         do not use lea reg, str1Add


StrCpyAsm PROC  uses ecx eax esi edi,   ;save registers used;;;;;;;;;;;;;;;;;ADD ECX BACK
                       str1Add:DWORD,   ;address of string1
                       str2Add:DWORD    ;address of string2

    cld                                 ;forward direction - clear direction flag
    push str2Add                        ;address of str2 arg to StrlenAsm
    call StrLenAsm                      ;get length of str2
                                        ;called function responsible for stack cleanup
    mov  ecx,eax                        ;length of string in ecx for rep
    mov  edi,str1Add                    ;edi gets destination address for copy
    mov  esi,str2Add                    ;esi gets source address for copy
    rep  movsb                          ;copy byte from source to desintation ecx times
    mov  byte ptr[edi],0                ;null terminate copied string
    
    ret                                 ;return to caller

StrCpyAsm ENDP                          ;end of funcion StrCpyAsm                     

;----------------------------------------------
;StrNCpyAsm - copy zero terminated string2 to zero terminated string1, 
;             but copy no more than count (parameter) characters
;             or the length of string2, whichever comes first
;   entry: - str1Add contains the address of string1
;          - str2Add contains the address of string2
;          - count contains the max number of characters to copy
;   exit:  NONE (no return value so do not use edi to return an address)
;
;       Note: StrNCpyAsm does not zero terminate the copied string
;             unless the 0 is within count characters copied.
;
;   example1: char str1[]= {'h','e','l','l','o',' ','w','o','r','l','d',0};
;             char str2[]= {'G','o','o','d','-','b','y','e',0};
;            StrNCpyAsm(str1,str2,4);//terminating 0 not copied since only 4 characters copied
;                                   ;//and terminating 0 not within the 4 characters
;            after copy str1 contains: 'G','o','o','d','o',' ','w','o','r','l','d',0
;
;   example2: use str1 and str2 from example1
;      
;            StrNCpyAsm(str1,str2,9);  //terminating 0 copied since terminating 0 
;                                      //within 9 characters copied
;            str1 contains: 'G','o','o','d','-','b','y','e',0,'l','d',0
;
;   example3: use str1 and str2 from example1
;      
;            StrNCpyAsm(str1,str2,15);//copy 15 characters upto and including 0,
;                                     //whichever comes first
;            //only 9 characters including 0 copied 
;            after copy str1 contains: 'G','o','o','d','-','b','y','e',0,'l','d',0
;
;   The above is how you would call StrNCpyAsm from C++.
;
;   To call StrNCpyAsm from an asm function use:
;       
;       push 20 ;max num of characters to copy
;       push str2Add ;address of string 2
;       push str1Add ;address of string 1
;       call StrNCpyAsm
;       ;no add esp, 12 needed because stack cleaup automatically done
;
;
; hint1: use StrLenAsm to get the number of characters in str2
; hint2: the length returned by StrLenAsm does not include terminating 0
; hint3: copy the lesser of the length of the string (including terminating 0)
;        or count characters
;copy to ecx the lesser of count or the length of string2 (including terminating 0)
;  Please note for the above, you need the length of string2 including terminating 0.
;  StrLenAsm returns the length not including terminating 0
;populate esi and edi with the correct values
;clear the direction flag
;
;Do not use a loop in this function. use rep and movsb to copy	
;
;   Note: the parameters below (str1Add and str2Add) contain the address of the 
;         strings you want to work with. To transfer those addesses to a register
;         just use mov reg, str1Add 
;         Do not use mov reg, offset str1Add and 
;         do not use lea reg, str1Add
;

StrNCpyAsm PROC uses eax esi edi ecx    ,   ;save registers used
                            str1Add:DWORD,  ;address of string1
                            str2Add:DWORD,  ;address of string2
                            count:DWORD     ;max chars to copy
 
    push str2Add                            ;address of str2 arg to StrlenAsm
    call StrLenAsm                          ;get length of str2 returned in eax
                                            ;called function responsible for stack cleanup
    mov  edx, eax                           ;save the length on edx to use as count

    mov  edi,str1Add                        ;edi gets destination address for copy
    mov  esi,str2Add                        ;esi gets source address for copy
    cld                                     ;forward direction - clear direction flag
	mov  ecx, count                         ;save count to ecx to find smaller
    cmp  edx, ecx                           ;find smaller

    jge  stringLarger                       ;jump if string is larger
    xchg ecx, edx                           ;exchange ecx with edx so we can use ecx as counter
    rep  movsb                              ;copy byte from source to desintation ecx times
    mov  byte ptr[edi],0                    ;add zero if the string has it
    jmp  doneHere                           ;jumps over the next block of code

stringLarger:                               ;jump here if ecx is larger

    rep  movsb                              ;copy byte from source to destination ecx times
    
doneHere:                                   ;jump here to skip stringLarger

    ret                                     ;return to caller

StrNCpyAsm ENDP                             ;end of function StrNCpyAsm

;--------------------------------------------
;StrCatAsm - append  0 terminated string2 to  0 terminated string1
;   entry: str1Add contains the address of string1
;          str2Add contains the address of string2
;   exit:  NONE
;   note: StrCatAsm puts in terminating 0
;
;   example: char str1[] = {'h','e','l','l','o',0};
;            char str2[] = {'w','o','r','l','d',0};
;   after StrCatAsm(str1,str2) 
;            string1 = 'h','e','l','l','o','w','o','r','l','d',0
;
;  The above is how you would call StrCatAsm from C++.
;
;  To call StrCatAsm from another asm function use:
;
;   To call StrCatAsm from an asm function use:
;       
;       push str2Add ;address of string 2
;       push str1Add ;address of string 1
;       call StrCatAsm
;       ;no add esp, 8 needed because stack cleaup automatically done

;
; Do not use a loop in this function. 
; Do not call StrLenAsm in this function.

; StrCatAsm should zero terminate the concatenated string which is done by StrCpyAsm
; when you call it to copy str2 to the end of str1.
;
; Choose 2 instructions from the following string instructions to use:
; rep, repe, repne, movsb,stosb,cmpsb,scasb
;
;populate ecx with MAX_LEN defined at the top of this file
;get to the end of str1 using two string instructions
;then call StrCpyAsm to copy str2 to end of str1.
;
;   Note: the parameters below (str1Add and str2Add) contain the address of the 
;         strings you want to work with. To transfer those addesses to a register
;         just use mov reg, str1Add 
;         Do not use mov reg, offset str1Add and 
;         do not use lea reg, str1Add

StrCatAsm PROC  uses edx eax edi ecx esi  , ;save registers used
                    str1Add:DWORD,          ;address of string1
                    str2Add:DWORD           ;address of string2
   
    cld                                     ;forward direction - clear direction flag
    mov     edi,str1Add                     ;edi gets destination address for copy
    mov     esi,str2Add                     ;esi gets source address for copy
    
    mov     ecx, MAX_LEN                    ;save MAX_LEN to ecx according to instructions
    mov     eax, 0			                ;element to search for  
	repne   scasd			                ;repeat scan until element found or until ECX == 0
    
    mov     edx, MAX_LEN                    ;use MAX_LEN on edx to find the difference
    sub     edx, ecx                        ;find the difference and save on edx    
    add     str1Add, edx                    ;add the offset to str1Add address
     
    push    str2Add                         ;save parameter to call function
    push    str1Add                         ;save parameter to call function
    call    StrCpyAsm                       ;call function to copy at the end

    mov     byte ptr[edi],0                 ;null terminate copied string

    ret                                     ;return to caller

StrCatAsm ENDP                              ;end of function StrCatAsm

;StrRemove - Remove count characters from str1 starting at location
;
;    entry: - addStr contains the address of the string to remove characters from
;           - location contains the location in the string to start removing characters from
;           - count contains the max number of characters to remove
;   exit:   NONE (no return value)
;
; Note: location starts at 0 and counting starts on the left.
;
; For example: 
;
; location 0123
;  str1 = "Be my friend" location = 3 ('m') count = 3
;  after StrRemove(strAdd,3,3) str1 = "Be friend"
;
;  hint1: setup source to the address of location + count
;  hint2: setup destination to the address of location.
;  hint3: copy source to destination (think StrCpyAsm)
;
;   Do not use a loop and you don't even need to use the
;   string instructions, just use StrCpyAsm
;
;   To call StrRemove from C++  use: 
;       StrRemove(str1,4,8);
;
;   The above means remove 8 chars from str1 starting at location 4
;
;   Note: the parameter below (addStr) contains the address of the 
;         strings you want to work with. To transfer that addess to a register
;         just use mov reg, str1Add 
;         Do not use mov reg, offset str1Add and 
;         do not use lea reg, str1Add



StrRemove PROC uses edi esi ebx ecx,    ;save registers used
               strAdd:DWORD,            ;address of string to remove chars from
             location:DWORD,            ;location in string to start removing chars from
                count:DWORD             ;number of chars to remove

    cld                                 ;forward direction - clear direction flag        
    mov     esi, strAdd                 ;save address to esi
    mov     ebx, location               ;save parameter location to ebx
    mov     ecx, count                  ;save count to ecx

    add     esi, ebx                    ;add the to the address
    mov     edi, esi                    ;set up edi to add second offset
    add     edi, ecx                    ;add the second offset

    push    edi                         ;push parameter to call function
    push    esi                         ;push parameter to call function
    call    StrCpyAsm                   ;call function

    ret                                 ;return to caller

StrRemove ENDP                          ;end function StrRemove

;*************Extra Credit - StrInsertEC************************
;For extra credit code StrInsertEC below

;See the program 8 specifications document (pdf file)
;on the class web site for full instructions about
;implementing StrInsertEC below.

;StrInsertEC - Insert str2 into str1 at position
;
;    entry: - str1 contains the address of string1
;           - str2 contains the address of string2
;           - position contains the position in string 1 to insert string 2 at.
;    exit:   NONE (no return value)
;
; Note: position starts at 0 and counting starts on the left.
;
; For example: 
;
; position 0123456
;  str1 = "Be my friend today" and str2 = "good " position = 6 ('f')
; after StrInsert(str1,str2,6) str1 = "Be my good friend today"
;
; Note: No checking is done to make sure str1 is big enough to
; accomodate the insert.
;
;In the extra credit version do not copy part of string 1 to a 
;buffer so there will be no need for a local variable.

;Just work within string 1 and copy part of str1(from position 
;to the end of str1) towards the end of the str1 to make 
;room for the string to insert (str2). 
;
;You should not use a loop.
;
;You should use string instructions to copy string 1 down within itself. 
;You can use StrNCpyAsm to copy str2 into str1 starting at position.
;
;   To call StrInsertEC from C++  use: 
;       StrInsertEC(str1,str2,12);
;
;   The above means insert str2 into str1 starting at position 12 in str1.
;
;   Note: the parameters below (str1Add and str2Add) contain the address of the 
;         strings you want to work with. To transfer those addesses to a register
;         just use mov reg, str1Add 
;         Do not use mov reg, offset str1Add and 
;         do not use lea reg, str1Add

StrInsertEC PROC  str1Add:DWORD , ;string 1 address
                  str2Add:DWORD,  ;string 2 address
                  position:DWORD  ;position to insert at in str1
  
	mov edi, str1Add
	mov esi, str2Add
	mov ecx, position

    ;Student code here( you may change or delete any of the above 3 lines of code for efficiency if necessary)
	;If you use the above 3 lines, you  must comment them

ret

StrInsertEC ENDP

END