lorom

; Mirrortroid-related changes by theonlydude
;  taken from the VARIA randomizer github repo
; Other changes by me

; == Change PLM instruction so it check's Samus's xposition
; Torizo grey door
org $84BA4C
PLM_BTGreyDoorClosing_InstructionList:
    dw $0002,$A677 ; Draw left-facing grey door
    dw $BA6F,PLM_BTGreyDoorClosing_InstructionList ; Loop back until condition is met
    dw $0028,$A677 ; Draw
    dw $8C19 : db $08 ; Queue door close sound
    dw $0002,$A6CB
    dw $0002,$A6BF
    dw $0002,$A6B3
    dw $0001,$A6A7
    dw $8724,PLM_BTGreyDoorClosed_InstructionList ;$BA7F ; Go to $BA7F

org $84BA6F ; Conditional branch instruction
    lda.w $0AF6 ; Load xpos
    cmp.w #136  ; xpos > threshold
    bpl $03 ; bmi $03

org $84BA7F
PLM_BTGreyDoorClosed_InstructionList:
; Too tired to resolved the baked in pointers in this code.
;InstructionListPlmBaf4BombTorizoGreyDoor_BA7F:
    dw $8A72,$C4E2 ; | 84BA7F | Go to $C4E2 if the room argument door is set
    dw $8A24,$BA93 ; | 84BA83 | Link instruction = $BA93
    dw $BE3F ; | 84BA87 | Set grey door pre-instruction
    dw $0001,$A6A7
    dw $86B4 ; | 84BA8D | Sleep
    dw $8724,$BA8D ; | 84BA8F | Go to $BA8D
    dw $8A24,$BAB7 ; | 84BA93 | Link instruction = $BAB7
    dw $86C1,$BD0F ; | 84BA97 | Pre-instruction = go to link instruction if shot
    dw $0003,$A9B3
    dw $0004,$A6A7
    dw $0003,$A9B3
    dw $0004,$A6A7
    dw $0003,$A9B3
    dw $0004,$A6A7
    dw $8724,$BA9B ; | 84BAB3 | Go to $BA9B
    dw $8A91 : db $01 : dw $BABC ; | 84BAB7 | Increment door hit counter; Set room argument door and go to $BABC if [door hit counter] >= 01h
    dw $8C19 : db $07 ; | 84BABC | Queue sound 7, sound library 3, max queued sounds allowed = 6 (door opened)
    dw $0004,$A6B3
    dw $0004,$A6BF
    dw $0004,$A6CB
    dw $0001,$A677
    dw $86BC ; | 84BACF | Delete



; == Crumbling statue PLM
; thx PJ for finding this instruction
org $84D33B
    lda.w $0AF6 ; Load xpos
    cmp.w #136  ; xpos - threshold > 0
    bpl $13 ; bmi $13



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


lorom

;;; from mirrortroid ips

; 0xaac87f |     9 | Initialisation AI - enemy $EEFF/$EF3F/$EF7F/$EFBF (Torizos) | ['[0xaac8e0-0xaac8e9]']
; $AA:C8E0 9D 7A 0F    STA $0F7A,x[$7E:0F7A]
; $AA:C8E3 B9 63 C9    LDA $C963,y[$AA:C963]
; $AA:C8E6 9D 7E 0F    STA $0F7E,x[$7E:0F7E]

; Stop the enemy position from being hardcoded
org $AAC8E0
        nop : nop : nop
org $AAC8E6
        nop : nop : nop

; 0xaad5c2 |     2 | Activate Golden Torizo if Samus is in the right place | ['[0xaad5cb-0xaad5cd]']
; $AA:D5CA A9 70 01    LDA #$0170
; $AA:D5CD CD F6 0A    CMP $0AF6  [$7E:0AF6]
; $AA:D5D0 B0 0C       BCS $0C    [$D5DE]
;org $AAD5CA
;        lda #$0090
;org $AAD5D0
;        bcc $0C

