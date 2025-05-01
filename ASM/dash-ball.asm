; adapted from
;  https://github.com/Quote58/ACID-engine/blob/main/Code/extra/Project%20Base/PB_general_patches.asm
; by quote58

lorom

!C_dashball_bitmask = $0800
!W_Items_equip = $09A2
!W_Collision_flag   = $0DD0
!W_H_speed 	  	    = $0B42
!W_H_speed_sub 	    = $0B44

; Pickup PLM overrides

org $84E296 : dw !C_dashball_bitmask ; Open
org $84E6EA : dw !C_dashball_bitmask ; Chozo
org $84EBEE : dw !C_dashball_bitmask ; Shotblock

org $90854D : JSR Dash_ball					;this is where the game normally checks that samus' movement type is walk or run before deciding whether to dash
org $909774 : JSR Dash_ball					; ||
org $90A57C : JSR Midair_unmorph : NOP #3	;mid air unmorph won't reset horizontal speed

org $90F675 ; Freespace
;org $90F63A
; --- Quote58 ---
Dash_ball:
	AND #$00FF : CMP #$0001 : BEQ .end		;this is what is normally used to determine whether to dash
				 CMP #$0004 : BEQ +			; + normal ball on ground
				 CMP #$0011 : BNE .end		; + spring ball on ground
	+
	LDA !W_Items_equip : BIT #!C_dashball_bitmask 
    ;if in ball, check for item
	BNE +									;until dash ball plm is placed in the game, this ability comes with springball
	LDA #$0000								;if dash ball is not equipped, don't dash
	RTS
	+
	LDA #$0001								;if it is, all good to dash
.end
	RTS

; --- Author Unknown ---
Midair_unmorph:
	LDA !W_Collision_flag : CMP #$0001 : BNE +
	STZ !W_H_speed
	STZ !W_H_speed_sub
	+
	RTS

