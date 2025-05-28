;Changes how the end percentage in calculated. Made by Sadiztyk Fish   :P

;Allows tanks with multiple values (eg. missile tanks worth either 3 or 5)
;Allows an uneven or random number of items (up to 255 separate item pickups)
;Adds a single decimal point value, to give more accurate results to random item amounts

!CollectedItems = $7ED86E
!TotalItems = #34	;TOTAL number if items in the game. This includes ALL items: missiles, upgrades, etc

LOROM

org $84889F
	JSL COLLECTTANK

org $84EFE0
COLLECTTANK:
	PHA
	LDA !CollectedItems
	INC A
	STA !CollectedItems
	PLA
	JSL $80818E
RTL

; Bank $8B stuff

endTilemapBaseAddr = $7E3000

;endTilemapBaseAddr+($40*y)+(2*x)
percent_HundredsTopAddr = endTilemapBaseAddr+(2*20)+($40*7)
percent_HundredsBotAddr = endTilemapBaseAddr+(2*20)+($40*8)
percent_TensTopAddr     = endTilemapBaseAddr+(2*21)+($40*7)
percent_TensBotAddr     = endTilemapBaseAddr+(2*21)+($40*8)
percent_OnesTopAddr     = endTilemapBaseAddr+(2*22)+($40*7)
percent_OnesBotAddr     = endTilemapBaseAddr+(2*22)+($40*8)

org $8BE627
drawNumber_Percentage:
	PHP
	PHB
	PHK
	PLB
	REP #$30
	PHX
	PHY
	SEP #$20
	STZ $12
	LDA !CollectedItems				;Load number of collected items in the game
	STA $4202
	LDA #$64					;Load #100 decimal
	STA $4203
	NOP : NOP : NOP : NOP : NOP : NOP : NOP
	REP #$20
	LDA $4216					;Load number of (collected items * 100)
	STA $4204					;Store to devisor A
	SEP #$20
	LDA !TotalItems					;Load total number of game items
	STA $4206					;Store to devisor B
	NOP : NOP : NOP : NOP : NOP : NOP : NOP
	REP #$20
	LDA $4214					;Load ((collected items * 100)/Total items) ie Item percent
	STA $4204
	LDA $4216					;Load remainder
	PHA
	SEP #$20
	LDA #$0A
	STA $4206
	NOP : NOP : NOP : NOP : NOP : NOP : NOP		;Calculate percentage / 10
	REP #$20
	LDA $4214					;Load tenths of percentage / 10 (eg, if 78, load 7, if 53, load 5)
	STA $4204					;Store value to devisor A
	LDA $4216					;Load remainder of percentage / 10 (eg, if 78, load 8, if 53, load 3)
	STA $16						;Store to $16. oneths of percentage. if 78, = 8, if 100, = 0
	SEP #$20
	LDA #$0A
	STA $4206					
	NOP : NOP : NOP : NOP : NOP : NOP : NOP		;Divide percentage by 10 again
	REP #$20
	LDA $4214					;If 100%, this will be 1
	STA $12						;Store to $12. Contains 100th of percentage. WIll only be 1 if 100% achieved
	LDA $4216					;Load remainder, which will be 0 if 100% achieved
	STA $14						;Store to $14
	PLA
	SEP #$20
	STA $4204
	LDA #$0A
	STA $4206					
	NOP : NOP : NOP : NOP : NOP : NOP : NOP		;Divide remainder by 10
	REP #$20
	LDA $4214					;load value
	STA $18					
HUNDREDTHS:
	LDA $12						;Load hundredths value
	BEQ TENTHS					;If 0, don't draw hundredths digit
	ASL A : ASL A
	TAY
	LDA $E741,y
	STA.l percent_HundredsTopAddr ;$7E339A
	LDA $E743,y
	STA.l percent_HundredsBotAddr ;$7E33DA
TENTHS:
	LDA $14						;Load tenths value
	BNE DRAWTENTHS					;If more than 0, draw tenths digit
	LDA $12						;If 0, load hundredths value
	BEQ ONETHS					;If hundredths is 0, don't draw tenths digit
	LDA $14
