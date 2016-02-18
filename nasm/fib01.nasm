
fib01.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <apply>:
   0:	48 85 c9             	test   rcx,rcx
   3:	74 5f                	je     64 <apply+0x64>
   5:	53                   	push   rbx
   6:	41 bb 00 00 00 00    	mov    r11d,0x0
   c:	bb 00 00 00 00       	mov    ebx,0x0
  11:	66 0f 57 c9          	xorpd  xmm1,xmm1
  15:	4e 8d 0c da          	lea    r9,[rdx+r11*8]
  19:	f2 41 0f 11 09       	movsd  QWORD PTR [r9],xmm1
  1e:	4c 0f af d9          	imul   r11,rcx
  22:	b8 00 00 00 00       	mov    eax,0x0
  27:	41 b8 00 00 00 00    	mov    r8d,0x0
  2d:	4e 8d 14 18          	lea    r10,[rax+r11*1]
  31:	f2 42 0f 10 04 d7    	movsd  xmm0,QWORD PTR [rdi+r10*8]
  37:	f2 0f 59 04 c6       	mulsd  xmm0,QWORD PTR [rsi+rax*8]
  3c:	f2 41 0f 58 01       	addsd  xmm0,QWORD PTR [r9]
  41:	f2 41 0f 11 01       	movsd  QWORD PTR [r9],xmm0
  46:	41 83 c0 01          	add    r8d,0x1
  4a:	49 63 c0             	movsxd rax,r8d
  4d:	48 39 c1             	cmp    rcx,rax
  50:	77 db                	ja     2d <apply+0x2d>
  52:	83 c3 01             	add    ebx,0x1
  55:	4c 63 db             	movsxd r11,ebx
  58:	49 39 cb             	cmp    r11,rcx
  5b:	72 b8                	jb     15 <apply+0x15>
  5d:	b8 00 00 00 00       	mov    eax,0x0
  62:	5b                   	pop    rbx
  63:	c3                   	ret    
  64:	b8 00 00 00 00       	mov    eax,0x0
  69:	c3                   	ret    

000000000000006a <main>:
  6a:	55                   	push   rbp
  6b:	53                   	push   rbx
  6c:	48 83 ec 48          	sub    rsp,0x48
  70:	f2 0f 10 05 00 00 00 	movsd  xmm0,QWORD PTR [rip+0x0]        # 78 <main+0xe>
  77:	00 
  78:	f2 0f 11 44 24 20    	movsd  QWORD PTR [rsp+0x20],xmm0
  7e:	f2 0f 11 44 24 28    	movsd  QWORD PTR [rsp+0x28],xmm0
  84:	f2 0f 11 44 24 30    	movsd  QWORD PTR [rsp+0x30],xmm0
  8a:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
  91:	00 00 
  93:	f2 0f 11 04 24       	movsd  QWORD PTR [rsp],xmm0
  98:	f2 0f 10 0d 00 00 00 	movsd  xmm1,QWORD PTR [rip+0x0]        # a0 <main+0x36>
  9f:	00 
  a0:	f2 0f 11 4c 24 08    	movsd  QWORD PTR [rsp+0x8],xmm1
  a6:	83 ff 01             	cmp    edi,0x1
  a9:	7f 0c                	jg     b7 <main+0x4d>
  ab:	bd 01 00 00 00       	mov    ebp,0x1
  b0:	bb 00 00 00 00       	mov    ebx,0x0
  b5:	eb 1b                	jmp    d2 <main+0x68>
  b7:	48 8b 7e 08          	mov    rdi,QWORD PTR [rsi+0x8]
  bb:	ba 0a 00 00 00       	mov    edx,0xa
  c0:	be 00 00 00 00       	mov    esi,0x0
  c5:	e8 00 00 00 00       	call   ca <main+0x60>
  ca:	89 c5                	mov    ebp,eax
  cc:	85 c0                	test   eax,eax
  ce:	7f e0                	jg     b0 <main+0x46>
  d0:	eb 35                	jmp    107 <main+0x9d>
  d2:	b9 02 00 00 00       	mov    ecx,0x2
  d7:	48 8d 54 24 10       	lea    rdx,[rsp+0x10]
  dc:	48 89 e6             	mov    rsi,rsp
  df:	48 8d 7c 24 20       	lea    rdi,[rsp+0x20]
  e4:	e8 00 00 00 00       	call   e9 <main+0x7f>
  e9:	f2 0f 10 44 24 10    	movsd  xmm0,QWORD PTR [rsp+0x10]
  ef:	f2 0f 11 04 24       	movsd  QWORD PTR [rsp],xmm0
  f4:	f2 0f 10 44 24 18    	movsd  xmm0,QWORD PTR [rsp+0x18]
  fa:	f2 0f 11 44 24 08    	movsd  QWORD PTR [rsp+0x8],xmm0
 100:	83 c3 01             	add    ebx,0x1
 103:	39 eb                	cmp    ebx,ebp
 105:	7c cb                	jl     d2 <main+0x68>
 107:	f2 0f 10 04 24       	movsd  xmm0,QWORD PTR [rsp]
 10c:	be 00 00 00 00       	mov    esi,0x0
 111:	bf 01 00 00 00       	mov    edi,0x1
 116:	b8 01 00 00 00       	mov    eax,0x1
 11b:	e8 00 00 00 00       	call   120 <main+0xb6>
 120:	f2 0f 10 44 24 08    	movsd  xmm0,QWORD PTR [rsp+0x8]
 126:	be 00 00 00 00       	mov    esi,0x0
 12b:	bf 01 00 00 00       	mov    edi,0x1
 130:	b8 01 00 00 00       	mov    eax,0x1
 135:	e8 00 00 00 00       	call   13a <main+0xd0>
 13a:	b8 00 00 00 00       	mov    eax,0x0
 13f:	48 83 c4 48          	add    rsp,0x48
 143:	5b                   	pop    rbx
 144:	5d                   	pop    rbp
 145:	c3                   	ret    
