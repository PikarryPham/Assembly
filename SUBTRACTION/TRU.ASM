.model small
.stack 100h
.data

msg0 db "RULES: the first number is smaller than the second one"
msg1 db "ENTER THE FIRST NUMBER: $"
msg2 db 0ah, 0dh,"ENTER THE SECOND NUMBER: $"
msg3 db 0ah, 0dh,"RESULT: $"

a db 0
b db 0
result db 0 
.code
main proc
	;data segment
	mov ax, @data
	mov ds, ax
	
	;hien thi msg1 ra man hinh
	mov ah, 9
	lea dx, msg1
	int 21h
	
	;nhap vao so a
	mov ah,1
	int 21h
	mov a,al
	
	;hien thi msg2 ra man hinh
	mov ah, 9
	lea dx, msg2
	int 21h
	
	; nhap vao so b
	mov ah,1 ;ham doc ki tu
	int 21h ;thuc hien line feed
	mov b,al
	
	mov cl,b
	cmp a,cl ;cf = 0
	ja truraam ;a>b
	
	SUB al,a ;b-a
	
	add al,48
	mov bl,al
	;khi debu toi msg3, dong int 21h thi gia tri al bi thay doi sai
	;gan bl = al de gia tri no k bi anh huong
	;hien thi msg3 ra man hinh
	mov ah,9
	lea dx, msg3
	int 21h 
	
    
	mov ah,2
	mov dl,'-'
	int 21h 
	
	;one is for bl register
	mov ah,2
	mov dl,bl ;dl = bl ma bl = al luc nay
	int 21h 
	
	mov ah, 4ch
	int 21h 
	
	truraam:
		mov al,a
		SUB al,b
	
	add al,48
	
	mov bx,ax ;storing value of ax register to bx register
	
	;hien thi msg3 ra man hinh
	mov ah,9
	lea dx, msg3
	int 21h
	
	
	
	;one is for bl register
	mov ah,2
	mov dl,bl
	int 21h
		
	
	
	
	
	mov ah, 4ch
	int 21h 
	main endp
	end main 
	