	.text 
	.globl main 
main: 
	la  	$s0, array 
	addi 	$s1,$zero,0 
	addi 	$s2,$zero,10 
while:   
 	#request for input 
 	li 	$v0, 4  	# print_string syscall code = 4  	
 	la 	$a0, msg1 
 	syscall 

 	# Read input from user 
 	li 	$v0,5  	# read_int syscall code = 5 
 	syscall  

 	move $t5,$v0 

 	slt $t0, $t5, $s2   	# t5 < 10 
 	sgt $t1, $t5, $s1 	# t5 >0  
 	beq $t0, 1, ife 
 	j while 

ife: 	beq $t1, 1, exit 

 	j while 
exit:  
 	sll $t5, $t5, 2 
 	add $t5, $t5, $s0 

 	#Print string result 
 	li 	$v0, 4  	# print_string syscall code = 4 
 	la 	$a0, msg2 
 	syscall 

 	#Print int from index 
 	li 	$v0,1  	# print_int syscall code = 1 
 	lw 	$a0, 0($t5) 
 	syscall 

 	li 	$v0, 10 	# exit  syscall code = 10  	
 	syscall 

	.data 

	msg1: .asciiz "Input an index that less than 10 and greater than 0:	" 
	msg2: .asciiz "Result = " 
	space:  .asciiz " " 
	array: .word  1 ,2 ,3 ,4 ,5 ,6 ,7 ,8 ,9 ,10  

