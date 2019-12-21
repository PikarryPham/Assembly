.data
	msg: .asciiz "The quotient is: \n"
	msg1: .asciiz "The remain is: \n"

.text
	la $a0,msg
	la $a1, msg1
	
	addi $t0, $zero, 12
	addi $t1, $zero, 5
	
	div $t0, $t1
	mflo $s0 #quotient
	mfhi $s1 #remain
	
	li $v0,4
	syscall
	
	li $v0,1
	add $a0, $zero, $s1
	syscall
	
	move $a0,$a1
	li $v0,4
	syscall
	
	move $s1, $s0
	li $v0,1
	add $a0, $zero, $s1
	syscall
	
	li $v0, 10
	syscall
	