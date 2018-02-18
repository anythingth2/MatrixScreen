    .model  tiny
    
    .data   
rect    struc
    left    db  ?
    right   db  ?
    rect    ends

a   rect    <5>
    .code
    
    org 0100h
    
main:   

    mov [a.left],10h


    cmp [a.left],10h
    ; jne  exit

    mov ah,02h
    mov dh,3h
    mov dl,3h
    int 10h

    mov ah,0Ah
    mov al,'p'
    mov cx,5
    int 10h

exit:
    ret
end main