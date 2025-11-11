; Author: Awet Tesfai
; Section: 1002
; Date Last Modified: 7/23/2024
; Program Description: In this assignment we will be learning
; instructions to work with macros while using comparisons and jumps to
; create conditional and looping code.

; Print String help output the string to the terminal
%macro printString 1
push rax
push rdi
push rsi
push rdx
push rcx
;----
;count characters in string.
lea rdi, [%1]
mov rdx, 0
%%stringLoop:
cmp byte [rdi + rdx], NULL
je %%stringDone
inc rdx
jmp %%stringLoop
%%stringDone:
cmp rdx, 0
je %%printDone
; -----
; Call OS to output string.
mov rax, SYS_write
mov rdi, STDOUT
lea rsi, [%1]
syscall
%%printDone:
pop rcx
pop rdx
pop rsi
pop rdi
pop rax
%endmacro


; %1: char, %2: inLine
; GetInput helps read the inputs from the user
%macro getInput 2
push rax
push rbx
push rdi
push rsi
push rdx
push rcx

mov rbx, %2
mov r12, 0
%%readCharacters:
mov rax, SYS_read
mov rdi, STDIN
lea rsi, byte[%1]
mov rdx, 1
syscall

mov al, byte[%1]
cmp al, LF
je %%readDone
inc r12
cmp r12, StringLength
jae %%readCharacters

mov byte[rbx], al
inc rbx
jmp %%readCharacters
%%readDone:
mov byte[rbx], NULL

pop rcx
pop rdx
pop rsi
pop rdi
pop rbx
pop rax
%endmacro

; this macro help convert the string to integer
%macro string2integer 2

mov r8, 10
mov r12, 0
mov r9, 0
mov rax, 0
mov r10, 0
mov rbx, %1
cmp byte[rbx], '0'
je %%errorLp
cmp byte[rbx], '.'
je %%errorLp
; error check help check for errors
%%errorCheck:
cmp byte[rbx + r9], LF
je %%skipLF
cmp byte[rbx + r9], '.'
je %%DecimalCheck
cmp byte[rbx + r9], '0'
jb %%errorLp
cmp byte[rbx + r9], '9'
ja %%errorLp
%%skipLF:
inc r9
cmp byte[rbx + r9], NULL
jne %%errorCheck
jmp %%cvt2Str

; check for any errors after decimal point
%%DecimalCheck:
inc r9
%%DecimalErrCheck:
cmp byte[rbx + r9], LF
je %%DecimalskipLF
cmp byte[rbx + r9], '0'
jb %%errorLp
cmp byte[rbx + r9], '9'
ja %%errorLp
%%DecimalskipLF:
inc r9
cmp byte[rbx + r9], NULL
jne %%DecimalErrCheck

; this loop converts the string to integers * 100
; considering the decimal point
%%cvt2Str:
mov r9, 0
mov rax, 0
mov r11, 0
%%Length:
mov r10b, byte[rbx + r9]
mov r11, rax
inc r9
cmp r10b, LF
je %%Length
cmp r10b, '.'
je %%Length
sub r10b, 48
cmp byte[rbx + r9], NULL
je %%LengthInt
mov r11, 2
add rax, r10
mul r8
loop %%Length

%%DecimalPoint:
mov r11, 1
loop %%Length

%%LengthInt:
add rax, r10
cmp r11, 0
ja %%endloop
mul r8
mul r8
cmp r11, 1
ja %%endloop
mul r8
loop %%endloop

%%errorLp:
mov eax, -1


%%endloop:
mov dword[%2], eax
%endmacro

; this macro helps convert string to integer without the decimal point
%macro convert2weight 2
mov r8, 10
mov r12, 0
mov r9, 0
mov rax, 0
mov r10, 0
mov rbx, %1
cmp byte[rbx], '0'
je %%errorLp
cmp byte[rbx], '.'
je %%errorLp
%%DecimalErrCheck:
cmp byte[rbx + r9], LF
je %%DecimalskipLF
cmp byte[rbx + r9], '0'
jb %%errorLp
cmp byte[rbx + r9], '9'
ja %%errorLp
%%DecimalskipLF:
inc r9
cmp byte[rbx + r9], NULL
jne %%DecimalErrCheck

