	.file	"expon.c"
	.text
	.globl	expon
	.type	expon, @function
expon:
.LFB0:
	.cfi_startproc
	endbr64
	movsd	.LC0(%rip), %xmm1
	movaps	%xmm0, %xmm3
	movl	$1, %eax
	movaps	%xmm1, %xmm2
	movaps	%xmm1, %xmm0
.L2:
	cvtsi2sdl	%eax, %xmm4
	mulsd	%xmm3, %xmm2
	incl	%eax
	mulsd	%xmm4, %xmm1
	movaps	%xmm2, %xmm4
	divsd	%xmm1, %xmm4
	addsd	%xmm4, %xmm0
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
