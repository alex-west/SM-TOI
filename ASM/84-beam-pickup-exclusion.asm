lorom

; Makes the Linguini beam exclusive from the others upon collection

org $8488C5
    jmp label

org $8488D6
    hijackEnd:

org $84EFF4	; Freespace
label:
    ; Check if collecting plasma -- if so, unequip other beams
    bit.w #$0008
        bne .unsetOthers
    ; Check if collecting not plasma -- if so, unequip plasma
    lda.w $0000,y
    bit.w #$0007
        bne .unsetPlasma
    jmp hijackEnd
    
.unsetPlasma:
    lda #$0008
    TRB $09A6 ; Unset equipped bits
    jmp hijackEnd
    
.unsetOthers:
    lda #$0007
    TRB $09A6 ; Unset equipped bits
    jmp hijackEnd

