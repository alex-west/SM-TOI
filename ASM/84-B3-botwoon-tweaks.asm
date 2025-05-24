lorom

; == PLM EDITS ==

; Draw commands for walls
org $84930F
draw_ClearWall_D:
    dw $0005, $00FF, $00FF, $00FF, $00FF, $00FF
    dw $0000
draw_ClearWall_A:
    dw $0005, $8053, $8053, $8053, $8053, $8053
    dw $0000
draw_ClearWall_B:
    dw $0005, $8054, $8054, $8054, $8054, $8054
    dw $0000
draw_ClearWall_C:
    dw $0005, $0055, $0055, $0055, $0055, $0055
    dw $0000

;;; $AB31: Instruction list - PLM $B79B (crumble Botwoon wall) ;;;
org $84AB31
    dw $874E
        db $05 ; Timer = 9
    dw $AB51 ; Scroll 0..1 = blue
.loop:
    dw $8C10 ; Queue sound
        db $0A  
    dw $0004, $A345 ;draw_ClearWall_A
    dw $0004, $A34B ;draw_ClearWall_B
    dw $0004, $A351 ;draw_ClearWall_C
    dw $0004, $A357 ;draw_ClearWall_D
    dw movePLM      ; Move PLM down one block
    dw $873F, .loop  ; Decrement timer and go to $AB36 if non-zero
    dw $86BC ; Delete

org $84AB59 ; Move PLM right one block
movePLM:
    inc $1C87,x
    inc $1C87,x
    rts

rts

;;; $AB67: Instruction list - PLM $B797 (clear Botwoon wall) ;;;
org $84AB67
    dw $0001, draw_ClearWall_D
    dw $86BC ; Delete
    
; == BOTWOON AI EDITS ==

;;; $9583: Initialisation AI - enemy $F293 (Botwoon) ;;;
org $B39583
    lda #$0001 ; Use the main boss bit
    jsl $8081DC ; Check the boss bit
    bcc $24 ; Branch if boss is not dead

org $B39593 ; Spawn PLM to clear Botwoon's wall
    db $07,$0E
    dw $B797
    
org $B39AE1 ; Spawn PLM to crumble Botwoon's wall
    db $07,$0E
    dw $B79B
    
;;; $9A5E: Botwoon function - death sequence - falling to ground ;;;
org $B39A86 ; Comparison threshold
    CMP #$00D8 ; #$00C8 
org $B39A8B ; Clamping position
    LDA #$00D8 ; #$00C8


;;; $9AF9: Botwoon function - death sequence - crumbling wall ;;;

org $B39AFD
    cmp #$007C ; Timer for explosions
    
org $B39B13
    lda #$0001 ; Set main boss bit

; Explosion position adjustments
org $B39B3C
    adc #$00D8 ; Y position
    sta $14 ; Temp var for ypos

org  $B39B48
    clc
    adc #$0078-$0040 ; X position (adjust for waittime)

org $B39B51
    sta $12 ; Temp var for xpos

; Smoke position adjustments

org $B39B84
    adc #$00D8 ; Y position
    sta $14 ; Temp var for ypos

org $B39B90
    clc
    adc #$0070-$0040 ; X position (adjust for waittime)

org $B39B99
    sta $12 ; Temp var for xpos

; == BOTWOON PROJECTILE EDITS ==

;;; $EB1F: Botwoon's body function - dying - falling ;;;
org $86EB4C ; Comparison threshold
    CMP #$00D8 ; #$00C8

org $86EB51 ; Clamping threshold
    LDA #$00D8 ; #$00C8

; Botwoon's body
org $86EBA0
    dw $EA31,$EA80,$E8F3
    db $02,$02
    dw $E028 ; Damage
    dw $0000,$84FC

; Botwoon's spit
org $86EC48
    dw $EBC6,$EC05,$EBAE
    db $02,$02
    dw $1014 ; Damage
    dw $0000,$84FC
