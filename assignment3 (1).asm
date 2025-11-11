; Author: Awet Tesfai
; Section: 1002
; Date Last Modified: 7/23/2024
; Program Description: In this assignment we will be learning
; instructions to work with arrays of data while using comparisons and jumps to
; create conditional and looping code.

section .data
; System Service Call Values
	SYSTEM_EXIT equ 60
	SUCCESS equ 0
	SYSTEM_WRITE equ 1
	STANDARD_OUT equ 1

BASE equ 10
NEWLINE equ 10

;   Termpreature array list
temperature dw -5, 2, 7, 9, 13, 17, 20, 28, 32, 36 
            dw 40, 47, 53, 52, 52, 55, 61, 69, 76, 77
            dw 79, 85, 91, 96, 100, 100, 101, 103, 102, 104
            dw 106, 109, 108, 106, 108, 106, 104, 102, 106
            dw 109, 110, 111, 112, 114, 112, 110, 108, 110
            dw 114, 113, 109, 108, 103, 100, 99, 95, 95, 95
            dw 91, 90, 88, 88, 83, 77, 77, 81, 81, 83
            dw 85, 81, 83, 82, 84, 79, 80, 81, 77, 74 
            dw 68, 66, 63, 60, 62, 59, 60, 58, 56, 68
            dw 72, 65, 65, 69, 69, 67, 65, 67, 69, 70, 73, 73

;   WindSpeed array list
    windSpeed dw 9, 30, 4, 11, 13, 25, 23, 14, 19, 18,
              dw 15, 0, 9, 15, 23, 18, 6, 27, 12, 25,
              dw 25, 23, 13, 12, 4, 13, 25, 14, 24, 10,
              dw 19, 20, 5, 17, 5, 14, 5, 11, 20, 6,
              dw 24, 22, 18, 23, 9, 9, 8, 23, 29, 6,
              dw 27, 9, 20, 18, 22, 13, 3, 8, 30, 20,
              dw 6, 7, 19, 16, 12, 7, 15, 16, 1, 2,
              dw 5, 21, 8, 6, 23, 22, 8, 18, 13, 16,  
              dw 16, 25, 14, 4, 15, 19, 7, 16, 16, 18,
              dw 24, 27, 11, 21, 3, 17, 8, 3, 0, 10

;   Humidity array list
    humidity dd 26034, 26777, 25655, 22240, 23804, 21570, 24796, 26677, 25049, 27166, 19670, 21333,
             dd 25674, 28870, 34828, 40000, 38645, 39305, 39561, 37738, 29006, 23787, 27829, 26352,
             dd 26483, 27588, 19898, 16415, 20070, 16530, 20412, 16756, 11315, 6297, 9828, 7359, 7330,
             dd 10271, 8427, 2059, 431, 0, 5108, 8776, 13909, 13814, 8240, 7426, 9574, 5312, 0, 6168,
             dd 6614, 9980, 38196, 40000, 35412, 33163, 28102, 21407, 26889, 21039, 22589, 15664, 13060, 
             dd 13860, 12757, 12842, 12036, 10965, 2480, 8663, 7153, 7818, 11953, 5854, 5972, 12555, 10179,
             dd 2862, 302, 633, 0, 4359, 0, 0, 0, 4583, 0, 2534, 2217, 0, 4202, 6507, 6880, 10851, 9802, 16317, 17056, 16833

;   count variable to help track of the array value
    count dq 100
;   tempAverage variable stores the average value to print it at the end
    tempAverage dw 0

;   These variables help print the Average value label
    labelAverage db "Average: "
    LABEL_AVERAGE_LENGTH equ 9
    labelUnit db "F", NEWLINE
    LABEL_UNIT_LENGTH equ 2

section .bss
    stringBuffer resb 6
    newTemp resw 100
section .text
global _start
_start:

;   rsi is used as index in the loop
    mov rsi, 0
;   r9w, r10w, and r12w are used to multiply and divide in calculations
    mov bx, 2
    mov r9w, 3
    mov r12w, 2500
;   r11w is used to store the total sum of newTemp
    mov r11w, 0
    newTempLoop:
;   check if the tempreature is less than 70 or greater than or equal to 80
    mov r8w, word[temperature + rsi * 2]
    cmp r8w, 80
    jae humidityloop
    cmp r8w, 70
    ja endloop

;   If the tempreature is not greater than or equal to 80, and isn't greater than 70
;   calculate the newTemp using windSpeed with temp - (3 * windSpeed / 2), then jump to endloop
    mov ax, word[windSpeed + rsi * 2]
    mov dx, 0
    div bx
    mul r9w
    sub r8w, ax
    mov word[temperature + rsi * 2], r8w
    jmp endloop

;   If the tempreature is greater than or equal to 80, then it jumps to humidity loop to calculate
;   using the humidity using temp + (humidity / 2500)
    humidityloop:
    mov ax, word[humidity + rsi * 4]
    mov dx, word[humidity + rsi * 4 + 2]
    idiv r12w
    add r8w, ax
    mov word[temperature + rsi * 2], r8w

;   endloop is used to add the total sum of the newTemp to calculate the average later
;   and increment the index as well as check if we reached the end of the loop
    endloop:
    add r11w, word[temperature + rsi * 2]
    inc rsi
    cmp rsi, 100
    jl newTempLoop

;   In the end, we calculate the average by moving 100 to bx, and moving the total sum to ax
;   and divide ax by bx then save the average to tempAverage inorder to print the average later
    mov bx, 100
    mov ax, r11w
    mov dx, 0
    idiv bx
    mov word[tempAverage], ax

;   Print the Average Label
    mov rax, SYSTEM_WRITE
	mov rdi, STANDARD_OUT
	mov rsi, labelAverage
	mov rdx, LABEL_AVERAGE_LENGTH
	syscall
	
	; Convert 32 Bit Signed Number to 6 Character String
	; Check if number is negative
    mov r8w, word[tempAverage]
	mov r12b, 0 ; Sign 0 for Positive, 1 for Negative
	cmp r8w, 0
	jge notNegative
	; Negative Found
		mov r12b, 1
		neg r8w
	notNegative:
	
	; Extract Digits to Stack
	mov r11, 0 ; Digit Count
	mov r10b, BASE ; Base
    mov ax, r8w
	conversionLoop:
	idiv r10b ; remainder ah is lowest remaining digit
	push rax
	cbw
	inc r11
	cmp al, 0
	jne conversionLoop
	
	mov rdx, 0 ; String Length
	cmp r12b, 1
	jne skipMinus
	inc rdx
	mov byte[stringBuffer], '-'
	skipMinus:
	
	addDigitsLoop:
		pop rcx ; Next digit is in ch
		add ch, '0' ; Convert digit to a character
		mov byte[stringBuffer + rdx], ch
		inc rdx
		dec r11
	cmp r11, 0
	ja addDigitsLoop
	
	
	; Print Average
	mov rax, SYSTEM_WRITE
	mov rdi, STANDARD_OUT
	mov rsi, stringBuffer
	syscall

	; Print Average Unit
	mov rax, SYSTEM_WRITE
	mov rdi, STANDARD_OUT
	mov rsi, labelUnit
	mov rdx, LABEL_UNIT_LENGTH
	syscall


last:
    mov rax, SYSTEM_EXIT
    mov rdi, SUCCESS
    syscall
