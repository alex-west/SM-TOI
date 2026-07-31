; Message Box Timer Fix
;  by RT-55J

lorom

org $85847A
    lda $1C1F ; message box number
    rep #$20
    asl ; *2 for indexing into table
    tax
    lda timerTable, x
    tax
    sep #$20
    lda $1C1F ; reload message box number
    bra normalCode

;$85:847A A2 0A 00    LDX #$000A             ; X = 10
;$85:847D AD 1F 1C    LDA $1C1F  [$7E:1C1F]  ;\
;$85:8480 C9 14       CMP #$14               ;} If [message box index] != map data access completed:
;$85:8482 F0 0F       BEQ $0F    [$8493]     ;/
;$85:8484 C9 15       CMP #$15               ;\
;$85:8486 F0 0B       BEQ $0B    [$8493]     ;} If [message box index] != energy recharge completed:
;$85:8488 C9 16       CMP #$16               ;\
;$85:848A F0 07       BEQ $07    [$8493]     ;} If [message box index] != missile reload completed:
;$85:848C C9 18       CMP #$18               ;\
;$85:848E F0 03       BEQ $03    [$8493]     ;} If [message box index] != save completed:
;$85:8490 A2 68 01    LDX #$0168             ; X = 360

org $858493 : normalCode:


org $85FF80 ; Freespace

timerTable:
    dw 0   ; $00 - none
    dw 60 ; $01 - energy tank
    dw 60 ; $02 - missile tank
    dw 60 ; $03 - super missile
    dw 60 ; $04 - power bomb
    dw 120 ; $05 - grapple
    dw 120 ; $06 - xray
    dw 120 ; $07 - varia suit
    dw 120 ; $08 - spring ball
    dw 120 ; $09 - morph ball
    dw 120 ; $0A - screw attack
    dw 120 ; $0B - high jump boots
    dw 120 ; $0C - space jump
    dw 120 ; $0D - speed booster
    dw 120 ; $0E - charge beam
    dw 120 ; $0F - ice beam
    dw 120 ; $10 - wave beam
    dw 120 ; $11 - spazer
    dw 120 ; $12 - plasma beam
    dw 120 ; $13 - bomb
    dw 80  ; $14 - map station
    dw 40  ; $15 - energy refill
    dw 40  ; $16 - missile refill
    dw 40  ; $17 - save 
    dw 40  ; $18 - save complete
    dw 120 ; $19 - reserve tank 
    dw 120 ; $1A - gravity suit
    dw 10  ; $1B - 111111111111
    dw 40  ; $1C - save 
    dw 80  ; $1D - gates remaining
    dw 80  ; $1E - station opened
    dw 360 ; $1F - key item
    dw 40  ; $20 - invalid key 
    dw 40  ; $21 - self-destruct
    dw 10   ; $22 - 