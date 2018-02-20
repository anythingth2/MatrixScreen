    .model  tiny
    ; .stack  0100h

    .data   
iLoopPFM            dw      0   ; For Loop in printFlowMatrix
matrixColorCode     db      00000000b,00000000b,00001010b,00000010b,00001010b,00001010b,00000010b,00001010b,00000010b,00001010b,00000010b,00001010b,00000010b,00000010b,00001000b,00001111b
matrixY             db      80  dup(0)
i           db  0
seed        dw  13

num_Matrix  db  80



    .code
    
    org     0100h
    
main:
    mov     ah,00
    mov     al,03h
    int     10h
init_all_matrix:
    mov     cx,0h
    mov     cl,num_Matrix                   ;set number of for loop running
loop_init_all_matrix:
    mov     dh,64h                          ;random number (100,150)
    mov     dl,96h
    call    random_number
    
    mov     si,cx
    mov     matrixY[si],dl                  ;store random number to matrixY
            
    loop    loop_init_all_matrix 

    mov     dh,4h
    mov     dl,6h
    call    random_number
    
    mov     si,cx
    mov     matrixY[si],dl

main_loop:
    
    call    update_all_matrix
    
    call    sleep
    jmp     main_loop

    ret

;===== LOOP_printFlowMatrix =====
printFlowMatrix:            ;print Matrix Flow
    ;require   al,ah
    ;
    
    push    cx
    mov     cx,15           ;print Matrix length is 15 character
loop_printFlowMatrix:

  
    sub     al,1h
    cmp     al,0                ;if character not in screen
    jge     ifGreaterThan0      ;will not print

EndIfGreaterThan0:
    loop    loop_printFlowMatrix

    mov     dh,al
    mov     dl,ah
    push    si
    push    cx
    
    mov     si,cx

    mov     bl,matrixColorCode[si]          ;set character color
    pop     cx
    pop     si
    call    printCharAt                     ;print character to screen at row,column

    pop     cx
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
    push    si
    push    cx

    mov     si,cx

    mov     bl,matrixColorCode[si]          ;set character color
    pop     cx
    pop     si
    call    printCharAt                     ;print character to screen at row,column
    jmp     EndIfGreaterThan0           
;#### End If in printFlowMatrix ####

;===== EndLOOP_printFlowMatrix =====
 

update_all_matrix:                          ;move matrix down
    mov     cx,80                       
loop_update_all_matrix:
    
    mov     si,cx                           ;make si to index point "i"

    add     matrixY[si],1      
    cmp     matrixY[si],40                  ;if matrix[i] < 40
    jl      ifLessThan40
    je      ifEqual40
endIfLessThan40:

    
    loop    loop_update_all_matrix

    ret


ifLessThan40:
    ;PRINT_FLOW_MATRIX
    
    mov     ax,cx
    mov     ah,al
  
    mov     al,matrixY[si]

    call    printFlowMatrix

    jmp     endIfLessThan40
ifEqual40:
  
    push    dx
    mov     dh,0
    mov     dl,50
    call    random_number           ;if head matrix on botton screen
                                    ;start new matrix

    neg     dl
    mov     matrixY[si],dl

    pop     dx
    jmp     endIfLessThan40

random_number:              ;random number from dh to dl
    
    push    ax              ;backup value ax
    push    cx              ;backup value cx
    

    push    dx

    mov     ax,seed
    mov     cx,13
    mul     cx
    add     ax,23
    mov     seed,ax
    
    
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
printCharAt:                ;print random character at position (dh = row,dl = column)
                            ;with color ( bl = color code)
    ; call    test_print
    push    ax
    push    cx

    mov     ah,02h                          
    mov     bh,0h                           ;move cursor
    int     10h                             ;call move cursor interrupt                                     

    mov     dh,48
    mov     dl,126
    call    random_number                   ;random character decimal number


    mov     ah,09h                          ;print character
    mov     al,dl                           ;store character
    mov     bh,0h                         
    mov     cx,1h
    int     10h                             ;call print character interrupt

    pop     cx
    pop     ax

    ret

sleep:
    push    cx
    mov     cx,0ffffh
loop_sleep:
    nop                                     ;do nothing
    loop    loop_sleep                 ;loop until cx is zero
    pop     cx
    ret

exit:
    ret


end main