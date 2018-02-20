    .model  tiny
    ; .stack  0100h

    .data   
iLoopPFM            db      0   ; For Loop in printFlowMatrix
matrixColorCode     db      0fh,08h,0Ah,02h,0Ah,0Ah,02h,0Ah,02h,0Ah,02h,0Ah,02h,02h,00h
matrixY             db      80  dup(0)
    .code
    
    org     0100h
    
main:
    push    ax
    push    bx
    push    cx
    push    dx

; go to function printFlowMatrix    
    mov     ax,0
    mov     ah,x    ;;PFM(int x,int matrixY)
    mov     al,matrix_y

    call    printFlowMatrix

    pop     dx
    pop     cx
    pop     bx
    pop     ax

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
    push    ax
    push    bx
    push    cx
    push    dx

    call    setTestColorAndPrint
    
    pop     dx
    pop     cx
    pop     bx
    pop     ax

    ret
Exit_If:
    ret
;#### End If in printFlowMatrix ####

;===== EndLOOP_printFlowMatrix =====

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