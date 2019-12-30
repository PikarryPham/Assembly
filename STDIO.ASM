.Model Small
.Code
	ORG 100h
Start:
	jmp Main
	ChuSo DB '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'

XuatSoHeBX Proc
	xor	CX, CX
LayChuSo:
	xor	DX, DX
	div	BX
	push	DX
	inc	CX
	or	AX, AX
	jnz	LayChuSo

	mov	AH, 2
XuatChuSo:
	pop	BX
	mov	DL, ChuSo[BX]
	int	21h
	loop	XuatChuSo
	ret
XuatSoHeBX EndP

NhapSoHeBX Proc
	xor	AX, 0
NhapKyTu:
	push	AX
	mov	AH, 1
	int	21h
	cmp	AL, 13
	je	NhapXong
	mov 	CL, AL
	pop 	AX
	mul 	BX
	xor	CH, CH
	sub 	CL, '0'
	add	AX, CX
	jmp	NhapKyTu
NhapXong:
	pop 	AX
	ret
NhapSoHeBX EndP

Main:
	mov bx,10
	call NhapSoHeBX
	mov bx,2
	call XuatSoHeBX
	int 20h
End Start