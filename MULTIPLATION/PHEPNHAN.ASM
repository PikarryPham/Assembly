.model small
.stack 100h
.data

msg1 db 0ah, 0dh,"ENTER THE FIRST NUMBER: $"
msg2 db 0ah, 0dh,"ENTER THE SECOND NUMBER: $"
msg3 db 0ah, 0dh,"RESULT: $"

a db ? ; nen set la ? phong TH nhan qua lon, khac vs phep cong va tru ta de 0 thoi
b db ?
result db ? 
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
	sub al, 30h
	mov a,al
	
	;hien thi msg2 ra man hinh
	mov ah, 9
	lea dx, msg2
	int 21h
	
	; nhap vao so b
	mov ah,1
	int 21h
	sub al,30h ; vi trong bang ascii, vi du t nhap so 5 trong do se la 35
	;lay 35 - 30 ta ra duoc 5 la so ta vua nhap
	mov b,al
	
	;nhan 2 so
	mul a
	
	
	mov result, al
	AAM ; ;ASCII Adjust After Addition
	
	add ah, 30h
	add al, 30h
	
	
	mov bx,ax ;storing value of ax register to bx register
	
	;hien thi msg3 ra man hinh
	mov ah,9
	lea dx, msg3
	int 21h
	
	;one is for bl register
	mov ah,2
	mov dl,bh
	int 21h
	;one is for bh register
	mov ah,2
	mov dl,bl
	int 21h
	
	mov ah, 4ch
	int 21h 
	main endp
	end main 