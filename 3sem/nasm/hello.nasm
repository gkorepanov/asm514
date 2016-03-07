global _start ; make our code visible
extern exit ; use extern exit symbol
extern print_hex

section .rodata ;section start

hello: db 'Hello world', 0xa
.sz: equ $-hello ; size of hello world
loat: dt 0.123123

section .bss
buf: resb 8192

section .text ; code


_start:

	mov rax, 1 ; syscall write(stdout, 'hello world', size_of_hello)
	mov rdi, 1 
	mov rsi, hello
	mov rdx, hello.sz
	syscall

	mov rax, 0x0 ; syscall read
	mov rdi, 0x0 ; from stdin
	mov rsi, buf 
	mov rdx, 4095
	syscall
	; in rax -- number of bytes read

	push rax
	push rsi
	call print_hex
	pop rsi
	pop rax
	

	mov rdx, rax ; move number of bytes read to bytes to write
	mov rax, 0x1 ; syscall write
	mov rdi, 1; to stdout
	syscall
	

	mov rax, 0x0
	call exit
	; call system exit

	;mov rax, 60
	;mov rdi, 0x0
	;syscall

