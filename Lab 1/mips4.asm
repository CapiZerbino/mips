	.text
	.globl main
	
main:
	li	$t0, 0	#set loop counter  = 0
while:
	beq	$t0, 20, exit_while
	li	$v0, 4
	la	$a0, msg
	syscall
	li	$v0, 5
	syscall
	sw	$v0, list($t0)
	addi	$t0, $t0, 4
	j	while
exit_while:	
	la	$t3, list
	li	$v0, 4
	la	$a0, result
	syscall
loop_reverse:
	beq	$t0, 0, stop
	
	lw	$s0, 16($t3)
	
	li	$v0, 1
	move	$a0, $s0
	syscall
	
	li	$v0, 4
	la	$a0, space
	syscall
	
	subi	$t3, $t3, 4
	subi	$t0, $t0, 4
	j 	loop_reverse
stop:
	li	$v0, 10
	syscall
	
	.data
	list:	.space 20
	result:	.asciiz "The reverse order is: "
	msg:	.asciiz "Enter number: "
	space: 	.asciiz "->"