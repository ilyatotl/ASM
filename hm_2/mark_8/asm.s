	.file	"asm.c"
	.intel_syntax noprefix
	.text
	.globl	a
	.bss
	.align 32
	.type	a, @object
	.size	a, 100000
a:
	.zero	100000
	.globl	b
	.align 32
	.type	b, @object
	.size	b, 100000
b:
	.zero	100000
	.globl	exist
	.align 32
	.type	exist, @object
	.size	exist, 128
exist:
	.zero	128
	.section	.rodata
.LC0:
	.string	"wb"
.LC1:
	.string	"random_inputA.txt"
.LC2:
	.string	"random_inputB.txt"
.LC3:
	.string	"random_output.txt"
.LC4:
	.string	"Two strngs were generated."
.LC5:
	.string	"3 files needed"
.LC6:
	.string	"rb"
.LC7:
	.string	"Cannot open input file A"
.LC8:
	.string	"Cannot open input file B"
.LC9:
	.string	"Cannot open output file"
	.align 8
.LC10:
	.string	"Time, the pogramm was working: %ld ms\n"
	.text
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	push	rbx
	sub	rsp, 88
	mov	DWORD PTR -84[rbp], edi
	mov	QWORD PTR -96[rbp], rsi
	mov	DWORD PTR -44[rbp], 0
	mov	DWORD PTR -48[rbp], 0
	cmp	DWORD PTR -84[rbp], 1
	jne	.L2
	lea	rax, .LC0[rip]
	mov	rsi, rax
	lea	rax, .LC1[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -24[rbp], rax
	lea	rax, .LC0[rip]
	mov	rsi, rax
	lea	rax, .LC2[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -32[rbp], rax
	lea	rax, .LC0[rip]
	mov	rsi, rax
	lea	rax, .LC3[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -40[rbp], rax
	call	rand@PLT
	movsx	rdx, eax
	imul	rdx, rdx, 703694479
	shr	rdx, 32
	sar	edx, 14
	mov	ecx, eax
	sar	ecx, 31
	sub	edx, ecx
	imul	ecx, edx, 99999
	sub	eax, ecx
	mov	edx, eax
	lea	eax, 1[rdx]
	mov	DWORD PTR -44[rbp], eax
	call	rand@PLT
	movsx	rdx, eax
	imul	rdx, rdx, 703694479
	shr	rdx, 32
	sar	edx, 14
	mov	ecx, eax
	sar	ecx, 31
	sub	edx, ecx
	imul	ecx, edx, 99999
	sub	eax, ecx
	mov	edx, eax
	lea	eax, 1[rdx]
	mov	DWORD PTR -48[rbp], eax
	mov	DWORD PTR -56[rbp], 0
	jmp	.L3
.L4:
	call	rand@PLT
	movsx	rbx, eax
	call	clock@PLT
	add	rax, rbx
	cqo
	shr	rdx, 58
	add	rax, rdx
	and	eax, 63
	sub	rax, rdx
	add	eax, 32
	mov	ecx, eax
	mov	eax, DWORD PTR -56[rbp]
	cdqe
	lea	rdx, a[rip]
	mov	BYTE PTR [rax+rdx], cl
	mov	eax, DWORD PTR -56[rbp]
	cdqe
	lea	rdx, a[rip]
	movzx	eax, BYTE PTR [rax+rdx]
	movsx	eax, al
	mov	rdx, QWORD PTR -24[rbp]
	mov	rsi, rdx
	mov	edi, eax
	call	fputc@PLT
	add	DWORD PTR -56[rbp], 1
.L3:
	mov	eax, DWORD PTR -56[rbp]
	cmp	eax, DWORD PTR -44[rbp]
	jl	.L4
	mov	DWORD PTR -56[rbp], 0
	jmp	.L5
.L6:
	call	rand@PLT
	movsx	rbx, eax
	call	clock@PLT
	add	rax, rbx
	cqo
	shr	rdx, 58
	add	rax, rdx
	and	eax, 63
	sub	rax, rdx
	add	eax, 32
	mov	ecx, eax
	mov	eax, DWORD PTR -56[rbp]
	cdqe
	lea	rdx, b[rip]
	mov	BYTE PTR [rax+rdx], cl
	mov	eax, DWORD PTR -56[rbp]
	cdqe
	lea	rdx, b[rip]
	movzx	eax, BYTE PTR [rax+rdx]
	movsx	eax, al
	mov	rdx, QWORD PTR -32[rbp]
	mov	rsi, rdx
	mov	edi, eax
	call	fputc@PLT
	add	DWORD PTR -56[rbp], 1
.L5:
	mov	eax, DWORD PTR -56[rbp]
	cmp	eax, DWORD PTR -48[rbp]
	jl	.L6
	lea	rax, .LC4[rip]
	mov	rdi, rax
	call	puts@PLT
	jmp	.L7
.L2:
	mov	rax, QWORD PTR -96[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	cmp	eax, 1
	jne	.L8
.L9:
	mov	rax, QWORD PTR stdin[rip]
	mov	rdi, rax
	call	getc@PLT
	mov	DWORD PTR -60[rbp], eax
	mov	eax, DWORD PTR -44[rbp]
	lea	edx, 1[rax]
	mov	DWORD PTR -44[rbp], edx
	mov	edx, DWORD PTR -60[rbp]
	mov	ecx, edx
	cdqe
	lea	rdx, a[rip]
	mov	BYTE PTR [rax+rdx], cl
	cmp	DWORD PTR -60[rbp], -1
	jne	.L9
	mov	eax, DWORD PTR -44[rbp]
	sub	eax, 1
	cdqe
	lea	rdx, a[rip]
	mov	BYTE PTR [rax+rdx], 0
	sub	DWORD PTR -44[rbp], 1
	jmp	.L7
.L8:
	cmp	DWORD PTR -84[rbp], 5
	je	.L10
	lea	rax, .LC5[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	eax, 0
	jmp	.L11
.L10:
	mov	rax, QWORD PTR -96[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC6[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -24[rbp], rax
	cmp	QWORD PTR -24[rbp], 0
	jne	.L12
	lea	rax, .LC7[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	eax, 0
	jmp	.L11
.L12:
	mov	rax, QWORD PTR -96[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC6[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -32[rbp], rax
	cmp	QWORD PTR -32[rbp], 0
	jne	.L13
	lea	rax, .LC8[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	eax, 0
	jmp	.L11
.L13:
	mov	rax, QWORD PTR -96[rbp]
	add	rax, 32
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC0[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -40[rbp], rax
	cmp	QWORD PTR -40[rbp], 0
	jne	.L14
	lea	rax, .LC9[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	eax, 0
	jmp	.L11
.L14:
	mov	rax, QWORD PTR -24[rbp]
	mov	rdi, rax
	call	fgetc@PLT
	mov	DWORD PTR -60[rbp], eax
	mov	eax, DWORD PTR -44[rbp]
	lea	edx, 1[rax]
	mov	DWORD PTR -44[rbp], edx
	mov	edx, DWORD PTR -60[rbp]
	mov	ecx, edx
	cdqe
	lea	rdx, a[rip]
	mov	BYTE PTR [rax+rdx], cl
	cmp	DWORD PTR -60[rbp], -1
	jne	.L14
	mov	eax, DWORD PTR -44[rbp]
	sub	eax, 1
	cdqe
	lea	rdx, a[rip]
	mov	BYTE PTR [rax+rdx], 0
	sub	DWORD PTR -44[rbp], 1
.L15:
	mov	rax, QWORD PTR -32[rbp]
	mov	rdi, rax
	call	fgetc@PLT
	mov	DWORD PTR -60[rbp], eax
	mov	eax, DWORD PTR -48[rbp]
	lea	edx, 1[rax]
	mov	DWORD PTR -48[rbp], edx
	mov	edx, DWORD PTR -60[rbp]
	mov	ecx, edx
	cdqe
	lea	rdx, b[rip]
	mov	BYTE PTR [rax+rdx], cl
	cmp	DWORD PTR -60[rbp], -1
	jne	.L15
	mov	eax, DWORD PTR -48[rbp]
	sub	eax, 1
	cdqe
	lea	rdx, b[rip]
	mov	BYTE PTR [rax+rdx], 0
	sub	DWORD PTR -48[rbp], 1
.L7:
	call	clock@PLT
	mov	QWORD PTR -72[rbp], rax
	mov	DWORD PTR -56[rbp], 0
	jmp	.L16
.L17:
	mov	edx, DWORD PTR -48[rbp]
	mov	eax, DWORD PTR -44[rbp]
	mov	esi, edx
	mov	edi, eax
	call	get_len@PLT
	mov	DWORD PTR -52[rbp], eax
	add	DWORD PTR -56[rbp], 1
.L16:
	cmp	DWORD PTR -56[rbp], 99999
	jle	.L17
	call	clock@PLT
	mov	QWORD PTR -80[rbp], rax
	mov	DWORD PTR -56[rbp], 0
	jmp	.L18
.L22:
	cmp	DWORD PTR -84[rbp], 1
	je	.L19
	mov	rax, QWORD PTR -96[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	cmp	eax, 1
	je	.L20
.L19:
	mov	rdx, QWORD PTR -40[rbp]
	mov	eax, DWORD PTR -56[rbp]
	mov	rsi, rdx
	mov	edi, eax
	call	fputc@PLT
	jmp	.L21
.L20:
	mov	rdx, QWORD PTR stdin[rip]
	mov	eax, DWORD PTR -56[rbp]
	mov	rsi, rdx
	mov	edi, eax
	call	fputc@PLT
.L21:
	add	DWORD PTR -56[rbp], 1
.L18:
	mov	eax, DWORD PTR -56[rbp]
	cmp	eax, DWORD PTR -52[rbp]
	jle	.L22
	mov	edi, 10
	call	putchar@PLT
	mov	rax, QWORD PTR -80[rbp]
	sub	rax, QWORD PTR -72[rbp]
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
	lea	rax, .LC10[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	cmp	DWORD PTR -84[rbp], 1
	je	.L23
	mov	rax, QWORD PTR -96[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	cmp	eax, 1
	je	.L24
.L23:
	mov	rax, QWORD PTR -40[rbp]
	mov	rdi, rax
	call	fclose@PLT
	mov	rax, QWORD PTR -24[rbp]
	mov	rdi, rax
	call	fclose@PLT
	mov	rax, QWORD PTR -32[rbp]
	mov	rdi, rax
	call	fclose@PLT
.L24:
	mov	eax, 0
.L11:
	mov	rbx, QWORD PTR -8[rbp]
	leave
	ret
