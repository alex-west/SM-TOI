lorom

!bts = $03 ;max $0F
!free94 = $94DCF0 

org !bts*2+$9498AC
GameEndBTS:
	dw .endGame

org !free94
.endGame
	LDA #$0026 : STA $0998
	RTS

print pc