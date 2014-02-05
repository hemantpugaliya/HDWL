section .data
	msg1: db 'size of array1: ',0ah
	len1: equ $-msg1
	msg2: db 'elements : ',0ah
	len2: equ $-msg2
	msg3: db 'size of array2: ',0ah
	len3: equ $-msg3
	newline: db  10
	minus : db 45
	space: db 32
section .bss
	digit: resb 1
	counter: resb 1
	num: resw 1
	num1: resw 1
	sign: resb 1
	i: resw 1
	j: resw 1
	arr1: resw 50
	arr2: resw 50
	arr3: resw 100
	size1: resw 1
	size2: resw 1
	size3: resw 1
	high: resw 1
	low: resw 1
	mid: resw 1
	merge: resw 100
	size: resw 1
	low1: resw 1
	high1: resw 1
	m: resw 1
	k: resw 1
	l: resw 1
	temp: resw 1
	val1: resw 1
	val2: resw 1
	limit: resw 1
	

section .text
	global _start:
_start:

	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,len1
	int 80h

	call readnumber
	mov ax, word[num]
	mov word[size1],ax


	mov word[num],0
	mov ebx,arr1
	mov word[i],0
readarr1:
	mov ax,word[size1]
	cmp ax, word[i]
	je readsize2
	
	push rbx
	call readnumber
	pop rbx
	
	mov ax, word[num]
	mov word[ebx], ax
	add	ebx,4
	inc word[i]
	jmp readarr1
	

readsize2:
	

	call readnumber
	mov ax, word[num]
	mov word[size2],ax


;reading array elements
	
	mov word[num],0
	mov ebx,arr2
	mov word[i],0
readarr2:
	mov ax,word[size2]
	cmp ax, word[i]
	je bubblesort1
	
	push rbx
	call readnumber
	pop rbx
	
	mov ax, word[num]
	mov word[ebx], ax
	add	ebx,4
	inc word[i]
	jmp readarr2

bubblesort1:
	mov word[i],0
	mov word[j],0
	loop11:
		mov ax,word[size1]
		sub ax,1
		cmp ax,word[i]
		je bubblesort2
		mov ax,word[size1]
		sub ax, 1 ; here
		mov word[limit],ax
		mov ebx,arr1
		mov word[j],0		
		loop21:
			mov ax, word[limit]
			cmp ax, word[j]
			je out1
			mov ax,word[ebx]
			mov word[val1],ax
			mov ax,word[ebx+4]
			mov word[val2],ax
			push rbx
			mov ax, word[val1]
			cmp ax, word[val2]
			jg swap1
			pop rbx
			inc word[j]
			add ebx,4
			jmp loop21
			swap1:
				mov ax,word[val1]
				mov word[temp],ax
				mov word[num1],0
				mov ax,word[val2]
				mov word[val1],	ax
				mov word[val2],0
				mov ax, word[temp]
				mov word[val2],ax
				pop rbx
				mov ax,word[val1]
				mov word[ebx],ax
				mov ax,word[val2]
				mov word[ebx+4],ax
				mov word[val1],0
				mov word[val2],0
				inc word[j]
				add ebx,4
				jmp loop21
		out1:
			inc word[i]
			jmp loop11

bubblesort2:
	mov word[i],0
	mov word[j],0
	loop12:
		mov ax,word[size2]
		sub ax,1
		cmp ax,word[i]
		je makenew
		mov ax,word[size2]
		sub ax, 1 ; here
		mov word[limit],ax
		mov ebx,arr2
		mov word[j],0		
		loop22:
			mov ax, word[limit]
			cmp ax, word[j]
			je out2
			mov ax,word[ebx]
			mov word[val1],ax
			mov ax,word[ebx+4]
			mov word[val2],ax
			push rbx
			mov ax, word[val1]
			cmp ax, word[val2]
			jg swap2
			pop rbx
			inc word[j]
			add ebx,4
			jmp loop22
			swap2:
				mov ax,word[val1]
				mov word[temp],ax
				mov word[num1],0
				mov ax,word[val2]
				mov word[val1],	ax
				mov word[val2],0
				mov ax, word[temp]
				mov word[val2],ax
				pop rbx
				mov ax,word[val1]
				mov word[ebx],ax
				mov ax,word[val2]
				mov word[ebx+4],ax
				mov word[val1],0
				mov word[val2],0
				inc word[j]
				add ebx,4
				jmp loop22
		out2:
			inc word[i]
			jmp loop12


