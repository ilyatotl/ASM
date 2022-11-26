	.file	"asm.c"
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
	sub	rsp, 32
	mov	DWORD PTR -4[rbp], edi
	mov	QWORD PTR -16[rbp], rsi
	cmp	DWORD PTR -4[rbp], 2
	je	.L6
	lea	rax, .LC1[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	eax, 0
	jmp	.L7
.L6:
	mov	rax, QWORD PTR -16[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atof@PLT
	movapd	xmm4, xmm0                       # запишем в регистр xmm4 значение возврата функции atof (xmm4 - переменная x)
	pxor	xmm0, xmm0
	ucomisd	xmm4, xmm0                      
	jp	.L8
	pxor	xmm0, xmm0
	ucomisd	xmm4, xmm0                       # проверим на равенство регистр xmm0 и xmm4 (0 и x)
	jne	.L8
	lea	rax, .LC3[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	eax, 0
	jmp	.L7
.L8:
	comisd	xmm4, QWORD PTR .LC4[rip]       # проверим, что x больше 10
	jbe	.L17
	lea	rax, .LC5[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	eax, 0
	jmp	.L7
.L17:
	movsd	xmm0, QWORD PTR .LC6[rip]       # записали -10 в регистр xmm0
	comisd	xmm0, xmm4                      # сравниваем xmm0 и xmm4 (-10 и переменную x, строка 27)
	jbe	.L18
	lea	rax, .LC7[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	eax, 0
	jmp	.L7
.L18:
	movsd	xmm0, xmm4                      # записываем в регистр xmm0 значение регистра xmm4 (переменную x, для передачи в качестве аргумента функции)
	call	expon            
	movapd	xmm5, xmm0                      # записываем в регистр xmm5 значение, которое вернула функция (переменная pos)
	movq	xmm0, QWORD PTR .LC8[rip]
	movsd	xmm1, xmm4
	xorpd	xmm0, xmm1                      # в регистре xmm0 сохранили переменную -x
	call	expon                           # вызываем функцию
	movapd	xmm6, xmm0                      # в регистр xmm6 сохраняем значение, которое вернула функцию (переменная neg)
	movapd	xmm0, xmm5                      # кладем значение регистра xmm5 (переменная pos) в регистр xmm0
	addsd	xmm0, xmm6                      # прибавляем значение регистра xmm6 (переменная neg) в регистр xmm0
	movapd	xmm1, xmm5                      # кладем значение регистра xmm5 (переменная pos) в регистр xmm1
	subsd	xmm1, xmm6                      # вычитаем значение регистра xmm6 (переменная neg) из регистра xmm1
	divsd	xmm0, xmm1                      # делим регистр xmm0 на xmm1
	lea	rax, .LC9[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT                      # выводим результат
	mov	eax, 0
.L7:
	leave 
	ret                                     # выходим из функции
	.size	main, .-main
	.section	.rodata
	.align 8
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
