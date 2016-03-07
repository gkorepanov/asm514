
section .text ; code

global print_hex

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


