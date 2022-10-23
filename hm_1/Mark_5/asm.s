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
	push	rbp                                   # Кладем регистр rbp в стек
	mov	rbp, rsp
	mov	DWORD PTR -20[rbp], edi               # Записываем в аргумент a_sz значение регистра edi
	mov	DWORD PTR -24[rbp], esi               # Записываем в аргумент x значение регистра esi
	mov	DWORD PTR -4[rbp], 0                  # Инициализируем локальную переменную b_sz нулем
	mov	DWORD PTR -8[rbp], 0                  # Инициализируем локальную переменную i нулем
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
	add	DWORD PTR -4[rbp], 1                 # увеличиваем значение локальной переменной b_sz на 1
.L3:
	add	DWORD PTR -8[rbp], 1
.L2:
	mov	eax, DWORD PTR -8[rbp]                # Записываем в eax значение локальной переменной i
	cmp	eax, DWORD PTR -20[rbp]               # Сравниваем регистр eax c аргументом x
	jl	.L4
	mov	eax, DWORD PTR -4[rbp]                # Записываем в регистр eax значение локальной переменной b_sz
	pop	rbp                                   # Удаляем регистр rbp из стека
	ret                                           # Завершаем функцию
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
	sub	rsp, 48
	mov	DWORD PTR -36[rbp], edi
	mov	QWORD PTR -48[rbp], rsi
	mov	eax, DWORD PTR -36[rbp]
	sub	eax, 2
	mov	DWORD PTR -12[rbp], eax       # Записываем в переменную a_sz значение регистра eax (в котором лежит значение argc - 2)
	mov	eax, DWORD PTR -36[rbp]
	cdqe
	sal	rax, 3
	lea	rdx, -8[rax]
	mov	rax, QWORD PTR -48[rbp]
	add	rax, rdx
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT                   # Вызываем функцию atoi
	mov	DWORD PTR -16[rbp], eax    # Записываем в переменную x значение регистра eax
	mov	DWORD PTR -20[rbp], 0      # Инициализируем переменную b_sz нулем
	mov	DWORD PTR -4[rbp], 0       # Инициализируем переменную idx нулем
	mov	DWORD PTR -8[rbp], 0       # Инициализируем переменную i нулем
	jmp	.L7
.L8:
	mov	eax, DWORD PTR -8[rbp]
	cdqe
	add	rax, 1
	lea	rdx, 0[0+rax*8]
	mov	rax, QWORD PTR -48[rbp]
	add	rax, rdx
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	mov	edx, DWORD PTR -8[rbp]
	movsx	rdx, edx
	lea	rcx, 0[0+rdx*4]
	lea	rdx, a[rip]
	mov	DWORD PTR [rcx+rdx], eax
	add	DWORD PTR -8[rbp], 1
.L7:
	mov	eax, DWORD PTR -8[rbp]
	cmp	eax, DWORD PTR -12[rbp]
	jl	.L8
	mov	esi, DWORD PTR -16[rbp]              # Записываем в регистр esi значение переменной x
	mov	edi, DWORD PTR -12[rbp]              # Записываем в регистр edi значение переменной a_sz
	call	get_size                              # Вызываем функцию get_size
	mov	DWORD PTR -20[rbp], eax               # Записываем в локальную переменную значение регистра eax (а в нем лежит значение, которое вернула функция get_size)
	mov	DWORD PTR -8[rbp], 0                  # Приравниваем локальной переменной i зачение 0
	jmp	.L9
.L11:
	mov	eax, DWORD PTR -8[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	lea	rax, a[rip]
	mov	eax, DWORD PTR [rdx+rax]
	cdq
	idiv	DWORD PTR -16[rbp]
	mov	eax, edx
	test	eax, eax
	jne	.L10
	mov	eax, DWORD PTR -8[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	lea	rax, a[rip]
	mov	eax, DWORD PTR [rdx+rax]
	mov	edx, DWORD PTR -4[rbp]
	movsx	rdx, edx
	lea	rcx, 0[0+rdx*4]
	lea	rdx, b[rip]
	mov	DWORD PTR [rcx+rdx], eax
	add	DWORD PTR -4[rbp], 1
.L10:
	add	DWORD PTR -8[rbp], 1
.L9:
	mov	eax, DWORD PTR -8[rbp]
	cmp	eax, DWORD PTR -12[rbp]
	jl	.L11
	mov	DWORD PTR -8[rbp], 0
	jmp	.L12
.L13:
	mov	eax, DWORD PTR -8[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	lea	rax, b[rip]
	mov	eax, DWORD PTR [rdx+rax]
	mov	esi, eax
	lea	rax, .LC0[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	add	DWORD PTR -8[rbp], 1
.L12:
	mov	eax, DWORD PTR -8[rbp]
	cmp	eax, DWORD PTR -20[rbp]
	jl	.L13
	mov	edi, 10
	call	putchar@PLT
	mov	eax, 0
	leave
	ret
