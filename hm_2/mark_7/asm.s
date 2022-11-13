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
	.section	.rodata
.LC0:
	.string	"3 files needed"
.LC1:
	.string	"rb"
.LC2:
	.string	"Cannot open input file A"
.LC3:
	.string	"Cannot open input file B"
.LC4:
	.string	"wb"
.LC5:
	.string	"Cannot open output file"
	.text
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 64
	mov	DWORD PTR -52[rbp], edi
	mov	QWORD PTR -64[rbp], rsi
	cmp	DWORD PTR -52[rbp], 4      # сравнение argc с 4
	je	.L2
	lea	rax, .LC0[rip]
	mov	rdi, rax
	call	puts@PLT                   # вывод (12 строка)
	mov	eax, 0
	jmp	.L3
.L2:
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC1[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT                 # открытие фалйа inputA
	mov	QWORD PTR -24[rbp], rax   # inputFileA = fopen(argv[1], "rb")
	cmp	QWORD PTR -24[rbp], 0
	jne	.L4
	lea	rax, .LC2[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	eax, 0
	jmp	.L3
.L4:
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC1[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT               # открытие файла inputB
	mov	QWORD PTR -32[rbp], rax # inputFileB = fopen(argv[2], "rb")
	cmp	QWORD PTR -32[rbp], 0
	jne	.L5
	lea	rax, .LC3[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	eax, 0
	jmp	.L3
.L5:
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC4[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT                # открытие файла output
	mov	QWORD PTR -40[rbp], rax  # outputFile = fopen(argv[3], "wb")
	cmp	QWORD PTR -40[rbp], 0
	jne	.L6
	lea	rax, .LC5[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	eax, 0
	jmp	.L3
.L6:
	mov	DWORD PTR -4[rbp], 0   # инициализация len_a нулем
	mov	DWORD PTR -8[rbp], 0   # инициализация len_b нулем
.L7:
	mov	rax, QWORD PTR -24[rbp]
	mov	rdi, rax
	call	fgetc@PLT               # вызов функции fgetc (строка 34) 
	mov	DWORD PTR -44[rbp], eax # записываем в переменную ch значение регистра eax
	mov	eax, DWORD PTR -4[rbp]
	lea	edx, 1[rax]
	mov	DWORD PTR -4[rbp], edx  # прибавляем 1 к len_a
	mov	edx, DWORD PTR -44[rbp]
	mov	ecx, edx
	cdqe
	lea	rdx, a[rip]
	mov	BYTE PTR [rax+rdx], cl
	cmp	DWORD PTR -44[rbp], -1 # сраввниваем ch с -1
	jne	.L7
	mov	eax, DWORD PTR -4[rbp]
	sub	eax, 1
	cdqe
	lea	rdx, a[rip]
	mov	BYTE PTR [rax+rdx], 0
	sub	DWORD PTR -4[rbp], 1    # вычитаем из len_a 1
	mov	rax, QWORD PTR -24[rbp] # кладем в регистр rax файл inputA
	mov	rdi, rax
	call	fclose@PLT              # закрывем файл inputA
.L8:
	mov	rax, QWORD PTR -32[rbp]
	mov	rdi, rax
	call	fgetc@PLT               # вызов функции fgetc (строка 42) 
	mov	DWORD PTR -44[rbp], eax # записываем в переменную ch значение регистра eax
	mov	eax, DWORD PTR -8[rbp]
	lea	edx, 1[rax]
	mov	DWORD PTR -8[rbp], edx  # прибавляем 1 к len_b
	mov	edx, DWORD PTR -44[rbp]
	mov	ecx, edx
	cdqe
	lea	rdx, b[rip]
	mov	BYTE PTR [rax+rdx], cl
	cmp	DWORD PTR -44[rbp], -1 # сраввниваем ch с -1
	jne	.L8
	mov	eax, DWORD PTR -8[rbp]
	sub	eax, 1
	cdqe
	lea	rdx, b[rip]
	mov	BYTE PTR [rax+rdx], 0
	sub	DWORD PTR -8[rbp], 1     # вычитаем из len_a 1
	mov	rax, QWORD PTR -32[rbp]  # кладем в регистр rax файл inputB
	mov	rdi, rax
	call	fclose@PLT               # закрываем файл inputB
	mov	edx, DWORD PTR -8[rbp]   
	mov	eax, DWORD PTR -4[rbp]    
	mov	esi, edx                 # кладем в регистр esi переменную len_b
	mov	edi, eax                 # кладем в регистр edi переменную len_a 
	call	get_len@PLT              # вызываем функцию get_len
	mov	DWORD PTR -48[rbp], eax  # кладем в локальную переменную last_idx значение, которое вернула функция (лежит в регистре eax)
	mov	DWORD PTR -12[rbp], 0    # инициализируем переменную i нулем
	jmp	.L9
.L11:
	mov	eax, DWORD PTR -12[rbp]
	cdqe
	lea	rdx, exist[rip]
	movzx	eax, BYTE PTR [rax+rdx]
	test	al, al
	je	.L10
	mov	rdx, QWORD PTR -40[rbp]
	mov	eax, DWORD PTR -12[rbp]
	mov	rsi, rdx
	mov	edi, eax
	call	fputc@PLT               # выводим символ
.L10:
	add	DWORD PTR -12[rbp], 1
.L9:
	mov	eax, DWORD PTR -12[rbp]
	cmp	eax, DWORD PTR -48[rbp] # сравниваем eax (в нем лежит значение переменной i) и last_idx
	jle	.L11
	mov	rax, QWORD PTR -40[rbp] # кладем в rax файл output
	mov	rdi, rax
	call	fclose@PLT              # закрываем файл оutput
	mov	eax, 0
.L3:
	leave
	ret                     # выход из функции main
