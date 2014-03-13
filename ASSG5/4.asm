section .data
	msg1: db "Enter a string",10
	len1: equ $-msg1
	msg2: db "The given string is a palindrome"
	len2: equ $-msg2
	msg3: db "The given string is not a palindrome"
	len3: equ $-msg3
	minus: db "-"
	
section .bss
	string: resb 100
	size: resw 1
	palin: resb 1
	temp: resb 1
	n: resw 1
	
	
section .text
	global _start
_start:

	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, len1
	int 80h
	
	call read_string
	
	mov word[n], 0
	mov byte[palin], 0
	call chk_palin
	
	cmp byte[palin], 0
		je p
	
	mov eax, 4
	mov ebx, 1
	mov ecx, msg3
	mov edx, len3
	int 80h
	
	call exit
	
	p:
	mov eax, 4
	mov ebx, 1
	mov ecx, msg2
	mov edx, len2
	int 80h
	
	call exit
	
	read_string:
		pusha
		mov word[size], 0
		cld
		mov edi, string
	
		loop2:	
			mov eax, 3
			mov ebx, 0
			mov ecx, temp
			mov edx, 1
			int 80h
	
			cmp byte[temp], 10
				je end_read
	
			inc word[size]
			mov al, byte[temp]
			stosb
			jmp loop2
	
		end_read:
			popa
	ret
	
	chk_palin:
		pusha
		mov ecx, 0
		mov ebx, string
		mov cx, word[size]
		
		cmp cx, 1
			jne cont
		popa
		ret

		cont:
		sub cx, word[n]
		dec cx
		
		cmp cx, word[n]
			jng palint
		
		mov dl, byte[ebx + ecx]
		movzx eax, word[n]
		mov dh, byte[ebx + eax]
		cmp dh, dl
			je palinn
		
		mov byte[palin], 1
		popa
		ret
		
		palinn:
			inc word[n]
			call chk_palin
			popa
			ret
		
		palint:
			popa
			ret
			
	exit:
		mov eax, 1
		mov ebx, 0
		int 80h
		
		
		
