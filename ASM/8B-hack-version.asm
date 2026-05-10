; Hack Version

org $8B8697
    NOP

org $8B86E0 ; Skips drawing the game header version number and mute flag.
    bra skipThing
    
org $8B873D
skipThing:

org $8B877A ; 'Ver.' OAM entry tile numbers and attributes
    dw $39F2, $39F1, $39F0

;;;; $F754: Debug. Version string ;;;
; '02.02.21.30'
;$8B:F754             db 30, 32, 2E, 30, 32, 2E, 32, 31, 2E, 33, 30, 00
;}
org $8BF754
    db $30, $2E
    db $39, $32, $00;$2E
    ;db $32, $31, $2E
    ;db $33, $30, $00