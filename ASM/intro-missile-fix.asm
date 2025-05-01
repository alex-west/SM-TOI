; intro missile fix
;  by RT-55J
; probably done by dozens of others before

lorom

; Stop missiles from being set to 900
org $8BA3B3 ;: nop #6
; HOTFIX: Properly initialize gate count for game
  LDA #$0006
  STA $09EC

; Stop missiles from being set to 0
org $8BB76C : nop #6