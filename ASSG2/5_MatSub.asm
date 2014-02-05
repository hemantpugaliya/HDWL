section .bss
  num: resw 1 ;For storing a number, to be read of printed....
  nod: resb 1 ;For storing the number of digits....
  temp: resb 2
  matrix1: resw 200
  matrix2: resw 200
  m: resw 1
  n: resw 1
  i: resw 1
  j: resw 1
  sign: resb 1
  flag: resb 1
  
section .data
  msg1: db "Enter the number of rows in the matrices : "
  msg_size1: equ $-msg1
  msg2:  db "Enter the elements one by one(row by row) : "
  msg_size2: equ $-msg2
  msg3: db "Enter the number of columns in the matrices : "
  msg_size3: equ $-msg3
  tab: db  9 ;ASCII for vertical tab
  new_line: db 10 ;ASCII for new line
  minus: db "-"
  newline: db " ",0Ah
section .text
  global _start

_start:

  mov byte[sign], 0
  mov eax, 4
  mov ebx, 1
  mov ecx, msg1
  mov edx, msg_size1
  int 80h
  
  mov ecx, 0
  call read_num  
  mov cx, word[num]
  mov word[m], cx
  
  
  mov eax, 4
  mov ebx, 1
  mov ecx, msg3
  mov edx, msg_size3
  int 80h
  
  mov ecx, 0
  call read_num  
  mov cx, word[num]
  mov word[n], cx
  
  mov eax, 4
  mov ebx, 1
  mov ecx, msg2
  mov edx, msg_size2
  int 80h
  
  ;Reading each element of the matrix........
  mov eax, 0
  mov ebx, matrix1  
  
  mov word[i], 0
  mov word[j], 0
  
  
  i_loop:
    mov word[j], 0
    call print_newline
    j_loop:
 
 call read_num
 mov dx , word[num]
 ;eax will contain the array index and each element is 2 bytes(1 word) long
 mov  word[ebx + 2 * eax], dx
 inc eax    ;Incrementing array index by one....
 
 inc word[j]
 mov cx, word[j]
 cmp cx, word[n]
 jb j_loop
 
    inc word[i]
    mov cx, word[i]
    cmp cx, word[m]
    jb i_loop
 
 mov eax, 4
  mov ebx, 1
  mov ecx, msg2
  mov edx, msg_size2
  int 80h 
  

  ;Reading each element of the matrix2........
  mov eax, 0
  mov ebx, matrix2  
  
  mov word[i], 0
  mov word[j], 0
  
  
  i_loop2:
    mov word[j], 0
    call print_newline
    j_loop2:
 
 call read_num
 mov dx , word[num]
 ;eax will contain the array index and each element is 2 bytes(1 word) long
 mov  word[ebx + 2 * eax], dx
 inc eax    ;Incrementing array index by one....
 
 inc word[j]
 mov cx, word[j]
 cmp cx, word[n]
 jb j_loop2
 
    inc word[i]
    mov cx, word[i]
    cmp cx, word[m]
    jb i_loop2  
    
 ;Subtraction
 mov eax, 0
 mov ebx, matrix1
 mov edx, matrix2  
  
  mov word[i], 0
  mov word[j], 0
  
  
  i_loop4:
    mov word[j], 0
    j_loop4:
		mov cx, word[edx + 2 * eax]
		sub word[ebx + 2 * eax], cx
		;Modulus
		cmp word[ebx + 2 * eax], 0
		jnl pos
		mov cx, word[ebx + 2 * eax]
		neg cx
		mov word[ebx + 2 * eax], cx
		
pos:		 
 inc eax    ;Incrementing array index by one....
 
 inc word[j]
 mov cx, word[j]
 cmp cx, word[n]
 jb j_loop4
 
    inc word[i]
    mov cx, word[i]
    cmp cx, word[m]
    jb i_loop4  
 
  ;Reading each element of the matrix.(Storing the elements in row major order).......
  mov eax, 0
  mov ebx, matrix1  
  
  mov word[i], 0
  mov word[j], 0
  
  call print_newline
  i_loop3:
    mov word[j], 0
    j_loop3:
 
   ;eax will contain the array index and each element is 2 bytes(1 word) long
   mov  dx, word[ebx + 2 * eax]   ;
   mov word[num] , dx
   call print_num
   
   ;Printing a space after each element.....
   pusha
     mov eax, 4
     mov ebx, 1
     mov ecx, tab
     mov edx, 1
     int 80h    
   popa
   
   inc eax  
     
     
 inc word[j]
 mov cx, word[j]
 cmp cx, word[n]
 jb j_loop3
 
  call print_newline
 
    inc word[i]
    mov cx, word[i]
    cmp cx, word[m]
    jb i_loop3
  
;Exit System Call.....
exit:
  mov eax, 1
  mov ebx, 0
  int 80h

  
  
;Function to read a 16bit number
    read_num:

  pusha
  mov word[num], 0
  mov eax,0
  mov byte[sign],0
  read:
    mov eax, 3
    mov ebx, 0
    mov ecx, temp
    mov edx, 1
    int 80h
    
    cmp word[num],0
     jne cont
     cmp byte[temp],2dh
     je sign_detect


    
   cont:
     cmp byte[temp], 10
      je end
      
      cmp byte[temp],32
      je end
    
    mov ax, word[num]
    mov bx, 10
    mul bx
    mov bl, byte[temp]
    sub bl, 30h
    mov bh, 0
    add ax, bx
    mov word[num], ax
    jmp read 
   sign_detect:
   mov byte[sign],1
   jmp read
  end:
  cmp byte[sign],1
  je sign_inv
  popa
  ret
  sign_inv:
  mov ax,word[num]
  mov bx,-1
  mul bx
  mov word[num],ax
  popa
  ret

;Function to print 16bit number
print_num:
  pusha
  cmp word[num],0
  jl negative
  je zero
  resume: mov byte[nod],0
  extract_no:
    cmp word[num], 0
    je print_no
    inc byte[nod]
    mov edx, 0
    mov ebx,0
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
    mov byte[temp],dl
    add byte[temp], 30h


    mov eax, 4
    mov ebx, 1
    mov ecx, temp
    mov edx, 1
    int 80h
    
    jmp print_no
    
negative:
 call sign_invert
 jmp resume
 
 zero:
 mov byte[temp],30h
    mov eax, 4
    mov ebx, 1
    mov ecx, temp
    mov edx, 1
    int 80h
 
 
  end_print:   
  popa
  ret 
 sign_invert:
  pusha
   mov eax, 4
    mov ebx, 1
    mov ecx, minus
    mov edx, 1
    int 80h
  mov ax,word[num]
  mov bx,-1
  mul bx
  mov word[num],ax
  popa
  ret
  
   print_newline:
  pusha
  mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 2
    int 80h
  popa 
  ret
