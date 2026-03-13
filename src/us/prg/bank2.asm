.segment        "PRG2":absolute
; code bytes:	$0A26 (15.86% of bytes in this ROM bank)
; data bytes:	$34C5 (82.45% of bytes in this ROM bank)
; pcm bytes:	$0000 (0.00% of bytes in this ROM bank)
; chr bytes:	$0000 (0.00% of bytes in this ROM bank)
; free bytes:	$00A3 (0.99% of bytes in this ROM bank)
; unknown bytes:	$0072 (0.70% of bytes in this ROM bank)
; $3EEB bytes last seen in RAM bank $8000 - $BFFF (100.00% of bytes seen in this ROM bank, 98.31% of bytes in this ROM bank):
;	$0A26 code bytes (16.13% of bytes seen in this RAM bank, 15.86% of bytes in this ROM bank)
;	$34C5 data bytes (83.87% of bytes seen in this RAM bank, 82.45% of bytes in this ROM bank)

; PRG Bank 0x02: town/dungeon maps, warp data, NPC data, code for building town/dungeon maps and moving NPCs around, most of the main script text engine, including its dictionary, some control code handlers, the main script pointers, and the main script overflow from bank 5

; [bank start] -> data
; -> $02:$B68F: handler for control code #$FD
; possible external indexed data load target (from $0F:$F3ED, $0F:$FF28)
; external indirect data load target (via $0F:$FBAB)
; possible external indexed data load target (from $0F:$F3F2, $0F:$FF2D)
.byte $8F
; external indirect data load target (via $0F:$F78A)
.byte $B6
; -> $02:$B393: read the next string byte; preserves X and Y
.byte $41
.byte $B1
; indirect data load target (via $BE03)
; -> $02:$B292: looks like this determines NPC's post-Malroth text
.byte $93
.byte $B3
; external indirect data load target (via $0F:$D33F)
; -> $02:$B677: CLC if end of word, SEC otherwise
.byte $92,$B2
.byte $0E
.byte $B1
; external indirect data load target (via $0F:$FB4D, $0F:$FB7D, $0F:$FBD9)
; external indirect data load target (via $0F:$FB9E, $0F:$FBA6, $0F:$FBB0)
.byte $77
.byte $B6
; -> $02:$B687: if menu current column < #$16, CLC and RTS, otherwise do stuff
.byte $95
.byte $B6
; external indirect data load target (via $0F:$FB61, $0F:$FD40)
; external indirect data load target (via $0F:$FBA2)
.byte $87
.byte $B6
; -> $02:$B351: looks like more NPC data?
.byte $10
.byte $B7
; indirect data load target (via $B1C3)
; external indirect data load target (via $0F:$E4EF, $0F:$E4FB)
; -> $02:$BE00: read the next text token and interpolate any variable control codes; SEC to trigger read of [end-FA]-terminated string from $60F1, CLC to use A
.byte $51
.byte $B3
; external indirect data load target (via $0F:$FBF7)
; -> $02:$BEBC: copy $6119,X to $60F1,X until we read a #$FA
.byte $00
.byte $BE
; external indirect data load target (via $07:$87F4)
; map header info (exterior border tile ID, width, height, pointer low byte, pointer high byte, ?, ?, palette)
.byte $BC
.byte $BE
; external indirect data load target (via $0F:$E3FB)
; indirect data load target

.byte $01,$17,$17,$89,$8B,$01,$00,$0D,$04,$FF,$FF,$00,$80,$00,$00,$00
.byte $20,$09,$09,$40,$88,$00,$00,$0D,$01,$17,$17,$89,$8B,$01,$00,$0D
.byte $05,$05,$09,$52,$88,$00,$00,$0D,$01,$17,$17,$6A,$88,$01,$00,$0D
.byte $03,$19,$19,$22,$89,$01,$00,$0D,$06,$17,$17,$CC,$89,$01,$00,$0D
.byte $04,$07,$07,$9A,$8A,$00,$00,$0D,$08,$13,$13,$B6,$8A,$01,$00,$0D
.byte $05,$05,$06,$1F,$8C,$00,$00,$0D,$01,$19,$19,$38,$8C,$01,$00,$0D
.byte $01,$1D,$13,$17,$8D,$01,$00,$0D,$20,$07,$07,$08,$8E,$00,$00,$0D
.byte $20,$07,$07,$1C,$8E,$00,$00,$0D,$01,$17,$17,$2B,$8E,$01,$00,$0D
.byte $01,$17,$17,$04,$8F,$01,$00,$0D,$03,$13,$1F,$BF,$8F,$01,$00,$0D
.byte $02,$05,$05,$65,$90,$00,$00,$0D,$06,$09,$09,$74,$90,$01,$00,$0D
.byte $05,$17,$18,$9B,$90,$01,$00,$0D,$03,$19,$19,$68,$91,$01,$00,$0D
.byte $08,$19,$19,$3B,$92,$01,$00,$0D,$21,$0F,$0D,$F9,$92,$00,$00,$0D
.byte $04,$13,$13,$A3,$94,$00,$00,$0D,$05,$09,$09,$2D,$93,$00,$00,$0D
.byte $06,$07,$0B,$4C,$93,$01,$00,$0D,$24,$05,$05,$90,$94,$01,$00,$0D
.byte $05,$07,$07,$78,$93,$00,$00,$0D,$03,$09,$05,$8F,$93,$00,$00,$0D
.byte $01,$09,$05,$A8,$93,$00,$00,$0D,$03,$07,$07,$C1,$93,$00,$00,$0D
.byte $05,$07,$05,$E5,$93,$01,$00,$0D,$08,$07,$07,$07,$94,$01,$00,$0D
.byte $02,$09,$05,$23,$94,$01,$00,$0D,$04,$03,$03,$40,$94,$00,$00,$0D
.byte $04,$01,$01,$4B,$94,$00,$00,$0D,$04,$01,$01,$53,$94,$00,$00,$0D
.byte $04,$01,$01,$5B,$94,$00,$00,$0D,$04,$01,$01,$63,$94,$00,$00,$0D
.byte $04,$01,$01,$6B,$94,$00,$00,$0D,$02,$05,$05,$73,$94,$00,$00,$0D
.byte $05,$01,$01,$86,$94,$01,$00,$0D,$24,$05,$15,$9F,$96,$01,$00,$1A
.byte $24,$0F,$0F,$DA,$95,$01,$00,$34,$24,$0D,$0F,$3B,$96,$01,$00,$34
.byte $24,$0D,$0D,$BF,$96,$01,$00,$4E,$24,$11,$13,$17,$97,$01,$00,$4E
.byte $24,$09,$07,$B4,$97,$01,$00,$4E,$24,$0F,$0F,$D9,$97,$01,$00,$4E
.byte $24,$11,$11,$81,$87,$01,$00,$4E,$24,$0D,$07,$12,$88,$01,$00,$4E
.byte $24,$0D,$0D,$D9,$86,$01,$00,$1A,$24,$0B,$0F,$28,$87,$01,$00,$1A
.byte $24,$0B,$09,$5B,$87,$01,$00,$1A,$24,$09,$09,$3F,$98,$00,$00,$34
.byte $24,$0B,$0B,$4E,$98,$01,$00,$5B,$24,$1B,$05,$85,$98,$01,$00,$5B
.byte $24,$1B,$05,$D3,$98,$01,$00,$5B,$24,$0B,$09,$24,$99,$01,$00,$5B
.byte $24,$13,$1B,$59,$99,$01,$00,$5B,$24,$0F,$11,$50,$9A,$01,$00,$5B
.byte $24,$11,$13,$76,$9A,$01,$00,$5B,$24,$13,$17,$27,$95,$01,$00,$5B
.byte $24,$11,$13,$FC,$9A,$01,$00,$34,$24,$05,$19,$00,$00,$00,$00,$5B
.byte $24,$0F,$13,$00,$00,$00,$00,$5B,$24,$03,$0D,$80,$9B,$00,$00,$1A
.byte $28,$0B,$09,$8A,$9B,$01,$00,$27,$28,$09,$09,$A7,$9B,$01,$00,$27
.byte $28,$09,$09,$CF,$9B,$01,$00,$27,$28,$0B,$07,$F1,$9B,$01,$00,$27
.byte $28,$0D,$06,$19,$9C,$01,$00,$27,$28,$0B,$0B,$3B,$9C,$01,$00,$41
.byte $28,$0B,$0B,$83,$9C,$01,$00,$27,$28,$09,$09,$CE,$9C,$01,$00,$27
.byte $28,$07,$07,$FD,$9C,$01,$00,$27,$28,$05,$05,$20,$9D,$01,$00,$27
.byte $28,$05,$03,$3E,$9D,$00,$00,$27,$28,$03,$03,$4A,$9D,$00,$00,$27
.byte $28,$15,$15,$54,$9D,$01,$00,$41,$28,$11,$11,$AF,$9D,$01,$00,$27
.byte $28,$0F,$0F,$3B,$9E,$01,$00,$27,$28,$0D,$0D,$AE,$9E,$01,$00,$27
.byte $28,$0D,$0D,$12,$9F,$01,$00,$27,$28,$09,$0D,$7A,$9F,$01,$00,$27
.byte $28,$09,$09,$B5,$9F,$01,$00,$27,$28,$07,$07,$DC,$9F,$01,$00,$27
.byte $28,$0B,$0B,$F4,$9F,$00,$00,$41,$28,$0B,$0B,$17,$A0,$00,$00,$27
.byte $28,$0B,$0B,$3C,$A0,$00,$00,$27,$28,$09,$09,$60,$A0,$00,$00,$27
.byte $28,$09,$09,$7E,$A0,$00,$00,$27,$28,$09,$09,$9A,$A0,$00,$00,$27
.byte $28,$05,$05,$C1,$A0,$00,$00,$27,$28,$05,$05,$D3,$A0,$00,$00,$27
.byte $28,$07,$07,$E7,$A0,$00,$00,$41,$28,$07,$07,$FF,$A0,$00,$00,$27
.byte $28,$07,$07,$15,$A1,$00,$00,$27,$28,$07,$07,$2B,$A1,$00,$00,$27
.byte $28,$07,$07,$41,$A1,$00,$00,$27,$28,$05,$05,$57,$A1,$00,$00,$27
.byte $28,$07,$07,$68,$A1,$00,$00,$41,$28,$07,$07,$7F,$A1,$00,$00,$27
.byte $28,$07,$07,$94,$A1,$00,$00,$27,$28,$07,$07,$A9,$A1,$00,$00,$27
.byte $28,$07,$07,$BE,$A1,$00,$00,$27,$28,$07,$07,$D3
.byte $A1,$00,$00,$27,$28,$07
.byte $07,$E8,$A1
.byte $00,$00
.byte $27
; data -> unknown

