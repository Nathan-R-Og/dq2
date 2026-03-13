.segment        "PRGB":absolute
; code bytes:	$008D (0.86% of bytes in this ROM bank)
; data bytes:	$042A (6.51% of bytes in this ROM bank)
; pcm bytes:	$0000 (0.00% of bytes in this ROM bank)
; chr bytes:	$1F60 (49.02% of bytes in this ROM bank)
; free bytes:	$1BA9 (43.22% of bytes in this ROM bank)
; unknown bytes:	$0040 (0.39% of bytes in this ROM bank)
; $2417 bytes last seen in RAM bank $8000 - $BFFF (100.00% of bytes seen in this ROM bank, 56.39% of bytes in this ROM bank):
;	$008D code bytes (1.53% of bytes seen in this RAM bank, 0.86% of bytes in this ROM bank)
;	$042A data bytes (11.54% of bytes seen in this RAM bank, 6.51% of bytes in this ROM bank)
;	$1F60 chr bytes (86.94% of bytes seen in this RAM bank, 49.02% of bytes in this ROM bank)

; PRG Bank 0x0B: haven't looked at this much, contains the title screen graphics

; [bank start] -> code
; external control flow target (from $0F:$C693)
; possible external indexed data load target (from $0F:$F3ED, $0F:$FF28)
; possible external indexed data load target (from $0F:$F3F2, $0F:$FF2D)
    lda $80A6
    sta $0C
    lda $80A7
    sta $0D
    lda $80A8
    sta $0E
    lda $80A9
    sta $0F
    lda #$00
    sta $10
    sta $11
    lda #$07
    jsr $8087
    lda $80AA
    sta $0C
    lda $80AB
    sta $0D
    lda $80AC
    sta $0E
    lda $80AD
    sta $0F
    lda #$00
    sta $10
    lda #$10
    sta $11
    lda #$07
    jsr $8087
    lda #$20
    sta $2006 ; VRAM Address Register #2 (write twice; $2007 address)

    lda #$00
    sta $2006 ; VRAM Address Register #2 (write twice; $2007 address)

    lda $80B2
    sta $6D
    lda $80B3
    sta $6E
    ldx #$04
    ldy #$00
    sty $6F
; control flow target (from $8067, $806A)
B0B_805A:
    lda ($6D),Y
    sta $2007 ; VRAM I/O Register

    inc $6D
    bne B0B_8065
    inc $6E
; control flow target (from $8061)
B0B_8065:
    inc $6F
    bne B0B_805A
    dex
    bne B0B_805A
    lda #$FF
    sta $0D
    lda $80AE
    sta $0E
    lda $80AF
    sta $0F
    lda $80B0
    sta $10
    lda $80B1
    sta $11
; call to code in a different bank ($0F:$C2CD)
    jmp $C2CD

; control flow target (from $801C, $803D)
; call to code in a different bank ($0F:$C3E8)
    jsr $C3E8 ; wait for interrupt, set $6007 to #$FF, turn screen off

; call to code in a different bank ($0F:$C3F6)
    jmp $C3F6 ; copy ($0C) inclusive - ($0E) exclusive to PPU at ($10)



; code -> unknown
.byte $8D,$06,$20,$A9,$C0,$8D,$06,$20
.byte $A9,$FF,$A2,$3F,$8D,$07,$20,$9D
.byte $C0,$03,$9D,$C0,$07
.byte $CA
.byte $10,$F4
.byte $60
; unknown -> data
; data load target (from $8000)
; data load target (from $8005)
.byte $CE
; data load target (from $800A)
.byte $84
; data load target (from $800F)
.byte $CE
; data load target (from $801F)
.byte $94
; data load target (from $8024)
.byte $CE
; data load target (from $8029)
.byte $94
; data load target (from $802E)
.byte $2E
; data load target (from $8070)
.byte $A4
; data load target (from $8075)
.byte $C1
; data load target (from $807A)
.byte $80
; data load target (from $807F)
.byte $B4
; data load target (from $804A)
.byte $80
; data load target (from $804F)
.byte $CE
; indirect data load target (via $80B0)
.byte $80
; indirect data load target (via $80AE)
.byte $0F,$08,$08,$08,$37,$2C,$1C
.byte $08,$08,$08
.byte $30,$11
.byte $01
; indirect data load target (via $80B2)
.byte $1C,$37,$2C,$1C,$36,$27,$15
.byte $37,$2B,$1B
.byte $36,$27
.byte $15

