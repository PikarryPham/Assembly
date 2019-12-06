.MODEL SMALL
.STACK 100h
.DATA
msg1 db 0ah,0dh,"ENTER THE FIRST NUMBER: $"
msg2 db 0ah, 0dh,"ENTER THE SECOND NUMBER: $"
msg3 db 0ah, 0dh,"RESULT: $"

a db 0
b db 0
result db 0
.code
	mov ax,@data
	mov ds,ax
	
	call nhapsoa
	call nhapsob
	call phepcong
	call xuat2chuso
	
	mov ah, 4ch
	int 21h
	nhapsoa proc
		mov ah,9
		lea dx,msg1
		int 21h
		
		mov ah,1
		int 21h
		mov a,al
	ret
	nhapsoa endp
	nhapsob proc
	
		move ah,9
		lea dx,msg2
		int 21h
		
		mov ah,1
		int 21h
		mov b,al
	ret
	nhapsob endp
	phepcong proc
		add al,a
		aaa
	ret
	phepcong endp
	
	xuat2chuso proc
		add al,48
		add ah,48
	
		mov bx,ax 
		mov ah,9
		lea dx, msg3
		int 21h
		
		mov ah,2 
		mov dl,bh
		int 21h
	
		mov ah,2 
		mov dl,bl
		int 21h
    ret
	
	xuat2chuso endp
	end