;; 0xaae5d8 |   126 | Instruction | ['[0xaae630-0xaae638]', '[0xaae639-0xaae648]', '[0xaae648-0xaae658]', '[0xaae659-0xaae6b0]']
;; $AA:E630     dw 0000, 0000, 0000, 0000, FE00, FD00, F200, F800, FE00, FD00, F200, F800, 0000, 0000, 0000, 0000,
;;                 0000, 0000, 0000, 0000, 0200, 0300, 0E00, 0800, 0200, 0300, 0E00, 0800, 0000, 0000, 0000, 0000
;; 
;; $AA:E670     dw FFE4, FFE2, FFE0, FFE0, FFE0, FFE0, FFE0, FFE0, FFE0, FFE0, FFE0, FFE0, FFE0, FFE0, FFE0, FFE0,
;;                 001C, 001E, 0020, 0020, 0020, 0020, 0020, 0020, 0020, 0020, 0020, 0020, 0020, 0020, 0020, 0020
;org $AAE630
;        dw $ffff,$ffff,$ffff,$ffff,$0200,$0300,$0e00,$0800,$0200,$0300,$0e00,$0800,$ffff,$ffff,$ffff,$ffff
;        dw $ffff,$ffff,$ffff,$ffff,$fe00,$f800,$f200,$f800,$fe00,$fd00,$f200,$f800,$ffff,$ffff,$ffff,$ffff
;
;org $AAE670
;        dw $001c,$001e,$0020,$0020,$0020,$0020,$0020,$0020,$0020,$0020,$0020,$0020,$0020,$0020,$0020,$0020
;        dw $ffe4,$ffe2,$ffe0,$ffe0,$ffe0,$ffe0,$ffe0,$ffe0,$ffe0,$ffe0,$ffe0,$ffe0,$ffe0,$ffe0,$ffe0,$ffe0


; 0xaae6f0 |     1 | Instruction | ['[0xaae711-0xaae712]']
; $AA:E711             dx 17, 1D, D6FC        ;} Block slope access for Wrecked Ship chozo
;org $AAE711
;        db $3a, $1d : dw $D6FC

; 0xaae725 |     3 | Initialisation AI - enemy $F0FF (chozo statue) | ['[0xaae777-0xaae778]', '[0xaae77f-0xaae780]', '[0xaae79d-0xaae79e]']
; $AA:E777             dx 4A,17,D6EE          ;} Spawn Wrecked Ship chozo hand PLM
; $AA:E77F             dx 17,1D,D6FC          ;} Spawn block slope access for Wrecked Ship chozo PLM
; $AA:E79D             dx 0C,1D,D6D6          ;} Spawn Lower Norfair chozo hand PLM
;org $AAE777
;        db $15, $17 : dw $D6EE
;org $AAE77F
;        db $3A, $1D : dw $D6FC
;org $AAE79D
;        db $23, $1D : dw $D6D6

; 0xaae7dd |  2516 | Chozo statue spritemaps | ['[0xaae7df-0xaaee85]', '[0xaaefda-0xaaf13e]', '[0xaaf4b6-0xaaf680]']

;;; bomb torizo
; Enemy population format is:
;  ____________________________________ Enemy ID
; |     _______________________________ X position
; |    |     __________________________ Y position
; |    |    |     _____________________ Initialisation parameter (orientation in SMILE)
; |    |    |    |     ________________ Properties (special in SMILE)
; |    |    |    |    |     ___________ Extra properties (special graphics bitset in SMILE)
; |    |    |    |    |    |     ______ Parameter 1 (speed in SMILE)
; |    |    |    |    |    |    |     _ Parameter 2 (speed2 in SMILE)
; |    |    |    |    |    |    |    |
; iiii xxxx yyyy oooo pppp gggg aaaa bbbb
; ; Room $9804, state $981B: Enemy population
; ; Room $9804, state $9835: Enemy population
; $A1:84ED             dx EEFF,00DB,00B3,0000,2000,0000,0000,0000, FFFF, 00
;org $A184ED
;        dw $EEFF,$0025,$00B3,$0000,$2000,$0000,$0000,$0000
;        dw $FFFF : db $00



;;; mirroring bomb torizo

;;; plm for statue which crumbles when orb is collected
; $84:D6EA             dw D606,D368   ; Bomb Torizo's crumbling chozo

