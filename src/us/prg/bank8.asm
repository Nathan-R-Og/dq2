.segment        "PRG8":absolute
; code bytes:	$0479 (6.99% of bytes in this ROM bank)
; data bytes:	$0DC8 (21.53% of bytes in this ROM bank)
; pcm bytes:	$0000 (0.00% of bytes in this ROM bank)
; chr bytes:	$1EF0 (48.34% of bytes in this ROM bank)
; free bytes:	$0E3F (22.26% of bytes in this ROM bank)
; unknown bytes:	$0090 (0.88% of bytes in this ROM bank)
; $3131 bytes last seen in RAM bank $8000 - $BFFF (100.00% of bytes seen in this ROM bank, 76.86% of bytes in this ROM bank):
;	$0479 code bytes (9.09% of bytes seen in this RAM bank, 6.99% of bytes in this ROM bank)
;	$0DC8 data bytes (28.02% of bytes seen in this RAM bank, 21.53% of bytes in this ROM bank)
;	$1EF0 chr bytes (62.89% of bytes seen in this RAM bank, 48.34% of bytes in this ROM bank)

; PRG Bank 0x08: haven't looked at this much, probably contains title screen stuff

; [bank start] -> data
; from $0F:$C699
; possible external indexed data load target (from $0F:$F3ED, $0F:$FF28)
; external indirect data load target (via $0F:$C699)
; possible external indexed data load target (from $0F:$F3F2, $0F:$FF2D)
; data -> code
.byte $02,$80
; from $0F:$C699 via $8000
; indirect control flow target (via $8000)
    jsr $8024
    jsr $8058
    jsr $80E9
    jsr $81EC
; control flow target (from $8013)
B08_800E:
    jsr $830B
    lda $99
    beq B08_800E
; call to code in a different bank ($0F:$C577)
    jsr $C577 ; set $6144 to #$05

; call to code in a different bank ($0F:$C42A)
    jsr $C42A
; call to code in a different bank ($0F:$C3E8)
    jsr $C3E8 ; wait for interrupt, set $6007 to #$FF, turn screen off

; call to code in a different bank ($0F:$C446)
    jsr $C446 ; turn screen off, write $800 [space] tiles to PPU $2000, turn screen on

; call to code in a different bank ($0F:$C468)
    jmp $C468 ; set every 4th byte of $0200 - $02FC to #$F0


; control flow target (from $8002)
    ldx #$00
    stx $05
    stx $06
    stx $04
    stx $99
    stx $A5
    stx $60
    stx $60F2
    stx $60F3
    stx $60F4
    stx $6008
    dex
    stx $0201
    stx $020D
    stx $0219
    jsr $80D3
    lda #$0F
    sta $30
; call to code in a different bank ($0F:$C1DC)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    lda #$1E
    sta $2001 ; PPU Control Register #2 (#$E0: Full Background Colour, #$01 set [None, Green, Blue, Red], #$E0: Colour Intensity, #$01 not set [None, Green, Blue, Red], #$10: Sprite Visibility, #$80: Background Visibility, #$40: No Sprite Clipping, #$20: No Background Clipping, #$01: Monochrome Display)

    rts

; control flow target (from $8005)
    jsr $83F7
    ldy #$00
    sty $0201
; control flow target (from $80A5)
B08_8060:
    tya
    pha
    lda $8420,Y
    cmp #$FF
    beq B08_80A7
    pha
    lda $8447,Y
    jsr $81D3
    ldx #$00
    jsr $819F
    jsr $80D8
    pla
    ldx #$09
    jsr $82A9
    pla
    tax
    pha
    lda #$00
    sta $03 ; game clock?

    lda $8420,X
    sec
    sbc #$06
    sta $60F2
    jsr $822F
    pla
    tay
    pha
    lda $8447,Y
    jsr $81D3
    jsr $830B
    ldx #$0E
    jsr $8304
    pla
    tay
    iny
    bne B08_8060
; control flow target (from $8067)
B08_80A7:
    pla
    ldx #$1F
; control flow target (from $80BA)
B08_80AA:
    lda $8400,X
    sta $600B,X
    cpx #$10
    bcs B08_80B9
    lda #$01
    sta $606B,X
; control flow target (from $80B2)
B08_80B9:
    dex
    bpl B08_80AA
    lda #$42
    sta $607B
    lda #$77
    sta $607C
    jsr $830B
; call to code in a different bank ($0F:$FE97)
    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $C0
; data -> code
    jsr $80D8
    jmp $830B

; control flow target (from $8048)
    pha
    ldx #$00
    beq B08_80DB
; control flow target (from $8075, $80CD, $815E)
    pha
    ldx #$24
; control flow target (from $80D6)
B08_80DB:
    lda #$F7
; control flow target (from $80E4)
B08_80DD:
    sta $0200,X ; sprite buffer start

    inx
    inx
    inx
    inx
    bne B08_80DD
    pla
    rts

; control flow target (from $8101)
B08_80E8:
    rts

; control flow target (from $8008)
    jsr $83F7
    ldy #$00
    sty $60F1 ; start of text variable buffer

    sty $020D
    sty $0219
    sty $03 ; game clock?

; control flow target (from $819C)
    ldy $60F1 ; start of text variable buffer

    lda $84EB,Y
    cmp #$FF
    beq B08_80E8
    pha
    lda $846D,Y
    ldx #$02
    jsr $819F
    ldy $60F1 ; start of text variable buffer

    lda $8497,Y
    ldx #$01
    jsr $819F
    pla
    asl
    tax
    lda $A6C2,X
    sta $6D
    lda $A6C3,X
    sta $6E
    ldy $60F1 ; start of text variable buffer

    lda $84C1,Y
    pha
    ldy #$02
    lda ($6D),Y
    and #$E0
    tax
    pla
    ldy #$20
    jsr $A5E7
    jsr $830B
    ldy $60F1 ; start of text variable buffer

    lda $856D,Y
    asl
    tax
    lda $A6C2,X
    sta $6D
    lda $A6C3,X
    sta $6E
    lda $8543,Y
    pha
    ldy #$02
    lda ($6D),Y
    and #$E0
    tax
    pla
    ldy #$20
    jsr $A5E7
    jsr $80D8
    ldy $60F1 ; start of text variable buffer

    lda $856D,Y
    ldx #$20
    jsr $82A9
    ldy $60F1 ; start of text variable buffer

    lda $84EB,Y
    ldx #$09
    jsr $82A9
    ldy $60F1 ; start of text variable buffer

    lda $8517,Y
    sta $60F3
    sta $60F4
    lda #$00
    sta $03 ; game clock?

    ldx $60F1 ; start of text variable buffer

    jsr $8263
    ldy $60F1 ; start of text variable buffer

    lda $846D,Y
    jsr $81D3
    jsr $830B
    inc $60F1 ; start of text variable buffer

    jmp $80F9

; control flow target (from $8072, $8109, $8114)
    pha
    lda #$BF
    sta $0300 ; PPU write buffer start

    lda #$03
    sta $0301
    txa
    asl
    asl
    adc #$11
    sta $0302
    pla
    sta $6D
    asl
    adc $6D
    tay
    ldx #$00
; control flow target (from $81C5)
B08_81BB:
    lda $86A1,Y
    sta $0303,X
    iny
    inx
    cpx #$03
    bcc B08_81BB
; control flow target (from $821E)
    lda #$01
    sta $01
    sta $02
    sta $0183
    jmp $830B

; control flow target (from $806D, $8097, $8193)
    pha
    and #$03
    clc
    adc #$1A
    ora #$80
    pha
    tya
    lsr
    pla
    ldx $99
    beq B08_81E5
    lda #$80 ; Music ID #$80: SFX off

; control flow target (from $81E1)
B08_81E5:
    bcc B08_81EA
; call to code in a different bank ($0F:$C561)
    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

; control flow target (from $81E5)
B08_81EA:
    pla
    rts

; control flow target (from $800B)
    jsr $83F7
    ldx #$46
    jsr $8304
    lda #$0B ; Music ID #$0B: title theme part 1 BGM

; call to code in a different bank ($0F:$C561)
    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    ldx #$FF
    jsr $8304
    ldx #$FF
    jsr $8304
    ldx #$36
    jsr $8304
    lda $99
    bne B08_8221
    lda #$1A ; Music ID #$1A: title theme part 2 BGM

; call to code in a different bank ($0F:$C561)
    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    ldx #$00
; control flow target (from $821C)
B08_8213:
    lda $8222,X
    sta $0300,X ; PPU write buffer start

    inx
    cpx #$0D
    bcc B08_8213
    jsr $81C7
; control flow target (from $820A)
B08_8221:
    rts


; code -> data
; indexed data load target (from $8213)

.byte $A1,$0A,$6B,$C0,$C1,$C2,$C3
.byte $F1,$D0,$D1
.byte $D2,$D3
.byte $D4
; data -> code
; control flow target (from $808E, $8263)
    txa
    sec
    sbc #$23
    bcc B08_8262
    cmp #$02
    bcc B08_823B
    lda #$02
; control flow target (from $8237)
B08_823B:
    asl
    tax
    lda $86C5,X
    sta $0303
    lda $86C6,X
    sta $0304
    lda #$02
    sta $0301
    lda #$BF
    sta $0300 ; PPU write buffer start

    lda #$01
    sta $0302
    sta $01
    sta $0183
    lda #$05
    sta $02
    sec
; control flow target (from $8233, $8266, $826F)
B08_8262:
    rts

; control flow target (from $818A)
    jsr $822F
    bcc B08_8262
    lda #$09
    sta $0302
    dex
    dex
    bmi B08_8262
    txa
    asl
    sta $6E
    asl
    asl
    adc $6E
    tax
    ldy #$00
; control flow target (from $8286)
B08_827C:
    lda $86CB,X
    sta $0305,Y
    inx
    iny
    cpy #$19
    bcc B08_827C
    lda #$06
    sta $01
    dec $6008
    rts

    ldx $99
    bne B08_82A8
    sta $0C
; control flow target (from $82A6)
; call to code in a different bank ($0F:$C1DC)
B08_8296:
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

; call to code in a different bank ($0F:$C476)
    jsr $C476 ; read joypad 1 data into $2F

    lda $2F ; joypad 1 data

    beq B08_82A4
    inc $99
    bne B08_82A8
; control flow target (from $829E)
B08_82A4:
    dec $0C
    bne B08_8296
; control flow target (from $8292, $82A2)
B08_82A8:
    rts

; control flow target (from $807B, $8169, $8174)
    ldy $99
    bne B08_82B0
    jsr $82B1
; control flow target (from $82AB)
B08_82B0:
    rts

; control flow target (from $82AD)
    pha
    lda #$00
    sta $70
    sta $71
    sta $72
    pla
    stx $6F
    asl
    tax
    lda $A6C2,X
    sta $6D
    lda $A6C3,X
    sta $6E
    ldy #$00
; control flow target (from $8301)
B08_82CB:
    lda $6F
    asl
    asl
    tax
    lda ($6D),Y
    cmp #$FF
    beq B08_8303
    clc
    adc $70
    sta $0203,X
    iny
    lda ($6D),Y
    clc
    adc $71
    bcs B08_82E8
    cmp #$F8
    bcc B08_82EA
; control flow target (from $82E2)
B08_82E8:
    lda #$F8
; control flow target (from $82E6)
B08_82EA:
    sec
    sbc #$01
    sta $0200,X ; sprite buffer start

    iny
    lda ($6D),Y
    sta $0201,X
    iny
    lda ($6D),Y
    ora $72
    sta $0202,X
    iny
    inc $6F
    bne B08_82CB
; control flow target (from $82D4)
B08_8303:
    rts

; control flow target (from $809F, $81F1, $81FB, $8200, $8205, $8308)
B08_8304:
    jsr $830B
    dex
    bne B08_8304
    rts

; control flow target (from $800E, $809A, $80C6, $80D0, $8138, $8196, $81D0, $8304, $A658)
    lda $03 ; game clock?

    and #$07
    bne B08_832A
    txa
    pha
    tya
    pha
    jsr $834F
    pla
    tay
    pla
    tax
    inc $60
    lda $60
    and #$03
    cmp #$03
    bne B08_832A
    lda #$00
    sta $60
; control flow target (from $830F, $8324)
B08_832A:
    lda $99
    bne B08_834A
; call to code in a different bank ($0F:$C1DC)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    txa
    pha
    tya
    pha
; call to code in a different bank ($0F:$C476)
    jsr $C476 ; read joypad 1 data into $2F

    pla
    tay
    pla
    tax
    lda $2F ; joypad 1 data

    and #$08 ; Start

    beq B08_8344
    inc $99
; control flow target (from $8340)
B08_8344:
    lda #$00
    sta $6008
    rts

; control flow target (from $832C)
B08_834A:
    lda #$00
    sta $02
    rts

; control flow target (from $8315)
    ldx #$00
; control flow target (from $83C4)
B08_8351:
    txa
    pha
    asl
    asl
    sta $5A ; Crest/direction name write buffer start

    asl
    adc $5A ; Crest/direction name write buffer start

    tax
    lda $0201,X
    cmp #$FF
    beq B08_83BF
    pla
    tay
    pha
    lda $60F2,Y
    asl
    asl
    sta $5B
    adc $60F2,Y
    adc $5B
    pha
    sty $5A ; Crest/direction name write buffer start

    lda $60
    clc
    adc $5A ; Crest/direction name write buffer start

; control flow target (from $837F)
B08_8379:
    cmp #$03
    bcc B08_8383
    sbc #$03
    bcs B08_8379
    lda #$00
