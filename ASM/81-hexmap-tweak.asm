lorom

; This should skip the map preview because I'm too lazy to give it the proper palettes/graphics
org $81A8A9
    lda.w #$000D ; Switch menu mode to "fade to game"
    sta.w $0727
    jmp $A97E ; Draw hexmap labels (for just this one frame)
    
org $81AF66
    jsr $A97E ; Draw hexmap sprite labels
    nop #5 ; Skip drawing gridmap labels