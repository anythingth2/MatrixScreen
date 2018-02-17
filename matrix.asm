    .model  tiny
    
    .data   
x   dw  5h

    .code
    
    org 0100h
    
main:   
    mov ah,0Ah
    mov al,'p'
    mov cx,[x]
    int 10h
    ret
end main