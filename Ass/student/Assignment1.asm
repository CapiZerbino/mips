.data
	welcome:	.asciiz "========== WELCOME TO THE GAME TIC-TAC-TOE ==========\n"
	endgame:	.asciiz "\n\n===================== END GAME ======================\n"
	turn_player_1:	.asciiz "X - Which square? [1-9]: "
	turn_player_2:	.asciiz "O - Which square? [1-9]: "
	player_1_win:	.asciiz "\n	CONGRATULATIONS!!! PLAYER 1 (X) WIN"
	player_2_win:	.asciiz "\n	CONGRATULATIONS!!! PLAYER 2 (0) WIN"
	lastdraw: 	.asciiz "\n	DRAW !!! BOTH OF YOU ARE STRONG"
	row1:		.asciiz "	|  1  |  2  | 3   |"
	row2:		.asciiz "	|  4  |  5  |  6  |"
	row3:		.asciiz "	|  7  |  8  |  9  |"
	x:		.asciiz "  X  "
	o:		.asciiz "  O  "
	empty:		.asciiz "     "
	tab:		.asciiz "	"
	sep:		.asciiz "|"
	row:		.asciiz "\n	+-----+-----+-----+\n"
	explain:	.asciiz "The board numbering is as follows.\nPlay in a cell by selecting the cell number."
	explain_1:	.asciiz "Player 1 is displayed as X and player 2 is displayed as O"
	explain_2:	.asciiz "Enter the location[1-9] to play the games\nPLayer 1 move first.\n"
	newline:	.asciiz "\n"
	grid:		.asciiz 
	
.text
	
#define registers
#	$s0	==>	
#	$s1	==>	
#	$s2	==>	
#	$s3	==>	
#	$s4	==>	
#	$s5	==>	
#	$s6	==>	
#	$s7	==>	

main:
	li	$s3, 0
	li	$s4, 0
	
	la	$a0, welcome
	li	$v0, 4		
	syscall
	
	la	$a0, newline
	li	$v0, 4		
	syscall
	
	j	displaysample
	
#to determine the turn of player 1 or player 2
turn:
	la	$a0, newline
	li	$v0, 4		
	syscall
	
	
	beq	$s3, 0, player1
	beq	$s3, 1, player2
	
#control player 1 turn 
player1:
	la	$a0, turn_player_1
	li	$v0, 4
	syscall
	
	j	start
	
#control player 2 turn
player2:
	la	$a0, turn_player_2
	li	$v0, 4
	syscall
	
	j	start
	
#start the game: this function execute 3 other functions: getinput, check, store
start:
	beq 	$s4, 9, draw
	
	jal 	input
	jal	check
	j	store
	
#read input from player
input:
	li	$v0, 5	#get position
	syscall
	li	$s2, 0	#load 0 to s2
	add	$s2, $s2, $v0
	jr	$ra
	
#check input
check:
	la 	$t1, grid  		# load the board address
	add 	$t1, $t1, $s2 		# get exact locaion by adding $s2 into $t1
	lb 	$t2, ($t1) 		
	bne 	$t2, 0, turn 		# check if $t2!=0 jump to turn
	bge 	$s2, 10, turn 		# check if $s2 >= 10, jump to turn
	ble 	$s2, 0, turn 		# check if $s2 <= 0, jump to turn
	jr 	$ra 			#return to previous function

#save value into board
store:
	addi 	$s4, $s4, 1 		#increment $s4 for every turn
	beq 	$s3, 0, store_player_1 	#if player 1's turn jump to storex
	beq 	$s3, 1, store_player_2 	#if player 2's turn jump to storeo
	

#store the player 1 turn
store_player_1:
	la 	$t1, grid 		#load the grid
	add 	$t1, $t1, $s2 		#add $s2 location to $t1 to get the exact location
	li 	$t2, 1 
	sb 	$t2, ($t1) 		#store $t1 to $t2
	li 	$s3, 1 			#change the turn to player 2
	j 	show 			#jump to display
	
#store the player 2 turn
store_player_2:
	la $t1, grid
	add $t1, $t1, $s2
	li $t2, 2
	sb $t2, ($t1)
	li $s3, 0 #change the turn to player 1
	j show


#show grid view
show:
	li 	$s0, 0 			#set $s0 to 0 (count value is filled full or not)
	li 	$s1, 0 			#set $s1 to 1
	j 	showline 		#jump to displayline
	
	
