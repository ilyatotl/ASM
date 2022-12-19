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
	.section	.rodata
.LC0:
	.string	"2 files needed"
.LC1:
	.string	"rb"
.LC2:
	.string	"Cannot open input file"
.LC3:
	.string	"wb"
.LC4:
	.string	"Cannot open output file"
.LC5:
	.string	"%d"
.LC6:
	.string	"%d "
	.text
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 64
	mov	DWORD PTR -52[rbp], edi          # достаем argc с регистра edi
	mov	QWORD PTR -64[rbp], rsi          # достаем argv с регистра rsi
	cmp	DWORD PTR -52[rbp], 3            # сравниваем argc с 3 (строка 10)
	je	.L2
	lea	rax, .LC0[rip]
	mov	rdi, rax
	call	puts@PLT                         # вызываем функцию printf (строка 11)
	mov	eax, 0
	jmp	.L13
.L2:
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC1[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT                        # вызываем функцию fopen (строка 16)
	mov	QWORD PTR -16[rbp], rax          # записываем в inputFile результат функции fopen
	cmp	QWORD PTR -16[rbp], 0            # сравниаваем inputFile с NULL (строка 16)
	jne	.L4
	lea	rax, .LC2[rip]
	mov	rdi, rax
	call	puts@PLT                         # вызываем printf (строка 17)
	mov	eax, 0
	jmp	.L13
.L4:
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC3[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT                        # вызываем функцию fopen (строка 21)
	mov	QWORD PTR -24[rbp], rax          # записываем в outputFile результат функции fopen
	cmp	QWORD PTR -24[rbp], 0            # сравниваем outputFile с NULL (строка 21)
	jne	.L5
	lea	rax, .LC4[rip]
	mov	rdi, rax
	call	puts@PLT                         # вызываем функцию printf (строка 22)
	mov	rax, QWORD PTR -16[rbp]
	mov	rdi, rax                         # кладем inputFile в регистр rdi
	call	fclose@PLT                       # вызываем fclose для inputFile (строка 23)
	mov	eax, 0
	jmp	.L13
.L5:
	mov	DWORD PTR -28[rbp], 0           # инициализиурем переменную b_sz нулем
	mov	DWORD PTR -4[rbp], 0            # инициализируем переменную idx нулем
	lea	rdx, -32[rbp]
	mov	rax, QWORD PTR -16[rbp]
	lea	rcx, .LC5[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT             # вызываем функцию fscanf (строка 29)
	mov	DWORD PTR -8[rbp], 0            # инициализиурем переменную i нулем
	jmp	.L6
.L7:
	mov	eax, DWORD PTR -8[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	lea	rax, a[rip]
	add	rdx, rax
	mov	rax, QWORD PTR -16[rbp]
	lea	rcx, .LC5[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT            # вызываем функцию fscanf для a[i] (строка 32) 
	add	DWORD PTR -8[rbp], 1           # увеличиваем переменную i на 1
.L6:
	mov	eax, DWORD PTR -32[rbp]
	cmp	DWORD PTR -8[rbp], eax         # сравниваем переменную a_sz и i (строка 31)
	jl	.L7
	lea	rdx, -36[rbp]
	mov	rax, QWORD PTR -16[rbp]
	lea	rcx, .LC5[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT            # вызываем функцию fscanf для перменной x (строка 34)
	mov	edx, DWORD PTR -36[rbp]
	mov	eax, DWORD PTR -32[rbp]
	mov	esi, edx                       # кладем переменную x на регистр esi
	mov	edi, eax                       # кладем переменную a_sz на регистр edi
	call	get_size@PLT                   # вызываем функцию get_size
	mov	DWORD PTR -28[rbp], eax        # записываем в переменную b_sz результат функции get_size (строка 35)
	mov	DWORD PTR -8[rbp], 0           # записываем в переменную i 0
	jmp	.L8
.L10:
	mov	eax, DWORD PTR -8[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	lea	rax, a[rip]
	mov	eax, DWORD PTR [rdx+rax]
	mov	ecx, DWORD PTR -36[rbp]
	cdq
	idiv	ecx
	mov	eax, edx
	test	eax, eax
	jne	.L9
	mov	eax, DWORD PTR -8[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	lea	rax, a[rip]
	mov	eax, DWORD PTR [rdx+rax]
	mov	edx, DWORD PTR -4[rbp]
	movsx	rdx, edx
	lea	rcx, 0[0+rdx*4]
	lea	rdx, b[rip]
	mov	DWORD PTR [rcx+rdx], eax      # кладем в b[idx] a[i] (строка 38)
	add	DWORD PTR -4[rbp], 1          # прибавляем к idx 1
.L9:
	add	DWORD PTR -8[rbp], 1          # прибавляем к i 1
.L8:
	mov	eax, DWORD PTR -32[rbp]      
	cmp	DWORD PTR -8[rbp], eax        # сравниваем переменную i с a_sz
	jl	.L10
	mov	DWORD PTR -8[rbp], 0          # кладем в переменную i ноль
	jmp	.L11
.L12:
	mov	eax, DWORD PTR -8[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	lea	rax, b[rip]
	mov	edx, DWORD PTR [rdx+rax]
	mov	rax, QWORD PTR -24[rbp]
	lea	rcx, .LC6[rip]
	mov	rsi, rcx
	mov	rdi, rax                       # кладем в регистр rdi outputFile
	mov	eax, 0
	call	fprintf@PLT                    # вызываем функцию printf (строка 45)
	add	DWORD PTR -8[rbp], 1           # прибавляем к i 1
.L11:
	mov	eax, DWORD PTR -8[rbp]       
	cmp	eax, DWORD PTR -28[rbp]        # сравниавем a_sz с i
	jl	.L12
	mov	rax, QWORD PTR -24[rbp]
	mov	rsi, rax
	mov	edi, 10
	call	fputc@PLT                      # вызываем printf (строка 45)
	mov	rax, QWORD PTR -16[rbp]
	mov	rdi, rax
	call	fclose@PLT                     # вызываем функцию fclose для inputFile (строка 46)
	mov	rax, QWORD PTR -24[rbp]        
	mov	rdi, rax
	call	fclose@PLT                     # вызываем функцию fclose для outputFile (строка 47)
	mov	eax, 0
.L13:
	leave
	ret                                    # выходим из функции main
