; Multi-elevator
;  by Ob
; Adapted by RT-55J
; Diagonal Elevators by RT-55J

!A3Freespace = $A3F311

;Free Ram
!W_elevator_index = $0E14

!W_enemy_index = $0E54

!W_samus_xpos = $0AF6

!W_elevator_xpos = $0F7A
!W_elevator_xpos_sub = $0F7C
!W_elevator_ypos = $0F7E
!W_elevator_ypos_sub = $0F80

!W_elevator_pwork0 = $0FA8 ; Initial ypos?

!W_elevator_params = $0FB4
!W_elevator_entry_ypos = $0FB6

!C_elevator_speed_hi = $0002
!C_elevator_speed_lo = $0000

lorom

org $A3951D
    ;Hijack elavator InitAI
    JMP InitHijack

org $A3952A
    ;Hijack elevator MainAI
    JMP MainHijack

org $A39548 ; Input hijack
    JMP InputHijack
    NOP #$08
InputHijackReturn:

org $A39579 ; Leaving room hijack
LeavingRoom:
    ; Check the low bits
    LDX !W_enemy_index
    LDA !W_elevator_params, x
    BIT #$0002
        BEQ .down
    JSR MoveUp
        BRA .pickXDir
    .down:
    JSR MoveDown
    
    .pickXDir:
    LDA !W_elevator_params, x
    BIT #$0004
        BEQ .tryRight
    JSR MoveLeft

    .tryRight:
    LDA !W_elevator_params, x
    BIT #$0008
        BEQ .end
    JSR MoveRight    

.end:
    ; Original Code
    JSR ElevPutSamusOnTop ; Put Samus on Elevator
RTS

; print pc ; A395B8

org $A395BC ; Entering room hijack
EnteringRoom:
    ; Move horizontally first
    LDX !W_enemy_index
    LDA !W_elevator_params, x
    BIT #$0008
        BEQ .tryRight
    JSR MoveLeft
    
    .tryRight:
    LDX !W_enemy_index
    LDA !W_elevator_params, x
    BIT #$0004
        BEQ .pickYDir
    JSR MoveRight 
    
    .pickYDir:
    LDA !W_elevator_params, x
    BIT #$0002
        BNE .down
    JSR MoveUp
    CMP !W_elevator_pwork0, x
        BCC ElevEnterStop
        BRA ElevPutSamusOnTop
    
    .down:
    JSR MoveDown
    CMP !W_elevator_pwork0, x
        BCS ElevEnterStop
        BRA ElevPutSamusOnTop
    
; print pc ; Limit A3960E

org $A395F8
    ElevEnterStop:
org $A39612
    ElevPutSamusOnTop:

org !A3Freespace
InitHijack:
    {;After door transition is confirmed,
        LDX !W_enemy_index
        ; Ob just checked horizontal distance
        ;LDA #$0010
        ;JSL $A0BB9B : BCS .notThisOne
        ; We're gonna check the upper byte of the parameters to look for a match:
        LDA !W_elevator_params, x
        AND #$FF00
        CMP !W_elevator_index : BNE .notThisOne        

    .thisElevator
        ;LDX $0E54
        ; set enemy y position to entry pos
        LDA !W_elevator_entry_ypos,x : STA !W_elevator_ypos,x 
        ; set enemy x position to samus xpos
        LDA !W_samus_xpos : STA !W_elevator_xpos,x 
        JSR ElevPutSamusOnTop  ;Put samus on elevator

    .notThisOne
        RTL
    }
    
MainHijack:
print pc, " MAIN HIJACK"
    {; Hijacked elevator 
    LDA $0785 : BNE .end ; If not in door transition
    LDA $0E16 : ORA $0E18 : BEQ .end ; If inactive
    BRA .isThisElevator

    .end
        LDA $0FA8,x : STA !W_elevator_ypos_sub,x ;Put the not in use elevator back where it's supposed to be
        RTL
    
    .stateTable
    dw $9548, $9579, $95B9, $95BC

    .isThisElevator
        ;If samus is in contact with an elevator, is it this one?
        LDX !W_enemy_index ;enemy index
        LDA #$0030 ; distance to check; carry set if the elevator is farther away
        JSL $A0BB9B : BCC .yesThisElevator

    .notThisOne
        RTL 

    .yesThisElevator
        ; Save the elevator number for this elevator
        ;PHX : PHA
        ;LDX !W_enemy_index
        LDA !W_elevator_params, x
        AND #$FF00
        STA !W_elevator_index
        ;PLA : PLX
        ;Execute regular AI
        LDA $0E18 : ASL A : TAX : JSR (.stateTable,x) : RTL
    }

MoveDown:
    LDA #$0000 : STA $0799 ; Elevator direction = down
    ;} Enemy Y position += 1.8000h
    LDA !W_elevator_ypos_sub,x : CLC : ADC #!C_elevator_speed_lo : STA !W_elevator_ypos_sub,x
    LDA !W_elevator_ypos,x :           ADC #!C_elevator_speed_hi : STA !W_elevator_ypos,x
RTS

MoveUp:
    LDA #$8000 : STA $0799 ; Elevator direction = up
    ;} Enemy Y position -= 1.8000h
    LDA !W_elevator_ypos_sub,x : SEC : SBC #!C_elevator_speed_lo : STA !W_elevator_ypos_sub,x
    LDA !W_elevator_ypos,x :           SBC #!C_elevator_speed_hi : STA !W_elevator_ypos,x
RTS

MoveLeft:
    ;LDA #$8000 : STA $0799 ; Elevator direction = up
    ;} Enemy X position -= 1.8000h
    LDA !W_elevator_xpos_sub,x : SEC : SBC #!C_elevator_speed_lo : STA !W_elevator_xpos_sub,x
    LDA !W_elevator_xpos,x :           SBC #!C_elevator_speed_hi : STA !W_elevator_xpos,x
RTS

MoveRight:
    ;LDA #$0000 : STA $0799 ; Elevator direction = down
    ;} Enemy x position += 1.8000h
    LDA !W_elevator_xpos_sub,x : CLC : ADC #!C_elevator_speed_lo : STA !W_elevator_xpos_sub,x
    LDA !W_elevator_xpos,x :           ADC #!C_elevator_speed_hi : STA !W_elevator_xpos,x
RTS

InputHijack:
    ; Read elevator direction
    LDX !W_enemy_index : LDY !W_elevator_params,x
    ; Mask out unrelated bits
    TYA : AND #$0002 : TAY
    ; Read inputs
    LDA $8F
    AND $94E2,y ; Elevator input table
JMP InputHijackReturn

; Fixes the downwards elevator inconsistency
org $82E78C : jsr hotfix ; nop #3 ; 
; STZ $0E16

; Hotfix to prevent the above from borking saves
org $82F716 ; freespace
hotfix:
    lda $0998 ; Game mode
    cmp #$0006 ; Loading game
    beq .fix        
rts
    .fix:
    stz $0e16
    rts