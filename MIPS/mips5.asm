.data
77777
.text
	addi $s0, $zero,10
	addi $s1, $zero,4
	
	mul $t0,$s0,$s1
	
	#$t0 = $s0 * $s1
	#display the product
	
	li $v0,1
	add $a0,$zero,$t0
	
	syscall
	