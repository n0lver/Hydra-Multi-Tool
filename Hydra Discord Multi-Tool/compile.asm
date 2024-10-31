; This is an extended assembly program for x86, using DOS interrupts.
; This program demonstrates a variety of operations including I/O, loops,
; arithmetic operations, string manipulations, recursive functions, and file I/O.
; Requires DOSBox or similar to run, as it uses DOS interrupts.

section .data
    hello_msg db 'Hello, Extended Assembly World!', 0
    newline db 13, 10, '$'
    prompt_msg db 'Enter a number for factorial and Fibonacci: $'
    factorial_result_msg db 'Factorial is: $'
    fibonacci_result_msg db 'Fibonacci is: $'
    compare_msg db 'Comparing "hello" and "world": $'
    file_open_msg db 'Opening and writing to file: $'
    eof_msg db 13, 10, 'End of File', 13, 10, '$'

    input_number db 0                    ; Storage for user input number
    factorial_result db 0                ; Storage for factorial result
    fibonacci_result db 0                ; Storage for Fibonacci result
    string1 db 'hello', 0
    string2 db 'world', 0

    ; Buffer for file I/O
    file_name db 'output.txt', 0
    file_handle dw 0
    file_data db 'Data written to file by assembly code', 0

section .bss
    buffer resb 10                       ; General-purpose buffer for numbers

section .text
global _start

_start:
    ; Print Hello message
    mov ah, 09h                ; DOS interrupt to display a string
    mov dx, hello_msg
    int 21h

    ; Print a new line
    mov ah, 09h
    mov dx, newline
    int 21h

    ; Input a number from the user
    mov ah, 09h
    mov dx, prompt_msg
    int 21h
    call get_input               ; Get a number input from user

    ; Calculate factorial of input number
    mov al, [input_number]
    call factorial
    mov [factorial_result], al   ; Store factorial result

    ; Print factorial result
    mov ah, 09h
    mov dx, factorial_result_msg
    int 21h
    mov dl, [factorial_result]
    add dl, '0'                  ; Convert to ASCII
    mov ah, 02h
    int 21h

    ; Calculate Fibonacci of input number
    mov al, [input_number]
    call fibonacci
    mov [fibonacci_result], al   ; Store Fibonacci result

    ; Print Fibonacci result
    mov ah, 09h
    mov dx, fibonacci_result_msg
    int 21h
    mov dl, [fibonacci_result]
    add dl, '0'                  ; Convert to ASCII
    mov ah, 02h
    int 21h

    ; Compare two strings
    mov ah, 09h
    mov dx, compare_msg
    int 21h
    mov si, string1
    mov di, string2
    call compare_strings

    ; File I/O operations
    mov ah, 09h
    mov dx, file_open_msg
    int 21h
    call file_write

    ; Print End of File message
    mov ah, 09h
    mov dx, eof_msg
    int 21h

    ; Exit program
    mov ax, 4C00h
    int 21h

;----------------------------------------------
; Function: factorial
; Description: Computes factorial of a number in AL
;----------------------------------------------
factorial:
    cmp al, 1
    jbe .done                   ; If number <= 1, return
    dec al                      ; AL = AL - 1
    push ax                     ; Save current value
    call factorial              ; Recursive call
    pop bx                      ; Retrieve previous value
    mul bl                      ; AL = AL * BL
.done:
    ret

;----------------------------------------------
; Function: fibonacci
; Description: Computes the nth Fibonacci number in AL
;----------------------------------------------
fibonacci:
    cmp al, 2
    jb .base_case               ; If n < 2, base case
    dec al                      ; AL = AL - 1
    push ax                     ; Save current n
    call fibonacci              ; F(n-1)
    mov bl, al                  ; Store F(n-1) in BL
    pop ax                      ; Restore original n
    dec al                      ; AL = AL - 2
    push ax                     ; Save F(n-2)
    call fibonacci              ; F(n-2)
    add al, bl                  ; F(n) = F(n-1) + F(n-2)
    pop bx                      ; Restore
    ret
.base_case:
    mov al, 1                   ; F(0) = F(1) = 1
    ret

;----------------------------------------------
; Function: get_input
; Description: Gets a single digit input from the user
;----------------------------------------------
get_input:
    mov ah, 01h                ; DOS interrupt to read a character
    int 21h
    sub al, '0'                ; Convert ASCII to integer
    mov [input_number], al     ; Store input
    ret

;----------------------------------------------
; Function: compare_strings
; Description: Compares string1 and string2 character by character
;----------------------------------------------
compare_strings:
.loop:
    mov al, [si]                ; Load character from string1
    mov bl, [di]                ; Load character from string2
    cmp al, bl
    jne .not_equal              ; Jump if not equal
    test al, al
    je .equal                   ; If both are null, strings are equal
    inc si
    inc di
    jmp .loop
.not_equal:
    mov ah, 09h
    mov dx, 'Strings are NOT equal$', 0
    int 21h
    ret
.equal:
    mov ah, 09h
    mov dx, 'Strings are EQUAL$', 0
    int 21h
    ret

;----------------------------------------------
; Function: file_write
; Description: Opens and writes data to a file
;----------------------------------------------
file_write:
    ; Open file for writing
    mov ah, 3Ch                ; DOS interrupt for creating a file
    mov cx, 0                  ; File attribute: normal
    mov dx, file_name
    int 21h
    jc .error                   ; Jump if error (file could not be opened)
    mov [file_handle], ax       ; Store file handle

    ; Write data to file
    mov ah, 40h                ; DOS interrupt to write to file
    mov bx, [file_handle]
    mov dx, file_data
    mov cx, 32                 ; Number of bytes to write
    int 21h
    jc .error                   ; Jump if error

    ; Close file
    mov ah, 3Eh                ; DOS interrupt to close file
    mov bx, [file_handle]
    int 21h
    ret

.error:
    mov ah, 09h
    mov dx, 'Error writing to file$', 0
    int 21h
    ret
