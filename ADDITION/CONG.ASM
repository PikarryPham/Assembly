.model small
.stack 100h
.data

msg1 db 0ah,0dh,"ENTER THE FIRST NUMBER: $"
msg2 db 0ah, 0dh,"ENTER THE SECOND NUMBER: $"
msg3 db 0ah, 0dh,"RESULT: $"

a db 0
b db 0
result db 0 
.code
	;data segment
	mov ax, @data
	mov ds, ax
	
	;hien thi msg1 ra man hinh
	mov ah, 9 ;bieu dien chuoi ki tu
	lea dx, msg1 ;using pointers in languages such as C, work fine if msg1,msg2,msg3 is local variable
	;mov dx, msg1 ; su dung nay se bi loi "Operand type not match"
	int 21h
	
	;nhap vao so a
	mov ah,1; nhap 1 ki tu luu vao AL
	int 21h
	mov a,al
	
	;hien thi msg2 ra man hinh
	mov ah, 9 ;bieu dien chuoi ki tu
	lea dx, msg2
	;mov dx, msg2
	int 21h
	
	; nhap vao so b
	mov ah,1 ;ham doc ki tu
	int 21h ;thuc hien line feed
	mov b,al
	
	;cong 2 so
	add al,a 
	call xuathaichuso
	
	mov ah, 4ch
	int 21h 
	xuathaichuso proc
	;xuat hai chu so:
	mov ah, 0 ;ax = al + ah (al = low bit, ah = hight bit vd: 5 x 2 = 10 ==> al = 1, ah = 0
	aaa ;ASCII Adjust After Addition
	
	add al,48
	add ah,48
	
	mov bx,ax ;storing value of ax register to bx register
	
	;hien thi msg3 ra man hinh
	mov ah,9
	lea dx, msg3
	;mov dx,msg3
	int 21h
	
	;one is for bl(low) register
	mov ah,2 ;xuat ki tu o bit thap ra man hinh
	mov dl,bh
	int 21h
	;one is for bh(high) register
	mov ah,2 ;;xuat ki tu o bit cao ra man hinh
	mov dl,bl
	int 21h
    ret
    
    xuathaichuso endp
	
	end 
	