; control flow target (from $837B)
B08_8383:
    sta $5A ; Crest/direction name write buffer start

    asl
    adc $5A ; Crest/direction name write buffer start

    sta $5A ; Crest/direction name write buffer start

    pla
    adc $5A ; Crest/direction name write buffer start

    sta $5C
    lda $60F2,Y
    asl
    adc $60F2,Y
    sty $5A ; Crest/direction name write buffer start

    adc $5A ; Crest/direction name write buffer start

    tay
    lda $865F,Y
    asl
    sta $5A ; Crest/direction name write buffer start

    asl
    adc $5A ; Crest/direction name write buffer start

    sta $5E
    lda #$00
    sta $5D
    rol
    sta $5F
    clc
    lda $83FE
    adc $5E
    sta $5E
    lda $83FF
    adc $5F
    sta $5F
    jsr $83C7
; control flow target (from $8360)
B08_83BF:
    pla
    tax
    inx
    cpx #$03
    bcc B08_8351
    rts

; control flow target (from $83BC)
    lda #$03
    sta $5A ; Crest/direction name write buffer start

; control flow target (from $83F4)
B08_83CB:
    ldy $5C
    lda $8599,Y
    sta $0201,X
    ldy $5D
    lda ($5E),Y
    sta $0200,X ; sprite buffer start

    dec $0200,X ; sprite buffer start

    iny
    lda ($5E),Y
    sta $0203,X
    lda #$03
    sta $0202,X
    inx
    inx
    inx
    inx
    inc $5C
    inc $5D
    inc $5D
    dec $5A ; Crest/direction name write buffer start

    bne B08_83CB
    rts

; control flow target (from $8058, $80E9, $81EC)
    lda $99
    beq B08_83FD
    pla
    pla
; control flow target (from $83F9)
B08_83FD:
    rts


; code -> data
; called during main title screen
; data load target (from $83AE)
; data load target (from $83B5)
.byte $37
; indexed data load target (from $80AA)
.byte $B0
; indexed data load target (from $8062, $8085)
.byte $FF,$FF,$FF,$FF,$FF,$8D,$8E,$FF,$9C,$9D,$9E,$9F,$AC,$AD,$AE,$AF
.byte $BC,$BD,$BE,$BF,$CC,$CD,$CE,$CF
.byte $DC,$DD,$DE,$DF
.byte $EC,$ED
.byte $EE
.byte $EF
; indexed data load target (from $806A, $8094)
.byte $06,$07,$08,$07,$06,$07,$08,$07,$06,$07,$09,$0A,$0B,$0A,$09,$0A
.byte $0B,$0A,$0C,$0D,$0E,$0D,$0C,$0D,$11,$10,$0F,$10
.byte $11,$10,$12,$13,$14,$13
.byte $15,$16,$17
.byte $16
.byte $FF
; indexed data load target (from $8104, $8190)
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01
.byte $01,$01,$01,$02,$02,$02
.byte $02,$03,$03
.byte $03
.byte $03

.byte $04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04
.byte $04,$04,$05,$05,$05,$05,$05,$05,$05,$05,$05
.byte $05,$05,$05,$06,$06,$06
.byte $06,$07,$07
.byte $07
.byte $07
; data -> unknown

.byte $07,$07
.byte $07
.byte $07
; unknown -> data
; indexed data load target (from $810F)

.byte $08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08
.byte $08,$08,$09,$09,$09,$09,$09,$09,$09,$09,$09
.byte $09,$09,$09,$0A,$0A,$0A
.byte $0A,$0B,$0B
.byte $0B
.byte $0B
; data -> unknown

.byte $0B,$0B
.byte $0B
.byte $0B
; unknown -> data
; indexed data load target (from $8127)

.byte $00,$01,$02,$01,$00,$01,$02,$01,$00,$01,$05,$04,$03,$04,$05,$04
.byte $03,$04,$06,$07,$08,$07,$06,$07,$0B,$0A,$09
.byte $0A,$0B,$0A,$0C,$0D,$0E
.byte $0D,$11,$10
.byte $0F
.byte $10
; data -> unknown

.byte $12,$13,$12
.byte $10
; unknown -> data
; indexed data load target (from $80FC, $816F)

.byte $18,$19,$18,$19,$18,$19,$18,$19,$18,$19,$1A,$1B,$1A,$1B,$1A,$1B
.byte $1A,$1B,$1C,$1D,$1C,$1D,$1C,$1D,$1E,$1F,$1E,$1F
.byte $1E,$1F,$20,$21,$20,$21
.byte $22,$23,$22
.byte $23
.byte $FF
; data -> unknown

.byte $24,$25,$24
.byte $23
.byte $FF
; unknown -> data
; indexed data load target (from $817A)

.byte $00,$01,$02,$01,$00,$01,$02,$01,$00,$01,$03,$04,$05,$04,$03,$04
.byte $05,$04,$06,$07,$08,$07,$06,$07,$09,$0A,$0B
.byte $0A,$09,$0A,$0C,$0D,$0E
.byte $0D,$0F,$10
.byte $11
.byte $10
; data -> unknown

.byte $FF,$12,$13
.byte $12,$10
.byte $FF
; unknown -> data
; indexed data load target (from $814D)

.byte $14,$15,$16,$15,$14,$15,$16,$15,$14,$15,$19,$18,$17,$18,$19,$18
.byte $17,$18,$1A,$1B,$1C,$1B,$1A,$1B,$1F,$1E,$1D
.byte $1E,$1F,$1E,$20,$21,$22
.byte $21,$25,$24
.byte $23
.byte $24
; data -> unknown

.byte $26,$27,$26
.byte $24
.byte $26
; unknown -> data
; indexed data load target (from $813E, $8164)

.byte $27,$26,$27,$26,$27,$26,$27,$26,$27,$28,$29,$28,$29,$28,$29
.byte $28,$29,$2A,$2B,$2A,$2B,$2A,$2B,$2C,$2D,$2C
.byte $2D,$2C,$2D,$2E,$2F,$2E
.byte $2F,$32,$31
.byte $30
.byte $31
; data -> unknown

.byte $FF,$33,$34
.byte $33,$31
.byte $FF
; unknown -> data
; indexed data load target (from $83CD)

.byte $00,$00,$C6,$00,$00,$C7,$00,$00,$C8,$00,$00,$C6,$00,$00,$C7,$00
.byte $00,$C8,$00,$00,$C6,$00,$00,$C7,$00,$00,$C8,$00,$00,$C9,$00,$00
.byte $CA,$00,$00,$CB,$00,$00,$C9,$00,$00,$CA,$00,$00,$CB,$00,$00,$C9
.byte $00,$00,$CA,$00,$00,$CB,$00,$00,$CC,$00,$00,$CD,$00,$00,$CE,$00
.byte $00,$CC,$00,$00,$CD,$00,$00,$CE,$00,$00,$CC,$00,$00,$CD,$00,$00
.byte $CE,$00,$00,$CF,$00,$00,$D0,$00,$00,$D1,$00,$00,$CF,$00,$00,$D0
.byte $00,$00,$D1,$00,$00,$CF,$00,$00,$D0,$00,$00,$D1,$00,$D2,$D3,$00
.byte $D4,$D5,$00,$D6,$D7,$00,$D2,$D3,$00,$D4,$D5,$00,$D6,$D7,$00,$D2
.byte $D3,$00,$D4,$D5,$00,$D6,$D7,$00,$D8,$D9,$00,$DA,$DB,$00,$DC,$DD
.byte $00,$D8,$D9,$00,$DA,$DB,$00,$DC,$DD
.byte $00,$D8,$D9,$00,$DA
.byte $DB,$00
.byte $DC
.byte $DD
; data -> unknown

.byte $00,$D8,$D9,$00,$DA,$DB,$00,$DC,$DD,$00,$D8,$D9,$00,$DA,$DB,$00
.byte $DC,$DD,$00,$D8,$D9,$00,$DA,$DB,$00,$DC
.byte $DD,$00,$D8,$D9,$00
.byte $DA,$DB,$00
.byte $DC
.byte $DD
; unknown -> data
; indexed data load target (from $839B)

.byte $01,$13,$27,$02,$14,$28,$03,$15,$29,$04,$16,$2A,$05,$17,$2B,$06
.byte $18,$2C,$07,$19,$2D,$08,$1A,$2E,$09,$1B,$2F,$0A,$1C,$30,$0B,$1D
.byte $31,$0C,$1E,$32,$0D,$1F,$33,$0E,$20,$34,$0F
.byte $21,$35,$10,$22,$36,$11
.byte $23,$37,$12
.byte $24
.byte $38
; data -> unknown

.byte $12,$25,$39,$12,$26,$3A
.byte $12,$25,$39
.byte $12,$24
.byte $38
; unknown -> data
; indexed data load target (from $81BB)
; indexed data load target (from $823D)
.byte $17,$0C,$0C,$27,$1C,$0C,$27,$1C,$1C,$37,$2C,$1C,$17,$0B,$0B,$27
.byte $1B,$0B,$27,$1B,$1B,$37,$2B,$1B,$16,$07
.byte $05,$26,$17,$05,$26
.byte $17,$15,$36
.byte $27
.byte $15
; indexed data load target (from $8243)
.byte $18
; indexed data load target (from $827C)
.byte $08,$18,$18
.byte $37
.byte $18

.byte $A0,$02,$CA,$06,$07,$A1,$02,$2A,$36,$37,$A0,$02,$D4,$40,$41,$A1
.byte $02,$34,$70,$F9,$A0,$02,$EA,$16,$17,$A1,$02,$0A,$26,$27
.byte $A0,$02,$F4,$50,$51,$A1,$02
.byte $14,$60,$61,$A1
.byte $01,$35
.byte $71
; data -> chr
; indirect CHR load target (via $A672)
; indirect CHR load target (via $A674)
.incbin "../../split/us/gfx/intro/cannock_1_1.bin"
; indirect CHR load target (via $A676)
.incbin "../../split/us/gfx/intro/cannock_1_2.bin"
; indirect CHR load target (via $A678)
.incbin "../../split/us/gfx/intro/cannock_1_3.bin"
; indirect CHR load target (via $A67A)
.incbin "../../split/us/gfx/intro/cannock_2_1.bin"
; indirect CHR load target (via $A67C)
.incbin "../../split/us/gfx/intro/cannock_2_2.bin"
; indirect CHR load target (via $A67E)
.incbin "../../split/us/gfx/intro/cannock_2_3.bin"
; indirect CHR load target (via $A680)
.incbin "../../split/us/gfx/intro/cannock_3_1.bin"
; indirect CHR load target (via $A682)
.incbin "../../split/us/gfx/intro/cannock_3_2.bin"
; indirect CHR load target (via $A684)
.incbin "../../split/us/gfx/intro/cannock_3_3.bin"
; indirect CHR load target (via $A686)
.incbin "../../split/us/gfx/intro/cannock_4_1.bin"
; indirect CHR load target (via $A688)
.incbin "../../split/us/gfx/intro/cannock_4_2.bin"
; indirect CHR load target (via $A68A)
.incbin "../../split/us/gfx/intro/cannock_4_3.bin"
; indirect CHR load target (via $A68C)
.incbin "../../split/us/gfx/intro/cannock_5_1.bin"
; indirect CHR load target (via $A68E)
.incbin "../../split/us/gfx/intro/cannock_5_2.bin"
; indirect CHR load target (via $A690)
.incbin "../../split/us/gfx/intro/cannock_5_3.bin"
; indirect CHR load target (via $A692)
.incbin "../../split/us/gfx/intro/cannock_6_1.bin"
; indirect CHR load target (via $A694)
.incbin "../../split/us/gfx/intro/cannock_6_2.bin"
; indirect CHR load target (via $A696)
.incbin "../../split/us/gfx/intro/cannock_6_3.bin"
; indirect CHR load target (via $A698)
.incbin "../../split/us/gfx/intro/cannock_unused_1.bin"
; indirect CHR load target (via $A69A)
.incbin "../../split/us/gfx/intro/cannock_unused_2.bin"
; indirect CHR load target (via $A69C)
.incbin "../../split/us/gfx/intro/moonbrooke_1_1.bin"
; indirect CHR load target (via $A69E)
.incbin "../../split/us/gfx/intro/moonbrooke_1_2.bin"
; indirect CHR load target (via $A6A0)
.incbin "../../split/us/gfx/intro/moonbrooke_1_3.bin"
; indirect CHR load target (via $A6A2)
.incbin "../../split/us/gfx/intro/moonbrooke_2_1.bin"
; indirect CHR load target (via $A6A4)
.incbin "../../split/us/gfx/intro/moonbrooke_2_2.bin"
; indirect CHR load target (via $A6A6)
.incbin "../../split/us/gfx/intro/moonbrooke_2_3.bin"
; indirect CHR load target (via $A6A8)
.incbin "../../split/us/gfx/intro/moonbrooke_3_1.bin"
; indirect CHR load target (via $A6AA)
.incbin "../../split/us/gfx/intro/moonbrooke_3_2.bin"
; indirect CHR load target (via $A6AC)
.incbin "../../split/us/gfx/intro/moonbrooke_3_3.bin"
; indirect CHR load target (via $A6AE)
.incbin "../../split/us/gfx/intro/moonbrooke_4_1.bin"
; indirect CHR load target (via $A6B0)
.incbin "../../split/us/gfx/intro/moonbrooke_4_2.bin"
; indirect CHR load target (via $A6B2)
.incbin "../../split/us/gfx/intro/moonbrooke_4_3.bin"
; indirect CHR load target (via $A6B4)
.incbin "../../split/us/gfx/intro/moonbrooke_5_1.bin"
; indirect CHR load target (via $A6B6)
.incbin "../../split/us/gfx/intro/moonbrooke_5_2.bin"
; indirect CHR load target (via $A6B8)
.incbin "../../split/us/gfx/intro/moonbrooke_5_3.bin"
; indirect CHR load target (via $A6BA)
.incbin "../../split/us/gfx/intro/moonbrooke_6_1.bin"
; indirect CHR load target (via $A6BC)
.incbin "../../split/us/gfx/intro/moonbrooke_6_2.bin"
; indirect CHR load target (via $A6BE)
.incbin "../../split/us/gfx/intro/moonbrooke_6_3.bin"
; indirect CHR load target (via $A6C0)
.incbin "../../split/us/gfx/intro/moonbrooke_unused_1.bin"
.incbin "../../split/us/gfx/intro/moonbrooke_unused_2.bin"

