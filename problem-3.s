	;; What is the largest prime factor of the number 600851475143 ?

	extern printf

	SECTION .data

fmt:	db "%d", 10, 0		;"%d\n\0"
num:	dq 600851475143

	SECTION .text

	global main

main:
	
	mov r12, 2		;current number
	mov r13, 0		;largest prime factor

	fild qword [num]			;compute sqrt of argument
	fsqrt
	fistp qword [rsp]

 	mov r14, [rsp]


loop:
	xor rdx, rdx
	mov rax, [num]
	div r12

	mov r15, rax

	test rdx, rdx
	jne non_factor
	
	mov rdi, r12		;prime(r12)
	call prime

	test rax, rax		
	je second_factor

	cmp r12, r13
	cmovg r13, r12

second_factor:

	mov rdi, r15
	call prime

	test rax, rax
	je non_factor

	cmp r12, r13
	cmovg r13, r12

non_factor:

	inc r12
	cmp r12, r14
	jl loop

	add rsp, 8

	mov rsi, r13
	mov rdi, fmt
	mov rax, 0
	call printf
	
	mov rax, 60
	mov rdi, 0
	syscall
	
	
prime:				;returns 0 if non prime, not zero of prime
	sub rsp, 32
	mov [rsp+24], r12
	mov [rsp+16], r13
	mov [rsp+8], rdx
	mov [rsp], rdi

	fild qword [rsp]			;compute sqrt of argument
	fsqrt
	fistp qword [rsp]

	mov r13, [rsp]

	mov r12, 2

prime_loop:
	xor rdx, rdx
	mov rax, rdi
	div r12

	test rdx, rdx
	je return

	inc r12
	cmp r12, r13
	jle prime_loop

return:	
	mov rax, rdx		;set return value

	mov r12, [rsp+24]	;restore stack
	mov r13, [rsp+16]
	mov rdx, [rsp+8]
	mov rdi, [rsp]
	add rsp, 32
	
	ret