makenew:
	mov ax,word[size1]
	add ax,word[size2]
	mov word[size3],ax
	cld
	mov ebx,arr3
	mov esi,arr1
	mov edi,arr2
	mov word[i],0
	mov word[j],0
mk:
	mov ax,word[size1]
	cmp ax,word[i]
	je add_second
	mov ax,word[size2]
	cmp ax,word[j]
	je add_first
	mov ax,word[esi]
	cmp ax,word[edi]
	jl add_1
		mov ax,word[edi]
		mov word[ebx],ax
		inc word[j]
		add edi,4
		add ebx,4
		jmp mk
	add_1:
		mov ax,word[esi]
		mov word[ebx],ax
		inc word[i]
		add esi,4
		add ebx,4
		jmp mk
	
	add_first:
		mov ax,word[size1]
		cmp ax,word[i]
		je printarr3
		mov ax,word[esi]
		mov word[ebx],ax
		inc word[i]
		add esi,4
		add ebx,4
		jmp add_first

	add_second:
		mov ax,word[size2]
		cmp ax,word[j]
		je printarr3
		mov ax,word[edi]
		mov word[ebx],ax
		inc word[j]
		add ebx,4
		add edi,4
		jmp add_second

printarr3:
	mov ebx,arr3
	mov word[i],0
prnt:
	mov ax,word[size3]
	cmp ax, word[i]
	je exit
	
	mov ax,word[ebx]	
	mov word[num1],ax
		
	push rbx
	call printnumber
	mov eax,4
	mov ebx,1
	mov ecx,space
	mov edx,1
	int 80h

	pop rbx
	
	add ebx,4
	inc word[i]
	jmp prnt

exit: 
	mov eax,1
	mov ebx,0
	int 80h		
		

; subroutine for reading a numbner(with sign)
readnumber:
	mov word[num],0
	mov byte[sign],0

read:	
	mov eax,3
	mov ebx,0
	mov ecx,digit
	mov edx,1
	int 80h

	cmp byte[digit],10
	je end		
	cmp byte[digit], 45
	je change_sign
	mov ax,word[num]	
	mov bx,10
	mul bx
	sub byte[digit],48
	mov bh,0
	mov bl,byte[digit]
	add ax,bx
	mov word[num],ax
	jmp read
	
	change_sign:
		mov byte[sign],1
		jmp read

	end:
		cmp byte[sign],1
		je end1
			ret
		end1:
			mov ax,word[num]
			mov bx,-1
			mul bx
			mov word[num], ax
			ret

;subroutine for printing a number (without sign)
printnumber:
		mov byte[counter], 0
		mov byte[digit],0
		mov ax, word[num1]
		cmp ax, 0
		jl change	
		
	pushnumber:
		mov dx,0
		mov ax, word[num1]
		mov bx,10
		div bx
		push dx
		mov word[num1], ax
		cmp word[num1], 0
		je popnumber
		inc byte[counter]
		jmp pushnumber

	change:
		mov ax, word[num1]
		mov cx,-1
		mul cx
		mov word[num1],ax
		mov eax,4
		mov ebx,1
		mov ecx, minus
		mov edx,1
		int 80h
		jmp printnumber		

	popnumber:
		
		pop dx
		mov byte[digit], dl
		add byte[digit], 30h
		mov eax,4
		mov ebx,1
		mov ecx, digit
		mov edx,1
		int 80h
		cmp byte[counter],0
		je end2
		dec byte[counter]
		jmp popnumber

		
end2:
	mov eax, 4
	mov ebx, 1
	mov ecx, space
	mov ebx, 1
	int 80h
	ret