.byte $A8,$A9,$80,$81,$A8,$A9,$80,$81,$80,$81,$A8,$A9,$80,$81,$80,$81
.byte $A8,$A9,$80,$81,$80,$81,$80,$81,$A8,$A9,$A8,$A9,$80,$81,$A8,$A9
.byte $A8,$A9,$90,$91,$A8,$A9,$90,$91,$90,$91,$A8,$A9,$90,$91,$90,$91
.byte $A8,$A9,$90,$91,$90,$91,$90,$91,$A8,$A9,$A8,$A9,$90,$91,$A8,$A9
.byte $A8,$A9,$C5,$E1,$A8,$A9,$C5,$E1,$E0,$E1,$A8,$A9,$C5,$E1,$E0,$E1
.byte $A8,$A9,$C5,$E1,$E0,$E1,$E0,$E1,$A8,$A9,$A8,$A9,$C5,$E1,$A8,$A9
.byte $B8,$B9,$D5,$F1,$B8,$B9,$D5,$F1,$F0,$F1,$B8,$B9,$D5,$F1,$F0,$F1
.byte $B8,$B9,$D5,$F1,$F0,$F1,$F0,$F1,$B8,$B9,$B8,$B9,$D5,$F1,$B8,$B9
.byte $E0,$E1,$E0,$E1,$E0,$E1,$E0,$E1,$E0,$E1,$E0,$E1,$E0,$E1,$E0,$E1
.byte $E0,$E1,$E0,$E1,$E0,$E1,$E0,$E1,$E0,$E1,$E0,$E1,$E0,$E1,$E0,$E1
.byte $F0,$F1,$F0,$F1,$F0,$F1,$F0,$F1,$F0,$F1,$F0,$F1,$F0,$F1,$F0,$F1
.byte $F0,$F1,$F0,$F1,$F0,$F1,$F0,$F1,$F0,$F1,$F0,$F1,$F0,$F1,$F0,$F1
.byte $E0,$E1,$49,$4A,$00,$01,$02,$03,$04,$05,$C6,$C7,$08,$09,$0A,$0B
.byte $0C,$0D,$0E,$0F,$C8,$C9,$42,$43,$44,$45,$46,$47,$48,$4B,$4C,$E1
.byte $F0,$F1,$59,$5A,$10,$11,$12,$13,$14,$15,$D6,$D7,$18,$19,$1A,$1B
.byte $1C,$1D,$1E,$1F,$D8,$D9,$52,$53,$54,$55,$56,$57,$58,$5B,$5C,$F1
.byte $E0,$E1,$69,$6A,$20,$21,$22,$23,$24,$25,$E6,$E7,$28,$29,$2A,$2B
.byte $2C,$2D,$2E,$2F,$E8,$E9,$62,$63,$64,$65,$66,$67,$68,$6B,$6C,$E1
.byte $F0,$F1,$79,$7A,$30,$31,$32,$33,$34,$35,$F6,$F7,$38,$39,$3A,$3B
.byte $3C,$3D,$3E,$3F,$F8,$F9,$72,$73,$74,$75,$76,$77,$78,$7B,$7C,$F1
.byte $E0,$E1,$E0,$E1,$E0,$E1,$E0,$E1,$E0,$E1,$E0,$E1,$E0,$E1,$E0,$E1
.byte $E0,$E1,$E0,$E1,$E0,$E1,$E0,$E1,$E0,$E1,$E0,$E1,$E0,$E1,$E0,$E1
.byte $F0,$F1,$F0,$F1,$F0,$F1,$F0,$F1,$F0,$F1,$F0,$F1,$F0,$F1,$F0,$F1
.byte $F0,$F1,$F0,$F1,$F0,$F1,$F0,$F1,$F0,$F1,$F0,$F1,$F0,$F1,$F0,$F1
.byte $E0,$E1,$E0,$E1,$E0,$E1,$E0,$E1,$E0,$E1,$88,$89,$A4,$A5,$8A,$99
.byte $A4,$A5,$8A,$99,$AA,$AB,$E0,$E1,$E0,$E1,$E0,$E1,$E0,$E1,$E0,$E1
.byte $F0,$F1,$F0,$F1,$F0,$F1,$F0,$F1,$F0,$F1,$98,$99,$B4,$B5,$FF,$FF
.byte $B4,$B5,$FF,$FF,$BA,$BB,$F0,$F1,$F0,$F1,$F0,$F1,$F0,$F1,$F0,$F1
.byte $E0,$E1,$E0,$E1,$E0,$E1,$E0,$E1,$8A,$9B,$FF,$FF,$FF,$FF,$DF,$DF
.byte $DF,$DF,$FF,$FF,$FF,$FF,$BB,$EB,$E0,$E1,$E0,$E1,$E0,$E1,$FC,$FD
.byte $F0,$F1,$F0,$F1,$F0,$F1,$F0,$F1,$9A,$9B,$FF,$FF,$FF,$FF,$FF,$FF
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FA,$FB,$F0,$F1,$F0,$F1,$F0,$F1,$DA,$DB
.byte $FC,$FD,$E0,$E1,$E0,$E1,$E0,$E1,$8A,$8B,$FF,$FF,$FF,$FF,$FF,$FF
.byte $FF,$FF,$FF,$FF,$FF,$FF,$EA,$EB,$E0,$E1,$E0,$E1,$E0,$E1,$DA,$DB
.byte $DA,$DB,$F0,$F1,$F0,$F1,$F0,$F1,$9A,$9B,$FF,$FF,$FF,$FF,$FF,$FF
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FA,$FB,$F0,$F1,$F0,$F1,$F0,$F1,$DA,$DB
.byte $DA,$DB,$E0,$E1,$E0,$E1,$E0,$E1,$8A,$8B,$FF,$FF,$FF,$FF,$FF,$FF
.byte $FF,$FF,$FF,$FF,$FF,$FF,$EA,$EB,$E0,$E1,$E0,$E1,$FC,$FD,$DA,$DB
.byte $DA,$DB,$F0,$F1,$F0,$F1,$F0,$F1,$9A,$9B,$FF,$FF,$FF,$FF,$FF,$FF
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FA,$FB,$F0,$F1,$F0,$F1,$DA,$DB,$DA,$DB
.byte $DA,$DB,$FC,$FD,$E0,$E1,$E0,$E1,$8A,$A6,$FF,$6D,$6D,$FF,$FF,$FF
.byte $FF,$FF,$FF,$6D,$6D,$FF,$EA,$EB,$E0,$E1,$E0,$E1,$DA,$DB,$FC,$FD
.byte $FC,$FD,$DA,$DB,$E2,$E3,$E4,$E5,$9A,$B6,$5D,$5D,$5D,$5D,$EC,$FF
.byte $FF,$FF,$5D,$5D,$5D,$5D,$FA,$FB,$E2,$E3,$E4,$E5,$DA,$DB,$DA,$DB
.byte $DA,$DB,$DA,$DB,$F2,$F3,$F4,$F5,$4E,$4F,$4E,$4F,$4E,$4F,$4E,$4F
.byte $4E,$4F,$4E,$4F,$4E,$4F,$4E,$4F,$F2,$F3,$F4,$F5,$DA,$DB,$DA,$DB
.byte $DA,$DB,$DA,$DB,$7D,$FE,$94,$7D,$94,$95,$94,$FE,$5E,$5F,$5E,$5F
.byte $5E,$5F,$5E,$5F,$94,$95,$94,$95,$7D,$95,$7D,$7D,$DA,$DB,$DA,$DB
.byte $DA,$DB,$FC,$FD,$94,$95,$94,$95,$7D,$95,$94,$95,$6E,$6F,$6E,$6F
.byte $6E,$6F,$6E,$6F,$94,$FE,$94,$95,$FE,$7D,$CA,$CB,$FC,$FD,$DA,$DB
.byte $DA,$DB,$DA,$DB,$FE,$95,$7D,$95,$5E,$5F,$86,$87,$7E,$7F,$7E,$7F
.byte $7E,$7F,$7E,$7F,$96,$97,$5E,$5F,$94,$95,$DA,$DB,$DA,$DB,$DA,$DB
.byte $FC,$FD,$DA,$DB,$CA,$CB,$94,$95,$6E,$6F,$6E,$6F,$82,$83,$82,$83
.byte $82,$83,$82,$83,$6E,$6F,$6E,$6F,$94,$FE,$DA,$DB,$DA,$DB,$FC,$FD
.byte $DA,$DB,$DA,$DB,$DA,$DB,$86,$87,$7E,$7F,$7E,$7F,$92,$93,$92,$93
.byte $92,$93,$92,$93,$7E,$7F,$7E,$7F,$96,$97,$FC,$FD,$DA,$DB,$DA,$DB
.byte $DA,$FC,$FD,$DB,$FC,$FD,$6E,$6F,$82,$83,$A0,$A1,$A2,$A3,$A2,$A3
.byte $A0,$A1,$A2,$A3,$A0,$A1,$82,$83,$6E,$6F,$DA,$DB,$FC,$FD,$DA,$DB
.byte $DA,$DB,$DA,$DB,$DA,$DB,$7E,$7F,$92,$93,$B0,$B1,$B2,$B3,$B2,$B3
.byte $B0,$B1,$B2,$B3,$B0,$B1,$92,$93,$7E,$7F,$DA,$DB,$DA,$DB,$DA,$DB
.byte $80,$80,$20,$A0,$80,$A0,$00,$20,$AA,$AA,$2A,$0A,$0A,$8A,$AA,$AA
.byte $AA,$AA,$A2,$A0,$A0,$A8,$AA,$AA,$AA,$AA,$2A,$4A,$1A,$8A,$AA,$2A
.byte $88,$AA,$22,$44,$11,$88,$AA,$02,$00,$0A,$02,$06,$01,$0A,$0A,$00
.byte $00,$00,$00,$F0,$F0,$00,$00,$00
.byte $00,$00,$0F,$0F
.byte $0F,$0F
.byte $00
.byte $00
; data -> chr
; indirect CHR load target (via $80A6)
; indirect CHR load target (via $80A8, $80AA)
.incbin "../../split/us/gfx/title.bin"
; chr -> data
; indirect data load target (via $80AC)

.byte $FF
; data -> free
; ... skipping $1BA7 FF bytes
.res $1ba7

.byte $FF

.byte $FF
; free -> unknown


.byte $78,$EE,$DF,$BF,$4C,$86,$FF,$80
.literal "DRAGON WARRIORS2"
.byte $FF,$FF,$00,$00,$48,$04,$01,$0F
.byte $07,$9D,$D8,$BF,$D8,$BF,$D8,$BF
