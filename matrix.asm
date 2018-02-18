    .model  tiny
    
    .data   
_Matrix    struc
    x   db  ?
    y   db  ?
    len db  ?    
    _Matrix ends

matrix      _Matrix    <80>
temp_matrix     _Matrix <0>
    .code
    
    org     0100h
    
main:

    mov     dx,0h
    sub     dx,50h

    sub     dx,1h
    not     dx

    call    test_print
    ret

init_all_matrix:
    mov     dh,0h                   ;random number between 0 to 80
    mov     dl,50h
    call    random_number

    mov     [temp_matrix.x],dl      ;store random(0,80) to temp_matrix.x


    
    



    

test_print:
    mov     ah,0ah
    mov     al,'P'
    mov     bh,0h
    mov     cx,0h
    mov     cx,dx

    int     10h
    ret
init_matrix:
    

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
    ret
exit:
    ret
end main