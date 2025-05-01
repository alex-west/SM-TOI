;--------------------------SKIPS ALL MODE 7 DURING ZEBES ESCAPE---------------------------------------
;--------------------------------OmegaDragnet9--------------------------------------------------------
;-----------------------------Credits to P.JBoy for the Banklogs--------------------------------------

;I recommend checking out Tundain's No Planet Explosion Resource because
;it had a lot of documentation that assisted me with finding the Zebes GFX
;as well as the palettes used during the planet detonation.

lorom

org $8BD6C5		;This changes the music to the intro fanfare instead of the blow up sound. NECESSARY

LDA #$FF3C		;This track is the fanfare during the intro cinematic. 
JSL $808FC1
LDA #$0005
LDY #$000E
JSL $808FF7
RTS

;-------------------Music for Credits when Zebes Explodes-------------------------------------------;

org $8BDBA5 	;NOTICE THAT THE ORG COVERS A BROADER AREA OF CODE THAN WHAT I'VE UPLOADED BEFORE
    bra skipTo; NOP #24			;SKIPS ALL THIS BECAUSE IT'S DOING THIS ELSEWHERE ALREADY

org $8BDBBD
skipTo:

;----------------Skip Mode 7 Big Planet Zoomout------------------------------;

org $8BD701		;This skips the planet clouds and crap. NECESSARY BECAUSE IT'S A SPACE STATION.
JMP $D837

org $8BD879 	;Added this to skip Mode 7 Zebes, because that's a lot of GFX to edit. 
JMP $D8AE
