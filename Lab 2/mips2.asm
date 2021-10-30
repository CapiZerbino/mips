# Compute several Fibonacci numbers and put in array, then print
.data
fibs:.word   0 : 19         # "array" of words to contain fib values
size: .word  19             # size of "array" (agrees with array declaration)
prompt: .asciiz "How many Fibonacci numbers to generate? (2 <= x <= 19): "
space:.asciiz  " "          # space to insert between numbers
head: .asciiz  "The Fibonacci numbers are:\n"
.text
      la   $s0, fibs        # load address of array
      la   $s5, size        # load address of size variable
      lw   $s5, 0($s5)      # load array size

# Optional: user inputs the number of Fibonacci numbers to generate
pr:   la   $a0, prompt      # load address of prompt for syscall
      li   $v0, 4           # specify Print String service
      syscall               # print the prompt string
      li   $v0, 5           # specify Read Integer service
      syscall               # Read the number. After this instruction, the number read is in $v0.
      bgt  $v0, $s5, pr     # Check boundary on user input -- if invalid, restart
      blt  $v0, $zero, pr   # Check boundary on user input -- if invalid, restart
      add  $s5, $v0, $zero  # transfer the number to the desired register
      
      li   $s2, 1           # 1 is the known value of first and second Fib. number
      sw   $s2, 0($s0)      # F[0] = 1
      sw   $s2, 4($s0)      # F[1] = F[0] = 1
      addi $s1, $s5, -2     # Counter for loop, will execute (size-2) times
      
      la   $a0, head        # load address of the print heading string
      li   $v0, 4           # specify Print String service
      syscall               # print the heading string
      
      lw   $a0, 0($s0)      # load the integer to be printed (the current Fib. number)
      li   $v0, 1           # specify Print Integer service
      syscall               # print fibonacci number
      
      la   $a0, space       # load address of spacer for syscall
      li   $v0, 4           # specify Print String service
      syscall               # print the spacer string
      
      lw   $a0, 4($s0)      # load the integer to be printed (the current Fib. number)
      li   $v0, 1           # specify Print Integer service
      syscall               # print fibonacci number
      
      la   $a0, space       # load address of spacer for syscall
      li   $v0, 4           # specify Print String service
      syscall               # print the spacer string
      
      # Loop to compute each Fibonacci number using the previous two Fib. numbers.
loop: lw   $s3, 0($s0)      # Get value from array F[n-2]
      lw   $s4, 4($s0)      # Get value from array F[n-1]
      add  $s2, $s3, $s4    # F[n] = F[n-1] + F[n-2]
      
      move $t0, $s2
      li   $v0, 1
      move $a0, $t0
      syscall
      
      la   $a0, space       # load address of spacer for syscall
      li   $v0, 4           # specify Print String service
      syscall               # print the spacer string
      
      sw   $s2, 8($s0)      # Store newly computed F[n] in array
      addi $s0, $s0, 4      # increment address to now-known Fib. number storage
      addi $s1, $s1, -1     # decrement loop counter
      bgtz $s1, loop        # repeat while not finished
      
      # The program is finished. Exit.
      li   $v0, 10          # system call for exit
      syscall               # Exit!
