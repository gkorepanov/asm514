
fib.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <apply>:
   0:	55                   	push   rbp
   1:	48 89 e5             	mov    rbp,rsp
   4:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
   8:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
   c:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
  10:	48 89 4d d0          	mov    QWORD PTR [rbp-0x30],rcx
  14:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [rbp-0x8],0x0
  1b:	e9 92 00 00 00       	jmp    b2 <apply+0xb2>
  20:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
  23:	48 98                	cdqe   
  25:	48 c1 e0 03          	shl    rax,0x3
  29:	48 03 45 d8          	add    rax,QWORD PTR [rbp-0x28]
  2d:	ba 00 00 00 00       	mov    edx,0x0
  32:	48 89 10             	mov    QWORD PTR [rax],rdx
  35:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
  3c:	eb 65                	jmp    a3 <apply+0xa3>
  3e:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
  41:	48 98                	cdqe   
  43:	48 c1 e0 03          	shl    rax,0x3
  47:	48 03 45 d8          	add    rax,QWORD PTR [rbp-0x28]
  4b:	8b 55 f8             	mov    edx,DWORD PTR [rbp-0x8]
  4e:	48 63 d2             	movsxd rdx,edx
  51:	48 c1 e2 03          	shl    rdx,0x3
  55:	48 03 55 d8          	add    rdx,QWORD PTR [rbp-0x28]
  59:	f2 0f 10 0a          	movsd  xmm1,QWORD PTR [rdx]
  5d:	8b 55 f8             	mov    edx,DWORD PTR [rbp-0x8]
  60:	48 63 d2             	movsxd rdx,edx
  63:	48 89 d1             	mov    rcx,rdx
  66:	48 0f af 4d d0       	imul   rcx,QWORD PTR [rbp-0x30]
  6b:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
  6e:	48 63 d2             	movsxd rdx,edx
  71:	48 8d 14 11          	lea    rdx,[rcx+rdx*1]
  75:	48 c1 e2 03          	shl    rdx,0x3
  79:	48 03 55 e8          	add    rdx,QWORD PTR [rbp-0x18]
  7d:	f2 0f 10 12          	movsd  xmm2,QWORD PTR [rdx]
  81:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
  84:	48 63 d2             	movsxd rdx,edx
  87:	48 c1 e2 03          	shl    rdx,0x3
  8b:	48 03 55 e0          	add    rdx,QWORD PTR [rbp-0x20]
  8f:	f2 0f 10 02          	movsd  xmm0,QWORD PTR [rdx]
  93:	f2 0f 59 c2          	mulsd  xmm0,xmm2
  97:	f2 0f 58 c1          	addsd  xmm0,xmm1
  9b:	f2 0f 11 00          	movsd  QWORD PTR [rax],xmm0
  9f:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
  a3:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
  a6:	48 98                	cdqe   
  a8:	48 3b 45 d0          	cmp    rax,QWORD PTR [rbp-0x30]
  ac:	72 90                	jb     3e <apply+0x3e>
  ae:	83 45 f8 01          	add    DWORD PTR [rbp-0x8],0x1
  b2:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
  b5:	48 98                	cdqe   
  b7:	48 3b 45 d0          	cmp    rax,QWORD PTR [rbp-0x30]
  bb:	0f 82 5f ff ff ff    	jb     20 <apply+0x20>
  c1:	b8 00 00 00 00       	mov    eax,0x0
  c6:	c9                   	leave  
  c7:	c3                   	ret    

