	.file	"get_len.c"
	.intel_syntax noprefix
	.text
	.globl	get_len
	.type	get_len, @function
get_len:
	endbr64
	push	rbp
	mov	rbp, rsp
	mov	DWORD PTR -20[rbp], edi
	mov	DWORD PTR -24[rbp], esi
	mov	DWORD PTR -4[rbp], 0
	mov	DWORD PTR -8[rbp], 0
	mov	DWORD PTR -4[rbp], 0
	jmp	.L2
.L3:
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, a[rip]
	movzx	eax, BYTE PTR [rax+rdx]
	movsx	eax, al
	cdqe
	lea	rdx, exist[rip]
	mov	BYTE PTR [rax+rdx], 1
	add	DWORD PTR -4[rbp], 1
.L2:
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -20[rbp]
	jl	.L3
	mov	DWORD PTR -4[rbp], 0
	jmp	.L4
.L5:
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, b[rip]
	movzx	eax, BYTE PTR [rax+rdx]
	movsx	eax, al
	cdqe
	lea	rdx, exist[rip]
	mov	BYTE PTR [rax+rdx], 1
	add	DWORD PTR -4[rbp], 1
.L4:
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -24[rbp]
	jl	.L5
	mov	DWORD PTR -4[rbp], 0
	jmp	.L6
.L8:
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, exist[rip]
	movzx	eax, BYTE PTR [rax+rdx]
	test	al, al
	je	.L7
	mov	eax, DWORD PTR -4[rbp]
	mov	DWORD PTR -8[rbp], eax
.L7:
	add	DWORD PTR -4[rbp], 1
.L6:
	cmp	DWORD PTR -4[rbp], 127
	jle	.L8
	mov	eax, DWORD PTR -8[rbp]
	pop	rbp
	ret
