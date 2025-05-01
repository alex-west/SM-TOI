lorom
; Make varia suit spike armor
;  by RT-55J
; Thanks to PJ for the bank logs

!W_Items_equip = $09A2
!W_Samus_i_frames = $18A8

!spike_armor_bitflag = $0001 ; Change if you want to give this property to another item

org $9081DB ; let varia give lava immunity
    bit #!spike_armor_bitflag
    bne lavaHijackSkip 
org $90824C
lavaHijackSkip:

; Spike block collision BTS 0 hijack
org $948E83
    jsr armorCheck
    nop #12
    bcs $3A

org $948E99 : LDA #90 ; iframe adjustment

org $948EB2 : ADC #20 ; Armorless spike damage adjustment

; Spike block collision BTS 1 hijack    
org $948ECF
    jsr armorCheck
    bcs $35

org $948ED4 : LDA #90 ; iframe adjustment
    
; Spike block collision BTS 3 hijack    
org $948F0A
    jsr armorCheck
    bcs $35
    
org $948F0F : LDA #90 ; iframe adjustment

; Air spike block inside collision BTS 2 hijack
org $94986B
    jsr armorCheck
    bcs $35

org $949870 : LDA #90 ; iframe adjustment

org $94B19F ; Freespace

armorCheck: ; Return with carry set if varia is equipped
    lda !W_Items_equip
    and #!spike_armor_bitflag
        bne .yesArmor
    ; Also check i-frames
    lda !W_Samus_i_frames
        bne .yesArmor    
    clc
    rts
    
.yesArmor:
    sec
    rts
