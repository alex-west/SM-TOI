; Taken from PJ's banklogs
; All modifications by RT-55J

lorom

org $909E8B

;;; $9E8B: Samus physics constants ;;;
{
  dw $0AAA    ; Lava subdamage per frame ; Was $8000, now changed to 1 damage per 24 frames
  dw $0000    ; Lava damage per frame
  dw $8000    ; Acid subdamage per frame
  dw $0001    ; Acid damage per frame
  dw $0003    ; Samus animation delay in water
  dw $0002    ; Samus animation delay in lava/acid
  dw $0280    ; Space jump minimum Y velocity in air * 100h
  dw $0500    ; Space jump maximum Y velocity in air * 100h
  dw $0080    ; Space jump minimum Y velocity in water * 100h
  dw $0500    ; Space jump maximum Y velocity in water * 100h
  dw $0008    ; Maximum distance from wall for wall-jump
  dw $1C00    ; Samus Y subacceleration in air
  dw $0800    ; Samus Y subacceleration in water
  dw $0700    ; Samus Y subacceleration in acid/lava ; originally $0900
  dw $0000    ; Samus Y acceleration in air
  dw $0000    ; Samus Y acceleration in water
  dw $0000    ; Samus Y acceleration in acid/lava
  dw $0001    ; Camera X offset from Samus when turning
  dw $0000    ; Camera X suboffset from Samus when turning
  dw $0001    ; Camera Y offset from Samus when turning
  dw $0000    ; Camera X suboffset from Samus when turning
  dw $0001    ; Samus Y speed when bouncing in morph ball
  dw $0000    ; Samus Y subspeed when bouncing in morph ball

; $90:9EB9
;         _____________________________ Initial Y speed in air
;        |     ________________________ Initial Y speed in water
;        |    |     ___________________ Initial Y speed in lava/acid
;        |    |    |      _____________ Initial Y subspeed in air
;        |    |    |     |     ________ Initial Y subspeed in water
;        |    |    |     |    |     ___ Initial Y subspeed in lava/acid
;        |    |    |     |    |    |
  dw $0004,$0001,$0002, $E000,$E000,$C000 ; When jumping
  dw $0006,$0006,$0006, $0000,$0000,$0000 ; When jumping with hi-jump
  dw $0004,$0001,$0002, $A000,$4000,$A000 ; When wall-jumping
  dw $0005,$0003,$0003, $8000,$8000,$8000 ; When wall-jumping with hi-jump
  dw $0005,$0002,$0002, $0000,$0000,$0000 ; During knockback
  dw $000C,$000B,$000B, $C000,$1000,$1000 ; During bomb jump
; dw $0002,$0000,$0000, $C000,$1000,$1000 ; During bomb jump

; $90:9F01
;       _____________________________ X acceleration in air
;      |     ________________________ X acceleration in water
;      |    |     ___________________ X acceleration in lava/acid
;      |    |    |      _____________ X subacceleration in air
;      |    |    |     |     ________ X subacceleration in water
;      |    |    |     |    |     ___ X subacceleration in lava/acid
;      |    |    |     |    |    |
  dw $0000,$0000,$0000,$1000,$0600,$0600 ; When running ; Changed water/lava values from $0400 to $0600


; $90:9F0D, $90:9F19
;     _____________________________ Max X speed in air
;    |     ________________________ Max X speed in water
;    |    |     ___________________ Max X speed in lava/acid
;    |    |    |      _____________ Max X subspeed in air
;    |    |    |     |     ________ Max X subspeed in water
;    |    |    |     |    |     ___ Max X subspeed in lava/acid
;    |    |    |     |    |    |
  dw $0007,$0004,$0004, $0000,$0000,$0000 ; With speed booster
  dw $0002,$0001,$0001, $0000,$8000,$8000 ; Without speed booster

; $90:9F25, $90:9F31, $90:9F3D, $90:9F49
;     ______________________________ X acceleration
;    |     _________________________ X subacceleration
;    |    |      ___________________ Max X speed
;    |    |     |     ______________ Max X subspeed
;    |    |     |    |      ________ X deceleration
;    |    |     |    |     |     ___ X subdeceleration
;    |    |     |    |     |    |
  dw $0000,$3000, $0003,$0000, $0000,$0800 ; During diagonal bomb jump
  dw $0000,$3000, $000F,$0000, $0000,$1000 ; When disconnecting grapple beam in air
  dw $0000,$3000, $000F,$0000, $0000,$1000 ; When disconnecting grapple beam in water
  dw $0000,$3000, $000F,$0000, $0000,$1000 ; When disconnecting grapple beam in lava/acid
}


