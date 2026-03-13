.segment        "PRG9":absolute
; code bytes:	$0699 (10.31% of bytes in this ROM bank)
; data bytes:	$06C4 (10.57% of bytes in this ROM bank)
; pcm bytes:	$0000 (0.00% of bytes in this ROM bank)
; chr bytes:	$15F0 (34.28% of bytes in this ROM bank)
; free bytes:	$1CB3 (44.84% of bytes in this ROM bank)
; unknown bytes:	$0001 (0.01% of bytes in this ROM bank)
; $234C bytes last seen in RAM bank $8000 - $BFFF (100.00% of bytes seen in this ROM bank, 55.15% of bytes in this ROM bank):
;	$0699 code bytes (18.69% of bytes seen in this RAM bank, 10.31% of bytes in this ROM bank)
;	$06C4 data bytes (19.17% of bytes seen in this RAM bank, 10.57% of bytes in this ROM bank)
;	$15F0 chr bytes (62.15% of bytes seen in this RAM bank, 34.28% of bytes in this ROM bank)

; PRG Bank 0x09: haven't looked at this much, contains the end credits

; [bank start] -> code
; external control flow target (from $0F:$D34D)
; possible external indexed data load target (from $0F:$F3ED, $0F:$FF28)
; possible external indexed data load target (from $0F:$F3F2, $0F:$FF2D)
    ldx #$F0
; call to code in a different bank ($0F:$C1EE)
    jsr $C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

; call to code in a different bank ($0F:$C42A)
    jsr $C42A
; call to code in a different bank ($0F:$C446)
    jsr $C446 ; turn screen off, write $800 [space] tiles to PPU $2000, turn screen on

; call to code in a different bank ($0F:$C465)
    jsr $C465 ; wait for interrupt and then set every 4th byte of $0200 - $02FC to #$F0

    lda #$00
    sta $76
    sta $04
    sta $05
    sta $06
    lda #$0F
; call to code in a different bank ($0F:$C61F)
    jsr $C61F ; set MMC control mode based on A

    lda #$88
    sta $61AE
    lda #$8A
    sta $61AF
; call to code in a different bank ($0F:$C52D)
    jsr $C52D
    jsr $82A0
; call to code in a different bank ($0F:$C1DC)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    jsr $814B
    lda $829E ; -> $09:$83A6: End Credits text

    sta $77
    lda $829F
    sta $78
    lda #$00
    sta $76
    lda #$10
    sta $75
    lda #$1E
    sta $608C
; control flow target (from $806C)
B09_804A:
    ldy #$00
    lda ($77),Y
    bpl B09_8076
    cmp #$FF
    bne B09_8057
    jmp $80D5

; control flow target (from $8052)
B09_8057:
    pha
    and #$C0
    cmp #$C0
    bne B09_8062
    lda #$08
    sta $75
; control flow target (from $805C)
B09_8062:
    pla
    and #$1F
    sta $76
    jsr $8160
; control flow target (from $80D2)
    lda $76
    beq B09_804A
    dec $76
; call to code in a different bank ($0F:$C1DC)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    jmp $809E

; control flow target (from $804E)
B09_8076:
    sta $608B
    jsr $8160
; control flow target (from $8092)
    ldy #$00
    lda ($77),Y
    cmp #$FF
    beq B09_8095
    sta $09
    jsr $8167
; call to code in a different bank ($0F:$C1FA)
    jsr $C1FA ; wait for $02 to not be #$C0, write PPU address in $07-$08 and data in $09 to PPU write buffer at $0300,$02, $01 += 1, $02 += 3, and set $0183 to #$00

    inc $608B
    jsr $8160
    jmp $807C

; control flow target (from $8082)
B09_8095:
    jsr $8160
; call to code in a different bank ($0F:$C1DC)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    jsr $80E0
; control flow target (from $8073)
    lda $75
    sta $6F
; control flow target (from $80CF)
    ldx #$02
; call to code in a different bank ($0F:$C1EE)
    jsr $C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

    inc $06
    lda $06
    cmp #$F0
    bcc B09_80B9
    lda #$00
    sta $06
    lda $04
    eor #$08
    sta $04
; control flow target (from $80AD)
B09_80B9:
    lda $06
    and #$07
    bne B09_80C8
    ldy #$3B
    lda #$5F
    sta $6D
    jsr $81D6
; control flow target (from $80BD)
B09_80C8:
    dec $6F
    beq B09_80D2
; call to code in a different bank ($0F:$C1DC)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    jmp $80A2

; control flow target (from $80CA)
B09_80D2:
    jmp $806A

; control flow target (from $8054)
    ldx #$4D
; call to code in a different bank ($0F:$C1EE)
    jsr $C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

    jsr $9DD4
; call to code in a different bank ($0F:$C1DC)
    jmp $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF


; control flow target (from $809B)
    ldy #$00
    lda ($77),Y
    jsr $8160
    cmp #$FF
    bne B09_80FC
    ldx #$00
; control flow target (from $80F8)
B09_80ED:
    lda ($77,X)
    jsr $8160
    sta $615B,Y
    iny
    cpy #$10
    bcc B09_80ED
    bcs B09_8104
; control flow target (from $80E9, $8102)
B09_80FC:
    sta $615B,Y
    iny
    cpy #$10
    bcc B09_80FC
; control flow target (from $80FA)
B09_8104:
    lda $608C
    sta $6E
    lda #$00
    sta $6D
; control flow target (from $8148)
B09_810D:
    ldy $6D
    lda $615B,Y
    sta $61B0
    lda $6D
    pha
    lda $6E
    pha
    jsr $81FE
    ldy #$00
    and ($6D),Y
    ora $61B0
    sta ($6D),Y
    ldy $02
    sta $0302,Y
    lda $7A
    sta $0300,Y ; PPU write buffer start

    lda $79
    sta $0301,Y
    iny
    iny
    iny
    sty $02
    inc $01
    pla
    sta $6E
    pla
    clc
    adc #$01
    sta $6D
    cmp #$10
    bcc B09_810D
    rts

