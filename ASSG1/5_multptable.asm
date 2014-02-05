;Program to print multiplication table of single digit number

section .data
    string1: db 'Enter a single digit number',0Ah
    length1: equ $-string1
    string2: db 'The multiplication table',0Ah
    length2: equ $-string2
    limit: db 10
    counter: db 31h
    space: db '  '
    x: db '*'
    eq: db '='
    enter: db 0Ah


section .bss
    num : resb 1
    result1: resb 1
    result2: resb 1
    counter1: resb 1
    counter2: resb 1

section .text
    global _start:
_start:

;Print string1
    mov eax, 4
    mov ebx, 1
    mov ecx, string1
    mov edx, length1
    int 80h

;Input
    mov eax, 3
    mov ebx, 0
    mov ecx, num
    mov edx, 1
    int 80h

;Print string2
    mov eax, 4
    mov ebx, 1
    mov ecx, string2
    mov edx, length2
    int 80h

;Print number
l2: mov eax, 4
    mov ebx, 1
    mov ecx, num
    mov edx, 1
    int 80h

;Print space
    mov eax, 4
    mov ebx, 1
    mov ecx, space
    mov edx, 2
    int 80h

;Print X
    mov eax, 4
    mov ebx, 1
    mov ecx, x
    mov edx, 1
    int 80h

;Print space
    mov eax, 4
    mov ebx, 1
    mov ecx, space
    mov edx, 2
    int 80h

;Find digits of counter
    mov al, byte[counter]
    sub al, 30h
    mov bl, 10
    div bl
    mov byte[counter1], al
    mov bl,al
    mov byte[counter2], ah

    add byte[counter1], 30h
    add byte[counter2], 30h
    
    mov dl, 0
    cmp dl, bl
    je l3

    mov eax, 4
    mov ebx, 1
    mov ecx, counter1
    mov edx, 1
    int 80h

l3: mov eax, 4
    mov ebx, 1
    mov ecx, counter2
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, space
    mov edx, 2
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, eq
    mov edx, 1
    int 80h

    movzx ax, byte[num]
    sub ax, 30h
    mov cl, byte[counter]
    sub cl, 30h
    mul cl
    mov bl, 10
    div bl
    mov [result1], al
    mov [result2], ah

    add byte[result1], 30h
    add byte[result2], 30h
    
    mov bl, 30h
    mov al, byte[result1]
    cmp al, bl
    je l1

    mov eax, 4
    mov ebx, 1
    mov ecx, result1
    mov edx, 1
    int 80h

l1: mov eax, 4
    mov ebx, 1
    mov ecx, result2
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, enter
    mov edx, 1
    int 80h

    inc byte[counter]
    mov bl, byte[counter]
    sub bl, 30h
    mov al, byte[limit]
    cmp bl,al
    jna l2
    
    mov eax, 1
    mov ebx, 0
    int 80h
