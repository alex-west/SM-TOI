; Pause Screen adjustments
lorom

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
; oBOMBS - x
    dw $08FF, $08D5, $08D4, $08D4, $08D4, $08D4, $08D4, $08D4, $08D4
; oSPRING BALL - Espresso Ball
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


org $82C04C ; Change logical order on menu
    dw $1000 ; Weapons - charge
    dw $0004 ; Weapons - spazer
    dw $0002 ; Weapons - ice
    dw $0001 ; Weapons - wave
    dw $0008  ; Weapons - plasma
; My spring-with-morph patch modifies the table immediately following this



org $82D521 ; Samus Wireframe Tilemaps

incsrc "./equip-screen/unicolor-no-boots.asm"
incsrc "./equip-screen/unicolor-boots.asm"
incsrc "./equip-screen/tricolor-no-boots.asm"
incsrc "./equip-screen/tricolor-boots.asm"