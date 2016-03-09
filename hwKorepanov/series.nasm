global _start
extern printf
extern exit

section .data
format: db 'result: %lf', 0xa, 0x0

section .text
_start:
	finit

	push rbp
	mov rbp, rsp
	sub rsp, 16
	mov rcx, 3000000
	fldz 
	.loop:
		test rcx, rcx
		mov [rbp-0x8], rcx ; mov rcx to local variable
		jz .exit
		fld1
        fild qword [rbp-0x8]
		fdiv st1, st0 ; divide 1/n^2, result in st0
		fdivp st1, st0
		faddp
		dec rcx
		jmp .loop
	.exit:
	fstp qword [rbp-0x10]

    mov rax, 0x1
	mov rdi, format
	movq xmm0, qword [rbp-0x10]


    ; 16 bit alignmet means that rsp must have an adress like *10000 or *00000
    ; -16 is 11111111111110000
    ; so, wasting memory but not thinking too much we can write

    and rsp, -16
    add rsp, 16
	call printf

	mov rsp, rbp
	pop rbp

	mov rax, 0
	call exit
