; Bank $A7 Phantoon edits
; RT-55J
; Thanks PJBoy

lorom

org $A7CA21 ; Palettes

; Unused. Clone of $CC21 (one with the highest health
    dw $0000,$6F7B,$4ED9,$35FB,$2996,$2156,$18EF,$10CD,$0C8A,$02DF,$0A37,$054E,$6018,$3C12,$2010,$100C

; Fade out target palette
    dw $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000

; Wrecked Ship powered on BG1/2 target palettes 0..6 (same as SCE)
    dw $0000,$02DF,$01D7,$00AC,$5EBB,$3DB3,$292E,$1486,$0BB1,$48FB,$7FFF,$0000,$7FFF,$44E5,$7FFF,$0000
    dw $2003,$0BB1,$1EA9,$0145,$5EBB,$3DB3,$292E,$1486,$6318,$1CE7,$1084,$0000,$7FFF,$02DF,$001F,$0000
    dw $2003,$72BC,$48FB,$1816,$6318,$6318,$6318,$6318,$6318,$6318,$6318,$6318,$6318,$6318,$7FFF,$0000
    dw $0000,$72B2,$71C7,$4D03,$6318,$6318,$6318,$6318,$6318,$6318,$6318,$6318,$6318,$6318,$7FFF,$0000
    dw $0000,$0420,$1041,$2082,$38E4,$28A3,$1862,$34C4,$1C62,$38C4,$3CE5,$2483,$30A4,$0400,$0821,$1442
    dw $0000,$0420,$72EA,$5207,$1061,$24E3,$5E48,$6EA9,$6A69,$3524,$4165,$4DA6,$0C41,$1882,$5DE7,$6608
    dw $0000,$7E20,$6560,$2060,$1000,$7940,$5D00,$4CA0,$3CA0,$7FFF,$0113,$000F,$175C,$0299,$01D6,$0C20

; Health based palettes
    dw $000E, $25DC,$0155,$00B3,$0010, $000E,$000C,$000A,$0008, $02DF,$0A37,$054E, $1C1D,$0415,$0411,$0005 ; Health <= 312
    dw $000C, $2A1C,$0D55,$04F3,$0031, $000F,$002C,$002B,$0029, $02DF,$0A37,$054E, $281B,$0C15,$0811,$0406 ; Health > 312
    dw $000A, $2E5C,$15B5,$0D14,$0071, $004F,$004C,$004B,$0049, $02DF,$0A37,$054E, $301A,$1415,$0C11,$0407 ; Health > 624
    dw $0008, $327C,$21F6,$1556,$0893, $0090,$006D,$006B,$0469, $02DF,$0A37,$054E, $3819,$1C15,$1011,$0408 ; Health > 936
    dw $0006, $36BB,$21D4,$1D77,$10D4, $08B1,$048D,$046C,$046A, $02DF,$0A37,$054E, $4018,$2415,$1411,$0808 ; Health > 1248
    dw $0004, $3AFB,$2E37,$25B8,$1914, $10D2,$08AE,$088C,$048A, $02DF,$0A37,$054E, $4818,$2C14,$1811,$0C0A ; Health > 1560
    dw $0002, $3F3B,$3A78,$2DF9,$2155, $1914,$10CF,$0CAD,$088A, $02DF,$0A37,$054E, $3413,$3413,$1C11,$0C0C ; Health > 1872
    dw $0000, $6F7B,$4ED9,$35FB,$2996, $2156,$18EF,$10CD,$0C8A, $02DF,$0A37,$054E, $3C12,$3C12,$2010,$100C ; Health > 2184



!phantoon_function = $0FB2

; Hijack point for rage vulnerability
org $A7D89C : jmp rageHijack ; LDA #$D8AC

org $A7FF82 ; Freespace

; Add PB reaction to enrage
phantoon_PowerBombReaction:
    print pc, " - Phantoon Power Bomb Reaction"
    ;if [$0FB2] = $D5E7 or $D82A? or $D7F7?
    lda !phantoon_function,x
    cmp #$D5E7 : beq .doIt
    cmp #$D82A : bne .exit    
    .doIt:
        stz $0FE8 ; Clear timer
        jsl pseudoJSL ; Trigger rage
    .exit:
rtl
    
pseudoJSL:
    phb ; Don't want that plb right before the rtl to smash the stack :)
    jmp $DED5 ;$A7DED5


; Make vulnerable during rage
; in function $D891
;  LDA #$CC53 (open eye function)
;  STA $0FD2 (eye instruction list pointer)

; LDA #$CC4D ; eye hitbox only
; STA $0F92 ; body instruction list pointer

rageHijack:
    ; Vanilla code
    LDA #$D8AC : STA !phantoon_function ; [$7E:0FB2]  ;} Phantoon function = $D8AC
    LDA #$0004 : STA $0FB0,x            ; Phantoon function timer = 4
    STZ $0FF2 ; Phantoon rage round counter = 0

    ; Set body and eye instruction timers
    LDA #$0001 : STA $0F94 : STA $0FD4
    ; Open eye - Some jank going on here, but it works well enough
    lda #$CC53 : sta $0FD2
    ; Eye hitbox only
    lda #$CC4D : sta $0F92
    ; Set Phantoon body as tangible
    LDA $0F86 : AND #$FBFF : STA $0F86        
rts

