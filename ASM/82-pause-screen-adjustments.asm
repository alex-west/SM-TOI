; Pause Screen adjustments
lorom

;;; $B150: Equipment screen - main - boots ;;;
org $82B150 ; Fix the Spazer-Plasma glitch
    PHP
    REP #$30
    ;JSR $B160  ;[$82:B160]  ; Move response
    LDA #$0012             ;
    STA $18    ;[$7E:0018]  ;} $18 = 12h (boots tilemap size in bytes)
    JSR $B568  ;[$82:B568]  ; Button response <- this being here is bad, apparently
    JSR $B160  ;[$82:B160]  ; Move response
    PLP
    RTS

; Spazer-plasma check
; -- Make the Linguini beam and other beams mutually exclusive
;0001: Wave
;0010:
;0100:
;1000:
;        2: Ice
;        4: Spazer
;        8: Plasma

org $82B073
    BIT.w #%00000111
    BNE branch_toggledPVC
    ; BIT #$0004 ; Check if P V or C was toggled

org $82B087 
    BIT.w #%00000111 
    ; BIT #$0004

org $82B08C
    JMP beamUnequipHijack

branch_toggledPVC:
    LDA $24 ; Prev beams
    ; Funny bitwise math (to check if something got turned on)
    EOR #$FFFF
    AND $09A6
    BIT.w #%00000111
    BEQ exitPVCfunction
    LDA $09A6
    BRA unequipPlasma
    
org $82B0A8
    unequipPlasma:

org $82B0C0
    exitPVCfunction:

org $82F723
beamUnequipHijack:
    AND #%1111111111111000 ; Unequip PVC beams
    STA $09A6

    ; Cleanup graphics for Spazer beam
    ; Load dest arg
    LDA $C072 ; Load destination in VRAM for Spazer
    STA $00   ; Store arg in temp
    ; Load palette arg
    LDA #$0C00
    STA $12
    ; Load length arg
    LDA #$000A
    STA $16
    ; Set tile palettes
    JSR $A29D

    ; And some other beam
    LDA $C070
    STA $00
    ; Load palette arg
    LDA #$0C00
    STA $12
    ; Load length arg
    LDA #$000A
    STA $16
    JSR $A29D
    
    ; And another beam
    LDA $C06E
    STA $00
    ; Load palette arg
    LDA #$0C00
    STA $12
    ; Load length arg
    LDA #$000A
    STA $16
    JSR $A29D
    
    PLP
    RTS

org $82BF06 ; Equipment screen tilemaps

; MODE[MANUAL]
    dw $2519, $251A, $251B, $3D46, $3D47, $3D48, $3D49
; RESERVE TANK
    dw $3C80, $3C81, $3C82, $3C83, $3C84, $3C85, $3C86
; [MANUAL]
    dw $3D46, $3D47, $3D48, $3D49
; [ AUTO ]
    dw $3D56, $3D57, $3D58, $3D59

; oCHARGE
    dw $08FF, $08D6, $08D7, $08D8, $08D9
; oICE  - Pistachio
    dw $08FF, $08DA, $08DB, $08DC, $08DD
; oWAVE - Vanilla
    dw $08FF, $08DE, $08DF, $08E0, $08E1
; oSPAZER - Amarena
    dw $08FF, $08E2, $08E3, $08E4, $08E5
; oPLASMA - Linguini
    dw $08FF, $08E6, $08E7, $08E8, $08E9
    
; oVARIA SUIT - Tricolor Suit
    dw $08FF, $08EA, $08EB, $08EC, $08ED, $08EE, $08EF, $08F0, $08F1
; oGRAVITY SUIT - x
    dw $08FF, $08D5, $08D4, $08D4, $08D4, $08D4, $08D4, $08D4, $08D4

; oMORPHING BALL - Meatball
    dw $08FF, $08F2, $08F3, $08F4, $08F5, $08FD, $08D4, $08D4, $08D4
; oSPRING BALL - Spicy Meatball
    dw $08FF, $094A, $094B, $094D, $08F2, $08F3, $08F4, $08F5, $08FD
; oDASH BALL - Espresso Ball
    dw $08FF, $0900, $0901, $0902, $0903, $0904, $0905, $0906, $090B
; Unused
    dw $0000
; oSCREW ATTACK - Mad at Food
    dw $08FF, $090F, $0910, $0911, $0912, $0913, $0914, $0915, $08D4

; oHI-JUMP BOOTS - Calcio Cleats
    dw $08FF, $0916, $0917, $0918, $091F, $0920, $0921, $0922, $08D4
; oSPACE JUMP - Swirl Clamber
    dw $08FF, $0923, $0924, $0925, $0926, $0927, $0928, $0929, $092A
; oSPEED BOOSTER - Vespa LX 9000
    dw $08FF, $092B, $092F, $0930, $0931, $0932, $0933, $0934, $08D4

; oHYPER - Italy
    dw $08FF, $0935, $0936, $0937, $0938, $08D4, $08D4, $08D4, $08D4

; Blank placeholder
    dw $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000

;; Equipment bitmasks
org $82C04C ; Change logical order on menu
    dw $1000 ; Weapons - charge
    dw $0004 ; Weapons - spazer
    dw $0002 ; Weapons - ice
    dw $0001 ; Weapons - wave
    dw $0008 ; Weapons - plasma
    
    dw $0001 ; Suit/misc - varia suit
    dw $0020 ; Suit/misc - gravity suit
    
    dw $0004 ; Suit/misc - morph ball (was $0006 in previous version (spring+morph))
    dw $0002 ; Suit/misc - spring ball (was $1000 for bombs (which were unused))
    dw $0800 ; Suit/misc - spring ball (changed from $0002) (now dash ball)
    dw $0008 ; Suit/misc - screw attack

;$82:C062             dw 0100, ; Boots - hi-jump boots
;                        0200, ; Boots - space jump
;                        2000  ; Boots - speed booster



org $82D521 ; Samus Wireframe Tilemaps

incsrc "./equip-screen/unicolor-no-boots.asm"
incsrc "./equip-screen/unicolor-boots.asm"
incsrc "./equip-screen/tricolor-no-boots.asm"
incsrc "./equip-screen/tricolor-boots.asm"