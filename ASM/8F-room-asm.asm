; Room ASM

lorom

;!location  = $f000        ;place in 8f for the thing
!scroll_RAM_start = $7ECD20 
;!xpos      = $0720        ;samus x position to check for

org $8FE99B  ; Freespace

Pistachio_BottomElev_Main: ; thanks neen
print pc, " - Bottom Pistachio Elev Main ASM"
    lda $0af6 ; Samus X pos
    cmp #$0718 ;;#!xpos
        bmi .setscroll
    rts
    
    .setscroll:
    sep #$20
        lda #$02
        sta !scroll_RAM_start+9
        sta !scroll_RAM_start+10
        sta !scroll_RAM_start+46
    rep #$20
    stz $07df ; Clear the Main ASM pointer
rts

Cherry_BottomElev_Main: ; thanks neen
print pc, " - Bottom Cherry Elev Main ASM"
    lda $0af6 ; Samus X pos
    cmp #$0100-18 ;;#!xpos
        bpl .setscroll
    rts
    
    .setscroll:
    sep #$20
        lda #$02
        sta !scroll_RAM_start+13
        sta !scroll_RAM_start+14
        sta !scroll_RAM_start+41
    rep #$20
    stz $07df ; Clear the Main ASM pointer
rts

End_TopHub_Main:
print pc, " - End Area Top Hub Main ASM"
    ; Never run if Samus's y-pos is out of range
    lda $0AFA ; Samus Y pos
    cmp #$0100
        bmi .clear
    cmp #$0300
        bpl .clear
    
    ; Only run if Samus's x-pos is within range of ~$100-$400
    lda $0af6 ; Samus X pos
    cmp #$0100
        bmi .exit
    cmp #$0400
        bpl .exit
    
    .setScroll:
    sep #$20
        lda #$02
        sta !scroll_RAM_start+6
        sta !scroll_RAM_start+8
        lda #$00
        sta !scroll_RAM_start+1
    rep #$20
    .clear:
    stz $07df ; Clear the Main ASM pointer
    .exit:
rts

Pistachio_FloodedTower_Init:
print pc, " - Pistachio Flooded Tower Init ASM"
    lda $0AFA ; Samus Y pos
    cmp #$0480 ; random point halfway through room
        bmi .exit ; exit if above that point
    ; Set earthquake type
    lda #$000B : sta $183E
    ; Set earthquake timer and sound timer
    lda #$0080 : sta $1840
    ;nop #3
    ;;sta $0609
    ;; Queue lavaquake sound
    ;nop #6
    ;;lda #$0046 : sta $0607
    .exit: 
rts

;Pistachio_FloodedTower_Main:
;print pc, " - Pistachio Flooded Tower Main ASM"
;    jsl HandleEarthquakeSound_stub
;rts

;org $88EE32
;HandleEarthquakeSound_stub:
;    jsr $B21D
;rtl


;---------------------Event Trigger Alarm Zebes Timer----------------------------------------
;Code by FullOfFail, Scyzer, JAM, Smiley, Jathys, Mon732, and PJBoy.
;Other code featured by Black Falcon, and dewhi100
;Special thanks to Insane Firebat for helping me figure out how to use events as conditions
;Modifications by OmegaDragnet7

;Ideally this can be triggered with Benox50's Extended Event PLM
;Be sure to reference the RAM Map, beginning at $7ED820

;org !ZebesEventTrigger ;Room ASM
print pc, " - Event Escape Trigger Room ASM"

!ZebesTimerLength = #$0400 		;Unused spot in RAM
!EventToCheck = #$000E

!Ceres = #$0001					;Triggers Ceres alarm
!Zebes = #$0002					;Triggers Zebes alarm

!RoomShake = $C946 
!RoomShakeExplosion = $C124

EventTrigger:

.EventSet 
;Included are possible events. Comment one or the other. 
    ; Check event 20
	LDA !EventToCheck : JSL $808233 : BCC .End
    
	;LDA $7ED821 : BIT #$0040 : BEQ .End 
	;Sets Event 0E, which would make the other Event Script redundant
	
	;LDA $7ED820 : BIT #$0001 : BEQ .End 
	;Zebes is awake Event

;.ChangeTimer
;LDA #$0300
;STA !ZebesTimerLength
.ChangeMusic
	LDA #$0000 : JSL $808FC1
	LDA #$FF24 : JSL $808FC1
	LDA #$0007 : JSL $808FC1
.LoadTimer
    LDX $0330
	LDA #$0400 : STA $D0,X
	LDA #$C000 : STA $D2,X
	LDA #$B0B0 : STA $D4,X
	LDA #$7E00 : STA $D5,X
	TXA : CLC : ADC #$0007 : STA $0330
.RunTimer
	LDA !Zebes : STA $0943
	LDA #$E0E6 : STA $0A5A
.ClearFX2Pointer
	STZ $07DF
.RoomShake
	JSR !RoomShakeExplosion 				
	
.End RTS

;----------------------------Timer Lengths---------------------------------------------------

;Zebes Timer Length
;Points to Unuses space in RAM
;Entirely customizable on a script by script basis.

org $809E20 
LDA !ZebesTimerLength ;3 minutes, zero seconds in Vanilla