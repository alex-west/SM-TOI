;=========================================================================================================================
; thanks neen

org $82E74B ; shoutout to benox50 for this idea
    jsr hijack
    
org $82F70F ; Freespace
hijack:
    jsr $DFC7   ; draw inanimate Samus (vanilla code)
    stz $0A9C   ; fix slowed animations from water -> spore, rain, etc., effects during door transition
                ; this replaces a jsr $dfc7 which seems to have no effect at all, very lucky
                ; um actually if you have i-frames during a door this results in a small amount of flickering on the other side. probably fine
    rts