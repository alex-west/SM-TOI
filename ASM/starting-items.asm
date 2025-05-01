lorom

; Patch by SMILEuser96
;A patch to easily configure starting equipment
;Configuration, including free space usage, is under item and beam bit definitions


  !none = $0000 ;For convenience
;Item bit definitions
  !variaSuit = $0001
  !springBall = $0002
  !morphBall = $0004
  !screwAttack = $0008
  !custom1 = $0010 ;Unused in vanilla game
  !gravitySuit = $0020
  !custom2 = $0040 ;Unused in vanilla game
  !custom3 = $0080 ;Unused in vanilla game
  !highJump = $0100
  !spaceJump = $0200
  !custom4 = $0400 ;Unused in vanilla game
  !custom5 = $0800 ;Unused in vanilla game
  !bomb = $1000
  !speedBooster = $2000
  !grapple = $4000
  !xray = $8000

;Beam bit definitions
  !wave = $0001
  !ice = $0002
  !spazer = $0004
  !plasma = $0008
  !charge = $1000

;;;;;;;;;;;;;;;;;;;
;;;Configuration;;;
;;;;;;;;;;;;;;;;;;;
  !free81 = $81EF20 ;Free space in $81

;Starting equipment. All pause menu items will start both collected and enabled; spazer+plasma will crash the game
;To enable items, add items to the !startingItems define with the bitwise OR operator |
;To enable beams, add beams to the !startingBeams define with the bitwise OR operator |
;Use !none for... none
;Example:
;!startingItems = !variaSuit|!bomb|!morphBall
;Health and ammo are just numbers in decimal. Both will start full

  !startingItems = !morphBall|!springBall
  !startingBeams = !charge
  !energy = 199
  !missile = 10
  !superMissile = 0
  !powerBomb = 0
  !reserveEnergy = 0
  !reserveMode = 1 ;Reserve tank mode if starting reserve energy is non-zero- 1=auto, 2=manual


org $81B306
StartWithItems:
  JSR .startEquipment

org !free81
.startEquipment
  LDA.w #!startingItems : STA $09A2 : STA $09A4
  LDA.w #!startingBeams : STA $09A6 : STA $09A8
  LDA.w #!energy : STA $09C2 : STA $09C4
  LDA.w #!reserveEnergy : STA $09D6 : STA $09D4 : BEQ +
    LDA.w #!reserveMode : STA $09C0
+ LDA.w #!missile : STA $09C6 : STA $09C8
  LDA.w #!superMissile : STA $09CA : STA $09CC
  LDA.w #!powerBomb : STA $09CE : STA $09D0
  RTS