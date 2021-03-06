.MODEL SMALL
.stack 100h
.data 
    msg db 0ah,0dh,"The current time is: $"
    num db 10d
    msg1 db 0ah,0dh,"ENTER THE FIRST NUMBER: $"     ;endline db 10,13 ==> db 0ah,0dh
    msg2 db 0ah, 0dh,"ENTER THE SECOND NUMBER: $"
    msg3 db 0ah, 0dh,"RESULT: $"
    msg4 db 0ah,0dh,"Can't divide by 0 $"
    msg5 db 0ah,0dh,"Enter the number in range from 0 to 25 $"
    a db 0
    b db 0
    q db 0
    r db 0
    result db 0
.code
  mov ax,0000h
  mov es,ax
  ;mov al, 00100000b ;numlock
  mov al, byte ptr ES:[417h] ;  
  and al,00100000b		
  
  ;mov cl,al 
  ;mov dl,cl 
  
  mov bl,al
  mov dl,bl
  
  mov ax,0000h
  mov es,ax
  ;mov al, 01000000b ; caplock
  mov al, byte ptr ES:[417h] ;  
  and al,01000000b
  
  ;mov bl,al ;;lat nua se phai thay doi gia tri nen la gan cl = al la gtri cua caplock
  mov cl,al 
   
  ;ca hai cung on ==> ra 1 gia tri khac 0 ==> jnz
  or dl,cl ;so sanh hai ket qua, ket qua cuoi cung chua trong cl
  ;1 trong 2 cai on ==> goi den ham numon
  cmp dl,01100000b ;neu gia tri or = 00110000b thi co nghia la 2 nut deu bat
  ;jnz numon
  je compare01 ;this jump is too too long ==> USE JMP FOR LONG OFFSET
  ;1 trong 2 cai bi off
  ;cmp dl,00000000b
  jne sosanh
compare01:
	jmp compare
sosanh:
 cmp bl,00000000b
 ;jnz numon 
 jnz compare03
 cmp cl,00000000b
 ;jnz capon
 jnz compare02       ;this jump is too too long ==> USE JMP FOR LONG OFFSET
 jmp twoff	;neu nhu ca hai nut deu tat
compare02:
    jmp capon
compare03:
    jmp numon
    ;======================numon========================
capon:
	call @khoitao
	call @xuatmsg
	call in2soa ;nhapsoa
    call @khoitao
    call @xuatmsg
    call in2sob ;nhapsob
    call @ktxuongdong
    call @inhvuong
	mov ah,4ch
	int 21h
in2sob proc ; nhap vao so b 
    
    ;nhap so dau tien
    mov ah,8
    int 21h
    
    @repeatb: ;lap lai viec so sanh xem ki tu moi nhap vao co phai nho hon 0 hoac lon hon 9 hay k, neu co thi lap lai k thi in ra man hinh
    
    cmp al,'0' 
    jb @nextdigit2 ;neu no nho hon 0 thi yeu cau nhap lai
    
    cmp al,'9'
    ja @nextdigit2 ;neu no lon hon 9 thi yeu cau nhap lai
    
    ;nhap dung, hien thi so da nhap
    mov ah,2
    mov dl,al
    int 21h
    ;doi thanh tri va cat vao SI
    and al,0Fh
    cbw
    mov si,ax
    
    ;tinh sum = bx = bx * 10 + si
    mov ax,10
    mul bx ; dx:ax = bx*10 (dx=0>   ;bx = sum = 0
    mov bx,si
    add bx,ax
    
    cmp bx,25
    ja @exit
    ;nhan tiep, neu la enter thi ket thuc
    @nextdigit2:
    
    mov ah,8
    int 21h
    cmp al,13 ;ki tu enter
    jne @repeatb
    
    ;nhap enter ==> ket thuc
    mov ax,bx ; ax chua ket qua
    ;or cx,cx
    mov b,al
    mov bl,b
    ;pop dx
    ;pop cx
    
    
   ret
   in2sob endp    
in2soa proc    
    
    push si ;save gia tri vao trong thanh ghi
    push bx
    ;nhap ki tu dau tien
    mov ah,8
    int 21h
    @repeat2:
    cmp al,'0'
    jb @nextdigit ;neu no nho hon 0 thi yeu cau nhap lai
    cmp al,'9'
    ja @nextdigit ;neu no lon hon 9 thi yeu cau nhap lai
    mov ah,2 ;nhap dung, hien thi so da nhap
    mov dl,al
    int 21h
    ;doi thanh tri va cat vao SI
    and al,0Fh
    cbw
    mov si,ax
    ;tinh sum = bx = bx * 10 + si
    mov ax,10
    mul bx ; dx:ax = bx*10 (dx=0>   ;bx = sum = 0
    mov bx,si
    add bx,ax
    cmp bx,25
    ja @exit
	;ja in2soa
    @nextdigit: ;nhan tiep, neu la enter thi ket thuc
    mov ah,8
    int 21h
    cmp al,13 ;ki tu enter
    jne @repeat2
    ;nhap enter ==> ket thuc
    mov ax,bx ; ax chua ket qua
    ;or cx,cx
    mov a,al
    
    mov cl,a
    pop bx
    pop si
    ret
in2soa endp
@khoitao proc
    mov ax,@data
    mov ds,ax
    ret
@khoitao endp
@xuatmsg proc
    mov ah,9
    lea dx,msg5
    int 21h 
    ret
@xuatmsg endp
@ktxuongdong proc
    mov dl,10  ;ki tu sang dong moi
    mov ah, 2
    int 21h
    mov dl,13 ;ki tu ve dau dong
    mov ah, 2
    int 21h
    ret
@ktxuongdong endp
@inhvuong proc
    L1:
    cmp cl,00
    je @exit
    push cx ; cx = i 
    mov cx, bx ; cx = bx = j
    L2:
    Mov dl, '*'
    mov ah,2
    int 21h
    loop L2 ;cu moi lan goi den ham loop, bien j-- ;;dung loop l2 khi cx = 0 ==> chuyen den xuong duong in endline
    call @ktxuongdong
    pop cx  ;lay ra lai gia tri i truoc do de tru di mot don vi sau moi lan lap L1
    LOOP L1
    ;pop bien i truoc do de i-- va loop L1
    ret
@inhvuong endp
@exit: 
    mov ah,4ch
    int 21h

numon:
	;===================capon========================;
	
	
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
	    ;de code o day no bi anh huong
	    
	    mov q,al
	    mov r,ah
	    mov cl,q
	    add cl,48
	    
	    ;sau khi gan xong xuoi r = ah, q = al thi moi dung dong nay
	    
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
twoff:
    mov ah,2
    mov dl,'0'
    int 21h
    mov ah,4ch
	int 21h
; twoff endp
compare:
 
    ;mov ah,2
    ;mov dl,'1'
    ;int 21h
	call timing
    mov ah,4ch ;ketthuc ct luon
	int 21h
    timing proc
      
      mov ax,@data
      mov ds,ax
      
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
    xuattime proc	;ham xuat time theo dinh dang 00:00:00
        
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