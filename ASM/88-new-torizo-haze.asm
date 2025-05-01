; Makes Bomb Torizo haze HDMA objects transfer to CGRAM, where the haze is BG3, allowing many other layer blending configurations such as 18h to be used with the haze, and also make power bombs and x-ray work with it.
; by HAM
lorom

org $83AC44 : dw $DD32 ; Change haze effect to use BT's version instead of $DDC7

org $88DD32
JSL $888435 : dw $2100,$DD62 ; HDMA to CGADD
JSL $888435 : dw $2202,$DD4A ; HDMA to CGDATA
RTL

org $88DD43 : RTL ; RTL out setting layer blending configuration to 2Ch

function rgb555(r,g,b) = r|(g<<5)|(b<<10)

org $88DD75
db $48 : dw rgb555(0,0,0)
db $0A : dw rgb555(1,1,1)
db $0A : dw rgb555(1,1,1)
db $0A : dw rgb555(1,1,2)
db $0A : dw rgb555(2,2,2)
db $0A : dw rgb555(2,2,3)
db $0A : dw rgb555(2,2,3)
db $0A : dw rgb555(3,3,4)
db $0A : dw rgb555(3,3,4)
db $0A : dw rgb555(3,3,5)
db $0A : dw rgb555(4,4,5)
db $0A : dw rgb555(4,4,6)
db $0A : dw rgb555(4,4,6)
db $0A : dw rgb555(5,5,7)
db $0A : dw rgb555(5,5,7)
db $0A : dw rgb555(5,5,8)
db $00

org $88DDA6
db $48,$1B, ; palette 1 color Bh
   $0A,$1B,
   $0A,$1B,
   $0A,$1B,
   $0A,$1B,
   $0A,$1B,
   $0A,$1B,
   $0A,$1B,
   $0A,$1B,
   $0A,$1B,
   $0A,$1B,
   $0A,$1B,
   $0A,$1B,
   $0A,$1B,
   $0A,$1B,
   $0A,$1B,
   $00