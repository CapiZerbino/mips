 	.text 

 	.globl main 
 main: 
 	lw 	$t3, size 	#store size of array into t3 
 	la 	$t0, list 	#get array addresses 
 	li 	$t2, 0  	#set loop counter == 0 
 	addi 	$s0, $zero, 0 	#initialize sum with value 0 

loop: 	 
 	beq 	$t2, $t3, stop #check for array end 
 	lw 	$s0, ($t0) 	 
 	add 	$s1, $s1, $s0 	#sum = sum + arr[i] 
 	addi 	$t0, $t0, 4 	#move to arr[i+1] 
 	addi 	$t2, $t2, 1 	#increase i by 1 
 	j 	loop 	
 stop: 	 	
 	# Print the result 	
 	li  	$v0, 4  	 
 	la 	$a0, msg1 	
 	syscall 	

 	move    $a0, $s1 	
 	li      $v0, 1 	
 	syscall 	
 	
 	li 	$v0, 10 	
 	syscall 	
 	.data 
list:  	.word 2, 3, 5, 7, 11, 13, 17, 19, 23, 29 
size:  	.word 10 
msg1: .asciiz "The sum of the array [2, 3, 5, 7, 11, 13, 17, 19, 23, 29] is: " 

