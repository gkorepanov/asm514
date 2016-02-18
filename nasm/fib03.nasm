
fib03.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <apply>:
   0:	48 85 c9             	test   rcx,rcx
   3:	74 78                	je     7d <apply+0x7d>
   5:	55                   	push   rbp
   6:	66 0f 57 d2          	xorpd  xmm2,xmm2
   a:	4c 8d 59 01          	lea    r11,[rcx+0x1]
   e:	bd 01 00 00 00       	mov    ebp,0x1
  13:	53                   	push   rbx
  14:	31 db                	xor    ebx,ebx
  16:	66 2e 0f 1f 84 00 00 	nop    WORD PTR cs:[rax+rax*1+0x0]
  1d:	00 00 00 
  20:	4c 8d 14 da          	lea    r10,[rdx+rbx*8]
  24:	41 b8 01 00 00 00    	mov    r8d,0x1
  2a:	31 c0                	xor    eax,eax
  2c:	48 0f af d9          	imul   rbx,rcx
  30:	66 0f 28 ca          	movapd xmm1,xmm2
  34:	49 c7 02 00 00 00 00 	mov    QWORD PTR [r10],0x0
  3b:	eb 09                	jmp    46 <apply+0x46>
  3d:	0f 1f 00             	nop    DWORD PTR [rax]
  40:	4c 89 c0             	mov    rax,r8
  43:	4d 89 c8             	mov    r8,r9
  46:	4c 8d 0c 18          	lea    r9,[rax+rbx*1]
  4a:	f2 42 0f 10 04 cf    	movsd  xmm0,QWORD PTR [rdi+r9*8]
  50:	4d 8d 48 01          	lea    r9,[r8+0x1]
  54:	f2 0f 59 04 c6       	mulsd  xmm0,QWORD PTR [rsi+rax*8]
  59:	4d 39 d9             	cmp    r9,r11
  5c:	f2 0f 58 c8          	addsd  xmm1,xmm0
  60:	f2 41 0f 11 0a       	movsd  QWORD PTR [r10],xmm1
  65:	75 d9                	jne    40 <apply+0x40>
  67:	48 8d 45 01          	lea    rax,[rbp+0x1]
  6b:	4c 39 d8             	cmp    rax,r11
  6e:	74 08                	je     78 <apply+0x78>
  70:	48 89 eb             	mov    rbx,rbp
  73:	48 89 c5             	mov    rbp,rax
  76:	eb a8                	jmp    20 <apply+0x20>
  78:	5b                   	pop    rbx
  79:	31 c0                	xor    eax,eax
  7b:	5d                   	pop    rbp
  7c:	c3                   	ret    
  7d:	31 c0                	xor    eax,eax
  7f:	c3                   	ret    

Disassembly of section .text.startup:

0000000000000000 <main>:
   0:	48 83 ec 18          	sub    rsp,0x18
   4:	83 ff 01             	cmp    edi,0x1
   7:	7f 7d                	jg     86 <main+0x86>
   9:	ba 01 00 00 00       	mov    edx,0x1
   e:	66 0f 57 db          	xorpd  xmm3,xmm3
  12:	31 c0                	xor    eax,eax
  14:	f2 0f 10 0d 00 00 00 	movsd  xmm1,QWORD PTR [rip+0x0]        # 1c <main+0x1c>
  1b:	00 
  1c:	f2 0f 10 05 00 00 00 	movsd  xmm0,QWORD PTR [rip+0x0]        # 24 <main+0x24>
  23:	00 
  24:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
  28:	f2 0f 58 c3          	addsd  xmm0,xmm3
  2c:	83 c0 01             	add    eax,0x1
  2f:	39 d0                	cmp    eax,edx
  31:	66 0f 28 d0          	movapd xmm2,xmm0
  35:	66 0f 28 c1          	movapd xmm0,xmm1
  39:	f2 0f 59 cb          	mulsd  xmm1,xmm3
  3d:	f2 0f 58 c2          	addsd  xmm0,xmm2
  41:	f2 0f 58 ca          	addsd  xmm1,xmm2
  45:	7c e1                	jl     28 <main+0x28>
  47:	be 00 00 00 00       	mov    esi,0x0
  4c:	bf 01 00 00 00       	mov    edi,0x1
  51:	b8 01 00 00 00       	mov    eax,0x1
  56:	f2 0f 11 4c 24 08    	movsd  QWORD PTR [rsp+0x8],xmm1
  5c:	e8 00 00 00 00       	call   61 <main+0x61>
  61:	f2 0f 10 4c 24 08    	movsd  xmm1,QWORD PTR [rsp+0x8]
  67:	be 00 00 00 00       	mov    esi,0x0
  6c:	bf 01 00 00 00       	mov    edi,0x1
  71:	b8 01 00 00 00       	mov    eax,0x1
  76:	66 0f 28 c1          	movapd xmm0,xmm1
  7a:	e8 00 00 00 00       	call   7f <main+0x7f>
  7f:	31 c0                	xor    eax,eax
  81:	48 83 c4 18          	add    rsp,0x18
  85:	c3                   	ret    
  86:	48 8b 7e 08          	mov    rdi,QWORD PTR [rsi+0x8]
  8a:	ba 0a 00 00 00       	mov    edx,0xa
  8f:	31 f6                	xor    esi,esi
  91:	e8 00 00 00 00       	call   96 <main+0x96>
  96:	85 c0                	test   eax,eax
  98:	89 c2                	mov    edx,eax
  9a:	0f 8f 6e ff ff ff    	jg     e <main+0xe>
  a0:	f2 0f 10 0d 00 00 00 	movsd  xmm1,QWORD PTR [rip+0x0]        # a8 <main+0xa8>
  a7:	00 
  a8:	f2 0f 10 05 00 00 00 	movsd  xmm0,QWORD PTR [rip+0x0]        # b0 <main+0xb0>
  af:	00 
  b0:	eb 95                	jmp    47 <main+0x47>
