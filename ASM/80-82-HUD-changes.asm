lorom

HUD_ramTilemap = $7EC608

HUDoffset_energyCur = (3*2)+(64*1)
HUDoffset_energyTankRowA = (5*2)+(64*0)
HUDoffset_energyTankRowB = (5*2)+(64*1)

HUDoffset_reserveIcon = (0*2)+(64*0)

HUDoffset_missileIcon = (13*2)+(64*0)
HUDoffset_missileMax = (15*2)+(64*0)
HUDoffset_missileCur = (15*2)+(64*1)

HUDoffset_superIcon = (18*2)+(64*0)
HUDoffset_superMax = (20*2)+(64*0)
HUDoffset_superCur = (20*2)+(64*1)

HUDoffset_powerIcon = (22*2)+(64*0)
HUDoffset_powerMax = (24*2)+(64*0)
HUDoffset_powerCur = (24*2)+(64*1)

HUDoffset_grappleIcon = (0*2)+(64*2)

HUDoffset_xRayIcon = (1*2)+(64*2)
;HUDoffset_ = (*2)+(64*)

org $80988B ; Initial tilemap
; Top row
HUD_initialTilemap:
   dw $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $AC7B, $AC7C, $AC7C, $AC7C, $AC7C, $AC7C, $EC7B
; Other rows   
   dw $2C0F, $2C0B, $2C0C, $2C0D, $2C32, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C7E, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $6C7E
   dw $2C7C, $2C7C, $2C7A, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C7E, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $6C7E
   dw $2C0F, $2C0F, $2C7B, $2C7C, $2C7C, $2C7C, $2C7C, $2C7C, $2C7C, $2C7C, $2C7C, $2C7C, $2C7C, $2C7C, $2C7C, $2C7C, $2C7C, $2C7C, $2C7C, $2C7C, $2C7C, $2C7C, $2C7C, $2C7C, $2C7C, $2C7D, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $6C7E

;   dw $7033, $2C0B, $2C0C, $2C0D, $2C32, $3030, $3030, $3030, $3030, $3030, $3030, $3458, $2C0F, $3449, $344B, $3445, $3445, $2C0F, $3434, $7434, $3445, $2C0F, $3436, $7436, $3445, $2C7E, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $6C7E,
;   dw $2C7C, $2C7C, $2C7A, $2C08, $2C08, $3031, $3031, $3031, $3031, $3031, $3031, $B458, $2C0F, $344A, $344C, $2C09, $2C09, $2C0F, $3435, $7435, $2C09, $2C0F, $3437, $7437, $2C09, $2C7E, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $6C7E,
;   dw $347F, $347F, $2C7B, $2C7C, $2C7C, $2C7C, $2C7C, $2C7C, $2C7C, $2C7C, $2C7C, $2C7C, $2C7C, $2C7C, $2C7C, $2C7C, $2C7C, $2C7C, $2C7C, $2C7C, $2C7C, $2C7C, $2C7C, $2C7C, $2C7C, $2C7D, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $6C7E,


; Auto reserve (0,0)
HUD_reserveActive:
    dw $7033

; Empty auto reserve (0,0)
HUD_reserveEmpty:
    dw $6C33
    
; Missiles (13,0)
HUD_missiles:
    dw $3449, $344B
    dw $344A, $344C

; Super missiles (18,0)
HUD_superMissiles:
    dw $3434, $7434
    dw $3435, $7435

; Power bombs (22,0)
HUD_powerBombs:
    dw $3436, $7436
    dw $3437, $7437

; Grapple (0,2)
HUD_grapple:
    dw $347F ; Inactive
    dw $307F ; Active
    
; X-ray (1,2)
HUD_xRay:
    dw $347F ; Inactive
    dw $307F ; Active
    
; E-Tank full (5,0) to (11,1)
HUD_energyTankFull:
    dw $3030
    dw $3031
    
; E-Tank empty
HUD_energyTankEmpty:
    dw $3458
    dw $B458

org $8099CF
HUD_addMissileIcon:
    php
    phx
    phy
    phb
    phk
    plb
    rep #$30
    ldy.w #HUD_missiles ; Source
    ldx.w #HUDoffset_missileIcon ; Dest offset
    bra HUD_write2x2
    
org $809A0E
HUD_addSuperIcon:
    php
    phx
    phy
    phb
    phk
    plb
    rep #$30
    ldy.w #HUD_superMissiles ; Source
    ldx.w #HUDoffset_superIcon ; Dest offset
    bra HUD_write2x2

