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
.LC8:
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
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC20:
	.string	"The programm was working %ldms\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB39:
	.cfi_startproc
	endbr64
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	movl	%edi, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	subq	$32, %rsp
	.cfi_def_cfa_offset 80
	movq	%fs:40, %rax
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	cmpl	$1, %edi
	je	.L35
	movq	%rsi, %rbx
	cmpl	$2, %edi
	je	.L36
	cmpl	$3, %edi
	je	.L37
	leaq	.LC8(%rip), %rdi
	call	puts@PLT
.L3:
	movsd	16(%rsp), %xmm0
	ucomisd	.LC7(%rip), %xmm0
	jp	.L25
	je	.L38
.L25:
	comisd	.LC11(%rip), %xmm0
	ja	.L39
.L12:
	movsd	.LC15(%rip), %xmm1
	comisd	%xmm0, %xmm1
	jbe	.L31
	cmpl	$3, %ebp
	je	.L40
	leaq	.LC17(%rip), %rdi
	call	puts@PLT
.L15:
	leaq	.LC14(%rip), %rdi
	call	puts@PLT
	jmp	.L22
.L37:
	movq	8(%rsi), %rdi
	leaq	.LC2(%rip), %rsi
	call	fopen@PLT
	movq	%rax, %r14
	testq	%rax, %rax
	je	.L41
	movq	16(%rbx), %rdi
	leaq	.LC4(%rip), %rsi
	call	fopen@PLT
	movq	%rax, %r12
	movq	%rax, %r13
	testq	%rax, %rax
	je	.L42
	leaq	16(%rsp), %rdx
	leaq	.LC6(%rip), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	call	__isoc99_fscanf@PLT
	movq	%r14, %rdi
	call	fclose@PLT
	movsd	16(%rsp), %xmm0
	ucomisd	.LC7(%rip), %xmm0
	jp	.L11
	jne	.L11
	movq	%r12, %rcx
	movl	$14, %edx
	movl	$1, %esi
	leaq	.LC9(%rip), %rdi
	call	fwrite@PLT
	movq	%r12, %rdi
	call	fclose@PLT
	jmp	.L22
.L38:
	leaq	.LC10(%rip), %rdi
	call	puts@PLT
.L22:
	movq	24(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L43
	addq	$32, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
.L31:
	.cfi_restore_state
	call	clock@PLT
	movl	$10000000, %ebx
	movq	%rax, %r12
	.p2align 4,,10
	.p2align 3
.L19:
	movsd	16(%rsp), %xmm0
	call	expon@PLT
	movsd	%xmm0, 8(%rsp)
	movsd	16(%rsp), %xmm0
	xorpd	.LC18(%rip), %xmm0
	call	expon@PLT
	subl	$1, %ebx
	jne	.L19
	movsd	8(%rsp), %xmm3
	movapd	%xmm3, %xmm2
	subsd	%xmm0, %xmm3
	addsd	%xmm0, %xmm2
	divsd	%xmm3, %xmm2
	movsd	%xmm2, 8(%rsp)
	call	clock@PLT
	cmpl	$3, %ebp
	movsd	8(%rsp), %xmm0
	movq	%rax, %rbx
	je	.L44
	leaq	.LC19(%rip), %rsi
	movl	$1, %edi
	movl	$1, %eax
	call	__printf_chk@PLT
.L21:
	movq	%rbx, %rax
	movl	$1000, %ecx
	movl	$1, %edi
	subq	%r12, %rax
	leaq	.LC20(%rip), %rsi
	cqto
	idivq	%rcx
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L22
.L35:
	xorl	%edi, %edi
	call	time@PLT
	movl	%eax, %edi
	call	srand@PLT
	call	rand@PLT
	movl	%eax, %ebx
	call	rand@PLT
	pxor	%xmm1, %xmm1
	imull	$10, %ebx, %ebx
	pxor	%xmm0, %xmm0
	movl	$5, %ecx
	cltd
	movl	$1, %edi
	idivl	%ecx
	cvtsi2sdl	%ebx, %xmm0
	leaq	.LC1(%rip), %rsi
	movl	$1, %eax
	divsd	.LC0(%rip), %xmm0
	cvtsi2sdl	%edx, %xmm1
	addsd	%xmm1, %xmm0
	movsd	%xmm0, 16(%rsp)
	call	__printf_chk@PLT
	jmp	.L3
.L11:
	comisd	.LC11(%rip), %xmm0
	jbe	.L12
.L26:
	movq	%r13, %rcx
	movl	$7, %edx
	movl	$1, %esi
	leaq	.LC12(%rip), %rdi
	call	fwrite@PLT
	movq	%r13, %rdi
	call	fclose@PLT
	jmp	.L15
.L40:
	movq	%r13, %rcx
	movl	$8, %edx
	movl	$1, %esi
	leaq	.LC16(%rip), %rdi
	call	fwrite@PLT
	movq	%r13, %rdi
	call	fclose@PLT
	jmp	.L15
.L44:
	movq	%r13, %rdi
	movl	$1, %esi
	movl	$1, %eax
	leaq	.LC19(%rip), %rdx
	call	__fprintf_chk@PLT
	movq	%r13, %rdi
	call	fclose@PLT
	jmp	.L21
.L39:
	cmpl	$3, %ebp
	je	.L26
	leaq	.LC13(%rip), %rdi
	call	puts@PLT
	jmp	.L15
.L36:
	movq	8(%rsi), %rdi
	xorl	%esi, %esi
	call	strtod@PLT
	movsd	%xmm0, 16(%rsp)
	jmp	.L3
.L43:
	call	__stack_chk_fail@PLT
.L41:
	leaq	.LC3(%rip), %rdi
	call	puts@PLT
	jmp	.L22
.L42:
	leaq	.LC5(%rip), %rdi
	call	puts@PLT
	jmp	.L22
	.cfi_endproc
.LFE39:
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	-4194304
	.long	1105199103
	.set	.LC7,.LC18+8
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
