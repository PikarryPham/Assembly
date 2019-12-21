.data
	msg: .asciiz "My month date is: "
.text
main:
	li $v0,4 #sytem call code for print_str
	la $a0,msg #address of string to print
	syscall #print msg
	
	
	li $v0,1 #system call for print an integer
	la $a0,10
	syscall
	
	li $v0,10 #exit khoi chuong trinh
	syscall  