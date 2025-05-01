; morph with spring
; by RT-55J
; thanks to PJ's bank logs

lorom

;; Equipment bitmasks
;$82:C04C             dw 1000, ; Weapons - charge
;                        0002, ; Weapons - ice
;                        0001, ; Weapons - wave
;                        0004, ; Weapons - spazer
;                        0008  ; Weapons - plasma
org $82C056
  dw $0001 ; Suit/misc - varia suit
  dw $0020 ; Suit/misc - gravity suit
  dw $0006 ; Suit/misc - morph ball (changed from $0004)
  dw $1000 ; Suit/misc - bombs
  dw $0800 ; Suit/misc - spring ball (changed from $0002) (now dash ball)
  dw $0008 ; Suit/misc - screw attack
;$82:C062             dw 0100, ; Boots - hi-jump boots
;                        0200, ; Boots - space jump
;                        2000  ; Boots - speed booster

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