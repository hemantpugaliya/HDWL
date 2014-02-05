;Program to find gcd of two numbers

section .bss
    num1: resw 1
    num2: resw 2
    nod : resb 1
    temp: resb 2
    result : resw 1

section .text
    global _start
_start:
    
    mov word[num1], 0

    loop_read1:
        mov eax, 3
        mov ebx, 0
        mov ecx, temp
        mov edx, 1
        int 80h

        cmp byte[temp], 10
            je end_read1
        mov ax, word[num1]
        mov bx, 10
        mul bx
        mov bl, byte[temp]
        sub bl, 30h
        mov bh, 0
        add ax, bx
        mov word[num1], ax
        jmp loop_read1
    end_read1:
        mov word[num2], 0

    loop_read2:
        mov eax,3
        mov ebx,0
        mov ecx, temp
        mov edx, 1
        int 80h

        cmp byte[temp], 10
            je gcd

        mov ax, word[num2]
        mov bx, 10
        mul bx
        mov bl, byte[temp]
        sub bl, 30h
        mov bh, 0
        add ax, bx
        mov word[num2], ax
        jmp loop_read2

    gcd:
        mov bx, word[num2]
        mov ax, word[num1]
        
loop:   cmp ax, bx
        je gcd_exit
        cmp ax, bx
        jb l1
        sub ax, bx
        jmp loop
l1:     sub bx, ax
        jmp loop

    gcd_exit:
        mov word[result], ax
       
        extract_no:
            cmp word[result], 0
            je print_no
            inc byte[nod]
            mov dx, 0
            mov ax, word[result]
            mov bx, 10
            div bx
            push dx
            mov word[result], ax
        jmp extract_no

        print_no:
            cmp byte[nod], 0
            je end_print
            dec byte[nod]
            pop dx
            mov byte[temp], dl
            add byte[temp], 30h

            mov eax, 4
            mov ebx, 1
            mov ecx, temp
            mov edx, 1
            int 80h
            
            jmp print_no

        end_print:
            mov eax, 1
            mov ebx, 0
            int 80h



