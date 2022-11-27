	.file	"expon.c"
	.text
	.p2align 4
	.globl	expon
	.type	expon, @function
expon:
.LFB0:
	.cfi_startproc
	endbr64
	movsd	.LC0(%rip), %xmm1
	movapd	%xmm0, %xmm4
	movl	$1, %eax
	movapd	%xmm1, %xmm2
	movapd	%xmm1, %xmm0
	.p2align 4,,10
	.p2align 3
.L2:
	mulsd	%xmm4, %xmm2
	pxor	%xmm3, %xmm3
	cvtsi2sdl	%eax, %xmm3
	addl	$1, %eax
	mulsd	%xmm3, %xmm1
	movapd	%xmm2, %xmm3
	divsd	%xmm1, %xmm3
	addsd	%xmm3, %xmm0
	cmpl	$21, %eax
	jne	.L2
	ret
	.cfi_endproc
.LFE0:
	.size	expon, .-expon
	.section	.rodata.cst8,"aM",@progbits,8
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
