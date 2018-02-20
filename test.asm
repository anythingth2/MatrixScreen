    .model  tiny
    ; .stack  0100h

    .data   
iLoopPFM            dw      0   ; For Loop in printFlowMatrix
matrixColorCode     db      0fh,08h,0Ah,02h,0Ah,0Ah,02h,0Ah,02h,0Ah,02h,0Ah,02h,02h,00h
matrixY             db      80  dup(0)
i           db  0

num_Matrix  db  80



    .code
    
    org     0100h
    
main:
    

   
    ret
printFlowMatrix:        ;ah = axis x
                        ;al = axis y
    mov     cx,15
loop_printFlowMatrix:

  
    sub     al,1h
    cmp     al,0
    jge     ifGreaterThan0

EndIfGreaterThan0:
    loop    loop_printFlowMatrix

    mov     dh,0
    mov     dl,ah

    call    printCharAt
    ret
ifGreaterThan0:
    cmp     al,25
    jl      ifLessThan25
    jmp     EndIfGreaterThan0
EndIfGreaterThan25:

    jmp     EndIfGreaterThan0
ifLessThan25:
    mov     dh,al
    mov     dl,ah

    call    printCharAt
    jmp     EndIfGreaterThan0
printCharAt:                ;print random character at position (dh = row,dl = column)
                            ;with color ( bl = color code)
    push    ax

    push    cx
    

    mov     ah,02h                          
    mov     bh,0h                           ;move cursor
    int     10h                             ;call move cursor interrupt                                     

    mov     dh,33
    mov     dl,126
    call    random_number                   ;random character decimal number


    mov     ah,0Ah                          ;print character
    mov     al,dl                           ;store character
    mov     bh,0h                         
    mov     cx,1h
    int     10h                             ;call print character interrupt

    pop     cx
    pop     ax

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
test_print:
    push    ax
    push    dx

    mov     ah,0Ah
    mov     al,'I'
    int     10h

    mov     ah,02h
    mov     dl,0h
    int     10h

    push    dx
    pop     ax
end main