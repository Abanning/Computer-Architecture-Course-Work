# author: Alex Banning
# filename: homework4.asm
# assignment: Computer Architecture Homework 4
# date: February 20th, 2020
# description:  
#               Program for computer architecture HW5:
#               What we need:
#               	⁃	A calling function (main)
#	                ⁃	A callee function — subroutine
#               	⁃	4 Parameters, 2 RV (max in s4 and min in s5)

.text                   # put your program here
.globl  main            # your program starts with a main, just like main func in C/C++/Java

main:
		# Prepare input values
		addi $s0, $zero, 50
		addi $s1, $zero, 40
		addi $s2, $zero, 30
		addi $s3, $zero, 20
		# Prepare input parameters
		add $a0, $s0, $zero
		add	$a1, $s1, $zero
		add	$a2, $s2, $zero
		add	$a3, $s3, $zero
		# Call subroutine 
		jal Subroutine
		add $s4, $v0, $zero # $s4 = max, $s5 = min
		add	$s5, $v1, $zero
		j exit_all

Subroutine:
		addi $sp, $sp, -4		# Decrement stack pointer to allow room
		sw   $ra, 0($sp)		# Push $ra onto stack
		jal  FindMaximum
		add  $s4, $v0, $zero	# s4 = maximum
		jal  FindMinimum
		add	 $s5, $v0, $zero	# s5 = minimum
		
		# Prepare for return to main
		lw	 $ra, 0($sp)		# Get return address (pop)
		addi $sp, $sp, 4		# Increment stack pointer
		add	 $v0, $s4, $zero	# v0 gets minimum
		add	 $v1, $s5, $zero	# v1 gets maximum
		jr	 $ra

# Subroutine that finds the maximum value in a set of parameters
FindMaximum:
test01_max:
		slt $t0, $a0, $a1		# if a0 < a1, t0 = 1
		beq	$t0, $zero, test02_max
test12_max:		
        slt	$t0, $a1, $a2		# if a1 < a2, t0 = 1
		beq	$t0, $zero, test13_max
test23_max:
		slt	$t0, $a2, $a3		# if a2 < a3, t0 = 1
		beq	$t0, $zero, setA2_max
		j setA3_max
test02_max:
		slt	$t0, $a0, $a2		# if a0 < a2, t0 = 1
        beq	$t0, $zero, test03_max
		j test23_max
test13_max:
		slt $t0, $a1, $a3		# if a1 < a3, t0 = 1
		beq	$t0, $zero, setA1_max
		j setA3_max
test03_max:
		slt	$t0, $a0, $a3
		beq	$t0, $zero, setA0_max
setA0_max:
		add	$v0, $a0, $zero
		j exit_findmax
setA1_max:
		add	$v0, $a1, $zero
		j exit_findmax
setA2_max:
		add	$v0, $a2, $zero
		j exit_findmax
setA3_max:
		add	$v0, $a3, $zero
exit_findmax:
		jr	$ra

# Subroutine that finds the minimum value in a set of parameters
FindMinimum:
test01_min:
		slt	$t0, $a0, $a1		# if a0 < a1, t0 = 1
		bne $t0, $zero, test02_min
test12_min:
		slt	$t0, $a1, $a2		# if a1 < a2, t0 = 1
		bne	$t0, $zero, test13_min
test23_min:
		slt	$t0, $a2, $a3		# if a2 < a3, t0 = 1
		bne	$t0, $zero, setA2_min
		j setA3_min
test02_min:
    	slt	$t0, $a0, $a2		# if a0 < a2, t0 = 1
		bne	$t0, $zero, test03_min
		j test23_min
test13_min:
		slt	$t0, $a1, $a3		# if a1 < a3, t0 = 1
		bne	$t0, $zero, setA1_min
		j setA3_min
test03_min:
		slt	$t0, $a0, $a3
		bne	$t0, $zero, setA0_min
setA0_min:
		add	$v0, $a0, $zero
		j exit_findmin
setA1_min:
		add	$v0, $a1, $zero
		j exit_findmin
setA2_min:
		add	$v0, $a2, $zero
		j exit_findmin
setA3_min:
		add	$v0, $a3, $zero
exit_findmin:
		jr	$ra

exit_all:
        ori $v0, $zero, 10              # you need these two lines as the end of your program
        syscall