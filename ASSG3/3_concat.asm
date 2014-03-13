section .data
	msg1: db "Enter string1",10
	len1: equ $-msg1
	msg2: db "Enter string2",10
	len2: equ $-msg2
	msg3: db "The concatenated string",10
	len3: equ $-msg3
	
section .bss
	size1: resw 1
	string1: resb 100
	temp: resb 1
	size_add: resw 1
	
	size2: resw 1
	string2: resb 100
	
	size3: resw 1
	string3: resb 100
	
section .text
	global _start
_start:
	
	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, len1
	int 80h
	
	mov ebx,string1
	mov ecx,size1
	

	call read_string
	
	
	mov eax, 4
	mov ebx, 1
	mov ecx, msg2
	mov edx, len2
	int 80h
	
	mov word[size2], 0
	mov ebx,string2
	mov ecx,size2
	call read_string
	
	mov eax, 4
	mov ebx, 1
	mov ecx, msg3
	mov edx, len3
	int 80h
	
	call concat
	
	mov eax,4
	mov ebx, 1
	mov ecx, string3
	mov edx, size3
	int 80h
	
	mov byte[temp],0Ah
	mov eax, 4
	mov ebx, 1
	mov ecx, temp
	mov edx, 1
	int 80h
	
	call exit
	
read_string:
	pusha
	cld
	mov edi,ebx
	mov word[ecx],0
	
loop:	
        push ecx
	mov eax, 3
	mov ebx, 0
	mov ecx, temp
	mov edx, 1
	int 80h
	pop ecx
	cmp byte[temp], 10
		je end_read
	
	inc word[ecx]
	mov al, byte[temp]
	stosb
	jmp loop
	
end_read:
	popa
ret



concat:
	pusha
	cld
	
	mov esi, string1
	mov ebx, string3
	movzx ecx, word[size1]
	l1:
	lodsb
	mov byte[ebx], al
	inc ebx
	inc word[size3]
	loop l1
	
	cld
	
	mov esi, string2
	movzx ecx, word[size2]
	l2:
	lodsb
	mov byte[ebx], al
	inc ebx
	inc word[size3]
	loop l2
	
	popa
ret

exit:
	mov eax, 1
	mov ebx, 0
	int 80h