; control flow target (from $8030)
    lda $838A
    sta $0E
    sta $10
    lda $838B
    sta $0F
    sta $11
    lda #$FF
    sta $0D
; call to code in a different bank ($0F:$C2CD)
    jmp $C2CD

; control flow target (from $8067, $8079, $808F, $8095, $80E4, $80EF)
    inc $77
    bne B09_8166
    inc $78
; control flow target (from $8162)
B09_8166:
    rts

; control flow target (from $8086, $81EA)
    lda $04
    and #$08
    ora #$20
    sta $08
    lda $05
    lsr
    lsr
    lsr
    clc
    adc $608B
    cmp #$20
    bcc B09_817E
    sbc #$20
; control flow target (from $817A)
B09_817E:
    sta $07
    lda #$00
    sta $6E
    lda $608C
    asl
    rol $6E
    asl
    rol $6E
    asl
    rol $6E
    clc
    adc $06
    tax
    bcc B09_8198
    inc $6E
; control flow target (from $8194)
B09_8198:
    sec
    sbc #$F0
    sta $6D
    lda $6E
    sbc #$00
    sta $6E
    bcc B09_81C0
    lda $6D
    sec
    sbc #$F0
    tay
    lda $6E
    sbc #$00
    bcs B09_81BC
    lda $08
    eor #$08
    sta $08
    lda $6D
    jmp $81C1

; control flow target (from $81AF)
B09_81BC:
    tya
    jmp $81C1

; control flow target (from $81A3)
B09_81C0:
    txa
; control flow target (from $81B9, $81BD)
    ldx #$00
    stx $6D
    asl
    rol $6D
    asl
    rol $6D
    ora $07
    sta $07
    lda $6D
    ora $08
    sta $08
    rts

; control flow target (from $80C5)
    lda $608C
    pha
    lda $608B
    pha
    sty $608C
    lda #$20
    sta $608B
    lda $6D
    sta $09
; control flow target (from $81F3)
B09_81EA:
    jsr $8167
; call to code in a different bank ($0F:$C1FA)
    jsr $C1FA ; wait for $02 to not be #$C0, write PPU address in $07-$08 and data in $09 to PPU write buffer at $0300,$02, $01 += 1, $02 += 3, and set $0183 to #$00

    dec $608B
    bne B09_81EA
    pla
    sta $608B
    pla
    sta $608C
    rts

; control flow target (from $811B)
    lda $04
    and #$08
    ora #$23
    sta $7A
    lda #$C0
    sta $79
    lsr $6E
    lda $06
    lsr
    lsr
    lsr
    lsr
    clc
    adc $6E
; control flow target (from $8225)
    cmp #$0F
    bcc B09_8228
    sbc #$0F
    sta $6E
    lda $7A
    eor #$08
    sta $7A
    lda $6E
    jmp $8215

; control flow target (from $8217)
B09_8228:
    sta $6E
    lda $05
    lsr
    lsr
    lsr
    lsr
    clc
    adc $6D
    cmp #$10
    bcc B09_8239
    sbc #$10
; control flow target (from $8235)
B09_8239:
    sta $6D
    lda $6E
    lsr
    php
    asl
    asl
    asl
    clc
    adc $79
    sta $79
    bne B09_824B
    inc $7A
; control flow target (from $8247)
B09_824B:
    plp
    bcs B09_8260
    lda $6D
    lsr
    bcs B09_8259
    jsr $8284
    lda #$FC
    rts

; control flow target (from $8251)
B09_8259:
    jsr $8284
    lda #$F3
    bne B09_827D
; control flow target (from $824C)
B09_8260:
    lda $6D
    lsr
    bcs B09_826C
    jsr $8284
    lda #$CF
    bne B09_8277
; control flow target (from $8263)
B09_826C:
    jsr $8284
    lda #$3F
    asl $61B0
    asl $61B0
; control flow target (from $826A)
B09_8277:
    asl $61B0
    asl $61B0
; control flow target (from $825E)
B09_827D:
    asl $61B0
    asl $61B0
    rts

; control flow target (from $8253, $8259, $8265, $826C)
    clc
    adc $79
    sta $79
    sta $6D
    lda $7A
    adc #$00
    sta $7A
    cmp #$2B
    beq B09_8299
    lda #$03
    bne B09_829B
; control flow target (from $8293)
B09_8299:
    lda #$07
; control flow target (from $8297)
B09_829B:
    sta $6E
    rts


; code -> data
; -> $09:$83A6: End Credits text
; data load target (from $8033)
; data load target (from $8038)
.byte $A6

