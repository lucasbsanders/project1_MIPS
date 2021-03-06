# On my honor, I have neither given nor received unauthorized aid on this assignment
# Project 1 - CDA3101
# Lucas Sanders

#data section
.data
arrayA: .word 89, 19, 91, -5, 23, -67, 31, 46, -71, -14, -10, 3, 67, 17, 11, -18, 43, -73		#load array A with its values
arrayB: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0		#load array B with its values
arrayC: .word 0, 0, 0, 0, 0, 0, 0 		#load array C with its values
sizeA: .byte 72
sizeB: .byte 44
sizeC: .byte 28
msg0:	.asciiz "Index of the smallest positive number: "
msg1:	.asciiz "Array B: "
msg2:	.asciiz "Array C: "
msg3:	.asciiz " "
msg4:	.asciiz "\n"

.text
.globl main
main:
	la $s0, arrayA		#load register s0 with address of array A
	la $s1, arrayB		#load register s1 with address of array B
	la $s2, arrayC		#load register s2 with address of array C
	
	li $t0, 100 		#load t0 with min = 100
	li $t1, 0 		#load t1 with minIndex = 0
	li $t2, 0		#load t2 with value i=0 
	li $t3, 0		#load t3 with value j=0 
	li $t4, 0		#load t4 with value k=0
				#t5, t6, t7 are used intermittedly within the program
	
#/*find the index of the smallest positive number in the array*/
	
	li $t2, 0		#set t2 to 0. t2 is i, used as an iterator for this loop
loopo:
	add $t6, $t2, $s0		#set t6 equal to the memory location A[i]
	lw $t5, 0($t6)		#load a temporary value (t5) with A[i]
	slt $t6, $t5, $t0		#load a temporary value (t6) with 1 if A[i] is less than min
	slt $t7, $zero, $t5		#load a temporary value (t7) with 1 if A[i] is greater than 0
	and $t5, $t7, $t6		#AND value (t5) is the result of the two previous boolean statements
	bne $t5, 1, ifo		#skip the steps in the if statement if t5 (boolean within if statement) is not equal to one
	
	add $t6, $t2, $s0		#set t6 equal to the memory location A[i]
	lw $t0, 0($t6)		#load the variable min with A[i]
	add $t1, $t2, 0		#sets minIndex equal to i
ifo:				#skip to here if the if statement fails
	addi $t2, 4		#iterate (i plus 4, for the size of a word)
	slti $t6, $t2, sizeA 	#set temp value t6 to 1, if i is less than 18 times 4
	beq $t6, 1, loopo		#if t6 is 1, then loop back to the start of loopo
	
	la $a0, msg0		
	li $v0, 4		#print the following: ("Index of the smallest positive number: ")	
	syscall
	srl $t1, $t1, 2
	add $a0, $t1, 0		
	li $v0, 1 		#print the index	
	syscall
	sll $t1, $t1, 2
	
#/*Transfer all positive numbers to array B and all negative numbers to array C*/

	li $t3, 0		#load t3 with value j=0 
	li $t4, 0		#load t4 with value k=0
	li $t2, 0		#t2 is i, used as an iterator for this loop
loopw:
	
	add $t6, $t2, $s0		#set t6 equal to the memory location A[i]
	lw $t5, 0($t6)		#load a temporary value (t5) with A[i]
	slt $t7, $zero, $t5		#load a temporary value (t5) with 1 if A[i] is greater than 0
	bne $t7, 1, ifw		#skip the steps in the "if" statement if t5 (boolean within if statement) is not equal to one

	add $t6, $t2, $s0		#set t6 equal to the memory location A[i]
	lw $t5, 0($t6)		#load a temporary value (t5) with A[i]
	add $t6, $t3, $s1		#set t6 equal to the memory location B[j]
	sw $t5, 0($t6)		#sets B[j] equal to A[i]
	addi $t3, 4		#iterate (j plus 4)
	j elseo
	
ifw:				#else statement
	add $t6, $t2, $s0		#set t6 equal to the memory location A[i]
	lw $t5, 0($t6)		#load a temporary value (t5) with A[i]
	add $t6, $t4, $s2		#set t6 equal to the memory location C[k]
	sw $t5, 0($t6)		#sets C[k] equal to A[i]
	addi $t4, 4		#iterate (k plus 4)
elseo:
	addi $t2, 4		#iterate (i plus 4)
	slti $t6, $t2, sizeA 	#set t6 equal to 1 if i is less than 18 times 4
	beq $t6, 1, loopw		#if t6 is 1, then loop back to the start of loopw
	
	la $a0, msg4
	li $v0, 4		#print the following: ("\n")
	syscall
	la $a0, msg1
	li $v0, 4		#print the following: ("Array B ")
	syscall
	
	li $t2, 0		#t2 is i, used as an iterator for this loop
loopt:
	add $t6, $t2, $s1		#set t6 equal to the memory location B[i]
	lw $t5, 0($t6)		#load a temporary value (t5) with B[i]
	
	la $a0, msg3		
	li $v0, 4 		#print the following: (" ")	
	syscall
	add $a0, $t5, 0
	li $v0, 1 		#print  B[i]	
	syscall
	
	addi $t2, 4		#iterate (i plus 4)
	slti $t6, $t2, sizeB		#set t6 equal to 1 if i is less than 11 times 4
	beq $t6, 1, loopt		#if t6 is 1, then loop back to the start of loopt
	
	la $a0, msg4
	li $v0, 4		#print the following: ("\n")
	syscall
	la $a0, msg2
	li $v0, 4		#print the following: ("Array C ")
	syscall
	
	li $t2, 0		#t2 is i, used as an iterator for this loop
loopf:
	add $t6, $t2, $s2		#set t6 equal to the memory location C[i]
	lw $t5, 0($t6)		#load a temporary value (t5) with C[i]
	
	la $a0, msg3		
	li $v0, 4 		#print the following: (" ")	
	syscall
	add $a0, $t5, 0		
	li $v0, 1 		#print  C[i]	
	syscall
	
	addi $t2, 4		#iterate (i plus 4)
	slti $t6, $t2, sizeC 		#set t6 equal to 1 if i is less than 7 times 4
	beq $t6, 1 loopf		#if t6 is 1, then loop back to the start of loopf

	la $a0, msg4
	li $v0, 4		#print the following: ("\n")
	syscall
	
    	li $v0, 10
    	syscall             # exit
