lorom

; Remove music stop from the start of page 6
org $8BB220 : rts

; Create a command routine that can be run.
org $8BF760
musicStop: ; Queue music stop
    lda #$0000 : jsl $808FC1  
rts