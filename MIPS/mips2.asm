.data
	name: .asciiz "My name is Trang \n"
	id: .asciiz "My ID is 18127022 \n"
	GPAHK2: .double 8.5
	zeroDouble: .double 0.0
.text
	main:
	la $a0,name
	la $t0,id
	ldc1 $f2,GPAHK2
	ldc1 $f0,zeroDouble
	
	#print the first line "My name is Trang"
	li $v0,4
	syscall
	
	move $a0,$t0
	li $v0,4
	syscall
	
	li $v0,3
	add.d $f12,$f2,$f0 #floating point addition double precision
	syscall
	
	li $v0,10 #ket thuc chuong trinh
	syscall