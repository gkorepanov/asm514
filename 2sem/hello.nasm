global _start ; make our code visible
section .rodata ;section start

hello: db 'Hello world', 0xa
.sz: equ $-hello ; size of hello world

section .bss
buf: resb 8192

section .text ; code


print_hex: ; in rax -- number to print
	push rbp;
	mov rbp, rsp
	; we need rax, rdi, rsi, rdx for output
	sub rsp, 17
	push rbx
	push rsi
	mov rsi, rbp
	dec rsi
	mov BYTE [rsi], 0xa
	mov rbx, rax
.loop:
	test rbx, rbx
	jz .exit
	and rbx, 0xf
	cmp rbx, 0xa
	jb .digit
	sub rbx, 0xa
	add rbx, 'a'
	jmp .next
.digit:
	add rbx, '0'
.next:
	dec rsi
	mov [rsi], bl
	sar rax, 4
	mov rbx, rax
	jmp .loop
.exit:
	mov rax, 1
	mov rdi, 1
	; rsi already contains address of buffer
	mov rdx, rbp
	sub rdx, rsi
	syscall

	pop rsi
	pop rbx
	mov rsp, rbp
	pop rbp
	ret



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
	

	; call system exit

	mov rax, 60
	mov rdi, 0x0
	syscall

