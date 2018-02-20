    .model  tiny
    ; .stack  0100h

    .data   
iLoopPFM            db      0   ; For Loop in printFlowMatrix
matrixColorCode     db      0fh,08h,0Ah,02h,0Ah,0Ah,02h,0Ah,02h,0Ah,02h,0Ah,02h,02h,00h
matrixY             db      80  dup(0)
i           db  0

num_Matrix  db  5h
matrixY     db  80  dup(0)


    .code
    
    org     0100h
    
main:
   

    
    
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



    ret

;===== LOOP_printFlowMatrix =====
printFlowMatrix:            ;For loop i<15
    sub     al,iLoopPFM

    call    If_printFlowMatrix:

    add     iLoopPFM,1
    cmp     iLoopPFM,15
    je      exit_LoopPrintFlowMatrix

    jmp     printFlowMatrix
    ret

exit_LoopPrintFlowMatrix:
    ret
;#### If in printFlowMatrix ####
If_printFlowMatrix:
    cmp     al,1
    jg      SecondIf_printFlowMatrix

    jl      Exit_If
    ret
SecondIf_printFlowMatrix:
    cmp     al,25
    jl      If_condition

    jg      Exit_If
    ret
If_condition:
  
    push    bx
    push    cx
    push    dx

    push    si
    mov     dh,al
    mov     dl,ah
    mov     si,[iLoopPFM]
    mov     bl,matrixColorCode[si]
    call    printCharAt
    
    pop     si
    pop     dx
    pop     cx
    pop     bx


    ret
Exit_If:
    ret
;#### End If in printFlowMatrix ####

;===== EndLOOP_printFlowMatrix =====
 

update_all_matrix:
    mov     cx,0h
    mov     cl,[num_Matrix]
loop_update_all_matrix:
    mov     si,cx                           ;make si to index point "i"

    cmp     matrixY[si],150                 ;if matrix[i] < 150
    jl      ifLessThan150
    jge     ifNotLessThan150
endIfLessThan150:


    cmp     matrixY[si],40                  ;if matrix[i] < 40
    jl      ifLessThan40
    je      ifEqual40
endIfLessThan40:

    loop    loop_update_all_matrix
    ret

ifLessThan150:
    inc     matrixY[si]                     ;matrix[i]++;
    jmp     endIfLessThan150
ifNotLessThan150:
    mov     matrixY[si],0h                  ;matrix[i]=0
    jmp     endIfLessThan150

ifLessThan40:
    ;PRINT_FLOW_MATRIX
    mov     ah,si
    mov     al,matrixY[si]
    jmp     endIfLessThan40
ifEqual40:
    mov     matrixY[si],40
    jmp     endIfLessThan40

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


    mov     ah,09h                          ;print O
    mov     al,dl                           ;store character
    mov     bh,0h                         
    mov     cx,1h
    int     10h                             ;call print character interrupt

    pop     cx
    pop     ax

    ret
exit:
    ret


end main