; Author: Awet Tesfai
; Section: 1002
; Date Last Modified: 08/06/2024
; Program Description: This assignment will explore the use of accessing functions from a
; library and processing command line arguments.
section .data
; -----
; Define standard constants.
StringLength equ 50
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

; Constants to help calculate the radius and volume
PI dq 3.12159 
two dq 2.0
three dq 3.0
zero dq 0.0

Halfspheremsg db "Halfsphere Volume: %f", LF, NULL ; output message
errormsg db "Error input, please try again", LF, NULL	; error message

section .bss
; declare extern functions
extern atof, printf, fflush

section .text
global main
main:
; check if the amount of strings is 3
mov r12, rdi
cmp r12, 3
jne Output_error
; check if the second string is equal to '-d',NULL
mov r13, qword[rsi + 8]
cmp byte[r13], '-'
jne Output_error
cmp byte[r13 + 1], 'd'
jne Output_error
cmp byte[r13 + 2], NULL
jne Output_error
; convert the third string to a double-precision float
mov r13, qword[rsi + 16]
mov rdi, r13
call atof

ucomisd xmm0, qword[zero]
je Output_error

movsd xmm1, xmm0 ; move the converted result to xmm1
movsd xmm0, qword[two]
movsd xmm2, qword[three]
movsd xmm4, qword[PI]
divsd xmm1, xmm0 ; get the radius
movsd xmm3, xmm1
mulsd xmm1, xmm1
mulsd xmm1, xmm3 ; radius ^ 3
mulsd xmm1, xmm4 ; radisu * PI
mulsd xmm1, xmm0 ; 2 * radius * PI
divsd xmm1, xmm2 ; (2 * radius * PI) / 3
movsd xmm0, xmm1 ; move the result to xmm0 to print the result

ucomisd xmm0, qword[zero]
jb Output_error
; output the Halfsphere volume
mov rax, 1
mov rdi, Halfspheremsg
and rsp, 0xFFFFFFF0
call printf
; end the program
jmp last
Output_error:
mov rax, 0
mov rdi, errormsg
and rsp, 0xFFFFFFF0
call printf
last:
    mov rax, SYS_exit
    mov rdi, EXIT_SUCCESS
    syscall
