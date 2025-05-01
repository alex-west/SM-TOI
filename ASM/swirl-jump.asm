lorom
; Space Jump replacement
;  "swirl jump"
; by RT-55J
; thanks to PJ for the banklogs and advice

; Defines
!samus_x_bonk_flag = $0DCE
!samus_y_accel_lo = $0B32
!samus_y_accel_hi = $0B34
!samus_equipped_items = $09A2

!space_jump_bitflag = $0200
!player_1_input = $8B
!player_jump_input_binding = $09B4

; $90:A436
; Samus movement - spin jumping

; $90:9040
; Samus spin jumping movement
org $9090B3 ; hijack point
    JSR swirl_hijack


org $90F63A ; freespace
swirl_hijack:
    ; check if bonk'd
    lda !samus_x_bonk_flag 
        beq .end
    ; check if we have the item equipped
    lda !samus_equipped_items : and #!space_jump_bitflag
        beq .end
    ; check if jump is being held
    lda !player_1_input : and !player_jump_input_binding
        beq .end

    ; Negate the vertical acceleration
    lda !samus_y_accel_lo : eor #$FFFF : sta !samus_y_accel_lo
    lda !samus_y_accel_hi : eor #$FFFF : sta !samus_y_accel_hi
    CLC
    lda !samus_y_accel_lo : adc #$01 : sta !samus_y_accel_lo
    lda !samus_y_accel_hi : adc #$00 : sta !samus_y_accel_hi
.end:
    lda $9E9F ; original ASM at hijack point
rts

;print pc

org $90A4C2 ; Disable vanilla space jumping
    bra $04

; Disable liquid space jump animation restriction
org $91F690 ; Facing right
    bra $20
org $91F6F1 ; Facing left
    bra $20

; Ignore spikes if spinning with swirl jump equipped

; Wall-jump
;  Add toggle in main menu
