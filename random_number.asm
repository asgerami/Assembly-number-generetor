section .bss
    num1 resb 5
    num2 resb 5
    result resb 5

section .data
    prompt1 db 'Enter the minimum number: ', 0
    prompt2 db 'Enter the maximum number: ', 0
    newline db 10, 0
    random_msg db 'Random number: ', 0

section .text
    global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt1
    mov edx, 25
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, num1
    mov edx, 5
    int 0x80

    call atoi

    mov eax, 4
    mov ebx, 1
    mov ecx, prompt2
    mov edx, 27
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, num2
    mov edx, 5
    int 0x80

    call atoi

    mov eax, 1
    xor ebx, ebx
    rdtsc
    mov ebx, eax
    xor edx, edx
    mov ecx, [num2]
    sub ecx, [num1]
    inc ecx
    xor edx, edx
    div ecx
    add eax, [num1]

    call itoa

    mov eax, 4
    mov ebx, 1
    mov ecx, random_msg
    mov edx, 15
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 5
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    mov eax, 1
    xor ebx, ebx
    int 0x80

atoi:
    xor eax, eax
    xor ebx, ebx
    mov ebx, 10

atoi_loop:
    movzx ecx, byte [num1]
    cmp ecx, 10
    je atoi_done
    sub ecx, '0'
    imul eax, ebx
    add eax, ecx
    inc num1
    jmp atoi_loop

atoi_done:
    ret

itoa:
    mov ecx, 10
    xor ebx, ebx

itoa_loop:
    xor edx, edx
    div ecx
    add dl, '0'
    dec num1
    mov [num1], dl
    inc ebx
    test eax, eax
    jnz itoa_loop

    mov eax, ebx
    ret
