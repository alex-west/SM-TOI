; Custom gate switch plm resource by Tundain, credits to Smiley for original code and Oi27 for making msg box able to play sfx
;This resource adds gate switches like in hyper metroid or super metroid: exertion
; you can choose which msg box to display, which sound effect to play, and if you want you can make the msg box display a number to tell the player how many gates are left
; for more instruction, look further down
; important: the gate switch plm doesn't have any collision or gfx, you just need to add those yourself in the editor


;Switch Plm parameters 
;high byte: X0XX = bue switch, X1XX = red switch, X2XX = green switch, X3XX = yellow switch
;Low byte:= door ID to open

;Gate plm parameters: = door ID to check

lorom
!MsgBoxId = #$001D ; which msg box to show
!MsgBoxIdB = #$001E ; Message Box to show if not adjusting gate count
!GateSwitchFreespace = $84F300 ; repoint to freespace in bank $84, use as your switch plm 
!GatePlmFreespace = $84F1E0 ; repoint to freespace in bank $84, use as gate plm
!Sfxtoplay = #$000E ; sfx id to play, currently it's the gate trigered sound, bc i use library 3
; for a list with all possible sound effects, go to --> https://patrickjohnston.org/ASM/Lists/Super%20Metroid/Sound%20effects.asm

; only use the next values if you want your msg box to display a value based of how many gates you've opened
!MsgBocCodeFreespace = $8596D0 ;--set as your msg box's drawcode
!GateAmount = #$0006 ; how many gates to use in your hack, max = 20 ($14) (although, if you understand the digit tables at the bottom, you know how to add more)
!Bank80Freespace = $80D000 ;freespace in bank $80, duh


;---gate switch code---------------
; It's important to understand that these plms use door id's to keep track of whether they're unlocked or nothing
; the argument for the gate switch plm is which door ID you unlock (so if you for example have a door with the same id, it wil also get unlocked)
org !GateSwitchFreespace
DW Init : DW Main

Init:
  PHY
  LDA $1DC7,y
  AND #$FF00
  STA $1E17,y
  LDA $1DC7,y ;PLM Room argument
  AND #$00FF
  STA $1DC7,y
  JSL $80818E
  LDA $7ED8B0,x ;Opened door bit array
  PLY
  AND $05E7 : BNE + ;Often used to check bits for completed tasks/picked up items

  LDX $1C87,y ; PLM's location in the room (nth block * 2)
  LDA #$C044 : JSR $82B4 ;Set BTS so projectile detection works
  RTS
+
  LDA #$0000 : STA $1C27,y ;Gate already opened, delete switch
  RTS

Main:
  DW $8A24, OpenGate  ;Run this when hit by projectile
  DW $86C1, Detection  ;Test for projectiles
MainWait:
  DW $86B4 ;Wait

OpenGate:
print "opzengate: ",pc
  DW $8A91 : DB $01 : DW End ;Increment hit counter. If at least as much as the argument (1 byte), set the door as opened, 
                             ;disable preplm code, and goto the second argument
  DW $8724, MainWait  ;Goes back to waiting (if needs more than one shot for any reason)

End:
  DW DisplayMessage
  DW $86BC ;Delete

Detection:
print "ProjectileDetection",pc
  LDA $1E17,x
  AND #$0F00
  CMP #$0100
  BEQ superOrmissiles
  CMP #$0200
  BEQ superMissiles
;  CMP #$0300
;  BEQ Powerbombs
  LDA $1D77,x
  BNE Setgate
  RTS
superOrmissiles:
  LDA $1D77,x ;Projectile type
  AND #$0FFF
  CMP #$0100
  BEQ Setgate 
  CMP #$0200
  BEQ Setgate
  RTS
superMissiles:
  LDA $1D77,x ;Projectile type
  AND #$0FFF
  CMP #$0200
  BEQ Setgate 
  RTS
;Powerbombs:
;  LDA $1D77,x ;Projectile type
;  AND #$0FFF
;  CMP #$0300
;  BEQ Setgate 
;  RTS

Setgate:
print "Setgate: ",pc
  LDA $7EDEBC,x : STA $1D27,x ;Sets addresss from $7E:DEBC as next instruction (OpenGate)
  LDA #$0001 : STA $7EDE1C,x
  LDA $1E17,x
  AND #$F000
  BIT #$1000
  BNE loop
  RTS
loop:
  DEX : DEX
  LDA $1C37,x
  CMP #$C82A
  BNE loop
  LDA $1D77,x
  BNE loopEnd
  INC $1D77,x
