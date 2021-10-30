	.text 
 	.globl main 
 main: 
 	lw 	$t3, size 	#store size of array into t3  	
 	la 	$t0, list 	#get array addresses  	
 	li 	$t2, 0  	#set loop counter == 0 
 	addi 	$s0, $zero, 0 #initialize sum with value 0 

	# Print the array 

	li  $v0, 4   
	la $a0, msg0 
	syscall 
	
 	# Print the new line  
 	li  	$v0, 4  	 
 	la 	$a0, line 
 	syscall 

	#Calculating the sum of even elements in array 
loopEven: 	 
 	beq 	$t2, $t3, stop_1 	#check for array end 
 	lw 	$s0, ($t0) 	 
 	add 	$s1, $s1, $s0 	#sum = sum + arr[i] 
 	addi 	$t0, $t0, 8 	#move to arr[i+2] 
 	addi 	$t2, $t2, 2 
 	j 	loopEven 

stop_1: 
 	# Print the result 	
 	#increase i by 1 

 	li  $v0, 4   
 	la $a0, msg1  
 	syscall 
 	
 	move    $a0, $s1
 	li      $v0, 1 
 	syscall 

 	# Print the new line  	 

 	li  $v0, 4   
 	la $a0, line  
 	syscall
#****************************************************** 

#Calculating the sum of even elements in array 	 
 	lw 	$t3, size 	# store size of array into t3 
 	la 	$t0, list 	# get arr[0] address 
 	addi 	$t0, $t0, 4 	# move to arr[1] 
 	li 	$t2, 0  	# set loop counter == 0 
 	addi  	$s2, $zero, 0 # initialize sum with value 0 
 	
loopOdd:
 	beq 	$t2, $t3, stop_2 	#check for array end 
	lw 	$s0, ($t0) 	 
	add 	$s2, $s2, $s0 # sum = sum + arr[i] 
	addi 	$t0, $t0, 8 	# move to arr[i+2] 
	addi 	$t2, $t2, 2 	# increase i by 2 
 	j 	loopOdd 
stop_2: 
 	# Print the result 
 	li  	$v0, 4  	 
 	la 	$a0, msg2 
 	syscall 

 	move    $a0, $s2  
 	li      $v0, 1  
 	syscall  

 	li 	$v0, 10 
 	syscall 
 	
 	.data  
list:  .word 1,2,3,4,5,6,7,8,9,10
size:  .word 10 
msg0: .asciiz "Initialize array: 1,2,3,4,5,6,7,8,9,10" 
msg1: .asciiz "The sum of even elements is:  	" 
msg2:  .asciiz "The sum of odd elements is:	" 
line:  	.asciiz "\n" 

