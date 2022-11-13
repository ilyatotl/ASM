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
	mov	DWORD PTR -4[rbp], 0       # инициализирцем перменную i нулем
	mov	DWORD PTR -8[rbp], 0       # инициализируем переменную last_idx нулем
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
	mov	BYTE PTR [rax+rdx], 1    # exist[a[i]] = true;
	add	DWORD PTR -4[rbp], 1
.L2:
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -20[rbp]  # сравниваем eax (в нем лежит значение перменной i) с аргументом len_a
	jl	.L3
	mov	DWORD PTR -4[rbp], 0     # инициализируем переменную i нулем
	jmp	.L4
.L5:
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, b[rip]
	movzx	eax, BYTE PTR [rax+rdx]
	movsx	eax, al
	cdqe
	lea	rdx, exist[rip]
	mov	BYTE PTR [rax+rdx], 1    # exist[b[i]] = true;
	add	DWORD PTR -4[rbp], 1
.L4:
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -24[rbp]  # сравниваем eax (в нем лежит значение перменной i) с аргументом len_b
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
	mov	DWORD PTR -8[rbp], eax  # записываем в переменную last_idx значение регистра eax (17 строка)
.L7:
	add	DWORD PTR -4[rbp], 1
.L6:
	cmp	DWORD PTR -4[rbp], 127  # сравниваем перменную i и 127 (условие цикла)
	jle	.L8
	mov	eax, DWORD PTR -8[rbp]  # записали в регистр eax значение переменной last_idx
	pop	rbp
	ret                             # выход из функции
