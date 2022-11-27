	.file	"expon.c"
	.intel_syntax noprefix
	.text
	.globl	expon
	.type	expon, @function
expon:
	endbr64
	push	rbp
	mov	rbp, rsp
	movsd	QWORD PTR -40[rbp], xmm0
	movsd	xmm0, QWORD PTR .LC0[rip]
	movsd	QWORD PTR -8[rbp], xmm0
	movsd	xmm0, QWORD PTR .LC0[rip]
	movsd	QWORD PTR -16[rbp], xmm0
	movsd	xmm0, QWORD PTR .LC0[rip]
	movsd	QWORD PTR -24[rbp], xmm0
	mov	DWORD PTR -28[rbp], 1
	jmp	.L2
.L3:
	movsd	xmm0, QWORD PTR -16[rbp]
	mulsd	xmm0, QWORD PTR -40[rbp]
	movsd	QWORD PTR -16[rbp], xmm0
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, DWORD PTR -28[rbp]
	movsd	xmm1, QWORD PTR -24[rbp]
	mulsd	xmm0, xmm1
	movsd	QWORD PTR -24[rbp], xmm0
	movsd	xmm0, QWORD PTR -16[rbp]
	divsd	xmm0, QWORD PTR -24[rbp]
	movsd	xmm1, QWORD PTR -8[rbp]
	addsd	xmm0, xmm1
	movsd	QWORD PTR -8[rbp], xmm0
	add	DWORD PTR -28[rbp], 1
.L2:
	cmp	DWORD PTR -28[rbp], 20
	jle	.L3
	movsd	xmm0, QWORD PTR -8[rbp]
	movq	rax, xmm0
	movq	xmm0, rax
	pop	rbp
	ret
	.size	expon, .-expon
	.section	.rodata
	.align 8
.LC0:
	.long	0
	.long	1072693248
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