;;; $9F55: Samus X speed table - normal ;;;
{     
;         ______________________________ X acceleration
;        |     _________________________ X subacceleration
;        |    |      ___________________ Max X speed
;        |    |     |     ______________ Max X subspeed
;        |    |     |    |      ________ X deceleration
;        |    |     |    |     |     ___ X subdeceleration
;        |    |     |    |     |    |
;$90:9F55
  dw $0000,$C000,$0000,$0000,$0000,$8000  ; 0: Standing
  dw $0000,$3000,$0002,$C000,$0000,$8000  ; 1: Running
  dw $0000,$C000,$0001,$4000,$0000,$8000  ; 2: Normal jumping
  dw $0000,$C000,$0001,$6000,$0000,$8000  ; 3: Spin jumping
  dw $0000,$C000,$0003,$4000,$0000,$8000  ; 4: Morph ball - on ground
  dw $0000,$C000,$0000,$0000,$0000,$8000  ; 5: Crouching
  dw $0000,$C000,$0001,$0000,$0000,$8000  ; 6: Falling
  dw $0002,$0000,$0001,$0000,$0000,$8000  ; 7: Unused
  dw $0000,$C000,$0001,$0000,$0000,$8000  ; 8: Morph ball - falling
  dw $0002,$0000,$0002,$0000,$0000,$8000  ; 9: Unused
  dw $0001,$8000,$0005,$0000,$0000,$8000  ; Ah: Knockback / crystal flash ending
  dw $0000,$C000,$0000,$0000,$0000,$8000  ; Bh: Unused
  dw $0000,$C000,$0000,$0000,$0000,$8000  ; Ch: Unused
  dw $0000,$C000,$0002,$0000,$0000,$8000  ; Dh: Unused
  dw $0000,$C000,$0000,$0000,$0000,$8000  ; Eh: Turning around - on ground
  dw $0000,$C000,$0001,$4000,$0000,$8000  ; Fh: Crouching/standing/morphing/unmorphing transition
  dw $0000,$C000,$0000,$8000,$0000,$8000  ; 10h: Moonwalking
  dw $0000,$C000,$0003,$4000,$0000,$8000  ; 11h: Spring ball - on ground
  dw $0000,$C000,$0001,$4000,$0000,$8000  ; 12h: Spring ball - in air
  dw $0000,$C000,$0001,$0000,$0000,$8000  ; 13h: Spring ball - falling
  dw $0000,$C000,$0001,$6000,$0000,$8000  ; 14h: Wall jumping
  dw $0000,$C000,$0000,$0000,$0000,$8000  ; 15h: Ran into a wall
  dw $0000,$C000,$0001,$4000,$0000,$8000  ; 16h: Grappling
  dw $0000,$C000,$0000,$0000,$0000,$8000  ; 17h: Turning around - jumping
  dw $0000,$C000,$0000,$0000,$0000,$8000  ; 18h: Turning around - falling
  dw $0000,$C000,$0005,$0000,$0000,$8000  ; 19h: Damage boost
}


;;; $A08D: Samus X speed table - in water ;;;
{       
;          ______________________________ X acceleration
;         |     _________________________ X subacceleration
;         |    |      ___________________ Max X speed
;         |    |     |     ______________ Max X subspeed
;         |    |     |    |      ________ X deceleration
;         |    |     |    |     |     ___ X subdeceleration
;         |    |     |    |     |    |
;$90:A08D
  dw $0000,$C000,$0000,$0000,$0000,$0800  ; 0: Standing
  dw $0000,$0600,$0002,$C000,$0000,$0800  ; 1: Running
  dw $0000,$C000,$0001,$4000,$0000,$0800  ; 2: Normal jumping
  dw $0000,$C000,$0001,$6000,$0000,$0800  ; 3: Spin jumping
  dw $0000,$0600,$0002,$C000,$0000,$0800  ; 4: Morph ball - on ground
  dw $0000,$C000,$0000,$0000,$0000,$0800  ; 5: Crouching
  dw $0000,$C000,$0001,$0000,$0000,$0800  ; 6: Falling
  dw $0002,$0000,$0001,$0000,$0000,$0800  ; 7: Unused
  dw $0000,$0600,$0001,$8000,$0000,$0800  ; 8: Morph ball - falling
  dw $0002,$0000,$0002,$0000,$0000,$0800  ; 9: Unused
  dw $0001,$8000,$0005,$0000,$0000,$0800  ; Ah: Knockback / crystal flash ending
  dw $0000,$C000,$0000,$0000,$0000,$0800  ; Bh: Unused
  dw $0000,$C000,$0000,$0000,$0000,$0800  ; Ch: Unused
  dw $0000,$C000,$0002,$0000,$0000,$0800  ; Dh: Unused
  dw $0000,$C000,$0000,$0000,$0000,$0800  ; Eh: Turning around - on ground
  dw $0000,$C000,$0001,$4000,$0000,$0800  ; Fh: Crouching/standing/morphing/unmorphing transition
  dw $0000,$C000,$0000,$8000,$0000,$0800  ; 10h: Moonwalking
  dw $0000,$0600,$0002,$C000,$0000,$0800  ; 11h: Spring ball - on ground
  dw $0000,$0600,$0001,$4000,$0000,$0800  ; 12h: Spring ball - in air
  dw $0000,$0600,$0001,$8000,$0000,$0800  ; 13h: Spring ball - falling
  dw $0000,$C000,$0001,$6000,$0000,$0800  ; 14h: Wall jumping
  dw $0000,$C000,$0000,$0000,$0000,$0800  ; 15h: Ran into a wall
  dw $0000,$C000,$0001,$4000,$0000,$0800  ; 16h: Grappling
  dw $0000,$C000,$0000,$0000,$0000,$0800  ; 17h: Turning around - jumping
  dw $0000,$C000,$0000,$0000,$0000,$0800  ; 18h: Turning around - falling
  dw $0000,$C000,$0000,$8000,$0000,$0800  ; 19h: Damage boost
  dw $0000,$C000,$0005,$0000,$0000,$0800  ; 1Ah: Grabbed by Draygon
  dw $0000,$C000,$0005,$0000,$0000,$0800  ; 1Bh: Shinespark / crystal flash / drained by metroid / damaged by MB's attacks
}


