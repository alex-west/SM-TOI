; by Tundain

; Replaces transparency option 0x28
lorom
org $888112 ; new layer blending for placing BG3 behind the other layers, can get repointed if needed, just watch out for space constraints.
LDA #$11 : STA $69;main screen = BG1/sprites
LDA #$06 : STA $6B;subscreen = BG2/BG3
LDA #$20 : STA $71;only enable control math on backdrop, disable elsewhere
RTS