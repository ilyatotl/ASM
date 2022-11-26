	.file	"asm.c"
	.intel_syntax noprefix
	.text
	.globl	expon
	.type	expon, @function
expon:
	endbr64
	push	rbp
	mov	rbp, rsp
	movsd	QWORD PTR -40[rbp], xmm0           # кладем в аргумень x значение регистра xmm0
	movsd	xmm0, QWORD PTR .LC0[rip]          # кладем в регистр xmm0 единицу
	movsd	QWORD PTR -8[rbp], xmm0            # инициализируем локальную переменную res единицей
	movsd	xmm0, QWORD PTR .LC0[rip]
	movsd	QWORD PTR -16[rbp], xmm0           # инициализируем локальную переменную deg единицей
	movsd	xmm0, QWORD PTR .LC0[rip]
	movsd	QWORD PTR -24[rbp], xmm0           # инициализируем локальную переменную fact единицей
	mov	DWORD PTR -28[rbp], 1              # инициализируем локальную переменную i единицей
	jmp	.L2
.L3:
	movsd	xmm0, QWORD PTR -16[rbp]           # кладем в регистр xmm0 значение переменной deg
	mulsd	xmm0, QWORD PTR -40[rbp]           # умножаем значение регистра xmm0 на аргумент x
	movsd	QWORD PTR -16[rbp], xmm0           # записываем в локальную переменную deg значение регистра xmm0 (строка 7)
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, DWORD PTR -28[rbp]
	movsd	xmm1, QWORD PTR -24[rbp]
	mulsd	xmm0, xmm1                         # умножаем регистр xmm0 на xmm1 (переменную fact на переменную i, строка 8)
	movsd	QWORD PTR -24[rbp], xmm0           # кладем в перменную fact значение регистра xmm0
	movsd	xmm0, QWORD PTR -16[rbp]           # кладем в xmm0 переменную deg
	divsd	xmm0, QWORD PTR -24[rbp]           # делим xmm0 на fact
	movsd	xmm1, QWORD PTR -8[rbp]
	addsd	xmm0, xmm1                         # прибавляем к регистру xmm0 xmm1 (строка 9)
	movsd	QWORD PTR -8[rbp], xmm0            # записываем в переменную res новое значение
	add	DWORD PTR -28[rbp], 1
.L2:
	cmp	DWORD PTR -28[rbp], 20            # сравниваем переменную i с 20
	jle	.L3
	movsd	xmm0, QWORD PTR -8[rbp]
	movq	rax, xmm0
	movq	xmm0, rax
	pop	rbp
	ret
	.size	expon, .-expon
	.section	.rodata
.LC1:
	.string	"Invalid numbers of arguments"
.LC3:
	.string	"Invalid value"
.LC5:
	.string	"1.0000"
.LC7:
	.string	"-1.0000"
.LC9:
	.string	"%f\n"
	.text
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	DWORD PTR -36[rbp], edi      # достаем с регистра edi значение argc
	mov	QWORD PTR -48[rbp], rsi      # достаем с регистра rsi значение argv
	cmp	DWORD PTR -36[rbp], 2        # сравниваем argc с 2
	je	.L6
	lea	rax, .LC1[rip]
	mov	rdi, rax
	call	puts@PLT                     # вызываем функцию printf (строка 16)
	mov	eax, 0
	jmp	.L7
.L6:
	mov	rax, QWORD PTR -48[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]         
	mov	rdi, rax                     # кладем в регистр rax значение rax (в нем лежит argv[1])
	call	atof@PLT                     # вызываем функцию atof
	movq	rax, xmm0
	mov	QWORD PTR -8[rbp], rax       # записываем в пеерменную x возврващаемое значение функции atof
	pxor	xmm0, xmm0              
	ucomisd	xmm0, QWORD PTR -8[rbp]    
	jp	.L8
	pxor	xmm0, xmm0                   # обнуляем регистр xmm0
	ucomisd	xmm0, QWORD PTR -8[rbp]      # сравниваем x с 0 (аналог строки 20)
	jne	.L8
	lea	rax, .LC3[rip]
	mov	rdi, rax
	call	puts@PLT                     # вызываем функцию printf (аналог строки 21)
	mov	eax, 0
	jmp	.L7
.L8:
	movsd	xmm0, QWORD PTR -8[rbp]      # кладем в xmm0 значение переменной x
	comisd	xmm0, QWORD PTR .LC4[rip]    # проверяем, больше ли x чем 10 (аналог строки 24)
	jbe	.L17                        
	lea	rax, .LC5[rip]
	mov	rdi, rax
	call	puts@PLT                     # если x больше 10, вызываем функцию printf (строка 25)
	mov	eax, 0
	jmp	.L7
.L17:
	movsd	xmm0, QWORD PTR .LC6[rip]    # кладем в регистр xmm0 -10
	comisd	xmm0, QWORD PTR -8[rbp]      # проверяем, больше ли -10 чем x (строка 27)
	jbe	.L18
	lea	rax, .LC7[rip]
	mov	rdi, rax
	call	puts@PLT                     # если -10 больше x, вызываем функцию printf (строка 28)
	mov	eax, 0
	jmp	.L7
.L18:
	mov	rax, QWORD PTR -8[rbp]
	movq	xmm0, rax                    # кладем в регистр xmm0 переменную x
	call	expon                        # вызываем функцию expon
	movq	rax, xmm0
	mov	QWORD PTR -16[rbp], rax      # записываем в переменную pos возвращаемое значение функции
	movsd	xmm0, QWORD PTR -8[rbp]      # записываем в xmm0 значение x
	movq	xmm1, QWORD PTR .LC8[rip]    # записываем в xmm1 -1
	xorpd	xmm0, xmm1                   # делаем xor xmm0 и xmm1, и записываем в xmm0 (тем самым преврвщаем x в -x)
	call	expon                        # вызываем функцию expon
	movq	rax, xmm0
	mov	QWORD PTR -24[rbp], rax      # записываем в переменную neg возвращаемое значение функции
	movsd	xmm0, QWORD PTR -16[rbp]     # кладем в регистр xmm0 значение переменной pos
	addsd	xmm0, QWORD PTR -24[rbp]     # прибавляем к регистру xmm0 значение переменной neg
	movsd	xmm1, QWORD PTR -16[rbp]     # кладем в регистр xmm1 значение переменной pos
	subsd	xmm1, QWORD PTR -24[rbp]     # вычитаем из регистра xmm1 значение переменной neg
	divsd	xmm0, xmm1                   # делим значения регистров xmm0 на xmm1
	lea	rax, .LC9[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT                   # вызываем функцию printf, в которую выводим наше результат
	mov	eax, 0
.L7:
	leave
	ret                                  # выходим из функции main
.LC0:
	.long	0
	.long	1072693248
	.align 8
.LC4:
	.long	0
	.long	1076101120
	.align 8
.LC6:
	.long	0
	.long	-1071382528
	.align 16
.LC8:
	.long	0
	.long	-2147483648
	.long	0
	.long	0
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
