section .data
minus: db "-"
msg1: db "Please enter the no of elements in the array"
msg1_len: equ $-msg1
msg2: db "The Elements of the Array are:"
msg2_len: equ $-msg2
newline: db " ",0Ah
space: db "   "
decimal: db ".5"
decimal_len: equ $-decimal
section .bss
    num: resw 1
    nod : resb 1
    temp: resb 1
    sign: resb 1
    array: resw 100
    noe:  resb 1
    i: resb 1
    j: resb 1
    
  section .txt
 global _start
 
 _start:
 mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, msg1_len
    int 80h
     
   call read_num
   mov ax,word[num]
   mov byte[noe],al
   
   mov ecx,0
   mov cl,byte[noe]
   mov edi,array
   cld
   
   input:
   call read_num
   mov ax,word[num]
   STOSW
   loop input
   
   
    movzx ecx, byte[noe]
   mov ebx, array
   mov byte[i], 0

i_loop:
  mov byte[j], 0
  j_loop:
    mov ebx, array
    movzx eax, byte[j]
    mov dl,2
    mul dl
    add ebx, eax
    mov eax, ebx
    add eax, 2
    mov cx, word[ebx]
    mov dx, word[eax]
    cmp dx,cx
    jl swap
    jmp no_swap
  
    swap:
      mov word[ebx], dx
      mov word[eax], cx

no_swap:
    inc byte[j]
    mov al, byte[noe]
    sub al, byte[i]
    sub al, 1
    cmp byte[j], al
    jl j_loop

  inc byte[i]
  mov al, byte[num]
  cmp byte[i], al
jl i_loop
   call print_newline
    mov ecx,0
   mov cl,byte[noe]
   mov esi,array
   cld
    
    output:
    LODSW
    mov word[num],ax
    call print_num
    call print_space
   loop output
   call print_newline
   
  mov eax,0
 mov al,byte[noe]
 mov cl,2
 div cl
 cmp ah,0
 je even_term
 movzx ax,al
 mul cl
 mov ebx,array
 add ebx,eax
 mov cx,word[ebx]
 mov word[num],cx
 call print_newline
 call print_num
 jmp exit
 
 even_term:
 movzx ax,al
 mul cl
 mov ebx,array
 add ebx,eax
 mov dx,word[ebx]
 sub ebx,2
 add dx,word[ebx]
 cmp dx,0
 jnl cont_even
 neg dx
 mov byte[sign],1
 cont_even:
 mov ax,dx
 div cl
 mov dh,ah
 movzx ax,al
 cmp byte[sign],1
 jne cont_print
 neg ax
 cont_print:
 mov word[num],ax
 call print_newline
 call print_num
 cmp dh,1
 je point5
 jmp exit
 
  point5:
  mov eax, 4
    mov ebx, 1
    mov ecx, decimal
    mov edx, decimal_len
    int 80h
    jmp exit
 
   
   
     



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
  print_space:
  pusha
  mov eax, 4
    mov ebx, 1
    mov ecx, space
    mov edx, 3
    int 80h
  popa 
  ret

exit:       mov eax, 1
            mov ebx, 0
            int 80h
