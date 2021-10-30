	.text
	.globl main
	
	
main:
	#Input the first number
	li	$v0,4
	la	$a0,msg1
	syscall
	
	li	$v0,5
	syscall
	move	$t0,$v0
	
	#Input the second number
	li	$v0,4
	la	$a0, msg2
	syscall
	
	li	$v0,5
	syscall
	move	$t1,$v0
	
	#Sum both numbers together
	add	$s0,$t0,$t1
	li	$v0,4
	la	$a0,result
	syscall
	li	$v0,1
	move	$a0,$s0
	syscall
	
	li	$v0,10
	syscall
	
	.data
	msg1: .asciiz "Enter first number: "
	msg2: .asciiz "Enter second number: "
	result: .asciiz "Your result: "
		