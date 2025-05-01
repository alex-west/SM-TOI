; Trying to make a more Core-X like Metroid

; TODO: Edit graphics!

; Make it not latch onto Samus
;  SOLVED: Change touch AI to 0x8023
; Make it hurt Samus on contact
;  SOLVED: Change touch AI to 0x8023
; Make immune to ice
;  SOLVED: Weakness table

; Make it take damage when hit while unfrozen
; $A3:EF1C F0 5B       BEQ $5B    [$EF79]     ;} If [enemy frozen timer] = 0: go to BRANCH_NOT_FROZEN
lorom

!W_invulnTimer = $0FA0

org $A3EF1C
    bra $5B ; Always skip to the stuff that processes the bounce
    
org $A3EF2E
    normalHurtReaction:

;$A3:F000 B9 18 0C    LDA $0C18,y[$7E:0C18]  ;
;$A3:F003 29 02 00    AND #$0002             ;} If projectile is not ice beam: go to BRANCH_NOT_ICE_BEAM
;$A3:F006 F0 32       BEQ $32    [$F03A]     ;

org $A3F000
    ; Trying to set a super long invulnerabilty timer --- not working --- probably should be after damage is dealt :/
;    LDA $0C18,y ; Load projectile type
;    AND #$0F00 : CMP #$0100 ; Check if projectile type is missile
;    bne .gotoNormal
;    ; Check invulnerabilty timer
;    lda !W_invulnTimer,x
;    bne .gotoNormal
;    ; Set timer
;    lda #180 : sta !W_invulnTimer,x
;
;.gotoNormal:
    jmp normalHurtReaction ; Make it take damage

; Make it intangible to walls
; Y-axis
org $A3EC67 : jsl $A0AF90 : bra $09 ; BCC $09
; X-axis
org $A3ECCC : jsl $A0AF6C : bra $09 ; BCC $09


; Force it to be always active once it activates for real

org $A3EB98 ; Hijack point
    jsr metroidHijack
    
org $A3F3DB  ; Freespace
metroidHijack:
    LDX $0E54 ; Load enemy index to x (vanilla code)
    ; force to process offscreen
    lda $0F86,x : ora #$0800 : sta $0F86,x
rts