#to display newline for displaying grid
showline:
	addi 	$s1, $s1, 3 		#add $s1 + 3 to make sure every 3 output make a new line
	
	
	la	$a0, row
	li	$v0, 4		
	syscall
	
	
	la	$a0, tab
	li	$v0, 4		
	syscall
	
	la	$a0, sep
	li	$v0, 4		
	syscall 
	
	j 	showgrid 		#jump to disply grid
		
	
#displaying all the information in grid
showgrid:
	beq 	$s0, $s1, showline
	beq 	$s0, 9, checkwinall 		#if $s0==9(all the value in grid are displayed), check the winning condition
	
	addi 	$s0, $s0, 1 			#increment $s0
	la	$t2, grid 			#load the current grid address
	add 	$t2, $t2, $s0  			#add the address with $s0
	lb 	$t3, ($t2) 			#load byte of $t2 to $t3
	
	beq 	$t3, 0, displayspace 		#if the value in $t3==0 jump to displayspace
	beq 	$t3, 1, display_X 		#if $t3==1 jump to displayx
	beq 	$t3, 2, display_O 		#if $t3==2 jump to displayo
	
#to display 1 to x 
display_X:
	la 	$a0, x
	li	$v0, 4		
	syscall
	
	la	$a0, sep
	li	$v0, 4		
	syscall
	j 	showgrid

#to display 2 to O
display_O:
	la 	$a0, o
	li	$v0, 4		
	syscall
	
	la	$a0, sep
	li	$v0, 4		
	syscall
	j 	showgrid
	
#to display ? if the value in grid is 0
displayspace:
	la	$a0, empty
	li	$v0, 4		
	syscall
	la	$a0, sep
	li	$v0, 4		
	syscall
	j 	showgrid #jump back to grid
	
	
#display sample board with location (1-9)
displaysample:
	la	$a0, explain
	li	$v0, 4
	syscall
	jal 	newlines
	
	la	$a0, row
	li	$v0, 4		
	syscall
	
	la	$a0, row1
	li	$v0, 4
	syscall
	
	la	$a0, row
	li	$v0, 4		
	syscall
	
	la	$a0, row2
	li	$v0, 4
	syscall
	
	la	$a0, row
	li	$v0, 4		
	syscall
	
	la	$a0, row3
	li	$v0, 4
	syscall
	
	la	$a0, row
	li	$v0, 4		
	syscall
	
	la	$a0, explain_1
	li	$v0, 4
	syscall
	jal	newlines
	
	la	$a0, explain_2
	li	$v0, 4
	syscall
	jal	newlines
	
	j	turn
	
#create new line
newlines:
	li	$a0, 10		#load line
	li	$v0, 11		#print line
	syscall
	jr	$ra
	
#to check the winning condition
checkwinall:
	bge 	$s4, 5, wincondition1 #if $s4>=5 check the winning condition)
	j 	turn #if not jump to turn
	
	
#check if all the values in first row has the same value
wincondition1:
	li 	$s6, 0 			#set $s6 to 0
	li 	$s5, 1 			#set$s5 to 1
	la 	$t1, grid 		#load grid to $t1
	add 	$t1, $t1, $s5 		#add $t1 + $s5 to access the value in position 1
	lb 	$t2, ($t1) 		#load $t1 to $t2
	addi 	$t1, $t1, 1 		#increment address $t1 + 1 
	lb 	$t3, ($t1) 		#load $t1 to $t3
	addi 	$t1, $t1, 1 		#increment address $t1 + 1 
	lb 	$t4, ($t1) 		#load $t1 to $t4
	add 	$s6, $s6, $t2 		#add $s6 +$t2 for further checking
	bne 	$t2, $t3, wincondition2 #check if the values are same, jump to next wincondition
	bne 	$t3, $t4, wincondition2 #check if the values are same, jump to next wincondition
	beq 	$t2, 0, wincondition2 	#check if $t2 is equal to 0 which is empty, jump to next wincondition
	j 	win 			#else jump to win
	
#check if all the values in first column has the same value
wincondition2:
	li $s6, 0
	li $s5, 1
	la $t1, grid
	add $t1, $t1, $s5
	lb $t2, ($t1)
	addi $t1, $t1, 3
	lb $t3, ($t1)
	addi $t1, $t1, 3
	lb $t4, ($t1)
	add $s6, $s6, $t2
	bne $t2, $t3, wincondition3
	bne $t3, $t4, wincondition3
	beq $t2, 0, wincondition3
	j win

