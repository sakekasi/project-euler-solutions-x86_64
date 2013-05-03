	;; Find the largest palindrome made from the product of two 3-digit numbers.

	extern printf
	
	SECTION .data

fmt:	db "%d", 10, 0 		;"%d\n\0"


	SECTION .text

	global main

main:
	mov r15, 0		;largest palindrome
	mov r12, 100

.outer:
	mov r13, r12

.inner:
	mov rax, r13		;r14 = r13*r12
	mul r12
	mov r14, rax

	mov rdi, r14
	call palindrome

	test rax, rax
	je .non_palindrome

	cmp r14, r15
	cmovg r15, r14
	
.non_palindrome:

	inc r13
	cmp r13, 1000
	jl .inner

	inc r12
	cmp r12, 1000
	jl .outer
	
	mov rsi, r15
	mov rdi, fmt
	mov rax, 0
	call printf
	
	mov rax, 60
	mov rdi, 0
	syscall

	

palindrome:
	push r12
	push r13
	push r14
	
	mov r12, rdi
	mov r13, 0

.loop:
	
	mov rdx, 0
	mov rax, r12
	mov rbx, 10
	div rbx

	mov r12, rax
	mov r14, rdx

	mov rax, 10
	mul r13
	mov r13, rax
	
	add r13, r14

	test r12, r12
	jne .loop

	mov rax, 0
	cmp r13, rdi
	jne .false
	mov rax, 1
.false:

	pop r14
	pop r13
	pop r12
	ret
