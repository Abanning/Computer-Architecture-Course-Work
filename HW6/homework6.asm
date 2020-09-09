# author: Alex Banning
# filename: homework6.asm
# assignment: Computer Architecture Homework 6
# date: March 5th, 2020
# description:  
#               Program for computer architecture HW6:
#               Call two subroutines for recursive (Fib1) and iterative (Fib2) Fibonacci
#               sequence. Store results in $s1 and $s2 respectively.

.text                                   # put your program here
.globl  main                            # your program starts with a main, just like main func in C/C++/Java

# Main function
main:
        addi    $s0, $zero, 8           # Fibonacci(n), n = 8
        add     $a0, $s0, $zero         # Prepare parameters
        jal Fib1                        # Call recursive Fib
        add     $s1, $v0, $zero         # Store return value in $s1
        add     $a0, $s0, $zero         # Prepare parameters
        jal Fib2                        # Call iterative Fib
        add     $s2, $v0, $zero         # Store return value in $s2
        j exit                          # exit

# Fibonacci Subroutine using recursion
Fib1:
        addi    $sp, $sp, -4		# Decrement stack pointer to allow room
	sw      $ra, 0($sp)	        # Push $ra onto stack
        addi    $sp, $sp, -4            # Decrement stack pointer to allow room
        sw      $s0, 0($sp)             # save n
        addi    $sp, $sp, -4	        # Decrement stack pointer to allow room
	sw      $s7, 0($sp)	        # Push Fib(n-1) onto stack
        add     $s0, $a0, $zero         # store parameter in $s3
        beq     $s0, $zero, return_0    # if (n == 0) { return 0; }
        addi    $t0, $zero, 1           # Fib(1) = 1
        beq     $s0, $t0, return_1      # if (n == 1) { return 1; }
        # Else, call recursively
        addi    $t0, $s0, -1            # $t0 = n - 1
        add     $a0, $t0, $zero         # prepare params
        jal Fib1                        # call recursive again Fib(n-1)
        add     $s7, $v0, $zero         # $s7 = Fib(n-1)
        addi    $t0, $s0, -2            # $t0 = n-2
        add     $a0, $t0, $zero         # prepare params
        jal Fib1                        # call Fib(n-2)
        add     $t2, $v0, $zero         # $t0 = new return value = Fib(n-1)
        add     $t0, $s7, $t2           # $t0 = fib(n-1) + fib(n-2)
        add     $v0, $t0, $zero         # return (Fib(n-1) + Fib(n-2));
        lw      $s7, 0($sp)             # pop old return value = Fib(n-1)
        addi    $sp, $sp, 4             # increment stack pointer
        lw      $s0, 0($sp)             # pop n
        addi    $sp, $sp, 4             # increment $sp
        lw      $ra, 0($sp)             # pop old return address
        addi    $sp, $sp, 4             # increment stack pointer
        jr      $ra                     # exit subroutine
return_0:
        lw      $s7, 0($sp)             # pop old return value = Fib(n-1)
        addi    $sp, $sp, 4             # increment stack pointer
        lw      $s0, 0($sp)             # pop n
        addi    $sp, $sp, 4             # increment $sp
        lw      $ra, 0($sp)             # pop $ra
        addi    $sp, $sp, 4             # increment $sp
        addi    $v0, $zero, 0           # return 0;
        jr	$ra                     # return from subroutine
return_1:
        lw      $s7, 0($sp)             # pop old return value = Fib(n-1)
        addi    $sp, $sp, 4             # increment stack pointer
        lw      $s0, 0($sp)             # pop n
        addi    $sp, $sp, 4             # increment $sp
        lw      $ra, 0($sp)             # pop $ra
        addi    $sp, $sp, 4             # increment $sp
        addi    $v0, $zero, 1           # return 1;
        jr      $ra                     # return from subroutine

# Fibonacci Subroutine using iteration
Fib2: 			
        addi    $t0, $zero, 1           # prev1 = $t0 = 1
	addi    $t1, $zero, 0 	        # prev2 = $t1 = 0
	addi    $t2, $zero, 0 	        # return_value = 0
	beq     $a0, $zero, return_t1
	beq     $a0, $t0, return_t0
	addi    $t3, $a0, -1 	        # use $t3 as final loop value (n-1)
        addi    $t4, $t4, 0 	        # counter = 0
loop:			
        beq     $t4, $t3, return_t2     # if counter == (n-1), return current value
	add     $t2, $t0, $t1	        # Else, return_value = prev1 + prev2
	add     $t1, $t0, $zero	        # prev2 = prev1
	add     $t0, $t2, $zero	        # prev1 = return_value
	addi    $t4, $t4, 1	        # increment counter
	j loop
return_t2:		
        addi    $v0, $t2, 0
	jr      $ra

return_t1:
	addi    $v0, $t1, 0
	jr      $ra
				
return_t0:		
        addi    $v0, $t0, 0
	jr      $ra

# End of Program
exit:
	ori     $v0, $zero, 10          # you need these two lines as the end of your program
	syscall