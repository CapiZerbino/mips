	.text 
 	.globl main 
main: 
 	li 	$t3, 0  	#set loop counter 1 == 0 
while: 
 	beq 	$t3, 40, exit 
 	li 	$v0, 4  	#Print command asking input integer from user  	
 	la 	$a0, prompt 
 	syscall 
 	
 	li 	$v0, 5  	#User input  	
 	syscall 
 	
	sw 	$v0, list($t3) 
	addi 	$t3, $t3, 4 
	j while 
exit: 	 	
 	addi 	$s0, $zero, 0 	#initialize sum with value 0 
 	la 	$t0, list 	#get array addresses 
 	li 	$t2, 0  	#set loop counter 2 == 0 
 	addi 	$s1, $zero, 0 	

loop: 	 	
 	beq 	$t2, 10, stop 	#check for array end 
 	lw 	$s0, 0($t0) 	 
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
list:  	.space 40 
msg1: 	.asciiz "The sum of the array is:	 " 
prompt: .asciiz "Enter a number: 	" 

