.data
testarray: .word 1 2 3 4 5 6 7 8 9 10
sumMsg: .asciiz "Sum = "
newline: .asciiz "\n"

.text 
j start

sum:   addiu $sp, $sp, -8
       sw $s0, 0($sp)    # save s0 because we overwrite it
       sw $ra, 4($sp)    # save $ra because jal overwrites it

	beq $a1, $zero, basecase
	addiu $t0, $a1, -1
	sll $t0, $t0, 2
	addu $t0, $t0, $a0
	lw $s0, 0($t0)        # s0 = arr[size-1]
	addiu $a1, $a1, -1    # set arguments
	jal sum              # call sum(arr, size - 1)
	addu $s0, $v0, $s0   # s0 = s0 + sum(arr,size-1)
	
	li	$v0, 4
	la	$a0, sumMsg
	syscall
	
	li	$v0, 1
	move	$a0, $s0
	syscall
	
	li	$v0, 4
	la	$a0, newline
	syscall
	
	move $v0, $s0        # put result in v0
	
	j sum_end

basecase: addi $v0, $zero, 0   # put result in v0

sum_end: 
	lw $s0, 0($sp)    # restore $s0
       lw $ra, 4($sp)      # restore $ra
       addiu $sp, $sp, 8
       jr $ra
       
start:
la $a0, testarray   # load address of the array [1,2,3]
addiu $a1, $zero, 10   # size = 3
jal sum              # call sum(testarray, 3)