.byte $83
; data -> code
; control flow target (from $802A)
; call to code in a different bank ($0F:$C1DC)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    lda #$00
    sta $2001 ; PPU Control Register #2 (#$E0: Full Background Colour, #$01 set [None, Green, Blue, Red], #$E0: Colour Intensity, #$01 not set [None, Green, Blue, Red], #$10: Sprite Visibility, #$80: Background Visibility, #$40: No Sprite Clipping, #$20: No Background Clipping, #$01: Monochrome Display)

    lda #$C0
    sta $6D
    lda $2002 ; PPU Status Register (#$80: In VBlank, #$40: Sprite #0 Hit, #$20: Scanline Sprite Count > 8, #$10: Ignore VRAM Writes); after read, #$80 and $2005-$2006 are reset

    lda #$23
    sta $2006 ; VRAM Address Register #2 (write twice; $2007 address)

    lda #$C0
    sta $2006 ; VRAM Address Register #2 (write twice; $2007 address)

    lda #$03
    sta $6E
    jsr $82D7
    lda #$2B
    sta $2006 ; VRAM Address Register #2 (write twice; $2007 address)

    lda #$C0
    sta $2006 ; VRAM Address Register #2 (write twice; $2007 address)

    lda #$07
    sta $6E
    jsr $82D7
    lda #$18
    sta $2001 ; PPU Control Register #2 (#$E0: Full Background Colour, #$01 set [None, Green, Blue, Red], #$E0: Colour Intensity, #$01 not set [None, Green, Blue, Red], #$10: Sprite Visibility, #$80: Background Visibility, #$40: No Sprite Clipping, #$20: No Background Clipping, #$01: Monochrome Display)

    rts

; control flow target (from $82BD, $82CE)
    lda #$00
    ldy #$3F
; control flow target (from $82E1)
B09_82DB:
    sta $2007 ; VRAM I/O Register

    sta ($6D),Y
    dey
    bpl B09_82DB
    rts

; control flow target (from $9DE0)
    sta $73
    lda #$10
    sta $70
; control flow target (from $8307)
; call to code in a different bank ($0F:$C1DC)
B09_82EA:
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

; call to code in a different bank ($0F:$C1DC)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    lda #$00
    jsr $8330
    lda $73
    beq B09_82FE
    lda #$0D
    jsr $8330
; control flow target (from $82F7)
B09_82FE:
    lda $70
    clc
    adc #$10
    sta $70
    cmp #$50
    bcc B09_82EA
    rts

; control flow target (from $9E0E)
    sta $73
    lda #$40
    sta $70
; control flow target (from $832D)
; call to code in a different bank ($0F:$C1DC)
B09_8310:
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

; call to code in a different bank ($0F:$C1DC)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    lda #$00
    jsr $8330
    lda $73
    beq B09_8324
    lda #$0D
    jsr $8330
; control flow target (from $831D)
B09_8324:
    lda $70
    sec
    sbc #$10
    sta $70
    cmp #$00
    bpl B09_8310
    rts

; control flow target (from $82F2, $82FB, $8318, $8321)
    pha
    tay
    lda ($6D),Y
    sta $6F
    lda #$0D
    sta $74
    iny
    ldx $02
    pla
    beq B09_8346
    lda #$1A
    sta $74
    lda #$10
; control flow target (from $833E)
B09_8346:
    sta $71
    jmp $836D

; control flow target (from $8387)
B09_834B:
    lda $71
    cmp #$04
    beq B09_836D
    cmp #$08
    beq B09_836D
    cmp #$0C
    beq B09_836D
    cmp #$14
    beq B09_836D
    cmp #$18
    beq B09_836D
    cmp #$1C
    beq B09_836D
    lda ($6D),Y
    iny
    sec
    sbc $70
    bpl B09_836F
; control flow target (from $8348, $834F, $8353, $8357, $835B, $835F, $8363)
B09_836D:
    lda $6F
; control flow target (from $836B)
B09_836F:
    sta $0302,X
    lda #$3F
    sta $0300,X ; PPU write buffer start

    lda $71
    sta $0301,X
    inx
    inx
    inx
    stx $02
    inc $01
    inc $71
    cpy $74
    bcc B09_834B
    rts


; code -> data
; data load target (from $814B, $9DD4)
; data load target (from $8152, $9DD9)
.byte $8C
; indirect data load target (via $838A)
.byte $83
; indirect data load target
.byte $0F,$2A,$2A,$2A,$28,$28,$28
.byte $34,$34,$34
.byte $31,$31
.byte $31
; indirect data load target
.byte $0F
; indirect data load target
.byte $0F
; indirect data load target
.byte $0F
; indirect data load target
.byte $0F
; indirect data load target
.byte $0F
; indirect data load target
.byte $0F
; indirect data load target
.byte $0F
; indirect data load target
.byte $0F
; indirect data load target
.byte $0F
; indirect data load target
.byte $0F
; indirect data load target
.byte $0F
; indirect data load target
.byte $0F
; End Credits text
.byte $0F
; indirect data load target (via $829E)
; data load target (from $9E02)
.byte $08,$03,$11,$00,$06,$0E,$0D,$5F,$10,$14,$04,$12,$13,$5F,$5F,$08
.byte $08,$FF,$03,$08,$0E,$11,$08,$06,$08,$0D,$00,$0B,$5F,$15,$04,$11
.byte $12,$08,$0E,$0D,$FF,$03,$0D,$12,$13,$00,$05,$05,$FF,$03,$86,$03
.byte $12,$02,$04,$0D,$00,$11,$08,$0E,$5F,$16,$11,$08,$13,$04,$11,$FF
.byte $01,$0D,$18,$14,$09,$08,$5F,$07,$0E,$11,$08,$08,$FF,$02,$86,$03
.byte $0C,$0E,$0D,$12,$13,$04,$11,$5F,$03,$04,$12,$08,$06,$0D,$04,$11
.byte $FF,$01,$0D,$00,$0A,$08,$11,$00,$5F,$13,$0E,$11,$08,$18,$00,$0C
.byte $00,$FF,$02,$86,$03,$0C,$14,$12,$08,$02,$5F,$02,$0E,$0C,$0F,$0E
.byte $12,$04,$11,$FF,$01,$0D,$0A,$0E,$08,$02,$07,$08,$5F,$12,$14,$06
.byte $08,$18,$00,$0C,$00,$FF,$02,$86,$03,$12,$02,$04,$0D,$00,$11,$08
.byte $0E,$5F,$00,$12,$12,$08,$12,$13,$00,$0D,$13,$FF,$01,$0D,$07,$08
.byte $11,$0E,$12,$07,$08,$5F,$0C,$08,$18,$00,$0E,$0A,$00,$FF,$02,$86
.byte $03,$02,$07,$08,$04,$05,$5F,$0F,$11,$0E,$06,$11,$00,$0C,$0C,$04
.byte $11,$FF,$01,$0D,$0A,$0E,$08,$02,$07,$08,$5F,$0D,$00,$0A,$00,$0C
.byte $14,$11,$00,$FF,$02,$86,$03,$0F,$11,$0E,$06,$11,$00,$0C,$0C,$04
.byte $11,$12,$FF,$01,$0D,$18,$14,$13,$00,$0A,$00,$5F,$06,$18,$0E,$13
.byte $0E,$0A,$14,$FF,$02,$0D,$13,$0E,$06,$0E,$5F,$0D,$00,$11,$08,$13
.byte $00,$FF,$02,$0D,$0A,$08,$18,$0E,$13,$00,$0A,$00,$5F,$0A,$0E,$0D
.byte $0E,$FF,$02,$0D,$0C,$00,$12,$00,$00,$0A,$08,$5F,$0E,$0A,$00,$0D
.byte $0E,$FF,$02,$0D,$0A,$0E,$09,$08,$5F,$18,$0E,$12,$07,$08,$03,$00
.byte $FF,$02,$82,$03,$12,$0E,$14,$0D,$03,$5F,$0F,$11,$0E,$06,$11,$00
.byte $0C,$0C,$04,$11,$FF,$01,$0D,$13,$00,$0A,$04,$0D,$0E,$11,$08,$5F
.byte $18,$00,$0C,$00,$0C,$0E,$11,$08,$FF,$02,$82,$03,$02,$06,$5F,$03
.byte $04,$12,$08,$06,$0D,$04,$11,$FF,$01,$0D,$13,$00,$0A,$00,$12,$07
.byte $08,$5F,$18,$00,$12,$14,$0D,$0E,$FF,$02,$82,$03,$00,$12,$12,$08
.byte $12,$13,$00,$0D,$13,$12,$FF,$01,$0D,$11,$08,$0A,$00,$5F,$12,$14
.byte $19,$14,$0A,$08,$FF,$02,$0D,$07,$08,$03,$04,$07,$08,$11,$0E,$5F
.byte $18,$0E,$12,$07,$08,$03,$00,$FF,$02,$86,$03,$03,$08,$11,$04,$02
.byte $13,$0E,$11,$FF,$01,$0D,$0A,$0E,$08,$02,$07,$08,$5F,$0D,$00,$0A
.byte $00,$0C,$14,$11,$00,$FF,$02,$86,$03,$0F,$11,$0E,$03,$14,$02,$04
.byte $11,$FF,$01,$0D,$18,$14,$0A,$08,$0D,$0E,$01,$14,$5F,$02,$07,$08
.byte $03,$00,$FF,$02,$88,$08,$03,$11,$00,$06,$0E,$0D,$5F,$16,$00,$11
.byte $11,$08,$0E,$11,$5F,$08,$08,$FF,$03,$0E,$12,$13,$00,$05,$05,$FF
.byte $03,$87,$03,$0F,$11,$0E,$06,$11,$00,$0C,$0C,$04,$11,$12,$FF,$01
.byte $0D,$0C,$00,$0D,$00,$01,$14,$5F,$18,$00,$0C,$00,$0D,$00,$FF,$02
.byte $0D,$0A,$04,$0D,$08,$02,$07,$08,$5F,$0C,$00,$12,$14,$13,$00,$FF
.byte $02,$83,$03,$02,$06,$5F,$03,$04,$12,$08,$06,$0D,$04,$11,$FF,$01
.byte $0D,$12,$00,$13,$0E,$12,$07,$08,$5F,$05,$14,$03,$00,$01,$00,$FF
.byte $02,$83,$03,$04,$17,$04,$02,$14,$13,$08,$15,$04,$5F,$0F,$11,$0E
.byte $03,$14,$02,$04,$11,$FF,$01,$0D,$07,$08,$11,$0E,$18,$14,$0A,$08
.byte $5F,$13,$00,$0A,$00,$07,$00,$12,$07,$08,$FF,$02,$87,$09,$00,$0C
.byte $04,$11,$08,$02,$00,$0D,$5F,$12,$13,$00,$05,$05,$FF,$03,$05,$0D
.byte $08,$0D,$13,$04,$0D,$03,$0E,$5F,$0E,$05,$5F,$00,$0C,$04,$11,$08
.byte $02,$00,$5F,$08,$0D,$02,$6B,$FF,$03,$88,$03,$0F,$11,$0E,$09,$04
.byte $02,$13,$5F,$03,$08,$11,$04,$02,$13,$0E,$11,$FF,$01,$0D,$12,$07
.byte $08,$06,$04,$11,$14,$5F,$0E,$13,$00,$FF,$02,$84,$03,$00,$0C,$04
.byte $11,$08,$02,$00,$0D,$5F,$12,$02,$11,$04,$04,$0D,$5F,$13,$04,$17
.byte $13,$FF,$01,$0D,$12,$02,$0E,$13,$13,$5F,$0F,$04,$0B,$0B,$00,$0D
.byte $03,$FF,$02,$84,$03,$00,$12,$12,$08,$12,$13,$04,$03,$5F,$01,$18
.byte $FF,$01,$0D,$03,$00,$18,$15,$5F,$01,$11,$0E,$0E,$0A,$12,$FF,$02
.byte $0D,$00,$0D,$03,$FF,$01,$0D,$01,$11,$08,$00,$0D,$5F,$0C,$08,$0B
.byte $0B,$04,$11,$FF,$02,$83,$03,$13,$11,$00,$0D,$12,$0B,$00,$13,$08
.byte $0E,$0D,$5F,$00,$12,$12,$08,$12,$13,$00,$0D,$02,$04,$FF,$01,$0D
.byte $13,$0E,$12,$07,$08,$0A,$0E,$5F,$16,$00,$13,$12,$0E,$0D,$FF,$02
.byte $88,$03,$0F,$14,$01,$0B,$08,$12,$07,$04,$11,$FF,$01,$0D,$18,$00
.byte $12,$14,$07,$08,$11,$0E,$5F,$05,$14,$0A,$14,$12,$07,$08,$0C,$00
.byte $FF,$02,$87,$07,$02,$0E,$0F,$18,$11,$08,$06,$07,$13,$5F,$1B,$23
.byte $23,$1A,$5F,$1B,$23,$22,$21,$FF,$03,$07,$2A,$5F,$00,$11,$0C,$0E
.byte $11,$5F,$0F,$11,$0E,$09,$04,$02,$13,$FF,$03,$07,$2A,$5F,$01,$08
.byte $11,$03,$5F,$12,$13,$14,$03,$08,$0E,$FF,$03,$07,$2A,$5F,$0A,$0E
.byte $08,$02,$07,$08,$5F,$12,$14,$06,$08,$18,$00,$0C,$00,$FF,$03,$07
.byte $2A,$5F,$24,$25,$26,$27,$5F,$12,$0E,$05,$13,$FF,$FF,$03,$03,$03
.byte $03,$01,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$09,$2A,$5F
.byte $04,$0D,$08,$17,$5F,$1B,$23,$23,$1A,$FF,$03,$D2,$0F,$2B,$2C,$2D
.byte $FF,$00,$0E,$2E,$2F,$30,$31,$FF,$00,$0E,$32,$33,$34,$35,$FF,$00
.byte $0E,$36,$37,$38,$39,$FF,$00,$0E
.byte $3A,$3B,$3C,$3D
.byte $FF,$00
.byte $8E
.byte $FF
; data load target (from $9E07)
.byte $C8
; indirect data load target (via $87C6)
.byte $87
; indirect data load target
.byte $0F
; indirect data load target
.byte $27
; indirect data load target
.byte $17
; indirect data load target
.byte $07
; indirect data load target
.byte $20
; indirect data load target
.byte $10
; indirect data load target
.byte $00
; indirect data load target
.byte $0F
; indirect data load target
.byte $0F
; indirect data load target
.byte $0F
; indirect data load target
.byte $0F
; indirect data load target
.byte $0F
; indirect data load target
.byte $0F
; indirect data load target
.byte $0F
; indirect data load target
.byte $0F
; indirect data load target
.byte $0F
; indirect data load target
.byte $0F
; indirect data load target
.byte $30
; indirect data load target
.byte $10
; indirect data load target
.byte $00
; indirect data load target
.byte $2C
; indirect data load target
.byte $1C
; indirect data load target
.byte $0C
; indirect data load target
.byte $31
; indirect data load target
.byte $21
; data load target (from $9FFF)
.byte $11
; data load target (from $A004)
.byte $E4

.byte $87
; data -> chr
; 2bpp tiles
; ending graphics
; indirect CHR load target (via $87E2)
.incbin "../../split/us/gfx/end.bin"


; chr -> code
; control flow target (from $80DA)
    lda $838A
    sta $6D
    lda $838B
    sta $6E
    lda #$FF
    jsr $82E4
    lda #$00
    sta $2001 ; PPU Control Register #2 (#$E0: Full Background Colour, #$01 set [None, Green, Blue, Red], #$E0: Colour Intensity, #$01 not set [None, Green, Blue, Red], #$10: Sprite Visibility, #$80: Background Visibility, #$40: No Sprite Clipping, #$20: No Background Clipping, #$01: Monochrome Display)

    lda #$00
    sta $04
    sta $05
    sta $06
    jsr $9FFC ; copy $87E4-$9EE3 to VRAM $0000-$16FF; overshoots and copies $10F bytes of code too :/

    jsr $A038
    lda #$18
    sta $2001 ; PPU Control Register #2 (#$E0: Full Background Colour, #$01 set [None, Green, Blue, Red], #$E0: Colour Intensity, #$01 not set [None, Green, Blue, Red], #$10: Sprite Visibility, #$80: Background Visibility, #$40: No Sprite Clipping, #$20: No Background Clipping, #$01: Monochrome Display)

    jsr $9DFF

; code -> data
; indirect data load target

.byte $60
; data -> code
; control flow target (from $9DFB)
    jsr $9E68
    lda $87C6
    sta $6D
    lda $87C7
    sta $6E
    lda #$FF
    jsr $830A
    ldx #$64
; call to code in a different bank ($0F:$C1EE)
    jsr $C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

    jsr $9F0B
; call to code in a different bank ($0F:$C1DC)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

; control flow target (from $9E65)
    jsr $9E68
    lda #$06
    sta $6D
; control flow target (from $9E51)
B09_9E23:
    lda #$08
    sta $6E
    ldy #$00
; control flow target (from $9E38)
B09_9E29:
    lda $0221,Y
    clc
    adc #$08
    sta $0221,Y
    iny
    iny
    iny
    iny
    dec $6E
    bne B09_9E29
    lda $6D
    cmp #$05
    bcc B09_9E46
    inc $0241
    inc $0245
; control flow target (from $9E3E)
B09_9E46:
    tya
    lsr
    lsr
    lsr
    lsr
    tax
; call to code in a different bank ($0F:$C1EE)
    jsr $C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

    dec $6D
    bne B09_9E23
    jsr $9E68
    jsr $9EA4
    ldx #$FF
; call to code in a different bank ($0F:$C1EE)
    jsr $C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

; call to code in a different bank ($0F:$C3AB)
    jsr $C3AB ; generate a random number and store it in $32-$33 (two passes)

    tax
; call to code in a different bank ($0F:$C1EE)
    jsr $C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

    jmp $9E1C

; control flow target (from $9DFF, $9E1C, $9E53)
    jsr $9E97
    ldy #$00
    sty $0221
    iny
    sty $0225
    iny
    sty $0229
    iny
    sty $022D
    iny
    sty $0231
    iny
    sty $0235
    iny
    sty $0239
    iny
    sty $023D
    lda #$57
    sta $0241
    lda #$5B
    sta $0245
    rts

; control flow target (from $9E68, $9EFE)
    ldx #$1F
    lda #$F7
; control flow target (from $9EA1)
B09_9E9B:
    sta $0200,X ; sprite buffer start

    dex
    cpx #$FF
    bne B09_9E9B
    rts

; control flow target (from $9E56)
    lda #$57
    sta $0241
    lda #$5B
    sta $0245
    txa
    pha
    tya
    pha
    lda #$8C
    sta $71
    lda #$8B
    sta $72
    lda #$00
    tay
    lda #$05
    sta $73
; control flow target (from $9F04)
B09_9EC1:
    ldx #$00
; control flow target (from $9EEB)
B09_9EC3:
    lda $A329,Y
    cmp #$FF
    beq B09_9EED
    clc
    adc $71
    sta $0203,X
    iny
    lda $A329,Y
    clc
    adc $72
    sta $0200,X ; sprite buffer start

    iny
    lda $A329,Y
    sta $0201,X
    lda #$01
    sta $0202,X
    inx
    inx
    inx
    inx
    iny
    bne B09_9EC3
; control flow target (from $9EC8)
B09_9EED:
    lda $73
    bne B09_9EFB
    lda #$5A
    sta $0241
    lda #$5E
    sta $0245
; control flow target (from $9EEF)
; call to code in a different bank ($0F:$C1DC)
B09_9EFB:
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    jsr $9E97
    iny
    dec $73
    bne B09_9EC1
    pla
    tay
    pla
    tax
    rts

; control flow target (from $9E16)
    tya
    pha
    txa
    pha
    lda #$00
    sta $77
    lda #$04
    sta $78
; control flow target (from $9F4B)
B09_9F17:
    ldx $02
    lda $77
    sta $74
    lda #$14
    sta $76
; control flow target (from $9F3E)
B09_9F21:
    lda #$15
    sta $0300,X ; PPU write buffer start

    lda $74
    sta $0301,X
    lda #$00
    sta $0302,X
    lda $74
    clc
    adc #$04
    sta $74
    inx
    inx
    inx
    inc $01
    dec $76
    bne B09_9F21
    stx $02
    ldx #$08
; call to code in a different bank ($0F:$C1EE)
    jsr $C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

    inc $77
    dec $78
    bne B09_9F17
    ldx #$D3
    lda #$F7
; control flow target (from $9F57)
B09_9F51:
    sta $0200,X ; sprite buffer start

    dex
    cpx #$5F
    bne B09_9F51
; call to code in a different bank ($0F:$C1DC)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    ldy #$00
    ldx $02
; control flow target (from $9F91)
B09_9F60:
    lda $9FEC,Y
    sta $0301,X
    clc
    adc #$01
    sta $0304,X
    lda $9FED,Y
    sta $0300,X ; PPU write buffer start

    sta $0303,X
    lda $9FEE,Y
    sta $0302,X
    lda $9FEF,Y
    sta $0305,X
    inc $01
    inc $01
    txa
    clc
    adc #$06
    tax
    tya
    clc
    adc #$04
    tay
    cpy #$10
    bcc B09_9F60
    stx $02
; call to code in a different bank ($0F:$C1DC)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    ldx $02
    lda #$08
    sta $78
    lda #$FE
    sta $76
    lda #$7F
    sta $75
; control flow target (from $9FE5)
B09_9FA6:
    lda #$50
    sta $77
; control flow target (from $9FD6)
B09_9FAA:
    lda #$15
    sta $0300,X ; PPU write buffer start

    sta $0303,X
    lda $77
    sta $0301,X
    clc
    adc #$10
    sta $0304,X
    lda $76
    sta $0302,X
    lda $75
    sta $0305,X
    txa
    clc
    adc #$06
    tax
    inc $77
    inc $01
    inc $01
    lda $01
    cmp #$10
    bcc B09_9FAA
    stx $02
    ldx #$04
; call to code in a different bank ($0F:$C1EE)
    jsr $C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

    asl $76
    lsr $75
    dec $78
    bne B09_9FA6
    pla
    tax
    pla
    tay
    rts


; code -> data
; indexed data load target (from $9F60)
; indexed data load target (from $9F6C)
.byte $0C
; indexed data load target (from $9F75)
.byte $21
; indexed data load target (from $9F7B)
.byte $DD

.byte $DE,$15,$21,$00,$01,$2C,$21
.byte $ED,$EE,$35
.byte $21,$10
.byte $11
; data -> code
; copy $87E4-$9EE3 to VRAM $0000-$16FF; overshoots and copies $10F bytes of code too :/
; control flow target (from $9DF0)
; call to code in a different bank ($0F:$C1DC)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

; WARNING! $9FFF was also seen as data
    lda $87E2
    sta $6D
    lda $87E3
    sta $6E
    lda #$17
    sta $6F
    ldy #$00
    sty $71
    sty $72
; control flow target (from $A035)
B09_A013:
    lda $2002 ; PPU Status Register (#$80: In VBlank, #$40: Sprite #0 Hit, #$20: Scanline Sprite Count > 8, #$10: Ignore VRAM Writes); after read, #$80 and $2005-$2006 are reset

    lda $72
    sta $2006 ; VRAM Address Register #2 (write twice; $2007 address)

    lda $71
    sta $2006 ; VRAM Address Register #2 (write twice; $2007 address)

; control flow target (from $A02C)
B09_A020:
    lda ($6D),Y
    sta $2007 ; VRAM I/O Register

    inc $71
    bne B09_A02B
    inc $72
; control flow target (from $A027)
B09_A02B:
    iny
    bne B09_A020
; call to code in a different bank ($0F:$C1DC)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    inc $6E
    dec $6F
    bne B09_A013
    rts

; control flow target (from $9DF3)
    jsr $A03F
    jsr $A084
    rts

; control flow target (from $A038)
; call to code in a different bank ($0F:$C1DC)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    lda $A0F8
    sta $6D
    lda $A0F9
    sta $6E
; control flow target (from $A080)
    lda $2002 ; PPU Status Register (#$80: In VBlank, #$40: Sprite #0 Hit, #$20: Scanline Sprite Count > 8, #$10: Ignore VRAM Writes); after read, #$80 and $2005-$2006 are reset

    ldy #$00
    lda ($6D),Y
    cmp #$FF
    beq B09_A083
    pha
    iny
    lda ($6D),Y
    sta $2006 ; VRAM Address Register #2 (write twice; $2007 address)

    pla
    sta $2006 ; VRAM Address Register #2 (write twice; $2007 address)

; control flow target (from $A06C)
    iny
    lda ($6D),Y
    cmp #$FF
    beq B09_A06F
    sta $2007 ; VRAM I/O Register

    jmp $A062

; control flow target (from $A067)
B09_A06F:
    iny
    sty $6F
    lda $6D
    clc
    adc $6F
    sta $6D
    bcc B09_A07D
    inc $6E
; control flow target (from $A079)
; call to code in a different bank ($0F:$C1DC)
B09_A07D:
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    jmp $A04C

; control flow target (from $A055)
B09_A083:
    rts

; control flow target (from $A03B)
    lda $A0F6
    sta $6D
    lda $A0F7
    sta $6E
    ldx #$00
    stx $70
; control flow target (from $A0F0)
    ldy #$00
    lda ($6D),Y
    cmp #$FF
    beq B09_A0F3
    sta $6F
; control flow target (from $A0DE)
B09_A09C:
    iny
    lda ($6D),Y
    sta $0223,X
    iny
    lda ($6D),Y
    sta $0220,X
    lda $6F
    sta $0222,X
    lda $70
    bne B09_A0D0
    iny
    lda ($6D),Y
    sta $0221,X
    lda $0220,X
    sta $0224,X
    lda $0222,X
    sta $0226,X
    lda $0223,X
    clc
    adc #$08
    sta $0227,X
    inx
    inx
    inx
    inx
; control flow target (from $A0AF)
B09_A0D0:
    iny
    lda ($6D),Y
    php
    and #$7F
    sta $0221,X
    inx
    inx
    inx
    inx
    plp
    bpl B09_A09C
    iny
    sty $6F
    lda $6D
    clc
    adc $6F
    sta $6D
    bcc B09_A0EE
    inc $6E
; control flow target (from $A0EA)
B09_A0EE:
    stx $70
    jmp $A092

; control flow target (from $A098)
; call to code in a different bank ($0F:$C1DC)
B09_A0F3:
    jmp $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF



; code -> data
; data load target (from $A084)
; data load target (from $A089)
.byte $94
; data load target (from $A042)
.byte $A2
; data load target (from $A047)
.byte $FA
; format: 2 byte PPU address + data to write + FF
.byte $A0
; indirect data load target (via $A0F8)
; indirect data load target
.byte $AF,$20,$0C,$0D
.byte $0E,$0F
.byte $FF
; indirect data load target
.byte $CF,$20,$1C,$1D
.byte $1E,$1F
.byte $FF
; indirect data load target
.byte $EE,$20,$D6,$D7,$D8
.byte $D9,$DA,$DB
.byte $DC
.byte $FF
; indirect data load target
.byte $0E,$21,$E6,$E7,$E8
.byte $E9,$EA,$EB
.byte $EC
.byte $FF
; indirect data load target
.byte $2E,$21,$F6,$F7,$F8
.byte $F9,$FA,$FB
.byte $FC
.byte $FF
; indirect data load target
.byte $6E,$21,$15,$14,$15
.byte $F0,$14,$15
.byte $14
.byte $FF
; indirect data load target
.byte $8B,$21,$15,$04,$05,$04,$05,$04
.byte $05,$04,$05,$04
.byte $05,$14
.byte $FF
; indirect data load target
.byte $A9,$21,$14,$05,$12,$13,$12,$13,$02,$03
.byte $D1,$03,$02,$13,$12
.byte $13,$04
.byte $15
.byte $FF
; indirect data load target
.byte $C8,$21,$14,$05,$12,$03,$02,$03,$22,$23,$E0
.byte $E1,$E2,$23,$22,$03
.byte $02,$13,$04
.byte $15
.byte $FF
; indirect data load target
.byte $E8,$21,$05,$04,$13,$02,$03,$22,$23,$22,$D3
.byte $D4,$D5,$22,$23,$22
.byte $03,$12,$05
.byte $04
.byte $FF
; indirect data load target
.byte $08,$22,$04,$05,$12,$03,$02,$03,$22,$23,$22
.byte $E4,$22,$23,$22,$03
.byte $02,$13,$04
.byte $05
.byte $FF
; indirect data load target
.byte $29,$22,$14,$13,$02,$03,$02,$03,$02,$03
.byte $F4,$03,$02,$03,$02
.byte $03,$12,$05
.byte $14
.byte $FF
; indirect data load target
.byte $4A,$22,$04,$13,$12,$13,$12,$13,$12
.byte $58,$59,$5A,$5B,$13
.byte $12,$05
.byte $14
.byte $FF
; indirect data load target
.byte $6B,$22,$04,$05,$64,$65,$66,$67
.byte $68,$69,$6A,$6B
.byte $04,$05
.byte $FF
; indirect data load target
.byte $89,$22,$70,$71,$72,$73,$74,$75,$76
.byte $77,$78,$79,$7A,$7B
.byte $7C,$7D
.byte $7E
.byte $FF
; indirect data load target
.byte $A8,$22,$4F,$80,$81,$82,$83,$84,$85,$86
.byte $87,$88,$89,$8A,$8B
.byte $8C,$8D,$8E
.byte $8F
.byte $FF
; indirect data load target
.byte $C7,$22,$5E,$5D,$90,$91,$92,$93,$94,$95,$96
.byte $97,$98,$99,$9A,$9B
.byte $9C,$9D,$9E
.byte $9F
.byte $FF
; indirect data load target
.byte $E7,$22,$6E,$6F,$A0,$A1,$A2,$A3,$A4,$A5,$A6
.byte $A7,$A8,$A9,$AA,$AB
.byte $AC,$AD,$AE
.byte $AF
.byte $FF
; indirect data load target
.byte $08,$23,$7F,$B0,$B1,$B2,$B3,$B4,$B5,$B6
.byte $B7,$B8,$B9,$BA,$BB
.byte $BC,$BD,$BE
.byte $BF
.byte $FF
; indirect data load target
.byte $28,$23,$4C,$43,$C1,$C2,$C3,$C4,$C5,$C6
.byte $C7,$C8,$C9,$CA,$CB
.byte $CC,$CD
.byte $CE
.byte $FF
; indirect data load target
.byte $4A,$23,$40,$4C,$4A,$4A,$4A,$4A
.byte $4A,$4A,$4A,$4A
.byte $4B,$4C
.byte $FF
; indirect data load target
.byte $C0,$23,$00,$00,$00,$49,$50,$10,$00,$00,$00,$00,$00,$44,$55,$55
.byte $00,$00,$00,$00,$00,$05,$05,$05,$00,$00
.byte $00,$00,$00,$00,$00
.byte $00,$00
.byte $00
.byte $FF
; indirect data load target
.byte $E0,$23,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00
.byte $00,$00
.byte $00
.byte $FF

.byte $FF
; data -> unknown

.byte $FF
; unknown -> data
; indirect data load target (via $A0F6)
; indirect data load target
.byte $01
; indirect data load target
.byte $84
; indirect data load target
.byte $77
; indirect data load target
.byte $00
; indirect data load target
.byte $01
; indirect data load target
.byte $84
; indirect data load target
.byte $7F
; indirect data load target
.byte $02
; indirect data load target
.byte $03
; indirect data load target
.byte $84
; indirect data load target
.byte $87
; indirect data load target
.byte $04
; indirect data load target
.byte $05
; indirect data load target
.byte $84
; indirect data load target
.byte $8F
; indirect data load target
.byte $06
; indirect data load target
.byte $87
; indirect data load target
.byte $02
; indirect data load target
.byte $95
; indirect data load target
.byte $A3
; indirect data load target
.byte $57
; indirect data load target
.byte $81
; indirect data load target
.byte $9A
; indirect data load target
.byte $5B
; indirect data load target
.byte $88
; indirect data load target
.byte $71
; indirect data load target
.byte $3B
; indirect data load target
.byte $88
; indirect data load target
.byte $57
; indirect data load target
.byte $38
; indirect data load target
.byte $88
; indirect data load target
.byte $5F
; indirect data load target
.byte $39
; indirect data load target
.byte $88
; indirect data load target
.byte $67
; indirect data load target
.byte $BA
; indirect data load target
.byte $00
; indirect data load target
.byte $78
; indirect data load target
.byte $27
; indirect data load target
.byte $50
; indirect data load target
.byte $80
; indirect data load target
.byte $27
; indirect data load target
.byte $50
; indirect data load target
.byte $88
; indirect data load target
.byte $27
; indirect data load target
.byte $50
; indirect data load target
.byte $90
; indirect data load target
.byte $27
; indirect data load target
.byte $50
; indirect data load target
.byte $78
; indirect data load target
.byte $2F
; indirect data load target
.byte $51
; indirect data load target
.byte $80
; indirect data load target
.byte $2F
; indirect data load target
.byte $51
; indirect data load target
.byte $88
; indirect data load target
.byte $2F
; indirect data load target
.byte $51
; indirect data load target
.byte $90
; indirect data load target
.byte $2F
; indirect data load target
.byte $51
; indirect data load target
.byte $70
; indirect data load target
.byte $37
; indirect data load target
.byte $52
; indirect data load target
.byte $78
; indirect data load target
.byte $37
; indirect data load target
.byte $52
; indirect data load target
.byte $80
; indirect data load target
.byte $37
; indirect data load target
.byte $52
; indirect data load target
.byte $88
; indirect data load target
.byte $37
; indirect data load target
.byte $52
; indirect data load target
.byte $90
; indirect data load target
.byte $37
; indirect data load target
.byte $52
; indirect data load target
.byte $98
; indirect data load target
.byte $37
; indirect data load target
.byte $52
; indirect data load target
.byte $A0
; indirect data load target
.byte $37
; indirect data load target
.byte $52
; indirect data load target
.byte $70
; indirect data load target
.byte $3F
; indirect data load target
.byte $53
; indirect data load target
.byte $78
; indirect data load target
.byte $3F
; indirect data load target
.byte $53
; indirect data load target
.byte $80
; indirect data load target
.byte $3F
; indirect data load target
.byte $53
; indirect data load target
.byte $88
; indirect data load target
.byte $3F
; indirect data load target
.byte $53
; indirect data load target
.byte $90
; indirect data load target
.byte $3F
; indirect data load target
.byte $53
; indirect data load target
.byte $98
; indirect data load target
.byte $3F
; indirect data load target
.byte $53
; indirect data load target
.byte $A0
; indirect data load target
.byte $3F
; indirect data load target
.byte $52
; indirect data load target
.byte $70
; indirect data load target
.byte $47
; indirect data load target
.byte $54
; indirect data load target
.byte $78
; indirect data load target
.byte $47
; indirect data load target
.byte $54
; indirect data load target
.byte $80
; indirect data load target
.byte $47
; indirect data load target
.byte $54
; indirect data load target
.byte $88
; indirect data load target
.byte $47
; indirect data load target
.byte $54
; indirect data load target
.byte $90
; indirect data load target
.byte $47
; indirect data load target
.byte $54
; indirect data load target
.byte $98
; indirect data load target
.byte $47
; indirect data load target
.byte $54
; indirect data load target
.byte $A0
; indirect data load target
.byte $47
; indirect data load target
.byte $54
; indirect data load target
.byte $60
; indirect data load target
.byte $40
; indirect data load target
.byte $55
; indirect data load target
.byte $68
; indirect data load target
.byte $40
; indirect data load target
.byte $55
; indirect data load target
.byte $A8
; indirect data load target
.byte $40
; indirect data load target
.byte $56
; indirect data load target
.byte $B0
; indirect data load target
.byte $40
; indirect data load target
.byte $56
; indirect data load target
.byte $60
; indirect data load target
.byte $48
; indirect data load target
.byte $55
; indirect data load target
.byte $68
; indirect data load target
.byte $48
; indirect data load target
.byte $55
; indirect data load target
.byte $A8
; indirect data load target
.byte $48
; indirect data load target
.byte $56
; indirect data load target
.byte $B0
; indirect data load target
.byte $48
; indirect data load target
.byte $D6
; indexed data load target (from $9EC3, $9ED1, $9EDB)
.byte $FF

.byte $00,$00,$3F,$FF,$00,$00,$40,$FF,$00,$00,$41,$FF,$FC,$FC,$42,$04
.byte $FC,$43,$FC,$04,$44,$04,$04,$45,$FF,$08
.byte $F8,$4D,$00,$00,$4E
.byte $F8,$08
.byte $4F
.byte $FF
; data -> free
.res $1cb1
; ... skipping $1CB1 FF bytes
.byte $FF

.byte $FF
; free -> data
.byte $FF