; chr -> code
; control flow target (from $8135, $815B, $A65B)
    pha
    lda $A5
    bne B08_A5F8
    pla
    sta $9F
    stx $A6
    sty $A5
    lda #$00
    sta $A0
    pha
; control flow target (from $A5EA)
B08_A5F8:
    pla
    lda $9F
    asl
    tax
    lda $A672,X
    sta $A1
    lda $A673,X
    sta $A2
    lda $A0
    jsr $A65F
    adc $A1
    sta $A1
    lda $A2
    adc $A4
    sta $A2
    lda $A6
    jsr $A65F
    sta $0302
    lda a:$A4
    ora #$90
    sta $0300 ; PPU write buffer start

    lda #$00
    sta $0301
    tax
    tay
    inc $01
    lda #$50
    sta $A3
; control flow target (from $A643, $A64F)
B08_A633:
    lda ($A1),Y
    sta $0303,X
    inx
    iny
    inc $0301
    dec $A3
    lda $A3
    and #$0F
    bne B08_A633
    inc $A0
    inc $A6
    dec $A5
    beq B08_A65E
    lda $A3
    bne B08_A633
    lda #$01
    sta $0183
    sta $02
    jsr $830B
    jmp $A5E7

; control flow target (from $A64B)
B08_A65E:
    rts

; control flow target (from $A609, $A618)
    pha
    lda #$00
    sta $A4
    pla
    asl
    rol $A4
    asl
    rol $A4
    asl
    rol $A4
    asl
    rol $A4
    rts


