section .data
	msg1: db "Enter first integer",10
	len1: equ $-msg1
	msg2: db "The sum of the digits",10
	len2: equ $-msg2
	minus: db '-'

section .bss
	num: resw 1
	temp: resb 1
	sign: resb 1
	n: resw 1
	sum: resw 1
	offset: resw 1
	flag: resb 1
	nod: resb 1

section .text
	global _start
_start:
mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, len1
int 80h
	
call read_num
mov word[sum],0

call sum_digits

mov eax, 4
mov ebx, 1
mov ecx, msg2
mov edx, len2
int 80h

mov ax,word[sum]
mov word[num],ax

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
            je l1


        cmp byte[temp], '-'
            jne l
            inc byte[sign]
            jmp loop_read

    l:  mov ax, word[num]
        mov bx, 10
        mul bx
        mov bl, byte[temp]
        sub bl, 30h
        mov bh, 0
        add ax, bx
        mov word[num], ax
        jmp loop_read

    l1: cmp byte[sign], 1
        jne end_read
        mov bx, -1
        mov ax, word[num]
        mul bx
        mov word[num],ax
        mov byte[sign], 0

    end_read:
    popa
ret	

sum_digits:
   pusha
   cmp word[num],0
   je return

   mov edx,0
   mov ax,word[num]
   mov bx,10
   div bx
   push edx
   mov word[num],ax
   call sum_digits
   pop edx 
   add word[sum],dx

   return:
     popa
     ret

print_num:
	mov byte[flag], 0
    pusha
	;cmp byte[flag], 1
	;	je print_no
    cmp word[num], 0
		jne lflag
		add word[num], 30h
		mov byte[flag], 1
		mov eax, 4
		mov ebx, 1
		mov ecx, num
		mov edx, 1
		int 80h
		jmp end_print
		
   lflag: cmp word[num],0
	  jnl extract_no
    mov ax, word[num]
    ;mov bx, -1
    ;mul bx
    neg ax
    mov word[num], ax

    mov eax, 4
    mov ebx, 1
    mov ecx, minus
    mov edx, 1
    int 80h

    extract_no:
        cmp word[num], 0
        je print_no
        inc byte[nod]
        mov dx, 0
        mov ax, word[num]
        mov bx, 10
        div bx
        push dx
        mov word[num], ax
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
    popa
ret

exit:
	mov eax, 1
	mov ebx, 0
	int 80h
