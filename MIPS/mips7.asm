#vietct kiem tra xem so nay co phai la so palindrome hay khong
#su dung:
# $t1 cho a
# $t2 cho b
# $t3: ki tu o address a
# $t4: ki tu o address b
# $v0: return values
# $a0: syscall para
# $a1: syscall para
.data
	strspace: .space 1024 #reserve 1024 bytes for the string
	ispalin_msg: .asciiz "The string is a palindrome \n"
	notpalin_msg: .asciiz "The string is not a palindrome \n"
.text
	#read the string S
	la $a0, strspace
	li $a1, 1024 
	li $v0, 8 #load "read_string" code into $vo
	syscall
	
	la $t1,strspace #a = s
	la $t2,strspace #need to move b to the end of string
lengthloop:
	lb $t3, ($t2) #load the byte at address b into $t3
	beqz $t3, endloop #if $t3 == 0 -> out loop
	addu $t2, $t2, 1 #otherwise, increment b
	b lengthloop #repeat the loop
endloop:
	subu $t2,$t2,2
testloop:
	bge $t1,$t2,ispalin #if a>=b, it's palindrome
	lb $t3, ($t1) #load the byte at address a into $t3
	lb $t4, ($t2) #load the byte at address b into $t4
	bne $t3, $t4, notpalin #if $t3 != $t4 ==> not palindrome
	#con neu khong
	addu $t1,$t1,1 
	subu $t2,$t2,1 #decrement b
	b testloop #and repeat the loop
ispalin:
	la $a0, ispalin_msg
	li $v0, 4
	syscall 
	b exit
notpalin:
	la $a0, notpalin_msg
	li $v0,4
	syscall
	b exit
exit:
	li $v0, 10
	syscall

	
	

	