.byte $77,$77,$5F,$5F,$00,$77,$77,$6A,$5F,$00,$77,$77,$5F,$6A,$00,$77
.byte $77,$6A,$6A,$00,$77,$7C,$5F,$7B,$00,$77,$7C,$6A,$7B,$00,$5F,$7B
.byte $5F,$7B,$00,$5F,$7B,$7D,$7E,$00,$77,$7C,$6B,$7B,$00,$77,$77,$6B
.byte $5F,$00,$77,$77,$5F,$6B,$00,$77,$77,$6B,$6B,$00,$77,$77
.byte $6B,$6A,$00,$77,$77,$6A,$6B
.byte $00,$5F,$5F
.byte $5F,$5F
.byte $00
; unknown -> data
; external indirect data load target (via $0F:$DEBD, $0F:$F93F)
; indirect data load target
; indirect data load target
.byte $C4
; indirect data load target
.byte $C8
; indirect data load target
.byte $C3
; indirect data load target
.byte $C7
; indirect data load target
.byte $02
; indirect data load target
.byte $90
; indirect data load target
.byte $90
; indirect data load target
.byte $90
; indirect data load target
.byte $90
; indirect data load target
.byte $03
; indirect data load target
.byte $91
; indirect data load target
.byte $91
; indirect data load target
.byte $91
; indirect data load target
.byte $91
; indirect data load target
.byte $51
; indirect data load target
.byte $A2
; indirect data load target
.byte $A2
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $53
; indirect data load target
.byte $A1
; indirect data load target
.byte $A0
; indirect data load target
.byte $A0
; indirect data load target
.byte $A1
; indirect data load target
.byte $40
; indirect data load target
.byte $94
; indirect data load target
.byte $96
; indirect data load target
.byte $93
; indirect data load target
.byte $95
; indirect data load target
.byte $F2
; indirect data load target
.byte $BE
; indirect data load target
.byte $C0
; indirect data load target
.byte $BD
; indirect data load target
.byte $BF
; indirect data load target
.byte $03
; indirect data load target
.byte $9C
; indirect data load target
.byte $9E
; indirect data load target
.byte $9B
; indirect data load target
.byte $9D
; indirect data load target
.byte $61
; indirect data load target
.byte $92
; indirect data load target
.byte $92
; indirect data load target
.byte $92
; indirect data load target
.byte $92
; indirect data load target
.byte $73
; indirect data load target
.byte $B6
; indirect data load target
.byte $B8
; indirect data load target
.byte $B5
; indirect data load target
.byte $B7
; indirect data load target
.byte $00
; indirect data load target
.byte $DE
; indirect data load target
.byte $E0
; indirect data load target
.byte $DD
; indirect data load target
.byte $DF
; indirect data load target
.byte $11
; indirect data load target
.byte $DA
; indirect data load target
.byte $DC
; indirect data load target
.byte $D9
; indirect data load target
.byte $DB
; indirect data load target
.byte $12
; indirect data load target
.byte $98
; indirect data load target
.byte $9A
; indirect data load target
.byte $97
; indirect data load target
.byte $99
; indirect data load target
.byte $12
; indirect data load target
.byte $BA
; indirect data load target
.byte $BC
; indirect data load target
.byte $B9
; indirect data load target
.byte $BB
; indirect data load target
.byte $00
; indirect data load target
.byte $D2
; indirect data load target
.byte $D4
; indirect data load target
.byte $D1
; indirect data load target
.byte $D3
; indirect data load target
.byte $12
; indirect data load target
.byte $D6
; indirect data load target
.byte $D8
; indirect data load target
.byte $D5
; indirect data load target
.byte $D7
; indirect data load target
.byte $12
; indirect data load target
.byte $C2
; indirect data load target
.byte $C6
; indirect data load target
.byte $C1
; indirect data load target
.byte $C5
; indirect data load target
.byte $12
; indirect data load target
.byte $CA
; indirect data load target
.byte $CE
; indirect data load target
.byte $C9
; indirect data load target
.byte $CD
; indirect data load target
.byte $12
; indirect data load target
.byte $CC
; indirect data load target
.byte $D0
; indirect data load target
.byte $CB
; indirect data load target
.byte $CF
; indirect data load target
.byte $02
; indirect data load target
.byte $E2
; indirect data load target
.byte $E4
; indirect data load target
.byte $E1
; indirect data load target
.byte $E3
; indirect data load target
.byte $F0
; indirect data load target
.byte $A4
; indirect data load target
.byte $A6
; indirect data load target
.byte $A3
; indirect data load target
.byte $A5
; indirect data load target
.byte $40
; indirect data load target
.byte $A8
; indirect data load target
.byte $A6
; indirect data load target
.byte $A7
; indirect data load target
.byte $A5
; indirect data load target
.byte $40
; indirect data load target
.byte $A8
; indirect data load target
.byte $B0
; indirect data load target
.byte $A7
; indirect data load target
.byte $A9
; indirect data load target
.byte $40
; indirect data load target
.byte $AA
; indirect data load target
.byte $A7
; indirect data load target
.byte $A3
; indirect data load target
.byte $A5
; indirect data load target
.byte $40
; indirect data load target
.byte $A5
; indirect data load target
.byte $AB
; indirect data load target
.byte $A7
; indirect data load target
.byte $A9
; indirect data load target
.byte $40
; indirect data load target
.byte $AA
; indirect data load target
.byte $A7
; indirect data load target
.byte $AC
; indirect data load target
.byte $AD
; indirect data load target
.byte $40
; indirect data load target
.byte $A5
; indirect data load target
.byte $A7
; indirect data load target
.byte $AE
; indirect data load target
.byte $AD
; indirect data load target
.byte $40
; indirect data load target
.byte $A5
; indirect data load target
.byte $AB
; indirect data load target
.byte $AE
; indirect data load target
.byte $AF
; indirect data load target
.byte $40
; indirect data load target
.byte $B1
; indirect data load target
.byte $A7
; indirect data load target
.byte $A7
; indirect data load target
.byte $A5
; indirect data load target
.byte $40
; indirect data load target
.byte $A5
; indirect data load target
.byte $B2
; indirect data load target
.byte $A7
; indirect data load target
.byte $A5
; indirect data load target
.byte $40
; indirect data load target
.byte $A5
; indirect data load target
.byte $A7
; indirect data load target
.byte $A7
; indirect data load target
.byte $B3
; indirect data load target
.byte $40
; indirect data load target
.byte $A5
; indirect data load target
.byte $A7
; indirect data load target
.byte $B4
; indirect data load target
.byte $A5
; external indirect data load target (via $0F:$DEBF, $0F:$F941)
.byte $40
; indirect data load target
; indirect data load target
.byte $91
; indirect data load target
.byte $93
; indirect data load target
.byte $90
; indirect data load target
.byte $92
; indirect data load target
.byte $02
; indirect data load target
.byte $94
; indirect data load target
.byte $94
; indirect data load target
.byte $94
; indirect data load target
.byte $94
; indirect data load target
.byte $03
; indirect data load target
.byte $95
; indirect data load target
.byte $95
; indirect data load target
.byte $95
; indirect data load target
.byte $95
; indirect data load target
.byte $01
; indirect data load target
.byte $9D
; indirect data load target
.byte $9F
; indirect data load target
.byte $9C
; indirect data load target
.byte $9E
; indirect data load target
.byte $03
; indirect data load target
.byte $A1
; indirect data load target
.byte $A0
; indirect data load target
.byte $A0
; indirect data load target
.byte $A1
; indirect data load target
.byte $40
; indirect data load target
.byte $D9
; indirect data load target
.byte $DB
; indirect data load target
.byte $D9
; indirect data load target
.byte $DB
; indirect data load target
.byte $F2
; indirect data load target
.byte $C5
; indirect data load target
.byte $C7
; indirect data load target
.byte $C4
; indirect data load target
.byte $C6
; indirect data load target
.byte $03
; indirect data load target
.byte $D9
; indirect data load target
.byte $DB
; indirect data load target
.byte $D8
; indirect data load target
.byte $DA
; indirect data load target
.byte $F2
; indirect data load target
.byte $A4
; indirect data load target
.byte $A4
; indirect data load target
.byte $A4
; indirect data load target
.byte $A4
; indirect data load target
.byte $73
; indirect data load target
.byte $C1
; indirect data load target
.byte $C3
; indirect data load target
.byte $C0
; indirect data load target
.byte $C2
; indirect data load target
.byte $00
; indirect data load target
.byte $E2
; indirect data load target
.byte $E4
; indirect data load target
.byte $E1
; indirect data load target
.byte $E3
; indirect data load target
.byte $F2
; indirect data load target
.byte $DE
; indirect data load target
.byte $E0
; indirect data load target
.byte $DD
; indirect data load target
.byte $DF
; indirect data load target
.byte $F1
; indirect data load target
.byte $CD
; indirect data load target
.byte $CF
; indirect data load target
.byte $CC
; indirect data load target
.byte $CE
; indirect data load target
.byte $12
; indirect data load target
.byte $BD
; indirect data load target
.byte $BF
; indirect data load target
.byte $BC
; indirect data load target
.byte $BE
; indirect data load target
.byte $F1
; indirect data load target
.byte $EA
; indirect data load target
.byte $EC
; indirect data load target
.byte $E9
; indirect data load target
.byte $EB
; indirect data load target
.byte $F1
; indirect data load target
.byte $EE
; indirect data load target
.byte $F0
; indirect data load target
.byte $ED
; indirect data load target
.byte $EF
; indirect data load target
.byte $F1
; indirect data load target
.byte $C9
; indirect data load target
.byte $CB
; indirect data load target
.byte $C8
; indirect data load target
.byte $CA
; indirect data load target
.byte $22
; indirect data load target
.byte $B1
; indirect data load target
.byte $B1
; indirect data load target
.byte $B1
; indirect data load target
.byte $B1
; indirect data load target
.byte $80
; indirect data load target
.byte $AE
; indirect data load target
.byte $B0
; indirect data load target
.byte $AD
; indirect data load target
.byte $AF
; indirect data load target
.byte $F0
; indirect data load target
.byte $D1
; indirect data load target
.byte $D3
; indirect data load target
.byte $D0
; indirect data load target
.byte $D2
; indirect data load target
.byte $30
; indirect data load target
.byte $E6
; indirect data load target
.byte $E8
; indirect data load target
.byte $E5
; indirect data load target
.byte $E7
; indirect data load target
.byte $02
; indirect data load target
.byte $B2
; indirect data load target
.byte $B3
; indirect data load target
.byte $B2
; indirect data load target
.byte $B3
; indirect data load target
.byte $01
; indirect data load target
.byte $D5
; indirect data load target
.byte $D7
; indirect data load target
.byte $D4
; indirect data load target
.byte $D6
; indirect data load target
.byte $02
; indirect data load target
.byte $F2
; indirect data load target
.byte $F4
; indirect data load target
.byte $F1
; indirect data load target
.byte $F3
; indirect data load target
.byte $02
; indirect data load target
.byte $B5
; indirect data load target
.byte $B7
; indirect data load target
.byte $B4
; indirect data load target
.byte $B6
; indirect data load target
.byte $F2
; indirect data load target
.byte $B9
; indirect data load target
.byte $BB
; indirect data load target
.byte $B8
; indirect data load target
.byte $BA
; indirect data load target
.byte $F1
; indirect data load target
.byte $A6
; indirect data load target
.byte $A8
; indirect data load target
.byte $A5
; indirect data load target
.byte $A7
; indirect data load target
.byte $F2
; indirect data load target
.byte $97
; indirect data load target
.byte $99
; indirect data load target
.byte $96
; indirect data load target
.byte $98
; indirect data load target
.byte $F2
; indirect data load target
.byte $F6
; indirect data load target
.byte $F8
; indirect data load target
.byte $F5
; indirect data load target
.byte $F7
; indirect data load target
.byte $F0
; indirect data load target
.byte $9B
; indirect data load target
.byte $A3
; indirect data load target
.byte $9A
; indirect data load target
.byte $A2
; indirect data load target
.byte $01
; indirect data load target
.byte $AA
; indirect data load target
.byte $AC
; indirect data load target
.byte $A9
; indirect data load target
.byte $AB
; indirect data load target
.byte $91
; indirect data load target
.byte $84
; indirect data load target
.byte $84
; indirect data load target
.byte $84
; indirect data load target
.byte $84
; indirect data load target
.byte $00
; indirect data load target
.byte $F9
; indirect data load target
.byte $F9
; indirect data load target
.byte $DC
; indirect data load target
.byte $DC
; indirect data load target
.byte $02
; indirect data load target
.byte $DC
; indirect data load target
.byte $DC
; indirect data load target
.byte $DC
; indirect data load target
.byte $DC
; indirect data load target
.byte $02
; indirect data load target
.byte $DC
; indirect data load target
.byte $DC
; indirect data load target
.byte $DC
; indirect data load target
.byte $DC
; indirect data load target
.byte $02
; indirect data load target
.byte $DC
; indirect data load target
.byte $DC
; indirect data load target
.byte $DC
; indirect data load target
.byte $DC
; indirect data load target
.byte $02
; indirect data load target
.byte $5F
; indirect data load target
.byte $5F
; indirect data load target
.byte $5F
; indirect data load target
.byte $5F
; indirect data load target
.byte $01
; indirect data load target
.byte $5F
; indirect data load target
.byte $5F
; indirect data load target
.byte $5F
; indirect data load target
.byte $5F
; indirect data load target
.byte $01
; indirect data load target
.byte $5F
; indirect data load target
.byte $5F
; indirect data load target
.byte $5F
; indirect data load target
.byte $5F
; indirect data load target
.byte $01
; indirect data load target
.byte $5F
; indirect data load target
.byte $5F
; indirect data load target
.byte $5F
; indirect data load target
.byte $5F
; external indirect data load target (via $0F:$DEC1, $0F:$F943)
.byte $01
; indirect data load target
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $02
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $02
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $02
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $02
; indirect data load target
.byte $BD
; indirect data load target
.byte $BE
; indirect data load target
.byte $BE
; indirect data load target
.byte $BD
; indirect data load target
.byte $A0
; indirect data load target
.byte $BD
; indirect data load target
.byte $BE
; indirect data load target
.byte $BE
; indirect data load target
.byte $BD
; indirect data load target
.byte $A0
; indirect data load target
.byte $BD
; indirect data load target
.byte $BE
; indirect data load target
.byte $BE
; indirect data load target
.byte $BD
; indirect data load target
.byte $A0
; indirect data load target
.byte $BD
; indirect data load target
.byte $BE
; indirect data load target
.byte $BE
; indirect data load target
.byte $BD
; indirect data load target
.byte $A0
; indirect data load target
.byte $93
; indirect data load target
.byte $97
; indirect data load target
.byte $92
; indirect data load target
.byte $96
; indirect data load target
.byte $F3
; indirect data load target
.byte $9B
; indirect data load target
.byte $9F
; indirect data load target
.byte $9A
; indirect data load target
.byte $9E
; indirect data load target
.byte $F3
; indirect data load target
.byte $91
; indirect data load target
.byte $95
; indirect data load target
.byte $90
; indirect data load target
.byte $94
; indirect data load target
.byte $F3
; indirect data load target
.byte $99
; indirect data load target
.byte $9D
; indirect data load target
.byte $98
; indirect data load target
.byte $9C
; indirect data load target
.byte $F3
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $02
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $02
; indirect data load target
.byte $BA
; indirect data load target
.byte $BC
; indirect data load target
.byte $B9
; indirect data load target
.byte $BB
; indirect data load target
.byte $11
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $02
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $02
; indirect data load target
.byte $B6
; indirect data load target
.byte $B8
; indirect data load target
.byte $B5
; indirect data load target
.byte $B7
; indirect data load target
.byte $21
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $02
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $02
; indirect data load target
.byte $B2
; indirect data load target
.byte $B4
; indirect data load target
.byte $B1
; indirect data load target
.byte $B3
; indirect data load target
.byte $01
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $02
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $02
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $02
; indirect data load target
.byte $C4
; indirect data load target
.byte $C8
; indirect data load target
.byte $C3
; indirect data load target
.byte $C7
; indirect data load target
.byte $F2
; indirect data load target
.byte $CC
; indirect data load target
.byte $D0
; indirect data load target
.byte $CB
; indirect data load target
.byte $CF
; indirect data load target
.byte $F2
; indirect data load target
.byte $C2
; indirect data load target
.byte $C6
; indirect data load target
.byte $C1
; indirect data load target
.byte $C5
; indirect data load target
.byte $F2
; indirect data load target
.byte $CA
; indirect data load target
.byte $CE
; indirect data load target
.byte $C9
; indirect data load target
.byte $CD
; indirect data load target
.byte $F2
; indirect data load target
.byte $A3
; indirect data load target
.byte $A7
; indirect data load target
.byte $A2
; indirect data load target
.byte $A6
; indirect data load target
.byte $F3
; indirect data load target
.byte $AB
; indirect data load target
.byte $AF
; indirect data load target
.byte $AA
; indirect data load target
.byte $AE
; indirect data load target
.byte $F3
; indirect data load target
.byte $A1
; indirect data load target
.byte $A5
; indirect data load target
.byte $A0
; indirect data load target
.byte $A4
; indirect data load target
.byte $F3
; indirect data load target
.byte $A9
; indirect data load target
.byte $AD
; indirect data load target
.byte $A8
; indirect data load target
.byte $AC
; indirect data load target
.byte $F3
; indirect data load target
.byte $5F
; indirect data load target
.byte $5F
; indirect data load target
.byte $5F
; indirect data load target
.byte $5F
; indirect data load target
.byte $01
; indirect data load target
.byte $5F
; indirect data load target
.byte $5F
; indirect data load target
.byte $5F
; indirect data load target
.byte $5F
; indirect data load target
.byte $01
; indirect data load target
.byte $5F
; indirect data load target
.byte $5F
; indirect data load target
.byte $5F
; indirect data load target
.byte $5F
; indirect data load target
.byte $01
; indirect data load target
.byte $5F
; indirect data load target
.byte $5F
; indirect data load target
.byte $5F
; indirect data load target
.byte $5F
; indirect data load target
.byte $01
; indirect data load target
.byte $5F
; indirect data load target
.byte $5F
; indirect data load target
.byte $5F
; indirect data load target
.byte $5F
; indirect data load target
.byte $01
; indirect data load target
.byte $5F
; indirect data load target
.byte $5F
; indirect data load target
.byte $5F
; indirect data load target
.byte $5F
; indirect data load target
.byte $01
; indirect data load target
.byte $5F
; indirect data load target
.byte $5F
; indirect data load target
.byte $5F
; indirect data load target
.byte $5F
; indirect data load target
.byte $01
; indirect data load target
.byte $5F
; indirect data load target
.byte $5F
; indirect data load target
.byte $5F
; indirect data load target
.byte $5F
; external indirect data load target (via $0F:$DEC3, $0F:$F945)
.byte $01
; indirect data load target
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $03
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $03
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $03
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $03
; indirect data load target
.byte $A3
; indirect data load target
.byte $A7
; indirect data load target
.byte $A2
; indirect data load target
.byte $A6
; indirect data load target
.byte $03
; indirect data load target
.byte $AB
; indirect data load target
.byte $AF
; indirect data load target
.byte $AA
; indirect data load target
.byte $AE
; indirect data load target
.byte $03
; indirect data load target
.byte $A1
; indirect data load target
.byte $A5
; indirect data load target
.byte $A0
; indirect data load target
.byte $A4
; indirect data load target
.byte $03
; indirect data load target
.byte $A9
; indirect data load target
.byte $AD
; indirect data load target
.byte $A8
; indirect data load target
.byte $AC
; indirect data load target
.byte $03
; indirect data load target
.byte $E3
; indirect data load target
.byte $E7
; indirect data load target
.byte $E2
; indirect data load target
.byte $E6
; indirect data load target
.byte $F2
; indirect data load target
.byte $EB
; indirect data load target
.byte $EF
; indirect data load target
.byte $EA
; indirect data load target
.byte $EE
; indirect data load target
.byte $F2
; indirect data load target
.byte $E1
; indirect data load target
.byte $E5
; indirect data load target
.byte $E0
; indirect data load target
.byte $E4
; indirect data load target
.byte $F2
; indirect data load target
.byte $E9
; indirect data load target
.byte $ED
; indirect data load target
.byte $E8
; indirect data load target
.byte $EC
; indirect data load target
.byte $F2
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $03
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $03
; indirect data load target
.byte $B2
; indirect data load target
.byte $B4
; indirect data load target
.byte $B1
; indirect data load target
.byte $B3
; indirect data load target
.byte $13
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $03
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $03
; indirect data load target
.byte $B6
; indirect data load target
.byte $B8
; indirect data load target
.byte $B5
; indirect data load target
.byte $B7
; indirect data load target
.byte $23
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $03
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $03
; indirect data load target
.byte $BA
; indirect data load target
.byte $BC
; indirect data load target
.byte $B9
; indirect data load target
.byte $BB
; indirect data load target
.byte $01
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $03
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $03
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $B0
; indirect data load target
.byte $03
; indirect data load target
.byte $C0
; indirect data load target
.byte $C4
; indirect data load target
.byte $BF
; indirect data load target
.byte $C3
; indirect data load target
.byte $F1
; indirect data load target
.byte $C8
; indirect data load target
.byte $CC
; indirect data load target
.byte $C7
; indirect data load target
.byte $CB
; indirect data load target
.byte $F1
; indirect data load target
.byte $BE
; indirect data load target
.byte $C2
; indirect data load target
.byte $BD
; indirect data load target
.byte $C1
; indirect data load target
.byte $F1
; indirect data load target
.byte $C6
; indirect data load target
.byte $CA
; indirect data load target
.byte $C5
; indirect data load target
.byte $C9
; indirect data load target
.byte $F1
; indirect data load target
.byte $93
; indirect data load target
.byte $97
; indirect data load target
.byte $92
; indirect data load target
.byte $96
; indirect data load target
.byte $F2
; indirect data load target
.byte $9B
; indirect data load target
.byte $9F
; indirect data load target
.byte $9A
; indirect data load target
.byte $9E
; indirect data load target
.byte $F2
; indirect data load target
.byte $91
; indirect data load target
.byte $95
; indirect data load target
.byte $90
; indirect data load target
.byte $94
; indirect data load target
.byte $F2
; indirect data load target
.byte $99
; indirect data load target
.byte $9D
; indirect data load target
.byte $98
; indirect data load target
.byte $9C
; indirect data load target
.byte $F2
; indirect data load target
.byte $CD
; indirect data load target
.byte $CD
; indirect data load target
.byte $CD
; indirect data load target
.byte $CD
; indirect data load target
.byte $01
; indirect data load target
.byte $CD
; indirect data load target
.byte $CD
; indirect data load target
.byte $CD
; indirect data load target
.byte $CD
; indirect data load target
.byte $01
; indirect data load target
.byte $CD
; indirect data load target
.byte $CD
; indirect data load target
.byte $CD
; indirect data load target
.byte $CD
; indirect data load target
.byte $01
; indirect data load target
.byte $CD
; indirect data load target
.byte $CD
; indirect data load target
.byte $CD
; indirect data load target
.byte $CD
; indirect data load target
.byte $01
; indirect data load target
.byte $CD
; indirect data load target
.byte $CD
; indirect data load target
.byte $CD
; indirect data load target
.byte $CD
; indirect data load target
.byte $01
; indirect data load target
.byte $CD
; indirect data load target
.byte $CD
; indirect data load target
.byte $CD
; indirect data load target
.byte $CD
; indirect data load target
.byte $01
; indirect data load target
.byte $CD
; indirect data load target
.byte $CD
; indirect data load target
.byte $CD
; indirect data load target
.byte $CD
; indirect data load target
.byte $01
; indirect data load target
.byte $CD
; indirect data load target
.byte $CD
; indirect data load target
.byte $CD
; indirect data load target
.byte $CD
; indirect data load target
.byte $01
; indirect data load target
.byte $84
; indirect data load target
.byte $84
; indirect data load target
.byte $84
; indirect data load target
.byte $84
; indirect data load target
.byte $02
; indirect data load target
.byte $84
; indirect data load target
.byte $84
; indirect data load target
.byte $84
; indirect data load target
.byte $84
; indirect data load target
.byte $02
; indirect data load target
.byte $84
; indirect data load target
.byte $84
; indirect data load target
.byte $84
; indirect data load target
.byte $84
; indirect data load target
.byte $02
; indirect data load target
.byte $84
; indirect data load target
.byte $84
; indirect data load target
.byte $84
; indirect data load target
.byte $84
; -> $02:$A201: Map ID #$6D: Moonbrooke (prologue)
.byte $02
; external data load target (from $0F:$E49B)
; external data load target (from $0F:$E4A0)
.byte $01
; Map ID #$34: Charlock Castle B1/B2
.byte $A2
; indirect data load target (via $81BB)
; Map ID #$35: Charlock Castle B3/B4-1/B5-1
.byte $0E,$0E,$48,$E2,$80,$E2,$5C,$79,$AB,$2A,$04,$F0,$5E,$9E,$53,$43
.byte $3E,$CB,$1E,$F1,$C3,$A2,$7E,$61,$D6,$76,$64,$E9,$B1,$AC,$CF,$6A
.byte $04,$51,$A5,$02,$A5,$8A,$02,$EF,$BA,$51,$62,$11,$66,$A1,$16,$6F
.byte $BD,$EB,$14,$AD,$F9,$67,$3C,$69,$F8,$7E,$65,$DA,$17,$77,$29,$89
.byte $00,$2D,$15,$22,$65,$3C,$A5,$48
.byte $70,$0E,$45,$DE
.byte $19,$68
.byte $10
; indirect data load target (via $81C3)
; Map ID #$36: Charlock Castle B4-2/B5-2/B6
.byte $0C,$10,$48,$E0,$5E,$AB,$E4,$99,$41,$42,$EF,$CB,$BE,$15,$C6,$6A
.byte $71,$14,$1D,$1D,$1E,$4E,$0B,$5E,$C5,$B2,$7D,$2B,$98,$1F,$65,$89
.byte $E6,$3A,$0F,$22,$33,$8D,$6D,$BC,$12,$EB
.byte $7E,$14,$25,$AC,$95
.byte $A0,$07
.byte $90
.byte $94
; indirect data load target (via $81CB)
; Map ID #$32: Sea Cave B4
.byte $0C,$0A,$48,$07,$80,$40,$0A,$00,$50,$0A,$00,$E3,$BA,$AC,$AB,$E2
.byte $81,$40,$28,$14,$0F,$26,$5B,$6D,$CB,$1E,$37
.byte $53,$94,$19,$4A,$27,$BB
.byte $53,$A2,$02
.byte $51
.byte $2D
; indirect data load target (via $81AB)
; Map ID #$33: Sea Cave B5
.byte $12,$12,$48,$22,$95,$DA,$55,$95,$4C,$95,$61,$0C,$3C,$21,$56,$3D
.byte $C6,$AD,$2F,$0C,$87,$82,$2D,$8C,$F1,$12,$A5,$2B,$7E,$4E,$1A,$0E
.byte $86,$49,$67,$2B,$26,$7E,$FB,$9C,$33,$3C,$BD,$27,$C3,$3D,$CF,$D1
.byte $1F,$C0,$F7,$29,$E8,$DA,$B2,$F4,$F9,$05,$DF,$01,$AB,$2C,$F1,$BE
.byte $05,$6B,$CD,$F0,$00,$53,$5B,$E6,$BE,$59,$71,$2F,$AE,$2C,$B2,$F9
.byte $67,$80,$35,$3C,$E9,$04,$A7,$4D,$D3,$A7,$9A,$79,$39,$7F,$2A,$C2
.byte $B8,$73,$10,$E5,$4C,$EF,$A2,$F5,$06,$C0,$D3,$59,$3B,$5D,$EF,$0D
.byte $D6,$3E,$43,$9F,$F0,$B9,$74,$31,$4C,$28,$38,$D6,$6B,$F2,$6C,$4A
.byte $62,$7B,$AB,$B6,$90,$64,$4C,$D1,$A6
.byte $37,$06,$F5,$E4
.byte $9B,$F7
.byte $7E
.byte $01
; indirect data load target (via $81B3)
; Map ID #$02: Midenhall 2F
.byte $0E,$08,$48,$E1,$8B,$49,$65,$44,$59,$E4,$89,$62,$87,$81,$85,$82
.byte $35,$26,$90,$B0,$26,$A1,$2C,$F4,$56,$FC,$B3,$D3,$C5,$09,$83
.byte $AE,$CE,$C8,$00,$F2,$E6,$4A,$62
.byte $44,$EF,$14,$06
.byte $40,$E7
.byte $81
; indirect data load target (via $802B)
; Map ID #$04: Midenhall B1
.byte $0A,$0A,$90,$50,$11,$76,$0F,$92,$8A
.byte $B2,$55,$F3,$A2,$C8
.byte $3C,$CE
.byte $49
.byte $84
; indirect data load target (via $803B)
; Map ID #$05: Leftwyne
.byte $06,$0A,$C5,$28,$46,$4E,$08,$B4,$76,$01,$29,$D4
.byte $66,$AB,$35,$F3,$5D,$BA
.byte $A4,$32,$8C
.byte $F1,$19
.byte $23
; indirect data load target (via $8043)
; Map ID #$06: Cannock
.byte $18,$18,$C1,$08,$25,$92,$89,$81,$AB,$8C,$39,$33,$41,$B7,$F2,$7B
.byte $A2,$55,$78,$5E,$0B,$BE,$E0,$F6,$70,$F4,$16,$3D,$37,$CF,$E0,$D3
.byte $C2,$25,$D9,$F1,$49,$2F,$44,$0A,$CE,$65,$86,$FB,$8D,$55,$47,$17
.byte $00,$36,$5F,$4C,$F3,$83,$19,$BE,$E5,$D9,$5F,$D1,$CD,$3F,$00,$A2
.byte $51,$9A,$84,$26,$2B,$1E,$ED,$AD,$A3,$CE,$89,$86,$5A,$39,$17,$91
.byte $A7,$25,$95,$82,$CB,$1A,$11,$E9,$62,$A3,$C5,$78,$48,$F8,$43,$23
.byte $6F,$BD,$E1,$66,$DC,$51,$45,$69,$E5,$E5,$E2,$45,$14,$14,$15,$57
.byte $8B,$C5,$45,$95,$65,$17,$8C,$5C,$80,$80,$60,$88,$79,$01,$03,$8F
.byte $00,$00,$80,$00,$00,$40,$00,$00,$20,$01,$D1,$8E,$00,$80,$0F,$2D
.byte $91,$59,$18,$4B,$16,$CC,$65,$80,$AC,$DD,$29,$B6,$9B,$C8,$77,$76
.byte $0D,$EE,$00,$BD,$60,$3F,$38,$7B,$C6,$EB,$D6,$E6
.byte $E3,$54,$33,$E3,$C6,$94
.byte $A1,$C1,$98
.byte $32,$C0
.byte $10
; indirect data load target (via $804B)
; Map ID #$07: Hamlin
.byte $1A,$1A,$C3,$00,$25,$8B,$A5,$A9,$D0,$3C,$24,$95,$29,$02,$04,$08
.byte $92,$9E,$06,$78,$40,$BA,$F0,$20,$5E,$75,$A5,$9E,$5A,$53,$D5,$05
.byte $0A,$0B,$E0,$D0,$20,$27,$4E,$A4,$19,$6E,$A8,$BA,$94,$56,$4B,$D4
.byte $76,$74,$15,$2A,$CB,$9F,$62,$EF,$B9,$A7,$48,$59,$65,$B3,$C3,$4F
.byte $DE,$46,$4F,$2B,$6C,$79,$2C,$2E,$9F,$2C,$B6,$79,$F8,$4B,$1E,$16
.byte $9F,$54,$A0,$34,$02,$8A,$34,$F0,$F1,$40,$37,$C6,$BC,$03,$40,$C5
.byte $FA,$03,$3E,$BC,$14,$0D,$F0,$AC,$02,$28,$14,$05,$02,$05,$03,$40
.byte $D0,$2F,$BF,$00,$4F,$7A,$F4,$E7,$91,$1C,$B8,$02,$8A,$6B,$CA,$7F
.byte $0C,$6C,$B1,$AA,$6C,$1F,$BD,$44,$A2,$CB,$79,$DC,$63,$37,$89,$23
.byte $F1,$B3,$1A,$87,$42,$82,$79,$9D,$12,$29,$A1,$C3,$76
.byte $20,$5E,$D2,$0D,$E5,$91,$A5
.byte $28,$24,$4D
.byte $8C,$46
.byte $07
; indirect data load target (via $8053)
; Map ID #$08: Hamlin Waterway
.byte $18,$18,$C6,$08,$24,$CF,$4D,$01,$C4,$BC,$82,$08,$27,$1F,$7B,$7D
.byte $27,$25,$C0,$71,$AD,$2C,$08,$4B,$D1,$0C,$86,$5F,$04,$AB,$25,$E7
.byte $80,$4B,$29,$14,$AF,$CC,$10,$D1,$B3,$A0,$04,$CF,$01,$96,$2D,$9E
.byte $00,$02,$02,$67,$96,$13,$3E,$CB,$07,$24,$CB,$7D,$CB,$02,$9C,$F8
.byte $E4,$2C,$FD,$BA,$DD,$3D,$EC,$DE,$A0,$91,$32,$16,$92,$C3,$6B,$C9
.byte $9E,$0D,$A1,$F3,$3C,$36,$87,$A4,$F0,$0B,$06,$E7,$A9,$C2,$BA,$AE
.byte $8E,$AA,$DF,$3B,$4A,$F7,$13,$22,$09,$1B,$20,$58,$30,$57,$D7,$EB
.byte $69,$F9,$E3,$43,$C2,$CF,$94,$28,$51,$AA,$78,$28,$AD,$3D,$3A,$37
.byte $C0,$74,$5B,$82,$39,$B0,$04,$E6,$79,$6F,$A0,$86,$78,$81,$11,$39
.byte $21,$D0,$E0,$89,$08,$71,$15,$A5,$84,$19,$1E,$42,$59,$C5,$EA,$40
.byte $E4,$65,$2A,$B8,$B4,$C8,$44,$F2,$D8,$B5,$8B,$84,$B1,$0C,$A7,$13
.byte $6F,$B0,$DE,$0D,$D9,$5D,$01,$D9,$C1,$98,$FF,$90,$66,$72,$70
.byte $56,$C9,$0B,$D8,$63,$BB,$9E,$74
.byte $A5,$1A,$8B,$41
.byte $93,$80
.byte $80
; indirect data load target (via $805B)
; Map ID #$09: Moonbrooke
.byte $08,$08,$C4,$28,$48,$78,$30,$0D,$F8,$3D,$E0,$12,$95,$A9
.byte $4B,$26,$BD,$3C,$87,$8F,$B1
.byte $7C,$DD,$23,$53
.byte $6B,$CD
.byte $10
; indirect data load target (via $8063)
; Map ID #$03: Midenhall 1F
.byte $14,$14,$C8,$00,$88,$05,$97,$7C,$01,$B4,$4D,$F7,$80,$2E,$F8,$00
.byte $6F,$97,$12,$AD,$9B,$E9,$77,$DE,$DF,$7E,$0C,$09,$34,$64,$A4,$F0
.byte $55,$EC,$75,$38,$67,$B9,$87,$A5,$E1,$D0,$BC,$70,$88,$41,$9E,$AA
.byte $E6,$86,$A7,$81,$9C,$72,$A7,$82,$DD,$1D,$DB,$A9,$05,$A5,$42,$53
.byte $41,$E0,$05,$05,$C4,$A0,$DF,$3C,$08,$38,$DA,$0B,$C4,$19,$06,$3E
.byte $97,$04,$A3,$55,$28,$8C,$F0,$82,$C4,$0C,$3D,$46,$3E,$8D,$F2,$CB
.byte $28,$89,$E7,$82,$BF,$21,$87,$C9,$38,$EF,$A4,$F5,$B2,$DA,$6F,$4E
.byte $8F,$C9,$B9,$2C,$74,$37,$4F,$2F,$09,$32,$F1,$1D,$4E,$15,$09,$D6
.byte $BD,$FD,$BB,$A5,$75,$1E,$C9,$DE,$7C,$66,$E9,$DF,$7C,$0B,$63,$64
.byte $EC,$E7,$9B,$F1,$96,$67,$CF,$86,$B3,$49,$8C,$B2,$53,$24,$68,$31
.byte $9C,$88,$4E,$F8,$12,$52,$B7,$6B,$4C,$6F,$0E,$AF,$AC,$2B,$5A,$2E
.byte $85,$99,$C9,$5D,$59,$0E,$C2,$82,$C0,$66,$0F,$A3,$EE,$82,$41,$EE
.byte $14,$C0,$E5,$DA,$0D,$4B,$F2,$96,$0B,$59
.byte $17,$DF,$CA,$B9,$3F
.byte $74,$ED
.byte $44
.byte $80
; indirect data load target (via $801B, $8033)
; Map ID #$0A: Moonbrooke B1
.byte $18,$18,$C1,$00,$39,$0C,$51,$3A,$18,$01,$25,$B3,$C0,$AD,$24,$73
.byte $47,$E0,$74,$37,$27,$24,$BB,$C3,$51,$82,$B2,$CA,$4B,$39,$A9,$40
.byte $9E,$11,$43,$94,$00,$B3,$A7,$95,$5C,$F9,$42,$8A,$15,$AB,$EE,$11
.byte $C2,$8D,$19,$41,$F4,$80,$B0,$10,$31,$BE,$8D,$03,$CF,$78,$36,$BC
.byte $68,$B0,$60,$82,$3C,$F0,$01,$40,$68,$51,$58,$79,$E0,$1A,$F0,$14
.byte $0A,$06,$BE,$06,$B3,$DE,$E5,$61,$51,$78,$F5,$CB,$C9,$DC,$AF,$37
.byte $B6,$BB,$FB,$BF,$5B,$64,$27,$49,$89,$E9,$39,$8C,$95,$C9,$8C,$EE
.byte $33,$A9,$A1,$F5,$3C,$6E,$EE,$6F,$5E,$19,$92,$C3,$12,$D8,$6B,$86
.byte $F8,$72,$33,$11,$48,$61,$38,$BD,$C2,$29,$2F
.byte $B9,$27,$E1,$F1,$42,$94
.byte $74,$53,$C6
.byte $46
.byte $02
; indirect data load target (via $806B)
; Map ID #$0B: Lianport
.byte $06,$07,$C5,$00,$58,$04,$1E,$22,$A3,$09,$1B,$EF,$2F
.byte $30,$BF,$2F,$43,$77,$A4
.byte $16,$E6,$71
.byte $0C,$62
.byte $04
; indirect data load target (via $8073)
; Map ID #$0C: Tantegel
.byte $1A,$1A,$C1,$08,$44,$28,$33,$A4,$73,$63,$DC,$11,$6F,$C3,$30,$58
.byte $F2,$8E,$C5,$6A,$9A,$3D,$8C,$13,$39,$88,$41,$B1,$48,$02,$6F,$53
.byte $2C,$37,$44,$2B,$43,$3C,$9D,$CA,$0A,$EC,$48,$6B,$ED,$17,$22,$A1
.byte $B5,$1B,$69,$29,$73,$DD,$0D,$60,$FD,$64,$07,$4E,$99,$D1,$E8,$E5
.byte $E2,$24,$BC,$D8,$A9,$C2,$CC,$E5,$CF,$74,$9D,$3F,$A0,$79,$24,$35
.byte $3E,$6C,$F7,$41,$42,$A1,$2E,$7B,$8E,$B9,$78,$F5,$86,$D7,$B9,$98
.byte $96,$CD,$59,$66,$FB,$D1,$73,$DC,$34,$AB,$12,$D6,$F9,$04,$AF,$2B
.byte $12,$6B,$CF,$D3,$5C,$55,$78,$58,$48,$41,$02,$55,$80,$60,$83,$0F
.byte $12,$A8,$78,$C0,$F3,$1E,$10,$18,$23,$C7,$52,$F8,$00,$20,$00,$30
.byte $8A,$68,$CF,$A5,$F0,$A2,$F8,$00,$80,$C1,$A3,$09,$F5,$4F,$17,$C0
.byte $60,$15,$E0,$C4,$F0,$1C,$A4,$A4,$47,$3F,$42,$96,$22,$CA,$B2,$85
.byte $95,$65,$89,$4B,$E5,$B8,$34,$96,$DF,$94,$D3,$CD,$08,$1B,$8E,$1A
.byte $49,$AC,$7C,$3E,$2F,$80,$4E,$EC,$E9,$8D,$4F,$15,$98,$21,$F4,$2B
.byte $6E,$71,$34,$39,$4A,$09,$09,$AA
.byte $9A,$DC,$8D,$4F
.byte $C4,$70
.byte $40
; indirect data load target (via $807B)
; Map ID #$0D: Tantegel Town 2F
.byte $1E,$14,$C1,$08,$04,$4B,$52,$15,$6A,$1A,$47,$B3,$D5,$02,$08,$95
.byte $6B,$79,$64,$B1,$0D,$F6,$17,$C6,$87,$86,$9F,$84,$A7,$9D,$18,$AE
.byte $0E,$B3,$C3,$43,$C8,$24,$B6,$71,$B7,$2C,$9C,$F0,$C5,$E8,$85,$59
.byte $2F,$49,$6A,$F0,$6D,$B8,$32,$DC,$70,$4D,$F7,$83,$A5,$51,$7A,$2D
.byte $D7,$9E,$91,$4B,$CB,$A2,$5E,$4F,$C4,$E4,$95,$4E,$05,$B7,$14,$B1
.byte $C3,$08,$E0,$F4,$71,$E3,$2F,$29,$9A,$FE,$A8,$60,$C6,$09,$81,$D6
.byte $2D,$5D,$0D,$A2,$A2,$B4,$4C,$5E,$A7,$05,$9E,$59,$08,$11,$13,$8F
.byte $3D,$02,$08,$C3,$C4,$E4,$38,$00,$40,$39,$4A,$80,$28,$00,$AD,$41
.byte $E1,$18,$28,$6B,$3C,$BE,$9E,$55,$E4,$75,$50,$A8,$34,$D1,$54,$F2
.byte $8F,$82,$2B,$85,$34,$A8,$20,$C1,$A3,$1E,$2F,$80,$A3,$5E,$3C,$06
.byte $78,$11,$82,$78,$C6,$F9,$3D,$78,$FD,$0A,$AF,$C4,$CC,$57,$CC,$B2
.byte $19,$6F,$98,$E3,$72,$6B,$62,$B1,$1C,$CE,$41,$0D,$DC,$D3,$FA,$55
.byte $9D,$D9,$D9,$A5,$03,$77,$74,$B4,$58,$27,$92,$CB,$10,$94,$6E,$92
.byte $73,$38,$16,$B9,$B3,$8B,$BE,$E8,$B3,$0D,$A7,$89,$61,$77,$E2,$58
.byte $13,$5E,$0F,$13,$B1,$A2,$4A,$56,$42
.byte $0A,$40,$92,$14
.byte $64,$16
.byte $C8
.byte $82
; indirect data load target (via $8083)
; Map ID #$0E: Tantegel Castle 2F
.byte $08,$08,$D0,$28,$04,$9C,$D3,$76,$3F,$65
.byte $BC,$DE,$D1,$DE,$23
.byte $3C,$83,$39
.byte $86
.byte $10
; indirect data load target (via $808B)
; Map ID #$0F: Osterfair
.byte $08,$08,$90,$50,$12,$76,$3F,$6B
.byte $70,$E9,$24,$F3
.byte $3B,$4C
.byte $20
; indirect data load target (via $8093)
; Map ID #$10: Zahan
.byte $18,$18,$C1,$00,$24,$B3,$46,$40,$C5,$C2,$9C,$80,$CC,$FB,$09,$59
.byte $3E,$A3,$69,$E2,$16,$F4,$39,$B9,$EB,$54,$2C,$A9,$74,$59,$5E,$25
.byte $98,$CB,$F4,$40,$C9,$56,$5F,$7B,$F8,$38,$B4,$44,$8A,$0B,$E3,$E2
.byte $14,$44,$F1,$D0,$DF,$9E,$12,$26,$57,$14,$4B,$C1,$D1,$CA,$57,$37
.byte $03,$92,$85,$C9,$12,$A0,$9F,$C6,$62,$B7,$4C,$5E,$AB,$9D,$D9,$C2
.byte $7B,$F4,$1A,$64,$C6,$F8,$91,$CC,$5C,$91,$6F,$94,$A1,$65,$57,$C2
.byte $D1,$FE,$20,$94,$06,$99,$F5,$17,$DC,$EF,$80,$00,$02,$80,$00,$01
.byte $40,$00,$00,$A0,$68,$C2,$7E,$9A,$79,$01,$88,$9E,$06,$61,$E4,$3C
.byte $45,$40,$4D,$01,$8A,$8C,$5F,$B9,$F4,$F5,$F2,$35,$28,$A6,$8B,$F1
.byte $53,$C1,$E1,$67,$8B,$CD,$42,$42,$27,$E2,$2E,$19,$06,$E2,$21,$BB
.byte $81,$BF,$FA,$A9,$9B,$82,$22,$55,$3C,$D6,$3F,$E7,$11,$9D,$FC,$3F
.byte $33,$AB,$C3,$C3,$A6,$E1,$0B,$00,$E1,$93,$7E,$8D,$07,$29,$41,$58
.byte $FD,$00,$04,$44,$48,$8A,$A8,$AD,$5B,$12,$DE,$18,$C4
.byte $9C,$39,$89,$2C,$21,$6A
.byte $11,$25,$E7
.byte $72,$0F
.byte $26
; indirect data load target (via $809B)
; Map ID #$11: Tuhn
.byte $18,$18,$C1,$08,$05,$A2,$7B,$94,$0D,$65,$41,$A1,$D9,$2A,$D2,$54
.byte $E3,$3F,$48,$A1,$09,$9E,$84,$02,$C0,$44,$3B,$1B,$41,$CA,$9E,$A9
.byte $45,$8B,$CF,$A0,$9B,$EE,$35,$82,$EF,$A2,$AC,$BC,$9F,$83,$9B,$89
.byte $FC,$3A,$1A,$3A,$44,$E2,$9E,$00,$00,$40,$00,$00,$40,$00,$0E,$5C
.byte $D6,$FB,$81,$3C,$00,$0F,$0B,$45,$6A,$C2,$5E,$8E,$15,$84,$BC,$D3
.byte $28,$20,$20,$9C,$7B,$42,$08,$08,$89,$C7,$D0,$58,$B1,$65,$2A,$10
.byte $21,$29,$60,$02,$52,$C2,$04,$22,$96,$54,$A9,$5C,$B1,$E8,$10,$46
.byte $3C,$4F,$04,$B2,$51,$DA,$C2,$C5,$D2,$DC,$B3,$D7,$7D,$33,$D7,$7E
.byte $0D,$A3,$D3,$3E,$CC,$FB,$33,$F7,$DE,$76,$6F,$26,$7E,$FB,$CB,$67
.byte $1E,$72,$E7,$E1,$BD,$D4,$25,$8A,$86,$B0,$D3,$11,$0A,$62,$36,$19
.byte $0D,$CC,$4D,$04,$17,$9B,$C7,$E4,$93,$78,$88,$92,$45,$49
.byte $67,$88,$29,$40,$11,$F1,$05
.byte $08,$F1,$88
.byte $98,$68
.byte $0E
; indirect data load target (via $80A3)
; Map ID #$12: Tuhn Watergate
.byte $14,$20,$C3,$18,$06,$32,$97,$59,$4A,$69,$5A,$97,$49,$3E,$52,$90
.byte $D4,$88,$10,$09,$A6,$7A,$C5,$BE,$E7,$E0,$58,$B2,$59,$60,$32,$59
.byte $7C,$51,$38,$42,$D6,$79,$6A,$67,$95,$7C,$0D,$28,$C4,$8E,$7F,$44
.byte $B2,$A1,$2D,$19,$F7,$2F,$DE,$5C,$26,$7E,$FB,$90,$BC,$67,$AA,$9E
.byte $0A,$4A,$F2,$C5,$86,$78,$2C,$0B,$2C,$A0,$B2,$A5,$01,$51,$60,$32
.byte $3E,$D7,$9F,$8F,$E5,$E1,$69,$48,$4B,$12,$C2,$0E,$8C,$B5,$28,$52
.byte $AB,$9E,$7C,$41,$08,$72,$4A,$8A,$62,$3E,$80,$A5,$2B,$85,$20,$AA
.byte $F0,$90,$A6,$0B,$91,$0B,$65,$B3,$DC,$82,$24,$A1,$2A,$14,$46,$86
.byte $47,$AD,$96,$CF,$42,$CB,$28,$2C,$B3,$C4,$F1,$26,$A4,$8D,$D0,$FD
.byte $15,$E4,$81,$5C,$3C,$4B,$90,$0C,$ED,$F9,$AC
.byte $51,$19,$87,$A3,$0A,$56
.byte $51,$E7,$1B
.byte $7E
.byte $0B
; indirect data load target (via $80AB)
; Map ID #$13: Wellgarth
.byte $06,$06,$C2,$28,$44,$77,$0E,$50
.byte $EF,$21,$B2,$57
.byte $68,$A9
.byte $12
; indirect data load target (via $80B3)
; Map ID #$14: Wellgarth Underground
.byte $0A,$0A,$C6,$10,$68,$F0,$26,$79,$C1,$91,$33,$C9,$4B,$09,$9E,$75
.byte $DC,$4C,$F3,$C2,$A8,$E2,$00,$9C,$E9,$E3,$35,$E6
.byte $76,$E0,$F9,$39,$70,$65
.byte $2A,$38,$83
.byte $6E
.byte $0A
; indirect data load target (via $80BB)
; Map ID #$15: Beran
.byte $18,$19,$C5,$00,$5A,$42,$02,$E1,$BF,$01,$86,$14,$78,$7D,$18,$C1
.byte $3C,$60,$9F,$58,$D4,$28,$06,$30,$68,$DF,$81,$9E,$40,$53,$28,$3E
.byte $84,$01,$2C,$12,$F8,$2F,$87,$D1,$A2,$9E,$03,$5A,$37,$E2,$79,$7C
.byte $0B,$A4,$F0,$0A,$D3,$7E,$6B,$D3,$CF,$78,$56,$97,$C5,$3D,$EF,$0F
.byte $0F,$08,$F0,$89,$0C,$68,$2E,$8C,$6A,$06,$60,$10,$A0,$AD,$1E,$74
.byte $71,$AD,$01,$77,$C0,$0A,$02,$80,$78,$39,$6A,$54,$55,$38,$7C,$02
.byte $4F,$05,$09,$8A,$00,$00,$A6,$05,$05,$33,$C0,$10,$03,$EC,$0A,$00
.byte $16,$0B,$43,$7E,$06,$41,$F4,$00,$5F,$0D,$2D,$80,$59,$56,$51,$65
.byte $5F,$3F,$38,$2B,$9C,$45,$CF,$AE,$E7,$CB,$7E,$C9,$96,$97,$A4,$F2
.byte $5A,$F6,$6B,$10,$F1,$04,$8F,$0E,$6F,$66,$F5,$70,$D7,$01,$9B,$00
.byte $E8,$38,$43,$29,$4D,$E2,$2F,$0B,$1D,$E2,$E3,$1C,$59,$C5,$43,$77
.byte $27,$30,$B3,$8B,$62,$70,$E0,$86,$11,$99,$CE,$A1,$7B,$68,$2C
.byte $A5,$06,$07,$B4,$25,$1D,$92
.byte $25,$1E,$1A,$03
.byte $89,$60
.byte $C4
; indirect data load target (via $80C3)
; Map ID #$16: Hargon's Castle 1F
.byte $1A,$1A,$C3,$20,$04,$1B,$14,$56,$8A,$5F,$50,$96,$31,$29,$54,$65
.byte $C4,$7A,$D8,$02,$6D,$62,$F9,$9D,$2C,$5B,$65,$17,$5A,$50,$A0,$94
.byte $8A,$C5,$65,$45,$9C,$86,$49,$3F,$6A,$81,$C8,$EC,$38,$33,$17,$83
.byte $A1,$16,$94,$40,$B6,$4A,$B2,$5F,$E8,$AE,$A3,$0D,$07,$9A,$CA,$86
.byte $7B,$4F,$7E,$4E,$67,$59,$FA,$5D,$D6,$12,$F8,$19,$21,$15,$C5,$BA
.byte $AC,$8B,$62,$DF,$70,$DE,$3F,$47,$84,$E8,$36,$84,$49,$B4,$F0,$B4
.byte $08,$90,$20,$25,$58,$20,$8C,$3C,$95,$51,$CC,$18,$E4,$6C,$71,$FD
.byte $AC,$A5,$97,$94,$19,$41,$43,$7C,$B2,$C1,$54,$4B,$2B,$7D,$C2,$8A
.byte $A5,$14,$BC,$ED,$22,$02,$0C,$3C,$20,$21,$55,$7F,$37,$0B,$66,$0E
.byte $61,$87,$CF,$92,$F0,$C7,$16,$71,$24,$07,$E2,$51,$A8,$47,$9F,$91
.byte $C7,$A1,$D0,$7A,$21,$8F,$22,$31,$78,$9E,$20,$12,$CA,$71,$7B,$80
.byte $37,$6F,$B9,$2A,$9B,$01,$E2,$B7,$A8,$D8,$07,$41,$C1,$7C,$1E,$6C
.byte $A5,$85,$28,$04,$A5,$37,$E3,$E4,$56,$FE
.byte $13,$CD,$FC,$2F,$97
.byte $A3,$38
.byte $F2
.byte $6A
; indirect data load target (via $80CB)
; Map ID #$17: Hargon's Castle 7F
.byte $1A,$1A,$C8,$40,$04,$37,$A8,$50,$D9,$6A,$C1,$DC,$31,$0B,$CD,$6A
.byte $F9,$35,$AB,$8C,$C0,$81,$0A,$54,$09,$C5,$59,$62,$58,$32,$C4,$B2
.byte $A8,$12,$A7,$83,$22,$AB,$C2,$28,$05,$96,$72,$B4,$AA,$A0,$15,$65
.byte $8D,$1A,$AB,$E4,$AA,$80,$12,$CB,$F2,$C1,$2C,$4B,$2A,$BC,$32,$C6
.byte $48,$AB,$2F,$28,$01,$5B,$28,$D5,$69,$E2,$A0,$8B,$B6,$FB,$2F,$34
.byte $03,$26,$9A,$0C,$1B,$F0,$4B,$67,$B9,$22,$54,$68,$CF,$A2,$C9,$7D
.byte $E4,$65,$05,$00,$EA,$79,$1B,$73,$DE,$EA,$43,$19,$37,$DE,$F4,$24
.byte $38,$0F,$D3,$26,$74,$28,$9C,$E4,$67,$14,$E0,$41,$04,$3C,$F4,$11
.byte $40,$0A,$00,$A0,$1F,$A4,$3A,$6A,$0F,$46,$F4,$1C,$A6,$28,$E3,$29
.byte $6C,$75,$0F,$A4,$DA,$60,$67,$3D,$CC,$6D,$56,$D8,$0F,$D7,$AD,$78
.byte $35,$A4,$E3,$A5,$79,$3C,$71,$4A,$69,$21,$09,$CC,$8E,$27,$8A
.byte $62,$80,$E6,$CA,$08,$9C,$70,$21
.byte $81,$E3,$41,$F4
.byte $6F,$3D
.byte $C1
; indirect data load target (via $80D3)
; Map ID #$19: Shrine NW of Midenhall
.byte $10,$0E,$CD,$69,$14,$47,$38,$02,$87,$57,$DB,$85,$AE,$12,$CB,$28
.byte $59,$65,$05,$96,$50,$B2,$CA,$F3,$F2,$28,$82,$79,$60,$00,$5B,$63
.byte $E1,$75,$60,$02,$D6,$06,$AF,$C4,$6D,$46
.byte $F6,$9D,$97,$87,$25
.byte $9B,$8C,$EF
.byte $46
.byte $13
; indirect data load target (via $80E3)
; Map ID #$1A: Shrine SW of Cannock
.byte $0A,$0A,$C5,$B0,$04,$AD,$80,$93,$FD,$68,$51,$42,$DF,$0B,$00,$40
.byte $1C,$89,$20,$8F,$25,$41,$D1,$3C
.byte $6C,$B2,$3C,$86
.byte $C8,$81
.byte $34
; indirect data load target (via $80EB)
; Map ID #$1C: Shrine SE of Rimuldar
.byte $08,$0C,$C6,$00,$58,$16,$B2,$8D,$78,$2C,$A1,$65,$D0,$78,$6B,$C2
.byte $CB,$E6,$69,$82,$AF,$96,$99,$6A,$A1,$57,$C6,$6F,$49,$F5
.byte $43,$77,$FB,$18,$0C,$38,$62
.byte $96,$45,$F1,$D8
.byte $EF,$F2
.byte $81
; indirect data load target (via $80FB)
; Map ID #$1D: Shrine NW of Beran
.byte $08,$08,$C5,$00,$58,$81,$00,$9C,$D2,$B1,$2C,$4B
.byte $12,$FF,$C7,$F9,$3E,$72
.byte $9C,$A4,$38
.byte $08
.byte $12
; indirect data load target (via $8103)
; Map ID #$1E: Shrine NW of Zahan
.byte $0A,$06,$C3,$00,$3B,$20,$10,$03,$C2,$DC,$22,$8B,$28
.byte $2C,$A2,$9E,$4F,$5F,$67
.byte $6C,$B7,$3E
.byte $F9,$62
.byte $21
; indirect data load target (via $810B)
; Map ID #$1F: Rhone Shrine
.byte $0A,$06,$C1,$00,$18,$04,$01,$03,$C2,$DB,$A2,$8B,$28
.byte $2C,$A2,$9E,$5B,$7B,$98
.byte $9E,$D6,$C6
.byte $B1,$32
.byte $21
; indirect data load target (via $8113)
; Map ID #$20: Shrine SW of Moonbrooke
.byte $08,$08,$C4,$00,$4B,$80,$04,$03,$C2,$D7,$C4,$04,$73,$21,$2C,$12
.byte $C7,$8F,$95,$15,$7C,$B4,$5A,$77,$B9,$E6
.byte $EA,$D3,$C9,$FE,$12
.byte $CC,$21,$C0
.byte $40
.byte $98
; indirect data load target (via $811B)
; Map ID #$21: Rhone Cave Shrine
.byte $08,$06,$C5,$00,$5A,$90,$1B,$F0,$7F,$28,$48,$78,$10,$60,$67,$DF
.byte $79,$6A,$70,$53,$C8,$63,$69,$13,$C8
.byte $33,$C2,$27,$8C,$49
.byte $4A,$15
.byte $E4
.byte $C0
; indirect data load target (via $8123)
; Map ID #$22: Shrine S of Midenhall
.byte $08,$08,$C8,$01,$7B,$E5,$54,$82,$B5,$E4,$F3,$CA,$72,$85
.byte $8B,$CA,$14,$28,$5F,$27,$B8
.byte $43,$A8,$81,$4A
.byte $95,$A4
.byte $CB
; indirect data load target (via $812B)
; Map ID #$23: Rubiss' Shrine B1
.byte $0A,$06,$C2,$00,$58,$08,$14,$50,$AB,$7C,$25,$24,$EC,$07,$E9
.byte $68,$19,$E2,$C1,$27,$C0,$4C
.byte $A5,$03,$61,$06
.byte $BF,$88
.byte $1C
; indirect data load target (via $8133)
; Map ID #$24: Rubiss' Shrine B2
.byte $04,$04,$C4,$01,$65,$68
.byte $86,$03,$3F
.byte $18
.byte $45
; indirect data load target (via $813B)
; Map ID #$25: Rubiss' Shrine B3
.byte $02,$02,$C4,$01
.byte $0C,$19
.byte $E3
.byte $09
; indirect data load target (via $8143)
; Map ID #$26: Rubiss' Shrine B4
.byte $02,$02,$C4,$01
.byte $0C,$19
.byte $E3
.byte $09
; indirect data load target (via $814B)
; Map ID #$27: Rubiss' Shrine B5
.byte $02,$02,$C4,$01
.byte $0C,$19
.byte $E3
.byte $09
; indirect data load target (via $8153)
; Map ID #$28: Rubiss' Shrine B6
.byte $02,$02,$C4,$01
.byte $0C,$19
.byte $E3
.byte $09
; indirect data load target (via $815B)
; Map ID #$29: Rubiss' Shrine B7
.byte $02,$02,$C4,$01
.byte $0C,$19
.byte $E3
.byte $09
; indirect data load target (via $8163)
; Map ID #$2A: Shrine W of Zahan
.byte $06,$06,$C2,$28,$04,$77,$09,$27,$38,$5A
.byte $51,$6F,$E7,$BC,$FE
.byte $A9,$0C
.byte $72
.byte $04
; indirect data load target (via $816B)
; Map ID #$1B: Shrine NW of Lianport
.byte $02,$02,$C5,$01,$0C
.byte $27,$E4,$CA
.byte $53
.byte $26
; indirect data load target (via $80F3)
; Map ID #$18: Charlock Castle B8
.byte $06,$06,$C5,$28,$05,$37,$22,$B3,$C8,$63
.byte $99,$CE,$27,$AA,$4C
.byte $A5,$02
.byte $32
.byte $44
; indirect data load target (via $80DB)
; Map ID #$3F: Cave to Rhone 6F
.byte $14,$14,$C4,$20,$06,$33,$79,$45,$50,$C4,$62,$89,$87,$A9,$5C,$24
.byte $8A,$FD,$2B,$E0,$88,$AC,$D8,$59,$69,$C5,$3C,$A4,$92,$56,$78,$1A
.byte $EF,$2B,$A2,$D9,$CC,$71,$52,$92,$F8,$2B,$1C,$25,$74,$9C,$74,$00
.byte $47,$39,$D5,$97,$93,$69,$3C,$44,$84,$13,$9B,$4B,$A5,$73,$F7,$66
.byte $9D,$F0,$62,$77,$6E,$B2,$1F,$52,$44,$4F,$1D,$4D,$F3,$C2,$D2,$A8
.byte $22,$55,$96,$04,$B0,$4B,$81,$2C,$AB,$E1,$2C,$A3,$19,$2F,$92,$CF
.byte $A1,$65,$1A,$78,$2C,$EA,$CC,$96,$25,$96,$25,$94,$02,$CB,$12,$CB
.byte $12,$CA,$58,$4A,$59,$62,$59,$62,$59,$7F
.byte $26,$63,$FE,$86,$43
.byte $C0,$99,$D7
.byte $46
.byte $48
; indirect data load target (via $8213)
; Map ID #$2C: Lake Cave B1
.byte $14,$18,$48,$E0,$B9,$E0,$D4,$BF,$2C,$6B,$D0,$D7,$C4,$BD,$D7,$01
.byte $AF,$87,$71,$52,$90,$64,$55,$7D,$B3,$5E,$9D,$17,$D0,$CF,$AE,$94
.byte $63,$25,$7D,$74,$DF,$08,$6D,$C9,$5E,$7A,$31,$EA,$C3,$EE,$3E,$C9
.byte $4E,$08,$CB,$80,$DF,$82,$67,$D9,$9F,$5E,$E1,$BE,$13,$3E,$CB,$65
.byte $9A,$A9,$15,$E9,$67,$05,$F3,$42,$7B,$8D,$11,$CB,$7C,$D4,$F7,$46
.byte $11,$10,$F1,$5D,$C0,$21,$CB,$10,$E4,$00,$70,$C8,$39,$F1,$A7,$47
.byte $07,$87,$D4,$8F,$68,$93,$4E,$10,$E2,$58,$B2,$B0,$B5,$9E,$AA,$47
.byte $EE,$28,$F6,$90,$9D,$D7,$51,$B4,$6B,$10,$02,$38,$AC,$F7,$1E,$A8
.byte $1E,$48,$28,$94,$67,$35,$D8,$6B,$D8,$94,$B8,$AF,$8E,$90,$B5,$E4
.byte $73,$DD,$C6,$09,$58,$4B,$08,$21,$AF,$C9,$DA,$53,$48,$9D,$53,$35
.byte $17,$1B,$EC,$30,$0E,$17,$86,$E1,$D0,$ED
.byte $CF,$31,$FB,$73,$48
.byte $65,$9D
.byte $3E
.byte $13
; indirect data load target (via $817B)
; Map ID #$2D: Lake Cave B2
.byte $10,$10,$48,$07,$B3,$E1,$1D,$F7,$A0,$20,$67,$DD,$00,$B4,$86,$78
.byte $82,$2D,$41,$01,$E0,$14,$15,$22,$8A,$08,$37,$E6,$14,$3C,$13,$C5
.byte $1A,$2E,$37,$47,$1E,$2A,$72,$F2,$E5,$CC,$29,$CE,$83,$A5,$24,$1D
.byte $84,$85,$FE,$5B,$C0,$1E,$82,$4C,$78,$32,$BC,$49,$E5,$F9,$F6,$92
.byte $9C,$8C,$D7,$F8,$56,$0A,$44,$24,$F4,$68,$21,$C3,$2B,$F2,$27,$03
.byte $D1,$00,$53,$56,$23,$C1,$4A,$CD,$F7
.byte $F8,$3C,$26,$6D
.byte $9D,$EB
.byte $A0
.byte $3C
; indirect data load target (via $8183)
; Map ID #$2B: Cave to Hamlin
.byte $0E,$10,$48,$E2,$80,$E0,$00,$6B,$40,$08,$78,$F3,$C3,$4B,$AB,$D4
.byte $32,$72,$A8,$9C,$7E,$2F,$82,$D1,$C9,$3A,$21,$51,$B7,$F2,$78,$6D
.byte $FC,$9E,$ED,$91,$4C,$1A,$97,$F1,$9E,$B7,$C3,$5E,$C6,$7E,$FB,$C6
.byte $92,$7A,$3C,$96,$CF,$2F,$1B,$AD,$F2,$D6,$04,$F2,$62,$A4,$39,$D0
.byte $93,$71,$28,$2D,$E9,$C3,$29,$52,$16,$A0,$A0,$05,$B8,$58,$D7,$9A
.byte $75,$C2,$74,$CB,$AD,$F1,$1B,$1D,$F6,$A3
.byte $54,$1E,$3F,$1F,$AB
.byte $E3,$FA,$5F
.byte $22
.byte $03
; indirect data load target (via $8173)
; Map ID #$2E: Sea Cave B1
.byte $06,$16,$48,$E0,$41,$DF,$09,$39,$83,$F0,$A1,$41,$D0,$00,$03,$F8
.byte $0C,$08,$F3,$3C,$F3,$98,$96,$C8
.byte $01,$40,$1A,$03
.byte $08,$DE
.byte $80
.byte $80
; indirect data load target (via $818B)
; Map ID #$2F: Sea Cave B2
.byte $0E,$0E,$48,$07,$AA,$A5,$15,$22,$82,$80,$05,$2C,$94,$1C,$03,$A9
.byte $44,$C1,$40,$3C,$5B,$E2,$A9,$05,$1D,$21,$AB,$9C,$13,$9D,$11,$CF
.byte $20,$A1,$06,$37,$E2,$81,$EF,$F0,$0B,$A3,$E3,$41,$AD,$00,$B1,$2A
.byte $B7,$C1,$09,$D1,$D3,$C9,$A8,$8F,$1E,$19,$C2,$85,$1B,$89,$06,$33
.byte $1A,$00,$5C,$76,$3E,$F0,$A9,$C3,$A1,$14,$B7,$93
.byte $32,$78,$18,$10,$31,$4D
.byte $CF,$91,$DE
.byte $3B,$20
.byte $10
; indirect data load target (via $8193)
; Map ID #$30: Sea Cave B3-1
.byte $12,$14,$48,$07,$AB,$D8,$04,$00,$00,$20,$00,$04,$01,$8A,$90,$5A
.byte $82,$A1,$69,$02,$D2,$11,$6A,$5A,$10,$87,$80,$08,$07,$40,$35,$5F
.byte $15,$31,$C2,$CE,$9E,$67,$4E,$34,$00,$4E,$43,$27,$1A,$F7,$1A,$30
.byte $E3,$16,$21,$AD,$13,$C7,$9C,$3E,$5A,$79,$A7,$B8,$88,$A9,$CA,$51
.byte $4E,$6C,$22,$FE,$6C,$0C,$5E,$02,$F0,$65,$4E,$20,$07,$38,$24,$B2
.byte $F3,$FA,$59,$D3,$39,$5D,$53,$57,$C7,$D0,$78,$EF,$07,$DB,$DB,$1F
.byte $54,$E2,$BC,$27,$8E,$09,$88,$8B,$A3,$B6,$F9,$4E,$14,$D1,$31,$22
.byte $90,$6D,$AB,$17,$49,$96,$5C,$ED,$05,$91,$75,$91,$55,$63,$99,$02
.byte $98,$CE,$BD,$27,$E8,$90,$DE,$35,$06,$BD,$12,$64,$4E,$82,$31
.byte $8B,$F9,$0F,$34,$E7,$6C,$DB
.byte $A1,$75,$BF,$39
.byte $E7,$A0
.byte $20
; indirect data load target (via $819B)
; Map ID #$31: Sea Cave B3-2
.byte $0A,$08,$48,$E0,$9E,$84,$25,$94,$A2,$92,$9E,$49,$F0,$6F,$A0,$4E
.byte $1E,$8F,$C5,$86,$20,$BC,$52,$7C,$12,$A9,$67
.byte $88,$C2,$80,$4E,$49
.byte $E9,$21,$AB
.byte $D0
.byte $81
; indirect data load target (via $81A3)
; Map ID #$37: Cave to Rhone B1
.byte $10,$10,$48,$E2,$BE,$42,$0A,$0E,$08,$84,$05,$00,$54,$78,$6E,$45
.byte $5A,$86,$7B,$DE,$39,$12,$14,$5A,$9B,$F9,$EE,$17,$90,$4F,$C7,$B5
.byte $BF,$33,$E5,$2C,$2B,$20,$9E,$08,$66,$6F,$C0,$14,$00,$55,$25,$95
.byte $B2,$C6,$7B,$E6,$F9,$79,$71,$29,$67,$65,$8C,$F1,$08,$08,$08,$47
.byte $EC,$BA,$B6,$CE,$6C,$A0,$98,$D7,$DC,$43,$8D,$0A,$6F,$0A,$65,$F2
.byte $56,$9F,$E4,$CD,$56,$E9,$17,$A9,$D1,$21,$07
.byte $67,$D2,$41,$79,$EF,$B8
.byte $95,$FF,$A7
.byte $8D
.byte $01
; indirect data load target (via $81D3)
; Map ID #$38: Cave to Rhone 1F
.byte $0A,$0A,$48,$E0,$45,$D8,$27,$27
.byte $43,$9A,$E1,$17
.byte $B0,$52
.byte $6E
; indirect data load target (via $81DB)
; Map ID #$39: Cave to Rhone 2F-1
.byte $0C,$0C,$48,$E0,$A1,$55,$95,$62,$C4,$AB,$22,$59,$5B,$2F,$CB,$2B
.byte $65,$59,$F3,$67,$CA,$95,$BF,$25,$96,$25,$5F,$26,$1F,$9B,$ED,$43
.byte $C5,$B4,$FD,$5F,$7D,$0E,$39,$9E,$E8,$39,$76,$A3
.byte $B3,$84,$C6,$C1,$47,$94
.byte $D8,$3C,$70
.byte $51
.byte $31
; indirect data load target (via $81E3)
; Map ID #$3A: Cave to Rhone 2F-2
.byte $1C,$06,$48,$E2,$95,$50,$00,$00,$04,$78,$27,$04,$67,$E9,$B7,$F2
.byte $7B,$C1,$9F,$A6,$DF,$C9,$EF,$06,$7E,$9B,$7F,$27,$BC,$19,$FA,$6D
.byte $FC,$9E,$F0,$67,$E9,$B7,$F2,$7B,$C3,$C0,$73,$23,$54,$F0,$04,$78
.byte $50,$15,$91,$20,$CB,$C3,$42,$D8,$C8,$88,$34,$15,$15,$6D,$3E
.byte $07,$84,$61,$B8,$96,$2E,$0E,$2B
.byte $6B,$D9,$B6,$1D
.byte $73,$57
.byte $01
; indirect data load target (via $81EB)
; Map ID #$3B: Cave to Rhone 2F-3
.byte $1C,$06,$48,$E2,$95,$50,$00,$00,$04,$78,$27,$04,$67,$E9,$B7,$F2
.byte $7B,$C1,$9F,$A6,$DF,$C9,$EF,$06,$7E,$9B,$7F,$27,$BC,$19,$FA,$6D
.byte $FC,$9E,$F0,$67,$E9,$B6,$AF,$BC,$79,$38,$BC,$A8,$87,$32,$35,$4F
.byte $1C,$07,$85,$01,$59,$12,$0C,$BC,$34,$2D,$8C,$88,$83,$41,$51,$56
.byte $D3,$E2,$F8,$96,$1B,$84,$60,$60,$D5
.byte $F5,$CD,$87,$66
.byte $DA,$F8
.byte $A0
.byte $10
; indirect data load target (via $81F3)
; Map ID #$3C: Cave to Rhone 3F
.byte $0C,$0A,$48,$E0,$90,$0B,$40,$BA,$79,$43,$81,$46,$3F,$4F,$06,$3F
.byte $4F,$3D,$93,$8D,$1A,$9C,$50,$98,$01,$E3,$F5,$72,$F1,$E1,$CF,$E8
.byte $B4,$BE,$12,$65,$88,$70,$A0,$1A,$09,$79,$C0
.byte $8B,$6E,$A3,$43,$2D
.byte $2C,$16,$00
.byte $79
.byte $49
; indirect data load target (via $81FB)
; Map ID #$3D: Cave to Rhone 4F
.byte $14,$1C,$48,$E2,$9F,$3C,$25,$8A,$D1,$67,$CA,$25,$94,$43,$7C,$64
.byte $B2,$A2,$B7,$E5,$94,$78,$E2,$90,$0B,$07,$15,$81,$86,$7D,$8B,$9E
.byte $5C,$F5,$8F,$78,$17,$86,$0B,$53,$75,$85,$34,$4F,$B4,$1C,$11,$E8
.byte $4F,$04,$4E,$86,$F4,$B9,$F6,$6F,$A5,$96,$37,$C5,$CF,$12,$CB,$33
.byte $D6,$C6,$C1,$F1,$65,$8C,$5F,$59,$BE,$96,$5C,$F5,$97,$7E,$6F,$A5
.byte $84,$AE,$20,$A5,$2C,$A8,$B2,$CB,$38,$23,$D7,$87,$7D,$C7,$7E,$94
.byte $5B,$C9,$4C,$96,$B7,$E2,$3D,$6D,$1D,$E5,$AE,$75,$D6,$05,$AA,$4C
.byte $D3,$D9,$1F,$49,$34,$2C,$10,$52,$20,$9E,$4E,$D4,$09,$50,$56,$A9
.byte $CD,$1F,$B5,$19,$C9,$9F,$9A,$94,$3D,$47,$DA,$52,$67,$F6,$CB,$E0
.byte $FE,$41,$97,$42,$B7,$1F,$7E,$C3,$C2,$81,$39,$16,$42,$20,$46,$82
.byte $A1,$49,$D5,$33,$A6,$0A,$2E,$AD,$8E,$01,$97,$46,$28,$4B,$C4,$42
.byte $8A,$43,$C2,$A5,$8B,$FA,$01,$8A,$C8,$BE,$59,$AC,$FB,$E7,$36,$51
.byte $FA,$53,$9F,$99,$C8,$54,$6D,$2B,$16,$65,$EC,$91,$80,$FC,$00,$12
.byte $03,$8B,$8A,$42,$BB,$0D,$58,$D8,$F4,$B7,$47,$D0,$34,$4C,$9B,$B1
.byte $9E,$F0,$4B,$82,$E4,$1E,$5E,$17,$D5,$FC,$17,$C7
.byte $CC,$98,$CD,$FD,$57,$D7
.byte $4D,$C4,$DF
.byte $10
.byte $10
; indirect data load target (via $8203)
; Map ID #$3E: Cave to Rhone 5F
.byte $10,$12,$48,$E0,$42,$2E,$E1,$4F,$FC,$00,$07,$88,$27,$37,$8E,$F5
.byte $DF,$3B,$F4,$3B,$84,$98,$78,$87,$0A,$F0,$89
.byte $89,$7A,$45,$C6,$BE,$23
.byte $64,$5F,$91
.byte $F2
.byte $16
; indirect data load target (via $820B)
; Map ID #$40: Spring of Bravery
.byte $12,$14,$48,$07,$9F,$BA,$85,$37,$C0,$00,$A0,$DF,$0D,$F0,$05,$00
.byte $03,$7C,$A6,$F8,$37,$C3,$7D,$D1,$DD,$04,$E8,$14,$6F,$CD,$F4,$F4
.byte $A2,$6A,$55,$6C,$26,$0B,$1B,$E4,$5B,$B7,$6E,$6C,$BD,$BF,$9C,$F3
.byte $76,$A4,$D0,$78,$A0,$00,$73,$8E,$71,$E6,$B6,$00,$23,$EA,$5D,$01
.byte $A5,$4B,$53,$74,$4F,$DC,$BA,$28,$51,$9E,$0E,$61,$40,$75,$4A,$75
.byte $78,$00,$00,$E0,$D0,$F0,$D1,$5D,$71,$E7,$4D,$73,$FA,$46,$FE,$DE
.byte $1A,$EB,$36,$E5,$CC,$4F,$8E,$F2,$0E,$31,$1E,$34,$CF,$9A,$1F,$70
.byte $F0,$32,$74,$B2,$1C,$8C,$5A,$C8,$14,$10,$59
.byte $12,$62,$57,$8D,$5E,$42
.byte $81,$D0,$31
.byte $60
.byte $0B
; indirect data load target (via $821B)
; Map ID #$43: Cave to Rimuldar
.byte $12,$14,$48,$01,$42,$67,$35,$5A,$C0,$3A,$F3,$9E,$31,$69,$74,$83
.byte $56,$59,$4B,$2C,$A0,$AD,$B3,$C6,$CB,$2F,$81,$B5,$3C,$1B,$E2,$9A
.byte $8B,$2F,$80,$01,$40,$1B,$E0,$0A,$00,$F0,$45,$E9,$E5,$CF,$FB,$C7
.byte $83,$8A,$A0,$80,$59,$CA,$0C,$97,$8C,$EA,$C3,$86,$78,$B2,$A5,$4A
.byte $96,$02,$AF,$3F,$E4,$75,$64,$22,$84,$0B,$17,$FB,$2E,$35,$27,$46
.byte $21,$C2,$CA,$AC,$A8,$01,$78,$82,$46,$B1,$0B,$14,$6D,$24,$F3,$C8
.byte $B4,$23,$B3,$02,$55,$F2,$A5,$65,$0C,$67,$51,$3C,$6B,$76,$2E,$66
.byte $4B,$5F,$66,$B5,$A1,$2C,$68,$89,$E5,$A2
.byte $E0,$90,$9E,$0D,$93
.byte $BB,$7A,$9E
.byte $34
.byte $01
; indirect data load target (via $8233)
; Map ID #$44: Hargon's Castle 2F
.byte $04,$0E,$48,$E0,$45
.byte $C8,$98,$DE
.byte $44
.byte $22
; indirect data load target (via $823B)
; Map ID #$45: Hargon's Castle 3F
.byte $0C,$0A,$48,$07,$80,$20,$02,$00,$40,$02,$00,$E5,$0A,$C2,$58
.byte $96,$12,$F8,$FA,$C4,$DC,$10
.byte $A5,$3B,$41,$51
.byte $14,$6D
.byte $01
; indirect data load target (via $8243)
; Map ID #$46: Hargon's Castle 4F
.byte $0A,$0A,$48,$07,$8D,$C9,$56,$54,$20,$04,$00,$83,$12,$CA,$59,$5E
.byte $08,$1E,$3D,$79,$31,$A4,$31,$29,$1D,$A6,$E2,$8A
.byte $00,$C2,$7A,$E3,$26,$FE
.byte $FF,$42,$19
.byte $CE,$A8
.byte $1A
; indirect data load target (via $824B)
; Map ID #$47: Hargon's Castle 5F
.byte $0A,$0A,$48,$07,$9F,$22,$55,$28,$CF,$1A,$14,$02,$80,$50,$6F,$8A
.byte $7F,$8F,$2A,$4E,$11,$0C,$4A,$D9,$BC
.byte $0D,$62,$AD,$60,$A0
.byte $15,$86
.byte $5C
.byte $0E
; indirect data load target (via $8253)
; Map ID #$48: Hargon's Castle 6F
.byte $0C,$08,$48,$07,$80,$A4,$47,$3D,$48,$8F,$00,$03,$AD,$2F,$80,$70
.byte $10,$8B,$C7,$AE,$26,$38,$87,$0A,$04,$D8,$90,$A7
.byte $C6,$89,$46,$66,$2D,$F2
.byte $B0,$6D,$91
.byte $7B,$5C
.byte $86
; indirect data load target (via $825B)
; Map ID #$49: Moon Tower 1F
.byte $0E,$07,$48,$07,$90,$E9,$4B,$2A,$CA,$59,$D0,$14,$A5,$95,$65,$2C
.byte $F1,$EA,$C9,$B6,$21,$89,$2F,$49,$49
.byte $14,$53,$8F,$51,$F2
.byte $82,$5E
.byte $8F
.byte $02
; indirect data load target (via $8263)
; Map ID #$4A: Moon Tower 2F
.byte $0C,$0C,$48,$07,$81,$30,$A1,$52,$28,$52,$A4,$52,$A4,$52,$95,$22
.byte $8D,$78,$A7,$8A,$07,$85,$9C,$A1,$13,$99,$73,$92,$C1,$C5,$20,$F2
.byte $62,$18,$B6,$ED,$BF,$6F,$45,$E0,$71,$40,$A8,$29,$C1,$39,$10,$72
.byte $F4,$E1,$7C,$AB,$44,$78,$D6,$48,$B1,$29,$10,$E1
.byte $4C,$0F,$D0,$02,$90,$65
.byte $1A,$26,$AF
.byte $B3,$00
.byte $A2
; indirect data load target (via $826B)
; Map ID #$4B: Moon Tower 3F
.byte $0C,$0C,$48,$07,$89,$A5,$A2,$94,$0A,$48,$52,$8A,$91,$55,$22,$95
.byte $BE,$0A,$91,$4A,$A9,$14,$57,$8A,$29,$D5,$CB,$12,$F3,$3A,$BC,$88
.byte $17,$C9,$8B,$68,$79,$F8,$F0,$EC,$8B,$82,$D6,$77,$90,$E9,$C1,$38
.byte $50,$92,$F1,$20,$85,$87,$4E,$23,$CC,$B2,$C5,$95,$60,$88
.byte $22,$60,$B0,$34,$00,$9C,$19
.byte $56,$99,$B3
.byte $6A,$00
.byte $37
; indirect data load target (via $8273)
; Map ID #$4C: Moon Tower 4F
.byte $0A,$0A,$48,$E2,$A1,$82,$8A,$57,$82,$C4,$28,$20,$DA,$3E,$1A,$7A
.byte $45,$73,$00,$F1,$E4,$B1,$9B,$62,$6B,$77,$45,$C5,$94,$E1,$40,$17
.byte $12,$1E,$29,$10,$89,$0A,$9E,$BA
.byte $CA,$C7,$C1,$06
.byte $AF,$46
.byte $03
; indirect data load target (via $827B)
; Map ID #$4D: Moon Tower 5F
.byte $08,$08,$48,$E2,$98,$45,$3C,$15,$AA,$75,$5A,$0D,$FC,$09,$1E,$F2
.byte $D8,$AF,$1F,$AE,$91,$33,$BB,$88,$63,$58
.byte $EC,$50,$DF,$26,$4F
.byte $C3,$67
.byte $2C
.byte $09
; indirect data load target (via $8283)
; Map ID #$4E: Moon Tower 6F
.byte $06,$06,$48,$E2,$92,$45,$3C,$D3,$5A,$78,$28,$44,$B9,$E5,$33
.byte $F7,$DE,$3D,$9C,$E2,$68,$10,$A5
.byte $4A,$34,$34,$46
.byte $4E,$98
.byte $26
; indirect data load target (via $828B)
; Map ID #$4F: Moon Tower 7F
.byte $06,$04,$48,$07,$8B,$AA
.byte $13,$C9,$A4
.byte $7A,$C6
.byte $44
; indirect data load target (via $8293)
; Map ID #$50: Lighthouse 1F
.byte $04,$04,$48,$07,$56
.byte $87,$D1,$74
.byte $29
.byte $3A
; indirect data load target (via $829B)
; Map ID #$51: Lighthouse 2F
.byte $16,$16,$48,$E0,$90,$40,$5C,$F3,$58,$0F,$B0,$6A,$1E,$F0,$00,$0A
.byte $6B,$03,$EC,$18,$DF,$8A,$3D,$BE,$F0,$1A,$81,$E0,$0A,$6B,$7E,$03
.byte $5A,$37,$D0,$3E,$1E,$78,$00,$05,$01,$58,$FA,$31,$80,$35,$2E,$2B
.byte $D6,$12,$AA,$E1,$2A,$AE,$12,$AA,$E1,$9F,$BF,$EF,$7B,$C5,$F7,$90
.byte $79,$39,$5E,$BD,$D7,$1C,$98,$B9,$E0,$A7,$0A,$8A,$73,$11
.byte $7C,$55,$06,$BF,$6B,$22,$51
.byte $EE,$B0,$69
.byte $1D,$7E
.byte $03
; indirect data load target (via $82A3)
; Map ID #$52: Lighthouse 3F
.byte $12,$12,$48,$E2,$94,$70,$0A,$0E,$96,$A2,$B8,$1D,$00,$21,$00,$38
.byte $0B,$0F,$05,$1D,$16,$94,$BC,$CF,$12,$02,$44,$4E,$9C,$60,$40,$63
.byte $05,$33,$DF,$61,$2F,$B9,$A6,$8B,$48,$31,$2D,$5F,$0C,$2D,$F2,$D6
.byte $2C,$8C,$FA,$68,$24,$5B,$86,$7D,$F7,$86,$7A,$D3,$C3,$0B,$7D,$E3
.byte $CE,$D9,$CB,$5D,$6B,$E2,$60,$3C,$45,$9A,$B4,$E7,$02,$E5,$7C,$7C
.byte $BC,$2C,$A7,$0A,$F2,$9F,$20,$E2,$38,$92,$B2,$85,$53,$37,$D0,$28
.byte $F4,$8B,$AE,$4F,$BE,$C6,$AB,$9D,$29,$2D,$2E,$55,$46,$ED,$5E,$F3
.byte $04,$10,$53,$32,$62,$4D,$A4,$84,$96,$EE,$3A,$AA,$71,$83
.byte $0B,$E2,$FC,$65,$9E,$B3,$BE
.byte $AF,$E5,$DC,$97
.byte $63,$80
.byte $AF
; indirect data load target (via $82AB)
; Map ID #$53: Lighthouse 4F
.byte $10,$10,$48,$E2,$88,$13,$B4,$12,$C6,$A3,$CE,$E7,$40,$51,$CD,$F8
.byte $20,$3C,$08,$DA,$EA,$28,$8D,$08,$C0,$2D,$ED,$34,$90,$43,$7E,$0A
.byte $0E,$4A,$D4,$96,$BB,$20,$49,$A4,$B5,$7D,$DF,$08,$0A,$73,$F4,$90
.byte $8A,$E1,$F1,$78,$33,$58,$FC,$B8,$78,$7E,$03,$A7,$6F,$5D,$FF,$AB
.byte $EC,$13,$F9,$F0,$3B,$DC,$94,$DB,$29,$8E,$17,$03,$D9,$08,$2A,$12
.byte $CF,$36,$9C,$2D,$0D,$6C,$9F,$4C,$14,$88,$B0,$49,$B5,$7D,$C5,$69
.byte $FA,$8E,$B2,$53,$19,$03,$57,$06,$35,$A5
.byte $66,$3B,$6F,$4B,$60
.byte $CF,$F0
.byte $00
.byte $53
; indirect data load target (via $82B3)
; Map ID #$54: Lighthouse 5F
.byte $0E,$0E,$48,$E2,$B0,$04,$B2,$93,$A0,$71,$04,$95,$66,$96,$55,$9E
.byte $63,$E8,$78,$20,$04,$25,$C0,$D5,$91,$3E,$58,$A4,$AB,$61,$2D,$5F
.byte $25,$E0,$B8,$BB,$F0,$95,$BE,$22,$EF,$B9,$C0,$38,$E5,$2D,$74,$CC
.byte $24,$F2,$61,$D8,$B6,$3D,$B0,$71,$7D,$48,$F4,$8D,$8F,$96,$F0,$4B
.byte $D0,$14,$E7,$5F,$AE,$42,$87,$AB,$A3,$89,$48,$51,$B8,$94,$27,$D1
.byte $A0,$C6,$64,$4F,$9E,$4C,$C1,$5E,$95,$86
.byte $C0,$AC,$C1,$23,$C1
.byte $C0,$6B,$58
.byte $A0
.byte $0B
; indirect data load target (via $82BB)
; Map ID #$55: Lighthouse 6F
.byte $0E,$0E,$48,$E2,$83,$21,$CC,$3A,$89,$4E,$BB,$0A,$D8,$7C,$29,$09
.byte $2A,$C2,$1C,$2D,$96,$12,$AC,$F0,$25,$67,$70,$70,$82,$5B,$10,$96
.byte $F2,$A4,$A3,$64,$F8,$62,$5A,$BE,$68,$7A,$0E,$A6,$54,$E8,$9D,$29
.byte $6F,$28,$E8,$24,$E2,$91,$E3,$C3,$70,$0C,$7B,$6F,$DE,$F9,$B2,$69
.byte $1A,$6E,$A5,$DA,$76,$45,$E1,$71,$92,$9C,$CC,$FE,$09,$D7,$0A,$B2
.byte $AD,$13,$04,$50,$58,$46,$84,$9B,$05,$0F,$57,$47
.byte $12,$84,$90,$A7,$22,$8B
.byte $80,$C5,$7A
.byte $DE,$3C
.byte $06
; indirect data load target (via $82C3)
; Map ID #$56: Lighthouse 7F
.byte $0A,$0E,$48,$04,$85,$B2,$73,$C0,$8F,$3C,$7F,$92,$C2,$58,$96,$13
.byte $8B,$91,$45,$2B,$96,$14,$10,$04,$B0,$84,$2D,$22,$A1,$3C,$7C,$5E
.byte $ED,$A7,$66,$98,$91,$B2,$43,$1C,$48,$31,$89,$14,$28,$15
.byte $51,$F4,$6A,$83,$8C,$F2,$9E
.byte $14,$2C,$FD
.byte $14,$36
.byte $09
; indirect data load target (via $82CB)
; Map ID #$57: Lighthouse 8F
.byte $0A,$0A,$48,$07,$98,$4B,$09,$62,$5E,$5D,$26,$F9,$62,$58,$4B,$12
.byte $C7,$E4,$30,$F9,$D1,$E2,$B2,$DD,$1E,$D1,$36,$84
.byte $30,$A2,$DF,$A5,$1B,$12
.byte $DE,$CA,$BB
.byte $11
.byte $13
; indirect data load target (via $82D3)
; Map ID #$58: Wind Tower 1F
.byte $08,$08,$48,$07,$91,$56,$25,$EB,$75,$89,$7F,$03
.byte $1B,$5F,$FF,$E0,$7D,$63
.byte $29,$4A,$D1
.byte $46,$D2
.byte $5D
; indirect data load target (via $82DB)
; Map ID #$59: Wind Tower 2F
.byte $0C,$0C,$48,$07,$84,$84,$10,$C3,$7D,$EE,$66,$13,$7C,$6F,$C2,$58
.byte $97,$9C,$24,$B0,$81,$84,$BE,$04,$10,$9B
.byte $EF,$26,$17,$9B,$6F
.byte $45,$E0
.byte $0A
.byte $4E
; indirect data load target (via $82E3)
; Map ID #$5A: Wind Tower 3F
.byte $0C,$0C,$48,$07,$95,$E5,$85,$34,$DF,$9E,$14,$DF,$02,$CA,$69,$9E
.byte $57,$80,$A6,$99,$EA,$F1,$BE,$14,$F2,$60,$18
.byte $DE,$B0,$3D,$BF,$42
.byte $C2,$CB,$8C
.byte $94
.byte $9B
; indirect data load target (via $82EB)
; Map ID #$5B: Wind Tower 4F
.byte $0C,$0C,$48,$07,$88,$E0,$04,$30,$DF,$4F,$0C,$25,$A3,$7E,$02,$58
.byte $60,$9B,$E7,$84,$13,$7D,$E2,$79,$38,$4C
.byte $9B,$43,$1E,$B3,$88
.byte $60,$05,$D8
.byte $CA
.byte $44
; indirect data load target (via $82F3)
; Map ID #$5C: Wind Tower 5F
.byte $0A,$0A,$48,$07,$97,$E9,$BE,$28,$29,$AD,$7B,$C2,$CA,$B8,$6F
.byte $CA,$B2,$81,$5E,$79,$38,$1D,$5E
.byte $CE,$2C,$79,$5D
.byte $6F,$40
.byte $64
; indirect data load target (via $82FB)
; Map ID #$5D: Wind Tower 6F
.byte $0A,$0A,$48,$07,$8D,$4A,$52,$83,$7C,$52,$E7,$90,$8A,$A2
.byte $5D,$17,$CA,$1E,$3D,$56,$B3
.byte $BD,$E3,$26,$C7
.byte $46,$42
.byte $6F
; indirect data load target (via $8303)
; Map ID #$5E: Wind Tower 7F
.byte $0A,$0A,$48,$E0,$81,$C4,$CF,$5C,$F1,$9E,$B2,$E7,$8C,$F5,$DF,$97
.byte $3C,$67,$AC,$B9,$E7,$2C,$97,$FC,$78,$9C,$07,$68
.byte $9B,$EE,$06,$AF,$47,$B8
.byte $1E,$B7,$4A
.byte $32
.byte $28
; indirect data load target (via $830B)
; Map ID #$5F: Wind Tower 8F
.byte $06,$06,$48,$E0,$98,$9D,$12,$E2,$C7
.byte $8F,$03,$37,$6B,$5B
.byte $24,$98
.byte $24
.byte $27
; indirect data load target (via $8313)
; Map ID #$60: Dragon Horn South 1F
.byte $06,$06,$48,$07,$82,$5C,$8C,$E8,$77,$24
.byte $3F,$1F,$2B,$73,$64
.byte $79,$C5,$DB
.byte $29
.byte $09
; indirect data load target (via $831B)
; Map ID #$61: Dragon Horn South 2F
.byte $08,$08,$48,$02,$F8,$C0,$C7,$FF,$3D,$DE,$4B,$02
.byte $58,$12,$C0,$96,$7F,$6E
.byte $AE,$97,$51
.byte $3D,$48
.byte $4C
; indirect data load target (via $8323)
; Map ID #$62: Dragon Horn South 3F
.byte $08,$08,$48,$E1,$52,$B4,$15,$AA,$96,$52,$CA
.byte $59,$E2,$F8,$C0,$C7,$FF
.byte $27,$A8,$FC
.byte $C6
.byte $4D
; indirect data load target (via $832B)
; Map ID #$63: Dragon Horn South 4F
.byte $08,$08,$48,$E1,$52,$B4,$15,$AA,$96,$52,$CA
.byte $59,$E2,$F8,$FF,$C7,$C0
.byte $1F,$99,$3D
.byte $48
.byte $4D
; indirect data load target (via $8333)
; Map ID #$64: Dragon Horn South 5F
.byte $08,$08,$48,$E1,$52,$B4,$15,$AA,$96,$52,$CA
.byte $59,$E3,$F3,$27,$A8,$BF
.byte $F1,$F0,$3E
.byte $04
.byte $4D
; indirect data load target (via $833B)
; Map ID #$65: Dragon Horn South 6F
.byte $08,$08,$48,$E1,$52,$B4,$15,$AA,$96,$52,$CA
.byte $59,$E2,$F8,$FF,$C7,$C0
.byte $1F,$99,$3D
.byte $48
.byte $4D
; indirect data load target (via $8343)
; Map ID #$66: Dragon Horn North 1F
.byte $06,$06,$48,$07,$8C,$8B,$29,$65,$2C
.byte $AF,$16,$2F,$1E
.byte $F0,$F5
.byte $46
.byte $40
; indirect data load target (via $834B)
; Map ID #$67: Dragon Horn North 2F
.byte $08,$08,$48,$02,$81,$D4,$0A,$05,$02,$F9,$E1,$14
.byte $B2,$C2,$59,$61,$2C,$B0
.byte $96,$5F,$27
.byte $59
.byte $08
; indirect data load target (via $8353)
; Map ID #$68: Dragon Horn North 3F
.byte $08,$08,$48,$40,$49,$D8,$F7,$B8,$96,$58,$4B
.byte $2C,$25,$96,$12,$CF
.byte $26,$E0,$F8
.byte $C6
.byte $4D
; indirect data load target (via $835B)
; Map ID #$69: Dragon Horn North 4F
.byte $08,$08,$48,$40,$49,$D8,$F7,$B8,$96,$58,$4B
.byte $2C,$25,$96,$12,$CF
.byte $26,$E0,$F8
.byte $C6
.byte $4D
; indirect data load target (via $8363)
; Map ID #$6A: Dragon Horn North 5F
.byte $08,$08,$48,$40,$49,$D8,$F7,$B8,$96,$58,$4B
.byte $2C,$25,$96,$12,$CF
.byte $1F,$19,$37
.byte $08
.byte $4D
; indirect data load target (via $836B)
; Map ID #$6B: Dragon Horn North 6F
.byte $08,$08,$48,$40,$49,$D8,$F7,$B8,$96,$58,$4B
.byte $2C,$25,$96,$12,$CF
.byte $1F,$19,$37
.byte $08
.byte $4D
; indirect data load target (via $8373)
; Map ID #$6C: Dragon Horn North 7F
.byte $08,$08,$48,$40,$49,$D8,$F7,$B8,$96,$58,$4B
.byte $2C,$25,$96,$12,$CF
.byte $1F,$19,$37
.byte $08
.byte $4D
; indirect data load target (via $837B)
; Map ID #$6D: Moonbrooke (prologue)
.byte $08,$08,$48,$02,$8F,$14,$0A,$05,$EF,$95,$F3,$D7,$EB
.byte $2F,$77,$A5,$96,$12,$CB
.byte $09,$65,$9E
.byte $3D,$A1
.byte $90
; indirect data load target (via $86D7)
; Save Point ID #$00: Midenhall 2F
.byte $14,$14,$C2,$00,$2A,$F8,$00,$00,$0E,$95,$C0,$EC,$42,$5D,$F0,$FC
.byte $18,$52,$24,$42,$78,$6A,$42,$05,$53,$C2,$51,$F5,$49,$7C,$2D,$8E
.byte $00,$94,$D0,$78,$01,$41,$40,$82,$05,$50,$81,$A2,$50,$14,$68,$9A
.byte $78,$CF,$2A,$C1,$46,$F9,$44,$A9,$E1,$BE,$59,$65,$11,$01,$E8,$60
.byte $BE,$10,$67,$81,$2F,$F5,$B0,$75,$DC,$1D,$3E,$87,$32,$43,$CD,$47
.byte $D1,$E3,$A1,$BA,$78,$FC,$9B,$92,$CB,$69,$BD,$3A
.byte $67,$0A,$F6,$91,$9C,$88
.byte $4E,$F8,$31
.byte $96,$4C
.byte $10
; external indirect data load target (via $06:$BFA9)
; indirect data load target
; Save Point ID #$01: Cannock
.byte $81,$D6
.byte $3C
; external indirect data load target (via $06:$BFAB)
; Save Point ID #$02: Tantegel
.byte $81,$A0
.byte $11
; external indirect data load target (via $06:$BFAD)
; Save Point ID #$03: Osterfair
.byte $81,$3A
.byte $2E
; external indirect data load target (via $06:$BFAF)
; Save Point ID #$04: Beran
.byte $81,$D6
.byte $8E
; external indirect data load target (via $06:$BFB1)
; Save Point ID #$05: Rhone Shrine
.byte $81,$23
.byte $C0
; external indirect data load target (via $06:$BFB3)
; Save Point ID #$06: Hamlin
.byte $81,$8A
.byte $9B
; external indirect data load target (via $06:$BFB5)
; warp points (map ID, X-pos, Y-pos); other end is same index in $03:$BD13
.byte $81,$7D
.byte $56
; external indirect data load target (via $0F:$D7EA)
; indirect data load target
; external indirect data load target (via $06:$BF9D)
.byte $81,$D6,$3B,$81,$A8,$32,$81,$A0,$10,$81,$7D,$55,$81,$62,$6F,$81
.byte $1D,$37,$81,$3A,$2D,$81,$D6,$8D,$81,$F0
.byte $E9,$81,$46,$85,$81
.byte $94,$D1,$81
.byte $23
.byte $C1
; external indirect data load target (via $06:$BF8F)
.byte $81,$5F,$A5
.byte $81,$E6
.byte $15
; external indirect data load target (via $06:$BF91)
.byte $81,$8E,$18,$81,$05,$2B,$81,$4D,$4F,$81,$19,$9D,$81,$D0,$D8,$81
.byte $8A,$9A,$81,$4A,$78,$81,$4C,$78,$81,$83,$C7,$81
.byte $E2,$67,$81,$C8,$73,$81
.byte $EC,$EB,$81
.byte $89
.byte $1C
; external indirect data load target (via $06:$BF93)
.byte $81,$5D
.byte $0C
; external indirect data load target (via $06:$BFA3)
.byte $81,$B5
.byte $A7
; external indirect data load target (via $06:$BF95)
.byte $81,$8B
.byte $7B
; external indirect data load target (via $06:$BFA1)
.byte $81,$3C
.byte $33
; external indirect data load target (via $06:$BF97)
.byte $81,$3F
.byte $67
; external indirect data load target (via $06:$BF9F)
.byte $81,$73
.byte $C5
; external indirect data load target (via $06:$BFA5)
.byte $81,$47
.byte $91
; external indirect data load target (via $06:$BFA7)
.byte $81,$0C
.byte $47
; external indirect data load target (via $06:$BF9B)
.byte $81,$0D
.byte $43
; external indirect data load target (via $06:$BF99)
.byte $81,$4F
.byte $2D
; pointers to per-map NPC setup (X-pos, Y-pos, ???, sprite ID, dialogue [not string] ID)
.byte $81,$DE,$08,$81,$5F,$A5,$81,$8E,$1D,$81,$6D,$B9,$81,$4F,$30,$01
.byte $D5,$3B,$01,$A7,$32,$01,$9F,$10,$01,$7C,$55,$01,$61,$6F,$01,$1C
.byte $37,$01,$39,$2D,$01,$D5,$8D,$01,$EF,$E9,$01,$45,$85,$01,$93,$D1
.byte $01,$22,$C1,$01,$5E,$A5,$01,$3B,$33,$02,$03,$07,$03,$15,$02,$07
.byte $07,$05,$07,$0B,$05,$09,$0A,$0E,$0D,$06,$04,$0E,$05,$05,$11,$01
.byte $03,$13,$07,$04,$44,$04,$0F,$1A,$05,$07,$23,$03,$03,$24,$01,$01
.byte $25,$01,$01,$26,$01,$01,$27,$01,$01,$28,$01,$01,$AA,$01,$01,$83
.byte $07,$0C,$A2,$02,$03,$8F,$02,$15,$9D,$03,$02,$9A,$05,$0A,$9E,$06
.byte $02,$9C,$07,$04,$9E,$02,$02,$9B,$03,$03,$9E,$04,$02,$9D,$05,$02
.byte $9D,$07,$02,$A0,$00,$01,$95,$0C,$02,$A1,$04,$03,$A1,$04,$03,$2C
.byte $02,$09,$2E,$04,$05,$2F,$0E,$13,$2F,$02,$03,$2F,$04,$07,$2F,$02
.byte $17,$2F,$0C,$19,$2F,$16,$1D,$2F,$1E,$1F,$2F,$1E,$23,$2F,$0E,$05
.byte $31,$1C,$03,$31,$16,$0B,$31,$18,$19,$31,$0E,$03,$31,$06,$03,$31
.byte $0C,$09,$31,$0E,$0B,$31,$10,$0D,$31,$08,$09,$31,$0A,$0B,$31,$0C
.byte $0D,$31,$0E,$0F,$31,$08,$0D,$31,$0A,$0F,$31,$0A,$1D,$32,$0A,$03
.byte $32,$02,$0F,$32,$02,$21,$4A,$14,$05,$4A,$14,$15,$4A,$0A,$0F,$4A
.byte $02,$15,$4A,$04,$03,$4B,$08,$0B,$4B,$04,$03,$4B,$10,$03,$4C,$04
.byte $05,$4C,$0A,$0D,$4D,$04,$05,$4D,$02,$09,$4E,$0A,$03,$4F,$04,$05
.byte $34,$08,$19,$34,$0C,$07,$34,$04,$03,$34,$02,$05,$34,$16,$19,$35
.byte $02,$09,$35,$0E,$03,$35,$0A,$0B,$35,$02,$19,$35,$14,$1D,$36,$02
.byte $03,$36,$0A,$07,$36,$10,$03,$51,$0C,$0D,$51,$14,$0D,$51,$14,$15
.byte $51,$0C,$15,$52,$1E,$01,$52,$1C,$09,$52,$1E,$17,$52,$14,$0F,$52
.byte $10,$1B,$52,$0A,$1B,$52,$02,$01,$53,$14,$15,$53,$16,$1B,$53,$02
.byte $0F,$53,$04,$0B,$54,$1A,$01,$54,$1A,$0F,$54,$16,$11,$54,$00,$01
.byte $54,$04,$05,$54,$02,$17,$55,$10,$17,$55,$12,$1B,$55,$04,$0B,$55
.byte $10,$03,$55,$10,$0F,$56,$00,$03,$56,$04,$05,$56,$02,$11,$56,$00
.byte $13,$57,$06,$0B,$38,$06,$0F,$38,$14,$03,$38,$0A,$15,$38,$0E,$0D
.byte $3B,$06,$03,$3B,$06,$0D,$3B,$14,$11,$3C,$0E,$21,$3C,$02,$2B,$3D
.byte $02,$21,$3D,$0A,$21,$3D,$12,$21,$3D,$1A,$21,$3E,$0E,$1D,$3E,$20
.byte $0D,$3E,$12,$0F,$3E,$12,$19,$3E,$20,$05,$3F,$12,$15,$59,$06,$13
.byte $59,$0C,$0B,$59,$16,$01,$5A,$00,$01,$5A,$08,$03,$5A,$0A,$0F,$5B
.byte $02,$05,$5B,$0A,$09,$5B,$00,$11,$5C,$04,$09,$5C,$08,$09,$5C,$08
.byte $13,$5C,$12,$13,$5D,$0A,$09,$5D,$0E,$07,$5E,$02,$05,$5E,$06,$03
.byte $5E,$00,$01,$5E,$04,$09,$5E,$08,$07,$5F,$04,$05,$61,$06,$0D,$62
.byte $06,$0D,$63,$06,$0D,$64,$06,$0D,$65,$06,$07,$67,$06,$09,$68,$06
.byte $09,$69,$06,$09,$6A,$06,$09,$6B,$06,$09,$6C,$04,$07,$45
.byte $0E,$09,$46,$02,$05,$47,$14
.byte $07,$48,$02,$07
.byte $17,$0D
.byte $0B
; index corresponds to map ID
; indexed data load target (from $B1D6)
; external indexed data load target (from $0F:$E527)
; indexed data load target (from $B1DB)
.byte $30
; external indexed data load target (from $0F:$E52C)
; Map ID #$02: Midenhall 2F
.byte $A6,$00,$00,$1B,$A6,$30,$A6,$77,$A6,$87,$A6,$CE,$A6,$1F,$A7,$6B
.byte $A7,$76,$A7,$86,$A7,$8C,$A7,$E2,$A7,$29,$A8,$2F,$A8,$35,$A8,$81
.byte $A8,$D2,$A8,$00,$00,$19,$A9,$29,$A9,$7A,$A9,$D5,$A9,$F9,$A9,$09
.byte $AA,$0F,$AA,$15,$AA,$25,$AA,$2B,$AA,$31,$AA,$37,$AA,$3D,$AA,$48
.byte $AA,$4E,$AA,$59,$AA,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$D5,$AA,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$A7,$AA,$00
.byte $00,$00,$00,$00,$00,$B2,$AA,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$64
.byte $AA,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$A1,$AA,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$86,$AA,$CF,$AA,$C9,$AA,$C3,$AA,$BD,$AA,$7B,$AA,$9B,$AA,$00
.byte $00,$6F,$AA,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$75
.byte $AA,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $EA,$AA,$4F,$AB
.byte $69,$AB
.byte $83
.byte $AB
; indirect data load target (via $A53D)
; indirect data load target
.byte $07,$05,$12,$0B,$9F,$03,$03,$02,$03,$9D
.byte $04,$07,$02,$0A,$9E
.byte $03,$07,$00
.byte $FF
.byte $00
; Map IDs #$00/#$03: Fake Midenhall/Midenhall 1F
.byte $FF
; indirect data load target (via $A539, $A53F)
; indirect data load target
.byte $0E,$09,$12,$07,$8E,$16,$0E,$13,$0A,$8F,$03,$06,$12,$07,$2A,$0C
.byte $16,$10,$09,$30,$0A,$06,$13,$06,$2C,$0D,$04,$12,$0A,$2F,$05,$13
.byte $12,$0C,$8D,$11,$0A,$13,$0C,$2D,$02,$02,$01,$05,$29,$05,$0B,$02
.byte $0B,$2B,$0A,$14,$01,$06,$1C,$0D,$0F,$01,$0A
.byte $2E,$15,$13,$03,$06,$0A
.byte $10,$02,$03
.byte $03
.byte $D7
; Map ID #$04: Midenhall B1
.byte $FF
; indirect data load target (via $A541)
; indirect data load target
.byte $00,$03,$10,$08,$A0,$05,$01,$02
.byte $0A,$31,$01,$08
.byte $00,$05
.byte $D9
; Map ID #$05: Leftwyne
.byte $FF
; indirect data load target (via $A543)
; indirect data load target
.byte $05,$03,$12,$06,$14,$05,$0F,$10,$09,$38,$04,$06,$11,$0A,$95,$0C
.byte $13,$13,$0A,$35,$0F,$05,$10,$0C,$36,$09,$0C,$13,$07,$32,$03,$0A
.byte $12,$0B,$34,$13,$0A,$10,$0C,$33,$09,$04,$01,$06,$28,$13,$04,$02
.byte $05,$27,$04,$13,$01,$06,$1D,$13,$0F,$03,$06
.byte $0B,$16,$16,$01,$08,$37
.byte $12,$12,$02
.byte $01
.byte $01
; Map ID #$06: Cannock
.byte $FF
; indirect data load target (via $A545)
; indirect data load target
.byte $02,$06,$11,$0A,$39,$16,$02,$13,$07,$A2,$06,$0F,$12,$0B,$40,$13
.byte $13,$11,$08,$3D,$09,$14,$11,$07,$3F,$14,$16,$12,$0C,$3E,$03,$04
.byte $02,$03,$A1,$11,$01,$02,$0A,$93,$07,$05,$00,$0A,$3A,$0B,$09,$02
.byte $0B,$A3,$16,$07,$02,$05,$27,$14,$09,$00,$04,$00,$17,$09,$00,$04
.byte $00,$01,$0F,$01,$06,$0C,$18,$0F
.byte $03,$0A,$3C,$02
.byte $17,$01
.byte $06
.byte $1E
; Map ID #$07: Hamlin
.byte $FF
; indirect data load target (via $A547)
; indirect data load target
.byte $0C,$02,$11,$09,$02,$08,$0F,$11,$07,$91,$0C,$0B,$10,$0C,$42,$0C
.byte $15,$11,$08,$44,$15,$08,$13,$0C,$96,$12,$13,$11,$0A,$43,$00,$00
.byte $02,$0A,$94,$05,$04,$02,$0B,$41,$05,$05,$00,$04,$00,$13,$03,$02
.byte $05,$27,$12,$0A,$03,$06,$28,$03,$11,$01,$06,$0D,$15,$0F
.byte $02,$06,$15,$16,$15,$03,$06
.byte $1F,$0F,$01
.byte $02,$0B
.byte $05
; Map ID #$08: Hamlin Waterway
.byte $FF
; indirect data load target (via $A549)
; indirect data load target
.byte $03,$01,$13,$05,$A5
.byte $05,$01,$02
.byte $05
.byte $A5
; Map ID #$09: Moonbrooke
.byte $FF
; indirect data load target (via $A54B)
; indirect data load target
.byte $03,$06,$11,$04,$45,$11,$05,$10
.byte $04,$A6,$08,$12
.byte $10,$04
.byte $46
; Map ID #$0A: Moonbrooke B1
.byte $FF
; indirect data load target (via $A54D)
; indirect data load target
.byte $00,$06,$00
.byte $0A
.byte $A7
; Map ID #$0B: Lianport
.byte $FF
; indirect data load target (via $A54F)
; indirect data load target
.byte $0C,$05,$13,$0C,$48,$0B,$15,$10,$0A,$4B,$0E,$0D,$10,$08,$AB,$01
.byte $15,$10,$07,$AC,$09,$0C,$10,$0C,$4A,$10,$13,$13,$07,$4C,$04,$04
.byte $03,$05,$00,$03,$05,$00,$05,$00,$03,$04,$02,$07,$AA,$10,$07,$02
.byte $0B,$A8,$08,$03,$02,$06,$16,$05,$0B,$01,$06,$20,$12,$0D,$03,$06
.byte $28,$17,$0E,$02,$06,$A9,$05,$12,$02,$0B,$27
.byte $18,$14,$03,$06,$0E
.byte $13,$05,$00
.byte $0D
.byte $00
; Map ID #$0C: Tantegel
.byte $FF
; indirect data load target (via $A551)
; indirect data load target
.byte $16,$02,$10,$0A,$4E,$17,$0A,$13,$0C,$4F,$08,$0A,$10,$0C,$4D,$12
.byte $0E,$12,$06,$98,$13,$09,$11,$07,$51,$04,$04,$02,$06,$17,$0C,$02
.byte $03,$07,$97,$0C,$07,$02,$0B,$AD,$1B,$06,$02,$05,$AF,$03,$0D,$01
.byte $06,$0F,$0B,$10,$00,$06,$21,$17,$10,$03,$0A
.byte $50,$1C,$0F,$03,$0B,$AE
.byte $1C,$0A,$03
.byte $05
.byte $27
; Map ID #$0D: Tantegel Town 2F
.byte $FF
; indirect data load target (via $A553)
; indirect data load target
.byte $02,$02,$02
.byte $03
.byte $52
; Map ID #$0E: Tantegel Castle 2F
.byte $FF
; indirect data load target (via $A555)
; indirect data load target
.byte $02,$05,$11
.byte $0A
.byte $53
; Map ID #$0F: Osterfair
.byte $FF
; indirect data load target (via $A557)
; indirect data load target
.byte $07,$04,$02,$0A,$58,$12,$10,$13,$0C,$59,$03,$0E,$11,$06,$10,$09
.byte $14,$12,$08,$5A,$08,$10,$11,$0C,$5C,$08,$09,$01,$09,$B3,$0C,$05
.byte $02,$04,$00,$0D,$06,$02,$07,$55,$0E,$05,$02,$03,$B0,$0F,$06,$02
.byte $07,$56,$10,$05,$02,$04,$00,$04,$08,$02,$0B,$B1,$13,$0A
.byte $01,$08,$57,$06,$15,$01,$06
.byte $18,$11,$12
.byte $03,$05
.byte $54
; Map ID #$10: Zahan
.byte $FF
; indirect data load target (via $A559)
; indirect data load target
.byte $08,$08,$11,$0B,$67,$10,$0C,$13,$05,$65,$0A,$0D,$10,$07,$64,$04
.byte $12,$10,$07,$62,$13,$12,$12,$07,$63,$12,$08,$03,$09,$B4,$00,$00
.byte $02,$08,$5D,$09,$02,$02,$04,$00,$0F,$02,$02,$04,$00,$03,$08,$01
.byte $07,$11,$0C,$09,$02,$07,$5E,$05,$0C,$03,$06,$66,$15,$0A,$03,$07
.byte $22,$0E,$10,$00,$07,$5F,$0B,$12
.byte $01,$07,$60,$0D
.byte $13,$03
.byte $05
.byte $61
; Map ID #$11: Tuhn
.byte $FF
; indirect data load target (via $A55B)
; indirect data load target
.byte $12,$0A,$13,$09,$6C,$03,$15,$10,$0C,$6A,$00,$0E,$12,$07,$69,$0C
.byte $18,$12,$0A,$6F,$0C,$14,$13,$07,$6E,$09,$1F,$13,$0C,$6D,$12,$01
.byte $02,$08,$6B,$0A,$0D,$01,$06,$12,$11,$0C,$02,$0C,$23,$11,$11,$03
.byte $0B,$70,$05,$16,$02,$0B,$B5,$11,$19,$01,$0B
.byte $68,$05,$1D,$03,$06,$19
.byte $10,$1D,$02
.byte $05
.byte $27
; Map ID #$13: Wellgarth
.byte $FF
; indirect data load target (via $A55F)
; indirect data load target
.byte $05,$08,$11,$09,$72,$03,$04,$02
.byte $04,$00,$02,$05
.byte $03,$0C
.byte $71
; Map ID #$14: Wellgarth Underground
.byte $FF
; indirect data load target (via $A561)
; indirect data load target
.byte $01,$03,$11,$0B,$75,$02,$0D,$12,$05,$77,$0C,$06,$12,$07,$03,$05
.byte $17,$12,$07,$78,$01,$08,$10,$08,$25,$0E,$11,$10,$0C,$79,$0B,$0C
.byte $13,$08,$99,$08,$01,$02,$06,$1A,$0E,$01,$02,$0B,$73,$17,$01,$02
.byte $0C,$B6,$15,$05,$02,$0A,$74,$0B,$09,$03,$06,$24,$08,$10,$01,$06
.byte $28,$14,$10,$02,$05,$27,$00,$13
.byte $01,$06,$12,$11
.byte $13,$02
.byte $0A
.byte $7A
; Map ID #$15: Beran
.byte $FF
; indirect data load target (via $A563)
; indirect data load target
.byte $06,$0B,$12,$05,$9A,$16,$0C,$10,$05,$B9,$0E,$0C,$13,$0A,$80,$13
.byte $17,$11,$0C,$84,$05,$0E,$11,$07,$81,$17,$14,$12,$08,$1B,$0E,$12
.byte $11,$0B,$82,$17,$16,$10,$07,$26,$02,$01,$02,$0B,$C0,$08,$00,$02
.byte $07,$7C,$0D,$06,$02,$05,$27,$10,$03,$02,$08,$7D,$14,$02,$02,$0A
.byte $7E,$14,$0D,$01,$06,$7F,$03,$11,$01,$06,$13,$08,$16
.byte $03,$0A,$92,$0D,$16,$01,$06
.byte $28,$15,$15
.byte $01,$0A
.byte $83
; Map ID #$16: Hargon's Castle 1F
.byte $FF
; indirect data load target (via $A565)
; indirect data load target
.byte $07,$14,$00,$04,$88,$0C,$16,$11,$04,$85,$0F,$13,$13,$04,$86,$13
.byte $14,$00,$04,$89,$0D,$10,$11,$04,$87,$0C
.byte $0F,$02,$05,$BA,$0E
.byte $0F,$02
.byte $05
.byte $BA
; Map ID #$17: Hargon's Castle 7F
.byte $FF
; indirect data load target (via $A567)
; indirect data load target
.byte $06,$04,$02,$04,$00,$07,$04,$02
.byte $05,$BB,$08,$04
.byte $02,$04
.byte $00
; Map ID #$18: Charlock Castle B8
.byte $FF
; indirect data load target (via $A569)
; indirect data load target
.byte $0A,$10,$02
.byte $05
.byte $BC
; Map ID #$19: Shrine NW of Midenhall
.byte $FF
; indirect data load target (via $A56B)
; indirect data load target
.byte $05,$05,$03
.byte $05
.byte $9B
; Map ID #$1A: Shrine SW of Cannock
.byte $FF
; indirect data load target (via $A56D)
; indirect data load target
.byte $05,$01,$12,$0B,$9C,$02,$04,$00
.byte $0A,$BD,$05,$04
.byte $00,$0A
.byte $BE
; Map ID #$1B: Shrine NW of Lianport
.byte $FF
; indirect data load target (via $A56F)
; indirect data load target
.byte $04,$01,$11
.byte $0B
.byte $8A
; Map ID #$1C: Shrine SE of Rimuldar
.byte $FF
; indirect data load target (via $A571)
; indirect data load target
.byte $04,$04,$03
.byte $0B
.byte $BF
; Map ID #$1D: Shrine NW of Beran
.byte $FF
; indirect data load target (via $A573)
; indirect data load target
.byte $04,$03,$02
.byte $0B
.byte $7B
; Map ID #$1E: Shrine NW of Zahan
.byte $FF
; indirect data load target (via $A575)
; indirect data load target
.byte $03,$03,$02
.byte $04
.byte $00
; Map ID #$1F: Rhone Shrine
.byte $FF
; indirect data load target (via $A577)
; indirect data load target
.byte $04,$02,$02,$05,$C1
.byte $04,$06,$03
.byte $07
.byte $8B
; Map ID #$20: Shrine SW of Moonbrooke
.byte $FF
; indirect data load target (via $A579)
; indirect data load target
.byte $04,$04,$00
.byte $05
.byte $C2
; Map ID #$21: Rhone Cave Shrine
.byte $FF
; indirect data load target (via $A57B)
; indirect data load target
.byte $00,$07,$10,$05,$49
.byte $02,$02,$01
.byte $0B
.byte $8C
; Map ID #$22: Shrine S of Midenhall
.byte $FF
; indirect data load target (via $A57D)
; indirect data load target
.byte $07,$01,$02,$0B,$47
.byte $07,$02,$00
.byte $04
.byte $00
; Map ID #$40: Spring of Bravery
.byte $FF
; indirect data load target (via $A5B9)
; indirect data load target
.byte $21,$0C,$03,$08,$CD
.byte $09,$0A,$02
.byte $0B
.byte $D0
; Map ID #$59: Wind Tower 2F
.byte $FF
; indirect data load target (via $A5EB)
; indirect data load target
.byte $16,$02,$00
.byte $0A
.byte $C3
; Map ID #$60: Dragon Horn South 1F
.byte $FF
; indirect data load target (via $A5F9)
; indirect data load target
.byte $06,$03,$02
.byte $06
.byte $CE
; Map ID #$56: Lighthouse 7F
.byte $FF
; indirect data load target (via $A5E5)
; indirect data load target
.byte $0E,$0A,$02,$0B,$D1
.byte $0E,$04,$02
.byte $05
.byte $00
; Map ID #$51: Lighthouse 2F
.byte $FF
; indirect data load target (via $A5DB)
; indirect data load target
.byte $22,$1F,$02,$0B,$D8,$1D,$1C,$02,$FF,$00
.byte $1F,$1C,$02,$FF,$00
.byte $1F,$1E,$03
.byte $FF
.byte $00
; Map ID #$57: Lighthouse 8F
.byte $FF
; indirect data load target (via $A5E7)
; indirect data load target
.byte $0A,$0F,$02
.byte $0A
.byte $D6
; Map ID #$49: Moon Tower 1F
.byte $FF
; indirect data load target (via $A5CB)
; indirect data load target
.byte $12,$04,$02
.byte $0B
.byte $C4
; Map ID #$2F: Sea Cave B2
.byte $FF
; indirect data load target (via $A597)
; indirect data load target
.byte $0D,$02,$02,$0A,$CA
.byte $09,$1E,$03
.byte $0A
.byte $CF
; Map ID #$33: Sea Cave B5
.byte $FF
; indirect data load target (via $A59F)
; indirect data load target
.byte $11,$0B,$03,$05,$D3
.byte $14,$0A,$03
.byte $FF
.byte $00
; Map ID #$55: Lighthouse 6F
.byte $FF
; indirect data load target (via $A5E3)
; indirect data load target
.byte $01,$19,$02
.byte $0B
.byte $D1
; Map ID #$54: Lighthouse 5F
.byte $FF
; indirect data load target (via $A5E1)
; indirect data load target
.byte $19,$17,$00
.byte $0B
.byte $D1
; Map ID #$53: Lighthouse 4F
.byte $FF
; indirect data load target (via $A5DF)
; indirect data load target
.byte $1A,$13,$02
.byte $0B
.byte $D1
; Map ID #$52: Lighthouse 3F
.byte $FF
; indirect data load target (via $A5DD)
; indirect data load target
.byte $14,$1E,$01
.byte $0B
.byte $D1
; Map ID #$29: Rubiss' Shrine B7
.byte $FF
; indirect data load target (via $A58B)
; indirect data load target
.byte $02,$02,$00,$FF,$00,$04,$02,$00,$FF,$00
.byte $02,$04,$00,$FF,$00
.byte $04,$04,$00
.byte $FF
.byte $00
; Map ID #$6D: Moonbrooke (prologue)
.byte $FF
; indirect data load target (via $A613)
; indirect data load target
.byte $03,$02,$03,$FF,$00,$09,$64,$02,$01,$00,$08,$0A,$02,$02,$00,$0B
.byte $0B,$02,$0A,$00,$02,$13,$02,$0A,$00,$13,$0B,$01,$05,$00,$64,$64
.byte $02,$05,$00,$64,$64,$00,$05,$00,$0A,$02,$01,$FF,$00,$12,$02,$03
.byte $FF,$00,$64,$64,$02,$05,$00,$64,$64,$02,$05,$00,$64,$64,$02,$05
.byte $00,$64,$64,$02,$05,$00,$64,$64,$02,$05,$00,$64,$64,$02,$05,$00
.byte $64,$64,$00,$05,$00,$10,$12,$00,$0A,$00
.byte $11,$12,$00,$0A,$00
.byte $02,$02,$01
.byte $0A
.byte $00
; Map ID #$6E: Midenhall 1F (prologue)
.byte $FF
; indirect data load target (via $A615)
; indirect data load target
.byte $0F,$17,$00,$0A,$00,$0D,$0F,$01,$0A,$00,$11,$0F,$03
.byte $0A,$00,$0A,$14,$01,$06
.byte $00,$15,$13
.byte $03,$06
.byte $00
; Map ID #$6F: World Map at Moonbrooke (prologue)
.byte $FF
; indirect data load target (via $A617)
; indirect data load target
.byte $61,$6E,$00,$FF,$00,$62,$6E,$00,$FF,$00,$61,$6F,$00
.byte $FF,$00,$62,$6F,$00,$FF
.byte $00,$63,$6F
.byte $01,$0A
.byte $00
; Map ID #$70: World Map at Midenhall (prologue)
.byte $FF
; indirect data load target (via $A619)
; indirect data load target
.byte $CF,$38,$01
.byte $0A
.byte $00

