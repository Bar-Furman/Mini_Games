# Title: a.s        	Filename:a.s
# Author: Bar Furman - 208533406     	Date:12.12.22
# Description: printing info about input numbers
# Input: numbers by the user until '0'
# Output: different info about the input number
################# Data segment #####################
.data
space: .asciiz " "
line: .asciiz "\n"
ans1: .asciiz "OK"
ans2: .asciiz "WRONG"
################# Code segment #####################
.text
.globl main
main:	# main program entry
	li $v0,4		#prints string in $a0
	la $a0,line		#loads space to $a0
	syscall
	
	li,$v0,5		#reads int to $v0
	syscall
	beq $v0,$zero,exit	#exits program if the input is '0'

a:	move,$a0,$v0		#stores $v0 to $a0
	li $v0,1		#prints value of $a0
	syscall
	move,$t0,$a0		#stores $a0 to $t0 for later use

	li $v0,4		#prints string in $a0
	la $a0,space		#loads space to $a0
	syscall

b:	add $t1,$zero,$zero	#zero out $t1 for later use
	addi $t2,$zero,1	#stores the immediate '1' in $t2 as a mask
	sll $t2,$t2,31		#moves the mask to the 32 bit position
	addi $t3,$zero,32	#loop counter for later use
	
c:	add $t4,$zero,$zero	#zero out $t4 for later use as '1' counter
	
loop_b: and $t1,$t0,$t2		#stores the ans of bitwise mul of the int and '1'
	beq $t1,$zero,print_b	#if the bit is '0' it goes to print
	add $t1,$zero,$zero	#zero out $t1
	addi $t1,$zero,1	#stores '1' in $t1
	addi $t4,$t4,1		#+1 to '1' counter
	j print_b
	
print_b: 
	li $v0,1		#prints value of $a0 when syscall
	move $a0,$t1		#stores $t1 to $a0
	syscall
	srl $t2,$t2,1		#moves the '1' mask to the next bit
	addi $t3,$t3,-1		#-1 from the loop counter
	bne $t3,$zero,loop_b	#if the loop counter is not '0' it returns to the loop
	
	li $v0,4		#prints string in $a0
	la $a0,space		#loads space to $a0
	syscall
	
print_c:
	li $v0,1		#prints value of $a0 when syscall
	move $a0,$t4		#stores $t4 to $a0
	syscall	
	
	li $v0,4		#prints string in $a0
	la $a0,space		#loads space to $a0
	syscall		
	
d:	beq $t5,$zero,pre
	addi $t6,$t5,1		#sets $t6 as $t5 (the prior loop '1' counter) + '1'
	bne $t4,$t6,wrong

ok:	li $v0,4		#prints string in $a0
	la $a0,ans1		#stores the ans1 address to $a0
	syscall

pre:	#a label for the first number which doesnt print ok\wrong
	move $t5,$t4		#stores $t4 (the amount of '1's) to $t5
	j main			#returns to the start of the over loop
				
exit:	li $v0, 10		# Exit program
	syscall

wrong:	#this label is after "exit" because there's a chance it won't be used at all!
	li $v0,4		#prints string in $a0
	la $a0,ans2		#stores the ans2 address to $a0
	syscall
	j pre			#returns to the pre label
