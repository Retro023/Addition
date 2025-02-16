section .data
    prompt1 db 'Enter your first number: ', 0   ; the first number
    prompt2 db 'Enter your second number: ', 0   ; the second number
    result_mesg db 'The sum is: ', 0            ; the result of num1 + num2
    newline db 10, 0                            ; Line break

section .bss
    num1 resb 4                                 ; Reserve 4 bytes for the first num
    num2 resb 4                                 ; Reserve 4 bytes for the second number
    result resb 4                               ; Reserve 4 bytes for the result
    
section .text
    global _start

_start:
    ; print the first prompt
    mov eax, 4                                    ; sys_write
    mov ebx, 1                                    ; file descriptor for stdout
    mov ecx, prompt1                              ; pointer to the first prompt's string
    mov edx, 18                                   ; length of the first prompt's string
    int 0x80                                      ; make system call

    ; Read the First number
    mov eax, 3
    mov ebx, 0
    mov ecx, num1                                  ; everything same as before just for the first number, yes I am too lazy to comment this code
    mov edx, 4
    int 0x80

    ; print second prompt
    mov eax, 4                                    
    mov ebx, 1                                    
    mov ecx, prompt2                               ; everything same as before just for the second prompt, yes I am too lazy to comment this code                        
    mov edx, 19                               
    int 0x80

    ; Read the second number
    mov eax, 3                                    
    mov ebx, 0                                    
    mov ecx, num2                                 ; everything same as before just for the second number, yes I am too lazy to comment this code                        
    mov edx, 4                                   
    int 0x80

    ; Convert the inputted str to ints
    mov eax, [num1]                                 ; load first str num into eax
    sub eax, '0'                                    ; Convert the ASCII (Str) to int
    mov ebx, eax                                    ; Store the first num in ebx

    mov eax, [num2]                                 ; load the second num to eax
    sub eax, '0'                                    ; convert the ASCII (Str) to int

    ; Adding the two numbers
    add eax, ebx                                    ; add the two numbers
    ; store the result in memory
    mov [result], eax                               ; store the resulting number into memory hoping it fits in one byte
    
    ; print the result message
    mov eax, 4                                      ; sys_write
    mov ebx, 1                                      ; file descriptor for stdout
    mov ecx, result_mesg                            ; pointer to the result message
    mov edx, 12                                     ; length of the result message
    int 0x80                                        ; make system call
    
    ; convert int result to ASCII
    mov eax, [result]                               ; load result
    add eax, '0'                                    ; convert the int back into ASCII
    mov [result], al                                ; storing the result as a character

    ; print the resulting character
    mov eax, 4                                      ; sys_write
    mov ebx, 1                                      ; file descriptor for stdout
    mov ecx, result                                 ; pointer to result
    mov edx, 1                                      ; length of the result
    int 0x80                                        ; make system call

    ; Print newline
    mov eax, 4                                      ; sys_write
    mov ebx, 1                                      ; file descriptor for stdout
    mov ecx, newline                                ; pointer to newline
    mov edx, 1                                      ; length of the newline
    int 0x80                                        ; make system call

    ; Exit the program
    mov eax, 1                                      ; sys_exit
    xor ebx, ebx                                    ; return code 0
    int 0x80                                        ; make system call

;End
