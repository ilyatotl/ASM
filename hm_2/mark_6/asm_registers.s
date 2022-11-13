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
	.size	get_len, .-get_len
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	push	r13         # кладем в стек регистр r13
	push	r12         # кладем в стек регистр r12
	push	rbx
	sub	rsp, 8
	mov	ebx, 0      # кладем в регистр ebx 0 (переменная len_a)
	mov	r13d, 0     # кладем в регистр r13d 0 (переменная len_b)
.L11:
	mov	rax, QWORD PTR stdin[rip]
	mov	rdi, rax
	call	getc@PLT
	mov	r12d, eax   # записываем в регистр r12d значение eax (переменная ch)
	mov	eax, ebx    # записываем в регистр eax регистр ebx (переменную len_a)
	lea	ebx, 1[rax] # увеличиваем len_a на 1
	mov	ecx, r12d
	cdqe
	lea	rdx, a[rip]
	mov	BYTE PTR [rax+rdx], cl
	cmp	r12d, -1    # сравниваем значение регистра r12d и -1 (сравниваем ch и -1)
	jne	.L11
	lea	eax, -1[rbx]
	cdqe
	lea	rdx, a[rip]
	mov	BYTE PTR [rax+rdx], 0
	sub	ebx, 1      # вычитаем из регистра ebx 1 (переменная len_a)
	mov	esi, r13d   # кладем в регистр esi значение регистра r13d (переменная len_b)
	mov	edi, ebx    # кладем в регистр edi значение регистра ebx (переменная len_a)
	call	get_len
	mov	r12d, eax   # записываем в регистр r12d значение регистра eax (в переменную last_idx записали возвращаемое знаение функции)
	mov	ebx, 0      # записываем в ebx 0 (переменная i)
	jmp	.L12
.L14:
	movsx	rax, ebx
	lea	rdx, exist[rip]
	movzx	eax, BYTE PTR [rax+rdx]
	test	al, al
	je	.L13
	mov	edi, ebx
	call	putchar@PLT
.L13:
	add	ebx, 1
.L12:
	cmp	ebx, r12d  # сравниваем регистры ebx и r12d (переменные i и last_idx)
	jle	.L14
	mov	edi, 10
	call	putchar@PLT
	mov	eax, 0
	add	rsp, 8
	pop	rbx      # удаляем регистр rbx
	pop	r12      # удаляем регистр r12
	pop	r13      # удаляем регистр r13
	pop	rbp      # удаляем регистр rbp
	ret              # выход из функции main
