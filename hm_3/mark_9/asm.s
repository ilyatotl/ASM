	.file	"asm.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
.LC1:
	.string	"Number %f was generated\n"
.LC2:
	.string	"r"
.LC3:
	.string	"Cannot open input file"
.LC4:
	.string	"w"
.LC5:
	.string	"Cannot open output file"
.LC6:
	.string	"%lf"
.LC7:
	.string	"Invalid numbers of arguments"
.LC9:
	.string	"Invalid value\n"
.LC10:
	.string	"Invalid value"
.LC12:
	.string	"1.0000\n"
.LC13:
	.string	"1.0000"
.LC14:
	.string	"The programm was working 0 ms"
.LC16:
	.string	"-1.0000\n"
.LC17:
	.string	"-1.0000"
.LC19:
	.string	"%f\n"
	.align 8
.LC20:
	.string	"The programm was working %ldms\n"
	.text
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 112
	mov	DWORD PTR -84[rbp], edi
	mov	QWORD PTR -96[rbp], rsi
	cmp	DWORD PTR -84[rbp], 1
	jne	.L2
	mov	edi, 0
	call	time@PLT
	mov	edi, eax
	call	srand@PLT
	call	rand@PLT
	mov	edx, eax
	mov	eax, edx
	sal	eax, 2
	add	eax, edx
	add	eax, eax
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, eax
	movsd	xmm1, QWORD PTR .LC0[rip]
	divsd	xmm0, xmm1
	movsd	QWORD PTR -104[rbp], xmm0
	call	rand@PLT
	movsx	rdx, eax
	imul	rdx, rdx, 1717986919
	shr	rdx, 32
	sar	edx
	mov	esi, eax
	sar	esi, 31
	mov	ecx, edx
	sub	ecx, esi
	mov	edx, ecx
	sal	edx, 2
	add	edx, ecx
	sub	eax, edx
	mov	ecx, eax
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, ecx
	addsd	xmm0, QWORD PTR -104[rbp]
	movsd	QWORD PTR -72[rbp], xmm0
	mov	rax, QWORD PTR -72[rbp]
	movq	xmm0, rax
	lea	rax, .LC1[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT
	jmp	.L3
.L2:
	cmp	DWORD PTR -84[rbp], 2
	jne	.L4
	mov	rax, QWORD PTR -96[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atof@PLT
	movq	rax, xmm0
	mov	QWORD PTR -72[rbp], rax
	jmp	.L3
.L4:
	cmp	DWORD PTR -84[rbp], 3
	jne	.L5
	mov	rax, QWORD PTR -96[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC2[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -32[rbp], rax
	cmp	QWORD PTR -32[rbp], 0
	jne	.L6
	lea	rax, .LC3[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	eax, 0
	jmp	.L25
.L6:
	mov	rax, QWORD PTR -96[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC4[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -8[rbp], rax
	cmp	QWORD PTR -8[rbp], 0
	jne	.L8
	lea	rax, .LC5[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	eax, 0
	jmp	.L25
.L8:
	lea	rdx, -72[rbp]
	mov	rax, QWORD PTR -32[rbp]
	lea	rcx, .LC6[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	mov	rax, QWORD PTR -32[rbp]
	mov	rdi, rax
	call	fclose@PLT
	jmp	.L3
.L5:
	lea	rax, .LC7[rip]
	mov	rdi, rax
	call	puts@PLT
.L3:
	movsd	xmm0, QWORD PTR -72[rbp]
	pxor	xmm1, xmm1
	ucomisd	xmm0, xmm1
	jp	.L9
	pxor	xmm1, xmm1
	ucomisd	xmm0, xmm1
	jne	.L9
	cmp	DWORD PTR -84[rbp], 3
	jne	.L11
	mov	rax, QWORD PTR -8[rbp]
	mov	rcx, rax
	mov	edx, 14
	mov	esi, 1
	lea	rax, .LC9[rip]
	mov	rdi, rax
	call	fwrite@PLT
	mov	rax, QWORD PTR -8[rbp]
	mov	rdi, rax
	call	fclose@PLT
	jmp	.L12
.L11:
	lea	rax, .LC10[rip]
	mov	rdi, rax
	call	puts@PLT
.L12:
	mov	eax, 0
	jmp	.L25
.L9:
	movsd	xmm0, QWORD PTR -72[rbp]
	comisd	xmm0, QWORD PTR .LC11[rip]
	jbe	.L29
	cmp	DWORD PTR -84[rbp], 3
	jne	.L15
	mov	rax, QWORD PTR -8[rbp]
	mov	rcx, rax
	mov	edx, 7
	mov	esi, 1
	lea	rax, .LC12[rip]
	mov	rdi, rax
	call	fwrite@PLT
	mov	rax, QWORD PTR -8[rbp]
	mov	rdi, rax
	call	fclose@PLT
	jmp	.L16
.L15:
	lea	rax, .LC13[rip]
	mov	rdi, rax
	call	puts@PLT
.L16:
	lea	rax, .LC14[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	eax, 0
	jmp	.L25
.L29:
	movsd	xmm1, QWORD PTR -72[rbp]
	movsd	xmm0, QWORD PTR .LC15[rip]
	comisd	xmm0, xmm1
	jbe	.L30
	cmp	DWORD PTR -84[rbp], 3
	jne	.L19
	mov	rax, QWORD PTR -8[rbp]
	mov	rcx, rax
	mov	edx, 8
	mov	esi, 1
	lea	rax, .LC16[rip]
	mov	rdi, rax
	call	fwrite@PLT
	mov	rax, QWORD PTR -8[rbp]
	mov	rdi, rax
	call	fclose@PLT
	jmp	.L20
.L19:
	lea	rax, .LC17[rip]
	mov	rdi, rax
	call	puts@PLT
.L20:
	lea	rax, .LC14[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	eax, 0
	jmp	.L25
.L30:
	call	clock@PLT
	mov	QWORD PTR -40[rbp], rax
	mov	DWORD PTR -20[rbp], 0
	jmp	.L21
.L22:
	mov	rax, QWORD PTR -72[rbp]
	movq	xmm0, rax
	call	expon@PLT
	movq	rax, xmm0
	mov	QWORD PTR -56[rbp], rax
	movsd	xmm0, QWORD PTR -72[rbp]
	movq	xmm1, QWORD PTR .LC18[rip]
	xorpd	xmm0, xmm1
	movq	rax, xmm0
	movq	xmm0, rax
	call	expon@PLT
	movq	rax, xmm0
	mov	QWORD PTR -64[rbp], rax
	movsd	xmm0, QWORD PTR -56[rbp]
	addsd	xmm0, QWORD PTR -64[rbp]
	movsd	xmm1, QWORD PTR -56[rbp]
	subsd	xmm1, QWORD PTR -64[rbp]
	divsd	xmm0, xmm1
	movsd	QWORD PTR -16[rbp], xmm0
	add	DWORD PTR -20[rbp], 1
.L21:
	cmp	DWORD PTR -20[rbp], 9999999
	jle	.L22
	call	clock@PLT
	mov	QWORD PTR -48[rbp], rax
	cmp	DWORD PTR -84[rbp], 3
	jne	.L23
	mov	rdx, QWORD PTR -16[rbp]
	mov	rax, QWORD PTR -8[rbp]
	movq	xmm0, rdx
	lea	rdx, .LC19[rip]
	mov	rsi, rdx
	mov	rdi, rax
	mov	eax, 1
	call	fprintf@PLT
	mov	rax, QWORD PTR -8[rbp]
	mov	rdi, rax
	call	fclose@PLT
	jmp	.L24
.L23:
	mov	rax, QWORD PTR -16[rbp]
	movq	xmm0, rax
	lea	rax, .LC19[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT
.L24:
	mov	rax, QWORD PTR -48[rbp]
	sub	rax, QWORD PTR -40[rbp]
	mov	rcx, rax
	movabs	rdx, 2361183241434822607
	mov	rax, rcx
	imul	rdx
	mov	rax, rdx
	sar	rax, 7
	sar	rcx, 63
	mov	rdx, rcx
	sub	rax, rdx
	mov	rsi, rax
	lea	rax, .LC20[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	eax, 0
.L25:
	leave
	ret
	.size	main, .-main
	.section	.rodata
	.align 8
.LC0:
	.long	-4194304
	.long	1105199103
	.align 8
.LC11:
	.long	0
	.long	1076101120
	.align 8
.LC15:
	.long	0
	.long	-1071382528
	.align 16
.LC18:
	.long	0
	.long	-2147483648
	.long	0
	.long	0
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
