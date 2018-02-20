    .model  tiny
    ; .stack  0100h

    .data   
i       db      0
j       db      0       

    .code
    
    org     0100h
    
main:


random_number:              ;random number from dh to dl
    push    ax              ;backup value ax
    push    cx              ;backup value cx
    
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
    
    add     dx,cx           ;ret random number to dx

    pop     cx              ;give value back
    pop     ax

    ret

exit:
    ret


end main