#check if the position 1,5,9(diagonal) have the same value
wincondition3:
	li $s6, 0
	li $s5, 1
	la $t1, grid
	add $t1, $t1, $s5
	lb $t2, ($t1)
	addi $t1, $t1, 4
	lb $t3, ($t1)
	addi $t1, $t1, 4
	lb $t4, ($t1)
	add $s6, $s6, $t2
	bne $t2, $t3, wincondition4
	bne $t3, $t4, wincondition4
	beq $t2, 0, wincondition4
	j win

#check if all the values in second column have the same value
wincondition4:
	li $s6, 0
	li $s5, 2
	la $t1, grid
	add $t1, $t1, $s5
	lb $t2, ($t1)
	addi $t1, $t1, 3
	lb $t3, ($t1)
	addi $t1, $t1, 3
	lb $t4, ($t1)
	add $s6, $s6, $t2
	bne $t2, $t3, wincondition5
	bne $t3, $t4, wincondition5
	beq $t2, 0, wincondition5
	j win

#check if all the values in second row are same
wincondition5:
	li $s6, 0
	li $s5, 4
	la $t1, grid
	add $t1, $t1, $s5
	lb $t2, ($t1)
	addi $t1, $t1, 1
	lb $t3, ($t1)
	addi $t1, $t1, 1
	lb $t4, ($t1)
	add $s6, $s6, $t2
	bne $t2, $t3, wincondition6
	bne $t3, $t4, wincondition6
	beq $t2, 0, wincondition6
	j win

#check if positon 3,5,7(second diagonal) are same
wincondition6:
	li $s6, 0
	li $s5, 3
	la $t1, grid
	add $t1, $t1, $s5
	lb $t2, ($t1)
	addi $t1, $t1, 2
	lb $t3, ($t1)
	addi $t1, $t1, 2
	lb $t4, ($t1)
	add $s6, $s6, $t2
	bne $t2, $t3, wincondition7
	bne $t3, $t4, wincondition7
	beq $t2, 0, wincondition7
	j win

#check all the values in third column are same
wincondition7:
	li 	$s6, 0
	li 	$s5, 3
	la 	$t1, grid
	add 	$t1, $t1, $s5
	lb 	$t2, ($t1)
	addi 	$t1, $t1, 3
	lb 	$t3, ($t1)
	addi 	$t1, $t1, 3
	lb 	$t4, ($t1)
	add 	$s6, $s6, $t2
	bne 	$t2, $t3, wincondition8
	bne 	$t3, $t4, wincondition8
	beq 	$t2, 0, wincondition8
	j 	win

#check if all the values in third row are same
wincondition8:
	li 	$s6, 0
	li 	$s5, 7
	la 	$t1, grid
	add 	$t1, $t1, $s5
	lb 	$t2, ($t1)
	addi 	$t1, $t1, 1
	lb 	$t3, ($t1)
	addi 	$t1, $t1, 1
	lb 	$t4, ($t1)
	add 	$s6, $s6, $t2
	bne 	$t2, $t3, turn #check if $t2!=t$t3 return to turn
	bne 	$t3, $t4, turn #check if $t4!=t$t3 return to turn
	beq 	$t2, 0, turn #check if $t2 has mssing values, retur to turn
	j 	win #else jump to win
	
#to display the winner
win:
	beq 	$s6, 1, player1_win #check if $s6==1(x),jump to player1win
	beq 	$s6, 2, player2_win #check if $s6==2(O),jump to player2win
	
#load and display win1
player1_win:
	la	$a0, newline
	li	$v0, 4		
	syscall
	
	la 	$a0, player_1_win
	li 	$v0, 4
	syscall
	j 	end
	
#load and display win2
player2_win:
	la	$a0, newline
	li	$v0, 4		
	syscall
	
	la 	$a0, player_2_win
	li 	$v0, 4
	syscall
	j 	end
	
#load and display lastdraw
draw:
	la	$a0, newline
	li	$v0, 4		
	syscall
	
	la 	$a0, lastdraw
	li 	$v0, 4
	syscall
	
	j 	end
	
#exit the program
end:
	la 	$a0, endgame
	li 	$v0, 4
	syscall
	li $v0, 10
	syscall