loopEnd: 
  RTS

DisplayMessage:
  LDA $1E17,x
  BIT #$2000
  BNE MsgBox
  LDA !Sfxtoplay
 ; JSL $809021    : BRA .out    ;Play Lib1 Sound
 ; JSL $8090A3    : BRA .out    ;Play Lib2 Sound ---uncomment the right line for the library you need
  JSL $80914D                ;Play Lib3 Sound
  JSR checkifcounter
  RTS

MsgBox:
  JSR checkifcounter
  BIT #$4000
  BEQ MsgBoxB
  LDA !MsgBoxId
  BRA DrawMsg
MsgBoxB:
  LDA !MsgBoxIdB
DrawMsg:
  JSL $858080
  RTS

checkifcounter:
  LDA $1E17,x
  BIT #$4000
  BNE affectmaxGates
  RTS
affectmaxGates:
  DEC $09EC
  RTS

  
  
;------code for making the msg box play an sfx
org $858469    ;hijack message box opener for sound effect
JSR PICKUPSOUND
org $859650
{
PICKUPSOUND:    ;Pick [A] sound off of table, return [A] and [X] same as before routine.
JSR $859B    ;Code overwritten
PHA : PHX
LDA !MsgBoxId
CMP $1C1F ; check if the current msg box is the one from the gate switch
BEQ .play
LDA !MsgBoxIdB
CMP $1C1F ; check if the current msg box is the one from the gate switch
BNE .out

.play:
LDA !Sfxtoplay
;JSL $809021    : BRA .out    ;Play Lib1 Sound
;JSL $8090A3    : BRA .out    ;Play Lib2 Sound ;---uncomment the correct library you need for your sfx
JSL $80914D                ;Play Lib3 Sound
.out
PLX : PLA
RTS
}


;---the gate plm itself-------
; just like the gate switch, the gate plm's argument is the corresponding door ID to unlock (or in this case, which door ID to check)
org !GatePlmFreespace

GatePLM:
DW InitGate : DW GateMain

InitGate:
  LDA $0DC4 : PHA
  LDA $1C87,y : LSR : STA $0DC4
  LDA $1DC7,y  ;Room argument
  JSL $80818E  ;$05E7 = A % 8, x = A / 8
  LDA $7ED8B0,x : AND $05E7 : BNE SpawnOpenGate  ;Branches if the bit was set

SpawnClosedGate:
  LDA #$C82A : JSL $8484E7  ;Spawns a closed gate over this PLM
  BRA GateEnd


SpawnOpenGate:
  LDA #$C826 : JSL $8484E7  ;Spawns an open gate over this PLM

GateEnd:
  PLA : STA $0DC4
  RTS

GateMain:
 DW $86BC ; Delete


;----------msg box code for displaying a number-----------------
;comment (or remove) all of this below if you just want to display a msg box with nothing special
org !MsgBocCodeFreespace
  PHY
  LDA $09EC
  ASL
  TAY
  LDA FirstDigitTable,y  
  LDX #$0112 ;play around with this value to change where the first digit appears (make sure it's an even number)            
  STA $7E3200,x          
  LDA SecondDigitTable,y 
  LDX #$0114 ;play around with this value to change where the second digit appears (make sure it's an even number)  
  STA $7E3200,x          
  LDA #$01A0
  STA $34
  JSR $831E
  PLY
  RTS

FirstDigitTable:
DW #$2809,#$2800,#$2801,#$2802,#$2803,#$2804,#$2805,#$2806,#$2807,#$2808,#$2800,#$2800,#$2800,#$2800,#$2800,#$2800,#$2800,#$2800,#$2800,#$2800,#$2801
SecondDigitTable:
DW #$280F,#$280F,#$280F,#$280F,#$280F,#$280F,#$280F,#$280F,#$280F,#$280F,#$2809,#$2800,#$2801,#$2802,#$2803,#$2804,#$2805,#$2806,#$2807,#$2808,#$2809


;----------main game hijack for init RAM---------
; RT: This does not appear to work properly
;  putting a hotfix in intro-missile-fix.asm 
;  to avoid issue with stale RAM
org $8084B8
  JSL SetupAmount
  
org !Bank80Freespace
SetupAmount:
print "setupamount: ",pc
  PHP
  REP #$20
  LDA !GateAmount
  STA $09EC ;--------initialize some unuses SRAM to keep track of how many gates are left
  PLP
  LDA #$8F
  STA $51
  RTL

  
  