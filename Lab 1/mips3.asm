	.text
	.globl main
	
main:
	#Print the request input
	#Input a = $t0
	li	$v0,4
	la	$a0,msg1
	syscall
	li	$v0,5
	syscall
	move	$t0,$v0
	
	#Input b = $t1
	li	$v0,4
	la	$a0,msg2
	syscall
	li	$v0,5
	syscall
	move	$t1,$v0
	
	#Input c = $t2
	li	$v0,4
	la	$a0,msg3
	syscall
	li	$v0,5
	syscall
	move	$t2,$v0
	
	#Input d = $t3
	li	$v0,4
	la	$a0,msg4
	syscall
	li	$v0,5
	syscall
	move	$t3,$v0
	
	#First Equation
	add	$s0,$t0,$t1
	sub	$s1,$t2,$t3
	subi	$s1,$s1,2
	sub	$s3,$s0,$s1
	li	$v0,4
	la	$a0,equation_1
	syscall
	li	$v0,1
	move	$a0,$s3
	syscall
	
	li	$v0, 4
	la	$a0, newline
	syscall
	
	#Second Equation
	addi	$t4, $zero, 3
	addi	$t5, $zero, 2
	add	$s4, $t0, $t1
	mul	$s4, $s4, $t4
	
	add	$s5, $t2, $t3
	mul	$s5, $s5, $t5
	
	sub	$s6, $s4, $s5
	li	$v0, 4
	la	$a0, equation_2
	syscall
	li	$v0, 1
	move	$a0, $s6
	syscall
	
	
	#Exit
	li	$v0,10
	syscall
	
	
	.data
	msg1: .asciiz "Value of a: "
	msg2: .asciiz "Value of b: "
	msg3: .asciiz "Value of c: "
	msg4: .asciiz "Value of d: "
	equation_1: .asciiz "f = (a + b) - (c - d - 2) = "
	equation_2: .asciiz "g = (a + b)*3 - (c + d)*2 = "
	newline:   .asciiz 	"\n" 
	
