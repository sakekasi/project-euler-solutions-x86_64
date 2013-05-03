	;; If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23. 
	;; Find the sum of all the multiples of 3 or 5 below 1000.

	extern printf

	SECTION .data
	
fmt:	db "%d", 10, 0 		;"%d\n\0"

	
	SECTION .text

	global main

main:	
	mov r10, 0 		;total
	mov r11, 1		;number to test

loop:
	xor rdx, rdx
	mov rax, r11
	mov rbx, 3
	div rbx
	
	cmp rdx, 0
	jne mul_3
	add r10, r11
	jmp mul_5
	
mul_3:
	mov rdx, 0
	mov rax, r11
	mov rbx, 5
	div rbx
	
	cmp rdx, 0
	jne mul_5
	add r10, r11
mul_5:
	inc r11
	cmp r11, 1000
	jl loop

	mov rsi, r10
	mov rdi, fmt
	mov rax, 0
	call printf
	
	mov rax, 60
	mov rdi, 0
	syscall
