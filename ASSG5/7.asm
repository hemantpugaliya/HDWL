section .data
	msg1: db "Enter a string",10
	len1: equ $-msg1
	msg2: db "The  string copied is:"
	len2: equ $-msg2
   minus: db "-"

	section .bss
	string: resb 100
	string1: resb 100
	string2: resb 100
	size: resw 1
	equal: resb 1
	temp: resb 1
	n: resb 1

section .text
	global _start
_start:
mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, len1
int 80h
	
call read_string
mov esi,string
mov edi,string1
movzx ecx,word[size]
rep movsb

mov byte[n],0
call copy_string
mov eax, 4
mov ebx, 1
mov ecx, msg2
mov edx, len2
int 80h
mov edx,0
mov eax, 4
mov ebx,1
mov ecx, string2
mov dx,word[size]
int 80h

mov byte[temp],10
mov eax, 4
mov ebx, 1
mov ecx, temp
mov edx, 1
int 80h

mov eax, 1
		mov ebx, 0
		int 80h





copy_string:
    pusha 
  mov eax,string1
  mov ebx,string2
  mov ecx,0
  mov cl,byte[n]
  mov dl,byte[eax+ecx]
  mov byte[ebx+ecx],dl
  cmp dl,0
  je return
  inc byte[n]
  call copy_string

  return:
  popa
  ret

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
		   inc word[size]
		   mov al,0
		   stosb
		   popa
	ret