.byte $FF
; data -> code
; external control flow target (from $0F:$E4AD)
    lda $0C ; save $0C-$11 on the stack

    pha
    lda $0D
    pha
    lda $0E
    pha
    lda $0F
    pha
    lda $10
    pha
    lda $11
    pha
; call to code in a different bank ($0F:$C1DC)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    lda $23 ; map pointer, low byte

    sta $0C
    lda $24 ; map pointer, high byte

    sta $0D
    jsr $B077 ; read the first 3 bytes of map data, initialize the map width, map height, map buffer index bit width, tile ID bit width and $6158 (unused?); leaves $0C-$0D pointing at map data byte 3

    jsr $ABBF
    pla ; restore $0C-$11 from the stack

    sta $11
    pla
    sta $10
    pla
    sta $0F
    pla
    sta $0E
    pla
    sta $0D
    pla
    sta $0C
    rts

; control flow target (from $ABA9)
    jsr $AC41 ; load map tiles

    jsr $AC62 ; switch to map roofing phase and process roofing updates

    jsr $ABC9
    rts

; control flow target (from $ABC5)
    lda $1F ; some kind of map type (#$00: World Map, #$01: other non-dungeon maps, #$02: maps #$2B - #$43 inclusive, #$03: maps >= #$44, #$FF => game menu)

    cmp #$01
    beq B02_ABD0 ; scan through map and replace Vertical Wall tiles that don't have a Vertical Wall tile with the same roofing below them with Horizontal Wall tiles

    rts

; scan through map and replace Vertical Wall tiles that don't have a Vertical Wall tile with the same roofing below them with Horizontal Wall tiles
; control flow target (from $ABCD)
B02_ABD0:
    lda #$00 ; set $0C-$0D to address of map buffer at $7800

    sta $0C
    lda #$78
    sta $0D
    lda #$00
    sta $6D ; current row

; process row
; control flow target (from $AC3E)
B02_ABDC:
    ldy #$00 ; current column

; process column
; control flow target (from $AC2B)
B02_ABDE:
    lda ($0C),Y ; current map tile

    sta $6E ; current map tile

    and #$1F ; ignore roofing

    cmp #$05 ; Map Tile ID #$05: Vertical Wall

    bne B02_AC28 ; update map co-ordinates

    lda $6E ; current map tile

    and #$E0 ; pick out the roofing

    sta $6E ; current map tile's roofing

    ldx $6D ; current row

    inx ; next row

    cpx $0F ; map height

    bcc B02_ABFD ; not processing bottom row of map

    lda $20 ; map exterior border tile ID (#$00 = Road, #$01 = Grass, #$02 = Sand, #$03 = Tree, #$04 = Water, #$05 = Vertical Wall, #$06 = Shrub, #$07 = Horizontal Wall, #$08 = Swamp, ..., #$20 = Ceiling Alternating?, #$21 = Ceiling Down?, #$24 = Black?, #$28 = Blue?)

    cmp #$05 ; Map Tile ID #$05: Vertical Wall

    bne B02_AC22 ; replace Vertical Wall tile with Horizontal Wall tile

    beq B02_AC28 ; update map co-ordinates

; not processing bottom row of map
; control flow target (from $ABF3)
B02_ABFD:
    lda $0C ; set $72-$73 to current map pos + 1 row

    clc
    adc $0E ; map width

    sta $72
    lda $0D
    adc #$00
    sta $73
    lda ($72),Y ; tile below current map tile

    sta $6F ; tile below current map tile

    and #$E0 ; pick out the roofing

    cmp $6E ; current map tile's roofing

    beq B02_AC16 ; tile below current map tile has same roofing

    bpl B02_AC28 ; update map co-ordinates

; tile below current map tile has same roofing
; control flow target (from $AC12)
B02_AC16:
    lda $6F ; tile below current map tile

    and #$1F ; ignore the roofing

    cmp #$05 ; Map Tile ID #$05: Vertical Wall

    beq B02_AC28 ; update map co-ordinates

    cmp #$07 ; Map Tile ID #$07: Horizontal Wall

    beq B02_AC28 ; update map co-ordinates

; replace Vertical Wall tile with Horizontal Wall tile
; control flow target (from $ABF9)
B02_AC22:
    lda #$07 ; Map Tile ID #$07: Horizontal Wall

    ora $6E ; current map tile's roofing

    sta ($0C),Y ; current map tile

; update map co-ordinates
; control flow target (from $ABE6, $ABFB, $AC14, $AC1C, $AC20)
B02_AC28:
    iny ; current column

    cpy $0E ; map width

    bcc B02_ABDE ; process column

    lda $0C ; add map width to 16-bit $0C-$0D

    clc
    adc $0E ; map width

    sta $0C
    bcc B02_AC38
    inc $0D
; control flow target (from $AC34)
B02_AC38:
    inc $6D ; current row

    lda $6D ; current row

    cmp $0F ; map height

    bcc B02_ABDC ; process row

    rts

; load map tiles
; control flow target (from $ABBF)
    jsr $AC77 ; initialize map bit index $614D, map roofing phase flag $614E, and "map stack" index $6156 to #$00

    jsr $AC83 ; read 1 tile ID of map data, fill map interior background with that tile

; process next map control code
; control flow target (from $AC73, $AD3C, $AE11, $AE3C, $AE86)
    jsr $ACC3 ; read 2 bits of map data into $6D-$6E, updating read variables as necessary and returning $6D in A

; process map control code in A
; control flow target (from $AD3F)
    cmp #$00
    beq B02_AC59 ; map data 0b00 handler: set current 1x1 or 2x2 block of tiles

    cmp #$01
    beq B02_AC5C ; map data 0b01 handler: read 2 co-ordinates of map data and depending on roofing phase, fill the map buffer between those two points with the current 1x1 or 2x2 block of tile IDs or update the roofing between those two points

    cmp #$02
    beq B02_AC5F ; map data 0b10 handler: read 1 co-ordinate of map data and then start drawing the current tile ID from there, moving around as dictated by map data

    jmp $AE36 ; map data 0b11 handler: read 1 co-ordinate of map data and then depending on roofing phase, either write the current 1x1 or 2x2 block of tile IDs there or update its roofing


; map data 0b00 handler: set current 1x1 or 2x2 block of tiles
; control flow target (from $AC4C)
B02_AC59:
    jmp $AD0D ; map data 0b00 handler: set the current 1x1 or 2x2 block of tile IDs


; map data 0b01 handler: read 2 co-ordinates of map data and depending on roofing phase, fill the map buffer between those two points with the current 1x1 or 2x2 block of tile IDs or update the roofing between those two points
; control flow target (from $AC50)
B02_AC5C:
    jmp $AD42 ; map data 0b01 handler: read 2 co-ordinates of map data and depending on roofing phase, fill the map buffer between those two points with the current 1x1 or 2x2 block of tile IDs or update the roofing between those two points


; map data 0b10 handler: read 1 co-ordinate of map data and then start drawing the current tile ID from there, moving around as dictated by map data
; control flow target (from $AC54)
B02_AC5F:
    jmp $AE3F ; map data 0b10 handler: read 1 co-ordinate of map data and then start drawing the current tile ID from there, moving around as dictated by map data


; switch to map roofing phase and process roofing updates
; control flow target (from $ABC2)
    lda #$FF
    sta $614E ; map roofing phase flag

    lda #$02
    jsr $ACCA ; read A bits of map data into $6D-$6E, updating read variables as necessary and returning $6D in A

    cmp #$00
    beq B02_AC76 ; #$00 => no roofing updates, so skip this phase

    sta $6157 ; map tile ID bit size

    jsr $AC47 ; process next map control code

; control flow target (from $AC6E)
B02_AC76:
    rts

; initialize map bit index $614D, map roofing phase flag $614E, and "map stack" index $6156 to #$00
; control flow target (from $AC41)
    lda #$00
    sta $614D ; map bit index; how many times to LSR #$80 so it lines up with the current map bit

    sta $614E ; map roofing phase flag

    sta $6156 ; index to top of "map stack" at $616B for 0b10 handler

    rts

; read 1 tile ID of map data, fill map interior background with that tile
; control flow target (from $AC44)
    jsr $ACA8 ; read 1 tile ID of map data into $6D-$6E, updating read variables as necessary and returning $6D in A

    pha ; map interior background tile ID

    lda #$00 ; initialize map buffer address $10-$11 to $7800

    sta $10 ; map buffer address, low byte

    lda #$78
    sta $11 ; map buffer address, high byte

    pla ; map interior background tile ID

    ldy $0F ; map height

    sty $6D ; number of rows left

    ldy #$00
; control flow target (from $ACA5)
B02_AC96:
    ldx $0E ; map width

; control flow target (from $ACA1)
B02_AC98:
    sta ($10),Y ; write map interior background tile ID to buffer

    inc $10 ; INC 16-bit write address

    bne B02_ACA0
    inc $11
; control flow target (from $AC9C)
B02_ACA0:
    dex ; number of columns left

    bne B02_AC98
    dec $6D ; number of rows left

    bne B02_AC96
    rts

; read 1 tile ID of map data into $6D-$6E, updating read variables as necessary and returning $6D in A
; control flow target (from $AC83, $AD12, $AD2A, $AD30, $AD36)
    lda $6157 ; map tile ID bit size

    jmp $ACCA ; read A bits of map data into $6D-$6E, updating read variables as necessary and returning $6D in A


; read 1 co-ordinate of map data into $6D-$6E, set $75-$76 to that map buffer address
; control flow target (from $AE36, $AE3F)
    jsr $ACC7 ; read 1 co-ordinate of map data into $6D-$6E, updating read variables as necessary and returning $6D in A

    lda #$00
    ldy #$78
    ldx #$6D
    jsr $B00A ; given A, X, and Y, ($00,X-$01,X)  = ($00,X-$01,X) + (Y * $100 + A)

    lda $6D
    sta $75
    lda $6E
    sta $76
    rts

; read 2 bits of map data into $6D-$6E, updating read variables as necessary and returning $6D in A
; control flow target (from $AC47, $AD18)
    lda #$02
    bne B02_ACCA ; read A bits of map data into $6D-$6E, updating read variables as necessary and returning $6D in A

; read 1 co-ordinate of map data into $6D-$6E, updating read variables as necessary and returning $6D in A
; control flow target (from $ACAE, $AD42, $AD5A)
    lda $6150 ; map buffer index bit size

; read A bits of map data into $6D-$6E, updating read variables as necessary and returning $6D in A
; control flow target (from $AC69, $ACAB, $ACC5, $AE52, $AF1F)
B02_ACCA:
    tax
    lda #$00
    sta $6D
    sta $6E
; control flow target (from $ACD9)
B02_ACD1:
    jsr $ACDE ; read 1 bit of map data into C, updating read variables as necessary

    rol $6D ; rotate C into 16-bit $6D-$6E

    rol $6E
    dex
    bne B02_ACD1
    lda $6D
    rts

; read 1 bit of map data into C, updating read variables as necessary
; control flow target (from $ACD1, $AD1F, $AE48, $AE61, $AE89)
    lda #$80
    ldy $614D ; map bit index; how many times to LSR #$80 so it lines up with the current map bit

; control flow target (from $ACE7)
    beq B02_ACEA
    lsr
    dey
    jmp $ACE3

; control flow target (from $ACE3)
B02_ACEA:
    ldy #$00
    and ($0C),Y
    sta $7B ; dedicated temporary storage for byte containing current map bit; PHA/PLA would have been better

    inc $614D ; map bit index; how many times to LSR #$80 so it lines up with the current map bit

    lda $614D ; map bit index; how many times to LSR #$80 so it lines up with the current map bit

    cmp #$08 ; 8 bits per byte

    bcc B02_AD05 ; CLC if $7B is #$00, SEC otherwise

    lda #$00 ; otherwise reset to #$00 and INC 16-bit map data address $0C-$0D

    sta $614D ; map bit index; how many times to LSR #$80 so it lines up with the current map bit

    inc $0C
    bne B02_AD05 ; CLC if $7B is #$00, SEC otherwise

    inc $0D
; CLC if $7B is #$00, SEC otherwise
; control flow target (from $ACF8, $AD01)
B02_AD05:
    lda $7B ; dedicated temporary storage for byte containing current map bit; PHA/PLA would have been better

    beq B02_AD0B
    sec
    rts

; control flow target (from $AD07)
B02_AD0B:
    clc
    rts

; map data 0b00 handler: set the current 1x1 or 2x2 block of tile IDs
; control flow target (from $AC59)
    lda #$00
    sta $614F ; flag for whether 0b00 handler wrote tile IDs to $6153-$6155

    jsr $ACA8 ; read 1 tile ID of map data into $6D-$6E, updating read variables as necessary and returning $6D in A

    sta $6152 ; first tile ID from 0b00 handler

    jsr $ACC3 ; read 2 bits of map data into $6D-$6E, updating read variables as necessary and returning $6D in A

    cmp #$00
    bne B02_AD3F ; loop to process map control code in A

    jsr $ACDE ; read 1 bit of map data into C, updating read variables as necessary

    bcc B02_AD25 ; flag 2x2 block, read 3 tile IDs of map data into $6153-$6155

    rts ; RTS to end this map phase


; flag 2x2 block, read 3 tile IDs of map data into $6153-$6155
; control flow target (from $AD22)
B02_AD25:
    lda #$FF
    sta $614F ; flag for whether 0b00 handler wrote tile IDs to $6153-$6155

    jsr $ACA8 ; read 1 tile ID of map data into $6D-$6E, updating read variables as necessary and returning $6D in A

    sta $6153 ; second tile ID from 0b00 handler

    jsr $ACA8 ; read 1 tile ID of map data into $6D-$6E, updating read variables as necessary and returning $6D in A

    sta $6154 ; third tile ID from 0b00 handler

    jsr $ACA8 ; read 1 tile ID of map data into $6D-$6E, updating read variables as necessary and returning $6D in A

    sta $6155 ; fourth tile ID from 0b00 handler

    jmp $AC47 ; process next map control code


; loop to process map control code in A
; control flow target (from $AD1D)
B02_AD3F:
    jmp $AC4A ; process map control code in A


; map data 0b01 handler: read 2 co-ordinates of map data and depending on roofing phase, fill the map buffer between those two points with the current 1x1 or 2x2 block of tile IDs or update the roofing between those two points
; control flow target (from $AC5C)
    jsr $ACC7 ; read 1 co-ordinate of map data into $6D-$6E, updating read variables as necessary and returning $6D in A

    lda $6D ; useless op: A already contains $6D

    sta $74 ; copy map buffer index from $6D-$6E to $74-$75

    lda $6E
    sta $75
    lda $0E ; map width

    ldx #$6D
    jsr $B060 ; given A and X, perform 16-bit division: ($00,X-$01,X) / A = quotient in ($00,X-$01,X), remainder in A

    sta $70 ; start column

    lda $6D ; start row

    sta $71 ; start row

    jsr $ACC7 ; read 1 co-ordinate of map data into $6D-$6E, updating read variables as necessary and returning $6D in A

    lda $0E ; map width

    ldx #$6D
    jsr $B060 ; given A and X, perform 16-bit division: ($00,X-$01,X) / A = quotient in ($00,X-$01,X), remainder in A

    sta $72 ; end column

    lda $6D ; end row

    sta $73 ; end row

    lda #$00
    ldy #$78
    ldx #$74
    jsr $B00A ; given A, X, and Y, ($00,X-$01,X)  = ($00,X-$01,X) + (Y * $100 + A); $74-$75 is now address in map buffer

    lda $73 ; end row

    sec
    sbc $71 ; start row

    sta $71 ; difference between row offsets

    lda $72 ; end column

    sec
    sbc $70 ; start column

    sta $70 ; difference between column offsets

    lda $614F ; flag for whether 0b00 handler wrote tile IDs to $6153-$6155

    beq B02_AD8A
    lsr $70 ; if flag set, we're writing 2x2 blocks instead of 1x1, so divide the differences by 2

    lsr $71
; control flow target (from $AD84)
B02_AD8A:
    inc $70 ; convert to number of columns

    inc $71 ; convert to number of rows

; update map buffer
; control flow target (from $AE14)
    lda $6152 ; first tile ID from 0b00 handler

    ldx $70 ; number of columns to copy

; update map buffer row
; control flow target (from $ADE3, $ADFD)
B02_AD93:
    ldy #$00
    pha
    lda $614E ; map roofing phase flag

    beq B02_ADB0 ; adding base tiles phase

; roofing phase
    lda ($74),Y ; map data

    and #$1F ; strip off the roof

    sta ($74),Y ; map data

    pla ; tile ID

    pha ; tile ID

    asl ; base tiles are at most 5 bits wide, so roofing gets the high 3 bits

    asl
    asl
    asl
    asl
    ora ($74),Y ; map data; add the roof

    sta ($74),Y ; map data

    pla ; tile ID

    jmp $ADF9 ; update the map co-ordinates


; adding base tiles phase
; control flow target (from $AD99)
B02_ADB0:
    lda $614F ; flag for whether 0b00 handler wrote tile IDs to $6153-$6155

    beq B02_ADF6 ; write a 1x1 tile ID and update the map co-ordinates

    pla
; write the 2x2 block of tile IDs given by $6152-$6155 to the map buffer at ($74),Y
    lda $6152 ; first tile ID from 0b00 handler

    sta ($74),Y ; map data

    jsr $AE17 ; INC 16-bit $74-$75

    lda $74 ; map data; save map buffer index on the stack

    pha
    lda $75
    pha
    lda $6153 ; second tile ID from 0b00 handler

    sta ($74),Y ; map data

    jsr $AE2A ; add map width $0E to 16-bit $74-$75, i.e. $74-$75 += 1 row

    lda $6155 ; fourth tile ID from 0b00 handler

    sta ($74),Y ; map data

    jsr $AE1E ; DEC 16-bit $74-$75

    lda $6154 ; third tile ID from 0b00 handler

    sta ($74),Y ; map data

    pla ; restore map buffer index from the stack

    sta $75
    pla
    sta $74 ; map data

    jsr $AE17 ; INC 16-bit $74-$75

    dex ; number of columns left to copy

    bne B02_AD93 ; update map buffer row

    lda $0E ; map width

    sec
    sbc $70 ; number of columns to copy

    sec
    sbc $70 ; number of columns to copy

    jsr $AE2C ; add A to 16-bit $74-$75

    jsr $AE2A ; add map width $0E to 16-bit $74-$75, i.e. $74-$75 += 1 row

    jmp $AE0D ; DEC number of rows left to copy, keep going


; write a 1x1 tile ID and update the map co-ordinates
; control flow target (from $ADB3)
B02_ADF6:
    pla
    sta ($74),Y ; map data

; update the map co-ordinates
; control flow target (from $ADAD)
    jsr $AE17 ; INC 16-bit $74-$75

    dex ; number of columns left to copy

    bne B02_AD93 ; update map buffer row

    lda $0E ; map width

    sec
    sbc $70 ; number of columns to copy

    clc
    adc $74
    sta $74 ; $74-$75 = $74-$75 + 1 row - number of columns we copied, i.e. original map co-ordinates + 1 row

    bcc B02_AE0D ; DEC number of rows left to copy, keep going

    inc $75
; DEC number of rows left to copy, keep going
; control flow target (from $ADF3, $AE09)
B02_AE0D:
    dec $71 ; number of rows left to copy

    bne B02_AE14 ; update map buffer

    jmp $AC47 ; process next map control code


; update map buffer
; control flow target (from $AE0F)
B02_AE14:
    jmp $AD8E ; update map buffer


; INC 16-bit $74-$75
; control flow target (from $ADBB, $ADDF, $ADF9)
    inc $74
    bne B02_AE1D
    inc $75
; control flow target (from $AE19)
B02_AE1D:
    rts

; DEC 16-bit $74-$75
; control flow target (from $ADD1)
    lda $74
    sec
    sbc #$01
    sta $74
    bcs B02_AE29
    dec $75
; control flow target (from $AE25)
B02_AE29:
    rts

; add map width $0E to 16-bit $74-$75, i.e. $74-$75 += 1 row
; control flow target (from $ADC9, $ADF0)
    lda $0E ; map width

; add A to 16-bit $74-$75
; control flow target (from $ADED)
    clc
    adc $74
    sta $74
    bcc B02_AE35
    inc $75
; control flow target (from $AE31)
B02_AE35:
    rts

; map data 0b11 handler: read 1 co-ordinate of map data and then depending on roofing phase, either write the current 1x1 or 2x2 block of tile IDs there or update its roofing
; control flow target (from $AC56)
    jsr $ACAE ; read 1 co-ordinate of map data into $6D-$6E, set $75-$76 to that map buffer address

    jsr $AF26 ; depending on roofing phase, either write the current 1x1 or 2x2 block of tile IDs to ($6D) or update the roofing of the 1x1 or 2x2 block at ($6D)

    jmp $AC47 ; process next map control code


; map data 0b10 handler: read 1 co-ordinate of map data and then start drawing the current tile ID from there, moving around as dictated by map data
; control flow target (from $AC5F, $AE66)
B02_AE3F:
    jsr $ACAE ; read 1 co-ordinate of map data into $6D-$6E, set $75-$76 to that map buffer address

    jsr $AF26 ; depending on roofing phase, either write the current 1x1 or 2x2 block of tile IDs to ($6D) or update the roofing of the 1x1 or 2x2 block at ($6D)

    jsr $AF1D ; read 2 bits of data into draw direction $6151, updating read variables as necessary

; process next 0b10 control code
; control flow target (from $AE83, $AEB9)
    jsr $ACDE ; read 1 bit of map data into C, updating read variables as necessary

    bcs B02_AE50 ; read 2 bits of map data: if #$00 or #$01, rotate in that direction and draw the current tile ID; if #$02, push to "map stack" then read 1 bit of map data, rotate in that direction, and draw current tile ID; if #$03, read 1 bit of map data and if set, pop from "map stack", else loop to 0b10 handler to start drawing at a new co-ordinate

    jmp $AEB3 ; keep drawing in the current direction; update map co-ordinates based on draw direction and depending on roofing phase flag, either update the roofing of the 1x1 or 2x2 block at ($75) or write a 1x1 or 2x2 block of tile IDs to ($75)


; read 2 bits of map data: if #$00 or #$01, rotate in that direction and draw the current tile ID; if #$02, push to "map stack" then read 1 bit of map data, rotate in that direction, and draw current tile ID; if #$03, read 1 bit of map data and if set, pop from "map stack", else loop to 0b10 handler to start drawing at a new co-ordinate
; control flow target (from $AE4B)
B02_AE50:
    lda #$02
    jsr $ACCA ; read A bits of map data into $6D-$6E, updating read variables as necessary and returning $6D in A

    cmp #$00
    beq B02_AE97 ; turn direction clockwise, move in that direction, and draw current tile ID

    cmp #$01
    beq B02_AEA5 ; turn direction counter-clockwise, move in that direction, and draw current tile ID

    cmp #$02
    beq B02_AE89 ; push the current map co-ordinates and direction to the "map stack", updating its index, then read 1 bit of map data and if set, rotate direction counter-clockwise, else rotate direction clockwise; either way, move in that direction and draw the current tile ID

    jsr $ACDE ; read 1 bit of map data into C, updating read variables as necessary

; useless op; control flow is identical without this
    bcs B02_AE68
    bcc B02_AE3F ; map data 0b10 handler: read 1 co-ordinate of map data and then start drawing the current tile ID from there, moving around as dictated by map data

; control flow target (from $AE64)
B02_AE68:
    ldx $6156 ; index to top of "map stack" at $616B for 0b10 handler

    beq B02_AE86 ; popping the bottom of the "map stack" ends the 0b10 control code; loop to process the next map control code

    dex
    lda $616B,X ; "map stack" start

    sta $6151 ; draw direction from 0b10 handler

    dex
    lda $616B,X ; "map stack" start

    sta $76
    dex
    lda $616B,X ; "map stack" start

    sta $75
    stx $6156 ; index to top of "map stack" at $616B for 0b10 handler

    jmp $AE48 ; process next 0b10 control code


; popping the bottom of the "map stack" ends the 0b10 control code; loop to process the next map control code
; control flow target (from $AE6B)
B02_AE86:
    jmp $AC47 ; process next map control code


; push the current map co-ordinates and direction to the "map stack", updating its index, then read 1 bit of map data and if set, rotate direction counter-clockwise, else rotate direction clockwise; either way, move in that direction and draw the current tile ID
; control flow target (from $AE5F)
B02_AE89:
    jsr $ACDE ; read 1 bit of map data into C, updating read variables as necessary

    bcc B02_AE94 ; push the current map co-ordinates and direction to the "map stack", updating its index, then rotate direction clockwise, move in that direction, and draw the current tile ID

    jsr $AFA4 ; push the current map co-ordinates and direction to the "map stack" and update its index

    jmp $AEA5 ; turn direction counter-clockwise, move in that direction, and draw current tile ID


; push the current map co-ordinates and direction to the "map stack", updating its index, then rotate direction clockwise, move in that direction, and draw the current tile ID
; control flow target (from $AE8C)
B02_AE94:
    jsr $AFA4 ; push the current map co-ordinates and direction to the "map stack" and update its index

; turn direction clockwise, move in that direction, and draw current tile ID
; control flow target (from $AE57)
B02_AE97:
    lda $6151 ; draw direction from 0b10 handler

    clc
    adc #$01
    and #$03
    sta $6151 ; draw direction from 0b10 handler

    jmp $AEB3 ; keep drawing in the current direction; update map co-ordinates based on draw direction and depending on roofing phase flag, either update the roofing of the 1x1 or 2x2 block at ($75) or write a 1x1 or 2x2 block of tile IDs to ($75)


; turn direction counter-clockwise, move in that direction, and draw current tile ID
; control flow target (from $AE5B, $AE91)
B02_AEA5:
    lda $6151 ; draw direction from 0b10 handler

    sec
    sbc #$01
    and #$03
    sta $6151 ; draw direction from 0b10 handler

    jmp $AEB3 ; keep drawing in the current direction; update map co-ordinates based on draw direction and depending on roofing phase flag, either update the roofing of the 1x1 or 2x2 block at ($75) or write a 1x1 or 2x2 block of tile IDs to ($75)


; keep drawing in the current direction; update map co-ordinates based on draw direction and depending on roofing phase flag, either update the roofing of the 1x1 or 2x2 block at ($75) or write a 1x1 or 2x2 block of tile IDs to ($75)
; control flow target (from $AE4D, $AEA2, $AEB0)
    jsr $AEBC ; update map co-ordinates based on draw direction

    jsr $AF67 ; depending on roofing phase, either write a 1x1 or 2x2 block of tile IDs to ($75) or update the roofing of the 1x1 or 2x2 block at ($75)

    jmp $AE48 ; process next 0b10 control code


; update map co-ordinates based on draw direction
; control flow target (from $AEB3)
    ldx $6151 ; draw direction from 0b10 handler

    beq B02_AEC9 ; subtract 1 or 2 rows from $75-$76 depending on whether we're writing 1x1 or 2x2 blocks

    dex
    beq B02_AED4 ; add 1 or 2 columns to $75-$76 depending on whether we're writing 1x1 or 2x2 blocks

    dex
    beq B02_AEDE ; add 1 or 2 rows to $75-$76 depending on whether we're writing 1x1 or 2x2 blocks

    bne B02_AEE8 ; subtract 1 or 2 columns from $75-$76 depending on whether we're writing 1x1 or 2x2 blocks

; subtract 1 or 2 rows from $75-$76 depending on whether we're writing 1x1 or 2x2 blocks
; control flow target (from $AEBF)
B02_AEC9:
    jsr $AEF2 ; subtract map width $0E from 16-bit $75-$76, i.e. $75-$76 -= 1 row

    lda $614F ; flag for whether 0b00 handler wrote tile IDs to $6153-$6155

    beq B02_AED3 ; done updating

    bne B02_AEF2 ; subtract map width $0E from 16-bit $75-$76, i.e. $75-$76 -= 1 row

; done updating
; control flow target (from $AECF, $AEDA, $AEE4, $AEEE)
B02_AED3:
    rts

; add 1 or 2 columns to $75-$76 depending on whether we're writing 1x1 or 2x2 blocks
; control flow target (from $AEC2)
B02_AED4:
    jsr $AEFE ; INC 16-bit $75-$76

    lda $614F ; flag for whether 0b00 handler wrote tile IDs to $6153-$6155

    beq B02_AED3 ; done updating

    bne B02_AEFE ; INC 16-bit $75-$76

; add 1 or 2 rows to $75-$76 depending on whether we're writing 1x1 or 2x2 blocks
; control flow target (from $AEC5)
B02_AEDE:
    jsr $AF05 ; add map width $0E to 16-bit $75-$76, i.e. $75-$76 += 1 row

    lda $614F ; flag for whether 0b00 handler wrote tile IDs to $6153-$6155

    beq B02_AED3 ; done updating

    bne B02_AF05 ; add map width $0E to 16-bit $75-$76, i.e. $75-$76 += 1 row

; subtract 1 or 2 columns from $75-$76 depending on whether we're writing 1x1 or 2x2 blocks
; control flow target (from $AEC7)
B02_AEE8:
    jsr $AF11 ; DEC 16-bit $75-$76

    lda $614F ; flag for whether 0b00 handler wrote tile IDs to $6153-$6155

    beq B02_AED3 ; done updating

    bne B02_AF11 ; DEC 16-bit $75-$76

; subtract map width $0E from 16-bit $75-$76, i.e. $75-$76 -= 1 row
; control flow target (from $AEC9, $AED1)
B02_AEF2:
    lda $75
    sec
    sbc $0E ; map width

    sta $75
    bcs B02_AEFD
    dec $76
; control flow target (from $AEF9, $AF00, $AF0C, $AF18)
B02_AEFD:
    rts

; INC 16-bit $75-$76
; control flow target (from $AED4, $AEDC)
B02_AEFE:
    inc $75
    bne B02_AEFD
    inc $76
    rts

; add map width $0E to 16-bit $75-$76, i.e. $75-$76 += 1 row
; control flow target (from $AEDE, $AEE6)
B02_AF05:
    lda $75
    clc
    adc $0E ; map width

    sta $75
    bcc B02_AEFD
    inc $76
    rts

; DEC 16-bit $75-$76
; control flow target (from $AEE8, $AEF0)
B02_AF11:
    lda $75
    sec
    sbc #$01
    sta $75
    bcs B02_AEFD
    dec $76
    rts

; read 2 bits of data into draw direction $6151, updating read variables as necessary
; control flow target (from $AE45)
    lda #$02
    jsr $ACCA ; read A bits of map data into $6D-$6E, updating read variables as necessary and returning $6D in A

    sta $6151 ; draw direction from 0b10 handler

    rts

; depending on roofing phase, either write the current 1x1 or 2x2 block of tile IDs to ($6D) or update the roofing of the 1x1 or 2x2 block at ($6D)
; control flow target (from $AE39, $AE42)
    lda $6152 ; first tile ID from 0b00 handler

    ldy #$00
    jsr $AF4A ; depending on roofing phase, either write the tile ID in A to ($6D),Y or update the roofing of ($6D),Y based on A

    lda $614F ; flag for whether 0b00 handler wrote tile IDs to $6153-$6155

    beq B02_AF49
    iny
    lda $6153 ; second tile ID from 0b00 handler

    jsr $AF4A ; depending on roofing phase, either write the tile ID in A to ($6D),Y or update the roofing of ($6D),Y based on A

    ldy $0E ; map width

    lda $6154 ; third tile ID from 0b00 handler

    jsr $AF4A ; depending on roofing phase, either write the tile ID in A to ($6D),Y or update the roofing of ($6D),Y based on A

    iny
    lda $6155 ; fourth tile ID from 0b00 handler

    jmp $AF4A ; depending on roofing phase, either write the tile ID in A to ($6D),Y or update the roofing of ($6D),Y based on A


; control flow target (from $AF31, $AF72)
B02_AF49:
    rts

; depending on roofing phase, either write the tile ID in A to ($6D),Y or update the roofing of ($6D),Y based on A
; control flow target (from $AF2B, $AF37, $AF3F, $AF46)
    pha ; tile ID

    lda $614E ; map roofing phase flag

    beq B02_AF63
    lda ($6D),Y ; map data

    and #$1F ; strip off the roof

    sta ($6D),Y ; map data

    pla ; tile ID

    pha ; tile ID

    asl ; base tiles are at most 5 bits wide, so roofing gets the high 3 bits

    asl
    asl
    asl
    asl
    ora ($6D),Y ; add the roof

    sta ($6D),Y ; map data

    pla ; tile ID

    rts

; control flow target (from $AF4E)
B02_AF63:
    pla
    sta ($6D),Y
    rts

; depending on roofing phase, either write a 1x1 or 2x2 block of tile IDs to ($75) or update the roofing of the 1x1 or 2x2 block at ($75)
; control flow target (from $AEB6)
    lda $6152 ; first tile ID from 0b00 handler

    ldy #$00
    jsr $AF87 ; depending on roofing phase, either write the tile ID in A to ($75),Y or update the roofing of ($75),Y based on A

    lda $614F ; flag for whether 0b00 handler wrote tile IDs to $6153-$6155

    beq B02_AF49
    iny ; original co-ordinates + 1 column

    lda $6153 ; second tile ID from 0b00 handler

    jsr $AF87 ; depending on roofing phase, either write the tile ID in A to ($75),Y or update the roofing of ($75),Y based on A

    ldy $0E ; map width; original co-ordinates + 1 row

    lda $6154 ; third tile ID from 0b00 handler

    jsr $AF87 ; depending on roofing phase, either write the tile ID in A to ($75),Y or update the roofing of ($75),Y based on A

    iny ; original co-ordinates + 1 row, + 1 column

    lda $6155 ; fourth tile ID from 0b00 handler

; depending on roofing phase, either write the tile ID in A to ($75),Y or update the roofing of ($75),Y based on A
; control flow target (from $AF6C, $AF78, $AF80)
    pha ; tile ID

    lda $614E ; map roofing phase flag

    beq B02_AFA0 ; non-roofing phase: write A to the map at ($75),Y

    lda ($75),Y ; map data

    and #$1F ; strip off the roof

    sta ($75),Y ; map data

    pla ; tile ID

    pha ; tile ID

    asl ; base tiles are at most 5 bits wide, so roofing gets the high 3 bits

    asl
    asl
    asl
    asl
    ora ($75),Y ; add the roof

    sta ($75),Y ; map data

    pla ; tile ID

    rts

; non-roofing phase: write A to the map at ($75),Y
; control flow target (from $AF8B)
B02_AFA0:
    pla
    sta ($75),Y
    rts

; push the current map co-ordinates and direction to the "map stack" and update its index
; control flow target (from $AE8E, $AE94)
    ldx $6156 ; index to top of "map stack" at $616B for 0b10 handler

    lda $75
    sta $616B,X ; "map stack" start

    inx
    lda $76
    sta $616B,X ; "map stack" start

    inx
    lda $6151 ; draw direction from 0b10 handler

    sta $616B,X ; "map stack" start

    inx
    stx $6156 ; index to top of "map stack" at $616B for 0b10 handler

    rts

    lda $0E ; map width

    clc
    adc $0C
    sta $0C
    bcc B02_AFC9
    inc $0D
; control flow target (from $AFC5, $AFD1)
B02_AFC9:
    rts

    lda $0C
    sec
    sbc $0E ; map width

    sta $0C
    bcs B02_AFC9
    dec $0D
    rts

    pha
    jsr $AFE4
    and #$E0
    sta ($6F),Y
    pla
    ora ($6F),Y
    sta ($6F),Y
    rts

; control flow target (from $AFD7)
    txa
    pha
    lda $0E ; map width

    sta $6F
    lda #$00
    sta $70
    tya
    ldx #$6F
    jsr $B015 ; given A and X, perform 16-bit multiplication: ($00,X-$01,X) = ($00,X-$01,X) * A; A unchanged

    lda #$00
    ldy #$78
    ldx #$6F
    jsr $B00A ; given A, X, and Y, ($00,X-$01,X)  = ($00,X-$01,X) + (Y * $100 + A)

    pla
    ldy #$00
    ldx #$6F
    jsr $B00A ; given A, X, and Y, ($00,X-$01,X)  = ($00,X-$01,X) + (Y * $100 + A)

    ldy #$00
    lda ($6F),Y
    rts

; given A, X, and Y, ($00,X-$01,X)  = ($00,X-$01,X) + (Y * $100 + A)
; control flow target (from $ACB7, $AD70, $AFFA, $B002)
    clc
    adc $00,X
    sta $00,X
    tya
    adc $01,X
    sta $01,X
    rts

; given A and X, perform 16-bit multiplication: ($00,X-$01,X) = ($00,X-$01,X) * A; A unchanged
; control flow target (from $AFF1, $B08A, $B0E7)
    sec
; control flow target (from $B061)
B02_B016:
    sta $7A ; remember original A for later

    lda $0C ; save $0C-$11 on the stack

    pha
    lda $0D
    pha
    lda $0E
    pha
    lda $0F
    pha
    lda $10
    pha
    lda $11
    pha
    txa ; save X on the stack

    pha
    lda $01,X
    sta $0D
    lda $00,X
    sta $0C
    lda #$00
    sta $0F
    lda $7A ; original value of A

    sta $0E
    bcc B02_B063
; call to code in a different bank ($0F:$C339)
    jsr $C339 ; 16-bit multiplication: ($10-$11) = ($0C-$0D) * ($0E-$0F); consumes $0C-$0F

; restore X from stack
    pla
    tax
; copy result to $00,X-$01,X
    lda $10
    sta $00,X
    lda $11
    sta $01,X
; control flow target (from $B074)
    pla ; restore $0C-$11 from the stack

    sta $11
    pla
    sta $10
    pla
    sta $0F
    pla
    sta $0E
    pla
    sta $0D
    pla
    sta $0C
    lda $7A
    rts

; given A and X, perform 16-bit division: ($00,X-$01,X) / A = quotient in ($00,X-$01,X), remainder in A
; control flow target (from $AD51, $AD61)
    clc
    bcc B02_B016
; control flow target (from $B03C)
; call to code in a different bank ($0F:$C360)
B02_B063:
    jsr $C360 ; 16-bit division: ($0C-$0D) / ($0E-$0F) = quotient in ($0C-$0D), remainder in ($10-$11)

; restore X from stack (from $B02A)
    pla
    tax
    lda $0C
; copy quotient to $00,X-$01,X
    sta $00,X
    lda $0D
    sta $01,X
    lda $10
    sta $7A
    jmp $B04B

; read the first 3 bytes of map data, initialize the map width, map height, map buffer index bit width, tile ID bit width and $6158 (unused?); leaves $0C-$0D pointing at map data byte 3
; control flow target (from $ABA6)
    ldy #$00 ; initialize map data read index

    sty $6E ; initialize high byte of multiplicand

    lda ($0C),Y ; map width

    sta $0E ; map width

    sta $6D ; low byte of multiplicand

    jsr $B0C4 ; INC 16-bit $0C-$0D

    lda ($0C),Y ; map height

    sta $0F ; map height

    ldx #$6D
    jsr $B015 ; given A and X, perform 16-bit multiplication: ($00,X-$01,X) = ($00,X-$01,X) * A; A unchanged

    lda $6D ; low byte of map size

    sec
    sbc #$01
    sta $6D
    lda $6E ; high byte of map size

    sbc #$00 ; carry from low byte subtraction

    sta $6E ; $6D-$6E = map size - 1

    ldx #$10 ; $6D-$6E is 16 bits

; control flow target (from $B0A3)
    asl $6D ; ASL 16-bit $6D-$6E

    rol $6E
    bcs B02_B0A6
    dex
    jmp $B09C ; loop until we reach a bit that's set


; control flow target (from $B0A0)
B02_B0A6:
    stx $6150 ; map buffer index bit size

    jsr $B0C4 ; INC 16-bit $0C-$0D

    lda ($0C),Y ; map data byte 2

    tax
    and #$C0
    clc
    rol
    rol
    rol
    adc #$02
    sta $6157 ; map tile ID bit size

    txa
    and #$1F
    sta $6158 ; low 5 bits of map data byte 2 (unused?)

    jsr $B0C4 ; INC 16-bit $0C-$0D

    rts

; INC 16-bit $0C-$0D
; control flow target (from $B081, $B0A9, $B0C0)
    inc $0C
    bne B02_B0CA
    inc $0D
; control flow target (from $B0C6)
B02_B0CA:
    rts

    ldy #$00
; control flow target (from $B10B)
B02_B0CD:
    sty $6F
    lda $051A,Y ; something to do with whether you've opened the chest containing the Shield of Erdrick

    ora $051B,Y
    beq B02_B105
    lda $051B,Y
    sta $6D
    lda #$00
    sta $6E
    ldx #$6D
    lda $21 ; map width

    clc
    adc #$01
    jsr $B015 ; given A and X, perform 16-bit multiplication: ($00,X-$01,X) = ($00,X-$01,X) * A; A unchanged

    lda $6E
    clc
    adc #$78
    sta $6E
    ldy $6F
    lda $051A,Y ; something to do with whether you've opened the chest containing the Shield of Erdrick

    tay
    lda ($6D),Y
    and #$1F
    cmp #$14
    bne B02_B105
    lda ($6D),Y
    and #$E0
    sta ($6D),Y
; control flow target (from $B0D5, $B0FD)
B02_B105:
    ldy $6F
    iny
    iny
    cpy #$10
    bne B02_B0CD
    rts

; indirect control flow target (via $8008)
    lda #$F2
    sta $19
    lda #$F0
    sta $18
; call to code in a different bank ($0F:$DF62)
    jsr $DF62
; call to code in a different bank ($0F:$DE00)
    jsr $DE00
    lda $07
    sta $74
    pha
    and #$1F
    sta $73
    pla
    and #$E0
    sta $72
    lda $08
    pha
    and #$FC
    sta $75
    pla
    and #$03
    lsr
    ror $72
    lsr
    ror $72
    ror $72
    lsr $72
    lsr $72
    rts

; indirect control flow target (via $8002)
    pha ; party leader's direction

    lda #$00
    sta $05F2 ; probably whether door between you and NPC is open

    sta $05F3 ; target NPC sprite ID

    lda $16 ; current map X-pos (1)

    sta $0C ; target NPC's X-pos

    lda $17 ; current map Y-pos (1)

    sta $0E ; target NPC's Y-pos

    pla ; party leader's direction

    bne B02_B161 ; branch if not facing up

    dec $0E ; target NPC is (0, -1) relative to party leader's position

    lda #$02 ; make NPC face down

    jsr $B20C
    dec $13
    jmp $B18A

; control flow target (from $B153)
B02_B161:
    cmp #$01
    bne B02_B171 ; branch if not facing right

    inc $0C ; target NPC is (+1, 0) relative to party leader's position

    lda #$03 ; make NPC face left

    jsr $B20C
    inc $12
    jmp $B18A

; control flow target (from $B163)
B02_B171:
    cmp #$02
    bne B02_B181 ; branch if not facing down

    inc $0E ; target NPC is (0, +1) relative to party leader's position

    lda #$00 ; make NPC face up

    jsr $B20C
    inc $13
    jmp $B18A

; control flow target (from $B173)
B02_B181:
    dec $0C ; party leader is facing left; target NPC is (-1, 0) relative to party leader's position

    lda #$01 ; make NPC face right

    jsr $B20C
    dec $12
; control flow target (from $B15E, $B16E, $B17E, $B287)
    ldy #$00
; control flow target (from $B1A8)
B02_B18C:
    lda $0554,Y ; NPC #$03 X-pos

    cmp $12
    bne B02_B1A1
    lda $0555,Y ; NPC #$03 Y-pos

    cmp $13
    bne B02_B1A1
    lda $0559,Y ; NPC #$03 sprite ID

    cmp #$FF
    bne B02_B1AC
; control flow target (from $B191, $B198)
B02_B1A1:
    tya
    clc
    adc #$08
    tay
    cmp #$A0
    bne B02_B18C
    beq B02_B208
; control flow target (from $B19F)
B02_B1AC:
    lda $0558,Y ; NPC #$03 motion nybble + direction nybble

    and #$F8
    ora $09
    sta $0558,Y ; NPC #$03 motion nybble + direction nybble

    lda $D0 ; Malroth status flag (#$FF = defeated, #$00 = alive, others = countdown to battle)

    bpl B02_B1CF
    lda $31 ; current map ID

    cmp #$03 ; Map ID #$03: Midenhall 1F

    bne B02_B1CF
; call to code in a different bank ($0F:$FEDA)
    jsr $FEDA ; parse byte following JSR for bank and pointer index, set $D6-$D7 to $8000,X-$8001,X in selected bank


; code -> data
; indirect data load target

.byte $49
; data -> code
    lda $D6
    sta $0C
    lda $D7
    sta $0D
    jmp $B1E4

; control flow target (from $B1B8, $B1BE)
B02_B1CF:
    lda $31 ; current map ID

    asl
    tax
    lda a:$50 ; um, okay?

    lda $A539,X ; pointers to per-map NPC setup (X-pos, Y-pos, ???, sprite ID, dialogue [not string] ID)

    sta $0C
    lda $A53A,X
    sta $0D
    ora $0C
    beq B02_B208
; control flow target (from $B1CC)
    tya ; set Y = 5 * Y / 8 + 3

    lsr
    sta $0E ; Y / 2

    lsr
    lsr ; Y / 8

    clc
    adc $0E ; Y / 2 + Y / 8

    clc ; pointless since Y >> 1 + Y >> 3 can't make a carry

    adc #$03
    tay
    lda ($0C),Y
    sta $05F3 ; target NPC sprite ID

    iny
    lda ($0C),Y
; control flow target (from $B20A, $B22E)
B02_B1F9:
    pha ; dialogue ID

; call to code in a different bank ($0F:$C1DC)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

; call to code in a different bank ($0F:$CF5E)
    jsr $CF5E
    pla ; dialogue ID

    sta $0C
    lda $94 ; return bank for various function calls, doubles as index of selected option for multiple-choice menus

; call to code in a different bank ($0F:$C3D5)
    jmp $C3D5 ; save A to $05F6, X to $43, and load bank specified by A


; control flow target (from $B1AA, $B1E2)
B02_B208:
    lda #$00
    beq B02_B1F9
; control flow target (from $B159, $B169, $B179, $B185)
    sta $09
    cmp $0548 ; NPC #$01 ? + direction nybble

    bne B02_B231
    lda $053A
    cmp $0542 ; NPC #$00 ?

    bne B02_B223
    lda $053B
    cmp $0543 ; NPC #$00 ?

    beq B02_B231
; control flow target (from $B219)
B02_B223:
    lda $0549 ; NPC #$01 sprite ID

    cmp #$01
    bne B02_B231
    pla
    pla
    lda #$01
; control flow target (from $B258, $B25E)
B02_B22E:
    jmp $B1F9

; control flow target (from $B211, $B221, $B228)
B02_B231:
    lda $09
    cmp $0550 ; NPC #$02 ? + direction nybble

    bne B02_B260
    tay
    lda $054A ; NPC #$01 scripted motion low byte

    cmp $B28A,Y
    bne B02_B260
    lda $054B ; NPC #$01 scripted motion high byte

    cmp $B28E,Y
    bne B02_B260
    lda $0551 ; NPC #$02 sprite ID

    cmp #$09
    beq B02_B25A
    cmp #$02
    bne B02_B260
    pla
    pla
    lda #$04
    bne B02_B22E
; control flow target (from $B24E)
B02_B25A:
    pla
    pla
    lda #$02
    bne B02_B22E
; control flow target (from $B236, $B23F, $B247, $B252)
B02_B260:
    lda $0C
    pha
    lda $0E
    pha
; call to code in a different bank ($0F:$DF83)
    jsr $DF83
    pla
    sta $13
    pla
    sta $12
    lda $1F ; some kind of map type (#$00: World Map, #$01: other non-dungeon maps, #$02: maps #$2B - #$43 inclusive, #$03: maps >= #$44, #$FF => game menu)

    cmp #$01
    bne B02_B285
    lda $0C
    cmp #$0D
    beq B02_B27F
    cmp #$1A
    bne B02_B285
; control flow target (from $B279)
B02_B27F:
    lda #$FF
    sta $05F2 ; probably whether door between you and NPC is open

    rts

; control flow target (from $B273, $B27D)
B02_B285:
    pla
    pla
    jmp $B18A


; code -> data
; indexed data load target (from $B23C)
; indexed data load target (from $B244)
.byte $80,$70
.byte $80
.byte $90

.byte $7F,$6F
.byte $5F
.byte $6F
; data -> code
; looks like this determines NPC's post-Malroth text
; indirect control flow target (via $8006)
    lda #$02
    sta a:$94 ; return bank for various function calls, doubles as index of selected option for multiple-choice menus

    lda $0C ; save $0C-$0D on the stack

    pha
    lda $0D
    pha
; call to code in a different bank ($0F:$EB76)
    jsr $EB76 ; open menu specified by next byte


; code -> data
; indirect data load target

.byte $04
; data -> code
    pla ; restore $0C-$0D from the stack

    sta $0D
    pla
    sta $0C
    lda $0C ; dialogue ID; just in case it wasn't already in A, clearly :p

    cmp #$45
    beq B02_B2B5 ; #$45, #$46, and #$A6 (Moonbrooke ghosts) all use the same string

    cmp #$46
    beq B02_B2B5
    cmp #$A6
    bne B02_B2B9
; control flow target (from $B2AB, $B2AF)
B02_B2B5:
    lda #$AC ; String ID #$01AC: ‘See a light--that is the pure light of Rubiss rising from the sea[.’][wait][line]‘We thank thee for all that thou hast done[.’][end-FC]

    bne B02_B32D
; control flow target (from $B2B3)
B02_B2B9:
    cmp #$52
    bne B02_B2C1
    lda #$AE ; String ID #$01AE: ‘I apologize for deceiving thee. I am the King of this castle. Ha! Ha!’[end-FC]

    bne B02_B32D
; control flow target (from $B2BB)
B02_B2C1:
    cmp #$B0
    bne B02_B2C9
    lda #$AF ; String ID #$01AF: ‘Thou art strong and noble, [name]. Well done[.’][end-FC]

    bne B02_B32D
; control flow target (from $B2C3)
B02_B2C9:
    cmp #$A1
    bne B02_B2DA
    lda #$01 ; Cannock

; call to code in a different bank ($0F:$FC50)
    jsr $FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

; call to code in a different bank ($0F:$FA2E)
    jsr $FA2E ; display string ID specified by next byte + #$0100


; code -> data
; indirect data load target

.byte $B0
; data -> code
    lda #$BB ; String ID #$01BB: ‘To thy new duties must thou go now, [name][.’][end-FC]

    bne B02_B32D
; control flow target (from $B2CB)
B02_B2DA:
    cmp #$A2
    bne B02_B2E2
    lda #$B1 ; String ID #$01B1: ‘Brother, thou hast done well. I shall never doubt thee again[.’][end-FC]

    bne B02_B32D
; control flow target (from $B2DC)
B02_B2E2:
    cmp #$BC
    bne B02_B2F0
    lda #$00
; call to code in a different bank ($0F:$FC50)
    jsr $FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

; call to code in a different bank ($0F:$FA32)
    jsr $FA32 ; display string ID specified by next byte + #$0200


; code -> data
; indirect data load target

.byte $F2
; data -> code
    rts

; control flow target (from $B2E4)
B02_B2F0:
    cmp #$01
    bne B02_B2FB
    lda #$B3 ; String ID #$01B3: [no voice][name] : [line]‘Thou shalt go[.’][end-FC]

    pha
    lda #$01 ; Cannock

    bne B02_B330
; control flow target (from $B2F2)
B02_B2FB:
    cmp #$02
    bne B02_B306
    lda #$B4 ; String ID #$01B4: [no voice][name] : [line]‘What? I seek not the crown[.’][end-FC]

    pha
    lda #$02 ; Moonbrooke

    bne B02_B330
; control flow target (from $B2FD)
B02_B306:
    ldy $05F3 ; target NPC sprite ID

    lda $B337,Y
    cmp #$AA
    bne B02_B31A
    ldx $31 ; current map ID

    cpx #$03 ; Map ID #$03: Midenhall 1F

    bne B02_B32D ; everybody in Midenhall says the same thing (except for the hidden person blocking your path to the basement)

    lda #$B2 ; String ID #$01B2: ‘Now thou art King of Midenhall and must take thy throne!’[end-FC]

    bne B02_B32D
; control flow target (from $B30E)
B02_B31A:
    cmp #$FF
    bne B02_B32D
    lda $0D
    ldy #$05
; control flow target (from $B328)
B02_B322:
    cmp $B345,Y
    beq B02_B32A
    dey
    bpl B02_B322
; control flow target (from $B325)
B02_B32A:
    lda $B34B,Y
; control flow target (from $B2B7, $B2BF, $B2C7, $B2D8, $B2E0, $B314, $B318, $B31C)
B02_B32D:
    pha
    lda #$00
; control flow target (from $B2F9, $B304)
; call to code in a different bank ($0F:$FC50)
B02_B330:
    jsr $FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    pla
; call to code in a different bank ($0F:$FA4E)
    jmp $FA4E ; display string ID specified by A + #$0100



; code -> data
; indexed data load target (from $B309)
; indexed data load target (from $B322)
.byte $00,$B3,$B4,$49,$00,$FF,$A4
.byte $A7,$A6,$AB,$AA
.byte $A4,$A5
.byte $00
; indexed data load target (from $B32A)
.byte $03,$07,$0B
.byte $0F,$13
.byte $2B
; looks like more NPC data?
.byte $00,$00,$AD
.byte $A9,$A8
.byte $00
; from $02:$B1C3, $0F:$E4EF, $0F:$E4FB via $8012
; indirect data load target (via $8012)
; indirect data load target
.byte $0F,$02,$02,$03,$00,$0F,$06,$03,$FF,$01,$0F,$06,$01,$FF,$02,$0F
.byte $02,$02,$FF,$00,$0E,$03,$02,$0A,$03,$10,$03,$02,$0A,$03,$0D,$04
.byte $01,$0A,$03,$11,$04,$03,$0A,$03,$0D,$06,$01,$0A,$03,$0D,$08,$01
.byte $0A,$03,$11,$06,$03,$0A,$03,$11,$08
.byte $03,$0A,$03,$15
.byte $05,$00
.byte $03
.byte $00

.byte $FF
; data -> code
; read the next string byte; preserves X and Y
; from $BE03 via $8004
; indirect control flow target (via $8004)
    txa
    pha
    tya
    pha
    jsr $B3A1 ; read the next string byte

    pla
    tay
    pla
    tax
    lda $6D
    rts

; read the next string byte
; control flow target (from $B397)
    lda $60D2 ; read index within current dictionary entry

    bne B02_B3AB ; if we're starting to read a new dictionary entry, reset the secondary text table offset

    lda #$00
    sta $60D3 ; secondary text table offset for C0 - C3 tables

; control flow target (from $B3A4, $B3C9, $B3E6)
; call to code in a different bank ($0F:$FE34)
B02_B3AB:
    jsr $FE34 ; swap in the right text bank, set A to the current dictionary index, swap in bank #$02

    jsr $B3F6 ; given a dictionary index in A, set $6F-$70 to the address of the corresponding dictionary entry

    lda $608B ; text engine: $608B = dictionary index

    jsr $B42D ; given dictionary index in A, set A to length of that dictionary entry

    cmp $60D2 ; read index within current dictionary entry

    beq B02_B3BE ; if read index == dictionary entry length, we finished with this entry last time, so reset temp vars, update read vars, and start reading the next entry

    bcs B02_B3CC ; if read index < dictionary entry length, process current dictionary byte

; control flow target (from $B3BA)
B02_B3BE:
    lda #$00
    sta $60D2 ; read index within current dictionary entry

    sta $60D3 ; secondary text table offset for C0 - C3 tables

; call to code in a different bank ($0F:$FDF7)
    jsr $FDF7 ; after reading a text token, update the read address in $55-$56 and bit index in $60D6

    jmp $B3AB ; loop to read the next byte of dictionary entry


; process current dictionary byte (update secondary text table offset if switch token, increment dictionary read index and return current byte otherwise)
; control flow target (from $B3BC)
B02_B3CC:
    ldy $60D2 ; read index within current dictionary entry

    lda ($6F),Y ; read the current byte of the current dictionary entry

    cmp #$C0 ; BUG: dictionary values #$C0 - #$CF are treated as table switches, but the offset data only covers #$C0 - #$C4 (and the game only uses #$C0 - #$C3)

    bcc B02_B3E9 ; if not a switch token, increment read index and return current byte of dictionary entry

    cmp #$D0
    bcs B02_B3E9 ; if not a switch token, increment read index and return current byte of dictionary entry

    sec
    sbc #$C0 ; normalize value to index; could have saved 3 bytes by doing "LDA $B331,Y" instead

    tay
    lda $B3F1,Y ; secondary text table offsets for C0 - C3 tables

    sta $60D3 ; secondary text table offset for C0 - C3 tables

; call to code in a different bank ($0F:$FDF7)
    jsr $FDF7 ; after reading a text token, update the read address in $55-$56 and bit index in $60D6

    jmp $B3AB ; loop to read the next byte of dictionary entry


; if not a switch token, increment read index and return current byte of dictionary entry
; control flow target (from $B3D3, $B3D7)
B02_B3E9:
    inc $60D2 ; read index within current dictionary entry

    lda ($6F),Y ; re-read the current byte of the current dictionary entry (... but it's already in A)

    sta $6D ; stash in $6D since caller needs to pop stuff off the stack

    rts


; code -> data
; secondary text table offsets for C0 - C3 tables
; indexed data load target (from $B3DD)

.byte $20,$40,$60
.byte $80
.byte $A0
; data -> code
; given a dictionary index in A, set $6F-$70 to the address of the corresponding dictionary entry
; control flow target (from $B3AE)
    tay ; Y = A = dictionary index

    lda $60D2 ; read index within current dictionary entry

    bne B02_B420 ; copy dictionary entry pointer to $6F-$70; if read index > 0, we've already done set up, so skip ahead

    lda $B42B ; pointer to dictionary entries

    sta $60D4 ; low byte of pointer to current dictionary entry

    lda $B42C
    sta $60D5 ; high byte of pointer to current dictionary entry

; dictionary entry pointer += length of the Y-th dictionary entry
; control flow target (from $B41D)
    dey
    cpy #$FF ; Y == #$FF => Y was #$00 => we're done updating the dictionary entry pointer

    beq B02_B420 ; copy dictionary entry pointer to $6F-$70

    tya
    jsr $B42D ; given dictionary index in A, set A to length of that dictionary entry

    clc
    adc $60D4 ; low byte of pointer to current dictionary entry

    sta $60D4 ; low byte of pointer to current dictionary entry

    bcc B02_B41D
    inc $60D5 ; high byte of pointer to current dictionary entry

; control flow target (from $B418)
B02_B41D:
    jmp $B408 ; dictionary entry pointer += length of the Y-th dictionary entry


; copy dictionary entry pointer to $6F-$70
; control flow target (from $B3FA, $B40B)
B02_B420:
    lda $60D4 ; low byte of pointer to current dictionary entry

    sta $6F
    lda $60D5 ; high byte of pointer to current dictionary entry

    sta $70
    rts


; code -> data
; pointer to dictionary entries
; data load target (from $B3FC)
; data load target (from $B402)
.byte $8B

.byte $B4
; data -> code
; given dictionary index in A, set A to length of that dictionary entry
; control flow target (from $B3B4, $B40E)
    lsr ; 2 lengths per byte; C will say which length we want

    tax
    lda $B43B,X ; dictionary entry lengths, 1 nybble each

    bcs B02_B438 ; if C set (dictionary index was odd), we want the low byte, otherwise the high byte

    lsr
    lsr
    lsr
    lsr
; control flow target (from $B432)
B02_B438:
    and #$0F
    rts


; code -> data
; dictionary entry lengths, 1 nybble each
; indexed data load target (from $B42F)
; dictionary entries
.byte $12,$52,$11,$11,$11,$11,$11,$11,$11,$11,$11,$11,$11,$11,$11,$11
.byte $11,$21,$11,$11,$11,$41,$A1,$11,$46,$11,$11,$F1,$11,$18,$11,$11
.byte $11,$31,$12,$11,$11,$11,$11,$11,$11,$12,$11,$11,$11,$11,$11,$11
.byte $94,$94,$44,$95,$55,$33,$47,$57,$55,$33,$68,$35,$84,$86,$75,$35
.byte $86,$74,$78,$56,$37,$E3,$44,$43
.byte $33,$33,$44,$AF
.byte $33,$2A
.byte $34
.byte $64

; indirect data load target (via $B42B)

.byte $FC,$6B,$FC,$6E,$66,$FD,$FD,$FC,$68,$FC,$FF,$22,$0C,$18,$0D,$0E
.byte $0F,$10,$11,$12,$13,$5F,$15,$16,$17,$FE,$68
.byte $65,$1B,$1C,$1D,$1E,$0A
.byte $20,$C0,$C1
.byte $C2
.byte $C3
; C0 table

.byte $24,$25,$26,$0A,$27,$28,$29,$2A,$2B,$2C,$2D,$2E,$12,$17,$10,$2F
.byte $30,$18,$18,$17,$0B,$1B,$18,$18,$14,$0E,$31,$32,$F7,$37,$11,$0E
.byte $5F,$35,$11,$18,$17,$0E,$5F,$36,$70,$38,$62,$3A,$0A,$1D,$0E,$1B
.byte $5F,$29,$15,$22,$12,$17,$10,$5F,$26,$15,$26,$3C,$3D
.byte $21,$39,$12,$15,$15,$0A,$10
.byte $0E,$5F,$23
.byte $F9,$64
.byte $2E
; C1 table

.byte $1F,$1A,$66,$FB,$FE,$35,$6B,$FD,$FD,$33,$0B,$37,$6F,$5A,$5B,$5C
.byte $3A,$14,$19,$6E,$69,$F4,$75,$75,$74,$67
.byte $6A,$66,$F6,$F3,$60
.byte $FB,$30,$F8
.byte $F5
.byte $FD
; C2 table

.byte $37,$11,$18,$1E,$5F,$11,$0A,$1C,$1D,$11,$0E,$1C,$1D,$30,$12,$0D
.byte $0E,$17,$11,$0A,$15,$15,$11,$18,$1E,$5F,$5F,$18,$0F,$5F,$5F,$12
.byte $1C,$5F,$5F,$1D,$11,$18,$1E,$5F,$11,$0A,$1C,$5F,$0A,$17,$0D,$5F
.byte $1D,$18,$5F,$1D,$11,$5F,$1D,$11,$0E,$0E,$0A,$1C,$1D,$5F,$0D,$18
.byte $11,$0A,$1D,$5F,$5F,$1C,$11,$0A,$15,$15,$5F,$5F,$20,$0A,$1C,$5F
.byte $11,$18,$1E,$5F,$11,$0A,$1C,$0D,$5F,$1D,$11,$0E,$5F,$11,$0A,$1C
.byte $5F,$10,$18,$17,$6B,$FB,$FE,$5F,$11,$0A,$1F,$0E,$5F,$0C,$18,$16
.byte $0E,$5F,$1D,$18,$5F,$12,$17,$10,$5F,$11,$0A,$1C,$1D,$18,$1C,$1D
.byte $5F,$1D,$11,$18,$1E,$1D,$11,$12,$1C,$5F,$18,$0F,$5F,$1D,$11,$0E
.byte $5F,$2B,$0A,$1B,$10,$18,$17,$12,$17,$5F,$1D,$11,$0E,$5F
.byte $1D,$11,$12,$17,$10,$11,$0E
.byte $5F,$5F,$20
.byte $12,$1D
.byte $11
; C3 table

.byte $1B,$0E,$0A,$1C,$1E,$1B,$0E,$5F,$65,$2B,$0A,$1C,$1D,$5F,$28,$1B
.byte $0D,$1B,$12,$0C,$14,$0C,$18,$16,$0E,$0E,$1B,$0E,$5F,$12,$1C,$5F
.byte $3A,$0E,$15,$0C,$18,$16,$0E,$5F,$1B,$12,$17,$0C,$0E,$5F,$10,$1B
.byte $0E,$0A,$1D,$0A,$1B,$1B,$5F,$0F,$18,$1B,$5F,$1D,$11,$19,$12,$0E
.byte $0C,$0E,$F2,$5F,$18,$0F,$5F,$10,$18,$15,$0D,$68,$FB,$FE,$25,$1E
.byte $1D,$5F,$11,$0E,$1B,$0E,$0C,$0A,$17,$5F,$18,$1F,$0E,$11,$0E,$0E
.byte $17,$18,$1D,$0F,$18,$1B,$18,$17,$0E,$5F,$0A,$17,$22,$5F,$1D,$18
.byte $5F,$0D,$0E,$1C,$0C,$0E,$17,$0D,$0A,$17,$1D,$35,$18,$10,$0E,$5F
.byte $29,$0A,$1C,$1D,$0F,$12,$17,$10,$0E,$1B,$0A,$15,$15,$1D,$11,$22
.byte $65,$3A,$1D,$11,$0A,$17,$14,$5F,$1D,$11,$0E,$0E,$5F,$12,$1D
.byte $5F,$1D,$11,$0A,$5F,$1D,$11
.byte $18,$1E,$5F,$5F
.byte $1D,$11
.byte $0E
; data -> code
; CLC if end of word, SEC otherwise
; from $0F:$FB4D, $0F:$FB7D, $0F:$FBD9 via $800A
; indirect control flow target (via $800A)
    cmp #$FA
    bcs B02_B685 ; CLC to indicate end of word; any control code >= #$FA counts as a word ender

    cmp #$60 ; [no voice]

    beq B02_B685 ; CLC to indicate end of word

    cmp #$5F ; [space]

    beq B02_B685 ; CLC to indicate end of word

    sec ; SEC to indicate not end of word

    rts

; CLC to indicate end of word
; control flow target (from $B679, $B67D, $B681)
B02_B685:
    clc
    rts

; if menu current column < #$16, CLC and RTS, otherwise do stuff
; from $0F:$FB61, $0F:$FD40 via $800E
; indirect control flow target (via $800E)
    lda $609E ; menu current column

    cmp #$16 ; width of dialogue box

    bcs B02_B698
    rts

; handler for control code #$FD
; from $0F:$FBAB via $8000
; indirect control flow target (via $8000)
    jsr $B6BA ; set menu current column to $7C

    jmp $B69D

; from $0F:$FB9E, $0F:$FBA6, $0F:$FBB0 via $800C
; indirect control flow target (via $800C)
    jsr $B6BA ; set menu current column to $7C

; control flow target (from $B68C)
B02_B698:
    cmp $60C8 ; speech sound effect / auto-indent flag

    beq B02_B6B9
; control flow target (from $B692)
    ldx $7D
    inx
    cpx #$08 ; height of dialogue box

    bcs B02_B6C0
; control flow target (from $B6C2)
B02_B6A4:
    lda $60C7
    lsr
    lsr
    eor #$03
    clc
    adc $7D
    sta $7D
; control flow target (from $B6E5)
B02_B6B0:
    lda $60C8 ; speech sound effect / auto-indent flag

    sta $609E ; menu current column

    sta $7C
    clc
; control flow target (from $B69B)
B02_B6B9:
    rts

; set menu current column to $7C
; control flow target (from $B68F, $B695)
    lda $7C
    sta $609E ; menu current column

    rts

; control flow target (from $B6A2)
B02_B6C0:
    lda $8E ; flag for in battle or not (#$FF)?

    bmi B02_B6A4
    jsr $B6E7
    lda $60C7
    cmp #$04
    bne B02_B6D1
    jsr $B6E7
; control flow target (from $B6CC)
B02_B6D1:
    lda #$13
    sta $6084
    lda #$00
    sta $6085
; control flow target (from $B6E3)
; call to code in a different bank ($0F:$FCFF)
B02_B6DB:
    jsr $FCFF
    lda $6084
    cmp #$1B
    bcc B02_B6DB
    bcs B02_B6B0
; control flow target (from $B6C4, $B6CE)
    ldx #$00
; control flow target (from $B703)
B02_B6E9:
    lda $070E,X
    and #$7F
    cmp #$76
    bcs B02_B700
    pha
    lda $06F8,X ; start of main dialogue window

    and #$7F
    cmp #$76
    pla
    bcs B02_B700
    sta $06F8,X ; start of main dialogue window

; control flow target (from $B6F0, $B6FB)
B02_B700:
    inx
    cpx #$9A
    bne B02_B6E9
    lda #$5F
; control flow target (from $B70D)
B02_B707:
    sta $06F8,X ; start of main dialogue window

    inx
    cpx #$B0
    bne B02_B707
    rts

; from $0F:$FBA2 via $8010
; indirect control flow target (via $8010)
    lda #$0F
    sta $03 ; game clock?

; control flow target (from $B721)
B02_B714:
    jsr $B730
; call to code in a different bank ($0F:$C1DC)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

; call to code in a different bank ($0F:$C476)
    jsr $C476 ; read joypad 1 data into $2F

    lda $2F ; joypad 1 data

    and #$F3 ; ignore Start/Select

    beq B02_B714
    jsr $B73A
    lda #$85 ; Music ID #$85: single beep SFX

; call to code in a different bank ($0F:$C561)
    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    lda #$02
    sta $7C
    rts

; control flow target (from $B714)
    ldx #$73
    lda $03 ; game clock?

    and #$1F
    cmp #$10
    bcs B02_B73C
; control flow target (from $B723)
    ldx #$5F
; control flow target (from $B738)
B02_B73C:
    stx $09
    lda #$10
    sta $608B
    lda $7D
    clc
    adc #$13
    sta $608C
; call to code in a different bank ($0F:$FE97)
    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $C1
; data -> code
; call to code in a different bank ($0F:$C1FA)
    jmp $C1FA ; wait for $02 to not be #$C0, write PPU address in $07-$08 and data in $09 to PPU write buffer at $0300,$02, $01 += 1, $02 += 3, and set $0183 to #$00



; code -> data
; -> $05:$8000: main script strings, part 1
; main script pointer table, targets in bank 5
; external indexed data load target (from $0F:$FA9A)
; external indexed data load target (from $0F:$FA9F)
.byte $00
; main script pointer table, targets in bank 2
.byte $80,$B3,$80,$77,$81,$9B,$82,$D6,$83,$20,$85,$28,$86,$0D,$88,$EF
.byte $8C,$F0,$8E,$FA,$8E,$04,$8F,$0E,$8F,$18,$8F,$22,$8F,$2C,$8F,$36
.byte $8F,$3F,$90,$43,$91,$9C,$92,$F9,$93,$1E,$95,$AB,$96,$EF,$97,$41
.byte $99,$DC,$9A,$0B,$9D,$94,$9E,$51,$A0,$5B,$A0,$65,$A0,$6F,$A0,$79
.byte $A0,$AF,$A2,$7E,$A6,$78,$A9,$4A,$AC,$17,$AF,$23,$B1,$EF
.byte $B2,$3E,$B5,$61,$B7,$4F,$B9
.byte $C3,$BB,$DA
.byte $BD,$AE
.byte $BF
; main script part 2; $B7B2-$B97D is overflow from bank 5
.byte $7E,$B9
.byte $97
.byte $BB
; external indirect data load target (via $0F:$FE32)
; indirect data load target
; main script strings #$02E0 - #$02EF
.byte $DF,$B4,$EB,$A0,$4D,$BB,$17,$F4,$F9,$C3,$E2,$57,$C0,$E7,$8F,$9D
.byte $7C,$1E,$09,$97,$D7,$FD,$36,$10,$FF,$98,$98,$75,$EF,$8A,$45,$5E
.byte $18,$E7,$47,$62,$F5,$9C,$E8,$E9,$27,$C0,$42,$0F,$E2,$1F,$F7,$61
.byte $30,$87,$93,$E2,$E3,$CC,$C7,$BD,$03,$9E,$3E,$76,$35,$D7,$26,$4F
.byte $E9,$CA,$FB,$9E,$29,$FC,$DF,$B6,$1D,$F7,$8A,$61,$04,$A1,$F0,$6F
.byte $5C,$97,$A9,$B7,$60,$EB,$D4,$33,$58,$ED,$6E,$FC,$1C,$EF,$E9,$F4
.byte $8E,$92,$7D,$6A,$5E,$63,$E6,$08,$7B,$13,$0E,$BD,$E9,$D1,$98,$F3
.byte $E1,$89,$B0,$EB,$C0,$33,$B1,$7D,$CF,$E3,$3D,$47,$CC,$90,$F8,$95
.byte $F0,$39,$E3,$D8,$F8,$F8,$F7,$B8,$34,$EF,$B5,$BB,$F9,$8D,$5A,$5D
.byte $8B,$F0,$73,$FD,$75,$E2,$3C,$DD,$A7,$5D,$02,$7C,$97,$E9,$FC,$B1
.byte $F0,$CE,$C5,$FD,$3E,$71,$FE,$3F,$6D,$84,$1F,$8D,$75,$C9,$7E,$1B
.byte $14,$FD,$75,$E9,$A0,$9D,$5D,$2F,$F8,$DF,$D3,$E8,$DD,$73,$DB,$27
.byte $E9,$E8,$D1,$5E,$7B,$3E,$E7,$1D,$79,$23,$DA,$C5,$E9,$27,$C4,$3D
.byte $9A,$E8,$13,$2E,$D7,$0F,$53,$64,$DB,$B1,$28,$FF,$1E,$54,$E3,$A4
.byte $9F,$4D,$04,$EA,$E9,$7F,$4E,$97,$F5,$FA,$C3,$53,$2C,$0E,$BC,$3A
.byte $61,$03,$F4,$93,$E2,$3B,$5E,$81,$2F,$76,$6F,$87,$A9,$B2,$6D,$D8
.byte $94,$7D,$75,$E4,$92,$9F,$F7,$1F,$FB,$FA,$FF,$9A,$F7,$7E,$D3,$AB
.byte $5D,$FE,$C8,$EB,$CB,$E6,$D7,$4D,$FB,$17,$F1,$0F,$D4,$5E,$A3,$E6
.byte $48,$EA,$7A,$2A,$F3,$09,$BF,$62,$FE,$21,$FA,$8B,$FF,$7F,$1F,$ED
.byte $F1,$71,$EF,$6F,$58,$4D,$97,$AC,$25,$FD,$72,$4A,$3E,$EE,$BF,$66
.byte $3C,$36,$79,$4F,$8E,$A4,$57,$FB,$B7,$E9,$27,$C9,$25,$2F,$8A,$5F
.byte $A5,$E9,$B2,$7C,$35,$84,$D8,$75,$E2,$3B,$58,$BE,$E7,$B5,$8B,$C9
.byte $BF,$88,$7E,$DB,$08,$3F,$F1,$F2,$FF,$DC,$7E,$91,$3D,$92,$3A,$F2
.byte $47,$F1,$B0,$F6,$27,$56,$43,$F5,$D3,$9F,$38,$7C,$4A,$FD,$EA,$C9
.byte $BF,$D7,$5E,$01,$FD,$3B,$70,$F4,$F3,$5D,$7A,$65,$76,$F4,$09,$EC
.byte $5F,$1D,$17,$A7,$4F,$62,$FE,$9F,$38,$7D,$F2,$66,$3D,$4D,$92,$5E
.byte $6B,$69,$58,$BC,$75,$2B,$B1,$BD,$7F,$53,$3E,$B5,$B0,$87,$FD,$8D
.byte $75,$C9,$FF,$05,$5E,$A1,$30,$83,$E4,$7E,$9C,$E8,$2F,$FB
.byte $87,$F1,$1E,$A5,$CF,$04,$7F
.byte $94,$EE,$C0,$0E
.byte $EC,$00
.byte $00
; indirect data load target (via $B7AE)
; main script strings #$02F0 - #$02FF
.byte $AF,$00,$CE,$C5,$FD,$EF,$53,$DB,$82,$BC,$43,$EE,$94,$FF,$B8,$F1
.byte $B0,$F5,$68,$C9,$43,$E3,$A9,$15,$E8,$D4,$96,$9B,$5F,$C7,$C7,$BC
.byte $BB,$27,$58,$4D,$F0,$F8,$35,$2F,$D3,$13,$A4,$0F,$FA,$4C,$3E,$3E
.byte $C5,$FD,$EF,$53,$DB,$F7,$60,$AF,$20,$A3,$9E,$1D,$AD,$DE,$AD,$42
.byte $E9,$7F,$5F,$AB,$69,$0D,$BA,$5F,$7C,$B7,$09,$F4,$12,$FE,$9D,$38
.byte $C2,$6D,$F5,$D7,$A8,$F0,$EE,$CF,$E1,$F6,$4A,$EC,$9C,$3E,$29,$42
.byte $21,$EB,$3D,$B2,$7F,$B7,$DA,$DD,$FA,$52,$B4,$DB,$5C,$7F,$D3,$0E
.byte $FF,$8E,$EF,$63,$70,$C4,$DB,$F5,$43,$6F,$8C,$DB,$A7,$FF,$DF,$C3
.byte $59,$3A,$C3,$FD,$BE,$C3,$A2,$AF,$07,$EC,$3F,$AE,$91,$F6,$FD,$B0
.byte $EF,$E2,$1F,$A8,$8A,$BC,$96,$4C,$C7,$EB,$28,$D1,$9B,$82,$F8,$B9
.byte $97,$E4,$B6,$F4,$1A,$E9,$E0,$9E,$A7,$B7,$05,$7A,$86,$26,$4F,$E2
.byte $3C,$DC,$27,$46,$67,$FE,$FE,$BE,$C7,$EB,$D3,$67,$D9,$37,$EB,$D2
.byte $6C,$75,$3D,$B8,$2B,$C9,$1F,$C6,$C3,$FA,$FB,$7D,$F2,$7E,$9F,$16
.byte $AD,$98,$2B,$F7,$F4,$34,$F6,$EC,$5F,$16,$AD,$98,$6A,$6C,$F4,$F4
.byte $09,$97,$FB,$27,$FB,$7F,$FB,$F8,$6B,$27,$58,$FA,$EB,$F6,$63,$ED
.byte $F1,$7F,$37,$A7,$A0,$4C,$BE,$74,$DB,$FD,$93,$F8,$8E,$C5,$FA,$7D
.byte $CF,$63,$26,$C9,$B7,$89,$8F,$7B,$92,$66,$90,$7D,$E1,$B1,$4F,$63
.byte $DD,$CF,$4F,$E9,$D3,$EB,$78,$9D,$7E,$6C,$97,$C7,$50,$69,$93,$FE
.byte $E1,$F2,$FC,$FC,$DF,$BE,$DF,$1F,$D7,$5E,$21,$F7,$4C,$BD,$04,$BE
.byte $47,$DF,$EB,$14,$A7,$0F,$EF,$35,$0B,$1F,$0C,$EA,$7B,$70,$77,$75
.byte $F0,$1E,$84,$C1,$BD,$02,$6C,$9F,$41,$FB,$3D,$A0,$87,$AA,$C7,$8B
.byte $FB,$CD,$42,$C7,$C3,$3B,$5B,$BD,$3D,$03,$61,$F5,$D7,$86,$B2,$75
.byte $8F,$17,$1E,$F7,$40,$D3,$60,$F6,$2F,$8E,$BB,$27,$58,$4D,$BF,$F7
.byte $D9,$3B,$D5,$91,$7F,$AE,$BC,$47,$62,$FE,$8F,$3D,$3B,$6F,$7E,$C7
.byte $D4,$DE,$B0,$66,$25,$0F,$FE,$5F,$7C,$5B,$2B,$5C,$13,$7F,$1F,$88
.byte $7E,$A2,$FE,$BE,$C7,$CA,$3C,$4C,$7E,$03,$EE,$EB,$C3,$1D,$F2,$3E
.byte $FA,$9E,$DC,$1F,$D2,$61,$F1,$F6,$2F,$EF,$7E,$BA,$F0,$10,$87,$FB
.byte $87,$FB,$6F,$C3,$2C,$9D,$61,$32,$BF,$EB,$8D,$75,$C9,$F1,$6C,$9F
.byte $E0,$AF,$8B,$64,$9E,$C5,$FF,$93,$F8,$87,$EA,$3F,$FB,$D7,$6D,$49
.byte $17,$3C,$BC,$4C,$7B,$DC,$1D,$B5,$E9,$40,$F6,$47,$D7,$5E,$0D,$2A
.byte $4E,$B0,$FF,$6F,$C7,$E2,$1F,$B6,$C2,$0F,$5B,$7A,$04,$F9,$2F,$D2
.byte $3A,$06,$99,$3D,$24,$FA,$D6,$C2,$1F,$F2,$0E,$FF,$64,$55,$E9,$A0
.byte $9D,$5D,$2F,$59,$DF,$86,$58,$F9,$5B,$07,$FD,$26,$1F
.byte $1B,$FA,$7D,$1B,$AE,$EA
.byte $7B,$7E,$EC
.byte $00,$00
.byte $00
; indirect data load target (via $B7B0)

.byte $AF,$1D,$23,$27,$C6,$C7,$FE,$F5,$37,$A0,$4B,$CD,$64,$DF,$17,$EC
.byte $5F,$74,$A7,$AE,$79,$F3,$8F,$FD,$EB,$39,$D0,$FD,$B7,$9C,$D5,$91
.byte $D8,$BF,$A3,$CF,$4E,$DB,$DF,$B1,$EE,$E7,$B6,$1D,$E8,$DA,$61,$0B
.byte $BF,$DC,$42,$7A,$FC,$32,$FE,$26,$3D,$EB,$A7,$4F,$B9,$F3,$86,$78
.byte $9E,$10,$EB,$D4,$78,$7A,$B6,$1F,$7C,$D9,$30,$2B,$E2,$DB,$DF,$D6
.byte $7F,$F2,$FE,$9E,$DA,$6C,$BA,$49,$FD,$8D,$C7,$8B,$9E,$BF,$F5,$C7
.byte $E0,$3A,$F8,$1E,$5C,$92,$FD,$A6,$10,$EC,$5F,$DE,$FD,$75,$E2,$D3
.byte $87,$F4,$E5,$F4,$93,$77,$F4,$E9,$7F,$4E,$5F,$49,$37,$F1,$F6,$9F
.byte $37,$A7,$4B,$D5,$66,$A6,$48,$B8,$EB,$C4,$63,$C5,$46,$A4,$B4,$D8
.byte $F9,$BF,$EB,$8B,$27,$48,$7D,$CF,$14,$BE,$C7,$D2,$2E,$FD,$43,$F3
.byte $1D,$79,$0E,$2B,$C4,$E0,$A5,$23,$9B,$AE,$F4,$60,$95,$61,$E7,$B2
.byte $13,$6B,$FF,$B8,$7C,$BF,$3F,$37,$AF,$D5,$EE,$FD,$43,$F3,$1D,$79
.byte $0B,$27,$50,$7F,$ED,$E2,$7C,$4F,$37,$D0,$D4,$DD,$FA,$7E,$0F,$D7
.byte $26,$5F,$AF,$5F,$6F,$BD,$EC,$6D,$DE,$C4,$D9,$B8,$D2,$D3,$F5,$D7
.byte $8D,$3E,$DF,$D3,$A5,$E7,$52,$BD,$FF,$27,$B1,$7B,$63,$D7,$9E,$F8
.byte $4D,$87,$5E,$23,$D4,$E9,$D2,$99,$3F,$7A,$6E,$3D,$6F,$A5,$29,$FD
.byte $7E,$3F,$AE,$BC,$43,$F6,$D8,$41,$F8,$B6,$90,$9F,$FD,$FC,$3A,$61
.byte $14,$E3,$C4,$F8,$BE,$94,$BF,$07,$EB,$93,$2F,$F8,$DF,$43,$53,$71
.byte $D7,$C0,$7C,$8E,$F5,$66,$D8,$62,$6C,$FE,$9F,$37,$6C,$93,$7B,$BF
.byte $ED,$E9,$1F,$C3,$1C,$75,$E1,$3A,$04,$C9,$FF,$6F,$FD,$F7,$59,$26
.byte $3D,$90,$FF,$E5,$E8,$4A,$51,$77,$FB,$9C,$44,$7A,$F4,$D9,$BA,$83
.byte $F9,$23,$58,$F0,$85,$FC,$4E,$1C,$F2,$3D,$A9,$DD,$83,$BB,$AF,$46
.byte $9C,$66,$D2,$7E,$D8,$99,$3D,$B2,$7C,$92,$94,$0E,$BD,$E6,$8B,$FF
.byte $BE,$0D,$5B,$30,$FB,$B1,$B2,$4B,$F3,$D7,$9E,$5E,$4F,$62,$FE,$F6
.byte $9D,$28,$3B,$BA,$F0,$C7,$7C,$8F,$BE,$C5,$FD,$E8,$EB,$C6,$FE,$7E
.byte $6F,$5F,$AB,$DD,$F9,$96,$1B,$07,$E9,$A8,$F4,$7A,$74,$A6,$4F,$B2
.byte $64,$84,$D9,$28,$FD,$71,$EF,$74,$DF,$35,$EF,$E2,$71,$83,$E2,$1E
.byte $C4,$EA,$CF,$D3,$E2,$7B,$63,$50,$7F,$40,$76,$99,$2F,$37,$F1,$EB
.byte $3E,$29,$F4,$EB,$C0,$33,$B1,$7E,$19,$64,$A5,$FF,$B5,$FC,$4F,$8B
.byte $EB,$AF,$30,$9B,$F6,$2F,$E2,$3C,$D6,$26,$1D,$7F,$93,$F5,$D7,$88
.byte $7E,$A2,$FE,$8F,$3D,$3B,$6F,$7E,$C5,$FA,$93,$F8,$49,$19,$9A,$96
.byte $13,$6E,$C7,$C7,$81,$E4,$B7,$E9,$67,$7F,$10,$FE,$BE,$C7,$8B,$6E
.byte $94,$3F,$E2,$FD,$58,$98,$75,$EF,$DB,$13,$2F,$FD,$F8,$6C,$52,$F3
.byte $6A,$29,$FA,$EB,$C6,$9F,$7E,$2E,$3D,$EC,$36,$29,$FA,$EB,$D1,$A4
.byte $C9,$6F,$40,$97,$C8,$FB,$7C,$4A,$F3,$33,$56,$8F,$8F,$12,$BE,$FD
.byte $7A,$61,$0F,$13,$AF,$B1,$F0,$93,$61,$A7,$90,$F8,$5B,$1E,$2F,$B9
.byte $E2,$9D,$FD,$AF,$F8,$EE,$FD,$3F,$A7,$4E,$B3,$86,$AB,$30,$7F,$40
.byte $76,$99,$21,$AF,$01,$0D,$E8,$B7,$F3,$78,$87,$EF,$58
.byte $33,$1F,$F7,$DB,$C9,$E9
.byte $1F,$C6,$9F
.byte $6F,$59
.byte $C6
; data -> code
; read the next text token and interpolate any variable control codes; SEC to trigger read of [end-FA]-terminated string from $60F1, CLC to use A
; from $0F:$FBF7 via $8014
; indirect control flow target (via $8014)
; call to code in a different bank ($0F:$FE97)
    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $42
; data -> code
    cmp #$F3 ; "[monster(s)]"

    beq B02_BE2C ; given monster count in $8F singular monster name in $6119, and monster name length in X, print appropriate singluar/plural monster name to $60F1

    cmp #$F4 ; "[cardinal #]"

    beq B02_BE31 ; given monster count in $8F, print corresponding cardinal number to $60F1

    cmp #$F5 ; "[number]"

    beq B02_BE39 ; print the number stored at $8F-$90 to $60F1 in decimal

    cmp #$F8 ; "[name]"

    beq B02_BE29 ; copy $6119,X to $60F1,X until we read a #$FA

    cmp #$F7 ; "[item]"

    beq B02_BE63 ; print name of item ID in $95 to $60F1

    cmp #$F9 ; "[item-F9]" used for getting random direction by crazy fortuneteller and for printing some names of crests

    beq B02_BE26 ; copy [end-FA]-terminated string from $5A to $60F1

    cmp #$F2 ; "[(s)]"

    beq B02_BE34 ; if $8F-$90 == #$0001, print "s" + [end-FA] to $60F1 and SEC, else LDA [end-FA] and CLC

    cmp #$F6 ; "[spell]"

    beq B02_BE9A ; given spell ID in $95, print spell name to $60F1

    clc ; SEC to trigger read of [end-FA]-terminated string from $60F1, CLC to use A

    rts

; copy [end-FA]-terminated string from $5A to $60F1
; control flow target (from $BE1A)
B02_BE26:
    jmp $BEAE ; copy [end-FA]-terminated string from $5A to $60F1


; copy $6119,X to $60F1,X until we read a #$FA
; control flow target (from $BE12)
B02_BE29:
    jmp $BEBC ; copy $6119,X to $60F1,X until we read a #$FA


; given monster count in $8F singular monster name in $6119, and monster name length in X, print appropriate singluar/plural monster name to $60F1
; control flow target (from $BE06)
; call to code in a different bank ($0F:$FE97)
B02_BE2C:
    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $E2
; data -> code
    rts

; given monster count in $8F, print corresponding cardinal number to $60F1
; control flow target (from $BE0A)
B02_BE31:
    jmp $BEF0 ; given monster count in $8F, print corresponding cardinal number to $60F1


; if $8F-$90 == #$0001, print "s" + [end-FA] to $60F1 and SEC, else LDA [end-FA] and CLC
; control flow target (from $BE1E)
; call to code in a different bank ($0F:$FE97)
B02_BE34:
    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $E3
; data -> code
    rts

; print the number stored at $8F-$90 to $60F1 in decimal
; control flow target (from $BE0E)
B02_BE39:
    lda #$05 ; 16-bit binary input => at most 5 decimal digit output

    sta $60A0 ; maximum string length

    lda $8F ; copy $8F-$90 to dividend address

    sta $10
    lda $90
    sta $11
    lda #$00 ; and set dividend byte 2 to #$00

    sta $12
; call to code in a different bank ($0F:$F17C)
    jsr $F17C ; given a 24-bit number N in $10-$12, print its base 10 digits in reverse to $0100 up to maximum string length $60A0

; call to code in a different bank ($0F:$F18D)
    jsr $F18D ; scan through $0100 + maximum string length $60A0 in reverse, replacing zeroes with spaces until the first non-zero or $0100 is reached; leaves X at most significant digit

    ldy #$00 ; reverse little-endian $0100 into big-endian $60F1

; control flow target (from $BE5A)
B02_BE52:
    lda $0100,X ; string copy buffer start (often referenced as $00FF,X)

    sta $60F1,Y ; start of text variable buffer

    iny
    dex
    bpl B02_BE52 ; keep looping until we reach $0100

; write [end-FA] then RTS
; control flow target (from $BE84, $BEAB)
    lda #$FA ; [end-FA]

    sta $60F1,Y ; start of text variable buffer

    sec ; SEC to trigger read of [end-FA]-terminated string from $60F1, CLC to use A

    rts

; print name of item ID in $95 to $60F1
; control flow target (from $BE16)
B02_BE63:
    lda #$00 ; item list is stored in two segments; start with the first one

    sta $60AB ; which list segment we're dealing with

    jsr $BE87 ; given item ID in $95, print item name segment to $0100

    jsr $BECB ; given length of string in $0100 in Y, copy that many bytes from $0100 to $60F1; transfer data from $FF,X to $60F1,Y

    lda #$5F ; Tile ID #$5F: [space]

    sta $60F1,Y ; start of text variable buffer

    iny
    tya ; save the current write index for later

    pha
    inc $60AB ; which list segment we're dealing with

    jsr $BE87 ; given item ID in $95, print item name segment to $0100

    sty $6084 ; length of string in $0100

    pla ; restore write index to Y

    tay
    jsr $BED0 ; given length of string in $0100 in $6084, copy that many bytes from $0100 to $60F1; transfer data from $FF,X to $60F1,Y

    jmp $BE5C ; write [end-FA] then RTS


; given item ID in $95, print item name segment to $0100
; control flow target (from $BE68, $BE79)
    lda #$0D ; max length of item name segment

    sta $60A0 ; maximum string length

    lda #$20
    sta $60AA ; menu format (#$80 = has cursor, #$40 = is linked, #$20 = is single spaced, #$02 = only display equipped items, #$01 = display [left border, equipped] if equipped)

    lda $95 ; ID for [item] and [spell] control codes; item index

    and #$3F ; strip off equipped bit

; call to code in a different bank ($0F:$F2A7)
    jsr $F2A7 ; print name of item ID in A to $0100 in reverse; depending on settings, possibly update menu's [left border] to [left border, equipped]

    clc
    rts

; given spell ID in $95, print spell name to $60F1
; control flow target (from $BE22)
B02_BE9A:
    lda #$09 ; max length of spell name

    sta $60A0 ; maximum string length

    lda $95 ; ID for [item] and [spell] control codes; spell ID

; call to code in a different bank ($0F:$FE97)
    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; given spell ID in A, set A to spell name index
; indirect data load target

.byte $D0
; data -> code
; call to code in a different bank ($0F:$F39F)
    jsr $F39F ; given spell name index in A, print spell name to $0100 in reverse, set Y to length of string copied, then load bank specified by $60D7 (set by last call to $F3E2)

    jsr $BECB ; given length of string in $0100 in Y, copy that many bytes from $0100 to $60F1

    jmp $BE5C ; write [end-FA] then RTS


; copy [end-FA]-terminated string from $5A to $60F1
; control flow target (from $BE26)
    ldx #$00
; control flow target (from $BEB8)
B02_BEB0:
    lda $5A,X ; Crest/direction name write buffer start

    sta $60F1,X ; start of text variable buffer

    inx
    cmp #$FA ; [end-FA]

    bne B02_BEB0
    sec ; SEC to trigger read of [end-FA]-terminated string from $60F1, CLC to use A

    rts

; copy $6119,X to $60F1,X until we read a #$FA
; OUT: X = string length + 1
; from $07:$87F4 via $8016
; control flow target (from $BE29)
; indirect control flow target (via $8016)
    ldx #$00
; control flow target (from $BEC7)
B02_BEBE:
    lda $6119,X ; start of buffer for [monster(s)], [name], maybe more

    sta $60F1,X ; start of text variable buffer

    inx
    cmp #$FA ; [end-FA]

    bne B02_BEBE
    sec ; SEC to trigger read of [end-FA]-terminated string from $60F1, CLC to use A

    rts

; given length of string in $0100 in Y, copy that many bytes from $0100 to $60F1
; control flow target (from $BE6B, $BEA8)
    sty $6084 ; length of string in $0100

    ldy #$00
; given length of string in $0100 in $6084, copy that many bytes from $0100 to $60F1
; control flow target (from $BE81)
    ldx $6084 ; length of string in $0100

    beq B02_BEEE ; if no string in $0100, DEY and RTS

    lda #$00 ; number of bytes copied

    sta $10 ; number of bytes copied

    ldx $60A0 ; maximum string length

; control flow target (from $BEEB)
B02_BEDC:
    lda a:$FF,X ; built-in offset from string copy buffer start at $0100

    sta $60F1,Y ; start of text variable buffer

    dex
    iny
    inc $10 ; number of bytes copied

    lda $10 ; number of bytes copied

    cmp $6084 ; length of string in $0100

    bne B02_BEDC ; if more bytes to copy, copy them

    rts

; control flow target (from $BED3)
B02_BEEE:
    dey ; undo the space between item segments

    rts

; given monster count in $8F, print corresponding cardinal number to $60F1
; control flow target (from $BE31)
    ldy $8F ; number of monsters in group

    dey ; count from 0 instead of 1

    sty $10
    ldx #$00 ; read index

    ldy #$00 ; write index

; control flow target (from $BF03, $BF09)
B02_BEF9:
    lda $BF0D,X ; Monster Counts text

    sta $60F1,Y ; start of text variable buffer

    iny
    inx
    cmp #$FA ; [end-FA]

    bne B02_BEF9 ; if not end token, keep copying

    ldy #$00 ; otherwise reset write index

    dec $10 ; update required number of end tokens

    bpl B02_BEF9 ; and if we still need more end tokens, loop

    sec ; SEC to trigger read of [end-FA]-terminated string from $60F1, CLC to use A

    rts


; code -> data
; Monster Counts text
; indexed data load target (from $BEF9)

.byte $32,$17,$0E,$FA,$37,$20,$18,$FA,$37,$11,$1B,$0E,$0E,$FA,$29,$18
.byte $1E,$1B,$FA,$29,$12,$1F,$0E,$FA,$36,$12,$21,$FA
.byte $36,$0E,$1F,$0E,$17,$FA
.byte $28,$12,$10
.byte $11,$1D
.byte $FA
; data -> free
.res $a1
; ... skipping $A1 FF bytes
.byte $FF

.byte $FF
; free -> unknown

.byte $78,$EE,$DF,$BF,$4C,$86,$FF,$80
.literal "DRAGON WARRIORS2"
.byte $FF,$FF,$00,$00,$48,$04,$01,$0F
.byte $07,$9D,$D8,$BF,$D8,$BF,$D8,$BF