DRAWTENTHS:
	ASL A : ASL A
	TAY
	LDA $E741,y
	STA.l percent_TensTopAddr ;$7E339C
	LDA $E743,y
	STA.l percent_TensBotAddr ;$7E33DC
ONETHS:
	LDA $16						;load oneths value
	ASL A : ASL A
	TAY
	LDA $E741,y
	STA.l percent_OnesTopAddr ;$7E339E
	LDA $E743,y
	STA.l percent_OnesBotAddr ;$7E33DE
;	LDA #$385A					;Load decimal point sign
;	STA $7E33E0
;	LDA $18						;load one/tenths value
;	ASL A : ASL A
;	TAY
;	LDA $E741,y
;	STA $7E33A2
;	LDA $E743,y
;	STA $7E33E2

;	LDA #$386A					;draw percentage sign
;	STA $7E33A4
;	LDA #$387A
;	STA $7E33E4
    
	PLY
	PLX
	PLB
	PLP
	RTS

warn pc, " $8BE741 percent function slack"

org $8BE741 ; Table for digit tilemaps

org $8BE780
endingInstruction_moveResultsDown:
    lda #$E797 ; Load next function pointer
    sta $1F51
    rts
    

org $8BF748
    dw $93D9,$93D9,seeYouNextMission_InstructionList ; See you next mission
    dw $93D9,$93D9,endingResults_InstructionList ; Item percentage

; Bank 8C Stuff

; Start at $8C:DF5B

org $8CDF5B
; == Results Instruction List
endingResults_InstructionList:
    dw $0040 : db $00, $00 : dw draw_Nothing
    dw $0020 : db   7,   5 : dw draw_Results
    
    dw $0020 : db   8,   7 : dw draw_Items
    dw drawNumber_Percentage ; Draw Item Percentage
    dw $0020 : db   23,  7 : dw draw_PercentSign
    
    dw $0020 : db   8,  10 : dw draw_Datalogs
    ;dw drawNumber_Datalogs
    dw $0020 : db  22,  10 : dw draw_DatalogTotal
    
    dw $0020 : db   8,  13 : dw draw_Secrets
    ;dw drawNumber_Secrets
    dw $0020 : db  22,  13 : dw draw_SecretsTotal
    
    dw $0080 : db $00, $00 : dw draw_Nothing
    dw endingInstruction_moveResultsDown
    dw $9698 ; Delete object

seeYouNextMission_InstructionList:
    dw $0040 : db $00, $00 : dw draw_Nothing
    dw $0004 : db   5, $02 : dw draw_seeYou_A ; "A"
    dw $0004 : db   6, $02 : dw draw_seeYou_L ; "L"
    dw $0004 : db   7, $02 : dw draw_seeYou_L ; "L"
    dw $0004 : db   8, $02 : dw draw_seeYou_A ; "A"
    dw $0004 : db   9, $02 : dw draw_Nothing  ; " "
    dw $0004 : db  10, $02 : dw draw_seeYou_P ; "P"
    dw $0004 : db  11, $02 : dw draw_seeYou_R ; "R"
    dw $0004 : db  12, $02 : dw draw_seeYou_O ; "O"
    dw $0004 : db  13, $02 : dw draw_seeYou_S ; "S"
    dw $0004 : db  14, $02 : dw draw_seeYou_S ; "S"
    dw $0004 : db  15, $02 : dw draw_seeYou_I ; "I"
    dw $0004 : db  16, $02 : dw draw_seeYou_M ; "M"
    dw $0004 : db  17, $02 : dw draw_seeYou_A ; "A"
    dw $0004 : db  18, $02 : dw draw_Nothing  ; " "
    dw $0004 : db  19, $02 : dw draw_seeYou_M ; "M"
    dw $0004 : db  20, $02 : dw draw_seeYou_I ; "I"
    dw $0004 : db  21, $02 : dw draw_seeYou_S ; "S"
    dw $0004 : db  22, $02 : dw draw_seeYou_S ; "S"
    dw $0004 : db  23, $02 : dw draw_seeYou_I ; "I"
    dw $0004 : db  24, $02 : dw draw_seeYou_O ; "O"
    dw $0004 : db  25, $02 : dw draw_seeYou_N ; "N"
    dw $0004 : db  26, $02 : dw draw_seeYou_E ; "E"
    
    dw $9698 ; Delete object

