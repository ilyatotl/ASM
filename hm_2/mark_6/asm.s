	.file	"asm.c"
	.intel_syntax noprefix
	.text
	.globl	a
	.bss
	.align 32
	.type	a, @object
	.size	a, 100000
a:                               # массив a
	.zero	100000
	.globl	b
	.align 32
	.type	b, @object
	.size	b, 100000
b:                              # массив b
	.zero	100000
	.globl	exist
	.align 32
	.type	exist, @object
	.size	exist, 128
exist:                         # массив exist
	.zero	128
	.text
	.globl	get_len
	.type	get_len, @function
get_len:                      # функция get_len
	endbr64
	push	rbp
	mov	rbp, rsp
	mov	DWORD PTR -20[rbp], edi  # получение переменой len_a как параметра функции
	mov	DWORD PTR -24[rbp], esi  # получение переменной len_b как параметра функции
	mov	DWORD PTR -4[rbp], 0     # инициализация локальной переменной i нулем
	mov	DWORD PTR -8[rbp], 0     # инициализация локальной переменной last_idx нулем
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
	mov	BYTE PTR [rax+rdx], 1   # инициализируем элемент массива exist[a[i]] как true
	add	DWORD PTR -4[rbp], 1    # прибавляем к i 1
.L2:
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -20[rbp]  # сравниваем eax (в нем лежит значение переменной i) с аргументом len_a
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
	mov	BYTE PTR [rax+rdx], 1  # инициализируем элемент массива exist[a[i]] как true
	add	DWORD PTR -4[rbp], 1   # прибавляем к i 1
.L4:
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -24[rbp]  # сравниваем eax (в нем лежит значение переменной i) с аргументом len_b
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
	mov	DWORD PTR -8[rbp], eax  # записываем в переменную last_idx значение регистра eax (в нем лежит значение пеерменной i)
.L7:
	add	DWORD PTR -4[rbp], 1    # прибавляем к i 1 
.L6:
	cmp	DWORD PTR -4[rbp], 127  # сравниваем i и 127 (условие цикла)
	jle	.L8
	mov	eax, DWORD PTR -8[rbp]  # записываем в eax значение перменной last_idx
	pop	rbp
	ret                             # выходим из функции
	.size	get_len, .-get_len
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	DWORD PTR -4[rbp], 0      # инициализация локальной переменной len_a нулем
	mov	DWORD PTR -12[rbp], 0     # инициализация локальной переменной len_b нулем
.L11:                                     # цикл do-while
	mov	rax, QWORD PTR stdin[rip]
	mov	rdi, rax
	call	getc@PLT                  # вызываем функцию getc
	mov	DWORD PTR -16[rbp], eax   # записываем в переменную ch значение регистра eax 
	mov	eax, DWORD PTR -4[rbp]
	lea	edx, 1[rax]              
	mov	DWORD PTR -4[rbp], edx    # запсиываем в переменную len_a значение регистра edx (увеличили на 1)
	mov	edx, DWORD PTR -16[rbp]
	mov	ecx, edx
	cdqe
	lea	rdx, a[rip]
	mov	BYTE PTR [rax+rdx], cl
	cmp	DWORD PTR -16[rbp], -1    # сравиваем переменную ch с -1
	jne	.L11
	mov	eax, DWORD PTR -4[rbp]    # записываем в eax переменную len_a
	sub	eax, 1                    # вычитаем из eax 1
	cdqe
	lea	rdx, a[rip]
	mov	BYTE PTR [rax+rdx], 0
	sub	DWORD PTR -4[rbp], 1      # вычитаем из len_a 1
	mov	edx, DWORD PTR -12[rbp]
	mov	eax, DWORD PTR -4[rbp]
	mov	esi, edx                  # записываем в регистр esi значение ргистра edx (в котором лежит значение len_b)
	mov	edi, eax                  # записываем в регистр edi значение ргистра eax (в котором лежит значение len_a)
	call	get_len                   # вызываем функцию get_len
	mov	DWORD PTR -20[rbp], eax   # записываем в локальную переменную last_idx значение регистра eax (в нем лежало возвращаемое значение функции get_len)
	mov	DWORD PTR -8[rbp], 0
	jmp	.L12
.L14:
	mov	eax, DWORD PTR -8[rbp]
	cdqe
	lea	rdx, exist[rip]
	movzx	eax, BYTE PTR [rax+rdx]
	test	al, al
	je	.L13
	mov	eax, DWORD PTR -8[rbp]
	mov	edi, eax
	call	putchar@PLT             # выводим символ
.L13:
	add	DWORD PTR -8[rbp], 1
.L12:
	mov	eax, DWORD PTR -8[rbp]  # записываем в eax значение переменной i
	cmp	eax, DWORD PTR -20[rbp] # сравниваем eax и переменную last_idx (условие цикла)
	jle	.L14
	mov	edi, 10
	call	putchar@PLT             # выводим перевод строки
	mov	eax, 0
	leave
	ret                             # завершение функции main
