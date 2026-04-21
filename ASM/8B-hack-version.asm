; Hack Version

org $8B8697
    NOP

;;;; $F754: Debug. Version string ;;;
; '02.02.21.30'
;$8B:F754             db 30, 32, 2E, 30, 32, 2E, 32, 31, 2E, 33, 30, 00
;}
org $8BF754
    db $30, $2E
    db $39, $32, $00;$2E
    ;db $32, $31, $2E
    ;db $33, $30, $00