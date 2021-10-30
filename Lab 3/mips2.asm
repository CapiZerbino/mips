.data
	msg1: 	.asciiz "Calculate numerical integration\n"
	msg2:	.asciiz "x: "
	msg3:	.asciiz "a: "
	msg4:	.asciiz "b: "
	msg5:	.asciiz "c: "
	upper:	.asciiz "Upper bound: "
	lower:	.asciiz "Lower bound: "
	result:	.asciiz "Result = "
	enter:	.asciiz "\n==================================\n"
	end:	.asciiz "End"
.text
	#print and receive a value
	la $a0, msg3
	li $v0, 4
	syscall			#print
	add $v0, $0, 5
	syscall			#receives value of height and stores in f0
	move $s1, $v0	#store f0 in f2
	#print and receive b value
	la $a0, msg4
	li $v0, 4
	syscall			#print
	add $v0, $0, 5
	syscall			#receives value of height and stores in f0
	move $s2, $v0	#store f0 in f2
	#print and receive c value
	la $a0, msg5
	li $v0, 4
	syscall			#print
	add $v0, $0, 5
	syscall			#receives value of height and stores in f0
	move $s3, $v0	#store f0 in f2
	#print and receive upper bound value
	la $a0, upper
	li $v0, 4
	syscall			#print
	add $v0, $0, 5
	syscall			#receives value of height and stores in f0
	move $s4, $v0	
	#store f0 in f2
	#print and receive lower bound value
	la 	$a0, lower
	li 	$v0, 4
	syscall			#print
	add 	$v0, $0, 5
	syscall			#receives value of height and stores in f0
	move $s5, $v0	#store f0 in f2
	
	#	$s1 --> a
	#	$s2 --> b
	#	$s3 --> c
	#	$s4 --> upper
	#	$s5 --> lower
	
	#calculate upper
	mul	$t0, $s1, $s4
	mul	$t0, $t0, $s4
	mul	$t0, $t0, $s4
	li	$t1, 3
	div	$t0, $t1
	mflo	$t0
	
	
	mul	$t2, $s2, $s4
	mul	$t2, $t2, $s4
	li	$t3, 2
	div	$t2, $t3
	mflo	$t2
	
	
	mul	$t4, $s3, $s4
	
	add	$t0, $t0, $t2
	add	$t0, $t0, $t4
	
	
	
	#calculate lower
	mul	$t5, $s1, $s5
	mul	$t5, $t5, $s5
	mul	$t5, $t5, $s5
	li	$t6, 3
	div	$t5, $t6
	mflo	$t5
	
	
	mul	$t7, $s2, $s5
	mul	$t7, $t7, $s5
	li	$s0, 2
	div	$t7, $s0
	mflo	$t7
	
	
	mul	$s6, $s3, $s5
	
	add	$t7, $t5, $t7
	add	$t7, $t7, $s6
	
	sub	$t7, $t7, $t0
	
	la $a0, result
	li $v0, 4
	syscall
	
	li $v0, 1
	move $a0, $t7
	syscall
	li $v0, 10
	syscall
	
	
	  
	
	