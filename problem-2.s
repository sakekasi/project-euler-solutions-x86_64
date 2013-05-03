	;; By considering the terms in the Fibonacci sequence whose values do not exceed four million,
	;; find the sum of the even-valued terms.

	extern printf

	SECTION .data

fmt:	db "%d", 10, 0		;"%d\n\0"

	
	SECTION .text

	global main

main:
	mov r12, 1
	mov r13, 1
	mov rax, 0

loop:
	xor r13, r12		;swap r12 and r10
	xor r12, r13
	xor r13, r12
	
	add r13, r12

	cmp r13, 4000000
	jge end

	mov r14, r13		;even test. lsb should be 0 if even, 1 if odd.
	and r14, 1
	

	mov r15, 0
	test r14, r14
	cmove r15, r13

	add rax, r15

	jmp loop

end:
	mov rsi, rax
	mov rdi, fmt
	mov rax, 0
	call printf
	
	mov rax, 60
	mov rdi, 0
	syscall
	
	
