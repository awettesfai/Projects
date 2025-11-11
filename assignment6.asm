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

Days_of_the_week db "  Su  Mo  Tu  We  Th  Fr  Sa", LF, NULL
Months_of_the_year db "          January      ", LF, NULL, "          February      ", LF, NULL, "          March      ", LF, NULL,
                   db "          April      ", LF, NULL, "          May      ", LF, NULL, "          June      ", LF, NULL,
                   db "          July      ", LF, NULL, "          August      ", LF, NULL, "          September      ", LF, NULL
                   db "          October      ", LF, NULL, "          November      ", LF, NULL, "          December      ", LF, NULL
space db "    ", NULL
Number_Days_PerMonth dq 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
Days_Per_Month dd 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
               dd 11, 12, 13, 14, 15, 16, 17, 18,
               dd 19, 20, 21, 22, 23, 24, 25, 26,
               dd 27, 28, 29, 30, 31
number_of_years dd 2024, 2025
newlines db LF, NULL
string_Day_Length dq 0 ;5 not needed
string_Month_Length dq 0 
string_Week_Length dq 0 ; not needed
string_Year_Length dq 0 ; not needed
Leap_Year_Num dd 0
Starting_week_of_the_year dq 1
Number_of_days_in_a_week dq 7 ; not needed
section .bss
Temp_Day resb 4
Temp_Month resb 6
section .text
global _start
_start:

mov r11, 0 ; index for current month
mov r12, 0 ; pointer for the Months_of_the_year
; check to see if the current year is a leap year
lea rdi, dword[number_of_years]
call Leap_Year
mov dword[Leap_Year_Num], eax
cmp eax, 1
jne print_Month_Lp
; if it is a leap year, set the number of days in Februray to 29
mov rax, 29
mov qword[Number_Days_PerMonth + 8], rax

; print_month_Lp prints the days according to the current month
print_Month_Lp:
; print out the month name
; by adding r12 with the string_Month_Length, it helps us point to the next Month name
; and after pointing to the next month, we update string_month_length
add r12, qword[string_Month_Length]
lea rdi, byte[Months_of_the_year + r12]
mov rsi, string_Month_Length
call get_Length

; print out the month name
mov rax, SYS_write
mov rdi, STDOUT
lea rsi, byte[Months_of_the_year + r12]
mov rdx, qword[string_Month_Length]
syscall

; print the week header, by finding the length of the string first
lea rdi, byte[Days_of_the_week]
mov rsi, string_Week_Length
call get_Length

mov rax, SYS_write
mov rdi, STDOUT
lea rsi, byte[Days_of_the_week]
mov rdx, qword[string_Week_Length]
syscall

; check for the pointer of the day, to determine the amount of space needed
cmp qword[Starting_week_of_the_year], 7
jne print_Space
; if the pointer is equal to 7, then reset the pointer to zero
mov eax, 0
mov qword[Starting_week_of_the_year], rax
jmp print_Days
; print_Space prints the nessesary space before the days 
print_Space:
mov r8, 0
print_Space_Lp:
mov rax, SYS_write
mov rdi, STDOUT
lea rsi, byte[space]
mov rdx, 4
syscall

inc r8
cmp r8, qword[Starting_week_of_the_year]
jne print_Space_Lp


mov r10, qword[Starting_week_of_the_year] ; pointer for when to print newLine
mov r9, 0 ; Days_Per_Month index
print_Days:
lea rdi, dword[Days_Per_Month + r9 * 4]
mov rsi, Temp_Day ; Temp_day holds the converted string
call cvt_to_string

mov rdi, Temp_Day ; get the length
mov rsi, string_Day_Length
call get_Length
; print the day 
mov rax, SYS_write
mov rdi, STDOUT
lea rsi, byte[Temp_Day]
mov rdx, qword[string_Day_Length]
syscall
; inc the day counter to check whether to print a newLine or not
inc r10
mov qword[Starting_week_of_the_year], r10
cmp r10, qword[Number_of_days_in_a_week]
jne No_newLine

mov rax, SYS_write
mov rdi, STDOUT
lea rsi, byte[newlines]
mov rdx, 1
syscall

; if newline is printed, reset the day counter
mov r10, 0
No_newLine:
inc r9 
cmp r9, qword[Number_Days_PerMonth] ; check if we reached the end of the month
jne print_Days

last:
    mov rax, SYS_exit
    mov rdi, EXIT_SUCCESS
    syscall


; ; Argument 1 – Year as an integer value
; ; Returns – 1 if it is a leap year, 0 if it is not
global Leap_Year
Leap_Year:
push rbx
push rcx
push rdx
push r8
push r9
push r10
push r11
mov eax, dword[rdi]
mov edx, 0
mov ebx, 400
div ebx

cmp edx, 0
je Is_LeapYear

mov eax, dword[rdi]
mov edx, 0
mov ebx, 4
div ebx

cmp edx, 0
je Is_LeapYear

mov eax, 0
jmp end_LeapYear

Is_LeapYear:
mov eax, 1
end_LeapYear:
pop r11
pop r10
pop r9
pop r8
pop rdx
pop rcx
pop rbx
ret

