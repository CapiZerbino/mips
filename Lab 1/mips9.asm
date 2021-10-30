	.text 
	.globl main 
main: 
 	la  	$s0, array 
 	

 	#loop body 
 	addi 	$t1, $zero, 0 	#count=0 
 	addi 	$t4, $zero, 0 	#sum=0 

loop: 	 
	# Print msg1 
 	li 	$v0,4  		# print_string syscall code = 4 
 	la 	$a0, msg1 	 
 	syscall 
 	
 	sll 	$t2,$t1, 2 	#offset = count*4 
 	add 	$t2, $t2, $s0 	#offset + base array address 

 	# Get element from user and save 
 	li 	$v0,5  		# read_int syscall code = 5 
 	syscall  

 	sw 	$v0, 0($t2) 	# syscall results returned in $v0, store word at $t2 
 	addi 	$t1, $t1,1 	#count++ 
 	bne 	$t1, 10, loop 	#if not go through 10 elements 	 
 	addi 	$t2,$zero,0 
 	addi 	$t1, $s0, 36 	#count=36 + baseArray 
 	#start loop 
loop2:  	 
 	#output each of element 
 	li 	$v0,1  		# print_int syscall code = 4 
 	lw 	$a0, 0($t1) 
 	syscall 

 	li 	$v0, 4  	# print_string syscall code = 4 
 	la 	$a0, space 
 	syscall 
 	#count sum 
 	addi 	$t2, $t2, 1 
 	addi 	$t1, $t1, -4 
 	bne 	$t2, 10, loop2 	#if not go through 10 elements 

 	#end loop
 	li 	$v0, 10 	# print_string syscall code = 4 
 	syscall 
.data 
	msg1: .asciiz "Input number:  " 
	msg2: .asciiz "Sum = " 
	lf:   .asciiz 	"\n" 
	space:.asciiz " " 
	.align 2 
	array: .space 40 
		
 