; code -> data
; indexed data load target (from $A5FD)
; indexed data load target (from $A602)
.byte $F7
; indexed data load target (from $811A, $8143, $82BF)
.byte $86,$37,$87,$77,$87,$B7,$87,$07,$88,$57,$88,$A7,$88,$27,$89,$A7
.byte $89,$27,$8A,$C7,$8A,$67,$8B,$07,$8C,$07,$8D,$07,$8E,$07,$8F,$77
.byte $90,$E7,$91,$57,$93,$A7,$94,$F7,$95,$37,$96,$77,$96,$B7,$96,$07
.byte $97,$57,$97,$A7,$97,$27,$98,$A7,$98,$27,$99,$D7,$99,$67,$9A,$17
.byte $9B,$27,$9C,$37,$9D,$47,$9E,$E7
.byte $9F,$77,$A1,$17
.byte $A3,$77
.byte $A4
; indexed data load target (from $811F, $8148, $82C4)
.byte $2C
; indirect data load target (via $A6C2, $A6C4, $A6C6, $A6C8, $A6CA, $A6CC, $A6CE)
.byte $A7,$2C,$A7,$2C,$A7,$2C,$A7,$2C,$A7,$2C,$A7,$2C,$A7,$3D,$A7,$4E
.byte $A7,$5F,$A7,$74,$A7,$89,$A7,$9E,$A7,$BF,$A7,$E0,$A7,$01,$A8,$2A
.byte $A8,$53,$A8,$78,$A8,$B9,$A8,$FA,$A8,$3B,$A9,$9C,$A9,$F9,$A9,$56
.byte $AA,$67,$AA,$78,$AA,$8D,$AA,$A2,$AA,$C3,$AA,$E4,$AA,$0D,$AB,$36
.byte $AB,$77,$AB,$B8,$AB,$15,$AC,$6E,$AC,$C3,$AC,$18,$AD,$29,$AD,$3A
.byte $AD,$4F,$AD,$64,$AD,$85,$AD,$A6,$AD,$D3,$AD,$F8,$AD
.byte $3D,$AE,$82,$AE,$DF,$AE
.byte $3C,$AF,$99
.byte $AF,$E6
.byte $AF
; indirect data load target
.byte $7B,$84,$00,$00,$83,$84,$01,$00
.byte $7B,$8C,$02,$00
.byte $83,$8C
.byte $03
.byte $00
; indirect data load target (via $A6D0)
.byte $FF
; indirect data load target
.byte $7B,$84,$04,$00,$83,$84,$05,$00
.byte $7B,$8C,$06,$00
.byte $83,$8C
.byte $07
.byte $00
; indirect data load target (via $A6D2)
.byte $FF
; indirect data load target
.byte $7B,$84,$08,$00,$83,$84,$09,$00
.byte $7B,$8C,$0A,$00
.byte $83,$8C
.byte $0B
.byte $00
; indirect data load target (via $A6D4)
.byte $FF
; indirect data load target
.byte $75,$84,$0C,$00,$7D,$84,$0D,$00
.byte $75,$8C,$0E,$00
.byte $7D,$8C
.byte $0F
.byte $00
; indirect data load target
.byte $7D
; indirect data load target
.byte $94
; indirect data load target
.byte $10
; indirect data load target
.byte $00
; indirect data load target (via $A6D6)
.byte $FF
; indirect data load target
.byte $75
; indirect data load target
.byte $84
; indirect data load target
.byte $11
; indirect data load target
.byte $00
; indirect data load target
.byte $7D
; indirect data load target
.byte $84
; indirect data load target
.byte $12
; indirect data load target
.byte $00
; indirect data load target
.byte $75
; indirect data load target
.byte $8C
; indirect data load target
.byte $13
; indirect data load target
.byte $00
; indirect data load target
.byte $7D
; indirect data load target
.byte $8C
; indirect data load target
.byte $14
; indirect data load target
.byte $00
; indirect data load target
.byte $7D
; indirect data load target
.byte $94
; indirect data load target
.byte $15
; indirect data load target
.byte $00
; indirect data load target (via $A6D8)
.byte $FF
; indirect data load target
.byte $75
; indirect data load target
.byte $84
; indirect data load target
.byte $16
; indirect data load target
.byte $00
; indirect data load target
.byte $7D
; indirect data load target
.byte $84
; indirect data load target
.byte $17
; indirect data load target
.byte $00
; indirect data load target
.byte $75
; indirect data load target
.byte $8C
; indirect data load target
.byte $18
; indirect data load target
.byte $00
; indirect data load target
.byte $7D
; indirect data load target
.byte $8C
; indirect data load target
.byte $19
; indirect data load target
.byte $00
; indirect data load target
.byte $7D
; indirect data load target
.byte $94
; indirect data load target
.byte $1A
; indirect data load target
.byte $00
; indirect data load target (via $A6DA)
.byte $FF
; indirect data load target
.byte $77
; indirect data load target
.byte $80
; indirect data load target
.byte $1B
; indirect data load target
.byte $00
; indirect data load target
.byte $7F
; indirect data load target
.byte $80
; indirect data load target
.byte $1C
; indirect data load target
.byte $00
; indirect data load target
.byte $77
; indirect data load target
.byte $88
; indirect data load target
.byte $1D
; indirect data load target
.byte $00
; indirect data load target
.byte $7F
; indirect data load target
.byte $88
; indirect data load target
.byte $1E
; indirect data load target
.byte $00
; indirect data load target
.byte $77
; indirect data load target
.byte $90
; indirect data load target
.byte $1F
; indirect data load target
.byte $00
; indirect data load target
.byte $7F
; indirect data load target
.byte $90
; indirect data load target
.byte $20
; indirect data load target
.byte $00
; indirect data load target
.byte $77
; indirect data load target
.byte $98
; indirect data load target
.byte $7F
; indirect data load target
.byte $00
; indirect data load target
.byte $7F
; indirect data load target
.byte $98
; indirect data load target
.byte $21
; indirect data load target
.byte $00
; indirect data load target (via $A6DC)
.byte $FF
; indirect data load target
.byte $77
; indirect data load target
.byte $80
; indirect data load target
.byte $22
; indirect data load target
.byte $00
; indirect data load target
.byte $7F
; indirect data load target
.byte $80
; indirect data load target
.byte $23
; indirect data load target
.byte $00
; indirect data load target
.byte $77
; indirect data load target
.byte $88
; indirect data load target
.byte $24
; indirect data load target
.byte $00
; indirect data load target
.byte $7F
; indirect data load target
.byte $88
; indirect data load target
.byte $25
; indirect data load target
.byte $00
; indirect data load target
.byte $77
; indirect data load target
.byte $90
; indirect data load target
.byte $26
; indirect data load target
.byte $00
; indirect data load target
.byte $7F
; indirect data load target
.byte $90
; indirect data load target
.byte $27
; indirect data load target
.byte $00
; indirect data load target
.byte $77
; indirect data load target
.byte $98
; indirect data load target
.byte $28
; indirect data load target
.byte $00
; indirect data load target
.byte $7F
; indirect data load target
.byte $98
; indirect data load target
.byte $29
; indirect data load target
.byte $00
; indirect data load target (via $A6DE)
.byte $FF
; indirect data load target
.byte $77
; indirect data load target
.byte $80
; indirect data load target
.byte $2A
; indirect data load target
.byte $00
; indirect data load target
.byte $7F
; indirect data load target
.byte $80
; indirect data load target
.byte $2B
; indirect data load target
.byte $00
; indirect data load target
.byte $77
; indirect data load target
.byte $88
; indirect data load target
.byte $2C
; indirect data load target
.byte $00
; indirect data load target
.byte $7F
; indirect data load target
.byte $88
; indirect data load target
.byte $2D
; indirect data load target
.byte $00
; indirect data load target
.byte $77
; indirect data load target
.byte $90
; indirect data load target
.byte $2E
; indirect data load target
.byte $00
; indirect data load target
.byte $7F
; indirect data load target
.byte $90
; indirect data load target
.byte $2F
; indirect data load target
.byte $00
; indirect data load target
.byte $77
; indirect data load target
.byte $98
; indirect data load target
.byte $30
; indirect data load target
.byte $00
; indirect data load target
.byte $7F
; indirect data load target
.byte $98
; indirect data load target
.byte $31
; indirect data load target
.byte $00
; indirect data load target (via $A6E0)
.byte $FF
; indirect data load target
.byte $74
; indirect data load target
.byte $81
; indirect data load target
.byte $32
; indirect data load target
.byte $00
; indirect data load target
.byte $7C
; indirect data load target
.byte $81
; indirect data load target
.byte $33
; indirect data load target
.byte $00
; indirect data load target
.byte $84
; indirect data load target
.byte $81
; indirect data load target
.byte $34
; indirect data load target
.byte $00
; indirect data load target
.byte $74
; indirect data load target
.byte $89
; indirect data load target
.byte $35
; indirect data load target
.byte $00
; indirect data load target
.byte $7C
; indirect data load target
.byte $89
; indirect data load target
.byte $36
; indirect data load target
.byte $00
; indirect data load target
.byte $84
; indirect data load target
.byte $89
; indirect data load target
.byte $37
; indirect data load target
.byte $00
; indirect data load target
.byte $74
; indirect data load target
.byte $91
; indirect data load target
.byte $38
; indirect data load target
.byte $00
; indirect data load target
.byte $7C
; indirect data load target
.byte $91
; indirect data load target
.byte $39
; indirect data load target
.byte $00
; indirect data load target
.byte $84
; indirect data load target
.byte $91
; indirect data load target
.byte $3A
; indirect data load target
.byte $00
; indirect data load target
.byte $7C
; indirect data load target
.byte $99
; indirect data load target
.byte $3B
; indirect data load target
.byte $00
; indirect data load target (via $A6E2)
.byte $FF
; indirect data load target
.byte $74
; indirect data load target
.byte $81
; indirect data load target
.byte $3C
; indirect data load target
.byte $00
; indirect data load target
.byte $7C
; indirect data load target
.byte $81
; indirect data load target
.byte $3D
; indirect data load target
.byte $00
; indirect data load target
.byte $84
; indirect data load target
.byte $81
; indirect data load target
.byte $3E
; indirect data load target
.byte $00
; indirect data load target
.byte $74
; indirect data load target
.byte $89
; indirect data load target
.byte $3F
; indirect data load target
.byte $00
; indirect data load target
.byte $7C
; indirect data load target
.byte $89
; indirect data load target
.byte $40
; indirect data load target
.byte $00
; indirect data load target
.byte $84
; indirect data load target
.byte $89
; indirect data load target
.byte $41
; indirect data load target
.byte $00
; indirect data load target
.byte $74
; indirect data load target
.byte $91
; indirect data load target
.byte $42
; indirect data load target
.byte $00
; indirect data load target
.byte $7C
; indirect data load target
.byte $91
; indirect data load target
.byte $43
; indirect data load target
.byte $00
; indirect data load target
.byte $84
; indirect data load target
.byte $91
; indirect data load target
.byte $44
; indirect data load target
.byte $00
; indirect data load target
.byte $7C
; indirect data load target
.byte $99
; indirect data load target
.byte $45
; indirect data load target
.byte $00
; indirect data load target (via $A6E4)
.byte $FF
; indirect data load target
.byte $74
; indirect data load target
.byte $81
; indirect data load target
.byte $46
; indirect data load target
.byte $00
; indirect data load target
.byte $7C
; indirect data load target
.byte $81
; indirect data load target
.byte $47
; indirect data load target
.byte $00
; indirect data load target
.byte $84
; indirect data load target
.byte $81
; indirect data load target
.byte $48
; indirect data load target
.byte $00
; indirect data load target
.byte $74
; indirect data load target
.byte $89
; indirect data load target
.byte $49
; indirect data load target
.byte $00
; indirect data load target
.byte $7C
; indirect data load target
.byte $89
; indirect data load target
.byte $4A
; indirect data load target
.byte $00
; indirect data load target
.byte $84
; indirect data load target
.byte $89
; indirect data load target
.byte $4B
; indirect data load target
.byte $00
; indirect data load target
.byte $74
; indirect data load target
.byte $91
; indirect data load target
.byte $4C
; indirect data load target
.byte $00
; indirect data load target
.byte $7C
; indirect data load target
.byte $91
; indirect data load target
.byte $4D
; indirect data load target
.byte $00
; indirect data load target
.byte $7C
; indirect data load target
.byte $99
; indirect data load target
.byte $4E
; indirect data load target
.byte $00
; indirect data load target (via $A6E6)
.byte $FF
; indirect data load target
.byte $73
; indirect data load target
.byte $7F
; indirect data load target
.byte $4F
; indirect data load target
.byte $00
; indirect data load target
.byte $7B
; indirect data load target
.byte $7F
; indirect data load target
.byte $50
; indirect data load target
.byte $00
; indirect data load target
.byte $83
; indirect data load target
.byte $7F
; indirect data load target
.byte $51
; indirect data load target
.byte $00
; indirect data load target
.byte $73
; indirect data load target
.byte $87
; indirect data load target
.byte $52
; indirect data load target
.byte $00
; indirect data load target
.byte $7B
; indirect data load target
.byte $87
; indirect data load target
.byte $53
; indirect data load target
.byte $00
; indirect data load target
.byte $83
; indirect data load target
.byte $87
; indirect data load target
.byte $54
; indirect data load target
.byte $00
; indirect data load target
.byte $73
; indirect data load target
.byte $8F
; indirect data load target
.byte $55
; indirect data load target
.byte $00
; indirect data load target
.byte $7B
; indirect data load target
.byte $8F
; indirect data load target
.byte $56
; indirect data load target
.byte $00
; indirect data load target
.byte $83
; indirect data load target
.byte $8F
; indirect data load target
.byte $57
; indirect data load target
.byte $00
; indirect data load target
.byte $73
; indirect data load target
.byte $97
; indirect data load target
.byte $58
; indirect data load target
.byte $00
; indirect data load target
.byte $7B
; indirect data load target
.byte $97
; indirect data load target
.byte $59
; indirect data load target
.byte $00
; indirect data load target
.byte $83
; indirect data load target
.byte $97
; indirect data load target
.byte $5A
; indirect data load target
.byte $00
; indirect data load target
.byte $7B
; indirect data load target
.byte $9F
; indirect data load target
.byte $5B
; indirect data load target
.byte $00
; indirect data load target
.byte $83
; indirect data load target
.byte $9F
; indirect data load target
.byte $5C
; indirect data load target
.byte $00
; indirect data load target
.byte $7B
; indirect data load target
.byte $A7
; indirect data load target
.byte $5D
; indirect data load target
.byte $00
; indirect data load target
.byte $83
; indirect data load target
.byte $A7
; indirect data load target
.byte $5E
; indirect data load target
.byte $00
; indirect data load target (via $A6E8)
.byte $FF
; indirect data load target
.byte $73
; indirect data load target
.byte $7F
; indirect data load target
.byte $5F
; indirect data load target
.byte $00
; indirect data load target
.byte $7B
; indirect data load target
.byte $7F
; indirect data load target
.byte $60
; indirect data load target
.byte $00
; indirect data load target
.byte $83
; indirect data load target
.byte $7F
; indirect data load target
.byte $61
; indirect data load target
.byte $00
; indirect data load target
.byte $73
; indirect data load target
.byte $87
; indirect data load target
.byte $62
; indirect data load target
.byte $00
; indirect data load target
.byte $7B
; indirect data load target
.byte $87
; indirect data load target
.byte $63
; indirect data load target
.byte $00
; indirect data load target
.byte $83
; indirect data load target
.byte $87
; indirect data load target
.byte $64
; indirect data load target
.byte $00
; indirect data load target
.byte $73
; indirect data load target
.byte $8F
; indirect data load target
.byte $65
; indirect data load target
.byte $00
; indirect data load target
.byte $7B
; indirect data load target
.byte $8F
; indirect data load target
.byte $66
; indirect data load target
.byte $00
; indirect data load target
.byte $83
; indirect data load target
.byte $8F
; indirect data load target
.byte $67
; indirect data load target
.byte $00
; indirect data load target
.byte $73
; indirect data load target
.byte $97
; indirect data load target
.byte $68
; indirect data load target
.byte $00
; indirect data load target
.byte $7B
; indirect data load target
.byte $97
; indirect data load target
.byte $69
; indirect data load target
.byte $00
; indirect data load target
.byte $83
; indirect data load target
.byte $97
; indirect data load target
.byte $6A
; indirect data load target
.byte $00
; indirect data load target
.byte $7B
; indirect data load target
.byte $9F
; indirect data load target
.byte $6B
; indirect data load target
.byte $00
; indirect data load target
.byte $83
; indirect data load target
.byte $9F
; indirect data load target
.byte $6C
; indirect data load target
.byte $00
; indirect data load target
.byte $7B
; indirect data load target
.byte $A7
; indirect data load target
.byte $6D
; indirect data load target
.byte $00
; indirect data load target
.byte $83
; indirect data load target
.byte $A7
; indirect data load target
.byte $6E
; indirect data load target
.byte $00
; indirect data load target (via $A6EA)
.byte $FF
; indirect data load target
.byte $73
; indirect data load target
.byte $7F
; indirect data load target
.byte $6F
; indirect data load target
.byte $00
; indirect data load target
.byte $7B
; indirect data load target
.byte $7F
; indirect data load target
.byte $70
; indirect data load target
.byte $00
; indirect data load target
.byte $83
; indirect data load target
.byte $7F
; indirect data load target
.byte $71
; indirect data load target
.byte $00
; indirect data load target
.byte $73
; indirect data load target
.byte $87
; indirect data load target
.byte $72
; indirect data load target
.byte $00
; indirect data load target
.byte $7B
; indirect data load target
.byte $87
; indirect data load target
.byte $73
; indirect data load target
.byte $00
; indirect data load target
.byte $83
; indirect data load target
.byte $87
; indirect data load target
.byte $74
; indirect data load target
.byte $00
; indirect data load target
.byte $73
; indirect data load target
.byte $8F
; indirect data load target
.byte $75
; indirect data load target
.byte $00
; indirect data load target
.byte $7B
; indirect data load target
.byte $8F
; indirect data load target
.byte $76
; indirect data load target
.byte $00
; indirect data load target
.byte $83
; indirect data load target
.byte $8F
; indirect data load target
.byte $77
; indirect data load target
.byte $00
; indirect data load target
.byte $73
; indirect data load target
.byte $97
; indirect data load target
.byte $78
; indirect data load target
.byte $00
; indirect data load target
.byte $7B
; indirect data load target
.byte $97
; indirect data load target
.byte $79
; indirect data load target
.byte $00
; indirect data load target
.byte $83
; indirect data load target
.byte $97
; indirect data load target
.byte $7A
; indirect data load target
.byte $00
; indirect data load target
.byte $7B
; indirect data load target
.byte $9F
; indirect data load target
.byte $7B
; indirect data load target
.byte $00
; indirect data load target
.byte $83
; indirect data load target
.byte $9F
; indirect data load target
.byte $7C
; indirect data load target
.byte $00
; indirect data load target
.byte $7B
; indirect data load target
.byte $A7
; indirect data load target
.byte $7D
; indirect data load target
.byte $00
; indirect data load target
.byte $83
; indirect data load target
.byte $A7
; indirect data load target
.byte $7E
; indirect data load target
.byte $00
; indirect data load target (via $A6EC)
.byte $FF
; indirect data load target
.byte $70
; indirect data load target
.byte $7E
; indirect data load target
.byte $80
; indirect data load target
.byte $00
; indirect data load target
.byte $78
; indirect data load target
.byte $7E
; indirect data load target
.byte $81
; indirect data load target
.byte $00
; indirect data load target
.byte $80
; indirect data load target
.byte $7E
; indirect data load target
.byte $82
; indirect data load target
.byte $00
; indirect data load target
.byte $88
; indirect data load target
.byte $7E
; indirect data load target
.byte $83
; indirect data load target
.byte $00
; indirect data load target
.byte $70
; indirect data load target
.byte $86
; indirect data load target
.byte $84
; indirect data load target
.byte $00
; indirect data load target
.byte $78
; indirect data load target
.byte $86
; indirect data load target
.byte $85
; indirect data load target
.byte $00
; indirect data load target
.byte $80
; indirect data load target
.byte $86
; indirect data load target
.byte $86
; indirect data load target
.byte $00
; indirect data load target
.byte $88
; indirect data load target
.byte $86
; indirect data load target
.byte $87
; indirect data load target
.byte $00
; indirect data load target
.byte $70
; indirect data load target
.byte $8E
; indirect data load target
.byte $88
; indirect data load target
.byte $00
; indirect data load target
.byte $78
; indirect data load target
.byte $8E
; indirect data load target
.byte $89
; indirect data load target
.byte $00
; indirect data load target
.byte $80
; indirect data load target
.byte $8E
; indirect data load target
.byte $8A
; indirect data load target
.byte $00
; indirect data load target
.byte $88
; indirect data load target
.byte $8E
; indirect data load target
.byte $8B
; indirect data load target
.byte $00
; indirect data load target
.byte $70
; indirect data load target
.byte $96
; indirect data load target
.byte $8C
; indirect data load target
.byte $00
; indirect data load target
.byte $78
; indirect data load target
.byte $96
; indirect data load target
.byte $8D
; indirect data load target
.byte $00
; indirect data load target
.byte $80
; indirect data load target
.byte $96
; indirect data load target
.byte $8E
; indirect data load target
.byte $00
; indirect data load target
.byte $88
; indirect data load target
.byte $96
; indirect data load target
.byte $8F
; indirect data load target
.byte $00
; indirect data load target
.byte $70
; indirect data load target
.byte $9E
; indirect data load target
.byte $90
; indirect data load target
.byte $00
; indirect data load target
.byte $78
; indirect data load target
.byte $9E
; indirect data load target
.byte $91
; indirect data load target
.byte $00
; indirect data load target
.byte $80
; indirect data load target
.byte $9E
; indirect data load target
.byte $92
; indirect data load target
.byte $00
; indirect data load target
.byte $88
; indirect data load target
.byte $9E
; indirect data load target
.byte $93
; indirect data load target
.byte $00
; indirect data load target
.byte $78
; indirect data load target
.byte $A6
; indirect data load target
.byte $94
; indirect data load target
.byte $00
; indirect data load target
.byte $80
; indirect data load target
.byte $A6
; indirect data load target
.byte $95
; indirect data load target
.byte $00
; indirect data load target
.byte $78
; indirect data load target
.byte $AE
; indirect data load target
.byte $96
; indirect data load target
.byte $00
; indirect data load target
.byte $80
; indirect data load target
.byte $AE
; indirect data load target
.byte $97
; indirect data load target
.byte $00
; indirect data load target (via $A6EE)
.byte $FF
; indirect data load target
.byte $70
; indirect data load target
.byte $7E
; indirect data load target
.byte $98
; indirect data load target
.byte $00
; indirect data load target
.byte $78
; indirect data load target
.byte $7E
; indirect data load target
.byte $99
; indirect data load target
.byte $00
; indirect data load target
.byte $80
; indirect data load target
.byte $7E
; indirect data load target
.byte $9A
; indirect data load target
.byte $00
; indirect data load target
.byte $88
; indirect data load target
.byte $7E
; indirect data load target
.byte $9B
; indirect data load target
.byte $00
; indirect data load target
.byte $70
; indirect data load target
.byte $86
; indirect data load target
.byte $9C
; indirect data load target
.byte $00
; indirect data load target
.byte $78
; indirect data load target
.byte $86
; indirect data load target
.byte $9D
; indirect data load target
.byte $00
; indirect data load target
.byte $80
; indirect data load target
.byte $86
; indirect data load target
.byte $9E
; indirect data load target
.byte $00
; indirect data load target
.byte $88
; indirect data load target
.byte $86
; indirect data load target
.byte $9F
; indirect data load target
.byte $00
; indirect data load target
.byte $70
; indirect data load target
.byte $8E
; indirect data load target
.byte $A0
; indirect data load target
.byte $00
; indirect data load target
.byte $78
; indirect data load target
.byte $8E
; indirect data load target
.byte $A1
; indirect data load target
.byte $00
; indirect data load target
.byte $80
; indirect data load target
.byte $8E
; indirect data load target
.byte $A2
; indirect data load target
.byte $00
; indirect data load target
.byte $88
; indirect data load target
.byte $8E
; indirect data load target
.byte $A3
; indirect data load target
.byte $00
; indirect data load target
.byte $70
; indirect data load target
.byte $96
; indirect data load target
.byte $A4
; indirect data load target
.byte $00
; indirect data load target
.byte $78
; indirect data load target
.byte $96
; indirect data load target
.byte $A5
; indirect data load target
.byte $00
; indirect data load target
.byte $80
; indirect data load target
.byte $96
; indirect data load target
.byte $A6
; indirect data load target
.byte $00
; indirect data load target
.byte $88
; indirect data load target
.byte $96
; indirect data load target
.byte $A7
; indirect data load target
.byte $00
; indirect data load target
.byte $70
; indirect data load target
.byte $9E
; indirect data load target
.byte $A8
; indirect data load target
.byte $00
; indirect data load target
.byte $78
; indirect data load target
.byte $9E
; indirect data load target
.byte $A9
; indirect data load target
.byte $00
; indirect data load target
.byte $80
; indirect data load target
.byte $9E
; indirect data load target
.byte $AA
; indirect data load target
.byte $00
; indirect data load target
.byte $78
; indirect data load target
.byte $A6
; indirect data load target
.byte $AB
; indirect data load target
.byte $00
; indirect data load target
.byte $80
; indirect data load target
.byte $A6
; indirect data load target
.byte $AC
; indirect data load target
.byte $00
; indirect data load target
.byte $78
; indirect data load target
.byte $AE
; indirect data load target
.byte $AD
; indirect data load target
.byte $00
; indirect data load target
.byte $80
; indirect data load target
.byte $AE
; indirect data load target
.byte $AE
; indirect data load target
.byte $00
; indirect data load target (via $A6F0)
.byte $FF
; indirect data load target
.byte $70
; indirect data load target
.byte $7E
; indirect data load target
.byte $AF
; indirect data load target
.byte $00
; indirect data load target
.byte $78
; indirect data load target
.byte $7E
; indirect data load target
.byte $B0
; indirect data load target
.byte $00
; indirect data load target
.byte $80
; indirect data load target
.byte $7E
; indirect data load target
.byte $B1
; indirect data load target
.byte $00
; indirect data load target
.byte $88
; indirect data load target
.byte $7E
; indirect data load target
.byte $B2
; indirect data load target
.byte $00
; indirect data load target
.byte $70
; indirect data load target
.byte $86
; indirect data load target
.byte $B3
; indirect data load target
.byte $00
; indirect data load target
.byte $78
; indirect data load target
.byte $86
; indirect data load target
.byte $B4
; indirect data load target
.byte $00
; indirect data load target
.byte $80
; indirect data load target
.byte $86
; indirect data load target
.byte $B5
; indirect data load target
.byte $00
; indirect data load target
.byte $88
; indirect data load target
.byte $86
; indirect data load target
.byte $B6
; indirect data load target
.byte $00
; indirect data load target
.byte $70
; indirect data load target
.byte $8E
; indirect data load target
.byte $B7
; indirect data load target
.byte $00
; indirect data load target
.byte $78
; indirect data load target
.byte $8E
; indirect data load target
.byte $B8
; indirect data load target
.byte $00
; indirect data load target
.byte $80
; indirect data load target
.byte $8E
; indirect data load target
.byte $B9
; indirect data load target
.byte $00
; indirect data load target
.byte $88
; indirect data load target
.byte $8E
; indirect data load target
.byte $BA
; indirect data load target
.byte $00
; indirect data load target
.byte $70
; indirect data load target
.byte $96
; indirect data load target
.byte $BB
; indirect data load target
.byte $00
; indirect data load target
.byte $78
; indirect data load target
.byte $96
; indirect data load target
.byte $BC
; indirect data load target
.byte $00
; indirect data load target
.byte $80
; indirect data load target
.byte $96
; indirect data load target
.byte $BD
; indirect data load target
.byte $00
; indirect data load target
.byte $88
; indirect data load target
.byte $96
; indirect data load target
.byte $BE
; indirect data load target
.byte $00
; indirect data load target
.byte $70
; indirect data load target
.byte $9E
; indirect data load target
.byte $BF
; indirect data load target
.byte $00
; indirect data load target
.byte $78
; indirect data load target
.byte $9E
; indirect data load target
.byte $C0
; indirect data load target
.byte $00
; indirect data load target
.byte $80
; indirect data load target
.byte $9E
; indirect data load target
.byte $C1
; indirect data load target
.byte $00
; indirect data load target
.byte $78
; indirect data load target
.byte $A6
; indirect data load target
.byte $C2
; indirect data load target
.byte $00
; indirect data load target
.byte $80
; indirect data load target
.byte $A6
; indirect data load target
.byte $C3
; indirect data load target
.byte $00
; indirect data load target
.byte $78
; indirect data load target
.byte $AE
; indirect data load target
.byte $C4
; indirect data load target
.byte $00
; indirect data load target
.byte $80
; indirect data load target
.byte $AE
; indirect data load target
.byte $C5
; indirect data load target
.byte $00
; indirect data load target (via $A6F2)
.byte $FF
; indirect data load target
.byte $9F
; indirect data load target
.byte $81
; indirect data load target
.byte $00
; indirect data load target
.byte $02
; indirect data load target
.byte $A7
; indirect data load target
.byte $81
; indirect data load target
.byte $01
; indirect data load target
.byte $02
; indirect data load target
.byte $9F
; indirect data load target
.byte $89
; indirect data load target
.byte $02
; indirect data load target
.byte $02
; indirect data load target
.byte $A7
; indirect data load target
.byte $89
; indirect data load target
.byte $03
; indirect data load target
.byte $02
; indirect data load target (via $A6F4)
.byte $FF
; indirect data load target
.byte $9F
; indirect data load target
.byte $81
; indirect data load target
.byte $40
; indirect data load target
.byte $02
; indirect data load target
.byte $A7
; indirect data load target
.byte $81
; indirect data load target
.byte $41
; indirect data load target
.byte $02
; indirect data load target
.byte $9F
; indirect data load target
.byte $89
; indirect data load target
.byte $42
; indirect data load target
.byte $02
; indirect data load target
.byte $A7
; indirect data load target
.byte $89
; indirect data load target
.byte $43
; indirect data load target
.byte $02
; indirect data load target (via $A6F6)
.byte $FF
; indirect data load target
.byte $99
; indirect data load target
.byte $81
; indirect data load target
.byte $00
; indirect data load target
.byte $02
; indirect data load target
.byte $A1
; indirect data load target
.byte $81
; indirect data load target
.byte $01
; indirect data load target
.byte $02
; indirect data load target
.byte $99
; indirect data load target
.byte $89
; indirect data load target
.byte $02
; indirect data load target
.byte $02
; indirect data load target
.byte $A1
; indirect data load target
.byte $89
; indirect data load target
.byte $03
; indirect data load target
.byte $02
; indirect data load target
.byte $A1
; indirect data load target
.byte $91
; indirect data load target
.byte $04
; indirect data load target
.byte $02
; indirect data load target (via $A6F8)
.byte $FF
; indirect data load target
.byte $99
; indirect data load target
.byte $81
; indirect data load target
.byte $40
; indirect data load target
.byte $02
; indirect data load target
.byte $A1
; indirect data load target
.byte $81
; indirect data load target
.byte $41
; indirect data load target
.byte $02
; indirect data load target
.byte $99
; indirect data load target
.byte $89
; indirect data load target
.byte $42
; indirect data load target
.byte $02
; indirect data load target
.byte $A1
; indirect data load target
.byte $89
; indirect data load target
.byte $43
; indirect data load target
.byte $02
; indirect data load target
.byte $A1
; indirect data load target
.byte $91
; indirect data load target
.byte $44
; indirect data load target
.byte $02
; indirect data load target (via $A6FA)
.byte $FF
; indirect data load target
.byte $9B
; indirect data load target
.byte $7D
; indirect data load target
.byte $00
; indirect data load target
.byte $02
; indirect data load target
.byte $A3
; indirect data load target
.byte $7D
; indirect data load target
.byte $01
; indirect data load target
.byte $02
; indirect data load target
.byte $9B
; indirect data load target
.byte $85
; indirect data load target
.byte $02
; indirect data load target
.byte $02
; indirect data load target
.byte $A3
; indirect data load target
.byte $85
; indirect data load target
.byte $03
; indirect data load target
.byte $02
; indirect data load target
.byte $9B
; indirect data load target
.byte $8D
; indirect data load target
.byte $04
; indirect data load target
.byte $02
; indirect data load target
.byte $A3
; indirect data load target
.byte $8D
; indirect data load target
.byte $05
; indirect data load target
.byte $02
; indirect data load target
.byte $9B
; indirect data load target
.byte $95
; indirect data load target
.byte $06
; indirect data load target
.byte $02
; indirect data load target
.byte $A3
; indirect data load target
.byte $95
; indirect data load target
.byte $07
; indirect data load target
.byte $02
; indirect data load target (via $A6FC)
.byte $FF
; indirect data load target
.byte $9B
; indirect data load target
.byte $7D
; indirect data load target
.byte $40
; indirect data load target
.byte $02
; indirect data load target
.byte $A3
; indirect data load target
.byte $7D
; indirect data load target
.byte $41
; indirect data load target
.byte $02
; indirect data load target
.byte $9B
; indirect data load target
.byte $85
; indirect data load target
.byte $42
; indirect data load target
.byte $02
; indirect data load target
.byte $A3
; indirect data load target
.byte $85
; indirect data load target
.byte $43
; indirect data load target
.byte $02
; indirect data load target
.byte $9B
; indirect data load target
.byte $8D
; indirect data load target
.byte $44
; indirect data load target
.byte $02
; indirect data load target
.byte $A3
; indirect data load target
.byte $8D
; indirect data load target
.byte $45
; indirect data load target
.byte $02
; indirect data load target
.byte $9B
; indirect data load target
.byte $95
; indirect data load target
.byte $46
; indirect data load target
.byte $02
; indirect data load target
.byte $A3
; indirect data load target
.byte $95
; indirect data load target
.byte $47
; indirect data load target
.byte $02
; indirect data load target (via $A6FE)
.byte $FF
; indirect data load target
.byte $98
; indirect data load target
.byte $7E
; indirect data load target
.byte $00
; indirect data load target
.byte $02
; indirect data load target
.byte $A0
; indirect data load target
.byte $7E
; indirect data load target
.byte $01
; indirect data load target
.byte $02
; indirect data load target
.byte $A8
; indirect data load target
.byte $7E
; indirect data load target
.byte $02
; indirect data load target
.byte $02
; indirect data load target
.byte $98
; indirect data load target
.byte $86
; indirect data load target
.byte $03
; indirect data load target
.byte $02
; indirect data load target
.byte $A0
; indirect data load target
.byte $86
; indirect data load target
.byte $04
; indirect data load target
.byte $02
; indirect data load target
.byte $A8
; indirect data load target
.byte $86
; indirect data load target
.byte $05
; indirect data load target
.byte $02
; indirect data load target
.byte $98
; indirect data load target
.byte $8E
; indirect data load target
.byte $06
; indirect data load target
.byte $02
; indirect data load target
.byte $A0
; indirect data load target
.byte $8E
; indirect data load target
.byte $07
; indirect data load target
.byte $02
; indirect data load target
.byte $A8
; indirect data load target
.byte $8E
; indirect data load target
.byte $08
; indirect data load target
.byte $02
; indirect data load target
.byte $A0
; indirect data load target
.byte $96
; indirect data load target
.byte $09
; indirect data load target
.byte $02
; indirect data load target (via $A700)
.byte $FF
; indirect data load target
.byte $98
; indirect data load target
.byte $7E
; indirect data load target
.byte $40
; indirect data load target
.byte $02
; indirect data load target
.byte $A0
; indirect data load target
.byte $7E
; indirect data load target
.byte $41
; indirect data load target
.byte $02
; indirect data load target
.byte $A8
; indirect data load target
.byte $7E
; indirect data load target
.byte $42
; indirect data load target
.byte $02
; indirect data load target
.byte $98
; indirect data load target
.byte $86
; indirect data load target
.byte $43
; indirect data load target
.byte $02
; indirect data load target
.byte $A0
; indirect data load target
.byte $86
; indirect data load target
.byte $44
; indirect data load target
.byte $02
; indirect data load target
.byte $A8
; indirect data load target
.byte $86
; indirect data load target
.byte $45
; indirect data load target
.byte $02
; indirect data load target
.byte $98
; indirect data load target
.byte $8E
; indirect data load target
.byte $46
; indirect data load target
.byte $02
; indirect data load target
.byte $A0
; indirect data load target
.byte $8E
; indirect data load target
.byte $47
; indirect data load target
.byte $02
; indirect data load target
.byte $A8
; indirect data load target
.byte $8E
; indirect data load target
.byte $48
; indirect data load target
.byte $02
; indirect data load target
.byte $A0
; indirect data load target
.byte $96
; indirect data load target
.byte $49
; indirect data load target
.byte $02
; indirect data load target (via $A702)
.byte $FF
; indirect data load target
.byte $97
; indirect data load target
.byte $7C
; indirect data load target
.byte $00
; indirect data load target
.byte $02
; indirect data load target
.byte $9F
; indirect data load target
.byte $7C
; indirect data load target
.byte $01
; indirect data load target
.byte $02
; indirect data load target
.byte $A7
; indirect data load target
.byte $7C
; indirect data load target
.byte $02
; indirect data load target
.byte $02
; indirect data load target
.byte $97
; indirect data load target
.byte $84
; indirect data load target
.byte $03
; indirect data load target
.byte $02
; indirect data load target
.byte $9F
; indirect data load target
.byte $84
; indirect data load target
.byte $04
; indirect data load target
.byte $02
; indirect data load target
.byte $A7
; indirect data load target
.byte $84
; indirect data load target
.byte $05
; indirect data load target
.byte $02
; indirect data load target
.byte $97
; indirect data load target
.byte $8C
; indirect data load target
.byte $06
; indirect data load target
.byte $02
; indirect data load target
.byte $9F
; indirect data load target
.byte $8C
; indirect data load target
.byte $07
; indirect data load target
.byte $02
; indirect data load target
.byte $A7
; indirect data load target
.byte $8C
; indirect data load target
.byte $08
; indirect data load target
.byte $02
; indirect data load target
.byte $97
; indirect data load target
.byte $94
; indirect data load target
.byte $09
; indirect data load target
.byte $02
; indirect data load target
.byte $9F
; indirect data load target
.byte $94
; indirect data load target
.byte $0A
; indirect data load target
.byte $02
; indirect data load target
.byte $A7
; indirect data load target
.byte $94
; indirect data load target
.byte $0B
; indirect data load target
.byte $02
; indirect data load target
.byte $9F
; indirect data load target
.byte $9C
; indirect data load target
.byte $0C
; indirect data load target
.byte $02
; indirect data load target
.byte $A7
; indirect data load target
.byte $9C
; indirect data load target
.byte $0D
; indirect data load target
.byte $02
; indirect data load target
.byte $9F
; indirect data load target
.byte $A4
; indirect data load target
.byte $0E
; indirect data load target
.byte $02
; indirect data load target
.byte $A7
; indirect data load target
.byte $A4
; indirect data load target
.byte $0F
; indirect data load target
.byte $02
; indirect data load target (via $A704)
.byte $FF
; indirect data load target
.byte $97
; indirect data load target
.byte $7C
; indirect data load target
.byte $40
; indirect data load target
.byte $02
; indirect data load target
.byte $9F
; indirect data load target
.byte $7C
; indirect data load target
.byte $41
; indirect data load target
.byte $02
; indirect data load target
.byte $A7
; indirect data load target
.byte $7C
; indirect data load target
.byte $42
; indirect data load target
.byte $02
; indirect data load target
.byte $97
; indirect data load target
.byte $84
; indirect data load target
.byte $43
; indirect data load target
.byte $02
; indirect data load target
.byte $9F
; indirect data load target
.byte $84
; indirect data load target
.byte $44
; indirect data load target
.byte $02
; indirect data load target
.byte $A7
; indirect data load target
.byte $84
; indirect data load target
.byte $45
; indirect data load target
.byte $02
; indirect data load target
.byte $97
; indirect data load target
.byte $8C
; indirect data load target
.byte $46
; indirect data load target
.byte $02
; indirect data load target
.byte $9F
; indirect data load target
.byte $8C
; indirect data load target
.byte $47
; indirect data load target
.byte $02
; indirect data load target
.byte $A7
; indirect data load target
.byte $8C
; indirect data load target
.byte $48
; indirect data load target
.byte $02
; indirect data load target
.byte $97
; indirect data load target
.byte $94
; indirect data load target
.byte $49
; indirect data load target
.byte $02
; indirect data load target
.byte $9F
; indirect data load target
.byte $94
; indirect data load target
.byte $4A
; indirect data load target
.byte $02
; indirect data load target
.byte $A7
; indirect data load target
.byte $94
; indirect data load target
.byte $4B
; indirect data load target
.byte $02
; indirect data load target
.byte $9F
; indirect data load target
.byte $9C
; indirect data load target
.byte $4C
; indirect data load target
.byte $02
; indirect data load target
.byte $A7
; indirect data load target
.byte $9C
; indirect data load target
.byte $4D
; indirect data load target
.byte $02
; indirect data load target
.byte $9F
; indirect data load target
.byte $A4
; indirect data load target
.byte $4E
; indirect data load target
.byte $02
; indirect data load target
.byte $A7
; indirect data load target
.byte $A4
; indirect data load target
.byte $4F
; indirect data load target
.byte $02
; indirect data load target (via $A706)
.byte $FF
; indirect data load target
.byte $94
; indirect data load target
.byte $7B
; indirect data load target
.byte $00
; indirect data load target
.byte $02
; indirect data load target
.byte $9C
; indirect data load target
.byte $7B
; indirect data load target
.byte $01
; indirect data load target
.byte $02
; indirect data load target
.byte $A4
; indirect data load target
.byte $7B
; indirect data load target
.byte $02
; indirect data load target
.byte $02
; indirect data load target
.byte $94
; indirect data load target
.byte $83
; indirect data load target
.byte $03
; indirect data load target
.byte $02
; indirect data load target
.byte $9C
; indirect data load target
.byte $83
; indirect data load target
.byte $04
; indirect data load target
.byte $02
; indirect data load target
.byte $A4
; indirect data load target
.byte $83
; indirect data load target
.byte $05
; indirect data load target
.byte $02
; indirect data load target
.byte $AC
; indirect data load target
.byte $83
; indirect data load target
.byte $06
; indirect data load target
.byte $02
; indirect data load target
.byte $94
; indirect data load target
.byte $8B
; indirect data load target
.byte $07
; indirect data load target
.byte $02
; indirect data load target
.byte $9C
; indirect data load target
.byte $8B
; indirect data load target
.byte $08
; indirect data load target
.byte $02
; indirect data load target
.byte $A4
; indirect data load target
.byte $8B
; indirect data load target
.byte $09
; indirect data load target
.byte $02
; indirect data load target
.byte $AC
; indirect data load target
.byte $8B
; indirect data load target
.byte $0A
; indirect data load target
.byte $02
; indirect data load target
.byte $94
; indirect data load target
.byte $93
; indirect data load target
.byte $0B
; indirect data load target
.byte $02
; indirect data load target
.byte $9C
; indirect data load target
.byte $93
; indirect data load target
.byte $0C
; indirect data load target
.byte $02
; indirect data load target
.byte $A4
; indirect data load target
.byte $93
; indirect data load target
.byte $0D
; indirect data load target
.byte $02
; indirect data load target
.byte $AC
; indirect data load target
.byte $93
; indirect data load target
.byte $0E
; indirect data load target
.byte $02
; indirect data load target
.byte $94
; indirect data load target
.byte $9B
; indirect data load target
.byte $0F
; indirect data load target
.byte $02
; indirect data load target
.byte $9C
; indirect data load target
.byte $9B
; indirect data load target
.byte $10
; indirect data load target
.byte $02
; indirect data load target
.byte $A4
; indirect data load target
.byte $9B
; indirect data load target
.byte $11
; indirect data load target
.byte $02
; indirect data load target
.byte $AC
; indirect data load target
.byte $9B
; indirect data load target
.byte $12
; indirect data load target
.byte $02
; indirect data load target
.byte $9C
; indirect data load target
.byte $A3
; indirect data load target
.byte $13
; indirect data load target
.byte $02
; indirect data load target
.byte $A4
; indirect data load target
.byte $A3
; indirect data load target
.byte $14
; indirect data load target
.byte $02
; indirect data load target
.byte $9C
; indirect data load target
.byte $AB
; indirect data load target
.byte $15
; indirect data load target
.byte $02
; indirect data load target
.byte $A4
; indirect data load target
.byte $AB
; indirect data load target
.byte $16
; indirect data load target
.byte $02
; indirect data load target (via $A708)
.byte $FF
; indirect data load target
.byte $9C
; indirect data load target
.byte $7B
; indirect data load target
.byte $41
; indirect data load target
.byte $02
; indirect data load target
.byte $A4
; indirect data load target
.byte $7B
; indirect data load target
.byte $42
; indirect data load target
.byte $02
; indirect data load target
.byte $AC
; indirect data load target
.byte $7B
; indirect data load target
.byte $43
; indirect data load target
.byte $02
; indirect data load target
.byte $94
; indirect data load target
.byte $83
; indirect data load target
.byte $44
; indirect data load target
.byte $02
; indirect data load target
.byte $9C
; indirect data load target
.byte $83
; indirect data load target
.byte $45
; indirect data load target
.byte $02
; indirect data load target
.byte $A4
; indirect data load target
.byte $83
; indirect data load target
.byte $46
; indirect data load target
.byte $02
; indirect data load target
.byte $AC
; indirect data load target
.byte $83
; indirect data load target
.byte $47
; indirect data load target
.byte $02
; indirect data load target
.byte $94
; indirect data load target
.byte $8B
; indirect data load target
.byte $48
; indirect data load target
.byte $02
; indirect data load target
.byte $9C
; indirect data load target
.byte $8B
; indirect data load target
.byte $49
; indirect data load target
.byte $02
; indirect data load target
.byte $A4
; indirect data load target
.byte $8B
; indirect data load target
.byte $4A
; indirect data load target
.byte $02
; indirect data load target
.byte $AC
; indirect data load target
.byte $8B
; indirect data load target
.byte $4B
; indirect data load target
.byte $02
; indirect data load target
.byte $94
; indirect data load target
.byte $93
; indirect data load target
.byte $4C
; indirect data load target
.byte $02
; indirect data load target
.byte $9C
; indirect data load target
.byte $93
; indirect data load target
.byte $4D
; indirect data load target
.byte $02
; indirect data load target
.byte $A4
; indirect data load target
.byte $93
; indirect data load target
.byte $4E
; indirect data load target
.byte $02
; indirect data load target
.byte $AC
; indirect data load target
.byte $93
; indirect data load target
.byte $4F
; indirect data load target
.byte $02
; indirect data load target
.byte $94
; indirect data load target
.byte $9B
; indirect data load target
.byte $50
; indirect data load target
.byte $02
; indirect data load target
.byte $9C
; indirect data load target
.byte $9B
; indirect data load target
.byte $51
; indirect data load target
.byte $02
; indirect data load target
.byte $A4
; indirect data load target
.byte $9B
; indirect data load target
.byte $52
; indirect data load target
.byte $02
; indirect data load target
.byte $9C
; indirect data load target
.byte $A3
; indirect data load target
.byte $53
; indirect data load target
.byte $02
; indirect data load target
.byte $A4
; indirect data load target
.byte $A3
; indirect data load target
.byte $54
; indirect data load target
.byte $02
; indirect data load target
.byte $9C
; indirect data load target
.byte $AB
; indirect data load target
.byte $55
; indirect data load target
.byte $02
; indirect data load target
.byte $A4
; indirect data load target
.byte $AB
; indirect data load target
.byte $56
; indirect data load target
.byte $02
; indirect data load target (via $A70A)
.byte $FF
; indirect data load target (via $A70C)
.byte $94,$7B,$00,$02,$9C,$7B,$01,$02,$A4,$7B,$02,$02,$94,$83,$03,$02
.byte $9C,$83,$04,$02,$A4,$83,$05,$02,$94,$8B,$06,$02,$9C,$8B,$07,$02
.byte $A4,$8B,$08,$02,$94,$93,$09,$02,$9C,$93,$0A,$02,$A4,$93,$0B,$02
.byte $94,$9B,$0C,$02,$9C,$9B,$0D,$02,$A4,$9B,$0E,$02,$94,$A3,$0F,$02
.byte $9C,$A3,$10,$02,$A4,$A3,$11,$02,$94,$AB,$12
.byte $02,$9C,$AB,$13,$02
.byte $A4,$AB,$14
.byte $02
.byte $FF
; indirect data load target (via $A70E)
.byte $94,$7B,$40,$02,$9C,$7B,$41,$02,$A4,$7B,$42,$02,$94,$83,$43,$02
.byte $9C,$83,$44,$02,$A4,$83,$45,$02,$94,$8B,$46,$02,$9C,$8B,$47,$02
.byte $A4,$8B,$48,$02,$94,$93,$49,$02,$9C,$93,$4A,$02,$A4,$93,$4B,$02
.byte $94,$9B,$4C,$02,$9C,$9B,$4D,$02,$A4,$9B,$4E,$02,$94,$A3,$4F,$02
.byte $9C,$A3,$50,$02,$A4,$A3,$51,$02,$94,$AB,$52
.byte $02,$9C,$AB,$53,$02
.byte $A4,$AB,$54
.byte $02
.byte $FF
; indirect data load target
.byte $5B
; indirect data load target
.byte $81
; indirect data load target
.byte $20
; indirect data load target
.byte $01
; indirect data load target
.byte $63
; indirect data load target
.byte $81
; indirect data load target
.byte $21
; indirect data load target
.byte $01
; indirect data load target
.byte $5B
; indirect data load target
.byte $89
; indirect data load target
.byte $22
; indirect data load target
.byte $01
; indirect data load target
.byte $63
; indirect data load target
.byte $89
; indirect data load target
.byte $23
; indirect data load target
.byte $01
; indirect data load target (via $A710)
.byte $FF
; indirect data load target
.byte $5B
; indirect data load target
.byte $81
; indirect data load target
.byte $60
; indirect data load target
.byte $01
; indirect data load target
.byte $63
; indirect data load target
.byte $81
; indirect data load target
.byte $61
; indirect data load target
.byte $01
; indirect data load target
.byte $5B
; indirect data load target
.byte $89
; indirect data load target
.byte $62
; indirect data load target
.byte $01
; indirect data load target
.byte $63
; indirect data load target
.byte $89
; indirect data load target
.byte $63
; indirect data load target
.byte $01
; indirect data load target (via $A712)
.byte $FF
; indirect data load target
.byte $55
; indirect data load target
.byte $81
; indirect data load target
.byte $20
; indirect data load target
.byte $01
; indirect data load target
.byte $5D
; indirect data load target
.byte $81
; indirect data load target
.byte $21
; indirect data load target
.byte $01
; indirect data load target
.byte $55
; indirect data load target
.byte $89
; indirect data load target
.byte $22
; indirect data load target
.byte $01
; indirect data load target
.byte $5D
; indirect data load target
.byte $89
; indirect data load target
.byte $23
; indirect data load target
.byte $01
; indirect data load target
.byte $5D
; indirect data load target
.byte $91
; indirect data load target
.byte $24
; indirect data load target
.byte $01
; indirect data load target (via $A714)
.byte $FF
; indirect data load target
.byte $55
; indirect data load target
.byte $81
; indirect data load target
.byte $60
; indirect data load target
.byte $01
; indirect data load target
.byte $5D
; indirect data load target
.byte $81
; indirect data load target
.byte $61
; indirect data load target
.byte $01
; indirect data load target
.byte $55
; indirect data load target
.byte $89
; indirect data load target
.byte $62
; indirect data load target
.byte $01
; indirect data load target
.byte $5D
; indirect data load target
.byte $89
; indirect data load target
.byte $63
; indirect data load target
.byte $01
; indirect data load target
.byte $5D
; indirect data load target
.byte $91
; indirect data load target
.byte $64
; indirect data load target
.byte $01
; indirect data load target (via $A716)
.byte $FF
; indirect data load target
.byte $57
; indirect data load target
.byte $7D
; indirect data load target
.byte $20
; indirect data load target
.byte $01
; indirect data load target
.byte $5F
; indirect data load target
.byte $7D
; indirect data load target
.byte $21
; indirect data load target
.byte $01
; indirect data load target
.byte $57
; indirect data load target
.byte $85
; indirect data load target
.byte $22
; indirect data load target
.byte $01
; indirect data load target
.byte $5F
; indirect data load target
.byte $85
; indirect data load target
.byte $23
; indirect data load target
.byte $01
; indirect data load target
.byte $57
; indirect data load target
.byte $8D
; indirect data load target
.byte $24
; indirect data load target
.byte $01
; indirect data load target
.byte $5F
; indirect data load target
.byte $8D
; indirect data load target
.byte $25
; indirect data load target
.byte $01
; indirect data load target
.byte $57
; indirect data load target
.byte $95
; indirect data load target
.byte $26
; indirect data load target
.byte $01
; indirect data load target
.byte $5F
; indirect data load target
.byte $95
; indirect data load target
.byte $27
; indirect data load target
.byte $01
; indirect data load target (via $A718)
.byte $FF
; indirect data load target
.byte $57
; indirect data load target
.byte $7D
; indirect data load target
.byte $60
; indirect data load target
.byte $01
; indirect data load target
.byte $5F
; indirect data load target
.byte $7D
; indirect data load target
.byte $61
; indirect data load target
.byte $01
; indirect data load target
.byte $57
; indirect data load target
.byte $85
; indirect data load target
.byte $62
; indirect data load target
.byte $01
; indirect data load target
.byte $5F
; indirect data load target
.byte $85
; indirect data load target
.byte $63
; indirect data load target
.byte $01
; indirect data load target
.byte $57
; indirect data load target
.byte $8D
; indirect data load target
.byte $64
; indirect data load target
.byte $01
; indirect data load target
.byte $5F
; indirect data load target
.byte $8D
; indirect data load target
.byte $65
; indirect data load target
.byte $01
; indirect data load target
.byte $57
; indirect data load target
.byte $95
; indirect data load target
.byte $66
; indirect data load target
.byte $01
; indirect data load target
.byte $5F
; indirect data load target
.byte $95
; indirect data load target
.byte $67
; indirect data load target
.byte $01
; indirect data load target (via $A71A)
.byte $FF
; indirect data load target
.byte $54
; indirect data load target
.byte $7E
; indirect data load target
.byte $20
; indirect data load target
.byte $01
; indirect data load target
.byte $5C
; indirect data load target
.byte $7E
; indirect data load target
.byte $21
; indirect data load target
.byte $01
; indirect data load target
.byte $54
; indirect data load target
.byte $86
; indirect data load target
.byte $22
; indirect data load target
.byte $01
; indirect data load target
.byte $5C
; indirect data load target
.byte $86
; indirect data load target
.byte $23
; indirect data load target
.byte $01
; indirect data load target
.byte $64
; indirect data load target
.byte $86
; indirect data load target
.byte $24
; indirect data load target
.byte $01
; indirect data load target
.byte $54
; indirect data load target
.byte $8E
; indirect data load target
.byte $25
; indirect data load target
.byte $01
; indirect data load target
.byte $5C
; indirect data load target
.byte $8E
; indirect data load target
.byte $26
; indirect data load target
.byte $01
; indirect data load target
.byte $64
; indirect data load target
.byte $8E
; indirect data load target
.byte $27
; indirect data load target
.byte $01
; indirect data load target
.byte $54
; indirect data load target
.byte $96
; indirect data load target
.byte $28
; indirect data load target
.byte $01
; indirect data load target
.byte $5C
; indirect data load target
.byte $96
; indirect data load target
.byte $29
; indirect data load target
.byte $01
; indirect data load target
.byte $64
; indirect data load target
.byte $96
; indirect data load target
.byte $2A
; indirect data load target
.byte $01
; indirect data load target (via $A71C)
.byte $FF
; indirect data load target
.byte $54
; indirect data load target
.byte $7E
; indirect data load target
.byte $60
; indirect data load target
.byte $01
; indirect data load target
.byte $5C
; indirect data load target
.byte $7E
; indirect data load target
.byte $61
; indirect data load target
.byte $01
; indirect data load target
.byte $54
; indirect data load target
.byte $86
; indirect data load target
.byte $62
; indirect data load target
.byte $01
; indirect data load target
.byte $5C
; indirect data load target
.byte $86
; indirect data load target
.byte $63
; indirect data load target
.byte $01
; indirect data load target
.byte $64
; indirect data load target
.byte $86
; indirect data load target
.byte $64
; indirect data load target
.byte $01
; indirect data load target
.byte $54
; indirect data load target
.byte $8E
; indirect data load target
.byte $65
; indirect data load target
.byte $01
; indirect data load target
.byte $5C
; indirect data load target
.byte $8E
; indirect data load target
.byte $66
; indirect data load target
.byte $01
; indirect data load target
.byte $64
; indirect data load target
.byte $8E
; indirect data load target
.byte $67
; indirect data load target
.byte $01
; indirect data load target
.byte $5C
; indirect data load target
.byte $96
; indirect data load target
.byte $68
; indirect data load target
.byte $01
; indirect data load target (via $A71E)
.byte $FF
; indirect data load target
.byte $53
; indirect data load target
.byte $7C
; indirect data load target
.byte $20
; indirect data load target
.byte $01
; indirect data load target
.byte $5B
; indirect data load target
.byte $7C
; indirect data load target
.byte $21
; indirect data load target
.byte $01
; indirect data load target
.byte $63
; indirect data load target
.byte $7C
; indirect data load target
.byte $22
; indirect data load target
.byte $01
; indirect data load target
.byte $53
; indirect data load target
.byte $84
; indirect data load target
.byte $23
; indirect data load target
.byte $01
; indirect data load target
.byte $5B
; indirect data load target
.byte $84
; indirect data load target
.byte $24
; indirect data load target
.byte $01
; indirect data load target
.byte $63
; indirect data load target
.byte $84
; indirect data load target
.byte $25
; indirect data load target
.byte $01
; indirect data load target
.byte $53
; indirect data load target
.byte $8C
; indirect data load target
.byte $26
; indirect data load target
.byte $01
; indirect data load target
.byte $5B
; indirect data load target
.byte $8C
; indirect data load target
.byte $27
; indirect data load target
.byte $01
; indirect data load target
.byte $63
; indirect data load target
.byte $8C
; indirect data load target
.byte $28
; indirect data load target
.byte $01
; indirect data load target
.byte $53
; indirect data load target
.byte $94
; indirect data load target
.byte $29
; indirect data load target
.byte $01
; indirect data load target
.byte $5B
; indirect data load target
.byte $94
; indirect data load target
.byte $2A
; indirect data load target
.byte $01
; indirect data load target
.byte $63
; indirect data load target
.byte $94
; indirect data load target
.byte $2B
; indirect data load target
.byte $01
; indirect data load target
.byte $53
; indirect data load target
.byte $9C
; indirect data load target
.byte $2C
; indirect data load target
.byte $01
; indirect data load target
.byte $5B
; indirect data load target
.byte $9C
; indirect data load target
.byte $2D
; indirect data load target
.byte $01
; indirect data load target
.byte $63
; indirect data load target
.byte $9C
; indirect data load target
.byte $2E
; indirect data load target
.byte $01
; indirect data load target
.byte $5B
; indirect data load target
.byte $A4
; indirect data load target
.byte $2F
; indirect data load target
.byte $01
; indirect data load target
.byte $63
; indirect data load target
.byte $A4
; indirect data load target
.byte $30
; indirect data load target
.byte $01
; indirect data load target (via $A720)
.byte $FF
; indirect data load target
.byte $53
; indirect data load target
.byte $7C
; indirect data load target
.byte $60
; indirect data load target
.byte $01
; indirect data load target
.byte $5B
; indirect data load target
.byte $7C
; indirect data load target
.byte $61
; indirect data load target
.byte $01
; indirect data load target
.byte $63
; indirect data load target
.byte $7C
; indirect data load target
.byte $62
; indirect data load target
.byte $01
; indirect data load target
.byte $53
; indirect data load target
.byte $84
; indirect data load target
.byte $63
; indirect data load target
.byte $01
; indirect data load target
.byte $5B
; indirect data load target
.byte $84
; indirect data load target
.byte $64
; indirect data load target
.byte $01
; indirect data load target
.byte $63
; indirect data load target
.byte $84
; indirect data load target
.byte $65
; indirect data load target
.byte $01
; indirect data load target
.byte $53
; indirect data load target
.byte $8C
; indirect data load target
.byte $66
; indirect data load target
.byte $01
; indirect data load target
.byte $5B
; indirect data load target
.byte $8C
; indirect data load target
.byte $67
; indirect data load target
.byte $01
; indirect data load target
.byte $63
; indirect data load target
.byte $8C
; indirect data load target
.byte $68
; indirect data load target
.byte $01
; indirect data load target
.byte $53
; indirect data load target
.byte $94
; indirect data load target
.byte $69
; indirect data load target
.byte $01
; indirect data load target
.byte $5B
; indirect data load target
.byte $94
; indirect data load target
.byte $6A
; indirect data load target
.byte $01
; indirect data load target
.byte $63
; indirect data load target
.byte $94
; indirect data load target
.byte $6B
; indirect data load target
.byte $01
; indirect data load target
.byte $53
; indirect data load target
.byte $9C
; indirect data load target
.byte $6C
; indirect data load target
.byte $01
; indirect data load target
.byte $5B
; indirect data load target
.byte $9C
; indirect data load target
.byte $6D
; indirect data load target
.byte $01
; indirect data load target
.byte $63
; indirect data load target
.byte $9C
; indirect data load target
.byte $6E
; indirect data load target
.byte $01
; indirect data load target
.byte $5B
; indirect data load target
.byte $A4
; indirect data load target
.byte $6F
; indirect data load target
.byte $01
; indirect data load target
.byte $63
; indirect data load target
.byte $A4
; indirect data load target
.byte $70
; indirect data load target
.byte $01
; indirect data load target (via $A722)
.byte $FF
; indirect data load target
.byte $58
; indirect data load target
.byte $7B
; indirect data load target
.byte $23
; indirect data load target
.byte $01
; indirect data load target
.byte $60
; indirect data load target
.byte $7B
; indirect data load target
.byte $24
; indirect data load target
.byte $01
; indirect data load target
.byte $50
; indirect data load target
.byte $83
; indirect data load target
.byte $25
; indirect data load target
.byte $01
; indirect data load target
.byte $58
; indirect data load target
.byte $83
; indirect data load target
.byte $26
; indirect data load target
.byte $01
; indirect data load target
.byte $60
; indirect data load target
.byte $83
; indirect data load target
.byte $27
; indirect data load target
.byte $01
; indirect data load target
.byte $68
; indirect data load target
.byte $83
; indirect data load target
.byte $28
; indirect data load target
.byte $01
; indirect data load target
.byte $50
; indirect data load target
.byte $8B
; indirect data load target
.byte $29
; indirect data load target
.byte $01
; indirect data load target
.byte $58
; indirect data load target
.byte $8B
; indirect data load target
.byte $2A
; indirect data load target
.byte $01
; indirect data load target
.byte $60
; indirect data load target
.byte $8B
; indirect data load target
.byte $2B
; indirect data load target
.byte $01
; indirect data load target
.byte $68
; indirect data load target
.byte $8B
; indirect data load target
.byte $2C
; indirect data load target
.byte $01
; indirect data load target
.byte $50
; indirect data load target
.byte $93
; indirect data load target
.byte $2D
; indirect data load target
.byte $01
; indirect data load target
.byte $58
; indirect data load target
.byte $93
; indirect data load target
.byte $2E
; indirect data load target
.byte $01
; indirect data load target
.byte $60
; indirect data load target
.byte $93
; indirect data load target
.byte $2F
; indirect data load target
.byte $01
; indirect data load target
.byte $68
; indirect data load target
.byte $93
; indirect data load target
.byte $30
; indirect data load target
.byte $01
; indirect data load target
.byte $50
; indirect data load target
.byte $9B
; indirect data load target
.byte $31
; indirect data load target
.byte $01
; indirect data load target
.byte $58
; indirect data load target
.byte $9B
; indirect data load target
.byte $32
; indirect data load target
.byte $01
; indirect data load target
.byte $60
; indirect data load target
.byte $9B
; indirect data load target
.byte $33
; indirect data load target
.byte $01
; indirect data load target
.byte $68
; indirect data load target
.byte $9B
; indirect data load target
.byte $34
; indirect data load target
.byte $01
; indirect data load target
.byte $50
; indirect data load target
.byte $A3
; indirect data load target
.byte $35
; indirect data load target
.byte $01
; indirect data load target
.byte $58
; indirect data load target
.byte $A3
; indirect data load target
.byte $36
; indirect data load target
.byte $01
; indirect data load target
.byte $60
; indirect data load target
.byte $A3
; indirect data load target
.byte $37
; indirect data load target
.byte $01
; indirect data load target
.byte $58
; indirect data load target
.byte $AB
; indirect data load target
.byte $38
; indirect data load target
.byte $01
; indirect data load target
.byte $60
; indirect data load target
.byte $AB
; indirect data load target
.byte $39
; indirect data load target
.byte $01
; indirect data load target (via $A724)
.byte $FF
; indirect data load target
.byte $58
; indirect data load target
.byte $7B
; indirect data load target
.byte $62
; indirect data load target
.byte $01
; indirect data load target
.byte $60
; indirect data load target
.byte $7B
; indirect data load target
.byte $63
; indirect data load target
.byte $01
; indirect data load target
.byte $50
; indirect data load target
.byte $83
; indirect data load target
.byte $64
; indirect data load target
.byte $01
; indirect data load target
.byte $58
; indirect data load target
.byte $83
; indirect data load target
.byte $65
; indirect data load target
.byte $01
; indirect data load target
.byte $60
; indirect data load target
.byte $83
; indirect data load target
.byte $66
; indirect data load target
.byte $01
; indirect data load target
.byte $68
; indirect data load target
.byte $83
; indirect data load target
.byte $67
; indirect data load target
.byte $01
; indirect data load target
.byte $50
; indirect data load target
.byte $8B
; indirect data load target
.byte $68
; indirect data load target
.byte $01
; indirect data load target
.byte $58
; indirect data load target
.byte $8B
; indirect data load target
.byte $69
; indirect data load target
.byte $01
; indirect data load target
.byte $60
; indirect data load target
.byte $8B
; indirect data load target
.byte $6A
; indirect data load target
.byte $01
; indirect data load target
.byte $68
; indirect data load target
.byte $8B
; indirect data load target
.byte $6B
; indirect data load target
.byte $01
; indirect data load target
.byte $50
; indirect data load target
.byte $93
; indirect data load target
.byte $6C
; indirect data load target
.byte $01
; indirect data load target
.byte $58
; indirect data load target
.byte $93
; indirect data load target
.byte $6D
; indirect data load target
.byte $01
; indirect data load target
.byte $60
; indirect data load target
.byte $93
; indirect data load target
.byte $6E
; indirect data load target
.byte $01
; indirect data load target
.byte $68
; indirect data load target
.byte $93
; indirect data load target
.byte $6F
; indirect data load target
.byte $01
; indirect data load target
.byte $50
; indirect data load target
.byte $9B
; indirect data load target
.byte $70
; indirect data load target
.byte $01
; indirect data load target
.byte $58
; indirect data load target
.byte $9B
; indirect data load target
.byte $71
; indirect data load target
.byte $01
; indirect data load target
.byte $60
; indirect data load target
.byte $9B
; indirect data load target
.byte $72
; indirect data load target
.byte $01
; indirect data load target
.byte $50
; indirect data load target
.byte $A3
; indirect data load target
.byte $73
; indirect data load target
.byte $01
; indirect data load target
.byte $58
; indirect data load target
.byte $A3
; indirect data load target
.byte $74
; indirect data load target
.byte $01
; indirect data load target
.byte $60
; indirect data load target
.byte $A3
; indirect data load target
.byte $75
; indirect data load target
.byte $01
; indirect data load target
.byte $68
; indirect data load target
.byte $A3
; indirect data load target
.byte $76
; indirect data load target
.byte $01
; indirect data load target
.byte $58
; indirect data load target
.byte $AB
; indirect data load target
.byte $77
; indirect data load target
.byte $01
; indirect data load target
.byte $60
; indirect data load target
.byte $AB
; indirect data load target
.byte $78
; indirect data load target
.byte $01
; indirect data load target (via $A726)
.byte $FF
; indirect data load target
.byte $58
; indirect data load target
.byte $7B
; indirect data load target
.byte $23
; indirect data load target
.byte $01
; indirect data load target
.byte $60
; indirect data load target
.byte $7B
; indirect data load target
.byte $24
; indirect data load target
.byte $01
; indirect data load target
.byte $50
; indirect data load target
.byte $83
; indirect data load target
.byte $25
; indirect data load target
.byte $01
; indirect data load target
.byte $58
; indirect data load target
.byte $83
; indirect data load target
.byte $26
; indirect data load target
.byte $01
; indirect data load target
.byte $60
; indirect data load target
.byte $83
; indirect data load target
.byte $27
; indirect data load target
.byte $01
; indirect data load target
.byte $68
; indirect data load target
.byte $83
; indirect data load target
.byte $28
; indirect data load target
.byte $01
; indirect data load target
.byte $50
; indirect data load target
.byte $8B
; indirect data load target
.byte $29
; indirect data load target
.byte $01
; indirect data load target
.byte $58
; indirect data load target
.byte $8B
; indirect data load target
.byte $2A
; indirect data load target
.byte $01
; indirect data load target
.byte $60
; indirect data load target
.byte $8B
; indirect data load target
.byte $2B
; indirect data load target
.byte $01
; indirect data load target
.byte $68
; indirect data load target
.byte $8B
; indirect data load target
.byte $2C
; indirect data load target
.byte $01
; indirect data load target
.byte $50
; indirect data load target
.byte $93
; indirect data load target
.byte $2D
; indirect data load target
.byte $01
; indirect data load target
.byte $58
; indirect data load target
.byte $93
; indirect data load target
.byte $2E
; indirect data load target
.byte $01
; indirect data load target
.byte $60
; indirect data load target
.byte $93
; indirect data load target
.byte $2F
; indirect data load target
.byte $01
; indirect data load target
.byte $68
; indirect data load target
.byte $93
; indirect data load target
.byte $30
; indirect data load target
.byte $01
; indirect data load target
.byte $50
; indirect data load target
.byte $9B
; indirect data load target
.byte $31
; indirect data load target
.byte $01
; indirect data load target
.byte $58
; indirect data load target
.byte $9B
; indirect data load target
.byte $32
; indirect data load target
.byte $01
; indirect data load target
.byte $60
; indirect data load target
.byte $9B
; indirect data load target
.byte $33
; indirect data load target
.byte $01
; indirect data load target
.byte $68
; indirect data load target
.byte $9B
; indirect data load target
.byte $34
; indirect data load target
.byte $01
; indirect data load target
.byte $58
; indirect data load target
.byte $A3
; indirect data load target
.byte $35
; indirect data load target
.byte $01
; indirect data load target
.byte $60
; indirect data load target
.byte $A3
; indirect data load target
.byte $36
; indirect data load target
.byte $01
; indirect data load target
.byte $68
; indirect data load target
.byte $A3
; indirect data load target
.byte $37
; indirect data load target
.byte $01
; indirect data load target
.byte $58
; indirect data load target
.byte $AB
; indirect data load target
.byte $38
; indirect data load target
.byte $01
; indirect data load target
.byte $60
; indirect data load target
.byte $AB
; indirect data load target
.byte $39
; indirect data load target
.byte $01
; indirect data load target (via $A728)
.byte $FF
; indirect data load target (via $A72A)
.byte $58,$7B,$22,$01,$60,$7B,$23,$01,$58,$83,$25,$01,$60,$83,$26,$01
.byte $50,$8B,$27,$01,$58,$8B,$28,$01,$60,$8B,$29,$01,$50,$93,$2A,$01
.byte $58,$93,$2B,$01,$60,$93,$2C,$01,$50,$9B,$2D,$01,$58,$9B,$2E,$01
.byte $60,$9B,$2F,$01,$50,$A3,$30,$01,$58,$A3,$31,$01,$60,$A3,$32
.byte $01,$50,$AB,$33,$01,$58,$AB
.byte $34,$01,$60,$AB
.byte $35,$01
.byte $FF
; indirect data load target (via $83FE)
.byte $58,$7B,$62,$01,$60,$7B,$63,$01,$50,$83,$64,$01,$58,$83,$65,$01
.byte $60,$83,$66,$01,$50,$8B,$67,$01,$58,$8B,$68,$01,$60,$8B,$69,$01
.byte $50,$93,$6A,$01,$58,$93,$6B,$01,$60,$93,$6C,$01,$50,$9B,$6D,$01
.byte $58,$9B,$6E,$01,$60,$9B,$6F,$01,$50,$A3,$70,$01,$58,$A3,$71,$01
.byte $60,$A3,$72,$01,$50,$AB,$73,$01,$58
.byte $AB,$74,$01,$60
.byte $AB,$75
.byte $01
.byte $FF
; indirect data load target
.byte $F8,$00,$F8
.byte $00,$F8
.byte $00
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $7F
; indirect data load target
.byte $79
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $80
; indirect data load target
.byte $78
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $82
; indirect data load target
.byte $78
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $7F
; indirect data load target
.byte $78
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $7F
; indirect data load target
.byte $78
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $81
; indirect data load target
.byte $78
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $80
; indirect data load target
.byte $75
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $80
; indirect data load target
.byte $75
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $81
; indirect data load target
.byte $75
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $81
; indirect data load target
.byte $74
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $81
; indirect data load target
.byte $74
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $81
; indirect data load target
.byte $74
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $73
; indirect data load target
.byte $71
; indirect data load target
.byte $7B
; indirect data load target
.byte $71
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $74
; indirect data load target
.byte $71
; indirect data load target
.byte $7C
; indirect data load target
.byte $71
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $75
; indirect data load target
.byte $71
; indirect data load target
.byte $7D
; indirect data load target
.byte $71
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $72
; indirect data load target
.byte $6E
; indirect data load target
.byte $7A
; indirect data load target
.byte $6E
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $75
; indirect data load target
.byte $6E
; indirect data load target
.byte $7D
; indirect data load target
.byte $6E
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $76
; indirect data load target
.byte $6E
; indirect data load target
.byte $7E
; indirect data load target
.byte $6E
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $7C
; indirect data load target
.byte $9D
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $7D
; indirect data load target
.byte $9C
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $7F
; indirect data load target
.byte $9C
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $7C
; indirect data load target
.byte $9C
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $7C
; indirect data load target
.byte $9C
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $7E
; indirect data load target
.byte $9C
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $7D
; indirect data load target
.byte $99
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $7D
; indirect data load target
.byte $99
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $7E
; indirect data load target
.byte $99
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $7E
; indirect data load target
.byte $96
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $7E
; indirect data load target
.byte $97
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $7E
; indirect data load target
.byte $98
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $70
; indirect data load target
.byte $95
; indirect data load target
.byte $78
; indirect data load target
.byte $95
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $71
; indirect data load target
.byte $95
; indirect data load target
.byte $79
; indirect data load target
.byte $95
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $72
; indirect data load target
.byte $95
; indirect data load target
.byte $7A
; indirect data load target
.byte $95
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $6F
; indirect data load target
.byte $92
; indirect data load target
.byte $77
; indirect data load target
.byte $92
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $72
; indirect data load target
.byte $92
; indirect data load target
.byte $7A
; indirect data load target
.byte $92
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $73
; indirect data load target
.byte $92
; indirect data load target
.byte $7B