; Argument 1 – String Address
; Argument 2 – Delimiting Character
; Argument 3 – Maximum Length to Check
; Returns – Number of characters in the string before finding a delimiting
; character (or the maximum), If the maximum length specified is 0, ignore the maximum length limit.
global get_Length
get_Length:
; -----
; Count characters in string.
mov rdx, 0
strCountLoop:
cmp byte [rdi + rdx], NULL
je strCountDone
inc rdx
; inc rbx
jmp strCountLoop
strCountDone:
cmp rdx, 0
je prtDone
prtDone:
add rdx, 1
mov qword[rsi], rdx
ret

; ; Argument 1 – 32 bit Unsigned Integer
; ; Argument 2 – String Address to store the result
; ; Returns – Nothing
global cvt_to_string
cvt_to_string:
push rbx
push rcx
push rdx
push r8
push r9
push r10
push r11
; convert an integer to a string
; mov eax, dword[rdi]
; mov rcx, 0
; mov ebx, 10
; mov rbx, rsi
push r8
push rcx
mov byte[rsi], ' '
mov byte[rsi + 1], ' '
mov r8, 2
mov eax, dword[rdi]
mov rcx, 0
mov ebx, 10
cmp eax, 10
jae divideLoop
mov byte[rsi + 2], ' '
inc r8
; successive division
divideLoop:
mov edx, 0
div ebx
; push remainder and increment digitCount
push rdx
inc rcx
; if eax is 0, end the loop
cmp eax, 0
jne divideLoop
; convert remainders and store
popLoop:
; pop the digits
pop rax
; add with '0' to convert to ascii
add al, '0'
; move the ascii to the string and check by decrementing the digit count
mov byte [rsi + r8], al
inc r8
dec rcx
; if there are no more digits, end the loop
cmp rcx, 0
jne popLoop
mov byte[rsi + r8], NULL
pop rcx
pop r8
mov eax, 0
pop r11
pop r10
pop r9
pop r8
pop rdx
pop rcx
pop rbx
ret

; Argument 1 – Days in Month
; Argument 2 – Month Label
; Argument 3 – Starting Weekday of Month: 0 for Sunday, 1 for Monday etc.
; Argument 4 – Address to Days of the Week Header
; Returns - Nothing
global print_month
print_month:
; print_month_Lp prints the days according to the current month
print_Month_Lp:
; print out the month name
; by adding r12 with the string_Month_Length, it helps us point to the next Month name
; and after pointing to the next month, we update string_month_length
add r12, qword[string_Month_Length]
lea rdi, byte[Months_of_the_year + r12]
mov rsi, string_Month_Length
call get_Length

; print out the month name
mov rax, SYS_write
mov rdi, STDOUT
lea rsi, byte[Months_of_the_year + r12]
mov rdx, qword[string_Month_Length]
syscall

; print the week header, by finding the length of the string first
lea rdi, byte[Days_of_the_week]
mov rsi, string_Week_Length
call get_Length

mov rax, SYS_write
mov rdi, STDOUT
lea rsi, byte[Days_of_the_week]
mov rdx, qword[string_Week_Length]
syscall

; check for the pointer of the day, to determine the amount of space needed
cmp qword[Starting_week_of_the_year], 7
jne print_Space
; if the pointer is equal to 7, then reset the pointer to zero
mov eax, 0
mov qword[Starting_week_of_the_year], rax
jmp print_Days
; print_Space prints the nessesary space before the days 
print_Space:
mov r8, 0
print_Space_Lp:
mov rax, SYS_write
mov rdi, STDOUT
lea rsi, byte[space]
mov rdx, 4
syscall

inc r8
cmp r8, qword[Starting_week_of_the_year]
jne print_Space_Lp


mov r10, qword[Starting_week_of_the_year] ; pointer for when to print newLine
mov r9, 0 ; Days_Per_Month index
print_Days:
lea rdi, dword[Days_Per_Month + r9 * 4]
mov rsi, Temp_Day ; Temp_day holds the converted string
call cvt_to_string

mov rdi, Temp_Day ; get the length
mov rsi, string_Day_Length
call get_Length
; print the day 
mov rax, SYS_write
mov rdi, STDOUT
lea rsi, byte[Temp_Day]
mov rdx, qword[string_Day_Length]
syscall
; inc the day counter to check whether to print a newLine or not
inc r10
mov qword[Starting_week_of_the_year], r10
cmp r10, qword[Number_of_days_in_a_week]
jne No_newLine

mov rax, SYS_write
mov rdi, STDOUT
lea rsi, byte[newlines]
mov rdx, 1
syscall

; if newline is printed, reset the day counter
mov r10, 0
No_newLine:
inc r9 
cmp r9, qword[Number_Days_PerMonth] ; check if we reached the end of the month
jne print_Days

ret

; ; Argument 1 – Address to Array of Days per Month
; ; Argument 2 – Starting Weekday of the Year: 0 for Sunday, 1 for Monday etc.
; ; Argument 3 – Current Calendar Year as an integer
; ; Argument 4 – Address to Year label
; ; Argument 5 – Number of newlines between each month (0 or greater)
; ; Argument 6 – Address to Days of the Week Header
; ; Arguments 7 to 18 – Addresses to string labels for each month
; ; Returns - Nothing
; global print_year
; print_year:


; ret