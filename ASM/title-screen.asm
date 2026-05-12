; Title Screen edits
lorom

; !!!!!!!!!!!!!!!!! UGLY HACK !!!!!!!!!!!!!!!!!
; Sure. Just fundamentally modify a sprite drawing routine, will ya?
org $81882B
    nop : nop : nop ;AND #$F1FF
    ; eor $16 ; ORA $16 ; This change would have some big ramifications

; === Bank 8B ===
; Code and instruction lists

; Palette indeces
org $8B9CC8 : LDA #$0000 ;#$0200
org $8B9D56 : LDA #$0000 ;#$0200
org $8B9DCF : LDA #$0000 ;#$0200
org $8B9E51 : LDA #$0000 ;#$0200

org $8B9EC8 ;: rts
    JSL $8DC4E9 ;-- get rid of fade in effect for title

;;; $A03D: Instruction list - cinematic sprite object $A0EF ('1994' scrolling text) ;;;
{
org $8BA03D ; 2024-2026
    dw $001C,$0000 ; Wait?
    dw $0020,spr_2024
    dw $0020,spr_2024dash
    dw $0025,spr_2024dash2026
    dw $9CE1        ; Trigger title sequence scene 0
    dw $9438        ; Delete
} ; OG Timing: $3C,8,8,8,$2D


;;; $A055: Instruction list - cinematic sprite object $A0F5 ('NINTENDO' scrolling text) ;;;
{
org $8BA055 ; PRESENTING
    dw $0020,spr_pre
    dw $0020,spr_present
    dw $0025,spr_presenting
    dw $9D5D        ; Trigger title sequence scene 1
    dw $9438        ; Delete
} ; OG Timing 8,8,8,8,8,8,8,$2D = $65


;;; $A079: Instruction list - cinematic sprite object $A0FB ('PRESENTS' scrolling text) ;;;
{
org $8BA079 ; PROJECT ITALY
    dw $0020,spr_proj
    dw $0020,spr_projecti
    dw $0025,spr_projectitaly
    dw $9DD6        ; Trigger title sequence scene 2
    dw $9438        ; Delete
} ; OG Timing 8,8,8,8,8,8,8,$2D = $65


;;; $A09D: Instruction list - cinematic sprite object $A101 ('METROID 3' scrolling text) ;;;
{
org $8BA09D ; METROID 4.5
    dw $0020,spr_met
    dw $0020,spr_metroid
    dw $00A8,spr_metroid4point5
    dw $9E58        ; Trigger title sequence scene 3
    dw $9438        ; Delete
} ; OG Timing 8,8,8,8,8,8,8,8,$78 = $B8

; === BANK 8C ===
; Spritemaps

org $8C80BB ; Boot logo spritemap
    DW $000E
    DB $B7,$81,$F8,$90,$00
    DB $C7,$81,$F8,$92,$00
    DB $D7,$81,$F8,$94,$00
    DB $E7,$81,$F8,$96,$00
    DB $F7,$81,$F8,$98,$00
    DB $07,$80,$F8,$9A,$00
    DB $17,$80,$F8,$9C,$00
    DB $27,$80,$F8,$9E,$00
    DB $37,$80,$F8,$B0,$00
    DB $3F,$80,$F8,$B1,$00
    DB $EC,$01,$F0,$B3,$00
    DB $17,$00,$F0,$B3,$00
    DB $1B,$00,$F0,$B3,$00
    DB $1F,$00,$F0,$B3,$00


org $8C879D ; Tour of Italy spritemap
    DW $000F
    DB $6D,$80,$F0,$4A,$34
    DB $5D,$80,$F0,$48,$34
    DB $4D,$80,$F0,$46,$34
    DB $3D,$80,$F0,$44,$34
    DB $2D,$80,$F0,$42,$34
    DB $1D,$80,$F0,$40,$34
    DB $0B,$80,$F0,$24,$34
    DB $FB,$81,$F0,$22,$34
    DB $EB,$81,$F0,$20,$34
    DB $DB,$81,$F0,$0A,$34
    DB $CB,$81,$F0,$08,$34
    DB $BB,$81,$F0,$06,$34
    DB $AB,$81,$F0,$04,$34
    DB $9B,$81,$F0,$02,$34
    DB $8B,$81,$F0,$00,$34

