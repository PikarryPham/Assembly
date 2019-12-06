.model small
.stack 100h
.data
msg1 db "ENTER THE FIRST NUMBER is greater than THE SECOND NUMBER: $"
msg2 db 0ah, 0dh,"ENTER THE SECOND NUMBER: $"
msg3 db 0ah,0dh, "CAN'T DIVIDE BY 0 $"
;msg3 db 0ah, 0dh,"RESULT: $"

a db ? ; nen set la ? phong TH nhan qua lon, khac vs phep cong va tru ta de 0 thoi
b db ?
;result db ? 
q db ?
r db ?
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
	mov ah,1 ;ham doc ki tu luu duoi ax, ma no luu duoi dang 8 bit -> bit thap --> luu so moi nhap vao duoi al
	int 21h
	sub al, '0'	;cai minh nhap vao la ki tu, method nay la de chuyen tu ki tu sang 1 so
	mov a,al	;chuyen gia tri al vao a
	;mov ax, offset a
    ;
	
	;hien thi msg2 ra man hinh
	mov ah, 9
	lea dx, msg2
	int 21h
	
	; nhap vao so b
	mov ah,1 ;ham doc ki tu luu duoi ax, ma no luu duoi dang 8 bit -> bit thap --> luu so moi nhap vao duoi al
	int 21h
	
	
	sub al, '0' ;cai minh nhap vao la ki tu, method nay la de chuyen tu ki tu sang 1 so ;tuong tu nhu viec ta gan sub al,30h
	mov b,al
	mov bl,b ;khong dung thanh bl nhieu, nen ta gan gia tri bl = b
	
	cmp bl,0d
	je outct
	
	
	and ax, 0000h ;chuyen thanh ghi ax thanh mot doan 0000 ( 00 for al, and 00 for ah)
	mov al, a
	;phep chia
	div bl ;bay gio ta co al = a, bl = b, ta se lay a/b
	
	
	mov q,al
	mov r,ah
	
	mov dl,q ;xuat ki tu thi phai dua sang thanh dl
	add dl,48 ;hien thi tu ki tu sang so
	mov ah,2
	int 21h
	
	mov dl,r
	add dl,48
	mov ah,2
	int 21h
	
	mov ah,4ch
	int 21h
	
	
	outct:
	   mov ah,9
	   lea dx,msg3
	   int 21h
	   
	   mov ah,4ch
	   int 21h 
main endp
end main
