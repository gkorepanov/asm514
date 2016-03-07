global _start
extern printf
extern exit

section .data
format: db 'result: %lf', 0xa, 0x0

section .bss
result: resq 1

section .text
_start:
	finit

	push rbp
	mov rbp, rsp
	sub rsp, 16
	mov rcx, 30
	fldz 
	.loop:
		test rcx, rcx
		mov [rbp-0x8], rcx ; mov rcx to local variable
		jz .exit
		fld1
		fdiv qword [rbp-0x8] ; divide 1/n^2, result in st0
		fdiv qword [rbp-0x8]
		faddp st1
		dec rcx
		jmp .loop
	.exit:
	fstp qword [rbp-0x10]

	mov rdi, format
	movq xmm0, qword [rbp-0x10]
	mov rax, 1
	call printf

	mov rsp, rbp
	pop rbp

	mov rax, 0
	call exit
	
	


		
		