;;; $A1DD: Samus X speed table - in lava/acid ;;;
{
;                        ______________________________ X acceleration
;                       |     _________________________ X subacceleration
;                       |    |      ___________________ Max X speed
;                       |    |     |     ______________ Max X subspeed
;                       |    |     |    |      ________ X deceleration
;                       |    |     |    |     |     ___ X subdeceleration
;                       |    |     |    |     |    |
;$90:A1DD
  dw $0000,$C000,$0000,$0000,$0000,$4000  ; 0: Standing
  dw $0000,$0600,$0001,$C000,$0000,$4000  ; 1: Running
  dw $0000,$C000,$0001,$4000,$0000,$4000  ; 2: Normal jumping
  dw $0000,$C000,$0001,$6000,$0000,$4000  ; 3: Spin jumping
  dw $0000,$0600,$0002,$C000,$0000,$4000  ; 4: Morph ball - on ground
  dw $0000,$C000,$0000,$0000,$0000,$4000  ; 5: Crouching
  dw $0000,$C000,$0001,$0000,$0000,$4000  ; 6: Falling
  dw $0002,$0000,$0001,$0000,$0000,$4000  ; 7: Unused
  dw $0000,$0600,$0001,$6000,$0000,$4000  ; 8: Morph ball - falling
  dw $0002,$0000,$0002,$0000,$0000,$4000  ; 9: Unused
  dw $0001,$8000,$0005,$0000,$0000,$4000  ; Ah: Knockback / crystal flash ending
  dw $0000,$C000,$0000,$0000,$0000,$4000  ; Bh: Unused
  dw $0000,$C000,$0000,$0000,$0000,$4000  ; Ch: Unused
  dw $0000,$C000,$0002,$0000,$0000,$4000  ; Dh: Unused
  dw $0000,$C000,$0000,$0000,$0000,$4000  ; Eh: Turning around - on ground
  dw $0000,$C000,$0001,$4000,$0000,$4000  ; Fh: Crouching/standing/morphing/unmorphing transition
  dw $0000,$C000,$0000,$8000,$0000,$4000  ; 10h: Moonwalking
  dw $0000,$0600,$0002,$C000,$0000,$4000  ; 11h: Spring ball - on ground
  dw $0000,$0600,$0001,$4000,$0000,$4000  ; 12h: Spring ball - in air
  dw $0000,$0600,$0001,$6000,$0000,$4000  ; 13h: Spring ball - falling
  dw $0000,$C000,$0001,$6000,$0000,$4000  ; 14h: Wall jumping
  dw $0000,$C000,$0000,$0000,$0000,$4000  ; 15h: Ran into a wall
  dw $0000,$C000,$0001,$4000,$0000,$4000  ; 16h: Grappling
  dw $0000,$C000,$0000,$0000,$0000,$4000  ; 17h: Turning around - jumping
  dw $0000,$C000,$0000,$0000,$0000,$4000  ; 18h: Turning around - falling
  dw $0000,$C000,$0000,$8000,$0000,$4000  ; 19h: Damage boost
  dw $0000,$C000,$0005,$0000,$0000,$4000  ; 1Ah: Grabbed by Draygon
  dw $0000,$C000,$0005,$0000,$0000,$4000  ; 1Bh: Shinespark / crystal flash / drained by metroid / damaged by MB's attacks
}