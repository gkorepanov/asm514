	.file	"fib.c"
	.text
.globl apply
	.type	apply, @function
apply:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movq	%rcx, -48(%rbp)
	movl	$0, -8(%rbp)
	jmp	.L2
.L5:
	movl	-8(%rbp), %eax
	cltq
	salq	$3, %rax
	addq	-40(%rbp), %rax
	movl	$0, %edx
	movq	%rdx, (%rax)
	movl	$0, -4(%rbp)
	jmp	.L3
.L4:
	movl	-8(%rbp), %eax
	cltq
	salq	$3, %rax
	addq	-40(%rbp), %rax
	movl	-8(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	-40(%rbp), %rdx
	movsd	(%rdx), %xmm1
	movl	-8(%rbp), %edx
	movslq	%edx, %rdx
	movq	%rdx, %rcx
	imulq	-48(%rbp), %rcx
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	leaq	(%rcx,%rdx), %rdx
	salq	$3, %rdx
	addq	-24(%rbp), %rdx
	movsd	(%rdx), %xmm2
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	-32(%rbp), %rdx
	movsd	(%rdx), %xmm0
	mulsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, (%rax)
	addl	$1, -4(%rbp)
.L3:
	movl	-4(%rbp), %eax
	cltq
	cmpq	-48(%rbp), %rax
	jb	.L4
	addl	$1, -8(%rbp)
.L2:
	movl	-8(%rbp), %eax
	cltq
	cmpq	-48(%rbp), %rax
	jb	.L5
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	apply, .-apply
	.section	.rodata
.LC3:
	.string	"%lf\n"
	.text
.globl main
	.type	main, @function
main:
.LFB1:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$104, %rsp
	movl	%edi, -100(%rbp)
	movq	%rsi, -112(%rbp)
	movl	$1, -28(%rbp)
	movl	$0, -24(%rbp)
	movl	$0, -20(%rbp)
	movabsq	$4607182418800017408, %rax
	movq	%rax, -64(%rbp)
	movabsq	$4607182418800017408, %rax
	movq	%rax, -56(%rbp)
	movabsq	$4607182418800017408, %rax
	movq	%rax, -48(%rbp)
	movl	$0, %eax
	movq	%rax, -40(%rbp)
	movabsq	$4607182418800017408, %rax
	movq	%rax, -80(%rbp)
	movabsq	$4619567317775286272, %rax
	movq	%rax, -72(%rbp)
	cmpl	$1, -100(%rbp)
	jle	.L8
	.cfi_offset 3, -24
	movq	-112(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	atoi
	movl	%eax, -28(%rbp)
.L8:
	movl	$0, -24(%rbp)
	jmp	.L9
.L12:
	leaq	-96(%rbp), %rdx
	leaq	-80(%rbp), %rbx
	leaq	-64(%rbp), %rax
	movl	$2, %ecx
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	apply
	movl	$0, -20(%rbp)
	jmp	.L10
.L11:
	movl	-20(%rbp), %ecx
	movl	-20(%rbp), %eax
	cltq
	movq	-96(%rbp,%rax,8), %rdx
	movslq	%ecx, %rax
	movq	%rdx, -80(%rbp,%rax,8)
	addl	$1, -20(%rbp)
.L10:
	cmpl	$1, -20(%rbp)
	jle	.L11
	addl	$1, -24(%rbp)
.L9:
	movl	-24(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jl	.L12
	movl	$0, -20(%rbp)
	jmp	.L13
.L14:
	movl	-20(%rbp), %eax
	cltq
	movsd	-80(%rbp,%rax,8), %xmm0
	movl	$.LC3, %eax
	movq	%rax, %rdi
	movl	$1, %eax
	call	printf
	addl	$1, -20(%rbp)
.L13:
	cmpl	$1, -20(%rbp)
	jle	.L14
	movl	$0, %eax
	addq	$104, %rsp
	popq	%rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	main, .-main
	.ident	"GCC: (GNU) 4.4.7 20120313 (Red Hat 4.4.7-16)"
	.section	.note.GNU-stack,"",@progbits
