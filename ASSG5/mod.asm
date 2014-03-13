section .data
	msg1: db "Enter a string",10
	len1: equ $-msg1
	msg2: db "The first capital letter is:"
	len2: equ $-msg2
	msg3: db "There is no capital letter"
	len3: equ $-msg3
	minus: db "-"
	
section .bss
	string: resb 100
	capital: resb 1
	letter:resb 1
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

	mov byte[capital],0
	mov byte[n],0

	call first_capital
     
    cmp byte[capital],1
    je print

    mov eax, 4
	mov ebx, 1
	mov ecx, msg3
	mov edx, len3
	int 80h

	jmp exit

	print:
	mov eax, 4
	mov ebx, 1
	mov ecx, msg2
	mov edx, len2
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, letter
	mov edx, 1
	int 80h


    exit:
	mov eax, 1
	mov ebx, 0
	int 80h





	read_string:
		pusha
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
	
			mov al, byte[temp]
			stosb
			jmp loop2
	
		end_read:
		   mov al,0
		   stosb
			popa
	ret

	first_capital:
  pusha
  mov eax,string
  mov ecx,0
  mov cl,byte[n]
  mov dl,byte[eax+ecx]
  cmp dl,0
  je return

  cmp dl,'A'
  jge greater
  jmp not_greater

  greater:
      cmp dl,'Z'
      jle found

  not_greater:
     inc byte[n]
     call first_capital 
     jmp return

  found:
       mov byte[capital],1
       mov byte[letter],dl
       jmp return

   return:
        popa 
        ret