org $8C8862 ; Pre-title text spritemaps

spr_2024dash2026:
  DW $0009
  DW $8031 : DB $F8 : DW $0708
  DW $8024 : DB $F8 : DW $0702
  DW $8019 : DB $F8 : DW $0700
  DW $800C : DB $F8 : DW $0702
  DW $01FC : DB $FC : DW $030A
  DW $81E8 : DB $F8 : DW $0504
  DW $81DB : DB $F8 : DW $0502
  DW $81D0 : DB $F8 : DW $0500
  DW $81C3 : DB $F8 : DW $0502
spr_2024dash:
  DW $0005
  DW $01FC : DB $FC : DW $030A
  DW $81E8 : DB $F8 : DW $0504
  DW $81DB : DB $F8 : DW $0502
  DW $81D0 : DB $F8 : DW $0500
  DW $81C3 : DB $F8 : DW $0502
spr_2024:
  DW $0004
  DW $81E8 : DB $F8 : DW $0504
  DW $81DB : DB $F8 : DW $0502
  DW $81D0 : DB $F8 : DW $0500
  DW $81C3 : DB $F8 : DW $0502

spr_presenting:
  DW $000A
  DW $8037 : DB $F8 : DW $0728
  DW $8027 : DB $F8 : DW $0744
  DW $801F : DB $F8 : DW $072A
  DW $8011 : DB $F8 : DW $034E
  DW $8000 : DB $F8 : DW $0344
  DW $81F2 : DB $F8 : DW $0326
  DW $81E6 : DB $F8 : DW $034C
  DW $81D8 : DB $F8 : DW $0526
  DW $81C8 : DB $F8 : DW $054A
  DW $81BA : DB $F8 : DW $0548
spr_present:
  DW $0007
  DW $8011 : DB $F8 : DW $034E
  DW $8000 : DB $F8 : DW $0344
  DW $81F2 : DB $F8 : DW $0326
  DW $81E6 : DB $F8 : DW $034C
  DW $81D8 : DB $F8 : DW $0526
  DW $81C8 : DB $F8 : DW $054A
  DW $81BA : DB $F8 : DW $0548
spr_pre:
  DW $0003
  DW $81D8 : DB $F8 : DW $0526
  DW $81C8 : DB $F8 : DW $054A
  DW $81BA : DB $F8 : DW $0548

spr_projectitaly:
  DW $000D
  DW $8045 : DB $F8 : DW $070E
  DW $803A : DB $F8 : DW $072E
  DW $8028 : DB $F8 : DW $0720
  DW $801C : DB $F8 : DW $074E
  DW $8014 : DB $F8 : DW $032A
  DW $8000 : DB $F8 : DW $034E
  DW $81F0 : DB $F8 : DW $0322
  DW $81E2 : DB $F8 : DW $0326
  DW $01D9 : DB $06 : DW $053C
  DW $81D9 : DB $F6 : DW $051C
  DW $81C8 : DB $F8 : DW $0546
  DW $81B8 : DB $F8 : DW $054A
  DW $81AA : DB $F8 : DW $0548
spr_projecti:
  DW $0009
  DW $8014 : DB $F8 : DW $032A
  DW $8000 : DB $F8 : DW $034E
  DW $81F0 : DB $F8 : DW $0322
  DW $81E2 : DB $F8 : DW $0326
  DW $01D9 : DB $06 : DW $053C
  DW $81D9 : DB $F6 : DW $051C
  DW $81C8 : DB $F8 : DW $0546
  DW $81B8 : DB $F8 : DW $054A
  DW $81AA : DB $F8 : DW $0548
spr_proj:
  DW $0005
  DW $01D9 : DB $06 : DW $053C
  DW $81D9 : DB $F6 : DW $051C
  DW $81C8 : DB $F8 : DW $0546
  DW $81B8 : DB $F8 : DW $054A
  DW $81AA : DB $F8 : DW $0548

