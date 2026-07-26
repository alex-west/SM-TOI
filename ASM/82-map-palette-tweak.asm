; By RT-55J

org $8294B5 ; Map data not collected case
    ; Ignore palette change logic
    nop
    nop
    nop

org $8294E0 ; Map data collected case
    LDA [$00],y
    ASL.b $28 ; Check if the map tile was explored
    BCS labelA ; Invert condition
    ORA.w #%0001110000000000 ; Force unexplored map tiles to palette 7
    ASL.b $26
    BCS labelB
    LDA #$001F ; For unexplored, unmarked tile to be blank
    BRA labelB
  labelA:
    ASL.b $26 ; explored tile
  labelB:

warnpc $8294F4

; TODO: Minimap