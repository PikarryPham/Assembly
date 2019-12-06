.MODEL SMALL
.STACK 100h
.DATA
msg1 db 0ah,0dh,"ENTER THE FIRST NUMBER: $"
msg2 db 0ah, 0dh,"ENTER THE SECOND NUMBER: $"
msg3 db 0ah, 0dh,"RESULT: $"
msg4 db 0ah,0dh,"Can't divide by 0 $"   
msg db 0ah,0dh,"The current time is: $"
num db 10d
a db 0
b db 0
q db 0
r db 0
result db 0
.code
	mov ax,@data
	mov ds,ax
	
	call nhapsoa
	call nhapsob
	call phepcong
	call xuat2chuso
	call pheptru
	call phepnhan
	call xuat2chuso
	
	call phepchia
	
	call timing
	;call xuattime
	call 
	
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
        mov ah,9
		lea dx,msg2
		int 21h
		
		mov ah,1
		int 21h
		mov b,al
		ret
	nhapsob endp
	phepcong proc
		mov al,b
		add al,a 
		mov ah,0
		aaa
		ret
	phepcong endp
	pheptru proc
	    ;vi truoc do al da co gia tri, nen neu lay gia tri do
	    ;cong tiep cac kieu vs 48 hay tru ==> sai
	    
	    ;bay gio gan al = b, sau do ta so sanh a vs al = b
	    mov al,b
	    cmp a,al
	    ja truraduong; a> b
	    
	    sub al,a
	    add al,48
	    
	    mov bl,al
	    
	    mov ah,9
	    lea dx, msg3
	    int 21h 
	
    
	    mov ah,2
	    mov dl,'-'
	    int 21h 
	
	    mov ah,2
	    mov dl,bl
	    int 21h  
	    ret 
	    truraduong:
	       mov al,a
	       sub al,b
	       
	       add al,48
	
	       mov bl,al
	       
	       mov ah,9
	       lea dx, msg3
	       int 21h
	
	       mov ah,2
	       mov dl,bl
	       int 21h 
	       ret
	
	pheptru endp
	phepnhan proc
	   
	    mov al,a
	    sub al,48
	    
	    mov dl,b
	    sub dl,48
	    
	    mul dl
	    ;mov result,al
	    AAM
	    
	    ret
	phepnhan endp
	phepchia proc
	    mov ax,0000h
	    mov al,a
	    sub al,48
	    
	    ; al = a - 48
	    mov cl,b
	    sub cl,48
	    ; dl = b - 48
	    cmp cl,0
	    je outct
	    
	   
	    div cl
	    
	    
	    ;mov ah,9
	    ;lea dx, msg3
	    ;int 21h
	    
	    
	    mov q,al
	    mov r,ah
	    mov cl,q
	    add cl,48
	    
	    
	    mov ah,9
	    lea dx, msg3
	    int 21h
	    
	    
	    mov ah,2 
	    mov dl,cl ;xuat ki tu thi phai dua sang thanh dl
	    int 21h
	    
	    mov cl,r
	    add cl,48
	    mov ah,2
	    mov dl,cl ;xuat ki tu thi phai dua sang thanh dl
	    int 21h
	    ret
	    outct:
	        mov dx,offset msg4
	        mov ah,9
	        int 21h 
	    
	    ret
	phepchia endp
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
    timing proc
      mov ah,9
      lea dx,msg
      int 21h
      
      mov ah,2ch ;get time
      int 21h
      
      mov dl,ch
      call xuattime
      
      mov ah,2h
      mov dl,':'
      int 21h
      
      
      mov dl,cl
      call xuattime
      
       
      mov ah,2h
      mov dl,':'
      int 21h 
      
      mov dl,dh
      call xuattime
      
        
    ret
    timing endp
    xuattime proc
        
        push bx
        push ax            

        xor ax, ax         ;AX = 0
        mov al, dl         ;AX = DL
 
        div num  ;AL = AX/10 (phan thuong), phan du nam trong AH = AX%10
        ;AX contains the digits

        ;Transform digit to digitals 
        add ax,3030h



        mov bx, ax         ;Save for later 
        mov dl, bl
        mov ah, 2h
        int 21h
        mov dl, bh
        mov ah, 02h
        int 21h

        pop ax
        pop bx
        ret
        xuattime endp
    end
	