.byte $92
; data -> unknown

.byte $F8,$00,$73,$94,$7B,$94
.byte $F8,$00,$72
.byte $A3,$7A
.byte $A3
; unknown -> data
; indirect data load target
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $7C
; indirect data load target
.byte $59
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $7D
; indirect data load target
.byte $58
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $7F
; indirect data load target
.byte $58
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $7C
; indirect data load target
.byte $58
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $7C
; indirect data load target
.byte $58
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $7E
; indirect data load target
.byte $58
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $7E
; indirect data load target
.byte $55
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $7D
; indirect data load target
.byte $55
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $7E
; indirect data load target
.byte $55
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $7E
; indirect data load target
.byte $52
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $7E
; indirect data load target
.byte $53
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $7E
; indirect data load target
.byte $54
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $70
; indirect data load target
.byte $51
; indirect data load target
.byte $78
; indirect data load target
.byte $51
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $71
; indirect data load target
.byte $51
; indirect data load target
.byte $79
; indirect data load target
.byte $51
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $72
; indirect data load target
.byte $51
; indirect data load target
.byte $7A
; indirect data load target
.byte $51
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $6F
; indirect data load target
.byte $4F
; indirect data load target
.byte $77
; indirect data load target
.byte $4F
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $72
; indirect data load target
.byte $4F
; indirect data load target
.byte $7A
; indirect data load target
.byte $4F
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $73
; indirect data load target
.byte $4F
; indirect data load target
.byte $7B

.byte $4F
; data -> unknown

.byte $F8,$00,$73,$50,$7B,$50
.byte $F8,$00,$72
.byte $50,$7A
.byte $50
; unknown -> free
.res $e3d
; ... skipping $E3D FF bytes
.byte $FF

.byte $FF
; free -> unknown

.byte $78,$EE,$DF,$BF,$4C,$86,$FF,$80
.literal "DRAGON WARRIORS2"
.byte $FF,$FF,$00,$00,$48,$04,$01,$0F
.byte $07,$9D,$D8,$BF,$D8,$BF,$D8,$BF