HUD_addPowerIcon:
    php
    phx
    phy
    phb
    phk
    plb
    rep #$30
    ldy.w #HUD_powerBombs ; Source
    ldx.w #HUDoffset_powerIcon ; Dest offset
    bra HUD_write2x2

org $809A2E
HUD_addGrapple:
    rep #$30
    lda.w HUD_grapple
    sta.l HUD_ramTilemap+HUDoffset_grappleIcon
rtl

org $809A3E
HUD_addXRay:
    rep #$30
    lda.w HUD_xRay
    sta.l HUD_ramTilemap+HUDoffset_xRayIcon
rtl

org $809A4C
HUD_write2x2:


; HUD Init Hijack - Skip initial drawing of numbers (should be unnoticeable with the fade-in (?))
org $809AF7
    bra HUD_initHijack

org $809B2B
    HUD_initHijack:

;;; $9B44: Handle HUD tilemap (HUD routine when game is paused/running) ;;;
; Based off of IFB's disassembly
DP_Temp00 = $00
DP_Temp12 = $12
DP_Temp14 = $14
DP_Temp16 = $16

energyCur = $09C2
energyMax = $09C4
missilesCur = $09C6
missilesMax = $09C8
superCur = $09CA
superMax = $09CC
powerCur = $09CE
powerMax = $09D0
reserveEnergyCur = $09D6

energyPrev = $0A06
missilesPrev = $0A08
superPrev = $0A0A
powerPrev = $0A0C

