# Title: b.s        	Filename:b.s
# Author: Bar Furman - 208533406     	Date:15.12.22
# Description: user input selects a number in octa from a list and it prints '&' times the octa in deci
# Input: a number between 1-12, 0 for exit
# Output: n times '&'
################# Data segment #####################
.data
string: .ascii "35  22  77  74  06  45  32  15  52  21  55  63"
msg1: .asciiz "\nEnter a number between 1-12:\n"
msg2: .asciiz "\n-Input Not_Valid-\n"
simbol: .asciiz "&"
################# Code segment #####################
.text
not_valid:
	li $v0,4			#prints string in $a0
	la $a0,msg2			#loads space to $a0
	syscall
	j main				#return to the main loop
	
.globl main
main:	# main program entry
	li $v0,4			#prints string in $a0
	la $a0,msg1			#loads space to $a0
	syscall
	li,$v0,5			#reads int to $v0
	syscall
	move $t0,$v0			#stores $a0 to $t0 for later use

#checks if the input is valid or '0' to exut program
	beq $v0,$zero,exit
	bgt $t0,12,not_valid	
	blt $t0,1,not_valid

	mul $t0,$t0,4			#mul the input by 4
	subi $t0,$t0,4			#sub 4 from the input
	lwr $t1,string($t0)		#loads the right 4 bytes starting at the input location of the string

	andi $t2,$t1,0xf		#extract the first hexa number from $t1 to $t2 - will be the 10's digit
	andi $t3,$t1,0xf00		#extract the third  hexa number from $t1 to $t3 - will be the 1's digit
	divu $t3,$t3,0x100		#moves the third bit to the first at $t3
	
	mul $t2,$t2,8			#converts from octa to dec - returns in hexa
	add $t4,$t3,$t2			#adds the 10's and the 1's digits to $t4

print_loop:
	li $v0, 4			#prints string in $a0
	la $a0, simbol			#loads '&' to $a0
	syscall
	subi $t4,$t4,1			#subs '1' from the loop counter
	bne $t4,$zero,print_loop	#if the loop counter is not '0' it returns to the start of the loop
	j main				#returns to the main loop
	
					
exit:	li $v0, 10			# Exit program
	syscall
