lorom

; Change PLM instruction so it check's Samus's xposition

; Torizo rey door
org $84BA6F
    lda.w $0AF6 ; Load xpos
    cmp.w #136  ; xpos > threshold
    bmi $03
;LDA $09A4  [$7E:09A4]
;BIT #$1000
;BEQ $03    [$BA7A]
;INY
;INY
;RTS
;
;LDA $0000,y[$84:BA52]
;TAY
;RTS

; Crumbling statue
; thx PJ for finding this instruction
org $84D33B
    lda.w $0AF6 ; Load xpos
    cmp.w #136  ; xpos - threshold > 0
    bmi $13
; LDA $09A4  [$7E:09A4]  ;\
; AND #$1000             ;} If Samus doesn't have bombs: return
; BEQ $13    [$D356]     ;/
; LDA #$0001             ;\
; STA $7EDE1C,x[$7E:DE66];} PLM instruction timer = 1
; INC $1D27,x[$7E:1D71]  ;\
; INC $1D27,x[$7E:1D71]  ;} PLM instruction list pointer += 2
; LDA #$D356             ;\
; STA $1CD7,x[$7E:1D21]  ;} PLM pre-instruction = RTS
; 
; RTS

;;; $C87F: Initialisation AI - enemy $EEFF/$EF3F/$EF7F/$EFBF (torizos) ;;;
; Using the Torizo bossbit is fine, I think
; But keeping this here for future reference
;org $AAC87F
; LDA #$0004             ;\
; JSL $8081DC[$80:81DC]  ;} If area torizo is dead:
; BCC $0D    [$C895]     ;/

; BT Code, just for neen :)
org $AAC913
bombTorizoCode:
    nop ; rtl
    nop ; jsr $C280 (load GT palette)
    nop
    nop
    lda $8B
    cmp #$C0C0
        bne .exit
    ; Load up reserves
    LDA.w #$012C
    STA $09D4
    STA $09D6
    INC $09C0 ; Set reserve mode to AUTO
    ; Give xray and grapple
    ; First for equipped items
    lda $09A2
    ora #$C000
    sta $09A2
    ; Then for collected items
    lda $09A4
    ora #$C000
    sta $09A4
    ; Refresh status bar
    jsl $809A2E ; grapple
    jsl $809A3E ; xray
        
.exit: rtl