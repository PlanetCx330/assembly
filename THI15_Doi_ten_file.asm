.model small
.stack 100h
.data 
      tb1 db 'Nhap ho ten sinh vien: $'
      ten db 100 dup('$')
      hoten db 'TRAN THI THANH$'
      tb2 db 10,13, 'Nhap sai ho ten!$'
      tb3 db 10,13, 'MaSV la: AT160346$'
      dem dw 0
      tb4 db 10,13, 'Nhap ten file: $'
      tencu db 100 dup(?),'$'
      tb5 db 10,13, 'Ten moi: $'
      tenmoi db 100 dup(?),'$'
  
.code
main proc
      mov ax,@data
      mov ds,ax
      mov es,ax
      
      mov ah,9
      lea dx,tb1
      int 21h
      
      mov ah,10
      lea dx,ten
      int 21h
      
      lea si,ten+2
      lea di,hoten
      mov cx,0
lap:      
      mov dx,0
      mov ax,0
      mov al,[si]
      mov dl,[di]
      cmp dl,'$'
      je  kiemtra
      cmp al,'a'
      jl  tiep
      cmp al,'z'
      jl  chuyenHoa  
tiep:
      inc cx
      cmp al,dl
      je  cong
      inc si
      inc di
      jmp lap
      
chuyenHoa:
      sub al,32
      jmp tiep
cong:
      inc dem
      inc si
      inc di
      jmp lap
      
kiemtra:
      cmp cx,dem
      je  hienCo
      jne sai
hienco:
      mov ah,9
      lea dx,tb3
      int 21h
      jmp caub          
sai:
      mov ah,9
      lea dx,tb2
      int 21h
      jmp ketthuc
caub: 
      mov ah,9
      lea dx,tb4
      int 21h

      lea si,tencu
      mov cx,0
      
      call nhap
      
      mov ah,9
      lea dx,tb5
      int 21h
      
      lea si,tenmoi
      mov cx,0
      
      call nhap
            
      mov ah,56h    ; doi ten file
      lea dx,tencu
      lea di,tenmoi
      int 21h
ketthuc:      
      mov ah,4ch
      int 21h           
main endp

nhap proc
      mov ah,1
      int 21h
      cmp al,13
      je  thoat
      mov [si],al
      inc si
      inc cx
      jmp nhap
      
thoat:
      ret
nhap endp
end