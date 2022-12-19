	.file	"get_size.c"
	.intel_syntax noprefix
	.text
	.globl	get_size
	.type	get_size, @function
get_size:
	endbr64
	push	rbp
	mov	rbp, rsp
	mov	DWORD PTR -20[rbp], edi               # достаем аргумент a_sz с регистра edi
	mov	DWORD PTR -24[rbp], esi               # достаем аргмент x с регистра esi
	mov	DWORD PTR -4[rbp], 0                  # инициализиурем переменную b_sz 0
	mov	DWORD PTR -8[rbp], 0                  # инициализиурем переменную i нулем
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
	add	DWORD PTR -4[rbp], 1                   # прибавляем к b_sz 1
.L3:
	add	DWORD PTR -8[rbp], 1                   # прибавляем к i 1
.L2:
	mov	eax, DWORD PTR -8[rbp]                 
	cmp	eax, DWORD PTR -20[rbp]                # сравниваем i с a_sz
	jl	.L4
	mov	eax, DWORD PTR -4[rbp]                 # кладем в регистр eax переменную b_sz
	pop	rbp
	ret
	.size	get_size, .-get_size
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
