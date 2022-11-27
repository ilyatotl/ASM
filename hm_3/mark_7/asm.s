	.file	"asm.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
.LC0:
	.string	"2 files needed"
.LC1:
	.string	"r"
.LC2:
	.string	"Cannot open input file"
.LC3:
	.string	"w"
.LC4:
	.string	"Cannot open output file"
.LC5:
	.string	"%lf"
.LC7:
	.string	"Invalid value\n"
.LC9:
	.string	"1.0000\n"
.LC11:
	.string	"-1.0000\n"
.LC13:
	.string	"%f\n"
	.text
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 64 
	mov	DWORD PTR -52[rbp], edi              # достаем из регистра edi количество аргументов (argc)
	mov	QWORD PTR -64[rbp], rsi              # досаем из регистра rsi аргументы argv  
	cmp	DWORD PTR -52[rbp], 3                # сравниваем аргумент argc с 3 (строка 7)
	je	.L2
	lea	rax, .LC0[rip]
	mov	rdi, rax
	call	puts@PLT                             # вызываем функцию printf (строка 8)
	mov	eax, 0
	jmp	.L12
.L2:
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC1[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT                            # вызываем функцию fopen
	mov	QWORD PTR -8[rbp], rax               # записываем результат вызова функции в переменную inputFile
	cmp	QWORD PTR -8[rbp], 0                 # сравниваем inputFile с NULL
	jne	.L4
	lea	rax, .LC2[rip]
	mov	rdi, rax
	call	puts@PLT                             # вызываем функцию printf (строка 14)
	mov	eax, 0
	jmp	.L12
.L4:
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC3[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT                            # вызываем функцию fopen
	mov	QWORD PTR -16[rbp], rax              # записываем результат вызова функции в переменную outputFile
	cmp	QWORD PTR -16[rbp], 0                # сравниваем outputFile c NULL
	jne	.L5
	lea	rax, .LC4[rip]
	mov	rdi, rax
	call	puts@PLT                             # вызываем функцию printf (строка 19)
	mov	eax, 0
	jmp	.L12
.L5:
	lea	rdx, -40[rbp]
	mov	rax, QWORD PTR -8[rbp]
	lea	rcx, .LC5[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT                 # вызываем функцию fscanf
	mov	rax, QWORD PTR -8[rbp]              
	mov	rdi, rax                            # кладем в регистр rdi файл inputFile
	call	fclose@PLT                          # вызываем функцию fclose (строка 25)
	movsd	xmm0, QWORD PTR -40[rbp]
	pxor	xmm1, xmm1
	ucomisd	xmm0, xmm1
	jp	.L6
	pxor	xmm1, xmm1                          # обнуляем регистр xmm1
	ucomisd	xmm0, xmm1                          # сравниваем переменную x с 0
	jne	.L6
	mov	rax, QWORD PTR -16[rbp]
	mov	rcx, rax
	mov	edx, 14
	mov	esi, 1
	lea	rax, .LC7[rip]
	mov	rdi, rax
	call	fwrite@PLT                          # вызываем функцию fprintf (строка 27)
	mov	rax, QWORD PTR -16[rbp]
	mov	rdi, rax                            # кладем в регистр rdi файл outputFile
	call	fclose@PLT                          # вызываем функцию fclose (строка 28)
	mov	eax, 0
	jmp	.L12
.L6:
	movsd	xmm0, QWORD PTR -40[rbp]
	comisd	xmm0, QWORD PTR .LC8[rip]           # сравниваем переменную x и 10
	jbe	.L16
	mov	rax, QWORD PTR -16[rbp]
	mov	rcx, rax
	mov	edx, 7
	mov	esi, 1
	lea	rax, .LC9[rip]
	mov	rdi, rax
	call	fwrite@PLT                          # вызываем функцию fprintf (строка 32)
	mov	rax, QWORD PTR -16[rbp]
	mov	rdi, rax                            # кладем в регистр rdi файл outputFile
	call	fclose@PLT                          # вызываем функцию fclose (строка 33)
	mov	eax, 0
	jmp	.L12
.L16:
	movsd	xmm1, QWORD PTR -40[rbp]
	movsd	xmm0, QWORD PTR .LC10[rip]
	comisd	xmm0, xmm1                          # сравниваем переменную x и -10 
	jbe	.L17
	mov	rax, QWORD PTR -16[rbp]
	mov	rcx, rax
	mov	edx, 8
	mov	esi, 1
	lea	rax, .LC11[rip]
	mov	rdi, rax
	call	fwrite@PLT                          # вызываем функцию fprintf (строка 36)
	mov	rax, QWORD PTR -16[rbp]
	mov	rdi, rax                            # кладем в регистр rdi файл outputFile
	call	fclose@PLT                          # вызываем функцию fclose (строка 33)
	mov	eax, 0
	jmp	.L12
.L17:
	mov	rax, QWORD PTR -40[rbp]
	movq	xmm0, rax                           # кладем переменную x в регистр xmm0 
	call	expon@PLT                           # вызываем функцию expon
	movq	rax, xmm0
	mov	QWORD PTR -24[rbp], rax             # сохраянем в переменную pos результат, который вернула функция
	movsd	xmm0, QWORD PTR -40[rbp]
	movq	xmm1, QWORD PTR .LC12[rip]
	xorpd	xmm0, xmm1
	movq	rax, xmm0
	movq	xmm0, rax
	call	expon@PLT                           # вызываем функцию expon
	movq	rax, xmm0
	mov	QWORD PTR -32[rbp], rax             # сохраняем в переменную neg результат, который вернула функция
	movsd	xmm0, QWORD PTR -24[rbp]
	addsd	xmm0, QWORD PTR -32[rbp]
	movsd	xmm1, QWORD PTR -24[rbp]
	subsd	xmm1, QWORD PTR -32[rbp]
	divsd	xmm0, xmm1                          # вычисляем значение (pos + neg) / (pos - neg) 
	movq	rdx, xmm0
	mov	rax, QWORD PTR -16[rbp]
	movq	xmm0, rdx
	lea	rdx, .LC13[rip]
	mov	rsi, rdx
	mov	rdi, rax
	mov	eax, 1
	call	fprintf@PLT                         # вызываем функцию fprintf (строка 42)
	mov	rax, QWORD PTR -16[rbp]
	mov	rdi, rax
	call	fclose@PLT                          # вызываем функцию fclose для файла ouputFile
	mov	eax, 0
.L12:
	leave                                       
	ret                                         # выходим из функции
.LC8:
	.long	0
	.long	1076101120
	.align 8
.LC10:
	.long	0
	.long	-1071382528
	.align 16
.LC12:
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