; == Cinematic Draw Instructions (Results)
draw_Nothing:
    dw $8849 ; Routine in bank $8B
draw_Results:
    dw $88B7 : db $07, $01
    dw $3C11, $3C04, $3C12, $3C14, $3C0B, $3C13, $3C12
draw_Items:
    dw $88B7 : db $05, $02
    dw $3C28, $3C43, $3C24, $3C2C, $3C42
    dw $3C38, $3C53, $3C34, $3C3C, $3C52
draw_PercentSign:
    dw $88B7 : db $01, $02
    dw $386A
    dw $387A
draw_Datalogs:
    dw $88B7 : db $08, $02
    dw $3C23, $3C20, $3C43, $3C20, $3C2B, $3C2E, $3C26, $3C42
    dw $3C33, $3C30, $3C53, $3C30, $3C3B, $3C3E, $3C36, $3C52
draw_DatalogTotal:
    dw $88B7 : db $02, $02
    dw $385B, $3864
    dw $386B, $3874
draw_Secrets:
    dw $88B7 : db $07, $02
    dw $3C42, $3C24, $3C22, $3C41, $3C24, $3C43, $3C42
    dw $3C52, $3C34, $3C32, $3C51, $3C34, $3C53, $3C52
draw_SecretsTotal:
    dw $88B7 : db $02, $02
    dw $385B, $3863
    dw $386B, $3873

; == Cinematic Draw Instructions (See Ya)
draw_seeYou_A:
    dw $88B7 : db $01, $02
    dw $2020, $2030
draw_seeYou_E:
    dw $88B7 : db $01, $02
    dw $2024, $2034
draw_seeYou_I:
    dw $88B7 : db $01, $02
    dw $2028, $2038
draw_seeYou_L:
    dw $88B7 : db $01, $02
    dw $202B, $203B
draw_seeYou_M:
    dw $88B7 : db $01, $02
    dw $202C, $203C
draw_seeYou_N:
    dw $88B7 : db $01, $02
    dw $202D, $203D
draw_seeYou_O:
    dw $88B7 : db $01, $02
    dw $202E, $203E
draw_seeYou_P:
    dw $88B7 : db $01, $02
    dw $202F, $203F
draw_seeYou_R:
    dw $88B7 : db $01, $02
    dw $2041, $2051
draw_seeYou_S:
    dw $88B7 : db $01, $02
    dw $2042, $2052

warn pc, " - How close is this to $8CE1E9"

;        A       L       L       A   _       P       R       O       S   S       I       M       A   _       M       I   S       S       I       O       N   E
;    dw $0020, $002B, $002B, $0020, $007F, $002F, $0041, $002E, $0042, $0042, $0028, $002C, $0020, $007F, $002C, $0028, $0042, $0042, $0028, $002E, $002D, $0024
;    dw $0030, $003B, $003B, $0030, $007F, $003F, $0051, $003E, $0052, $0052, $0038, $003C, $0030, $007F, $003C, $0038, $0052, $0052, $0038, $003E, $003D, $0034


org $8CE1E9
; Don't overwrite stuff after $8C:E1E9 (bunch palettes)

