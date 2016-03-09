global _start ; make our code visible
section .rodata ; section start

number: db 'Print the number:', 0xa
.sz equ $-number
base: db 'Print the initial base: ', 0xa
.sz equ $-base ; size of second string
basef: db 'Print the base to convert into:', 0xa
.sz equ $-basef
notadigit: db 'You', "'", 've typed non-digit symbol!', 0xa
.sz equ $-notadigit

section .bss
buf: resb 10
section .text ; code

; eax contains number, ebx - base
convert:
    push rbp
    mov rbp, rsp

    sub rsp, 100 ; memory for temporary results

    mov rsi, rbp
    dec rsi ; dec is first free element in stack
    
    mov BYTE [rsi], 0xa ; \n added

.loop:
    test eax, eax
    jz .exit

    xor edx, edx ; no need
    div ebx ; eax = num/base, edx = num % base 
    
    cmp edx, 0xa ; if edx < 10 it should be written as a digit
    jb .digit
    
    sub edx, 0xa
    add edx, 'A'
    jmp .proceed ; now edx is ascii symbol

.digit:
    add edx, '0' ; now edx is ascii symbol

.proceed:
    dec rsi
    mov BYTE [rsi], dl
    jmp .loop

.exit:
    mov rax, 1 ; to print
    mov rdi, 1 ; stdout
    mov rdx, rbp
    sub rdx, rsi ; num of symbols in rdx
    ; rsi contains ptr to begin of string
    syscall
    
    mov rsp, rbp
    pop rbp
    ret
 
; in r8d - base of read number, number is returned to eax
read_number:
    mov rax, 0
    mov rdi, 0
    mov rsi, buf
    mov rdx, 10
    syscall
    
    ; in rsi -- number of bytes read:
    mov rsi, rax
    sub rsi, 1
    
    mov rdi, rsi

    xor ebx, ebx
    xor eax, eax
    xor rsi, rsi

.loop:
    
    cmp rsi, rdi
    je .exit
    

    mov edx, r8d
    mul edx ; eax *= base initial (r8d) 


    xor ebx, ebx
    mov bl, BYTE [buf+rsi]
    sub ebx, '0' ; new digit in ebx
    
    cmp ebx, 0xa
    jae nondigit
    cmp ebx, 0
    jb nondigit

    add eax, ebx
    inc rsi

    jmp .loop

.exit:
    ret

nondigit:
    mov rax, 1
    mov rdi, 1
    mov rsi, notadigit
    mov rdx, notadigit.sz
    syscall
    jmp exit

_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, base
    mov rdx, base.sz
    syscall

    mov r8d, 10
    call read_number ; in eax - read initial base

    push rax ; store initial base

    mov rax, 1
    mov rdi, 1
    mov rsi, basef
    mov rdx, basef.sz
    syscall


    mov r8d, 10
    call read_number
    ; in eax -- readen final base

    pop r8 ; initial base in ecx
    push rax ; store final base
    
    mov rax, 1
    mov rdi, 1
    mov rsi, number
    mov rdx, number.sz
    syscall


    call read_number
    ; in eax -- read number
    
    pop rbx ; in ebx - final base


    call convert

exit:
	; call system exit
	mov rax, 60
	mov rdi, 0x0
	syscall
