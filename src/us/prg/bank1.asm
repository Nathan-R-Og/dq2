.segment        "PRG1":absolute
; code bytes:	$0000 (0.00% of bytes in this ROM bank)
; data bytes:	$3F11 (98.54% of bytes in this ROM bank)
; pcm bytes:	$0000 (0.00% of bytes in this ROM bank)
; chr bytes:	$0000 (0.00% of bytes in this ROM bank)
; free bytes:	$00C8 (1.22% of bytes in this ROM bank)
; unknown bytes:	$0027 (0.24% of bytes in this ROM bank)
; $3F11 bytes last seen in RAM bank $8000 - $BFFF (100.00% of bytes seen in this ROM bank, 98.54% of bytes in this ROM bank):
;	$3F11 data bytes (100.00% of bytes seen in this RAM bank, 98.54% of bytes in this ROM bank)

; PRG Bank 0x01: mostly enemy graphics, unknown format; also contains the menu pointers and data


incbinRange "../../split/us/prg/bank1.bin", 0, $3fd8

.byte $78,$EE,$DF,$BF,$4C,$86,$FF,$80
.literal "DRAGON WARRIORS2"
.byte $FF,$FF,$00,$00,$48,$04,$01,$0F
.byte $07,$9D,$D8,$BF,$D8,$BF,$D8,$BF
