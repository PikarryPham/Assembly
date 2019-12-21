.data
	num1: .word 26
	num2: .word 10
.text
	lw $s0, num1($zero)
	lw $s1, num2($zero)
	
	sub $s2, $s0, $s1 #$s2 = $s1 + $s0
	
	li $v0,1
	add $a0, $zero, $s2
	syscall