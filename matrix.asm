    .model  tiny
    ; .stack  0100h

    .data   
_Matrix    struc
    x   db  10h
    y   db  10h
    len db  10h  
    _Matrix ends

matrix      _Matrix    <5>
temp_matrix     _Matrix <0>
    i   db  0

num_Matrix  db  5h

    .code
    
    org     0100h
    
main:
    

    lea     bx,matrix[0]
    mov     [bx],8h
    inc     bx
    mov     [bx],8h
    inc     bx
    mov     [bx],3h
    

    
    lea     bx,matrix[0]
    add     bx,1h
    mov     cx,[bx]
    call    test_print
    ; ret


    ret
init_all_matrix:
   

    mov     cx,0h
    mov     cl,num_Matrix                   ;set number of for loop running



loop_init_all_matrix:

    call    init_matrix

    ; lea     bx,matrix.x

        
    loop    loop_init_all_matrix 

    ret

test_print:
    push    bx
    mov     dx,bx
    mov     ah,0ah
    mov     al,'P'
    mov     bh,0h

    int     10h

    pop     bx
    ret
init_matrix:
    mov     dh,0h                   ;random number between 0 to 80
    mov     dl,50h
    call    random_number

    mov     [temp_matrix.x],dl      ;store random(0,80) to temp_matrix.x


    mov     dh,64h
    mov     dh,96h
    call    random_number           ;random number between 100 to 150

    mov     [temp_matrix.y],dl      ;store random(100,150) to temp_matrix.y

    mov     dh,0ah              
    mov     dl,14h
    call    random_number           ;random number between 10 to 20

    mov     [temp_matrix.len],dl    ;store random(10,20) to temp_matrix.len
    
    ret

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