# author:       Alex Banning
# filename:     homework3.asm
# assignment:   Computer Architecture - HW3
# date:         February 12th, 2020
# description:  This program takes three data values, stored in $S0 - $S2, and returns the largest value in $S3

.text                   # put your program here
.globl  main            # your program starts with a main, just like main func in C/C++/Java

main:
        # Assign Values
        addi $s0, $zero, 0
        addi $s1, $zero, 1
        addi $s2, $zero, 2

        # Find Largest
        slt $t0, $s0, $s1                 # if s0 < s1, t0 = 1
        beq $t0, $zero, compare02         # if $t0 = 0, J compare s0 and s2
        slt $t0, $s1, $s2                 # if s1 < s2, t0 = 1
        beq $t0, $zero, storeS1           # if t0 = 0, s1 is largest
        j storeS2                         # else, s2 is largest
compare02:
        slt $t0, $s0, $s2                 # if s0 < s2, t0 = 1
        beq $t0, $zero, storeS0           # if t0 = 0, s0 is largest
        j storeS2                         # else, s2 is largest
storeS0:
        add $s3, $s0, $zero               # return s0
        j exit
storeS1:
        add $s3, $s1, $zero               # return s1
        j exit
storeS2:
        add $s3, $s2, $zero               # return s2
        j exit
exit:
        
        ori $v0, $zero, 10              # you need these two lines as the end of your program
        syscall