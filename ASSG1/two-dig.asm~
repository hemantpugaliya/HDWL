section .data
newline db 0Ah
section .bss
    num: resw 1
    nod : resb 1
    temp: resb 1
    sum : resd 1

section .text
    global _start
_start:
    mov word[num], 0
    mov dword[sum],0
    call read_num
    mov eax,0
    add ax,word[num]
    mov dword[sum],eax
    call read_num
    mov eax,0
    add ax,word[num]
    add dword[sum],eax
    call print_num
    jmp exit
    

read_num:
  pusha
  mov word[num], 0
    loop_read:
        mov eax, 3
        mov ebx, 0
        mov ecx, temp
        mov edx, 1
        int 80h

        cmp byte[temp], 10
            je end_read1
        mov ax, word[num]
        mov bx, 10
        mul bx
        mov bl, byte[temp]
        sub bl, 30h
        mov bh, 0
        add ax, bx
        mov word[num], ax
        jmp loop_read
    end_read1:
        popa
        ret

print_num:
  pusha
  mov byte[nod],0
  extract_no:
    cmp dword[sum], 0
    je print_no
    inc byte[nod]
    mov edx, 0
    mov ebx,0
    mov eax, dword[sum]
    mov bx, 10
    div bx
    push dx
    mov dword[sum], eax
  jmp extract_no


  print_no:
    
    cmp byte[nod], 0
    je end_print
    dec byte[nod]
    pop dx
    mov byte[temp],dl
    add byte[temp], 30h


    mov eax, 4
    mov ebx, 1
    mov ecx, temp
    mov edx, 1
    int 80h
    
    jmp print_no
    
  end_print:   
  popa
  ret 

exit:       mov eax, 1
            mov ebx, 0
            int 80h