spr_metroid4point5:
  DW $000B
  DW $803D : DB $F8 : DW $0706
  DW $0039 : DB $00 : DW $071A
  DW $802B : DB $F8 : DW $0704
  DW $8014 : DB $F8 : DW $0324
  DW $800C : DB $F8 : DW $032A
  DW $81FB : DB $F8 : DW $0346
  DW $81EB : DB $F8 : DW $034A
  DW $81DD : DB $F8 : DW $054E
  DW $81CF : DB $F8 : DW $0526
  DW $81C1 : DB $F8 : DW $0541
  DW $81B9 : DB $F8 : DW $0540
spr_metroid:
  DW $0008
  DW $8014 : DB $F8 : DW $0324
  DW $800C : DB $F8 : DW $032A
  DW $81FB : DB $F8 : DW $0346
  DW $81EB : DB $F8 : DW $034A
  DW $81DD : DB $F8 : DW $054E
  DW $81CF : DB $F8 : DW $0526
  DW $81C1 : DB $F8 : DW $0541
  DW $81B9 : DB $F8 : DW $0540
spr_met:
  DW $0004
  DW $81DD : DB $F8 : DW $054E
  DW $81CF : DB $F8 : DW $0526
  DW $81C1 : DB $F8 : DW $0541
  DW $81B9 : DB $F8 : DW $0540

warnpc $8C8C00

org $8CE1E9 ;;; $E1E9: Palettes - title screen ;;;
    dw $0000,$02DF,$01D7,$00AC,$5EBB,$3DB3,$292E,$1486,$48FB,$48FB,$7FFF,$0000,$7FFF,$44E5,$7FFF,$0000
    dw $1000,$0BB1,$1EA9,$0145,$5EBB,$3DB3,$292E,$1486,$6318,$4A52,$318C,$0000,$6318,$02DF,$7FFF,$0000
    dw $1000,$7E20,$6560,$2060,$1000,$7940,$5D00,$4CA0,$3CA0,$7FFF,$0113,$000F,$175C,$0299,$13FF,$0BB1
    dw $1000,$6BF5,$2E41,$2DA1,$2D01,$5E5F,$183F,$1014,$080A,$0404,$4F9F,$3ED8,$2E12,$6F70,$7FFF,$5EE0
    dw $1000,$7C00,$5800,$3400,$1000,$6C00,$4800,$2400,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
    dw $1000,$3570,$24CB,$0402,$0401,$312E,$1889,$1026,$0C04,$43FF,$0118,$0014,$16FF,$023E,$017B,$5EE0
    dw $1000,$72F2,$6A4D,$4524,$1400,$5E5F,$2C3F,$2414,$1C0A,$6B5E,$4E78,$2991,$6A99,$4174,$400F,$0040
    dw $1000,$033B,$001F,$0174,$080A,$7FFF,$0D66,$00E2,$0299,$0000,$0000,$0000,$0000,$0000,$7FFF,$0000

    ;dw $1000,$7FFF,$13FF,$131D,$121F,$093F,$00BF,$0017,$0C8C,$7FFF,$7D80,$6F5A,$5AB5,$4A10,$354A,$1000
    dw $1000,$1400,$6800,$7021,$7442,$7C63,$7C84,$7CC6,$7D08,$7D29,$7D80,$0101,$0101,$0101,$0101,$7FFF
    dw $1000,$7FFF,$13FF,$131D,$121F,$093F,$00BF,$0017,$0C8C,$001F,$2000,$6F5A,$5AB5,$4A10,$354A,$1000
    dw $1000,$2220,$77BD,$18B9, $1140,$39CE,$0C4C, $0CC0,$14A5,$1007, $7E20, $2220,$77BD,$18B9, $354A,$1000
    ;dw $1000,$7FFF,$13FF,$0F5F,$0EBF,$0A1F,$055F,$04BF,$001F,$0018,$1032,$204C,$3066,$5AB5,$354A,$1000
    dw $1000,$189B,$2E41,$2DA1,$2D01,$5E5F,$183F,$1014,$080A,$0404,$4F9F,$3ED8,$2E12,$6F70,$7FFF,$5EE0
    ;dw $1000,$6BF5,$2E41,$2DA1,$2D01,$5E5F,$183F,$1014,$080A,$0404,$4F9F,$3ED8,$2E12,$6F70,$7FFF,$5EE0
    dw $1000,$7C00,$5800,$3400,$1000,$6C00,$4800,$2400,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
    dw $1000,$3570,$24CB,$0402,$0401,$312E,$1889,$1026,$0C04,$43FF,$0118,$0014,$16FF,$023E,$017B,$5EE0
    dw $1000,$72F2,$6A4D,$4524,$1400,$5E5F,$2C3F,$2414,$1C0A,$6B5E,$4E78,$2991,$0299,$0174,$000F,$0040
    dw $1000,$033B,$001F,$0174,$080A,$7FFF,$0D66,$00E2,$0299,$0000,$0000,$0000,$0000,$0000,$7FFF,$0000
    
    
