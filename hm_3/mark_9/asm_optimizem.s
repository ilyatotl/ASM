	.file	"asm.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
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
.LC20:
	.string	"The programm was working %ldms\n"
	.section	.text.startup,"ax",@progbits
	.globl	main
	.type	main, @function
main:
.LFB24:
	.cfi_startproc
	endbr64
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	movl	%edi, %ebx
	subq	$40, %rsp
	.cfi_def_cfa_offset 80
	movq	%fs:40, %rax
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	decl	%edi
	jne	.L2
	xorl	%edi, %edi
	call	time@PLT
	movl	%eax, %edi
	call	srand@PLT
	call	rand@PLT
	movl	%eax, %r12d
	call	rand@PLT
	movl	$5, %ecx
	imull	$10, %r12d, %r12d
	leaq	.LC1(%rip), %rsi
	cltd
	movl	$1, %edi
	idivl	%ecx
	cvtsi2sdl	%r12d, %xmm0
	divsd	.LC0(%rip), %xmm0
	movb	$1, %al
	cvtsi2sdl	%edx, %xmm1
	addsd	%xmm1, %xmm0
	movsd	%xmm0, 16(%rsp)
	call	__printf_chk@PLT
	jmp	.L3
.L2:
	movq	%rsi, %r13
	cmpl	$2, %ebx
	jne	.L4
	movq	8(%rsi), %rdi
	call	atof@PLT
	movsd	%xmm0, 16(%rsp)
	jmp	.L3
.L4:
	cmpl	$3, %ebx
	jne	.L5
	movq	8(%rsi), %rdi
	leaq	.LC2(%rip), %rsi
	call	fopen@PLT
	leaq	.LC3(%rip), %rdi
	movq	%rax, %r12
	testq	%rax, %rax
	je	.L33
	movq	16(%r13), %rdi
	leaq	.LC4(%rip), %rsi
	call	fopen@PLT
	leaq	.LC5(%rip), %rdi
	movq	%rax, %rbp
	testq	%rax, %rax
	je	.L33
	movq	%r12, %rdi
	leaq	16(%rsp), %rdx
	leaq	.LC6(%rip), %rsi
	xorl	%eax, %eax
	call	__isoc99_fscanf@PLT
	movq	%r12, %rdi
	call	fclose@PLT
	jmp	.L3
.L5:
	leaq	.LC7(%rip), %rdi
	call	puts@PLT
.L3:
	movsd	16(%rsp), %xmm0
	xorps	%xmm1, %xmm1
	ucomisd	%xmm1, %xmm0
	jp	.L9
	jne	.L9
	leaq	.LC10(%rip), %rdi
	cmpl	$3, %ebx
	jne	.L33
	movq	%rbp, %rsi
	leaq	.LC9(%rip), %rdi
	call	fputs@PLT
	movq	%rbp, %rdi
	call	fclose@PLT
	jmp	.L22
.L9:
	comisd	.LC11(%rip), %xmm0
	jbe	.L28
	movq	%rbp, %rsi
	leaq	.LC12(%rip), %rdi
	cmpl	$3, %ebx
	je	.L31
	leaq	.LC13(%rip), %rdi
.L32:
	call	puts@PLT
.L15:
	leaq	.LC14(%rip), %rdi
.L33:
	call	puts@PLT
	jmp	.L22
.L28:
	movsd	.LC15(%rip), %xmm1
	comisd	%xmm0, %xmm1
	jbe	.L29
	leaq	.LC17(%rip), %rdi
	cmpl	$3, %ebx
	jne	.L32
	movq	%rbp, %rsi
	leaq	.LC16(%rip), %rdi
.L31:
	call	fputs@PLT
	movq	%rbp, %rdi
	call	fclose@PLT
	jmp	.L15
.L29:
	call	clock@PLT
	movl	$10000000, %r12d
	movq	%rax, %r13
.L19:
	movsd	16(%rsp), %xmm0
	call	expon@PLT
	movsd	%xmm0, 8(%rsp)
	movsd	16(%rsp), %xmm0
	xorps	.LC18(%rip), %xmm0
	call	expon@PLT
	decl	%r12d
	movsd	8(%rsp), %xmm1
	movaps	%xmm0, %xmm2
	jne	.L19
	movaps	%xmm1, %xmm0
	subsd	%xmm2, %xmm1
	addsd	%xmm2, %xmm0
	divsd	%xmm1, %xmm0
	movsd	%xmm0, 8(%rsp)
	call	clock@PLT
	cmpl	$3, %ebx
	movsd	8(%rsp), %xmm0
	leaq	.LC19(%rip), %rdx
	movq	%rax, %r12
	jne	.L20
	movq	%rbp, %rdi
	movl	$1, %esi
	movb	$1, %al
	call	__fprintf_chk@PLT
	movq	%rbp, %rdi
	call	fclose@PLT
	jmp	.L21
.L20:
	movq	%rdx, %rsi
	movl	$1, %edi
	movb	$1, %al
	call	__printf_chk@PLT
.L21:
	movq	%r12, %rax
	movl	$1000, %ecx
	movl	$1, %edi
	subq	%r13, %rax
	leaq	.LC20(%rip), %rsi
	cqto
	idivq	%rcx
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	__printf_chk@PLT
.L22:
	movq	24(%rsp), %rax
	subq	%fs:40, %rax
	je	.L23
	call	__stack_chk_fail@PLT
.L23:
	addq	$40, %rsp
	.cfi_def_cfa_offset 40
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE24:
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
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
	.section	.rodata.cst16,"aM",@progbits,16
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
