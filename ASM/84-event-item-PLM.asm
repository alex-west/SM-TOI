; Event-setting Item by RT-55J
; Thanks neen

;==============================================PLM================================================

lorom
org $84F42A ;$840000+!84freespaceone
    keyItemPLM:
        dw $EE64 ; Setup routine
        dw .inst
    
;    .setup:
;        lda #$000a                    ;gfx index. todo: figure out whuh
;        jmp $ee5f                     ;set gfx index and do standard item setup
    
    .inst:
        ; Load item graphics
        dw $8764,keyItemGraphics : db 00,00,00,00,00,00,00,00
        dw .checkeventinst, #.end               ;goto .end when room argument item is collected
        dw $8a24, #.link              ;set link instruction
        dw $86c1, $df89               ;set pre-instruction: go to link instruction when triggered
        .idle:
        dw $e04f ; draw frame 0
        dw $e067 ; draw frame 1
        dw $8724, #.idle              ;loop while waiting
        
        .link:
        dw $8BDD : db $02 ; Queue fanfare
        ;dw $8899                      ;set item as collected
        dw #.seteventinst
        .end:
        dw $8724, $dfa9               ;goto dfa9 (inst list for blank tile)
        
;    .chozodraw:                       ;draw instruction
;        dw $0001, $b045, $0000        ;one tile, item tile (type b), tile $45 (chozo head, face)
        
    .seteventinst:                    ;sets event bit from room argument and displays message box
        ldx $1c27
        lda $1dc7,x     ; \
        and #$00ff      ;  set event bit stored in plm argument low byte
        jsl $8081fa     ; /
        lda #$001F : jsl $858080 ; display message box        
        rts
        
    .checkeventinst: ; Instruction - go to [[Y]] if the room argument event is set
        lda $1DC7,x   ; Get PLM room argument
        bmi .skipgoto ; Let PLM respawn if bit 8000h is set
        and #$00ff    ; mask out upper byte for sanitation
        JSL $808233   ; Check event bit
        BCC .skipgoto ; Let PLM spawn
        JMP $8724     ; Goto [[Y]]
    .skipgoto:
        iny : iny     ; Y += 2
        rts



org $89AF00

keyItemGraphics:
    incbin "89-key-item-gfx.chr"