; Tide Change PLM
;  Changes the target Y position of the FX layer
; by RT-55J

lorom

!C_timerDelay = 30

; WRAM Addresses
!W_FX_CurrentY = $1962
!W_FX_TargetY = $197A
!W_FX_SpeedY = $197C
!W_FX_timer = $1980


!W_PLM_blockIndex = $1C87
!W_PLM_roomArg = $1DC7
!W_PLM_variable = $1E17

; Existing Instructions
I_PLM_sleep = $86B4
I_PLM_goto = $8724

; deleteSelf_instructionList = $AAE3 ; refers to bank $84

org $84F3E9 ; Set to appropriate freespace

; Tide Change PLM
tideChange_PLM:
print pc, " - Tide Change PLM"
; Should just be able to reuse the scroll PLM setup (and also the BTS collison reaction!)
    dw $B371, tideChange_instructionList ; $AF86

;tideChange_PLMSetup:
;; Write scroll PLM trigger block, set PLM as not triggered and skip debug draw instruction
;    ldx !W_PLM_blockIndex,y
;    LDA #$3046 ; block type
;    jsr $82B4 ; Draw
;    ; Set PLM as non-triggered
;    lda #$0000 : sta !W_PLM_variable,y
;ret

tideChange_instructionList: ; Based off $84:B703
    dw $0001, $AF62 ; Dummy draw instruction because we're using the scroll PLM's setup
    .loop:
        dw I_PLM_sleep
        dw I_PLM_tideChange
    dw I_PLM_goto, .loop  ; Go to $AF8A

I_PLM_tideChange: ; Quick change the tide!
    phb : phx : phy
    ; Clear triggered flag
    stz !W_PLM_variable, x
    ; Exit if new target equals old target
    lda !W_PLM_roomArg, x : cmp !W_FX_TargetY
        beq .exit
    ; Difference = targetY - currentY
    sec
    sbc !W_FX_CurrentY
    
    ; Branch based on the relative signs
    eor !W_FX_SpeedY
    bpl .endNegate
        ; Negate speed if signs mismatch
        lda !W_FX_SpeedY
        eor #$FFFF
        inc
        sta !W_FX_SpeedY
    .endNegate:
    
    ; Adjust tide
    lda !W_PLM_roomArg, x : sta !W_FX_TargetY
    ; Set timer
    lda #$002E : sta !W_FX_timer

    ; I have no idea why the Scroll PLM does this
    ;LDA !W_PLM_blockIndex,x;\
    ;TAX                    ;|
    ;LDA $7F0002,x          ;|
    ;AND #$0FFF             ;} PLM block type = special air
    ;ORA #$3000             ;|
    ;STA $7F0002,x          ;/

    .exit:
    ply : plx : plb
rts

; Tide Change Collision Reaction PLM
;tideChangeTrigger_PLM:
;; Just use the same setup as the scroll collision trigger PLM
;    dw $B393, deleteSelf_instructionList

; $B393

;tideChangeTrigger_Setup: ; Based on $B6FF
;;; Returns:
;;;     Carry: Set. Unconditional collision
;    tyx ; Transfer PLM index from Y to X
;    ; Load current PLM position to A to find the actual PLM at this position
;    lda !W_PLM_blockIndex,x
;    ; Clear the position of the current PLM to avoid a self-collision
;    stz !W_PLM_blockIndex,x
;    
;; Loop through PLM list from back to front
;    ldx #$004E ; X = 4Eh (PLM index)
;    .searchLoop:
;        cmp !W_PLM_blockIndex,x  ;\
;        beq .exitLoop ;} If [PLM block index] = [A]: go to BRANCH_FOUND
;        dex : dex ; X -= 2
;    BPL .searchLoop ; If [X] >= 0: Go to LOOP
;.crash: bra .crash ; No match found
;
;    .exitLoop:
;    
;; BRANCH_FOUND
;$84:B3A8 BD 17 1E    LDA $1E17,x[$7E:1E5B]  ;\
;$84:B3AB 30 13       BMI $13    [$B3C0]     ;} If PLM has been triggered: return
;$84:B3AD A9 00 80    LDA #$8000             ;\
;$84:B3B0 9D 17 1E    STA $1E17,x[$7E:1E5B]  ;} Trigger PLM
;$84:B3B3 FE 27 1D    INC $1D27,x[$7E:1D6B]  ;\
;$84:B3B6 FE 27 1D    INC $1D27,x[$7E:1D6B]  ;} PLM instruction list pointer += 2
;$84:B3B9 A9 01 00    LDA #$0001             ;\
;$84:B3BC 9F 1C DE 7E STA $7EDE1C,x[$7E:DE60];} PLM instruction timer = 1
;
;$84:B3C0 60          RTS

org $88B397 : nop #3 ; STZ $197C

org $88C463 : nop #3 ; STZ $197C