00000000000000c8 <main>:
  c8:	55                   	push   rbp
  c9:	48 89 e5             	mov    rbp,rsp
  cc:	53                   	push   rbx
  cd:	48 83 ec 68          	sub    rsp,0x68
  d1:	89 7d 9c             	mov    DWORD PTR [rbp-0x64],edi
  d4:	48 89 75 90          	mov    QWORD PTR [rbp-0x70],rsi
  d8:	c7 45 e4 01 00 00 00 	mov    DWORD PTR [rbp-0x1c],0x1
  df:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [rbp-0x18],0x0
  e6:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [rbp-0x14],0x0
  ed:	48 b8 00 00 00 00 00 	movabs rax,0x3ff0000000000000
  f4:	00 f0 3f 
  f7:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
  fb:	48 b8 00 00 00 00 00 	movabs rax,0x3ff0000000000000
 102:	00 f0 3f 
 105:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
 109:	48 b8 00 00 00 00 00 	movabs rax,0x3ff0000000000000
 110:	00 f0 3f 
 113:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
 117:	b8 00 00 00 00       	mov    eax,0x0
 11c:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
 120:	48 b8 00 00 00 00 00 	movabs rax,0x3ff0000000000000
 127:	00 f0 3f 
 12a:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax
 12e:	48 b8 00 00 00 00 00 	movabs rax,0x401c000000000000
 135:	00 1c 40 
 138:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
 13c:	83 7d 9c 01          	cmp    DWORD PTR [rbp-0x64],0x1
 140:	7e 16                	jle    158 <main+0x90>
 142:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
 146:	48 83 c0 08          	add    rax,0x8
 14a:	48 8b 00             	mov    rax,QWORD PTR [rax]
 14d:	48 89 c7             	mov    rdi,rax
 150:	e8 00 00 00 00       	call   155 <main+0x8d>
 155:	89 45 e4             	mov    DWORD PTR [rbp-0x1c],eax
 158:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [rbp-0x18],0x0
 15f:	eb 48                	jmp    1a9 <main+0xe1>
 161:	48 8d 55 a0          	lea    rdx,[rbp-0x60]
 165:	48 8d 5d b0          	lea    rbx,[rbp-0x50]
 169:	48 8d 45 c0          	lea    rax,[rbp-0x40]
 16d:	b9 02 00 00 00       	mov    ecx,0x2
 172:	48 89 de             	mov    rsi,rbx
 175:	48 89 c7             	mov    rdi,rax
 178:	e8 00 00 00 00       	call   17d <main+0xb5>
 17d:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [rbp-0x14],0x0
 184:	eb 19                	jmp    19f <main+0xd7>
 186:	8b 4d ec             	mov    ecx,DWORD PTR [rbp-0x14]
 189:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
 18c:	48 98                	cdqe   
 18e:	48 8b 54 c5 a0       	mov    rdx,QWORD PTR [rbp+rax*8-0x60]
 193:	48 63 c1             	movsxd rax,ecx
 196:	48 89 54 c5 b0       	mov    QWORD PTR [rbp+rax*8-0x50],rdx
 19b:	83 45 ec 01          	add    DWORD PTR [rbp-0x14],0x1
 19f:	83 7d ec 01          	cmp    DWORD PTR [rbp-0x14],0x1
 1a3:	7e e1                	jle    186 <main+0xbe>
 1a5:	83 45 e8 01          	add    DWORD PTR [rbp-0x18],0x1
 1a9:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
 1ac:	3b 45 e4             	cmp    eax,DWORD PTR [rbp-0x1c]
 1af:	7c b0                	jl     161 <main+0x99>
 1b1:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [rbp-0x14],0x0
 1b8:	eb 21                	jmp    1db <main+0x113>
 1ba:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
 1bd:	48 98                	cdqe   
 1bf:	f2 0f 10 44 c5 b0    	movsd  xmm0,QWORD PTR [rbp+rax*8-0x50]
 1c5:	b8 00 00 00 00       	mov    eax,0x0
 1ca:	48 89 c7             	mov    rdi,rax
 1cd:	b8 01 00 00 00       	mov    eax,0x1
 1d2:	e8 00 00 00 00       	call   1d7 <main+0x10f>
 1d7:	83 45 ec 01          	add    DWORD PTR [rbp-0x14],0x1
 1db:	83 7d ec 01          	cmp    DWORD PTR [rbp-0x14],0x1
 1df:	7e d9                	jle    1ba <main+0xf2>
 1e1:	b8 00 00 00 00       	mov    eax,0x0
 1e6:	48 83 c4 68          	add    rsp,0x68
 1ea:	5b                   	pop    rbx
 1eb:	c9                   	leave  
 1ec:	c3                   	ret    
