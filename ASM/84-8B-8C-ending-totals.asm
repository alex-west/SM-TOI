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

percent_HundredsOffset = (2*20)+($40*7)
percent_TensOffset     = (2*21)+($40*7)
percent_OnesOffset     = (2*22)+($40*7)

datalogNumberOffset = (2*21)+($40*10)
secretNumberOffset = (2*21)+($40*13)

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

    jsr countSecrets
    sec
    sbc $16
    
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
    ldx #percent_HundredsOffset
    jsr drawDigit

TENTHS:
	LDA $14						;Load tenths value
	BNE DRAWTENTHS					;If more than 0, draw tenths digit
	LDA $12						;If 0, load hundredths value
	BEQ ONETHS					;If hundredths is 0, don't draw tenths digit
	LDA $14
DRAWTENTHS:
    ldx #percent_TensOffset
    jsr drawDigit

ONETHS:
	LDA $16						;load oneths value
    ldx #percent_OnesOffset
    jsr drawDigit
    
	PLY
	PLX
	PLB
	PLP
	RTS


mapStationArray = $7ED908

drawNumber_Datalogs:
    php
    phb
    phx
    phy
    phk : plb
    stz $16 ; Arbitrary scratchpad value
    
    php
    sep #$20
    
    lda mapStationArray+1
    beq .noAddA
        inc $16
    .noAddA:
    lda mapStationArray+2
    beq .noAddB
        inc $16
    .noAddB:
    lda mapStationArray+4
    beq .noAddC
        inc $16
    .noAddC:
    lda mapStationArray+5
    beq .noAddD
        inc $16
    .noAddD:    
    
    plp
    
    lda $16
;    lda #0000
    ldx #datalogNumberOffset
    jsr drawDigit
    ply
    plx
    plb
    plp
rts

drawNumber_Secrets:
    php
    phb
    phx
    phy
    phk : plb
    jsr countSecrets
    lda $16
    ;lda #0000
    ldx #secretNumberOffset
    jsr drawDigit
    ply
    plx
    plb
    plp
rts


;warn pc, " $8BE741 percent function slack"

org $8BE741 ; Table for digit tilemaps
    digitTilemaps:

org $8BE780
endingInstruction_moveResultsDown:
    lda #$E797 ; Load next function pointer
    sta $1F51
    rts
    

org $8BF748
    dw $93D9,$93D9,seeYouNextMission_InstructionList ; See you next mission
    dw $93D9,$93D9,endingResults_InstructionList ; Item percentage


org $8BF768 ; Freespace, I hope
countSecrets:
    stz $16 ; Arbitrary scratpad value
    pha
    php
    sep #$20 ; 8-bit mode
    lda.l $7ED870+4 ; Lucky me, all the secret item bits are in the same byte
    bit #$04 ; Screw - ID 0x22
    beq .noAddA
        inc $16
    .noAddA:
    bit #$08 ; Speed - ID 0x23
    beq .noAddB
        inc $16
    .noAddB:
    bit #$10 ; Plasma - ID 0x24
    beq .noAddC
        inc $16
    .noAddC:       
    plp
    pla
rts

; Args
;  X - Tilemap offset
;  A - Digit value
drawDigit:
    asl a
    asl a
    tay
    lda digitTilemaps,y
    sta.l endTilemapBaseAddr, x
    lda digitTilemaps+2,y
    sta.l endTilemapBaseAddr+$40, x
rts

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
    dw drawNumber_Datalogs
    dw $0020 : db  22,  10 : dw draw_DatalogTotal
    
    dw $0020 : db   8,  13 : dw draw_Secrets
    dw drawNumber_Secrets
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

;warn pc, " - How close is this to $8CE1E9"

org $8CE1E9
; Don't overwrite stuff after $8C:E1E9 (bunch palettes)
