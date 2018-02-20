    .model  tiny
    
    .data   
_Matrix    struc
    x   db  6
    y   db  15
    len db  10    
     _Matrix ends

matrix   _Matrix    <0>
i       db      0       ;Count I
j       db      0       
;numMatrix   db  80

    .code
    
    org     0100h
    
main:

    push    ax
    push    bx
    push    cx
    push    dx

    call printFlowMatrix

    mov     ah,0eh
    mov     al,'M'
    mov     bh,0h
    mov     bl,3

    int     10h

    pop     dx
    pop     cx
    pop     bx
    pop     ax

    ret
;========================= End Main ============================
;========================= Start FlowMatrix =======================

;#### LOOP i ####
printFlowMatrix: 
 ;int y = matrix.y - i
    ; cl is y
    ; dl is i
;;
 ;   mov     ah,0eh
 ;   mov     al,'p'
 ;   mov     bh,0h
 ;   mov     bl,3

 ;   int     10h
;;/
    mov     cx,0h
    mov     cl,[matrix.y]   ;y=matrix.y

    mov     dx,0            ;set dx (word) = 0
    mov     dl,i
    sub     cl,dl           ;y=y-i
    
    call    if_printFlowMatrix
;;
 ;   mov     ah,0eh
  ;  mov     al,'1'
  ;  mov     bh,0h
  ;  mov     bl,3

  ;  int     10h
;;/
    add     i,01h           ;i++
    mov     dx,0            ;set ax (word) = 0
    mov     dl,[matrix.len] 

    cmp    i,dl             ;i < matrix.len
    je     exit_printFlowMatrix

    jmp    printFlowMatrix
    ret
;#### END LOOP i ####
;#### If in LOOP_printFlowMatrix #### 

;if (y>=0)
if_printFlowMatrix:         
    cmp     cl,0h    ;cl = y ;cl(byte)
    jg      secondIf_printFlowMatrix    ;jg – jump if greater than

    jmp     exit_if
    ret

;if (y<25)
secondIf_printFlowMatrix:   
    cmp     cl,25
    jl      inIf_printFlowMatrix        ;jl – jump if less than

    jmp     exit_if
    ret

;if(i == 0)
inIf_printFlowMatrix:       
    cmp     i,0
    je      setTextColor_WHITE

    jmp     elseifONE_inIf
    ret

;else if (i<2)
elseifONE_inIf:             
    cmp      i,2
    jl      setTextColor_GRAY        ;jl – jump if less than


    jmp     elseifTWO_inIf
    ret
;;************ ส่วนการแรนดอมมีปัญหา ปริ้นแล้วเป็นตัวเดิม ***********888
;;******** เขียนถึงการแสดงผล ยังไม่ได้เขียนกำหนด cursor ของแต่ละสี และกำหนดสี
;;อาจจะมีปัญหา
;else if (i<matrix.length - 2)
elseifTWO_inIf:
    ;al is matrix.len - 2
    mov     ax,0h
    mov     al,matrix.len
    sub     al,2
    cmp     i,al
    jl      If_elseIf

    jmp     else_inIf   
    ret

If_elseIf:
    mov dh,0      ;from
    mov dl,2      ;to

    push    ax
    push    bx
    push    cx

    call random_number  

    pop     cx
    pop     bx
    pop     ax

    cmp dl,1
    je  setTextColor_GREEN


    jmp setTextColor_DARK_GREEN
    ret

else_inIf:
    jmp setTextColor_DARK_GREEN
    ret

    ;jl – jump if less than, if second parameter is less than the first
    ;jg – jump if greater than, if second parameter is larger than the first

;#### END If in printFlowMatrix #### 

;#### Exit Function ####
    exit_printFlowMatrix:    
    mov     ah,0eh
    mov     al,'Q'
    mov     bh,0h
    mov     bl,2

    int     10h

    ret

    exit_if:
    mov     ah,0eh
    mov     al,'q'
    mov     bh,0h
    mov     bl,2

    int     10h
    ret
;======================= Print =========================
setTextColor_WHITE:
        ;mov     ah, 02h         ; Move cursor XY
        ;mov     bh, 00h         ;page
        ;mov     dh, x           ;row  (start 0)
        ;mov     dl, y           ;column (start 0)
        ;int     10h

        ;mov     ah, 0Ah         ; Write 
        ;mov     al, 'O'         ;char
        ;mov     bh, 00h        ;page
        ;mov     bl, 42h        ;background
        ;mov     cx, 1           ;how many?
        ;int     10h

        mov     ah,0eh
    mov     al,'W'
    mov     bh,0h
    mov     bl,2

    int     10h

        ret

    setTextColor_GRAY:
        mov     ah,0eh
    mov     al,'R'
    mov     bh,0h
    mov     bl,2

    int     10h

        ret

    setTextColor_DARK_GREEN:
        mov     ah,0eh
    mov     al,'G'
    mov     bh,0h
    mov     bl,2

    int     10h

        ret

    setTextColor_GREEN:
        mov     ah,0eh
        mov     al,'g'
        mov     bh,0h
        mov     bl,2

        int     10h

        ret


;========================== End FlowMatrix =============================

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

end main