mov r9, 0
mov rax, 0
%%Length:
mov r10b, byte[rbx + r9]
inc r9
cmp r10b, LF
je %%Length
cmp r10b, '.'
je %%Length
sub r10b, 48
cmp byte[rbx + r9], NULL
je %%LengthInt
add rax, r10
mul r8
loop %%Length

%%LengthInt:
add rax, r10
loop %%endloop
%%errorLp:
mov eax, -1


%%endloop:
mov dword[%2], eax
%endmacro


; this macro helps convert to string

%macro convert2string 2

mov eax, dword[%1]
mov rcx, 0
mov ebx, 10

%%divideLoop:
mov edx, 0
div ebx

push rdx
inc rcx

cmp eax, 0
jne %%divideLoop

mov rbx, %2
mov rdi, 0

%%popLoop:
pop rax

add al, '0'

mov byte [rbx + rdi], al
inc rdi
dec rcx
cmp rcx, 0
jne %%popLoop

mov byte[rbx + rdi], NULL
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


; variables to help with the terminal
StringLength equ 50
pmpt db "Price Comparator", LF, NULL
pmptLine db "----------------",LF, NULL
ItemOnePrice db "Item1 Price: $", NULL
ItemOneWeight db "Item1 Weight (ounces): ", NULL
ItemTwoPrice db "Item2 Price: $", NULL
ItemTwoWeight db "Item2 Weight (ounces): ", NULL
ItemOneresult db "Item1 ", NULL
ItemTworesult db "Item2 ", NULL
cents_ounce db " cents/ounces", LF, NULL
better db "is more expensive", LF, NULL
andStr db " and "
equal db "are the same price", LF, NULL
errorLine db "Error input", LF, NULL
newLine db LF, NULL

item1 dd 0
weight1 dd 0
answer1 dd 0
weight2 dd 0
item2 dd 0
answer2 dd 0

section .bss
chr resb 1
PriceOne resb StringLength
WeightOne resb StringLength
PriceTwo resb StringLength
WeightTwo resb StringLength
stringBuffer resb StringLength
strAnswer1 resb StringLength
strAnswer2 resb StringLength

section .text
global _start
_start:

printString pmpt
printString pmptLine
printString ItemOnePrice
getInput chr, PriceOne
string2integer PriceOne, item1
mov eax, dword[item1]
cmp eax, -1
je errorInput
printString ItemOneWeight
getInput chr, WeightOne
convert2weight WeightOne, weight1
mov eax, dword[weight1]
cmp eax, -1
je errorInput
printString newLine
printString ItemTwoPrice
getInput chr, PriceTwo
string2integer PriceTwo, item2
mov eax, dword[item2]
cmp eax, -1
je errorInput
printString ItemTwoWeight
getInput chr, WeightTwo
convert2weight WeightTwo, weight2
mov eax, dword[weight2]
cmp eax, -1
je errorInput


mov eax, dword[item1]
mov edx, 0
div dword[weight1]
mov dword[answer1], eax


mov eax, dword[item2]
mov edx, 0
div dword[weight2]
mov dword[answer2], eax

convert2string answer2, strAnswer2
convert2string answer1, strAnswer1


printString newLine
printString ItemOneresult
printString strAnswer1
printString cents_ounce
printString ItemTworesult
printString strAnswer2
printString cents_ounce

mov eax, dword[answer1]
mov ebx, dword[answer2]
cmp eax, ebx
ja printItemOne
cmp eax, ebx
jb printItemTwo
printString ItemOneresult
printString andStr
printString ItemTworesult
printString equal


jmp last
printItemOne:
printString ItemOneresult
printString better
jmp last
printItemTwo:
printString ItemTworesult
printString better
jmp last
errorInput:
printString errorLine
last:
    mov rax, SYS_exit
    mov rdi, EXIT_SUCCESS
    syscall