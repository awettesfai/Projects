; Author: Awet Tesfai
; Section: 1002
; Date Last Modified: 7/25/2024
; Program Description: In this assignment we will be learning
; instructions to work with macros while using comparisons and jumps to
; create conditional and looping code.

; this macro helps convert string to integer without the decimal point
%macro convert2weight 2
; set the register for further use
; push registers for safety after the macro is executed
push rax
push rdx
push rcx
push rsi
push rdi
push r9
; declare constants for further use in the conversion
mov r8, 10
mov r12, 0
mov r9, 0
mov rax, 0
mov r10, 0
mov rbx, %1
mov rsi, 0
; set register for further use in the conversion
mov r9, 0 ; index
%%convert:
mov rax, 0 ; integer
mov r12, 0
cmp byte[rbx + r9], '-'
jne %%Length
inc r9
mov r12, 1
%%Length:
; get the characters and check if it equal to LF, if true loop to the next character
mov r10b, byte[rbx + r9]
inc r9
sub r10b, 48
cmp byte[rbx + r9], LF
je %%LengthInt
; sub with the ascii value of '0'
cmp byte[rbx + r9], NULL
je %%LengthInt
; add the value to the sum and multiply by 10
add rax, r10
mul r8
loop %%Length

; jump to this when the character after the current character is NULL
; then add to the sum without multiplying
%%LengthInt:
add rax, r10
cmp r12, 1
jne %%positive
neg rax
%%positive:
mov dword[%2 + rsi * 4], eax
mov r11, 0
cmp byte[rbx + r9], NULL
je %%endloop
inc rsi
inc r9
jmp %%convert
%%endloop:
pop r9
pop rdi
pop rsi
pop rcx
pop rdx
pop rax
%endmacro

; this macro helps convert to string
; this code is from page 169 of the textbook
; Jorgensen, Ed. X86-64 Assembly Language Programming with Ubuntu. 2020.

%macro convert2string 3
; convert an integer to a string
mov eax, %1
mov rcx, 0
mov ebx, 10
mov r12, 0
; successive division
cmp eax, 0
jg %%divideLoop
neg eax
mov r12, 1
%%divideLoop:
mov edx, 0
div ebx
; push remainder and increment digitCount
push rdx
inc rcx
; if eax is 0, end the loop
cmp eax, 0
jne %%divideLoop
; convert remainders and store
mov rbx, %2
mov rdi, 0
cmp r12, 1
jne %%popLoop
mov r8b, '-'
mov byte[rbx], r8b
mov rdi, 1
%%popLoop:
; pop the digits
pop rax
; add with '0' to convert to ascii
add al, '0'
; move the ascii to the string and check by decrementing the digit count
mov byte [rbx + rdi], al
inc rdi
dec rcx
; if there are no more digits, end the loop
cmp rcx, 0
jne %%popLoop

mov byte[rbx + rdi], LF
inc rdi
mov byte[rbx + rdi], NULL
mov qword[%3], rdi
%endmacro


section .data
; -----
; Define standard constants.
BASE equ 10
LF equ 10 ; line feed
NULL equ 0 ; end of string
TRUE equ 1
FALSE equ 0
EXIT_SUCCESS equ 0 ; success code
STDIN equ 0 ; standard input
STDOUT equ 1 ; standard output
STDERR equ 2 ; standard error
SYS_read equ 0 ; read
SYS_write equ 1 ; write
SYS_open equ 2 ; file open
SYS_close equ 3 ; file close
SYS_fork equ 57 ; fork
SYS_exit equ 60 ; terminate
SYS_creat equ 85 ; file open/create
SYS_time equ 201 ; get time

O_CREAT		equ	0x40
O_TRUNC		equ	0x200
O_APPEND	equ	0x400

O_RDONLY	equ	000000q			; file permission - read only
O_WRONLY	equ	000001q			; file permission - write only
O_RDWR		equ	000002q			; file permission - read and write

S_IRUSR		equ	00400q
S_IWUSR		equ	00200q
S_IXUSR		equ	00100q

BUFFMAX     equ 3000 ; constant BUFFMAX is used to set the size for string buffers
WORDLENGTH  equ 20 ; constant WORDLENGTH is used to set the size for string input
; Declare constant variables to help with the input format
errormsg db "Error opening file, please try again", LF, NULL
pmptmsg db "Filename: ", NULL
fileDiscriptor dq 0 ; store the file discriptor of the file
dynamicSize dq 0 ; amount of size to allocate from the stack
negValue dd 0 ;temp dword variable to help output the list
numberofIntegers dq 0 ; size of the array of integers in the stack
numberOfCharacters dq 0 ; number of characters stored in temp char
filename db "sorted.txt", NULL ; file out name

