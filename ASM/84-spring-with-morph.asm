; morph with spring
; by RT-55J
; thanks to PJ's bank logs

lorom

; Adjust Item PLM instruction list for morph (in case of rando)

org $84E416 ; open
  dw $0006
org $84E8CE ; chozo
  dw $0006
org $84EE02 ; shot
  dw $0006
  
; Adjust Item PLM instruction list of new item (dash ball)

org $84E296 ; open
  org $0800
org $84E6EA ; chozo
  org $0800
org $84EBEE ; shot 
  org $0800