;; See You Next Mission
;    dw $0020, $002B, $002B, $0020, $007F, $002F, $0041, $002E, $0042, $0042, $0028, $002C, $0020, $007F, $002C, $0028, $0042, $0042, $0028, $002E, $002D, $0024
;    dw $0030, $003B, $003B, $0030, $007F, $003F, $0051, $003E, $0052, $0052, $0038, $003C, $0030, $007F, $003C, $0038, $0052, $0052, $0038, $003E, $003D, $0034
;;Results
;    dw $1811, $1804, $1812, $1814, $180B, $1813, $1812
;;Items
;    dw $1828, $1843, $1824, $182C, $1842 
;    dw $1838, $1853, $1834, $183C, $1852 
;;Datalogs
;    dw $1823, $1820, $1843, $1820, $182B, $182E, $1826, $1842 
;    dw $1833, $1830, $1853, $1830, $183B, $183E, $1836, $1852 
;;Secrets
;    dw $1842, $1824, $1822, $1841, $1824, $1843, $1842
;    dw $1852, $1834, $1832, $1851, $1834, $1853, $1852
;; 100%
;    $1461, $1460, $1460, $146A
;    $1471, $1470, $1470, $147A
;; 4/4
;    dw $1464, $145B, $1464
;    dw $1474, $146B, $1474
;; 3/3
;    dw $1463, $145B, $1463
;    dw $1473, $146B, $1473



;   dw $207F, $207F, $207F, $207F, $207F, $2020, $202B, $202B, $2020, $207F, $202F, $2041, $202E, $2042, $2042, $2028, $202C, $2020, $207F, $202C, $2028, $2042, $2042, $2028, $202E, $202D, $2024, $207F, $207F, $207F, $207F, $207F,
;   dw $207F, $207F, $207F, $207F, $207F, $2030, $203B, $203B, $2030, $207F, $203F, $2051, $203E, $2052, $2052, $2038, $203C, $2030, $207F, $203C, $2038, $2052, $2052, $2038, $203E, $203D, $2034, $207F, $207F, $207F, $207F, $207F,
;
;   dw $207F, $207F, $207F, $207F, $207F, $207F, $207F, $3C11, $3C04, $3C12, $3C14, $3C0B, $3C13, $3C12, $207F, $207F, $207F, $207F, $207F, $207F, $207F, $207F, $207F, $207F, $207F, $207F, $207F, $207F, $207F, $207F, $207F, $207F,
;
;   dw $3C28, $3C43, $3C24, $3C2C, $3C42, $207F, $207F, $207F, $207F, $207F, $207F, $207F, $3861, $3860, $3860, $386A
;   dw $3C38, $3C53, $3C34, $3C3C, $3C52, $207F, $207F, $207F, $207F, $207F, $207F, $207F, $3871, $3870, $3870, $387A
;
;   dw $3C23, $3C20, $3C43, $3C20, $3C2B, $3C2E, $3C26, $3C42, $3C7F, $207F, $207F, $207F, $207F, $3864, $385B, $3864
;   dw $3C33, $3C30, $3C53, $3C30, $3C3B, $3C3E, $3C36, $3C52, $207F, $207F, $207F, $207F, $207F, $3874, $386B, $3874
;
;   dw $3C42, $3C24, $3C22, $3C41, $3C24, $3C43, $3C42, $207F, $207F, $207F, $207F, $207F, $207F, $3863, $385B, $3863
;   dw $3C52, $3C34, $3C32, $3C51, $3C34, $3C53, $3C52, $207F, $207F, $207F, $207F, $207F, $207F, $3873, $386B, $3873
;
;; Items
;dw $3C28, $3C43, $3C24, $3C2C, $3C42
;dw $3C38, $3C53, $3C34, $3C3C, $3C52
;; Datalogs
;dw $3C23, $3C20, $3C43, $3C20, $3C2B, $3C2E, $3C26, $3C42
;dw $3C33, $3C30, $3C53, $3C30, $3C3B, $3C3E, $3C36, $3C52
;; Results
;dw $3C42, $3C24, $3C22, $3C41, $3C24, $3C43, $3C42
;dw $3C52, $3C34, $3C32, $3C51, $3C34, $3C53, $3C52
;; Percent
;dw $386A
;dw $387A
;; Datalog Total
;dw $385B, $3864
;dw $386B, $3874
;; Secret Total
;dw $385B, $3863
;dw $386B, $3873