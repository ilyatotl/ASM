	.file	"asm.c"
	.intel_syntax noprefix
	.text
	.globl	a
	.bss
	.align 32
	.type	a, @object
	.size	a, 400000
a:
	.zero	400000
	.globl	b
	.align 32
	.type	b, @object
	.size	b, 400000
b:
	.zero	400000
	.text
	.globl	get_size
	.type	get_size, @function
get_size:
	endbr64
	push	rbp
	mov	rbp, rsp
	mov	DWORD PTR -20[rbp], edi
	mov	DWORD PTR -24[rbp], esi
	mov	DWORD PTR -4[rbp], 0
	mov	DWORD PTR -8[rbp], 0
	mov	DWORD PTR -8[rbp], 0
	jmp	.L2
.L4:
	mov	eax, DWORD PTR -8[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	lea	rax, a[rip]
	mov	eax, DWORD PTR [rdx+rax]
	cdq
	idiv	DWORD PTR -24[rbp]
	mov	eax, edx
	test	eax, eax
	jne	.L3
	add	DWORD PTR -4[rbp], 1
.L3:
	add	DWORD PTR -8[rbp], 1
.L2:
	mov	eax, DWORD PTR -8[rbp]
	cmp	eax, DWORD PTR -20[rbp]
	jl	.L4
	mov	eax, DWORD PTR -4[rbp]
	pop	rbp
	ret
	.size	get_size, .-get_size
	.section	.rodata
.LC0:
	.string	"%d "
	.text
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 24
	mov	DWORD PTR -52[rbp], edi
	mov	QWORD PTR -64[rbp], rsi
	mov	eax, DWORD PTR -52[rbp]
	lea	r12d, -2[rax]                  # записываем в регистр r12d переменную a_sz(строка 18)
	mov	eax, DWORD PTR -52[rbp]
	cdqe
	sal	rax, 3
	lea	rdx, -8[rax]
	mov	rax, QWORD PTR -64[rbp]
	add	rax, rdx
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT                       # вызываем функцию atoi
	mov	r14d, eax                      # записываем в регистр r14d переменную x (строка 18)
	mov	r13d, 0                        # записываем в регистр r13d перемменную idx
	mov	ebx, 0                         # записываем в регистр ebx переменную i
	jmp	.L7
.L8:
	movsx	rax, ebx
	add	rax, 1
	lea	rdx, 0[0+rax*8]
	mov	rax, QWORD PTR -64[rbp]
	add	rax, rdx
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	movsx	rdx, ebx
	lea	rcx, 0[0+rdx*4]
	lea	rdx, a[rip]
	mov	DWORD PTR [rcx+rdx], eax
	add	ebx, 1
.L7:
	cmp	ebx, r12d                     # сравниавем регистры ebx и r12d (переменные i и a_sz) (строка 19)
	jl	.L8
	mov	esi, r14d
	mov	edi, r12d
	call	get_size                      # вызываем функцию get_size
	mov	r15d, eax                     # записываем в регистр r15d знаяение b_sz (строка 22)
	mov	ebx, 0                        # записываем в регистр ebx 0
	jmp	.L9
.L11:
	movsx	rax, ebx
	lea	rdx, 0[0+rax*4]
	lea	rax, a[rip]
	mov	eax, DWORD PTR [rdx+rax]
	cdq
	idiv	r14d
	mov	eax, edx
	test	eax, eax
	jne	.L10
	movsx	rax, ebx
	lea	rdx, 0[0+rax*4]
	lea	rax, a[rip]
	mov	eax, DWORD PTR [rdx+rax]
	movsx	rdx, r13d
	lea	rcx, 0[0+rdx*4]
	lea	rdx, b[rip]
	mov	DWORD PTR [rcx+rdx], eax
	add	r13d, 1                        # прибавляем к переменной idx 1 (строка 26)
.L10:
	add	ebx, 1
.L9:
	cmp	ebx, r12d                      # сравниавем регистры ebx и r12d (переменные i и a_sz) (строка 23)
	jl	.L11
	mov	ebx, 0                         # записываем в переменную i 0
	jmp	.L12
.L13:
	movsx	rax, ebx
	lea	rdx, 0[0+rax*4]
	lea	rax, b[rip]
	mov	eax, DWORD PTR [rdx+rax]
	mov	esi, eax
	lea	rax, .LC0[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	add	ebx, 1
.L12:
	cmp	ebx, r15d                     # сравниавем регистры ebx и r15d переменные i и b_sz (строка 29)
	jl	.L13
	mov	edi, 10
	call	putchar@PLT
	mov	eax, 0
	add	rsp, 24
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	ret
