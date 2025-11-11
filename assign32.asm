; Author: Salem Biruk
; Section: WRITE YOUR SECTION HERE
; Date Last Modified: July 21 2024
; Program Description: This program will demonstrate mastery over arithmetic operations in x86 assembly.
section .data
; System Service Call Values
    SYSTEM_EXIT equ 60
    SUCCESS equ 0
    SYSTEM_WRITE equ 1
    STANDARD_OUT equ 1

; Constants
    BASE equ 10
    NEWLINE equ 10

; Temperature data
temperatures    dw -5, 2, 7, 9, 13, 17, 20, 28, 32, 36
                dw 40, 47, 53, 52, 52, 55, 61, 69, 76, 77
                dw 79, 85, 91, 96, 100, 100, 101, 103, 102, 104
                dw 106, 109, 108, 106, 108, 106, 104, 102, 106
                dw 109, 110, 111, 112, 114, 112, 110, 108, 110
                dw 114, 113, 109, 108, 103, 100, 99, 95, 95, 95
                dw 91, 90, 88, 88, 83, 77, 77, 81, 81, 83, 85, 81
                dw 83, 82, 84, 79, 80, 81, 77, 74, 68, 66, 63, 60
                dw 62, 59, 60, 58, 56, 68, 72, 65, 65, 69, 69, 67
                dw 65, 67, 69, 70, 73, 73

; Wind speed data (mph)
windSpeeds      dw 9, 30, 4, 11, 13, 25, 23, 14, 19, 18
                dw 15, 0, 9, 15, 23, 18, 6, 27, 12, 25
                dw 25, 23, 13, 12, 4, 13, 25, 14, 24, 10
                dw 19, 20, 5, 17, 5, 14, 5, 11, 20, 6
                dw 24, 22, 18, 23, 9, 9, 8, 23, 29, 6
                dw 27, 9, 20, 18, 22, 13, 3, 8, 30, 20
                dw 6, 7, 19, 16, 12, 7, 15, 16, 1, 2
                dw 5, 21, 8, 6, 23, 22, 8, 18, 13, 16
                dw 16, 25, 14, 4, 15, 19, 7, 16, 16, 18
                dw 24, 27, 11, 21, 3, 17, 8, 3, 0, 10

; Humidity data (parts per million)
humidity        dd 26034, 26777, 25655, 22240, 23804, 21570, 24796, 26677, 25049, 27166
                dd 19670, 21333, 25674, 28870, 34828, 40000, 38645, 39305, 39561, 37738
                dd 29006, 23787, 27829, 26352, 26483, 27588, 19898, 16415, 20070, 16530
                dd 20412, 16756, 11315, 6297, 9828, 7359, 7330, 10271, 8427, 2059, 431
                dd 0, 5108, 8776, 13909, 13814, 8240, 7426, 9574, 5312, 0, 6168
                dd 6614, 9980, 38196, 40000, 35412, 33163, 28102, 21407, 26889, 21039
                dd 22589, 15664, 13060, 13860, 12757, 12842, 12036, 10965, 2480, 8663
                dd 7153, 7818, 11953, 5854, 5972, 12555, 10179, 2862, 302, 633, 0
                dd 4359, 0, 0, 0, 4583, 0, 2534, 2217, 0, 4202, 6507
                dd 6880, 10851, 9802, 16317, 17056, 16833

; Count of temperatures
temperatureCount dw 100

labelAverage db "Average: "
LABEL_AVERAGE_LENGTH equ 9


section .bss
feelsLikeTemp resw 100    ; Array to store calculated "feels like" temperatures
stringBuffer resb 6       ; Buffer for converting temperatures to strings
averageDerivedTemperature resw 1 ; Store the average derived temperature
section .text
global _start
_start:
    ; Calculate "Feels Like" Temperatures
    mov rcx, 0              ; Initialize loop counter
calculateFeelsLikeLoop:
    mov ax, word [temperatures + rcx * 2]  
    mov bx, word [windSpeeds + rcx * 2]    
    mov edx, dword [humidity + rcx * 4]    

    cmp ax, 70
    jl calculateWindChill
    cmp ax, 80
    jge calculateHighHumidity
    ; Otherwise,
    jmp storeDerivedTemperature

calculateWindChill:
    ; newTemperature = temperature - ⌊( 3 x windSpeed )^2 / 2 ⌋
    mov r8w, bx 
    mov dx, 3
    imul dx  
    mov r13w, 2          ;
    idiv r13w
    sub ax, r8w            ; Subtract from temperature
    mov word [feelsLikeTemp + rcx * 2], ax
    jmp storeDerivedTemperature

calculateHighHumidity:
    ; newTemperature = temperature + ⌊ humidity / 2500 ⌋
    mov eax, edx  
    cdq         
    mov ebx, 2500
    idiv ebx        ; Divide by 2500
    add ax, word [temperatures + rcx * 2] ; newTemperature = temperature + (humidity / 2500)
    mov word [feelsLikeTemp + rcx * 2], ax
    jmp storeDerivedTemperature        

storeDerivedTemperature:
    mov [feelsLikeTemp + rcx * 2], ax   ; Store feelLiketemperature
    add cx, 1              ;
    cmp cx, word [temperatureCount]
    jl calculateFeelsLikeLoop         ; Loop 

calculateAverage:
    mov eax, 0            ; Initialize loop counter
    mov ebx, 0          
averageLoop:
    add bx, [feelsLikeTemp + rcx * 2]  ; Add current "feels like" temperature to sum
    inc eax               ; Increment loop counter
    cmp eax, [temperatureCount]
    jl averageLoop        ; Continue loop if rcx < temperatureCount

    ; Calculate average
    mov ax, bx
    mov cx, [temperatureCount]       ; Move temperatureCount to cx
    mov dx, 0               ; Clear dx for division
    idiv cx                 ; Divide sum by temperatureCount

    ; Store average derived temperature
    mov [averageDerivedTemperature], ax
    mov r9w, word[averageDerivedTemperature]
    
  ; Print Average Label
    mov rax, SYSTEM_WRITE
    mov rdi, STANDARD_OUT
    mov rsi, labelAverage
    mov rdx, LABEL_AVERAGE_LENGTH
    syscall

    ; Convert average derived temperature to string
    mov r12b, 0           ; Sign 0 for Positive, 1 for Negative
    cmp r9w, 0
    jge notNegativeAvg
    ; Negative Found
    mov r12b, 1
    neg r9w
    notNegativeAvg:

    ; Convert number to string
    mov r11, 0            
    mov r10b, BASE        ; Base
    mov ax, r9w            
    conversionLoopAvg:
        idiv r10b           
        push rax
        cbw
        inc r11
    cmp al, 0
    jne conversionLoopAvg

    mov rdx, 0            ; String Length
    cmp r12b, 1
    jne skipMinusAvg
    inc rdx
    mov byte [stringBuffer], '-'
    skipMinusAvg:

    addDigitsLoopAvg:
        pop rcx           
        add ch, '0'      
        mov byte [stringBuffer + rdx], cl
        inc rdx
        dec r11
    cmp r11, 0
    ja addDigitsLoopAvg


    ; Print Average
    mov rax, SYSTEM_WRITE
    mov rdi, STANDARD_OUT
    mov rsi, stringBuffer
    syscall


    ; Exit program
    mov rax, SYSTEM_EXIT
    mov rdi, SUCCESS
    syscall