;;; $C696: Instruction list - palette FX object $E194 (fade in Super Metroid title logo) ;;;
;{
org $8DC696             
    dw $C655,$0142  ; Palette FX object colour index = 0142h
    dw $0003
    dw $2220,$77BD,$18B9, $1140,$39CE,$0C4C, $0CC0,$14A5,$1007, $7E20, $0000,$0000,$0000, $0000,$0000
    ;dw    0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,
    dw $C595 ; Done
    dw $0003
    dw $2220,$77BD,$18B9, $1140,$39CE,$0C4C, $0CC0,$14A5,$1007, $7E20, $0460,$0C63,$0004, $0000,$0000
;    dw    1084,0084,0064,0064,0044,0024,0004,0004,0003,0002,0401,0400,0C63,0421,0000,
    dw $C595 ; Done
    dw $0003
    dw $2220,$77BD,$18B9, $1140,$39CE,$0C4C, $0CC0,$14A5,$1007, $7E20, $0CC0,$2108,$0408, $0000,$0000
;    dw    2108,0508,00E8,00C8,0088,0048,0028,0008,0006,0405,0803,0C01,18C6,0C42,0400,
    dw $C595 ; Done
    dw $0003
    dw $2220,$77BD,$18B9, $1140,$39CE,$0C4C, $0CC0,$14A5,$1007, $7E20, $1100,$318C,$082D, $0000,$0000
    ;dw    35AD,05AD,056D,052D,00CD,008D,004D,000D,000A,0407,0C05,1422,2529,1484,0400,
    dw $C595 ; Done
    dw $0003
    dw $2220,$77BD,$18B9, $1140,$39CE,$0C4C, $0CC0,$14A5,$1007, $7E20, $1540,$4631,$0C50, $0000,$0000
    ;dw    4631,0A31,05D1,0591,0531,00B1,0051,0011,000D,080A,1026,1823,318C,1CA5,0800,
    dw $C595 ; Done
    dw $0003
    dw $2220,$77BD,$18B9, $1140,$39CE,$0C4C, $0CC0,$14A5,$1007, $7E20, $1980,$56B5,$1072, $0000,$0000
;    dw    5AD6,0AD6,0A56,09F6,0576,00F6,0076,0016,0011,080C,1428,2044,3DEF,24E7,0800,
    dw $C595 ; Done
    dw $0003
    dw $2220,$77BD,$18B9, $1140,$39CE,$0C4C, $0CC0,$14A5,$1007, $7E20, $1DC0,$6739,$1495, $0000,$0000
;    dw    6B5A,0F5A,0ADA,0A5A,05BA,011A,009A,001A,0014,0C0F,182A,2845,4A52,2D08,0C00,
    dw $C595 ; Done
    dw $0003
    dw $2220,$77BD,$18B9, $1140,$39CE,$0C4C, $0CC0,$14A5,$1007, $7E20, $2220,$77BD,$18B9, $0000,$0000
    ;dw    7FFF,13FF,0F5F,0EBF,0A1F,055F,04BF,001F,0018,1032,204C,3066,5AB5,354A,1000,
    dw $C595 ; Done
    dw $C5CF ; Delete
    
org $9580D8
    incbin "./title-sprites.bin"