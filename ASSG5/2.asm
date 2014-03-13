section .data
	msg1: db "Enter 10 numbers one by one",10
	len1: equ $-msg1
	msg2: db "The average of the numbers",10
	len2: equ $-msg2
	minus: db '-'
	dot : db '.'
	
section .bss
	sum: resw 1
	avg: resw 1
	array: resw 10
	num: resw 1
	sign: resb 1
    offset: resw 1
	flag: resb 1
	nod: resb 1
	temp: resb 1
	quo: resw 1
	rem: resw 1

section .text
	global _start
_start:
	
	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, len1
	int 80h
	
	;pop ecx
	mov eax, 0
    mov ebx, array
    mov ecx, 10
	;Read elements of array 1
	reading1:
		call read_num
		mov dx, word[num]
		mov word[ebx + 2 * eax], dx
		inc eax
	loop reading1
	
	call average
	
	mov ax, word[sum]
	mov word[num], ax
	call print_num

	mov byte[temp],10
	
	mov eax, 4
	mov ebx, 1
	mov ecx, temp
	mov edx, 1
	int 80h	
	mov eax, 4
	mov ebx, 1
	mov ecx, msg2
	mov edx, len2
	int 80h	
	
	mov ax, word[quo]
	mov word[num], ax
	
		call print_num
	
		mov eax, 4
		mov ebx, 1
		mov ecx, dot
		mov edx, 1
		int 80h
	
		mov ax, word[rem]
		mov word[num], ax
	
		call print_num
		
	call exit
	
	
	average:
	pusha
		mov ebx, array
		mov ecx, 10
		mov word[sum], 0
		mov word[quo], 0
		mov word[rem], 0
		
		suml:
			mov ax, word[ebx]
			add word[sum], ax
			inc ebx
			inc ebx
		loop suml
		
		;mov cx, word[sum]
		;mov word[num], cx
		
		;call print_num
		
		mov ax, word[sum]
		mov dx, 0
		mov ebx, 0
		mov bx, 10
		div bx
		
		mov word[quo], ax
		mov word[rem], dx
	popa
	ret
	
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
