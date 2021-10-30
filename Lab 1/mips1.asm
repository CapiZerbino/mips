	.text
	.globl main
	

main:
	#Print string msg1
	li	$v0,4
	la	$a0,msg1
	syscall
	
	
	#Get input from user
	li	$v0,5
	syscall
	move	$t0,$v0
	
	#Excute operation
	addi	$t0,$t0,1
	
	#Print string msg2
	li	$v0,4
	la	$a0,msg2
	syscall
	
	#Print Sum
	li	$v0,1
	move	$a0,$t0
	syscall
	
	li	$v0,10
	syscall
	
	
	.data
	msg1: .asciiz "Enter number: "
	msg2: .asciiz "The answer is: "
	newline: .asciiz "\n"