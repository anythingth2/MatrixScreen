    .model  tiny
    
    .data   
_Matrix    struc
    x   db  ?
    y   db  ?
    len db  ?    
    _Matrix ends

matrix   _Matrix    <80>
    .code
    
    org     0100h
    
main:
    mov     dh,03h
    mov     dl,6h
    call    random_number

    mov     ah,0ah
    mov     al,'P'
    mov     bh,0h
    mov     cx,0h
    mov     cx,dx

    int     10h



    ret


random_number:              ;random number from dh to dl
    push    dx
    mov     ah,2ch          ;call get system interrupt
    int     21h             ;to dx
    
    mov     ax,dx           ;store system time to ax
    pop     dx              ;pop [from,to] -> dx

    mov     cx,0h
    sub     dl,dh           ;to - from
    mov     cl,dl           ;store answer to cl
    push    dx              ;push [from,to]
    mov     dx,0h           ;clear dx for dividend
    div     cx              ;divide

    pop     cx              ;pop [from,to] -> cx

    mov     cl,ch
    mov     ch,0h
    
    add     dx,cx


exit:
    ret
end main