section .bss
stringBuffer resb WORDLENGTH ; variable to help keep the converted integer
BFMAX resb BUFFMAX ; helps read the variables from the file
chr resb WORDLENGTH ; helps store the user file input

dwordArray resd 200
section .text
global _start
_start:

; index used to help terminate the user input with NULL
mov r8, 0

OpenFile:
mov rdi, pmptmsg ; prompt the user for the input
call printString
; use syscall to read the input from the user
mov rax, SYS_read
mov rdi, STDIN
mov rsi, chr
mov rdx, WORDLENGTH
syscall
; use nullterminate loop to find the LF in the string
; and replace with NULL
nullterminate:
mov al, byte[chr + r8]
cmp al, LF
je mov_NULL
inc r8
jmp nullterminate
mov_NULL:
mov al, NULL
mov byte[chr + r8], al
; use syscall to open the file input from the user
mov rax, SYS_open
lea rdi, byte[chr]
mov rsi, O_RDONLY
syscall
; if file is not open, output an error and restart
cmp rax, 0
jg print

Error_On_Read:
mov rdi, errormsg
call printString
jmp OpenFile
; save the file discriptor
print:
mov qword[fileDiscriptor], rax
; read the value of the file to BFMAX
mov rax, SYS_read
mov rdi, qword[fileDiscriptor]
mov rsi, BFMAX
mov rdx, BUFFMAX
syscall
; close the file
mov rax, SYS_close
mov rdi, qword[fileDiscriptor]
syscall

mov r9, 0 ; for the amount of space allocated from the stack
mov rsi, 0 ; is the index for BFMAX
mov rdi, 0 ; for the length of the integer array
; this loop helps calculate the amount of integers
; are found in the file by finding the amount of LF and NULL
allocateSpace:
mov al, byte[BFMAX + rsi]
inc rsi
cmp al, LF
je spaceNum
cmp al, NULL
je spaceNum
jmp allocateSpace
spaceNum:
inc r9d
inc rdi
cmp al, NULL
jne allocateSpace

; save the amount of integers
; convert the string numbers to integers
mov qword[numberofIntegers], rdi
convert2weight BFMAX, dwordArray


mov rsi, 1 ; perfome insertion sort by ingoring the first integer 

InsertionSort:
cmp rsi, qword[numberofIntegers] ; compare the index with the number of integers
jge printToTerminal

mov rbx, rsi ; set the second index to the current index
mov eax, dword[dwordArray + rsi * 4]

whileLoop:
cmp rbx, 0 ; compare the index to zero
jl swapElements

dec rbx

mov edx, dword[dwordArray + rbx * 4]
cmp eax, edx ; if the neighboring number is less than the current number, then swap
jge swapElements

mov dword[dwordArray + (rbx + 1) * 4], edx
jmp whileLoop

swapElements:
inc rsi
mov dword[dwordArray + (rbx + 1) * 4], eax
jmp InsertionSort

printToTerminal:
;Open the output file for writing
mov rax, SYS_creat
lea rdi, [filename]
mov rsi, S_IRUSR | S_IWUSR
syscall
mov qword[fileDiscriptor], rax ; save the file Discriptor

mov rbx, 0 ;index

writeLoop:
cmp rbx, qword[numberofIntegers] ; Check if we've processed all integers
je closeFile ; IF yes, close the file

; Convert the integer to a string
mov rax, 0
mov eax, dword[dwordArray + rbx * 4]
convert2string eax, stringBuffer, numberOfCharacters

mov rdi, stringBuffer
call printString
;Write the string to the file
mov rax, SYS_write
mov rdi, qword[fileDiscriptor] ; File descriptor
mov rsi, stringBuffer ; Address of the string to write
mov rdx, qword[numberOfCharacters]
syscall

inc rbx ; Move to the next integer
jmp writeLoop

closeFile:
; Close the output file
mov rax, SYS_close
mov rdi, qword[fileDiscriptor]
syscall

last:
    mov rax, SYS_exit
    mov rdi, EXIT_SUCCESS
    syscall

global printString
printString:
push rbx
; -----
; Count characters in string.
mov rbx, rdi
mov rdx, 0
strCountLoop:
cmp byte [rbx], NULL
je strCountDone
inc rdx
inc rbx
jmp strCountLoop
strCountDone:
cmp rdx, 0
je prtDone
; -----
; Call OS to output string.
mov rax, SYS_write ; system code for write()
mov rsi, rdi ; address of char's to write
mov rdi, STDOUT ; standard out
; RDX=count to write, set above
syscall ; system call
; -----
; String printed, return to calling routine.
prtDone:
pop rbx
ret