;;; $D606: Setup - PLM $D6EA (Bomb Torizo's crumbling chozo) ;;;
; Delete PLM if area torizo is dead

;;; $D368: Instruction list - PLM $D6EA (Bomb Torizo's crumbling chozo) ;;;

; Used by instruction list $D368: PLM $D6EA (Bomb Torizo's crumbling chozo)
;;; display chozo statue
;;;   $7F:0002..6401: Level data (layer 1).
;;;   Word per block: ttttyxnn nnnnnnnn.
;;;   t = block type, yx are Y/X flips, n = block index
org $849877
	;; start from center of statue
        dw $0002, $8465, $8464
	;; x - 1
        db $FF, $00
        dw $0001, $8466
	;; x - 1, y - 1
        db $FF, $FF
        dw $0002, $8446, $8445
	;; x - 1, y + 1
        db $FF, $01
        dw $0003, $8449, $8448, $8447
        dw $0000

;; Used by instruction list $D368: PLM $D6EA (Bomb Torizo's crumbling chozo)
;;; clear chozo statue and one tile around 
org $84989D
	;; start from center of statue
        dw $0003, $00FF, $00FF, $00FF
	;; x - 1
        db $FF, $00
        dw $0001, $00FF
	;; x - 1, y + 1
        db $FF, $01
        dw $0004, $00FF, $00FF, $00FF, $00FF
	;; x - 1, y - 2
        db $FF, $FE
        dw $0004, $00FF, $00FF, $00FF, $00FF
	;; x - 1, y - 1
        db $FF, $FF
        dw $0004, $00FF, $00FF, $00FF, $00FF
        dw $0000

;;; $A764: Initialisation AI - enemy projectile $A993 (Bomb Torizo statue breaking) ;;;
; $86:A7AB             dw A4C3,A4D4,A4E5,A4F6,A507,A518,A529,A53A,A54B,A55C,A56D,A57E,A58F,A5A0,A5B1,A5C2 ; instruction lists
; $86:A7CB             dw 0008,0018,FFF8,0008,0018,FFF8,0008,0018,0008,FFF8,0018,0008,FFF8,0018,0008,FFF8 ; X offsets
; $86:A7EB             dw FFF8,FFF8,0008,0008,0008,0018,0018,0018 ; Y offsets
org $86A7CB
        ;; x offset
        dw $0008, $FFF8         ; top row
        dw $0018, $0008, $FFF8  ; middle row
        dw $0018, $0008, $FFF8  ; bottom row

; Enemy projectile $A993 (Bomb Torizo statue breaking)
org $8d8dfb
    dw $0001 : dw $c3f8 : db $f8 : dw $6ee0
    dw $0001 : dw $c3f8 : db $f8 : dw $6ee2
    dw $0001 : dw $c3f8 : db $f8 : dw $6ee4
    dw $0001 : dw $c3f8 : db $f8 : dw $6ee6
    dw $0001 : dw $c3f8 : db $f8 : dw $6ee8
    dw $0001 : dw $c3f8 : db $f8 : dw $6eea
    dw $0001 : dw $c3f8 : db $f8 : dw $6eec
    dw $0001 : dw $c3f8 : db $f8 : dw $6eee

;;; called from instruction list $B887, instruction $C3CC
;;; bomb torizo X positions when waking up ; PJ says these are velocities (?)
; $AA:C3EE  dw FFF7, FFFA, FFF9, 0005, FFF0, FFF9, 0000, 0000, 0009, 0006, 0007, FFFB, 0010, 0007, 0000, 0000
org $aac3ee
        dw $0009, $0006, $0007, $fffb, $0010, $0007, $0000, $0000, $fff7, $fffa, $fff9, $0005, $fff0, $fff9, $0000, $0000

;;; bomb torizo extended spritemaps when going from sitting to standing up
; $AA:AA3A             dx 0002, FFFB,FFE8,9380,885A, 0000,0000,8E43,8820
; $AA:AA4C             dx 0002, FFFB,FFE8,939B,886A, 0000,0000,8EC2,882E
; $AA:AA5E             dx 0002, FFFB,FFE8,939B,886A, 0000,0000,8F46,883C
org $AAAA3A+2
        dw $0005
org $AAAA4C+2
        dw $0005
org $AAAA5E+2
        dw $0005
;;; change spritemap of the arm which is used in regular spritemaps
;;; 9380: arm pointing left
;;; A0C5: arm pointing right
org $AAAA3A+6
        dw $A0C5
;;; 939B: arm pointing left
;;; A0FB: arm pointing right
org $AAAA4C+6
        dw $A0FB
org $AAAA5E+6
        dw $A0FB

;;; bomb torizo: switch to part of the instruction list going to the right instead
;                        80ED,B9B6               ; Go to $B9B6
org $AAB949
	dw $80ED, $BDE2

;;; golden torizo: switch to part of the instruction list going to the right instead
;                       80ED,D259               ; Go to $D259
;org $AACACA
; 	dw $80ED, $D2C9

;;; mirrored spritemaps
;;; bt sitting on the ground
org $aa8c33
    dw $001a : dw $000f : db $fa : dw $63fb : dw $0017 : db $fa : dw $63fa : dw $81f4 : db $ee : dw $6328 : dw $81f8 : db $fb : dw $2308 : dw $0006 : db $15 : dw $6362 : dw $000e : db $15 : dw $6361 : dw $0016 : db $15 : dw $6360 : dw $8009 : db $f7 : dw $a358 : dw $8001 : db $ff : dw $a347 : dw $01ff : db $12 : dw $6394 : dw $0007 : db $12 : dw $6393 : dw $81ff : db $02 : dw $6373 : dw $01f3 : db $16 : dw $63ef : dw $01eb : db $16 : dw $63fc : dw $01eb : db $0e : dw $63ff : dw $81f3 : db $06 : dw $63ed : dw $01f1 : db $e3 : dw $63cb : dw $01f9 : db $e3 : dw $63ca : dw $8001 : db $e3 : dw $63c8 : dw $8001 : db $f3 : dw $63e8 : dw $81e8 : db $06 : dw $6342 : dw $81f8 : db $06 : dw $6340 : dw $81e8 : db $f6 : dw $6322 : dw $81f8 : db $f6 : dw $6320 : dw $81e8 : db $e6 : dw $6302 : dw $81f8 : db $e6 : dw $6300
;;; bt standing up
org $aa8cb7
    dw $001a : dw $81f3 : db $f9 : dw $6306 : dw $81f3 : db $ec : dw $6326 : dw $0015 : db $03 : dw $238f : dw $000d : db $03 : dw $238e : dw $0009 : db $04 : dw $234f : dw $0001 : db $04 : dw $234e : dw $01f9 : db $04 : dw $234d : dw $01fd : db $10 : dw $6396 : dw $0005 : db $10 : dw $6395 : dw $81fd : db $00 : dw $6375 : dw $01f6 : db $01 : dw $e3ae : dw $01fe : db $01 : dw $e3ad : dw $81f6 : db $09 : dw $e3a6 : dw $01fd : db $15 : dw $6362 : dw $0005 : db $15 : dw $6361 : dw $000d : db $15 : dw $6360 : dw $01f2 : db $e4 : dw $63cb : dw $01fa : db $e4 : dw $63ca : dw $8002 : db $e4 : dw $63c8 : dw $8002 : db $f4 : dw $63e8 : dw $81e9 : db $07 : dw $6342 : dw $81f9 : db $07 : dw $6340 : dw $81e9 : db $f7 : dw $6322 : dw $81f9 : db $f7 : dw $6320 : dw $81e9 : db $e7 : dw $6302 : dw $81f9 : db $e7 : dw $6300
org $aa8d3b
    dw $001b : dw $8009 : db $0d : dw $236c : dw $81f6 : db $f4 : dw $6306 : dw $81f6 : db $e7 : dw $6326 : dw $8002 : db $07 : dw $2358 : dw $81fb : db $ff : dw $2347 : dw $01fd : db $16 : dw $6398 : dw $0005 : db $16 : dw $6397 : dw $81fd : db $06 : dw $6377 : dw $01f7 : db $1b : dw $6362 : dw $01ff : db $1b : dw $6361 : dw $0007 : db $1b : dw $6360 : dw $01f1 : db $0b : dw $e3ec : dw $01f9 : db $0b : dw $e3eb : dw $0001 : db $0b : dw $e3ea : dw $01f1 : db $03 : dw $63ec : dw $01f9 : db $03 : dw $63eb : dw $0001 : db $03 : dw $63ea : dw $01f2 : db $de : dw $63cb : dw $01fa : db $de : dw $63ca : dw $8002 : db $de : dw $63c8 : dw $8002 : db $ee : dw $63e8 : dw $81e9 : db $01 : dw $6342 : dw $81f9 : db $01 : dw $6340 : dw $81e9 : db $f1 : dw $6322 : dw $81f9 : db $f1 : dw $6320 : dw $81e9 : db $e1 : dw $6302 : dw $81f9 : db $e1 : dw $6300
org $aa8dc4
    dw $0019 : dw $81f5 : db $f1 : dw $6306 : dw $81f5 : db $e4 : dw $6326 : dw $800a : db $0a : dw $236c : dw $8003 : db $05 : dw $2358 : dw $81fc : db $fd : dw $2347 : dw $81ee : db $fb : dw $63a9 : dw $01f6 : db $0b : dw $63bb : dw $01fe : db $0b : dw $63af : dw $81f6 : db $fb : dw $63a8 : dw $01f2 : db $d9 : dw $63cb : dw $01fa : db $d9 : dw $63ca : dw $8002 : db $d9 : dw $63c8 : dw $8002 : db $e9 : dw $63e8 : dw $81e9 : db $fc : dw $6342 : dw $81f9 : db $fc : dw $6340 : dw $81e9 : db $ec : dw $6322 : dw $81f9 : db $ec : dw $6320 : dw $81e9 : db $dc : dw $6302 : dw $81f9 : db $dc : dw $6300 : dw $01f7 : db $1b : dw $6398 : dw $01ff : db $1b : dw $6397 : dw $81f7 : db $0b : dw $6377 : dw $01f0 : db $21 : dw $6362 : dw $01f8 : db $21 : dw $6361 : dw $0000 : db $21 : dw $6360
org $aa8e43
    dw $0019 : dw $01fb : db $d3 : dw $63cb : dw $0003 : db $d3 : dw $63ca : dw $800b : db $e3 : dw $63e8 : dw $800b : db $d3 : dw $63c8 : dw $01f7 : db $0f : dw $63ac : dw $01ff : db $0f : dw $63ab : dw $81f7 : db $ff : dw $63a4 : dw $01f5 : db $28 : dw $6362 : dw $01fd : db $28 : dw $6361 : dw $0005 : db $28 : dw $6360 : dw $01f6 : db $21 : dw $6396 : dw $01fe : db $21 : dw $6395 : dw $81f6 : db $11 : dw $6375 : dw $01fd : db $0e : dw $65ae : dw $0005 : db $0e : dw $65ad : dw $81fd : db $fe : dw $65a6 : dw $81f3 : db $15 : dw $658a : dw $81fb : db $0d : dw $6579 : dw $81f1 : db $1f : dw $65a2 : dw $81f2 : db $f7 : dw $6342 : dw $8002 : db $f7 : dw $6340 : dw $81f2 : db $e7 : dw $6322 : dw $8002 : db $e7 : dw $6320 : dw $81f2 : db $d7 : dw $6302 : dw $8002 : db $d7 : dw $6300
org $aa8ec2
    dw $001a : dw $01fb : db $d4 : dw $63cb : dw $0003 : db $d4 : dw $63ca : dw $800b : db $e4 : dw $63e8 : dw $800b : db $d4 : dw $63c8 : dw $01fc : db $0e : dw $23ae : dw $01f4 : db $0e : dw $23ad : dw $81f4 : db $fe : dw $23a6 : dw $01e5 : db $28 : dw $6362 : dw $01ed : db $28 : dw $6361 : dw $01f5 : db $28 : dw $6360 : dw $01eb : db $22 : dw $6398 : dw $01f3 : db $22 : dw $6397 : dw $81eb : db $12 : dw $6377 : dw $81fa : db $fc : dw $65a9 : dw $0002 : db $0c : dw $65bb : dw $000a : db $0c : dw $65af : dw $8002 : db $fc : dw $65a8 : dw $81fe : db $1f : dw $65a2 : dw $0009 : db $1f : dw $6597 : dw $8001 : db $0f : dw $6577 : dw $81f2 : db $f8 : dw $6342 : dw $8002 : db $f8 : dw $6340 : dw $81f2 : db $e8 : dw $6322 : dw $8002 : db $e8 : dw $6320 : dw $81f2 : db $d8 : dw $6302 : dw $8002 : db $d8 : dw $6300
org $aa8f46
    dw $001c : dw $01fb : db $d5 : dw $63cb : dw $0003 : db $d5 : dw $63ca : dw $800b : db $e5 : dw $63e8 : dw $800b : db $d5 : dw $63c8 : dw $01de : db $28 : dw $6362 : dw $01e6 : db $28 : dw $6361 : dw $01ee : db $28 : dw $6360 : dw $01fb : db $10 : dw $23ae : dw $01f3 : db $10 : dw $23ad : dw $81f3 : db $00 : dw $23a6 : dw $81e1 : db $1c : dw $638a : dw $81e9 : db $14 : dw $6379 : dw $000d : db $28 : dw $6562 : dw $0015 : db $28 : dw $6561 : dw $001d : db $28 : dw $6560 : dw $81f9 : db $fe : dw $65a9 : dw $0001 : db $0e : dw $65bb : dw $0009 : db $0e : dw $65af : dw $8001 : db $fe : dw $65a8 : dw $0009 : db $22 : dw $6594 : dw $0011 : db $22 : dw $6593 : dw $8009 : db $12 : dw $6573 : dw $81f2 : db $f9 : dw $6342 : dw $8002 : db $f9 : dw $6340 : dw $81f2 : db $e9 : dw $6322 : dw $8002 : db $e9 : dw $6320 : dw $81f2 : db $d9 : dw $6302 : dw $8002 : db $d9 : dw $6300
    