org $809B44
HUD_updateIngame: ;HandleHUDTilemap_PausedAndRunning:
    PHP                                                                  ;809B44;
    PHB                                                                  ;809B45;
    PHK                                                                  ;809B46;
    PLB                                                                  ;809B47;
    SEP #$20                                                             ;809B48;
    STZ.B $02                                                            ;809B4A;
    REP #$30                                                             ;809B4C;
    LDA.W $09C0 ; ReserveTankMode                                        ;809B4E;
    CMP.W #$0001                                                         ;809B51;
    BNE .handleSamusHealth                                               ;809B54;
        ldy.w #HUD_reserveActive
        LDA.W reserveEnergyCur                                              ;809B59;
        BNE .drawAutoReserve                                             ;809B5C;
            ldy.w #HUD_reserveEmpty                                      ;809B5E;
        .drawAutoReserve:
            lda.w $0000,y
            sta.l HUD_ramTilemap+HUDoffset_reserveIcon 

  .handleSamusHealth:
    LDA.W energyCur                                                        ;809B8B;
    CMP.W energyPrev                                                 ;809B8E;
    BEQ .handleSamusMissiles                                             ;809B91;
        ; Using multiplication registers (?) to get the number of etanks and energy mod-100
        STA.W energyPrev                                                 ;809B93;
        LDA.W energyCur                                                        ;809B96;
        STA.W $4204                                                          ;809B99;
        SEP #$20                                                             ;809B9C;
        LDA.B #$64 ;100 in decimal                                           ;809B9E;
        STA.W $4206                                                          ;809BA0;
        PHA                                                                  ;809BA3;
        PLA                                                                  ;809BA4;
        PHA                                                                  ;809BA5;
        PLA                                                                  ;809BA6;
        REP #$20                                                             ;809BA7;
        LDA.W $4214                                                          ;809BA9;
        STA.B DP_Temp14 ; Whole etanks                                       ;809BAC;
        LDA.W $4216                                                          ;809BAE;
        STA.B DP_Temp12 ; energy mod-100                                     ;809BB1;
        
        LDA.W energyMax                                                      ;809BB3;
        STA.W $4204                                                          ;809BB6;
        SEP #$20                                                             ;809BB9;
        LDA.B #$64                                                           ;809BBB;
        STA.W $4206                                                          ;809BBD;
        PHA                                                                  ;809BC0;
        PLA                                                                  ;809BC1;
        PHA                                                                  ;809BC2;
        PLA                                                                  ;809BC3;
        REP #$30                                                             ;809BC4;
        LDY.W #$0000                                                         ;809BC6;
        LDA.W $4214                                                          ;809BC9;
        INC                                                                  ;809BCC;
        STA.B DP_Temp16 ; Collected e-tanks + 1                              ;809BCD;

        ldx.w #$0000
        .loopEtanks:
            DEC.B DP_Temp16                                                      ;809BCF;
                BEQ .drawEtanksDigits                                            ;809BD1;
            ldy.w #HUD_energyTankEmpty ; #$3430                                                         ;809BD3;
            LDA.B DP_Temp14                                                      ;809BD6;
            BEQ .drawEtanks                                                      ;809BD8;
                DEC.B DP_Temp14                                                  ;809BDA;
                ldy.w #HUD_energyTankFull ; #$2831                                ;809BDC;
            .drawEtanks:
            lda.w $0000,y
            sta.l HUD_ramTilemap+HUDoffset_energyTankRowA,x
            lda.w $0002,y
            sta.l HUD_ramTilemap+HUDoffset_energyTankRowB,x
            ;TXA                                                                  ;809BDF;
            ;LDX.W .etankIconOffsets,Y                                            ;809BE0;
            ;STA.L HUDTilemap,X                                                   ;809BE3;
            inx                                                                  ;809BE7;
            inx                                                                  ;809BE8;
            cpx.w #(7*2) ;$001C                                                         ;809BE9;
        BMI .loopEtanks                                                      ;809BEC;
     
    .drawEtanksDigits:
        LDA.W #HUD_curDigits                                      ;809BEE;
        STA.B DP_Temp00                                                      ;809BF1;
        ldx.w #HUDoffset_energyCur                                           ;809BF3;
        LDA.B DP_Temp12                                                      ;809BF6;
        JSR.W DrawTwoHUDDigits                                               ;809BF8;

  .handleSamusMissiles:
    lda.w #HUD_curDigits                                          ;809BFB;
    STA.B DP_Temp00                                                      ;809BFE;
    LDA.W missilesMax                                                    ;809C00;
    BEQ .handleSuperMissiles                                             ;809C03;
        LDA.W missilesCur                                                       ;809C05;
        CMP.W missilesPrev                                               ;809C08;
        BEQ .handleSuperMissiles                                             ;809C0B;
            STA.W missilesPrev                                               ;809C0D;
            ;lda.w HUD_curDigits
            ;sta.b DP_Temp00
            ldx.w #HUDoffset_missileCur                                                         ;809C10;
            JSR.W DrawTwoHUDDigits                                             ;809C13;
            
            lda.w #HUD_maxDigits
            sta.b DP_Temp00
            ldx.w #HUDoffset_missileMax
            lda.w missilesMax
            JSR.W DrawTwoHUDDigits

  .handleSuperMissiles:
    lda.w #HUD_curDigits
    STA.B DP_Temp00     
    
    LDA.W superMax                                               ;809C16;
    BEQ .handlePowerBombs                                                ;809C19;
        LDA.W superCur                                                  ;809C1B;
        CMP.W superPrev                                          ;809C1E;
        BEQ .handlePowerBombs                                                ;809C21;
            STA.W superPrev                                          ;809C23;
            LDX.W #HUDoffset_superCur                                                         ;809C26;
            ;LDA.W superPrev                                          ;809C31;
            JSR.W DrawOneHUDDigit                                               ;809C34;
            
            lda.w #HUD_maxDigits
            sta.b DP_Temp00
            ldx.w #HUDoffset_superMax
            lda.w superMax
            JSR.W DrawOneHUDDigit

  .handlePowerBombs:
  jmp uglyHijack

warnpc $809C55

org $809C55
backToHUD:
  .endHijack:
; Plays click sound unless spin/wall jumping, grappling or X-raying
; Item highlighting stuff
;    LDA.W SelectedHUDItem                                                ;809C55;

org $809CEA
;;; $9CEA: Toggle HUD item highlight ;;;
HUDItemTilemapPaletteBits = $077C

ToggleHUDItemHighlight:
;; Parameters:
;;     A: HUD item index
;;     X: Tilemap palette bits (palette index * 400h)

