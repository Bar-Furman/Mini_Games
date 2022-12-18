# Title: c.s        	Filename:c.s
# Author: Bar Furman - 208533406     	Date:16.12.22
# Description: actions on array numbers
# Input: -
# Output: different outputs - descripted in the code
################# Data segment #####################
.data
array: .byte 23,-2,45,67,89,12,-100,0,120,6
comma: .asciiz ","
msga1: .asciiz "\nThe sum of the array(signed) is: "
msga2: .asciiz "\nThe sum of the squares(signed) is: "
msgb: .asciiz "\nThe difference of each pair of number(signed) in the array is: "
msgc: .asciiz "\nThe array as unsigned numbers: "
msgd1: .asciiz "\nThe sum of the array(unsigned) is: "
msgd2: .asciiz "\nThe sum of the squares(unsigned) is: "
################# Code segment #####################
.text
.globl main
main:	# main program entry
	add $t0,$zero,$zero		#zero out $t0 for later use
	add $t1,$zero,$zero		#zero out $t0 for later use
	add $t2,$zero,$zero		#zero out $t2 for later use
	
a1: #The sum of the array(signed)
	lb $t1,array($t0)		#loads the byte $t0 location in the array
	add $t2,$t2,$t1			#adds $t1 (the new number) to $t2 (the sum)
	beq $t0,9,print_a1		#if $t0 is at the last numer of the array, go to print
	addi $t0,$t0,1			#adds '1' to $t0
	j a1
	
print_a1: #the print of a1
	li $v0,4			#prints string in $a0
	la $a0,msga1			#loads space to $a0
	syscall
	li $v0,1			#prints value of $a0
	move $a0,$t2			#stores $t2 (the sum) to $a0
	syscall

	add $t0,$zero,$zero		#zero out $t0 for later use
	add $t1,$zero,$zero		#zero out $t0 for later use
	add $t2,$zero,$zero		#zero out $t2 for later use
	
a2: #The sum of the squares(signed)
	lb $t1,array($t0)		#loads the byte $t0 location in the array
	mul $t1,$t1,$t1			#sqr $t1 and returns to $t1
	add $t2,$t2,$t1			#adds $t1 (the new number) to $t2 (the sum)
	beq $t0,9,print_a2		#if $t0 is at the last number of the array, go to print
	addi $t0,$t0,1			#adds '1' to $t0
	j a2
	
print_a2: #the print of a2
	li $v0,4			#prints string in $a0
	la $a0,msga2			#loads space to $a0
	syscall
	li $v0,1			#prints value of $a0
	move $a0,$t2			#stores $t2 (the sum) to $a0
	syscall
	
	add $t0,$zero,$zero		#zero out $t0 for later use
	add $t1,$zero,$zero		#zero out $t0 for later use
	add $t2,$zero,$zero		#zero out $t2 for later use
	
#b starts here:
	li $v0,4			#prints string in $a0
	la $a0,msgb			#loads space to $a0
	syscall
	j b
	
b: #The difference of each pair of number(signed) in the array
	lb $t1,array($t0)		#loads the byte $t0 location in the array
	addi $t0,$t0,1			#adds '1' to $t0
	lb $t2,array($t0)		#loads the byte $t0 location in the array
	sub $t2,$t1,$t2			#makes $t2 the difference of $t2 and $t1

print_b: #label for comfort
	li $v0,1			#prints value of $a0
	move $a0,$t2			#stores $t2 (the diff) to $a0
	syscall
	li $v0,4			#prints string in $a0
	la $a0,comma			#loads space to $a0
	syscall
	bne $t0,9,b			#if the not all pairs have been used it will return to 'b'

	add $t0,$zero,$zero		#zero out $t0 for later use
	add $t1,$zero,$zero		#zero out $t0 for later use
	add $t2,$zero,$zero		#zero out $t2 for later use
	
#c starts here:	
	li $v0,4			#prints string in $a0
	la $a0,msgc			#loads space to $a0
	syscall

c: #The array as unsigned numbers
	lbu $t1,array($t0)		#loads the byte (unsigned) $t0 location in the array
	li $v0,1			#prints value of $a0
	move $a0,$t1			#stores $t1 (the number) to $a0
	syscall
	li $v0,4			#prints string in $a0
	la $a0,comma			#loads space to $a0
	syscall
	addi $t0,$t0,1			#adds '1' to $t0
	bne $t0,10,c			#if $t0 is not on the last number of the array return to 'c'

	add $t0,$zero,$zero		#zero out $t0 for later use
	add $t1,$zero,$zero		#zero out $t0 for later use
	add $t2,$zero,$zero		#zero out $t2 for later use

d1: #The sum of the array(signed)
	lbu $t1,array($t0)		#loads the byte $t0 location in the array
	add $t2,$t2,$t1			#adds $t1 (the new number) to $t2 (the sum)
	beq $t0,9,print_d1		#if $t0 is at the last numer of the array, go to print
	addi $t0,$t0,1			#adds '1' to $t0
	j d1
	
print_d1: #the print of d1
	li $v0,4			#prints string in $a0
	la $a0,msgd1			#loads space to $a0
	syscall
	li $v0,1			#prints value of $a0
	move $a0,$t2			#stores $t2 (the sum) to $a0
	syscall

	add $t0,$zero,$zero		#zero out $t0 for later use
	add $t1,$zero,$zero		#zero out $t0 for later use
	add $t2,$zero,$zero		#zero out $t2 for later use
	
d2: #The sum of the squares(unsigned)
	lbu $t1,array($t0)		#loads the byte $t0 location in the array
	mul $t1,$t1,$t1			#sqr $t1 and returns to $t1
	add $t2,$t2,$t1			#adds $t1 (the new number) to $t2 (the sum)
	beq $t0,9,print_d2		#if $t0 is at the last number of the array, go to print
	addi $t0,$t0,1			#adds '1' to $t0
	j d2
	
print_d2: #the print of d2
	li $v0,4			#prints string in $a0
	la $a0,msgd2			#loads space to $a0
	syscall
	li $v0,1			#prints value of $a0
	move $a0,$t2			#stores $t2 (the sum) to $a0
	syscall
			
exit:	li $v0, 10			# Exit program
	syscall
