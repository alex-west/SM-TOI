; Palette blends
; thx neen

lorom
org $89aa02

;   0        2                      8                      Eh                     14h                   1Ah
dw $0000,   $0E3F, $0D7F, $0000,   $6318, $6318, $0000,   $6318, $6318, $0000,   $6318, $6318, $0000,   $6318, $6318, $0000 ; 0
dw $3800,   $314A, $20C6, $0820,   $6318, $6318, $0000,   $6318, $6318, $0000,   $6318, $6318, $0000,   $6318, $6318, $0000 ; 20h
dw $3800,   $0400, $1C63, $0000,   $28E3, $1C60, $0000,   $2485, $3D88, $0000,   $0880, $0420, $0000,   $28E3, $1C60, $0000 ; 40h
dw $3800,   $20A5, $1C84, $1024,   $1087, $14A8, $0844,   $6318, $6318, $0000,   $6318, $6318, $0000,   $6318, $6318, $0000 ; 60h
;$2C4B, $59D6
dw $3800,   $086C, $014A, $0000,   $6318, $6318, $0000,   $6318, $6318, $0000,   $6318, $6318, $0000,   $6318, $6318, $0000 ; 80h
;dw $3800,   $6318, $6318, $0000,   $6318, $6318, $0000,   $6318, $6318, $0000,   $6318, $6318, $0000,   $6318, $6318, $0000 ; 80h
dw $3800,   $6318, $6318, $0000,   $6318, $6318, $0000,   $6318, $6318, $0000,   $6318, $6318, $0000,   $6318, $6318, $0000 ; A0h
dw $3800,   $6318, $6318, $0000,   $0420, $241C, $056c,   $6318, $6318, $0000,   $6318, $6318, $0000,   $6318, $6318, $0000 ; C0h
dw $3800,   $0400, $18A2, $0000,   $0020, $0C62, $0000,   $0400, $1C45, $0000,   $6318, $6318, $0000,   $6318, $6318, $0000 ; E0h

; Used palette blends:
;     2: Tourian acid/lava rooms
;     22h: Landing site before power bombs
;     42h: Yellow Maridia
;     48h: Water rooms
;     62h: Fog & rain, Crateria before Zebes awakens
;     E2h: Lower green/pink Maridia
;     E8h: Sandy Maridia
;     EEh: Upper green/pink Maridia

; Gonna use 82h