; Palette 4 (X = 1000h) is used for the highlighted palette, otherwise palette 5 (X = 1400h) is used
; This routine assumes missiles are 3 tiles wide and all other icons are 2 tiles wide
    STX.W HUDItemTilemapPaletteBits                                      ;809CEA;
    DEC                                                                  ;809CED;
    BMI .return                                                          ;809CEE;
    ; Get the offset for the item
    ASL                                                                  ;809CF0;
    TAY                                                                  ;809CF1;
    LDX.W .HUDItemOffsets,Y                                              ;809CF2;
    ; Top left
    LDA.L HUD_ramTilemap,X                                                   ;809CF5;
    CMP.W #$2C0F                                                         ;809CF9;
    BEQ .checkY                                                  ;809CFC;
    AND.W #$E3FF                                                         ;809CFE;
    ORA.W HUDItemTilemapPaletteBits                                      ;809D01;
    STA.L HUD_ramTilemap,X                                                   ;809D04;

 .checkY:
    CPY.W #$0006                                                         ;809D41;
    BMI .topRight                                                        ;809D44;
    RTS                                                                  ;809D46;

  .topRight:
    LDA.L HUD_ramTilemap+2,X                                                 ;809D08;
    CMP.W #$2C0F                                                         ;809D0C;
    BEQ .bottomLeft                                                      ;809D0F;
    AND.W #$E3FF                                                         ;809D11;
    ORA.W HUDItemTilemapPaletteBits                                      ;809D14;
    STA.L HUD_ramTilemap+2,X                                                 ;809D17;

  .bottomLeft:
    LDA.L HUD_ramTilemap+64,X                                              ;809D1B;
    CMP.W #$2C0F                                                         ;809D1F;
    BEQ .bottomRight                                               ;809D22;
    AND.W #$E3FF                                                         ;809D24;
    ORA.W HUDItemTilemapPaletteBits                                      ;809D27;
    STA.L HUD_ramTilemap+64,X                                              ;809D2A;

  .bottomRight:
    LDA.L HUD_ramTilemap+64+2,X                                            ;809D2E;
    CMP.W #$2C0F                                                         ;809D32;
    BEQ .return                                                          ;809D35;
    AND.W #$E3FF                                                         ;809D37;
    ORA.W HUDItemTilemapPaletteBits                                      ;809D3A;
    STA.L HUD_ramTilemap+64+2,X                                            ;809D3D;

  .return:
    RTS                                                                  ;809D6D;

  .HUDItemOffsets:
; HUD item tilemap offsets
    dw HUDoffset_missileIcon                                             ;809D6E; Missiles
    dw HUDoffset_superIcon                                               ;809D70; Super missiles
    dw HUDoffset_powerIcon                                               ;809D72; Power bombs
    dw HUDoffset_grappleIcon                                             ;809D74; Grapple beam
    dw HUDoffset_xRayIcon                                                ;809D76; X-ray


org $809D98 ; Hook to vanilla function
DrawTwoHUDDigits:


org $809DBF
HUD_curDigits:
    dw $2C09, $2C00, $2C01, $2C02, $2C03, $2C04, $2C05, $2C06, $2C07, $2C08
HUD_maxDigits:
    dw $3445, $343C, $343D, $343E, $343F, $3440, $3441, $3442, $3443, $3444
    
    
org $80CD8E ; FREESPACE

uglyHijack:

    lda.w #HUD_curDigits
    STA.B DP_Temp00
    
    LDA.W powerMax                                                  ;809C3F;
    BEQ .endHijack                                               ;809C42;
        LDA.W powerCur                                                     ;809C44;
        CMP.W powerPrev                                             ;809C47;
        BEQ .endHijack                                               ;809C4A;
            STA.W powerPrev                                             ;809C4C;
            LDX.W #HUDoffset_powerCur                                                       ;809C4F;
            JSR.W DrawOneHUDDigit                                               ;809C52;

            lda.w #HUD_maxDigits
            sta.b DP_Temp00
            ldx.w #HUDoffset_powerMax
            lda.w powerMax
            JSR.W DrawOneHUDDigit
    .endHijack:
    jmp backToHUD
    
 DrawOneHUDDigit: ; Again, based off IFB's disassembly
;; Parameters:
;;     A: Number to draw
;;     X: HUD tilemap index
;;     $00: Long pointer to digits tilemap
    STA.W $4204                                                          ;809D98;
    SEP #$20                                                             ;809D9B;
    LDA.B #$0A                                                           ;809D9D;
    STA.W $4206                                                          ;809D9F;
    PHA                                                                  ;809DA2;
    PLA                                                                  ;809DA3;
    PHA                                                                  ;809DA4;
    PLA                                                                  ;809DA5;
    REP #$20                                                             ;809DA6;
    LDA.W $4216                                                          ;809DB3;
    ASL                                                                  ;809DB6;
    TAY                                                                  ;809DB7;
    LDA.B [DP_Temp00],Y                                                  ;809DB8;
    STA.L HUD_ramTilemap,X                                                 ;809DBA;
    RTS
    
; Reserve tank fixes for pause menu
org $82AEFD ; Write AUTO tilemap (apparently useless due to a vanilla bug)
    rts
    
org $82AF33 ; Clear tilemap
    lda #$2C0F
    sta HUD_ramTilemap+HUDoffset_reserveIcon
    rts
