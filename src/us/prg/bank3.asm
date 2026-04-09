.segment        "PRG3":absolute
; code bytes:	$0367 (5.32% of bytes in this ROM bank)
; data bytes:	$3BDA (93.52% of bytes in this ROM bank)
; pcm bytes:	$0000 (0.00% of bytes in this ROM bank)
; chr bytes:	$0000 (0.00% of bytes in this ROM bank)
; free bytes:	$000A (0.06% of bytes in this ROM bank)
; unknown bytes:	$00B5 (1.10% of bytes in this ROM bank)
; $3F41 bytes last seen in RAM bank $8000 - $BFFF (100.00% of bytes seen in this ROM bank, 98.83% of bytes in this ROM bank):
;	$0367 code bytes (5.38% of bytes seen in this RAM bank, 5.32% of bytes in this ROM bank)
;	$3BDA data bytes (94.62% of bytes seen in this RAM bank, 93.52% of bytes in this ROM bank)

; PRG Bank 0x03: mostly music, also has warp data

; [bank start] -> code
; external control flow target (from $0F:$C0CB)
; possible external indexed data load target (from $0F:$F3ED, $0F:$FF28)
; possible external indexed data load target (from $0F:$F3F2, $0F:$FF2D)
    jmp $800C

; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])
; external control flow target (from $0F:$C56D)
B03_8003:
    jmp $82A9 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])


; external control flow target (from $0F:$C683, $0F:$D17F)
    jmp $8282

; external control flow target (from $0F:$C583)
    jmp $83DB ; set $6144 to #$05


; control flow target (from $8000)
    jsr $83E1
    ldx #$08
    ldy #$00
    jsr $8158
    lda $0152
    clc
    adc $0153
    sta $0152
    bcc B03_805E
; control flow target (from $8042)
B03_8022:
    sbc #$96
    sta $0152
    ldx #$00
    iny
    jsr $8158
    ldx #$02
    jsr $8158
    ldx #$04
    jsr $8158
    ldx #$06
    dey
    jsr $8158
    lda $0152
    cmp #$6A
    bcc B03_8022
    ldx #$06
; control flow target (from $804E)
B03_8046:
    lda ($F2,X)
    eor #$FC
    beq B03_805B
    dex
    dex
    bpl B03_8046
    ldx #$06
; control flow target (from $8059)
B03_8052:
    lda $012A,X
    bne B03_805B
    dex
    dex
    bpl B03_8052
; control flow target (from $804A, $8055)
B03_805B:
    sta $0156 ; probably music playing flag? set to #$00 when music finishes

; control flow target (from $8020)
B03_805E:
    ldx #$00
    ldy #$00
    jsr $8244
    jsr $80C3
    ldx #$02
    ldy #$04
    lda $0132
    beq B03_8082
    lda $0142
    bpl B03_8082
    jsr $8270 ; clear bit 7 of $0149,X

    ldy #$10
    jsr $80C3
    ldx #$08
    ldy #$04
; control flow target (from $806F, $8074)
B03_8082:
    jsr $8244
    jsr $80C3
    ldx #$04
    ldy #$08
    jsr $8244
    lda $0143
    eor #$FF
    and #$FE
    pha
    lda $6143
    cmp #$08
    bcs B03_80A2
    pla
    lda #$00
    pha
; control flow target (from $809C)
B03_80A2:
    pla
    sta $4008 ; pAPU Triangle Control Register #1

    ldx #$06
    ldy #$0C
    lda $0132
    beq B03_80C0
    lda $0142
    bmi B03_80C0
    jsr $8270 ; clear bit 7 of $0149,X

    ldy #$10
    jsr $80C3
    ldx #$08
    ldy #$0C
; control flow target (from $80AD, $80B2)
B03_80C0:
    jsr $8244
; control flow target (from $8065, $807B, $8085, $80B9)
    lda $013F,X
    bpl B03_80EE
    ldx #$30
    cmp #$FF
    beq B03_80D0
    ldx #$32
; control flow target (from $80CC, $8112)
B03_80D0:
    txa
    cpy #$08
    bcs B03_80EA
    pha
    and #$0F
    sta $6141
    lda $6143
    sta $6142
    jsr $839F
    pla
    and #$F0
    ora $6141
; control flow target (from $80D3)
B03_80EA:
    sta $4000,Y ; pAPU Pulse #1 Control Register

    rts

; control flow target (from $80C6)
B03_80EE:
    tya
    pha
    ldy $013E,X
    lda $850D,Y
    sta $FC
    lda $850E,Y
    sta $FD
    ldy $013F,X
; control flow target (from $810A)
B03_8100:
    lda ($FC),Y
    cmp #$30
    bcs B03_810C
    sta $013F,X
    tay
    bcc B03_8100
; control flow target (from $8104)
B03_810C:
    inc $013F,X
    tax
    pla
    tay
    bcs B03_80D0
; control flow target (from $817E)
B03_8114:
    jsr $8279 ; return ($F2,X) in A, INC 16-bit $F2,X

    pha
    jsr $8279 ; return ($F2,X) in A, INC 16-bit $F2,X

    pha
    lda $F2,X
    sta $0122,X
    lda $F3,X
    sta $0123,X
    pla
    sta $F3,X
    pla
    sta $F2,X
    bcs B03_8179
; control flow target (from $81AC)
B03_812E:
    lda $0148,X
    bne B03_8144
    lda #$02
    bne B03_8141
; control flow target (from $819E)
B03_8137:
    lda $0148,X
    php
    jsr $8279 ; return ($F2,X) in A, INC 16-bit $F2,X

    plp
    bne B03_8144
; control flow target (from $8135)
B03_8141:
    sta $0148,X
; control flow target (from $8131, $813F)
B03_8144:
    jsr $8279 ; return ($F2,X) in A, INC 16-bit $F2,X

    dec $0148,X
    beq B03_8155
    clc
    adc $F2,X
    sta $F2,X
    bcs B03_8155
    dec $F3,X
; control flow target (from $814A, $8151)
B03_8155:
    jmp $8179

; control flow target (from $8013, $802A, $802F, $8034, $803A)
    lda $012A,X
    bne B03_815E
; control flow target (from $8177)
B03_815D:
    rts

; control flow target (from $815B)
B03_815E:
    lda $0134,X
    beq B03_8174
    dec $0134,X
    bne B03_8174
    lda $013F,X
    cmp #$FF
    beq B03_8174
    lda #$FE
    sta $013F,X
; control flow target (from $8161, $8166, $816D)
B03_8174:
    dec $012A,X
    bne B03_815D
; control flow target (from $812C, $8155, $8188, $818C, $819A, $81A8, $81B7, $81C6, $81CD)
B03_8179:
    jsr $8279 ; return ($F2,X) in A, INC 16-bit $F2,X

    cmp #$FE
    beq B03_8114
    bcc B03_818A
    jsr $8279 ; return ($F2,X) in A, INC 16-bit $F2,X

    sta $0153
    bcs B03_8179
; control flow target (from $8180)
B03_818A:
    cmp #$FC
    beq B03_8179
    bcc B03_819C
    lda $0122,X
    sta $F2,X
    lda $0123,X
    sta $F3,X
    bcs B03_8179
; control flow target (from $818E)
B03_819C:
    cmp #$FA
    beq B03_8137
    bcc B03_81AA
    jsr $8279 ; return ($F2,X) in A, INC 16-bit $F2,X

    sta $0154
    bcs B03_8179
; control flow target (from $81A0)
B03_81AA:
    cmp #$F9
    beq B03_812E
    cmp #$F7
    bcc B03_81B9
    and #$01
    sta $0153,X
    bcs B03_8179
; control flow target (from $81B0)
B03_81B9:
    cmp #$E1
    bcc B03_81CF
    sbc #$E1
    asl
    sta $013E,X
    lda $013F,X
    bmi B03_8179
    lda #$00
    sta $013F,X
    beq B03_8179
; control flow target (from $81BB)
B03_81CF:
    pha
    sec
; control flow target (from $81D3)
B03_81D1:
    sbc #$4B
    bcs B03_81D1
    adc #$4B
    cmp #$49
    bne B03_81E2
    lda #$FF
    sta $013F,X
    bne B03_81F8
; control flow target (from $81D9)
B03_81E2:
    bcs B03_81F8
    dey
    iny
    beq B03_81EB
    adc $0154
; control flow target (from $81E6)
B03_81EB:
    sta $0149,X
    lda $0135,X
    bmi B03_81F8
    lda #$00
    sta $013F,X
; control flow target (from $81E0, $81E2, $81F1)
B03_81F8:
    cpx #$02
    beq B03_8200
    cpx #$04
    bne B03_8211
; control flow target (from $81FA)
B03_8200:
    lda $0153,X
    beq B03_8211
    lda $0129,X
    sta $012B,X
    lda $0133,X
    sta $0135,X
; control flow target (from $81FE, $8203)
B03_8211:
    pla
    cmp #$96
    bcc B03_821F
    jsr $8279 ; return ($F2,X) in A, INC 16-bit $F2,X

    sta $0135,X
    jmp $8235

; control flow target (from $8214)
B03_821F:
    cmp #$4B
    bcc B03_8235
    jsr $8279 ; return ($F2,X) in A, INC 16-bit $F2,X

    pha
    and #$7F
    sta $012B,X
    pla
    bpl B03_8235
    jsr $8279 ; return ($F2,X) in A, INC 16-bit $F2,X

    sta $0135,X
; control flow target (from $821C, $8221, $822D)
B03_8235:
    lda $012B,X
    sta $012A,X
    lda $0135,X
    and #$7F
    sta $0134,X
    rts

; control flow target (from $8062, $8082, $808C, $80C0)
    lda $0149,X
    bmi B03_826F
    ora #$80
    sta $0149,X
    cpy #$0C
    bne B03_825D
    and #$0F
    sta $400E ; pAPU Noise Frequency Register #1

    lda #$08
    sta $400F ; pAPU Noise Frequency Register #2

    rts

; control flow target (from $8250)
B03_825D:
    asl
    stx $FC
    tax
    lda $830D,X
    sta $4002,Y ; pAPU Pulse #1 Fine Tune Register

    lda $830E,X
    sta $4003,Y ; pAPU Pulse #1 Coarse Tune Register

    ldx $FC
; control flow target (from $8247)
B03_826F:
    rts

; clear bit 7 of $0149,X
; control flow target (from $8076, $80B4)
    lda $0149,X
    and #$7F
    sta $0149,X
    rts

; return ($F2,X) in A, INC 16-bit $F2,X
; control flow target (from $8114, $8118, $813B, $8144, $8179, $8182, $81A2, $8216, $8223, $822F, $82E1)
    lda ($F2,X)
    inc $F2,X
    bne B03_8281
    inc $F3,X
; control flow target (from $827D)
B03_8281:
    rts

; control flow target (from $8006)
    sei
    lda #$00
    sta $4015 ; READ: pAPU Sound/Vertical Clock Signal Register (#$40: Vertical Clock Signal IRQ Availability, #$10: Delta Modulation, #$08: Noise, #$04: Triangle, #$02: Pulse #2, #$01: Pulse #1), WRITE: pAPU Channel Control (#$10: Delta Modulation, #$08: Noise, #$04: Triangle, #$02: Pulse #2, #$01: Pulse #1)

    sta $4017 ; Joypad #2/SOFTCLK (READ: #$80: Vertical Clock Signal (External), #$40: Vertical Clock Signal (Internal), #$10: Zapper Trigger Not Pulled, #$08: Zapper Sprite Detection, #$01: Joypad Data; WRITE: #$01: set Expansion Port Method to Read)

    lda #$0F
    sta $4015 ; READ: pAPU Sound/Vertical Clock Signal Register (#$40: Vertical Clock Signal IRQ Availability, #$10: Delta Modulation, #$08: Noise, #$04: Triangle, #$02: Pulse #2, #$01: Pulse #1), WRITE: pAPU Channel Control (#$10: Delta Modulation, #$08: Noise, #$04: Triangle, #$02: Pulse #2, #$01: Pulse #1)

    lda #$08
    sta $4001 ; pAPU Pulse #1 Ramp Control Register

    sta $4005 ; pAPU Pulse #2 Ramp Control Register

    lda #$FF
    sta $0152
    lda #$00 ; Music ID #$00: BGM off

    jsr $82A9 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    lda #$80 ; Music ID #$80: SFX off

    jsr $82A9 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    cli
    rts

; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])
; control flow target (from $8003, $829F, $82A4)
B03_82A9:
    php
    sei
    asl
    bcs B03_82EE
    asl
    asl
    ora #$06
    tax
    ldy #6
; control flow target (from $82D2)
B03_82B5:
    lda B03_83F9+1,X
    sta $00F3,Y
    lda B03_83F9,X
    sta $00F2,Y
    lda #$01
    sta $012A,Y
    lda #$00
    sta $0135,Y
    sta $0148,Y
    dex
    dex
    dey
    dey
    bpl B03_82B5
    sta $0154
    sta $0155
    sta $0157
    sta $6144
    tax
    jsr $8279 ; return ($F2,X) in A, INC 16-bit $F2,X

    sta $0153
    lda #$10
    sta $6143
    plp
    rts

; control flow target (from $82AC)
B03_82EE:
    tax
    lda $84D2,X
    sta $0142
    ora #$80
    sta $FB
    lda $84D1,X
    sta $FA
    lda #$01
    sta $0132
    lda #$00
    sta $013D
    sta $0150
    plp
    rts


; code -> data
; indexed data load target (from $8261)
; indexed data load target (from $8267)
.byte $AD

.byte $0E
; data -> unknown

.byte $4D,$0E,$F3,$0D,$9D,$0D
.byte $4C,$0D,$00
.byte $0D,$B8
.byte $0C
; unknown -> data

.byte $74
.byte $0C
; data -> unknown

.byte $34,$0C
.byte $F8
.byte $0B
; unknown -> data

.byte $BF,$0B,$89
.byte $0B,$56
.byte $0B
; data -> unknown

.byte $26
.byte $0B
; unknown -> data

.byte $F9,$0A,$CE,$0A,$A6,$0A,$80,$0A,$5C,$0A,$3A,$0A,$1A,$0A,$FB,$09
.byte $DF,$09,$C4,$09,$AB,$09,$93,$09,$7C,$09,$67,$09,$52,$09,$3F,$09
.byte $2D,$09,$1C,$09,$0C,$09,$FD,$08,$EF,$08,$E1,$08,$D5,$08,$C9,$08
.byte $BD,$08,$B3,$08,$A9,$08,$9F,$08,$96,$08,$8E,$08,$86,$08,$7E,$08
.byte $77,$08,$70,$08,$6A,$08,$64,$08,$5E,$08,$59,$08,$54,$08,$4F
.byte $08,$4B,$08,$46,$08,$42,$08,$3F
.byte $08,$3B,$08,$38
.byte $08,$34
.byte $08
; data -> unknown

.byte $31,$08,$2F,$08,$2C
.byte $08,$29,$08
.byte $27
.byte $08
; unknown -> data

.byte $25
.byte $08
; data -> unknown

.byte $23,$08
.byte $21
.byte $08
; unknown -> data

.byte $1F
.byte $08
; data -> unknown

.byte $1D,$08,$1B
.byte $08,$1A
.byte $08
; unknown -> code
; control flow target (from $80E1)
    lda $6141
    eor #$FF
    sta $6141
    lda #$00
    lsr $6141
    bcs B03_83B1
    adc $6142
; control flow target (from $83AC)
B03_83B1:
    lsr
    lsr $6141
    bcs B03_83BA
    adc $6142
; control flow target (from $83B5)
B03_83BA:
    lsr
    lsr $6141
    bcs B03_83C3
    adc $6142
; control flow target (from $83BE)
B03_83C3:
    lsr
    lsr $6141
    bcs B03_83CC
    adc $6142
; control flow target (from $83C7)
B03_83CC:
    lsr
    lsr $6141
    bcs B03_83D5
    adc $6142
; control flow target (from $83D0)
B03_83D5:
    and #$0F
    sta $6141
    rts

; set $6144 to #$05
; control flow target (from $8009)
    lda #$05
    sta $6144
    rts

; control flow target (from $800C)
    lda $6144
    beq B03_83F8
    dec $6144
    bne B03_83F8
    lda $6143
    beq B03_83F8
    dec $6143
    lda #$05
    sta $6144
; control flow target (from $83E4, $83E9, $83EE)
B03_83F8:
    rts


; code -> data
B03_83F9:
.addr $852F      ; $03:$852F
.addr $8530      ; $03:$8530
.addr $8530      ; $03:$8530
.addr $8530      ; $03:$8530
.addr $998B      ; $03:$998B
.addr $999A      ; $03:$999A
.addr $8530      ; $03:$8530
.addr $8530      ; $03:$8530
.addr $99A4      ; $03:$99A4
.addr $99B8      ; $03:$99B8
.addr $99C2      ; $03:$99C2
.addr $8530      ; $03:$8530
.addr $99DA      ; $03:$99DA
.addr $99FC      ; $03:$99FC
.addr $99CB      ; $03:$99CB
.addr $8530      ; $03:$8530
.addr $9A0C      ; $03:$9A0C
.addr $9A17      ; $03:$9A17
.addr $9A21      ; $03:$9A21
.addr $8530      ; $03:$8530
.addr $9A29      ; $03:$9A29
.addr $9A4E      ; $03:$9A4E
.addr $9A66      ; $03:$9A66
.addr $8530      ; $03:$8530
.addr $9A6E      ; $03:$9A6E
.addr $8530      ; $03:$8530
.addr $8530      ; $03:$8530
.addr $8530      ; $03:$8530
.addr $9A9F      ; $03:$9A9F
.addr $9AE7      ; $03:$9AE7
.addr $9B09      ; $03:$9B09
.addr $8530      ; $03:$8530
.addr $9B29      ; $03:$9B29
.addr $9B39      ; $03:$9B39
.addr $8530      ; $03:$8530
.addr $8530      ; $03:$8530
.addr $9B48      ; $03:$9B48
.addr $9B43      ; $03:$9B43
.addr $8530      ; $03:$8530
.addr $8530      ; $03:$8530
.addr $9B61      ; $03:$9B61
.addr $8530      ; $03:$8530
.addr $8530      ; $03:$8530
.addr $8530      ; $03:$8530
.addr $8532      ; $03:$8532
.addr $862F      ; $03:$862F
.addr $86C6      ; $03:$86C6
.addr $8530      ; $03:$8530
.addr $872F      ; $03:$872F
.addr $88AB      ; $03:$88AB
.addr $8A51      ; $03:$8A51
.addr $8530      ; $03:$8530
.addr $9944      ; $03:$9944
.addr $9918      ; $03:$9918
.addr $991C      ; $03:$991C
.addr $8530      ; $03:$8530
.addr $8B0C      ; $03:$8B0C
.addr $8B56      ; $03:$8B56
.addr $8BA5      ; $03:$8BA5
.addr $8530      ; $03:$8530
.addr $8BD2      ; $03:$8BD2
.addr $8C7E      ; $03:$8C7E
.addr $8D21      ; $03:$8D21
.addr $8DD4      ; $03:$8DD4
.addr $8E09      ; $03:$8E09
.addr $8E75      ; $03:$8E75
.addr $8ECA      ; $03:$8ECA
.addr $8530      ; $03:$8530
.addr $8F0B      ; $03:$8F0B
.addr $8F58      ; $03:$8F58
.addr $8530      ; $03:$8530
.addr $8FB1      ; $03:$8FB1
.addr $8FC3      ; $03:$8FC3
.addr $8FE7      ; $03:$8FE7
.addr $9002      ; $03:$9002
.addr $8530      ; $03:$8530
.addr $901E      ; $03:$901E
.addr $9046      ; $03:$9046
.addr $8530      ; $03:$8530
.addr $8530      ; $03:$8530
.addr $909D      ; $03:$909D
.addr $9107      ; $03:$9107
.addr $9182      ; $03:$9182
.addr $8530      ; $03:$8530
.addr $91CE      ; $03:$91CE
.addr $9214      ; $03:$9214
.addr $9299      ; $03:$9299
.addr $8530      ; $03:$8530
.addr $930F      ; $03:$930F
.addr $9362      ; $03:$9362
.addr $93B9      ; $03:$93B9
.addr $8530      ; $03:$8530
.addr $9427      ; $03:$9427
.addr $9488      ; $03:$9488
.addr $94CF      ; $03:$94CF
.addr $8530      ; $03:$8530
.addr $9522      ; $03:$9522
.addr $9569      ; $03:$9569
.addr $9596      ; $03:$9596
.addr $8530      ; $03:$8530
.addr $95EA      ; $03:$95EA
.addr $9707      ; $03:$9707
.addr $9818      ; $03:$9818
.addr $8530      ; $03:$8530
.addr $8585      ; $03:$8585
.addr $8653      ; $03:$8653
.addr $86C8      ; $03:$86C8
.addr $8530      ; $03:$8530
; indexed data load target (from $82F9)
.addr $8530      ; $03:$8530
.addr $1B84      ; $03:$1B84
.addr $1B99      ; $03:$1B99
.addr $1BA8      ; $03:$1BA8
.addr $1BB9      ; $03:$1BB9
.addr $9BBF      ; $03:$9BBF
.addr $9BC4      ; $03:$9BC4
.addr $1BCC      ; $03:$1BCC
.addr $1BD6      ; $03:$1BD6
.addr $9BE4      ; $03:$9BE4
.addr $1BED      ; $03:$1BED
.addr $9BF7      ; $03:$9BF7
.addr $9C00      ; $03:$9C00
.addr $9C07      ; $03:$9C07
.addr $9C0E      ; $03:$9C0E; unused "bump" SFX
.addr $9C15      ; $03:$9C15
.addr $9C1A      ; $03:$9C1A
.addr $1C25      ; $03:$1C25
.addr $9C30      ; $03:$9C30
.addr $9C38      ; $03:$9C38
.addr $1B7D      ; $03:$1B7D
.addr $9B8B      ; $03:$9B8B
.addr $1C48      ; $03:$1C48
.addr $1C5B      ; $03:$1C5B
.addr $9C71      ; $03:$9C71
.addr $9C8F      ; $03:$9C8F
.addr $1CA9      ; $03:$1CA9
.addr $1CAE      ; $03:$1CAE
.addr $1CB3      ; $03:$1CB3
.addr $1CB8      ; $03:$1CB8
; indexed data load target (from $80F3)
.addr $9CD2      ; $03:$9CD2
.addr $9CE5      ; $03:$9CE5
.addr $9CF5      ; $03:$9CF5
.addr $9D07      ; $03:$9D07
.addr $9D17      ; $03:$9D17
.addr $9D1E      ; $03:$9D1E
.addr $9D21      ; $03:$9D21
.addr $9D3B      ; $03:$9D3B
.addr $9D55      ; $03:$9D55
.addr $9D61      ; $03:$9D61
.addr $9D69      ; $03:$9D69
.addr $9D87      ; $03:$9D87
.addr $9D8F      ; $03:$9D8F
.addr $9CBD      ; $03:$9CBD
.addr $9CC2      ; $03:$9CC2
.addr $9CC8      ; $03:$9CC8
.addr $9CCF      ; $03:$9CCF
; indirect data load target (via $83F9)
.byte $FF

; indirect data load target (via $83FB, $83FD, $83FF, $8405, $8407, $840F, $8417, $841F, $8427, $842B, $842D, $842F, $8437, $843D, $843F, $8445, $8447, $844B, $844D, $844F, $8457, $845F, $8467, $846F, $847F, $8485, $848F, $8495, $8497, $849F, $84A7, $84AF, $84B7, $84BF, $84C7, $84CF, $84D1)
.byte $94,$00

; indirect data load target (via $8451)
.byte $87,$E4,$FB,$05,$67,$96,$08,$67,$02,$67,$8C,$0B,$FF,$8A,$B0,$05,$B0,$06,$1A,$FF,$8B,$AE,$08,$B0,$06,$1C,$B3,$0B,$B2,$07,$1A,$B2,$08,$B3,$06,$1F,$B7,$08,$BA,$07,$21,$FF,$89,$1F,$1D,$1C,$FF,$82,$65,$96,$08,$65,$02,$65,$8C,$00,$FF,$7F,$67,$96,$08,$67,$02,$67,$8C,$0B,$FF,$7D,$B2,$00,$FF,$73,$18,$1C,$FF,$6E,$65,$F0,$60,$94,$08,$94,$00

; indirect data load target (via $84C9)
.byte $6E,$FB,$05,$6A,$94,$0C,$6A,$04,$FF,$7A,$6F,$98,$15,$26,$FF,$7B,$28,$74,$99,$00,$FF,$7C,$76,$18,$7B,$17,$FF,$7D,$95,$18,$7A,$94,$0C,$78,$84,$00,$FE,$BE,$85,$6F,$98,$16,$26,$28,$74,$99,$00,$76,$18,$7B,$2F,$7A,$94,$0C,$78,$84,$00,$78,$24,$76,$0C,$49,$C0,$0A,$2A,$2D,$76,$98,$00,$73,$30,$67,$94,$12,$67,$04,$67,$98,$16,$1C,$1E,$B6,$00,$6C,$30,$94,$0C,$B7,$0A,$23,$24,$71,$B0,$00,$94,$0C,$B7,$0A,$21,$24,$6F,$98,$16,$23,$21,$6A,$99,$00,$73,$3A,$74,$0C,$28,$71,$0E,$6F,$B0,$2E,$6C,$98,$16,$24,$71,$BA,$00,$73,$0C,$26,$6F,$0E,$6F,$B0,$2E,$6E,$98,$16,$1F,$76,$BA,$00,$73,$8C,$0A,$29,$76,$0E,$78,$BB,$00,$6C,$8C,$0A,$23,$6F,$0C,$74,$B0,$2E,$28,$6F,$C8,$3C,$6A,$94,$0C,$6A,$04,$FE,$AC,$85

; indirect data load target (via $8453)
.byte $E3,$F7,$18,$18,$18,$13,$13,$13,$10,$13,$18,$1A,$18,$13,$18,$1A,$1C,$1D,$21,$1D,$1C,$1A,$18,$13,$13,$13,$18,$18,$18,$18,$10,$18,$13,$49,$94,$00

; indirect data load target (via $84CB)
.byte $68,$94,$0C,$68,$04,$67,$98,$16,$1F,$24,$24,$6F,$B0,$2E,$24,$74,$A4,$00,$73,$0C,$49,$BD,$0A,$27,$2A,$73,$98,$00,$6F,$C8,$30,$5F,$98,$16,$14,$15,$17,$63,$B0,$00,$94,$0C,$AE,$0A,$1A,$1C,$6C,$B0,$00,$94,$0C,$B4,$0A,$1E,$21,$6C,$98,$16,$1F,$1D,$1D,$6B,$BC,$00,$6B,$0C,$20,$20,$6C,$B0,$2E,$67,$98,$16,$1C,$6C,$BC,$00,$69,$0C,$1E,$1E,$68,$B0,$2E,$68,$98,$16,$1D,$70,$BC,$00,$70,$8C,$0A,$26,$28,$74,$BC,$00,$68,$8C,$0A,$1F,$21,$6C,$B0,$00,$23,$67,$C8,$3C,$FE,$53,$86

; indirect data load target (via $8455)
.byte $94,$00

; indirect data load target (via $84CD)
.byte $94,$18,$63,$98,$16,$17,$16,$15,$5B,$B0,$2E,$11,$63,$98,$16,$13,$0C,$18,$18,$10,$13,$18,$5B,$B0,$2E,$10,$60,$98,$16,$10,$18,$15,$12,$15,$1A,$0E,$5E,$B0,$2E,$5E,$98,$16,$17,$10,$14,$17,$10,$15,$17,$18,$15,$12,$15,$1A,$0E,$13,$13,$1A,$1D,$1C,$19,$15,$10,$0E,$10,$11,$0E,$1A,$13,$1D,$13,$18,$13,$18,$49,$FE,$CA,$86,$74,$98,$10,$29,$29,$78,$8C,$08,$76,$E0,$54,$78,$A4,$1C,$78,$98,$10,$2D,$7B,$8C,$08,$7A,$D4,$48,$FD

; indirect data load target (via $8459)
.byte $8C,$FB,$07,$E6,$6A,$18,$73,$A4,$18,$73,$98,$10,$73,$8C,$06,$BE,$08,$28,$BE,$0B,$BE,$0A,$BE,$08,$28,$BE,$0A,$BE,$08,$BC,$80,$BE,$04,$71,$98,$00,$6F,$8C,$06,$6F,$BC,$00,$95,$C8,$3C,$6F,$8C,$80,$26,$BD,$04,$72,$98,$10,$72,$8C,$0C,$4A,$BD,$06,$27,$27,$BD,$80,$71,$98,$08,$BA,$18,$95,$0C,$BA,$06,$24,$B9,$80,$6F,$98,$08,$71,$BC,$00,$95,$C8,$3C,$6A,$8C,$08,$B5,$06,$6C,$98,$00,$95,$0C,$21,$21,$B7,$06,$23,$6F,$D4,$48,$6F,$8C,$06,$24,$B5,$0C,$4A,$B5,$06,$1F,$BA,$00,$BA,$06,$26,$73,$C8,$3C,$73,$8C,$08,$BE,$06,$28,$BF,$80,$BE,$04,$BC,$06,$6C,$A4,$18,$73,$8C,$06,$28,$BF,$80,$BE,$04,$BC,$06,$6C,$BC,$24,$94,$0C,$BA,$06,$BA,$80,$B7,$04,$BA,$06,$24,$24,$24,$71,$A4,$18,$6F,$BC,$00,$95,$48,$94,$18,$FB,$FE,$FE,$16,$87,$78,$8C,$80,$2F,$C6,$08,$C6,$06,$4A,$30,$C6,$80,$C5,$04,$C3,$08,$30,$C5,$0C,$C5,$08,$4A,$30,$C5,$0C,$C5,$08,$2D,$2B,$49,$C3,$08,$4A,$C1,$06,$BF,$08,$BF,$80,$C1,$04,$C3,$08,$C2,$80,$78,$98,$08,$7A,$BC,$30,$FE,$16,$87,$95,$0C,$78,$86,$00,$2F,$7B,$8C,$06,$7B,$18,$30,$6C,$0C,$24,$21,$6F,$18,$BE,$00,$26,$6F,$0C,$76,$06,$2D,$7A,$8C,$06,$7A,$18,$2F,$6E,$0C,$24,$23,$6F,$18,$C5,$00,$2D,$76,$0C,$74,$06,$2B,$78,$98,$10,$78,$8C,$06,$78,$24,$6F,$98,$00,$71,$24,$6F,$98,$0C,$77,$8C,$06,$C2,$00,$C3,$06,$77,$B0,$2E,$2D,$7A,$D4,$48,$73,$8C,$06,$FB,$07,$73,$A4,$1C,$26,$6F,$EC,$60,$6A,$8C,$06,$73,$A4,$1C,$26,$6F,$EC,$60,$6A,$8C,$06,$73,$A4,$1C,$26,$6F,$F8,$00,$95,$B0,$18,$BA,$00,$6F,$60,$4A,$E8,$6F,$10,$20,$24,$20,$1D,$20,$1D,$1A,$1D,$1A,$18,$1A,$E6,$67,$54,$4A,$FE,$32,$87,$F7,$21,$21,$21,$24,$23,$29,$29,$29,$2D,$2B,$FD

; indirect data load target (via $845B)
.byte $E7,$94,$18,$95,$8C,$06,$13,$B2,$00,$A9,$06,$FA,$04,$F5,$4A,$18,$B2,$00,$B2,$06,$F9,$F8,$49,$A6,$0C,$95,$18,$5B,$8C,$06,$4A,$10,$4A,$4A,$18,$AE,$00,$AE,$06,$FA,$03,$F7,$4A,$18,$B1,$00,$B1,$06,$4A,$1A,$B0,$00,$AD,$06,$4A,$17,$AD,$00,$AD,$06,$4A,$17,$A7,$00,$AD,$06,$4A,$17,$AD,$00,$AD,$06,$4A,$15,$AB,$00,$AB,$06,$F9,$F8,$4A,$14,$AA,$00,$AA,$06,$F9,$F8,$4A,$10,$AE,$00,$A6,$06,$4A,$10,$AE,$00,$A9,$06,$4A,$15,$AF,$00,$AB,$06,$F9,$F8,$4A,$11,$AB,$00,$A7,$06,$4A,$11,$AE,$00,$A7,$06,$4A,$11,$B7,$00,$A7,$06,$4A,$11,$A7,$00,$A7,$06,$4A,$15,$AB,$00,$AE,$06,$4A,$15,$AB,$00,$AB,$06,$4A,$10,$B2,$00,$A6,$06,$F9,$F8,$4A,$10,$A6,$00,$A6,$06,$F9,$F8,$FE,$9F,$88,$68,$8C,$80,$B5,$0C,$F8,$4A,$B2,$06,$BA,$00,$B2,$06,$F9,$F7,$4A,$1A,$B9,$00,$B0,$06,$4A,$1A,$BA,$00,$B9,$06,$4A,$18,$BA,$00,$B9,$06,$4A,$21,$B9,$00,$BA,$06,$4A,$17,$BC,$00,$B6,$06,$4A,$20,$BC,$00,$B6,$06,$FE,$9F,$88,$4A,$1D,$1F,$21,$21,$21,$18,$1C,$18,$1C,$24,$23,$21,$23,$24,$26,$26,$26,$1F,$21,$1F,$21,$26,$24,$23,$21,$23,$24,$24,$24,$21,$23,$21,$23,$23,$24,$F8,$23,$1A,$AD,$00,$B0,$06,$1E,$1A,$B4,$00,$B0,$06,$20,$1C,$B0,$00,$B2,$06,$F9,$F8,$6C,$8C,$00,$BA,$06,$21,$B9,$00,$B5,$06,$23,$67,$F8,$60,$F9,$F0,$5C,$0C,$AB,$06,$18,$A9,$00,$AD,$06,$1A,$AB,$00,$A6,$04,$FA,$04,$F9,$AB,$00,$10,$5C,$B0,$10,$49,$59,$98,$00,$11,$14,$18,$1D,$18,$14,$11,$E8,$6B,$10,$1D,$20,$1D,$1A,$1D,$1A,$14,$1A,$11,$14,$11,$E7,$63,$54,$4A,$FE,$AC,$88,$B0,$06,$24,$1A,$24,$1A,$24,$1A,$6A,$98,$10,$65,$8C,$06,$1F,$1A,$1F,$1A,$1F,$24,$1A,$24,$1A,$24,$1A,$24,$1A,$6A,$98,$10,$65,$8C,$06,$1F,$1A,$1F,$1A,$1F,$1A,$FD,$B7,$04,$21,$B7,$0B,$B7,$04,$F9,$F7,$FD,$1F,$1F,$B5,$0B,$B5,$04,$F9,$F8,$FD,$1D,$1D,$B3,$0B,$B3,$04,$F9,$F8,$FD,$1C,$1C,$B2,$0B,$B2,$04,$F9,$F8,$FD

; indirect data load target (via $845D)
.byte $F7,$1F,$0C,$18,$2B,$18,$FA,$04,$F9,$15,$21,$2B,$21,$F9,$FA,$F8,$15,$FA,$08,$FC,$F7,$14,$20,$2C,$20,$FA,$04,$F9,$13,$1F,$29,$1F,$F9,$FA,$13,$1F,$21,$1F,$13,$1F,$29,$1F,$11,$1D,$24,$1D,$FA,$04,$F9,$0C,$18,$28,$18,$F9,$FA,$0D,$19,$2B,$19,$F9,$FA,$0E,$1A,$29,$1A,$FA,$03,$F9,$0E,$1A,$21,$1A,$13,$1D,$29,$1D,$F9,$FA,$0C,$18,$2B,$18,$F9,$FA,$0C,$18,$24,$18,$0C,$18,$1F,$18,$F8,$FE,$04,$8A,$FE,$2C,$8A,$FE,$36,$8A,$FE,$3F,$8A,$FE,$48,$8A,$FE,$04,$8A,$FE,$2C,$8A,$FE,$2C,$8A,$FE,$36,$8A,$FE,$36,$8A,$FE,$3F,$8A,$FE,$3F,$8A,$FE,$48,$8A,$FE,$48,$8A,$F7,$11,$21,$24,$13,$23,$26,$F8,$60,$B0,$24,$60,$98,$08,$15,$15,$F9,$EE,$F7,$0E,$1D,$21,$10,$1F,$23,$F8,$5C,$B0,$20,$5C,$98,$08,$11,$11,$5E,$E0,$10,$AC,$18,$4A,$4A,$4A,$6A,$F8,$6C,$57,$98,$0C,$0C,$FE,$51,$8A

; indirect data load target (via $8469)
.byte $64,$E7,$73,$78,$78,$8C,$80,$2B,$2D,$2F,$30,$C3,$00,$74,$78,$76,$8C,$80,$29,$2B,$2D,$2F,$C1,$00,$73,$78,$74,$8C,$80,$28,$29,$2B,$2D,$BF,$00,$71,$6C,$6C,$8C,$80,$23,$24,$26,$28,$21,$26,$6F,$B0,$00,$6F,$83,$80,$26,$FA,$06,$F9,$6F,$02,$26,$24,$6E,$03,$B7,$00,$6E,$54,$6F,$86,$80,$BC,$00,$FE,$0E,$8B

; indirect data load target (via $846B)
.byte $E6,$6A,$0C,$24,$1F,$24,$20,$23,$1A,$20,$21,$24,$1C,$24,$24,$26,$28,$24,$21,$26,$21,$26,$21,$26,$21,$26,$1F,$26,$1F,$26,$23,$24,$26,$23,$1F,$24,$1F,$23,$1F,$22,$1F,$22,$21,$1D,$21,$24,$21,$23,$24,$21,$1D,$21,$1D,$21,$20,$23,$20,$23,$1C,$18,$1A,$1C,$1E,$24,$1E,$24,$1A,$1D,$1A,$1D,$1F,$1D,$1A,$1D,$F9,$F6,$FE,$56,$8B

; indirect data load target (via $846D)
.byte $63,$98,$17,$24,$23,$17,$15,$21,$1F,$15,$1A,$26,$24,$18,$17,$23,$1F,$13,$18,$18,$19,$19,$1A,$26,$24,$18,$17,$23,$1C,$1C,$15,$21,$1A,$1A,$13,$1F,$1A,$1F,$13,$1F,$1A,$13,$FE,$A5,$8B

; indirect data load target (via $8471)
.byte $7D,$E8,$FE,$2B,$8C,$FE,$25,$8C,$E7,$74,$0C,$BC,$06,$23,$1F,$94,$18,$73,$8C,$00,$27,$28,$2A,$2B,$78,$18,$76,$0C,$49,$29,$49,$27,$49,$71,$18,$6E,$0C,$24,$71,$18,$6E,$0C,$24,$71,$6C,$6E,$0C,$1F,$21,$6E,$18,$6A,$0C,$21,$6E,$18,$6A,$0C,$21,$6E,$18,$BE,$08,$6E,$8C,$00,$71,$98,$08,$B5,$0C,$69,$B0,$00,$67,$A4,$22,$69,$BC,$00,$FE,$D3,$8B,$94,$0C,$21,$B9,$06,$24,$71,$8C,$00,$B9,$04,$BA,$08,$BC,$00,$4A,$B9,$04,$BA,$08,$BC,$00,$4A,$B9,$04,$BC,$08,$76,$98,$00,$2A,$28,$6F,$8C,$04,$BC,$08,$BE,$00,$4A,$BA,$04,$BC,$08,$73,$EC,$00,$6F,$0C,$B7,$04,$B9,$08,$BA,$00,$4A,$B7,$04,$B9,$08,$BA,$00,$4A,$B7,$04,$BA,$08,$75,$98,$00,$26,$6F,$0C,$23,$B5,$04,$B7,$08,$B9,$00,$4A,$B5,$04,$B7,$08,$6E,$BC,$00,$FD

; indirect data load target (via $8473)
.byte $E6,$FE,$CA,$8C,$FE,$BC,$8C,$65,$8C,$00,$17,$29,$1A,$26,$B9,$06,$1F,$1A,$1C,$13,$FA,$04,$FB,$1B,$13,$FA,$04,$FB,$65,$98,$0C,$1A,$1A,$1A,$94,$8C,$04,$AA,$00,$AB,$06,$17,$18,$1A,$1C,$1E,$6A,$B0,$2A,$1F,$1F,$1F,$F7,$1A,$1C,$1A,$18,$1A,$F8,$FE,$7F,$8C,$65,$8C,$04,$17,$BE,$00,$B0,$04,$AE,$00,$B4,$04,$1F,$21,$62,$8C,$04,$1A,$C1,$00,$AD,$04,$17,$1A,$C0,$00,$AD,$04,$17,$1A,$BE,$00,$AD,$04,$17,$1A,$C0,$00,$AD,$04,$18,$1C,$BE,$00,$AE,$04,$18,$1C,$C0,$00,$AE,$04,$18,$1C,$C1,$00,$AE,$04,$18,$1C,$C0,$00,$AE,$04,$1C,$18,$BE,$00,$B2,$04,$1C,$18,$C0,$00,$B2,$04,$1C,$18,$C1,$00,$AE,$04,$21,$1E,$AE,$00,$B4,$04,$1A,$17,$C1,$00,$B0,$04,$1A,$17,$C0,$00,$B0,$04,$FD

; indirect data load target (via $8475)
.byte $FE,$7D,$8D,$FE,$6D,$8D,$5E,$98,$0C,$74,$12,$5E,$86,$05,$5E,$8C,$0B,$13,$49,$17,$63,$98,$06,$FA,$08,$FA,$6E,$8C,$00,$13,$23,$13,$21,$11,$21,$11,$F7,$10,$1C,$1E,$20,$21,$23,$24,$26,$28,$27,$26,$F8,$70,$98,$00,$15,$F7,$1A,$24,$F8,$21,$B0,$00,$1F,$65,$8C,$06,$6C,$98,$17,$6C,$8C,$06,$65,$98,$00,$FE,$21,$8D,$5E,$98,$0C,$73,$12,$5E,$86,$05,$65,$8C,$06,$1A,$BC,$00,$B0,$06,$F7,$A9,$00,$49,$2B,$94,$06,$5E,$06,$13,$13,$2A,$1A,$A9,$00,$49,$28,$94,$06,$5E,$06,$13,$13,$2A,$1A,$AB,$00,$49,$28,$94,$06,$60,$06,$15,$15,$2A,$1C,$AB,$00,$49,$2B,$94,$06,$60,$06,$15,$15,$2A,$1C,$AB,$00,$49,$28,$94,$06,$60,$06,$15,$15,$2A,$1C,$AB,$00,$49,$2B,$94,$06,$60,$06,$1A,$1A,$2A,$1A,$A9,$00,$49,$2B,$94,$06,$5E,$06,$13,$13,$2A,$1A,$F8,$FD

; indirect data load target (via $8477)
.byte $EC,$94,$18,$02,$FA,$20,$FA,$FE,$FB,$8D,$FE,$FB,$8D,$4D,$30,$02,$02,$02,$4D,$08,$94,$10,$4D,$0C,$49,$02,$94,$24,$94,$0C,$02,$05,$94,$18,$4D,$24,$FE,$D5,$8D,$94,$0C,$02,$FA,$06,$FA,$4D,$06,$02,$4D,$0C,$49,$02,$FD

; indirect data load target (via $8479)
.byte $6E,$E6,$69,$B0,$00,$6B,$18,$1E,$68,$0C,$1B,$1A,$1B,$68,$18,$1E,$68,$0C,$1B,$1A,$18,$1D,$1B,$1A,$18,$1A,$1B,$1D,$1B,$65,$18,$13,$5F,$06,$17,$1A,$1D,$20,$23,$26,$29,$2C,$29,$26,$23,$20,$1D,$1A,$17,$16,$19,$1C,$1F,$22,$25,$28,$2B,$2E,$2B,$28,$25,$22,$1F,$1C,$1F,$F9,$BF,$E7,$75,$86,$06,$75,$12,$75,$18,$2A,$2A,$FB,$FE,$F9,$F3,$FB,$00,$94,$8C,$00,$5D,$18,$1E,$75,$0C,$78,$03,$30,$2D,$30,$78,$8C,$06,$FB,$FF,$F9,$EC,$FB,$00,$FE,$0A,$8E

; indirect data load target (via $847B)
.byte $E7,$FE,$A1,$8E,$FE,$A1,$8E,$E6,$F7,$25,$25,$25,$25,$25,$F9,$F9,$F8,$57,$86,$00,$0F,$12,$15,$18,$1B,$1E,$21,$24,$27,$2A,$2D,$7B,$03,$33,$30,$33,$7B,$8C,$06,$F9,$E8,$FE,$75,$8E,$72,$86,$03,$24,$21,$24,$FA,$04,$F7,$26,$23,$20,$23,$FA,$04,$F9,$27,$22,$1E,$22,$FA,$04,$F9,$26,$23,$1F,$23,$FA,$04,$F9,$5F,$98,$00,$20,$2C,$20,$16,$22,$2E,$22,$FD

; indirect data load target (via $847D)
.byte $FE,$EB,$8E,$FE,$EB,$8E,$76,$86,$05,$2B,$66,$0C,$2B,$1B,$2B,$1B,$2B,$1B,$F9,$F2,$63,$98,$00,$24,$7B,$0C,$94,$24,$F9,$F6,$FE,$CA,$8E,$94,$18,$65,$B0,$10,$FA,$07,$FA,$6A,$18,$65,$8C,$00,$71,$18,$7D,$0C,$49,$32,$49,$26,$6A,$0C,$73,$18,$7F,$0C,$49,$34,$49,$28,$FD

; indirect data load target (via $8481)
.byte $64,$EB,$94,$A4,$00,$72,$98,$0C,$94,$3C,$72,$18,$94,$30,$E7,$5E,$E0,$00,$4A,$F9,$EC,$6D,$12,$6B,$92,$06,$70,$8C,$00,$6D,$06,$23,$22,$23,$6D,$0C,$21,$6B,$12,$69,$92,$06,$6E,$8C,$00,$6B,$24,$6A,$0C,$69,$06,$62,$8C,$06,$69,$86,$00,$62,$0C,$28,$71,$8C,$06,$1F,$1A,$13,$12,$1E,$23,$1E,$25,$1E,$4A,$1E,$FE,$0C,$8F

; indirect data load target (via $8483)
.byte $E7,$52,$8C,$06,$A6,$00,$A7,$06,$B2,$00,$10,$A7,$06,$52,$06,$10,$5C,$0C,$52,$06,$10,$5C,$0C,$B2,$00,$9D,$06,$A6,$00,$A7,$06,$52,$06,$10,$5C,$0C,$52,$E0,$00,$4A,$F9,$D7,$F7,$1E,$1C,$21,$1E,$1F,$1E,$1F,$1E,$1D,$1C,$1A,$1F,$1C,$1B,$1A,$13,$1A,$13,$24,$22,$1B,$16,$0F,$0E,$1A,$1F,$1A,$21,$1A,$4A,$1A,$F8,$FE,$59,$8F,$05,$05,$05,$05,$05,$94,$0C,$05,$05,$49,$FD

; indirect data load target (via $8487)
.byte $EA,$50,$06,$05,$05,$FE,$A6,$8F,$50,$06,$05,$49,$FE,$A6,$8F,$FE,$B2,$8F

; indirect data load target (via $8489)
.byte $55,$E1,$65,$C9,$80,$4A,$64,$AE,$00,$61,$60,$62,$9A,$80,$64,$C6,$00,$6A,$B2,$80,$68,$30,$67,$DE,$00,$65,$B2,$80,$62,$30,$64,$DE,$00,$FE,$C5,$8F

; indirect data load target (via $848B)
.byte $E1,$94,$01,$6A,$30,$1D,$67,$60,$68,$18,$20,$1A,$20,$6C,$48,$6A,$18,$6C,$78,$6A,$48,$67,$60,$4A,$FE,$EA,$8F

; indirect data load target (via $848D)
.byte $94,$03,$78,$78,$7D,$18,$34,$39,$7D,$30,$34,$35,$34,$7D,$48,$4A,$7B,$18,$2E,$78,$78,$7F,$18,$84,$30,$FE,$04,$90

; indirect data load target (via $8491)
.byte $5A,$E6,$71,$0C,$28,$29,$2B,$78,$18,$26,$2E,$78,$0C,$2B,$29,$2B,$73,$18,$74,$0C,$2B,$2D,$2E,$7B,$18,$79,$0C,$2D,$76,$24,$74,$06,$76,$86,$00,$73,$30,$FE,$20,$90

; indirect data load target (via $8493)
.byte $E6,$65,$0C,$19,$1A,$1C,$68,$30,$6A,$18,$6C,$0C,$22,$71,$18,$6F,$0C,$22,$21,$22,$24,$26,$73,$18,$29,$22,$71,$30,$70,$18,$FE,$47,$90,$6C,$06,$22,$21,$22,$6F,$A4,$22,$6F,$0C,$BC,$06,$24,$6E,$98,$00,$76,$48,$6A,$06,$21,$1F,$21,$6D,$30,$6D,$08,$24,$22,$FD,$71,$06,$1D,$21,$22,$71,$24,$78,$0C,$C1,$04,$BF,$08,$73,$06,$74,$0C,$BE,$00,$6F,$06,$6C,$3C,$FD

; indirect data load target (via $8499)
.byte $69,$E6,$FE,$67,$90,$6C,$18,$74,$48,$FE,$67,$90,$6C,$06,$6A,$8C,$06,$68,$AA,$1E,$74,$92,$06,$BD,$00,$FE,$85,$90,$94,$0C,$BC,$06,$68,$B0,$00,$6A,$0C,$1D,$6C,$12,$B8,$0C,$6F,$BC,$00,$FE,$85,$90,$71,$98,$0C,$65,$B0,$00,$68,$18,$68,$60,$FE,$9F,$90,$63,$8C,$04,$B3,$00,$AB,$04,$B3,$00,$F9,$F5,$FD,$B0,$04,$B5,$00,$AD,$04,$B5,$00,$F9,$F6,$AF,$04,$B5,$00,$AC,$04,$B5,$00,$F9,$F6,$FD,$94,$0C,$68,$98,$0C,$21,$1D,$21,$1C,$1F,$1C,$FD

; indirect data load target (via $849B)
.byte $E2,$FE,$DA,$90,$FE,$E6,$90,$FE,$DA,$90,$FE,$DA,$90,$FE,$E6,$90,$AE,$04,$AE,$00,$AB,$04,$AE,$00,$49,$6C,$92,$06,$B7,$00,$FE,$FB,$90,$1F,$22,$1A,$1A,$65,$8C,$00,$67,$06,$18,$1C,$1D,$1A,$1D,$6A,$18,$6A,$0C,$B2,$06,$18,$FE,$FB,$90,$6A,$0C,$F7,$22,$16,$16,$F8,$94,$0C,$65,$06,$63,$8C,$06,$61,$86,$00,$63,$3C,$FE,$08,$91,$1D,$21,$11,$21,$F9,$FA,$1D,$23,$11,$23,$F9,$FA,$1D,$22,$11,$22,$F9,$FA,$1D,$21,$11,$21,$FD,$B8,$06,$BC,$00,$AC,$06,$BF,$00,$F9,$F6,$B7,$06,$BA,$00,$AB,$06,$BE,$00,$F9,$F6,$FD

; indirect data load target (via $849D)
.byte $F7,$FE,$56,$91,$FE,$68,$91,$FE,$56,$91,$F8,$A7,$06,$29,$6F,$86,$00,$29,$68,$0C,$FE,$6D,$91,$B5,$06,$BF,$00,$A9,$06,$B8,$00,$AE,$06,$B8,$00,$AE,$06,$B8,$00,$5C,$12,$13,$60,$18,$73,$0C,$BA,$06,$21,$FE,$6D,$91,$6A,$0C,$49,$68,$18,$63,$30,$5C,$0C,$6D,$06,$21,$49,$1F,$6C,$18,$5C,$8C,$06,$11,$18,$FE,$82,$91

; indirect data load target (via $84A1)
.byte $78,$E6,$71,$30,$2D,$76,$98,$80,$29,$28,$BA,$00,$71,$30,$7B,$18,$76,$0C,$2D,$74,$18,$76,$0C,$29,$73,$18,$24,$71,$60,$4A,$94,$18,$28,$26,$2D,$73,$60,$94,$18,$28,$26,$2D,$76,$30,$73,$18,$24,$6D,$10,$24,$26,$6C,$18,$1F,$6F,$30,$6C,$18,$1F,$6C,$3C,$6C,$0C,$26,$28,$78,$60,$FE,$D0,$91

; indirect data load target (via $84A3)
.byte $E7,$68,$8C,$04,$21,$1D,$21,$1C,$21,$1C,$21,$1A,$21,$1A,$21,$18,$1F,$18,$1F,$F9,$EC,$69,$E0,$80,$B3,$00,$68,$86,$00,$21,$71,$8C,$04,$1D,$21,$1A,$1D,$21,$26,$67,$86,$00,$21,$6F,$8C,$04,$1C,$21,$24,$1C,$21,$24,$65,$86,$00,$1D,$6C,$8C,$04,$1A,$1D,$16,$1A,$1D,$21,$67,$86,$00,$1F,$6F,$8C,$04,$1C,$1F,$15,$18,$1C,$1F,$61,$86,$00,$1A,$68,$8C,$04,$16,$1A,$13,$16,$1A,$16,$5E,$86,$00,$16,$66,$8C,$04,$13,$16,$19,$1B,$16,$19,$64,$86,$00,$1C,$70,$8C,$04,$19,$1C,$25,$1A,$1C,$21,$67,$86,$00,$1F,$70,$8C,$04,$1C,$1F,$25,$1C,$1F,$25,$FE,$15,$92

; indirect data load target (via $84A5)
.byte $71,$8C,$04,$29,$B0,$00,$BF,$04,$24,$28,$AE,$00,$BE,$04,$22,$26,$AC,$00,$BC,$04,$21,$24,$AB,$00,$BA,$04,$F9,$E4,$1A,$21,$26,$21,$FA,$04,$F9,$B0,$00,$BC,$04,$94,$24,$65,$0C,$49,$1A,$AE,$00,$BA,$04,$94,$24,$63,$0C,$49,$18,$AC,$00,$B8,$04,$94,$24,$61,$0C,$49,$16,$AB,$00,$B7,$04,$94,$24,$60,$0C,$49,$15,$A9,$00,$B5,$04,$94,$24,$5E,$0C,$49,$13,$B1,$00,$B1,$04,$94,$24,$66,$0C,$49,$1B,$AB,$00,$B7,$04,$94,$24,$6C,$0C,$49,$1C,$AB,$00,$B7,$04,$94,$24,$6C,$0C,$49,$15,$FE,$99,$92

; indirect data load target (via $84A9)
.byte $B9,$E2,$67,$18,$1B,$1C,$1D,$1C,$1D,$1F,$1E,$1F,$21,$23,$24,$65,$48,$4A,$4A,$4A,$68,$18,$1C,$1D,$1F,$1E,$1F,$21,$20,$21,$23,$24,$26,$73,$48,$4A,$4A,$4A,$78,$98,$0C,$6C,$8C,$00,$23,$24,$21,$74,$48,$77,$98,$0C,$6B,$8C,$00,$21,$23,$1C,$6F,$48,$6C,$0C,$23,$BA,$80,$21,$23,$BA,$00,$26,$24,$B9,$80,$24,$23,$B7,$00,$73,$48,$1A,$FE,$11,$93

; indirect data load target (via $84AB)
.byte $E2,$94,$18,$6A,$0C,$1E,$6A,$18,$49,$6C,$0C,$1F,$6C,$18,$49,$6E,$0C,$22,$6E,$18,$49,$21,$21,$49,$6C,$0C,$1F,$6C,$18,$FA,$04,$F7,$49,$20,$21,$49,$22,$23,$49,$23,$24,$49,$21,$23,$49,$24,$24,$FA,$03,$FA,$49,$22,$22,$E6,$F7,$24,$1D,$1F,$21,$1D,$21,$23,$F8,$B2,$00,$1A,$67,$48,$1C,$1B,$6B,$18,$6B,$8C,$00,$21,$23,$24,$23,$21,$1F,$1D,$1C,$1A,$FE,$62,$93

; indirect data load target (via $84AD)
.byte $63,$98,$17,$30,$30,$1A,$32,$32,$1C,$34,$34,$1D,$29,$29,$1A,$80,$0C,$34,$80,$18,$18,$80,$0C,$34,$80,$18,$17,$80,$0C,$34,$80,$18,$15,$80,$0C,$34,$80,$18,$1A,$32,$32,$13,$32,$32,$1A,$35,$35,$13,$29,$29,$18,$2B,$2B,$17,$2B,$2B,$15,$2B,$2B,$13,$28,$28,$A7,$0C,$1D,$1D,$62,$0C,$1D,$21,$26,$21,$23,$67,$98,$00,$23,$1C,$15,$21,$1F,$69,$48,$1D,$67,$0C,$94,$3C,$5E,$0C,$29,$28,$26,$24,$23,$FE,$B9,$93,$6D,$8C,$06,$6C,$86,$00,$22,$69,$48,$95,$3C,$FD

; indirect data load target (via $84B1)
.byte $82,$E6,$7B,$08,$2E,$2A,$28,$24,$22,$69,$30,$95,$54,$6A,$0C,$FE,$1B,$94,$95,$18,$6A,$0C,$FE,$1B,$94,$74,$8C,$06,$28,$24,$77,$86,$06,$2C,$2C,$2C,$77,$0C,$DF,$00,$DF,$06,$77,$06,$2C,$2C,$2C,$77,$0C,$F9,$EB,$DF,$06,$BB,$00,$BC,$06,$4A,$BB,$00,$BC,$06,$95,$06,$25,$71,$0C,$FB,$F9,$F9,$EC,$FB,$00,$7E,$86,$06,$1B,$4A,$33,$1B,$4A,$7E,$BC,$36,$F9,$F3,$95,$18,$BD,$0C,$4A,$22,$F9,$F8,$FE,$36,$94

; indirect data load target (via $84B3)
.byte $E7,$73,$08,$26,$22,$20,$1C,$1A,$61,$30,$95,$60,$94,$0C,$65,$98,$0C,$FA,$08,$FA,$1C,$FA,$07,$FC,$67,$0C,$F7,$27,$27,$27,$27,$27,$18,$11,$27,$27,$27,$27,$27,$F9,$F2,$16,$1F,$20,$16,$1F,$20,$16,$1F,$20,$F9,$F5,$2E,$16,$4A,$2E,$16,$4A,$2E,$F9,$F7,$4A,$22,$4A,$1C,$F9,$FA,$F8,$FE,$94,$94

; indirect data load target (via $84B5)
.byte $63,$08,$1C,$1E,$22,$24,$1C,$94,$98,$0C,$18,$AE,$04,$18,$18,$18,$6A,$0C,$22,$FA,$08,$FA,$18,$22,$FA,$08,$FB,$F7,$2D,$2D,$2D,$2D,$2D,$18,$11,$2D,$2D,$2D,$2D,$2D,$F9,$F2,$16,$1F,$20,$16,$1F,$20,$16,$1F,$20,$F9,$F5,$F8,$7F,$86,$05,$18,$18,$34,$18,$18,$7F,$0C,$DF,$03,$22,$69,$86,$00,$1F,$62,$0C,$F9,$EB,$AE,$06,$FA,$10,$FB,$FE,$DF,$94

; indirect data load target (via $84B9)
.byte $59,$E2,$65,$18,$1D,$1A,$20,$65,$0C,$68,$98,$08,$68,$8C,$00,$65,$18,$20,$6A,$0C,$20,$22,$23,$25,$23,$22,$20,$6A,$60,$F9,$E3,$94,$8C,$04,$49,$74,$98,$0C,$94,$8C,$04,$49,$79,$83,$06,$2E,$2E,$2E,$79,$0C,$F9,$EB,$6C,$B0,$00,$6B,$14,$6B,$04,$6A,$18,$69,$30,$68,$18,$67,$0C,$1B,$FE,$24,$95

; indirect data load target (via $84BB)
.byte $E2,$F7,$15,$18,$15,$1B,$15,$18,$18,$15,$1B,$1A,$1B,$1D,$1E,$20,$1E,$1D,$1B,$1A,$F9,$EC,$0E,$0E,$24,$07,$13,$29,$29,$29,$29,$29,$F9,$F4,$1C,$1B,$1B,$1A,$19,$18,$17,$16,$FE,$6B,$95

; indirect data load target (via $84BD)
.byte $65,$8C,$00,$1D,$1A,$1D,$1A,$1D,$18,$1D,$1A,$1D,$1A,$1D,$1A,$1D,$18,$1D,$23,$24,$26,$27,$29,$27,$26,$24,$B9,$06,$20,$1D,$1A,$64,$06,$17,$61,$0C,$17,$19,$F9,$D8,$65,$8C,$0B,$1A,$2A,$1A,$13,$1F,$6E,$83,$02,$23,$23,$23,$6E,$0C,$F9,$EE,$BC,$06,$21,$21,$21,$25,$6B,$08,$70,$04,$6F,$0C,$1F,$23,$1E,$1E,$1E,$22,$1D,$21,$6B,$06,$1B,$FE,$96,$95

; indirect data load target (via $84C1)
.byte $60,$E2,$94,$60,$94,$48,$6A,$18,$FE,$A0,$96,$6F,$48,$94,$0C,$73,$06,$29,$76,$8C,$06,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$C1,$00,$BF,$06,$28,$74,$B0,$24,$76,$06,$2D,$76,$0C,$BF,$06,$28,$74,$BC,$00,$74,$0C,$28,$27,$73,$B0,$24,$6F,$06,$26,$73,$8C,$06,$28,$28,$28,$28,$28,$28,$28,$C5,$00,$C3,$06,$2C,$78,$BC,$00,$94,$18,$2D,$28,$2D,$78,$0C,$C1,$06,$2A,$76,$A4,$00,$94,$0C,$1F,$FE,$A0,$96,$6F,$48,$61,$03,$18,$65,$02,$1B,$1D,$1F,$20,$22,$24,$26,$27,$FB,$03,$E6,$FE,$A0,$96,$FB,$00,$72,$48,$94,$0C,$24,$76,$24,$77,$0C,$77,$24,$6F,$0C,$76,$24,$77,$0C,$77,$30,$94,$18,$2C,$6F,$30,$27,$29,$72,$60,$6F,$03,$20,$FA,$10,$FA,$27,$24,$FA,$10,$FB,$2B,$26,$FA,$10,$FB,$FF,$5A,$FE,$9A,$96,$FF,$50,$FE,$9A,$96,$76,$98,$0C,$94,$00,$2B,$26,$FA,$04,$FB,$FD,$71,$24,$73,$0C,$73,$24,$6A,$0C,$71,$24,$73,$0C,$73,$30,$94,$0C,$28,$28,$29,$29,$28,$26,$24,$6C,$48,$94,$0C,$21,$73,$24,$74,$0C,$74,$24,$6C,$0C,$73,$24,$74,$0C,$74,$30,$94,$0C,$29,$29,$2D,$2B,$29,$28,$26,$73,$48,$6F,$18,$78,$3C,$6F,$8C,$0B,$24,$26,$73,$98,$17,$28,$26,$24,$76,$BC,$00,$73,$0C,$2B,$2F,$78,$48,$94,$0C,$21,$73,$24,$74,$0C,$74,$24,$6C,$0C,$73,$24,$74,$0C,$74,$BC,$30,$74,$8C,$00,$6C,$18,$24,$26,$FD

; indirect data load target (via $84C3)
.byte $E7,$FE,$15,$98,$1C,$1F,$FA,$04,$FB,$67,$98,$0C,$1C,$1C,$1C,$21,$21,$21,$21,$20,$20,$20,$20,$1F,$1F,$1F,$1F,$1E,$1E,$20,$20,$18,$1C,$18,$1C,$1E,$1E,$1E,$1E,$17,$1A,$1D,$1D,$E4,$FE,$9E,$97,$1C,$1F,$1C,$1F,$67,$18,$59,$03,$0F,$5C,$02,$13,$14,$16,$18,$1A,$1B,$1D,$1F,$E2,$FE,$9E,$97,$5E,$0C,$16,$1B,$1F,$22,$1F,$1B,$1F,$FE,$93,$97,$FE,$93,$97,$94,$18,$24,$6B,$06,$1B,$FA,$04,$FA,$24,$20,$FA,$04,$FB,$23,$20,$1A,$20,$F9,$FA,$94,$0C,$5E,$06,$13,$14,$14,$16,$16,$18,$18,$1A,$1A,$1B,$1B,$1F,$1F,$F7,$20,$1B,$FA,$10,$FB,$24,$20,$FA,$10,$FB,$22,$1F,$FA,$18,$FB,$22,$49,$6B,$06,$24,$FA,$06,$FA,$27,$24,$20,$1B,$FD,$5B,$06,$13,$18,$1C,$18,$13,$18,$1C,$FA,$04,$F4,$11,$15,$18,$1D,$18,$15,$18,$1D,$FA,$08,$F5,$17,$1A,$1D,$1F,$1D,$1A,$1D,$23,$F9,$F6,$24,$1C,$1F,$24,$23,$1C,$1F,$23,$22,$1C,$26,$22,$1F,$1C,$1A,$22,$15,$18,$1D,$21,$1D,$18,$1D,$21,$F9,$F6,$14,$18,$1D,$20,$1D,$18,$1D,$20,$F9,$F6,$17,$1A,$1F,$23,$1F,$1A,$1F,$23,$F9,$F6,$70,$98,$00,$67,$86,$06,$21,$25,$28,$2B,$28,$25,$21,$1F,$1C,$19,$15,$11,$15,$18,$1D,$18,$15,$18,$1D,$FA,$04,$F5,$95,$0C,$B7,$00,$68,$18,$6C,$0C,$1D,$23,$1D,$FD,$FA,$09,$86

; indirect data load target (via $84C5)
.byte $63,$48,$94,$0C,$13,$F9,$F9,$FE,$B2,$98,$63,$A4,$18,$63,$8C,$0B,$18,$18,$49,$13,$18,$1F,$30,$1F,$18,$1F,$2E,$1F,$1D,$24,$30,$24,$FA,$04,$F9,$18,$1F,$30,$1F,$F9,$FA,$17,$23,$2D,$23,$1C,$23,$32,$23,$15,$1C,$30,$1C,$F9,$FA,$1A,$21,$30,$21,$F9,$FA,$13,$1A,$2F,$1A,$F9,$FA,$FE,$B2,$98,$63,$A4,$18,$63,$8C,$0B,$63,$98,$17,$16,$FE,$B2,$98,$66,$A4,$18,$66,$8C,$0B,$1B,$1B,$49,$1B,$68,$A4,$18,$68,$8C,$0B,$1D,$1D,$49,$1D,$F9,$F4,$61,$A4,$18,$61,$8C,$0B,$22,$22,$49,$22,$F9,$F4,$49,$66,$86,$05,$1B,$1D,$1D,$1F,$1F,$20,$20,$22,$22,$24,$24,$22,$22,$6B,$8C,$0B,$1B,$FA,$04,$F9,$14,$1B,$FA,$04,$FB,$1B,$16,$FA,$06,$FB,$1B,$94,$00,$63,$A4,$18,$63,$8C,$0B,$18,$18,$49,$1F,$F9,$F4,$65,$A4,$18,$65,$8C,$0B,$1A,$1A,$49,$21,$FA,$04,$F3,$5E,$A4,$18,$5E,$8C,$0B,$13,$13,$49,$1F,$63,$A4,$18,$63,$0C,$18,$79,$06,$2B,$28,$24,$22,$1F,$68,$A4,$18,$68,$8C,$0B,$68,$B0,$18,$F9,$F5,$67,$A4,$18,$67,$8C,$0B,$1C,$1C,$49,$1C,$60,$06,$1C,$21,$25,$94,$18,$7F,$06,$31,$2D,$2B,$28,$25,$21,$19,$65,$A4,$18,$65,$8C,$0B,$1A,$1A,$49,$21,$F9,$F4,$6A,$B0,$00,$13,$FD

; indirect data load target (via $8463)
.byte $ED,$94,$81,$02

; indirect data load target (via $8465)
.byte $7D,$20,$39,$82,$60,$80,$10,$34,$32,$4A,$30,$2E,$30,$2D,$7F,$20,$7D,$40,$4A,$4A,$84,$20,$3C,$86,$60,$82,$10,$35,$34,$4A,$35,$37,$84,$40,$4A,$4A,$4A,$FE,$1C,$99

; indirect data load target (via $8461)
.byte $96,$E9,$65,$90,$04,$21,$1D,$21,$1A,$23,$1F,$23,$1A,$24,$21,$24,$1A,$22,$1D,$22,$1C,$24,$21,$24,$1A,$21,$1E,$21,$1A,$21,$1E,$21,$1F,$22,$21,$24,$1A,$24,$21,$24,$1A,$23,$1F,$23,$1A,$23,$1F,$23,$1A,$22,$20,$22,$19,$21,$1C,$21,$1A,$21,$1C,$21,$19,$21,$1C,$21,$17,$21,$19,$21,$FE,$46,$99

; indirect data load target (via $8401)
.byte $78,$E6,$7D,$0C,$31,$30,$2F,$C3,$04,$26,$7D,$A4,$18,$94,$00

; indirect data load target (via $8403)
.byte $E6,$F7,$2A,$29,$28,$26,$24,$1E,$2A,$49

; indirect data load target (via $8409)
.byte $3C,$ED,$67,$0C,$1F,$24,$73,$09,$E1,$68,$9A,$80,$65,$96,$00,$67,$CB,$3F,$94,$00

; indirect data load target (via $840B)
.byte $E1,$94,$2E,$6C,$30,$6A,$CA,$3E,$94,$00

; indirect data load target (via $840D)
.byte $67,$0C,$1F,$24,$28,$7B,$6C,$94,$00

; indirect data load target (via $8415)
.byte $76,$0C,$2D,$37,$7F,$1E,$94,$4E,$76,$12,$37,$7F,$1E,$94,$00

; indirect data load target (via $8411)
.byte $64,$E6,$94,$02,$6A,$98,$03,$76,$2E,$ED,$6A,$8C,$00,$21,$2B,$73,$A6,$1E,$E6,$6A,$A4,$03,$73,$22,$ED,$6A,$92,$00,$2B,$73,$A4,$1E,$94,$00

; indirect data load target (via $8413)
.byte $E6,$94,$0E,$6C,$98,$03,$73,$6C,$95,$12,$76,$12,$95,$6C,$94,$00

; indirect data load target (via $8419)
.byte $64,$E6,$94,$02,$6A,$98,$03,$76,$30,$94,$00

; indirect data load target (via $841B)
.byte $E6,$94,$0E,$6C,$98,$03,$73,$24,$94,$00

; indirect data load target (via $841D)
.byte $76,$0C,$2D,$37,$7F,$1E,$94,$00

; indirect data load target (via $8421)
.byte $78,$E7,$FB,$05,$63,$98,$06,$1C,$21,$26,$DF,$00,$FF,$50,$E6,$6C,$18,$28,$6E,$3C,$6C,$0C,$28,$23,$21,$28,$6E,$18,$1F,$1C,$F9,$EF,$6C,$E0,$54,$94,$00

; indirect data load target (via $8423)
.byte $E7,$F7,$13,$19,$1E,$1D,$49,$F8,$E6,$94,$48,$6A,$18,$69,$30,$1D,$67,$18,$1A,$F9,$F4,$F7,$19,$49

; indirect data load target (via $8425)
.byte $67,$98,$06,$21,$24,$1F,$94,$00

; indirect data load target (via $8429)
.byte $8C,$E4,$FB,$05,$6A,$8C,$06,$1F,$6F,$0C,$6F,$06,$24,$73,$0C,$28,$76,$98,$00,$73,$06,$2B,$24,$28,$6A,$8C,$06,$24,$28,$24,$6A,$98,$00,$73,$06,$2B,$24,$28,$6A,$8C,$06,$24,$2B,$1F,$6F,$B0,$24,$94,$00

; indirect data load target (via $8431)
.byte $64,$E7,$FB,$05,$94,$8C,$00,$FF,$5A,$24,$FF,$5F,$24,$23,$FF,$64,$23,$21,$FF,$69,$21,$1F,$FF,$6E,$49,$21,$FF,$73,$21,$1F,$FF,$78,$1F,$1D,$FF,$7D,$1D,$1C,$FF,$78,$65,$86,$80,$15,$17,$18,$1A,$1C,$1D,$B5,$00,$6C,$0C,$FF,$73,$1D,$FF,$6E,$21,$FF,$69,$24,$FF,$64,$73,$30,$26,$95,$98,$0C,$94,$00

; indirect data load target (via $8433)
.byte $E7,$F7,$0C,$1C,$1C,$1F,$1F,$1D,$1D,$1C,$21,$1C,$1C,$1C,$1C,$19,$19,$19,$15,$11,$13,$15,$17,$18,$1A,$1C,$1D,$21,$18,$21,$20,$23,$4A,$49

; indirect data load target (via $8435)
.byte $57,$0C,$B5,$0B,$1F,$24,$24,$24,$24,$24,$21,$25,$25,$25,$25,$21,$21,$1F,$65,$B0,$2F,$1A,$67,$8C,$00,$23,$14,$10,$5E,$3C,$94,$00

; indirect data load target (via $8439)
.byte $50,$E4,$74,$04,$29,$29,$74,$88,$04,$27,$2B,$74,$A4,$18,$94,$00

; indirect data load target (via $843B)
.byte $E3,$F7,$24,$23,$22,$21,$1F,$22,$21,$49

; indirect data load target (via $8443)
.byte $ED,$94,$81,$02,$FF

; indirect data load target (via $8441)
.byte $78,$E6,$57,$07,$5E,$06,$18,$65,$01,$1C,$1D,$1F,$21,$22,$24,$26,$28,$29,$2B,$2D,$2E,$7B,$1E,$94,$00

; indirect data load target (via $8449)
.byte $96,$E4,$FE,$73,$9B,$FE,$73,$9B,$5B,$14,$5C,$02,$12,$55,$98,$0C,$94,$00,$57,$06,$17,$0B,$16,$0C,$17,$0B,$16,$FD

; indirect data load target
.byte $E6,$58,$0C,$59,$30,$94,$00

; indirect data load target
.byte $E6,$52,$04,$08,$09,$94,$00

; indirect data load target (via $84FB)
.byte $E5,$6F,$04,$27,$2A,$2D,$32,$2F,$2C,$29,$F9,$F5,$94,$00

; indirect data load target
.byte $EA,$59,$02,$0D,$94,$0C,$58,$02,$0C,$94,$0C,$F9,$F4,$94,$00

; indirect data load target
.byte $EA,$59,$02,$0D,$49,$0D,$0C,$49,$F9,$F7,$0D,$0C,$49,$0C,$0B,$94,$00

.byte $EA,$5A,$06,$0D,$94,$00

; indirect data load target (via $84DB)
.byte $E7,$90,$04,$94,$00

; indirect data load target (via $84DD)
.byte $E7,$87,$04,$42,$3C,$42,$94,$00

; indirect data load target
.byte $EA,$55,$02,$0B,$0C,$0D,$0E,$0F,$94,$00

; indirect data load target
.byte $EA,$53,$02,$09,$0A,$0B,$F9,$F9,$0A,$09,$08,$07,$94,$00

; indirect data load target (via $84E3)
.byte $E7,$82,$02,$38,$36,$F9,$FA,$94,$00

; indirect data load target
.byte $EA,$5A,$02,$0E,$0D,$0C,$0B,$0A,$94,$00

; indirect data load target (via $84E7)
.byte $E4,$71,$02,$23,$27,$F9,$FA,$94,$00

; indirect data load target (via $84E9)
.byte $E5,$78,$04,$2B,$27,$94,$00

; indirect data load target (via $84EB)
.byte $E5,$7A,$04,$2D,$29,$94,$00

; unused "bump" SFX
; indirect data load target (via $84ED)
.byte $E2,$5A,$03,$0E,$0C,$94,$00

; indirect data load target (via $84EF)
.byte $E2,$78,$02,$94,$00

; indirect data load target (via $84F1)
.byte $E5,$6F,$06,$27,$25,$28,$26,$29,$2A,$94,$00

; indirect data load target
.byte $EA,$5A,$03,$59,$02,$58,$01,$57,$02,$94,$00

; indirect data load target (via $84F5)
.byte $E7,$5D,$03,$18,$13,$19,$94,$00

; indirect data load target (via $84F7)
.byte $E4,$7B,$02,$25,$32,$27,$7F,$06,$71,$02,$33,$28,$80,$06,$94,$00

; indirect data load target
.byte $EC,$4C,$03,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0C,$E1,$58,$48,$94,$00

; indirect data load target
.byte $E1,$52,$86,$80,$06,$05,$04,$4E,$08,$04,$05,$06,$07,$08,$09,$0A,$0B,$0C,$58,$24,$94,$00

; indirect data load target (via $8501)
.byte $E7,$87,$82,$80,$3B,$3A,$39,$38,$37,$36,$35,$34,$33,$32,$31,$30,$2F,$2E,$2D,$2C,$2B,$2A,$29,$28,$27,$26,$25,$24,$94,$00

; indirect data load target (via $8503)
.byte $E5,$6F,$03,$23,$22,$21,$27,$26,$25,$24,$25,$24,$23,$22,$28,$27,$26,$25,$71,$04,$27,$28,$29,$2A,$94,$00

; indirect data load target
.byte $EE,$58,$0C,$94,$00

; indirect data load target
.byte $EF,$58,$0C,$94,$00

; indirect data load target
.byte $F0,$58,$08,$94,$00

; indirect data load target
.byte $F1,$58,$04,$94,$00

; indirect data load target (via $8527)
.byte $74,$71,$74,$71,$03

; indirect data load target (via $8529)
.byte $76,$72,$76,$72,$71,$04

; indirect data load target (via $852B)
.byte $B8,$B4,$B8,$B4,$B5,$B3,$05

; indirect data load target (via $852D)
.byte $BA,$B5,$00

; indirect data load target (via $850D)
.byte $B8,$B9,$BA,$BB,$BC,$BD,$7E,$7D,$7C,$7B,$7B,$7A,$79,$78,$78,$79,$7A,$7B,$0A

; indirect data load target (via $850F)
.byte $BA,$BC,$BD,$7F,$7E,$7D,$7C,$7B,$7A,$79,$78,$78,$79,$7A,$7B,$07

; indirect data load target (via $8511)
.byte $7D,$7F,$7E,$7E,$7E,$7E,$7D,$7C,$7B,$7A,$79,$78,$78,$78,$79,$7A,$7B,$08

; indirect data load target (via $8513)
.byte $7F,$7E,$7E,$7E,$7E,$7D,$7C,$7B,$7A,$79,$78,$78,$79,$7A,$7B,$07

; indirect data load target (via $8515)
.byte $3F,$7E,$BE,$3E,$7E,$BD,$03

; indirect data load target (via $8517)
.byte $BA,$BF,$05

; indirect data load target (via $8519)
.byte $7F,$7E,$BD,$BC,$BC,$BB,$BB,$BA,$BA,$BA,$B9,$B9,$B9,$B8,$B8,$B8,$B8,$B9,$BA,$BB,$BC,$BC,$BB,$BA,$B9,$0D

; indirect data load target (via $851B)
.byte $7F,$7D,$BA,$B9,$B9,$B8,$B8,$B8,$7C,$7B,$BA,$B9,$B9,$B8,$B8,$B8,$B8,$B9,$BA,$BB,$BC,$BC,$BB,$BA,$B9,$0D

; indirect data load target (via $851D)
.byte $3F,$3D,$3C,$3B,$3A,$3A,$39,$39,$38,$38,$37,$0A

; indirect data load target (via $851F)
.byte $3F,$39,$37,$35,$33,$32,$31,$06

; indirect data load target (via $8521)
.byte $BF,$BE,$BC,$BB,$BA,$B8,$B7,$BA,$B8,$B7,$B6,$B7,$B7,$B7,$B9,$B8,$B7,$B6,$B6,$B5,$B6,$B7,$B6,$B5,$B5,$B6,$B7,$B8,$B8,$15

; indirect data load target (via $8523)
.byte $3C,$39,$36,$34,$33,$32,$31,$06

; indirect data load target (via $8525)
.byte $B6,$B6,$B5,$B5,$B4

; indirect data load target
.byte $04

; external indirect data load target (via $0F:$DF81)
; indirect data load target
.byte $97

; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $A7
; indirect data load target
.byte $9F
; indirect data load target
.byte $B1
; indirect data load target
.byte $9F
; indirect data load target
.byte $BE
; indirect data load target
.byte $9F
; indirect data load target
.byte $D0
; indirect data load target
.byte $9F
; indirect data load target
.byte $E3
; indirect data load target
.byte $9F
; indirect data load target
.byte $F9
; indirect data load target
.byte $9F
; indirect data load target
.byte $0F
; indirect data load target
.byte $A0
; indirect data load target
.byte $29
; indirect data load target
.byte $A0
; indirect data load target
.byte $3E
; indirect data load target
.byte $A0
; indirect data load target
.byte $57
; indirect data load target
.byte $A0
; indirect data load target
.byte $72
; indirect data load target
.byte $A0
; indirect data load target
.byte $90
; indirect data load target
.byte $A0
; indirect data load target
.byte $AE
; indirect data load target
.byte $A0
; indirect data load target
.byte $CD
; indirect data load target
.byte $A0
; indirect data load target
.byte $E8
; indirect data load target
.byte $A0
; indirect data load target
.byte $FF
; indirect data load target
.byte $A0
; indirect data load target
.byte $16
; indirect data load target
.byte $A1
; indirect data load target
.byte $32
; indirect data load target
.byte $A1
; indirect data load target
.byte $4D
; indirect data load target
.byte $A1
; indirect data load target
.byte $67
; indirect data load target
.byte $A1
; indirect data load target
.byte $86
; indirect data load target
.byte $A1
; indirect data load target
.byte $A2
; indirect data load target
.byte $A1
; indirect data load target
.byte $C1
; indirect data load target
.byte $A1
; indirect data load target
.byte $E2
; indirect data load target
.byte $A1
; indirect data load target
.byte $01
; indirect data load target
.byte $A2
; indirect data load target
.byte $21
; indirect data load target
.byte $A2
; indirect data load target
.byte $48
; indirect data load target
.byte $A2
; indirect data load target
.byte $6F
; indirect data load target
.byte $A2
; indirect data load target
.byte $9E
; indirect data load target
.byte $A2
; indirect data load target
.byte $C6
; indirect data load target
.byte $A2
; indirect data load target
.byte $F3
; indirect data load target
.byte $A2
; indirect data load target
.byte $20
; indirect data load target
.byte $A3
; indirect data load target
.byte $4D
; indirect data load target
.byte $A3
; indirect data load target
.byte $76
; indirect data load target
.byte $A3
; indirect data load target
.byte $9E
; indirect data load target
.byte $A3
; indirect data load target
.byte $C5
; indirect data load target
.byte $A3
; indirect data load target
.byte $E8
; indirect data load target
.byte $A3
; indirect data load target
.byte $0C
; indirect data load target
.byte $A4
; indirect data load target
.byte $2E
; indirect data load target
.byte $A4
; indirect data load target
.byte $51
; indirect data load target
.byte $A4
; indirect data load target
.byte $73
; indirect data load target
.byte $A4
; indirect data load target
.byte $9B
; indirect data load target
.byte $A4
; indirect data load target
.byte $C8
; indirect data load target
.byte $A4
; indirect data load target
.byte $F5
; indirect data load target
.byte $A4
; indirect data load target
.byte $1B
; indirect data load target
.byte $A5
; indirect data load target
.byte $39
; indirect data load target
.byte $A5
; indirect data load target
.byte $57
; indirect data load target
.byte $A5
; indirect data load target
.byte $7B
; indirect data load target
.byte $A5
; indirect data load target
.byte $AB
; indirect data load target
.byte $A5
; indirect data load target
.byte $DA
; indirect data load target
.byte $A5
; indirect data load target
.byte $06
; indirect data load target
.byte $A6
; indirect data load target
.byte $2D
; indirect data load target
.byte $A6
; indirect data load target
.byte $53
; indirect data load target
.byte $A6
; indirect data load target
.byte $7D
; indirect data load target
.byte $A6
; indirect data load target
.byte $A7
; indirect data load target
.byte $A6
; indirect data load target
.byte $CF
; indirect data load target
.byte $A6
; indirect data load target
.byte $F5
; indirect data load target
.byte $A6
; indirect data load target
.byte $20
; indirect data load target
.byte $A7
; indirect data load target
.byte $4C
; indirect data load target
.byte $A7
; indirect data load target
.byte $74
; indirect data load target
.byte $A7
; indirect data load target
.byte $97
; indirect data load target
.byte $A7
; indirect data load target
.byte $B7
; indirect data load target
.byte $A7
; indirect data load target
.byte $D2
; indirect data load target
.byte $A7
; indirect data load target
.byte $F1
; indirect data load target
.byte $A7
; indirect data load target
.byte $11
; indirect data load target
.byte $A8
; indirect data load target
.byte $32
; indirect data load target
.byte $A8
; indirect data load target
.byte $57
; indirect data load target
.byte $A8
; indirect data load target
.byte $7C
; indirect data load target
.byte $A8
; indirect data load target
.byte $A3
; indirect data load target
.byte $A8
; indirect data load target
.byte $C2
; indirect data load target
.byte $A8
; indirect data load target
.byte $EA
; indirect data load target
.byte $A8
; indirect data load target
.byte $13
; indirect data load target
.byte $A9
; indirect data load target
.byte $3C
; indirect data load target
.byte $A9
; indirect data load target
.byte $61
; indirect data load target
.byte $A9
; indirect data load target
.byte $82
; indirect data load target
.byte $A9
; indirect data load target
.byte $A3
; indirect data load target
.byte $A9
; indirect data load target
.byte $C6
; indirect data load target
.byte $A9
; indirect data load target
.byte $E9
; indirect data load target
.byte $A9
; indirect data load target
.byte $0E
; indirect data load target
.byte $AA
; indirect data load target
.byte $33
; indirect data load target
.byte $AA
; indirect data load target
.byte $5B
; indirect data load target
.byte $AA
; indirect data load target
.byte $7C
; indirect data load target
.byte $AA
; indirect data load target
.byte $9E
; indirect data load target
.byte $AA
; indirect data load target
.byte $BB
; indirect data load target
.byte $AA
; indirect data load target
.byte $DC
; indirect data load target
.byte $AA
; indirect data load target
.byte $F9
; indirect data load target
.byte $AA
; indirect data load target
.byte $10
; indirect data load target
.byte $AB
; indirect data load target
.byte $29
; indirect data load target
.byte $AB
; indirect data load target
.byte $43
; indirect data load target
.byte $AB
; indirect data load target
.byte $5A
; indirect data load target
.byte $AB
; indirect data load target
.byte $71
; indirect data load target
.byte $AB
; indirect data load target
.byte $87
; indirect data load target
.byte $AB
; indirect data load target
.byte $9F
; indirect data load target
.byte $AB
; indirect data load target
.byte $B5
; indirect data load target
.byte $AB
; indirect data load target
.byte $D0
; indirect data load target
.byte $AB
; indirect data load target
.byte $E5
; indirect data load target
.byte $AB
; indirect data load target
.byte $F7
; indirect data load target
.byte $AB
; indirect data load target
.byte $0A
; indirect data load target
.byte $AC
; indirect data load target
.byte $1F
; indirect data load target
.byte $AC
; indirect data load target
.byte $34
; indirect data load target
.byte $AC
; indirect data load target
.byte $48
; indirect data load target
.byte $AC
; indirect data load target
.byte $5D
; indirect data load target
.byte $AC
; indirect data load target
.byte $76
; indirect data load target
.byte $AC
; indirect data load target
.byte $8C
; indirect data load target
.byte $AC
; indirect data load target
.byte $A4
; indirect data load target
.byte $AC
; indirect data load target
.byte $BB
; indirect data load target
.byte $AC
; indirect data load target
.byte $D0
; indirect data load target
.byte $AC
; indirect data load target
.byte $E7
; indirect data load target
.byte $AC
; indirect data load target
.byte $02
; indirect data load target
.byte $AD
; indirect data load target
.byte $22
; indirect data load target
.byte $AD
; indirect data load target
.byte $41
; indirect data load target
.byte $AD
; indirect data load target
.byte $5E
; indirect data load target
.byte $AD
; indirect data load target
.byte $76
; indirect data load target
.byte $AD
; indirect data load target
.byte $8D
; indirect data load target
.byte $AD
; indirect data load target
.byte $A6
; indirect data load target
.byte $AD
; indirect data load target
.byte $BE
; indirect data load target
.byte $AD
; indirect data load target
.byte $DC
; indirect data load target
.byte $AD
; indirect data load target
.byte $FC
; indirect data load target
.byte $AD
; indirect data load target
.byte $19
; indirect data load target
.byte $AE
; indirect data load target
.byte $3C
; indirect data load target
.byte $AE
; indirect data load target
.byte $55
; indirect data load target
.byte $AE
; indirect data load target
.byte $70
; indirect data load target
.byte $AE
; indirect data load target
.byte $8C
; indirect data load target
.byte $AE
; indirect data load target
.byte $A3
; indirect data load target
.byte $AE
; indirect data load target
.byte $B7
; indirect data load target
.byte $AE
; indirect data load target
.byte $CB
; indirect data load target
.byte $AE
; indirect data load target
.byte $DC
; indirect data load target
.byte $AE
; indirect data load target
.byte $F0
; indirect data load target
.byte $AE
; indirect data load target
.byte $07
; indirect data load target
.byte $AF
; indirect data load target
.byte $20
; indirect data load target
.byte $AF
; indirect data load target
.byte $3B
; indirect data load target
.byte $AF
; indirect data load target
.byte $58
; indirect data load target
.byte $AF
; indirect data load target
.byte $7C
; indirect data load target
.byte $AF
; indirect data load target
.byte $A3
; indirect data load target
.byte $AF
; indirect data load target
.byte $C5
; indirect data load target
.byte $AF
; indirect data load target
.byte $E8
; indirect data load target
.byte $AF
; indirect data load target
.byte $0B
; indirect data load target
.byte $B0
; indirect data load target
.byte $29
; indirect data load target
.byte $B0
; indirect data load target
.byte $46
; indirect data load target
.byte $B0
; indirect data load target
.byte $66
; indirect data load target
.byte $B0
; indirect data load target
.byte $8B
; indirect data load target
.byte $B0
; indirect data load target
.byte $AA
; indirect data load target
.byte $B0
; indirect data load target
.byte $C9
; indirect data load target
.byte $B0
; indirect data load target
.byte $E7
; indirect data load target
.byte $B0
; indirect data load target
.byte $0C
; indirect data load target
.byte $B1
; indirect data load target
.byte $2A
; indirect data load target
.byte $B1
; indirect data load target
.byte $48
; indirect data load target
.byte $B1
; indirect data load target
.byte $6A
; indirect data load target
.byte $B1
; indirect data load target
.byte $8C
; indirect data load target
.byte $B1
; indirect data load target
.byte $AA
; indirect data load target
.byte $B1
; indirect data load target
.byte $C6
; indirect data load target
.byte $B1
; indirect data load target
.byte $E2
; indirect data load target
.byte $B1
; indirect data load target
.byte $02
; indirect data load target
.byte $B2
; indirect data load target
.byte $22
; indirect data load target
.byte $B2
; indirect data load target
.byte $43
; indirect data load target
.byte $B2
; indirect data load target
.byte $5E
; indirect data load target
.byte $B2
; indirect data load target
.byte $81
; indirect data load target
.byte $B2
; indirect data load target
.byte $A5
; indirect data load target
.byte $B2
; indirect data load target
.byte $C7
; indirect data load target
.byte $B2
; indirect data load target
.byte $E7
; indirect data load target
.byte $B2
; indirect data load target
.byte $03
; indirect data load target
.byte $B3
; indirect data load target
.byte $20
; indirect data load target
.byte $B3
; indirect data load target
.byte $3F
; indirect data load target
.byte $B3
; indirect data load target
.byte $60
; indirect data load target
.byte $B3
; indirect data load target
.byte $82
; indirect data load target
.byte $B3
; indirect data load target
.byte $9E
; indirect data load target
.byte $B3
; indirect data load target
.byte $BD
; indirect data load target
.byte $B3
; indirect data load target
.byte $DA
; indirect data load target
.byte $B3
; indirect data load target
.byte $F9
; indirect data load target
.byte $B3
; indirect data load target
.byte $17
; indirect data load target
.byte $B4
; indirect data load target
.byte $32
; indirect data load target
.byte $B4
; indirect data load target
.byte $4D
; indirect data load target
.byte $B4
; indirect data load target
.byte $6A
; indirect data load target
.byte $B4
; indirect data load target
.byte $84
; indirect data load target
.byte $B4
; indirect data load target
.byte $A1
; indirect data load target
.byte $B4
; indirect data load target
.byte $BE
; indirect data load target
.byte $B4
; indirect data load target
.byte $D4
; indirect data load target
.byte $B4
; indirect data load target
.byte $E9
; indirect data load target
.byte $B4
; indirect data load target
.byte $FE
; indirect data load target
.byte $B4
; indirect data load target
.byte $10
; indirect data load target
.byte $B5
; indirect data load target
.byte $22
; indirect data load target
.byte $B5
; indirect data load target
.byte $33
; indirect data load target
.byte $B5
; indirect data load target
.byte $43
; indirect data load target
.byte $B5
; indirect data load target
.byte $51
; indirect data load target
.byte $B5
; indirect data load target
.byte $61
; indirect data load target
.byte $B5
; indirect data load target
.byte $72
; indirect data load target
.byte $B5
; indirect data load target
.byte $84
; indirect data load target
.byte $B5
; indirect data load target
.byte $91
; indirect data load target
.byte $B5
; indirect data load target
.byte $9E
; indirect data load target
.byte $B5
; indirect data load target
.byte $AB
; indirect data load target
.byte $B5
; indirect data load target
.byte $BA
; indirect data load target
.byte $B5
; indirect data load target
.byte $C9
; indirect data load target
.byte $B5
; indirect data load target
.byte $DB
; indirect data load target
.byte $B5
; indirect data load target
.byte $E9
; indirect data load target
.byte $B5
; indirect data load target
.byte $F8
; indirect data load target
.byte $B5
; indirect data load target
.byte $08
; indirect data load target
.byte $B6
; indirect data load target
.byte $1A
; indirect data load target
.byte $B6
; indirect data load target
.byte $31
; indirect data load target
.byte $B6
; indirect data load target
.byte $4A
; indirect data load target
.byte $B6
; indirect data load target
.byte $5F
; indirect data load target
.byte $B6
; indirect data load target
.byte $73
; indirect data load target
.byte $B6
; indirect data load target
.byte $87
; indirect data load target
.byte $B6
; indirect data load target
.byte $9A
; indirect data load target
.byte $B6
; indirect data load target
.byte $AE
; indirect data load target
.byte $B6
; indirect data load target
.byte $BE
; indirect data load target
.byte $B6
; indirect data load target
.byte $CF
; indirect data load target
.byte $B6
; indirect data load target
.byte $E0
; indirect data load target
.byte $B6
; indirect data load target
.byte $F1
; indirect data load target
.byte $B6
; indirect data load target
.byte $04
; indirect data load target
.byte $B7
; indirect data load target
.byte $14
; indirect data load target
.byte $B7
; indirect data load target
.byte $26
; indirect data load target
.byte $B7
; indirect data load target
.byte $36
; indirect data load target
.byte $B7
; indirect data load target
.byte $4B
; indirect data load target
.byte $B7
; indirect data load target
.byte $5B
; indirect data load target
.byte $B7
; indirect data load target
.byte $69
; indirect data load target
.byte $B7
; indirect data load target
.byte $78
; indirect data load target
.byte $B7
; indirect data load target
.byte $86
; indirect data load target
.byte $B7
; indirect data load target
.byte $92
; indirect data load target
.byte $B7
; indirect data load target
.byte $A0
; indirect data load target
.byte $B7
; indirect data load target
.byte $B0
; indirect data load target
.byte $B7
; indirect data load target
.byte $C2
; indirect data load target
.byte $B7
; indirect data load target
.byte $D1
; indirect data load target
.byte $B7
; indirect data load target
.byte $E2
; indirect data load target
.byte $B7
; indirect data load target
.byte $F0
; indirect data load target
.byte $B7
; indirect data load target
.byte $FA
; indirect data load target
.byte $B7
; indirect data load target
.byte $02
; indirect data load target
.byte $B8
; indirect data load target
.byte $0A
; indirect data load target
.byte $B8
; indirect data load target
.byte $12
; indirect data load target
.byte $B8
; indirect data load target
.byte $1A
; indirect data load target
.byte $B8
; indirect data load target
.byte $22
; indirect data load target
.byte $B8
; indirect data load target
.byte $2A
; indirect data load target
.byte $B8
; indirect data load target
.byte $34
; indirect data load target
.byte $B8
; indirect data load target
.byte $40
; indirect data load target
.byte $B8
; indirect data load target
.byte $4A
; indirect data load target
.byte $B8
; indirect data load target
.byte $55
; indirect data load target
.byte $B8
; indirect data load target
.byte $5D
; indirect data load target
.byte $B8
; indirect data load target
.byte $65
; indirect data load target
.byte $B8
; indirect data load target
.byte $6D
; indirect data load target
.byte $B8
; indirect data load target
.byte $75
; indirect data load target
.byte $B8
; indirect data load target
.byte $7D
; indirect data load target
.byte $B8
; indirect data load target
.byte $85
; indirect data load target
.byte $B8
; indirect data load target
.byte $8D
; indirect data load target
.byte $B8
; indirect data load target
.byte $95
; indirect data load target
.byte $B8
; indirect data load target
.byte $9D
; indirect data load target
.byte $B8
; indirect data load target
.byte $A5
; indirect data load target
.byte $B8
; indirect data load target
.byte $AD
; indirect data load target
.byte $B8
; indirect data load target
.byte $B5
; indirect data load target
.byte $B8
; indirect data load target
.byte $BD
; indirect data load target
.byte $B8
; indirect data load target
.byte $C5
; indirect data load target
.byte $B8
; indirect data load target
.byte $CD
; indirect data load target
.byte $B8
; indirect data load target
.byte $D7
; indirect data load target
.byte $B8
; indirect data load target
.byte $DF
; indirect data load target
.byte $B8
; indirect data load target
.byte $E7
; indirect data load target
.byte $B8
; indirect data load target
.byte $EF
; indirect data load target
.byte $B8

.byte $F7
; data -> unknown

.byte $B8
; unknown -> data
; indirect data load target
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $98
; indirect data load target
.byte $62
; indirect data load target
.byte $83
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $90
; indirect data load target
.byte $65
; indirect data load target
.byte $9F
; indirect data load target
.byte $99
; indirect data load target
.byte $63
; indirect data load target
.byte $82
; indirect data load target
.byte $65
; indirect data load target
.byte $81
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9E
; indirect data load target
.byte $E4
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $63
; indirect data load target
.byte $83
; indirect data load target
.byte $6B
; indirect data load target
.byte $90
; indirect data load target
.byte $C3
; indirect data load target
.byte $94
; indirect data load target
.byte $62
; indirect data load target
.byte $8A
; indirect data load target
.byte $62
; indirect data load target
.byte $83
; indirect data load target
.byte $63
; indirect data load target
.byte $84
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $88
; indirect data load target
.byte $66
; indirect data load target
.byte $8B
; indirect data load target
.byte $E9
; indirect data load target
.byte $94
; indirect data load target
.byte $25
; indirect data load target
.byte $93
; indirect data load target
.byte $67
; indirect data load target
.byte $85
; indirect data load target
.byte $63
; indirect data load target
.byte $88
; indirect data load target
.byte $6C
; indirect data load target
.byte $8A
; indirect data load target
.byte $C5
; indirect data load target
.byte $91
; indirect data load target
.byte $66
; indirect data load target
.byte $98
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $82
; indirect data load target
.byte $6D
; indirect data load target
.byte $87
; indirect data load target
.byte $EE
; indirect data load target
.byte $8F
; indirect data load target
.byte $A2
; indirect data load target
.byte $27
; indirect data load target
.byte $8B
; indirect data load target
.byte $28
; indirect data load target
.byte $67
; indirect data load target
.byte $91
; indirect data load target
.byte $6C
; indirect data load target
.byte $43
; indirect data load target
.byte $83
; indirect data load target
.byte $C7
; indirect data load target
.byte $8E
; indirect data load target
.byte $69
; indirect data load target
.byte $82
; indirect data load target
.byte $61
; indirect data load target
.byte $92
; indirect data load target
.byte $9F
; indirect data load target
.byte $9E
; indirect data load target
.byte $6F
; indirect data load target
.byte $24
; indirect data load target
.byte $82
; indirect data load target
.byte $F1
.byte $23
; indirect data load target
.byte $88
; indirect data load target
.byte $A3
; indirect data load target
.byte $2A
; indirect data load target
.byte $87
; indirect data load target
.byte $2B
; indirect data load target
.byte $67
; indirect data load target
.byte $91
; indirect data load target
.byte $68
; indirect data load target
.byte $48
; indirect data load target
.byte $CA
; indirect data load target
.byte $8A
; indirect data load target
.byte $68
; indirect data load target
.byte $85
; indirect data load target
.byte $61
; indirect data load target
.byte $93
; indirect data load target
.byte $9F
; indirect data load target
.byte $9C
; indirect data load target
.byte $69
; indirect data load target
.byte $23
; indirect data load target
.byte $62
; indirect data load target
.byte $27
; indirect data load target
.byte $F1
; indirect data load target
.byte $29
; indirect data load target
.byte $82
; indirect data load target
.byte $A6
; indirect data load target
.byte $64
; indirect data load target
.byte $24
; indirect data load target
.byte $83
; indirect data load target
.byte $30
; indirect data load target
.byte $66
; indirect data load target
.byte $89
; indirect data load target
.byte $E2
; indirect data load target
.byte $83
; indirect data load target
.byte $65
; indirect data load target
.byte $4C
; indirect data load target
.byte $C9
; indirect data load target
.byte $88
; indirect data load target
.byte $64
; indirect data load target
.byte $0C
; indirect data load target
.byte $61
; indirect data load target
.byte $9E
; indirect data load target
.byte $9F
; indirect data load target
.byte $9B
; indirect data load target
.byte $69
; indirect data load target
.byte $2E
; indirect data load target
.byte $E6
; indirect data load target
.byte $84
; indirect data load target
.byte $E4
; indirect data load target
.byte $2E
; indirect data load target
.byte $A4
; indirect data load target
.byte $69
; indirect data load target
.byte $21
; indirect data load target
.byte $82
; indirect data load target
.byte $34
; indirect data load target
.byte $65
; indirect data load target
.byte $85
; indirect data load target
.byte $E7
; indirect data load target
.byte $54
; indirect data load target
.byte $C8
; indirect data load target
.byte $86
; indirect data load target
.byte $68
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9A
; indirect data load target
.byte $69
; indirect data load target
.byte $30
; indirect data load target
.byte $E4
; indirect data load target
.byte $81
; indirect data load target
.byte $62
; indirect data load target
.byte $80
; indirect data load target
.byte $E2
; indirect data load target
.byte $2F
; indirect data load target
.byte $A3
; indirect data load target
.byte $6C
; indirect data load target
.byte $21
; indirect data load target
.byte $09
; indirect data load target
.byte $2A
; indirect data load target
.byte $64
; indirect data load target
.byte $27
; indirect data load target
.byte $67
; indirect data load target
.byte $EA
; indirect data load target
.byte $54
; indirect data load target
.byte $C6
; indirect data load target
.byte $84
; indirect data load target
.byte $6A
; indirect data load target
.byte $9F
; indirect data load target
.byte $80
; indirect data load target
.byte $9F
; indirect data load target
.byte $99
; indirect data load target
.byte $69
; indirect data load target
.byte $2A
; indirect data load target
.byte $81
; indirect data load target
.byte $25
; indirect data load target
.byte $E3
; indirect data load target
.byte $80
; indirect data load target
.byte $63
; indirect data load target
.byte $09
; indirect data load target
.byte $2A
; indirect data load target
.byte $64
; indirect data load target
.byte $22
; indirect data load target
.byte $A2
; indirect data load target
.byte $6E
; indirect data load target
.byte $82
; indirect data load target
.byte $28
; indirect data load target
.byte $66
; indirect data load target
.byte $28
; indirect data load target
.byte $64
; indirect data load target
.byte $EC
; indirect data load target
.byte $53
; indirect data load target
.byte $C6
; indirect data load target
.byte $82
; indirect data load target
.byte $6B
; indirect data load target
.byte $9F
; indirect data load target
.byte $81
; indirect data load target
.byte $9F
; indirect data load target
.byte $98
; indirect data load target
.byte $6B
; indirect data load target
.byte $27
; indirect data load target
.byte $84
; indirect data load target
.byte $28
; indirect data load target
.byte $80
; indirect data load target
.byte $60
; indirect data load target
.byte $0C
; indirect data load target
.byte $61
; indirect data load target
.byte $09
; indirect data load target
.byte $28
; indirect data load target
.byte $68
; indirect data load target
.byte $A2
; indirect data load target
.byte $6D
; indirect data load target
.byte $88
; indirect data load target
.byte $26
; indirect data load target
.byte $66
; indirect data load target
.byte $27
; indirect data load target
.byte $62
; indirect data load target
.byte $EF
; indirect data load target
.byte $A4
; indirect data load target
.byte $4B
; indirect data load target
.byte $C8
; indirect data load target
.byte $09
; indirect data load target
.byte $21
; indirect data load target
.byte $67
; indirect data load target
.byte $A2
; indirect data load target
.byte $9F
; indirect data load target
.byte $81
; indirect data load target
.byte $9F
; indirect data load target
.byte $98
; indirect data load target
.byte $67
; indirect data load target
.byte $82
; indirect data load target
.byte $27
; indirect data load target
.byte $85
; indirect data load target
.byte $28
; indirect data load target
.byte $80
; indirect data load target
.byte $62
; indirect data load target
.byte $81
; indirect data load target
.byte $27
; indirect data load target
.byte $64
; indirect data load target
.byte $A1
; indirect data load target
.byte $61
; indirect data load target
.byte $A2
; indirect data load target
.byte $69
; indirect data load target
.byte $90
; indirect data load target
.byte $24
; indirect data load target
.byte $66
; indirect data load target
.byte $2A
; indirect data load target
.byte $EC
; indirect data load target
.byte $A9
; indirect data load target
.byte $46
; indirect data load target
.byte $C8
; indirect data load target
.byte $83
; indirect data load target
.byte $21
; indirect data load target
.byte $64
; indirect data load target
.byte $A3
; indirect data load target
.byte $9F
; indirect data load target
.byte $82
; indirect data load target
.byte $9F
; indirect data load target
.byte $99
; indirect data load target
.byte $65
; indirect data load target
.byte $84
; indirect data load target
.byte $24
; indirect data load target
.byte $88
; indirect data load target
.byte $24
; indirect data load target
.byte $C2
; indirect data load target
.byte $84
; indirect data load target
.byte $29
; indirect data load target
.byte $62
; indirect data load target
.byte $A7
; indirect data load target
.byte $64
; indirect data load target
.byte $8B
; indirect data load target
.byte $62
; indirect data load target
.byte $86
; indirect data load target
.byte $25
; indirect data load target
.byte $69
; indirect data load target
.byte $28
; indirect data load target
.byte $E8
; indirect data load target
.byte $A9
; indirect data load target
.byte $83
; indirect data load target
.byte $43
; indirect data load target
.byte $C7
; indirect data load target
.byte $85
; indirect data load target
.byte $22
; indirect data load target
.byte $61
; indirect data load target
.byte $A2
; indirect data load target
.byte $62
; indirect data load target
.byte $9F
; indirect data load target
.byte $82
; indirect data load target
.byte $9F
; indirect data load target
.byte $99
; indirect data load target
.byte $63
; indirect data load target
.byte $95
; indirect data load target
.byte $CA
; indirect data load target
.byte $2B
; indirect data load target
.byte $64
; indirect data load target
.byte $A3
; indirect data load target
.byte $61
; indirect data load target
.byte $A2
; indirect data load target
.byte $87
; indirect data load target
.byte $68
; indirect data load target
.byte $83
; indirect data load target
.byte $28
; indirect data load target
.byte $67
; indirect data load target
.byte $00
; indirect data load target
.byte $12
; indirect data load target
.byte $27
; indirect data load target
.byte $AE
; indirect data load target
.byte $8E
; indirect data load target
.byte $C3
; indirect data load target
.byte $84
; indirect data load target
.byte $23
; indirect data load target
.byte $A4
; indirect data load target
.byte $62
; indirect data load target
.byte $9F
; indirect data load target
.byte $83
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $96
; indirect data load target
.byte $C8
; indirect data load target
.byte $2B
; indirect data load target
.byte $68
; indirect data load target
.byte $A1
; indirect data load target
.byte $86
; indirect data load target
.byte $71
; indirect data load target
.byte $25
; indirect data load target
.byte $68
; indirect data load target
.byte $10
; indirect data load target
.byte $11
; indirect data load target
.byte $25
; indirect data load target
.byte $A5
; indirect data load target
.byte $C3
; indirect data load target
.byte $A4
; indirect data load target
.byte $97
; indirect data load target
.byte $23
; indirect data load target
.byte $A4
; indirect data load target
.byte $64
; indirect data load target
.byte $9F
; indirect data load target
.byte $83
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $98
; indirect data load target
.byte $C6
; indirect data load target
.byte $E2
; indirect data load target
.byte $2A
; indirect data load target
.byte $64
; indirect data load target
.byte $A3
; indirect data load target
.byte $84
; indirect data load target
.byte $22
; indirect data load target
.byte $65
; indirect data load target
.byte $21
; indirect data load target
.byte $6A
; indirect data load target
.byte $23
; indirect data load target
.byte $6B
; indirect data load target
.byte $A5
; indirect data load target
.byte $CA
; indirect data load target
.byte $99
; indirect data load target
.byte $23
; indirect data load target
.byte $A2
; indirect data load target
.byte $67
; indirect data load target
.byte $9F
; indirect data load target
.byte $83
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9A
; indirect data load target
.byte $C3
; indirect data load target
.byte $E6
; indirect data load target
.byte $28
; indirect data load target
.byte $64
; indirect data load target
.byte $A3
; indirect data load target
.byte $82
; indirect data load target
.byte $25
; indirect data load target
.byte $62
; indirect data load target
.byte $23
; indirect data load target
.byte $62
; indirect data load target
.byte $E4
; indirect data load target
.byte $62
; indirect data load target
.byte $21
; indirect data load target
.byte $6C
; indirect data load target
.byte $E2
; indirect data load target
.byte $CC
; indirect data load target
.byte $86
; indirect data load target
.byte $63
; indirect data load target
.byte $8F
; indirect data load target
.byte $21
; indirect data load target
.byte $A3
; indirect data load target
.byte $67
; indirect data load target
.byte $89
; indirect data load target
.byte $60
; indirect data load target
.byte $99
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9B
; indirect data load target
.byte $E8
; indirect data load target
.byte $62
; indirect data load target
.byte $27
; indirect data load target
.byte $A8
; indirect data load target
.byte $81
; indirect data load target
.byte $2D
; indirect data load target
.byte $60
; indirect data load target
.byte $E6
; indirect data load target
.byte $6E
; indirect data load target
.byte $E5
; indirect data load target
.byte $C9
; indirect data load target
.byte $86
; indirect data load target
.byte $66
; indirect data load target
.byte $85
; indirect data load target
.byte $22
; indirect data load target
.byte $83
; indirect data load target
.byte $22
; indirect data load target
.byte $A1
; indirect data load target
.byte $68
; indirect data load target
.byte $8A
; indirect data load target
.byte $62
; indirect data load target
.byte $83
; indirect data load target
.byte $20
; indirect data load target
.byte $93
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9C
; indirect data load target
.byte $E6
; indirect data load target
.byte $65
; indirect data load target
.byte $27
; indirect data load target
.byte $A5
; indirect data load target
.byte $E4
; indirect data load target
.byte $2B
; indirect data load target
.byte $61
; indirect data load target
.byte $E5
; indirect data load target
.byte $6C
; indirect data load target
.byte $E9
; indirect data load target
.byte $C6
; indirect data load target
.byte $86
; indirect data load target
.byte $66
; indirect data load target
.byte $83
; indirect data load target
.byte $2A
; indirect data load target
.byte $A3
; indirect data load target
.byte $68
; indirect data load target
.byte $8A
; indirect data load target
.byte $61
; indirect data load target
.byte $21
; indirect data load target
.byte $81
; indirect data load target
.byte $22
; indirect data load target
.byte $92
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9C
; indirect data load target
.byte $E5
; indirect data load target
.byte $62
; indirect data load target
.byte $82
; indirect data load target
.byte $61
; indirect data load target
.byte $28
; indirect data load target
.byte $A3
; indirect data load target
.byte $E6
; indirect data load target
.byte $28
; indirect data load target
.byte $62
; indirect data load target
.byte $E4
; indirect data load target
.byte $6C
; indirect data load target
.byte $23
; indirect data load target
.byte $E9
; indirect data load target
.byte $C3
; indirect data load target
.byte $84
; indirect data load target
.byte $67
; indirect data load target
.byte $83
; indirect data load target
.byte $28
; indirect data load target
.byte $A3
; indirect data load target
.byte $6A
; indirect data load target
.byte $8B
; indirect data load target
.byte $61
; indirect data load target
.byte $0B
; indirect data load target
.byte $20
; indirect data load target
.byte $82
; indirect data load target
.byte $60
; indirect data load target
.byte $21
; indirect data load target
.byte $91
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9D
; indirect data load target
.byte $E3
; indirect data load target
.byte $63
; indirect data load target
.byte $83
; indirect data load target
.byte $61
; indirect data load target
.byte $27
; indirect data load target
.byte $A3
; indirect data load target
.byte $E8
; indirect data load target
.byte $25
; indirect data load target
.byte $65
; indirect data load target
.byte $C1
; indirect data load target
.byte $6A
; indirect data load target
.byte $28
; indirect data load target
.byte $EC
; indirect data load target
.byte $82
; indirect data load target
.byte $68
; indirect data load target
.byte $82
; indirect data load target
.byte $28
; indirect data load target
.byte $A4
; indirect data load target
.byte $6A
; indirect data load target
.byte $8B
; indirect data load target
.byte $63
; indirect data load target
.byte $83
; indirect data load target
.byte $60
; indirect data load target
.byte $20
; indirect data load target
.byte $91
; indirect data load target
.byte $9F
; indirect data load target
.byte $82
; indirect data load target
.byte $63
; indirect data load target
.byte $22
; indirect data load target
.byte $86
; indirect data load target
.byte $24
; indirect data load target
.byte $87
; indirect data load target
.byte $63
; indirect data load target
.byte $9C
; indirect data load target
.byte $E3
; indirect data load target
.byte $63
; indirect data load target
.byte $83
; indirect data load target
.byte $60
; indirect data load target
.byte $26
; indirect data load target
.byte $A6
; indirect data load target
.byte $EA
; indirect data load target
.byte $65
; indirect data load target
.byte $C5
; indirect data load target
.byte $65
; indirect data load target
.byte $2D
; indirect data load target
.byte $EC
; indirect data load target
.byte $69
; indirect data load target
.byte $81
; indirect data load target
.byte $2A
; indirect data load target
.byte $A1
; indirect data load target
.byte $6E
; indirect data load target
.byte $8A
; indirect data load target
.byte $61
; indirect data load target
.byte $84
; indirect data load target
.byte $61
; indirect data load target
.byte $91
; indirect data load target
.byte $9F
; indirect data load target
.byte $81
; indirect data load target
.byte $65
; indirect data load target
.byte $23
; indirect data load target
.byte $82
; indirect data load target
.byte $29
; indirect data load target
.byte $83
; indirect data load target
.byte $66
; indirect data load target
.byte $9B
; indirect data load target
.byte $E3
; indirect data load target
.byte $61
; indirect data load target
.byte $85
; indirect data load target
.byte $60
; indirect data load target
.byte $25
; indirect data load target
.byte $A3
; indirect data load target
.byte $63
; indirect data load target
.byte $E9
; indirect data load target
.byte $62
; indirect data load target
.byte $81
; indirect data load target
.byte $C3
; indirect data load target
.byte $0B
; indirect data load target
.byte $C2
; indirect data load target
.byte $62
; indirect data load target
.byte $2F
; indirect data load target
.byte $EF
; indirect data load target
.byte $66
; indirect data load target
.byte $09
; indirect data load target
.byte $09
; indirect data load target
.byte $2A
; indirect data load target
.byte $71
; indirect data load target
.byte $90
; indirect data load target
.byte $61
; indirect data load target
.byte $91
; indirect data load target
.byte $9F
; indirect data load target
.byte $80
; indirect data load target
.byte $67
; indirect data load target
.byte $32
; indirect data load target
.byte $81
; indirect data load target
.byte $E1
; indirect data load target
.byte $64
; indirect data load target
.byte $87
; indirect data load target
.byte $E5
; indirect data load target
.byte $8D
; indirect data load target
.byte $E2
; indirect data load target
.byte $61
; indirect data load target
.byte $85
; indirect data load target
.byte $62
; indirect data load target
.byte $22
; indirect data load target
.byte $A2
; indirect data load target
.byte $66
; indirect data load target
.byte $E7
; indirect data load target
.byte $61
; indirect data load target
.byte $89
; indirect data load target
.byte $C1
; indirect data load target
.byte $63
; indirect data load target
.byte $2F
; indirect data load target
.byte $EF
; indirect data load target
.byte $65
; indirect data load target
.byte $81
; indirect data load target
.byte $2A
; indirect data load target
.byte $71
; indirect data load target
.byte $90
; indirect data load target
.byte $61
; indirect data load target
.byte $91
; indirect data load target
.byte $9F
; indirect data load target
.byte $66
; indirect data load target
.byte $E2
; indirect data load target
.byte $A4
; indirect data load target
.byte $21
; indirect data load target
.byte $67
; indirect data load target
.byte $23
; indirect data load target
.byte $81
; indirect data load target
.byte $E1
; indirect data load target
.byte $65
; indirect data load target
.byte $83
; indirect data load target
.byte $E8
; indirect data load target
.byte $8D
; indirect data load target
.byte $E2
; indirect data load target
.byte $61
; indirect data load target
.byte $83
; indirect data load target
.byte $65
; indirect data load target
.byte $A2
; indirect data load target
.byte $67
; indirect data load target
.byte $E6
; indirect data load target
.byte $62
; indirect data load target
.byte $8B
; indirect data load target
.byte $66
; indirect data load target
.byte $2D
; indirect data load target
.byte $EC
; indirect data load target
.byte $66
; indirect data load target
.byte $82
; indirect data load target
.byte $29
; indirect data load target
.byte $72
; indirect data load target
.byte $8F
; indirect data load target
.byte $62
; indirect data load target
.byte $91
; indirect data load target
.byte $9F
; indirect data load target
.byte $64
; indirect data load target
.byte $E2
; indirect data load target
.byte $A2
; indirect data load target
.byte $61
; indirect data load target
.byte $A2
; indirect data load target
.byte $6A
; indirect data load target
.byte $22
; indirect data load target
.byte $80
; indirect data load target
.byte $E2
; indirect data load target
.byte $65
; indirect data load target
.byte $81
; indirect data load target
.byte $E6
; indirect data load target
.byte $64
; indirect data load target
.byte $8B
; indirect data load target
.byte $E5
; indirect data load target
.byte $81
; indirect data load target
.byte $72
; indirect data load target
.byte $E3
; indirect data load target
.byte $64
; indirect data load target
.byte $81
; indirect data load target
.byte $C2
; indirect data load target
.byte $87
; indirect data load target
.byte $67
; indirect data load target
.byte $2B
; indirect data load target
.byte $EA
; indirect data load target
.byte $67
; indirect data load target
.byte $84
; indirect data load target
.byte $27
; indirect data load target
.byte $69
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $65
; indirect data load target
.byte $8E
; indirect data load target
.byte $62
; indirect data load target
.byte $91
; indirect data load target
.byte $9F
; indirect data load target
.byte $60
; indirect data load target
.byte $E5
; indirect data load target
.byte $A1
; indirect data load target
.byte $64
; indirect data load target
.byte $A2
; indirect data load target
.byte $6A
; indirect data load target
.byte $21
; indirect data load target
.byte $81
; indirect data load target
.byte $E1
; indirect data load target
.byte $65
; indirect data load target
.byte $E7
; indirect data load target
.byte $66
; indirect data load target
.byte $8B
; indirect data load target
.byte $E4
; indirect data load target
.byte $75
; indirect data load target
.byte $42
; indirect data load target
.byte $63
; indirect data load target
.byte $82
; indirect data load target
.byte $C0
; indirect data load target
.byte $0C
; indirect data load target
.byte $C0
; indirect data load target
.byte $87
; indirect data load target
.byte $6B
; indirect data load target
.byte $26
; indirect data load target
.byte $E9
; indirect data load target
.byte $67
; indirect data load target
.byte $86
; indirect data load target
.byte $25
; indirect data load target
.byte $6A
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $82
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $65
; indirect data load target
.byte $8C
; indirect data load target
.byte $62
; indirect data load target
.byte $92
; indirect data load target
.byte $82
; indirect data load target
.byte $63
; indirect data load target
.byte $99
; indirect data load target
.byte $E4
; indirect data load target
.byte $A2
; indirect data load target
.byte $65
; indirect data load target
.byte $A2
; indirect data load target
.byte $69
; indirect data load target
.byte $22
; indirect data load target
.byte $80
; indirect data load target
.byte $E1
; indirect data load target
.byte $65
; indirect data load target
.byte $E6
; indirect data load target
.byte $68
; indirect data load target
.byte $8B
; indirect data load target
.byte $E7
; indirect data load target
.byte $6F
; indirect data load target
.byte $45
; indirect data load target
.byte $62
; indirect data load target
.byte $82
; indirect data load target
.byte $C1
; indirect data load target
.byte $82
; indirect data load target
.byte $60
; indirect data load target
.byte $0C
; indirect data load target
.byte $60
; indirect data load target
.byte $83
; indirect data load target
.byte $6C
; indirect data load target
.byte $24
; indirect data load target
.byte $C1
; indirect data load target
.byte $E2
; indirect data load target
.byte $82
; indirect data load target
.byte $64
; indirect data load target
.byte $81
; indirect data load target
.byte $62
; indirect data load target
.byte $88
; indirect data load target
.byte $22
; indirect data load target
.byte $A5
; indirect data load target
.byte $64
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $84
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $65
; indirect data load target
.byte $8B
; indirect data load target
.byte $61
; indirect data load target
.byte $93
; indirect data load target
.byte $81
; indirect data load target
.byte $66
; indirect data load target
.byte $98
; indirect data load target
.byte $E2
; indirect data load target
.byte $69
; indirect data load target
.byte $A1
; indirect data load target
.byte $62
; indirect data load target
.byte $42
; indirect data load target
.byte $64
; indirect data load target
.byte $22
; indirect data load target
.byte $80
; indirect data load target
.byte $E2
; indirect data load target
.byte $64
; indirect data load target
.byte $E5
; indirect data load target
.byte $6B
; indirect data load target
.byte $8B
; indirect data load target
.byte $E8
; indirect data load target
.byte $6B
; indirect data load target
.byte $47
; indirect data load target
.byte $62
; indirect data load target
.byte $86
; indirect data load target
.byte $63
; indirect data load target
.byte $83
; indirect data load target
.byte $65
; indirect data load target
.byte $42
; indirect data load target
.byte $63
; indirect data load target
.byte $22
; indirect data load target
.byte $C4
; indirect data load target
.byte $8A
; indirect data load target
.byte $67
; indirect data load target
.byte $84
; indirect data load target
.byte $A9
; indirect data load target
.byte $62
; indirect data load target
.byte $08
; indirect data load target
.byte $86
; indirect data load target
.byte $08
; indirect data load target
.byte $65
; indirect data load target
.byte $8B
; indirect data load target
.byte $61
; indirect data load target
.byte $93
; indirect data load target
.byte $80
; indirect data load target
.byte $68
; indirect data load target
.byte $97
; indirect data load target
.byte $E2
; indirect data load target
.byte $23
; indirect data load target
.byte $64
; indirect data load target
.byte $A1
; indirect data load target
.byte $62
; indirect data load target
.byte $44
; indirect data load target
.byte $62
; indirect data load target
.byte $23
; indirect data load target
.byte $80
; indirect data load target
.byte $23
; indirect data load target
.byte $64
; indirect data load target
.byte $E3
; indirect data load target
.byte $21
; indirect data load target
.byte $6A
; indirect data load target
.byte $8C
; indirect data load target
.byte $E8
; indirect data load target
.byte $A2
; indirect data load target
.byte $67
; indirect data load target
.byte $47
; indirect data load target
.byte $62
; indirect data load target
.byte $85
; indirect data load target
.byte $64
; indirect data load target
.byte $83
; indirect data load target
.byte $63
; indirect data load target
.byte $46
; indirect data load target
.byte $63
; indirect data load target
.byte $C5
; indirect data load target
.byte $8A
; indirect data load target
.byte $69
; indirect data load target
.byte $83
; indirect data load target
.byte $A5
; indirect data load target
.byte $81
; indirect data load target
.byte $A2
; indirect data load target
.byte $60
; indirect data load target
.byte $08
; indirect data load target
.byte $86
; indirect data load target
.byte $08
; indirect data load target
.byte $64
; indirect data load target
.byte $23
; indirect data load target
.byte $86
; indirect data load target
.byte $63
; indirect data load target
.byte $93
; indirect data load target
.byte $80
; indirect data load target
.byte $62
; indirect data load target
.byte $42
; indirect data load target
.byte $63
; indirect data load target
.byte $96
; indirect data load target
.byte $62
; indirect data load target
.byte $27
; indirect data load target
.byte $65
; indirect data load target
.byte $44
; indirect data load target
.byte $61
; indirect data load target
.byte $24
; indirect data load target
.byte $09
; indirect data load target
.byte $24
; indirect data load target
.byte $65
; indirect data load target
.byte $24
; indirect data load target
.byte $68
; indirect data load target
.byte $8F
; indirect data load target
.byte $E7
; indirect data load target
.byte $A5
; indirect data load target
.byte $64
; indirect data load target
.byte $45
; indirect data load target
.byte $65
; indirect data load target
.byte $82
; indirect data load target
.byte $65
; indirect data load target
.byte $83
; indirect data load target
.byte $65
; indirect data load target
.byte $43
; indirect data load target
.byte $66
; indirect data load target
.byte $C4
; indirect data load target
.byte $86
; indirect data load target
.byte $6D
; indirect data load target
.byte $82
; indirect data load target
.byte $A3
; indirect data load target
.byte $84
; indirect data load target
.byte $A2
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $84
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $63
; indirect data load target
.byte $25
; indirect data load target
.byte $83
; indirect data load target
.byte $65
; indirect data load target
.byte $93
; indirect data load target
.byte $80
; indirect data load target
.byte $61
; indirect data load target
.byte $44
; indirect data load target
.byte $63
; indirect data load target
.byte $94
; indirect data load target
.byte $64
; indirect data load target
.byte $28
; indirect data load target
.byte $64
; indirect data load target
.byte $42
; indirect data load target
.byte $61
; indirect data load target
.byte $24
; indirect data load target
.byte $82
; indirect data load target
.byte $23
; indirect data load target
.byte $63
; indirect data load target
.byte $27
; indirect data load target
.byte $66
; indirect data load target
.byte $91
; indirect data load target
.byte $E8
; indirect data load target
.byte $A4
; indirect data load target
.byte $64
; indirect data load target
.byte $42
; indirect data load target
.byte $66
; indirect data load target
.byte $82
; indirect data load target
.byte $21
; indirect data load target
.byte $65
; indirect data load target
.byte $82
; indirect data load target
.byte $64
; indirect data load target
.byte $44
; indirect data load target
.byte $67
; indirect data load target
.byte $C4
; indirect data load target
.byte $85
; indirect data load target
.byte $6F
; indirect data load target
.byte $A3
; indirect data load target
.byte $85
; indirect data load target
.byte $A3
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $81
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $63
; indirect data load target
.byte $27
; indirect data load target
.byte $67
; indirect data load target
.byte $94
; indirect data load target
.byte $80
; indirect data load target
.byte $62
; indirect data load target
.byte $44
; indirect data load target
.byte $63
; indirect data load target
.byte $93
; indirect data load target
.byte $66
; indirect data load target
.byte $28
; indirect data load target
.byte $67
; indirect data load target
.byte $23
; indirect data load target
.byte $85
; indirect data load target
.byte $22
; indirect data load target
.byte $61
; indirect data load target
.byte $27
; indirect data load target
.byte $64
; indirect data load target
.byte $A1
; indirect data load target
.byte $92
; indirect data load target
.byte $EA
; indirect data load target
.byte $A4
; indirect data load target
.byte $6B
; indirect data load target
.byte $83
; indirect data load target
.byte $22
; indirect data load target
.byte $64
; indirect data load target
.byte $83
; indirect data load target
.byte $62
; indirect data load target
.byte $44
; indirect data load target
.byte $68
; indirect data load target
.byte $C3
; indirect data load target
.byte $85
; indirect data load target
.byte $22
; indirect data load target
.byte $6E
; indirect data load target
.byte $A2
; indirect data load target
.byte $84
; indirect data load target
.byte $A5
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $64
; indirect data load target
.byte $27
; indirect data load target
.byte $68
; indirect data load target
.byte $94
; indirect data load target
.byte $81
; indirect data load target
.byte $64
; indirect data load target
.byte $42
; indirect data load target
.byte $64
; indirect data load target
.byte $92
; indirect data load target
.byte $67
; indirect data load target
.byte $27
; indirect data load target
.byte $65
; indirect data load target
.byte $24
; indirect data load target
.byte $85
; indirect data load target
.byte $23
; indirect data load target
.byte $81
; indirect data load target
.byte $23
; indirect data load target
.byte $63
; indirect data load target
.byte $A5
; indirect data load target
.byte $93
; indirect data load target
.byte $EB
; indirect data load target
.byte $A6
; indirect data load target
.byte $67
; indirect data load target
.byte $83
; indirect data load target
.byte $23
; indirect data load target
.byte $62
; indirect data load target
.byte $84
; indirect data load target
.byte $63
; indirect data load target
.byte $43
; indirect data load target
.byte $69
; indirect data load target
.byte $C2
; indirect data load target
.byte $84
; indirect data load target
.byte $25
; indirect data load target
.byte $6C
; indirect data load target
.byte $A1
; indirect data load target
.byte $21
; indirect data load target
.byte $82
; indirect data load target
.byte $A3
; indirect data load target
.byte $E3
; indirect data load target
.byte $A3
; indirect data load target
.byte $62
; indirect data load target
.byte $26
; indirect data load target
.byte $69
; indirect data load target
.byte $95
; indirect data load target
.byte $81
; indirect data load target
.byte $63
; indirect data load target
.byte $44
; indirect data load target
.byte $64
; indirect data load target
.byte $91
; indirect data load target
.byte $6B
; indirect data load target
.byte $E4
; indirect data load target
.byte $62
; indirect data load target
.byte $27
; indirect data load target
.byte $83
; indirect data load target
.byte $61
; indirect data load target
.byte $22
; indirect data load target
.byte $82
; indirect data load target
.byte $21
; indirect data load target
.byte $A6
; indirect data load target
.byte $64
; indirect data load target
.byte $92
; indirect data load target
.byte $ED
; indirect data load target
.byte $A3
; indirect data load target
.byte $67
; indirect data load target
.byte $84
; indirect data load target
.byte $22
; indirect data load target
.byte $62
; indirect data load target
.byte $84
; indirect data load target
.byte $64
; indirect data load target
.byte $42
; indirect data load target
.byte $6A
; indirect data load target
.byte $C3
; indirect data load target
.byte $82
; indirect data load target
.byte $29
; indirect data load target
.byte $6A
; indirect data load target
.byte $24
; indirect data load target
.byte $A1
; indirect data load target
.byte $E7
; indirect data load target
.byte $A3
; indirect data load target
.byte $62
; indirect data load target
.byte $26
; indirect data load target
.byte $68
; indirect data load target
.byte $95
; indirect data load target
.byte $81
; indirect data load target
.byte $62
; indirect data load target
.byte $44
; indirect data load target
.byte $62
; indirect data load target
.byte $A3
; indirect data load target
.byte $90
; indirect data load target
.byte $6C
; indirect data load target
.byte $E5
; indirect data load target
.byte $29
; indirect data load target
.byte $81
; indirect data load target
.byte $63
; indirect data load target
.byte $21
; indirect data load target
.byte $82
; indirect data load target
.byte $22
; indirect data load target
.byte $A3
; indirect data load target
.byte $43
; indirect data load target
.byte $63
; indirect data load target
.byte $92
; indirect data load target
.byte $F2
; indirect data load target
.byte $65
; indirect data load target
.byte $85
; indirect data load target
.byte $64
; indirect data load target
.byte $83
; indirect data load target
.byte $66
; indirect data load target
.byte $42
; indirect data load target
.byte $6A
; indirect data load target
.byte $31
; indirect data load target
.byte $66
; indirect data load target
.byte $26
; indirect data load target
.byte $EA
; indirect data load target
.byte $A4
; indirect data load target
.byte $61
; indirect data load target
.byte $26
; indirect data load target
.byte $66
; indirect data load target
.byte $96
; indirect data load target
.byte $80
; indirect data load target
.byte $64
; indirect data load target
.byte $42
; indirect data load target
.byte $61
; indirect data load target
.byte $A7
; indirect data load target
.byte $8F
; indirect data load target
.byte $6C
; indirect data load target
.byte $E3
; indirect data load target
.byte $25
; indirect data load target
.byte $A2
; indirect data load target
.byte $E2
; indirect data load target
.byte $63
; indirect data load target
.byte $22
; indirect data load target
.byte $81
; indirect data load target
.byte $25
; indirect data load target
.byte $46
; indirect data load target
.byte $62
; indirect data load target
.byte $94
; indirect data load target
.byte $EB
; indirect data load target
.byte $81
; indirect data load target
.byte $E4
; indirect data load target
.byte $63
; indirect data load target
.byte $85
; indirect data load target
.byte $64
; indirect data load target
.byte $84
; indirect data load target
.byte $65
; indirect data load target
.byte $44
; indirect data load target
.byte $66
; indirect data load target
.byte $34
; indirect data load target
.byte $63
; indirect data load target
.byte $29
; indirect data load target
.byte $EA
; indirect data load target
.byte $A5
; indirect data load target
.byte $26
; indirect data load target
.byte $66
; indirect data load target
.byte $96
; indirect data load target
.byte $80
; indirect data load target
.byte $68
; indirect data load target
.byte $A1
; indirect data load target
.byte $E2
; indirect data load target
.byte $A5
; indirect data load target
.byte $8D
; indirect data load target
.byte $6B
; indirect data load target
.byte $83
; indirect data load target
.byte $23
; indirect data load target
.byte $A4
; indirect data load target
.byte $E4
; indirect data load target
.byte $62
; indirect data load target
.byte $23
; indirect data load target
.byte $09
; indirect data load target
.byte $26
; indirect data load target
.byte $44
; indirect data load target
.byte $63
; indirect data load target
.byte $95
; indirect data load target
.byte $E9
; indirect data load target
.byte $83
; indirect data load target
.byte $E6
; indirect data load target
.byte $85
; indirect data load target
.byte $63
; indirect data load target
.byte $87
; indirect data load target
.byte $65
; indirect data load target
.byte $42
; indirect data load target
.byte $64
; indirect data load target
.byte $3F
; indirect data load target
.byte $26
; indirect data load target
.byte $EB
; indirect data load target
.byte $A4
; indirect data load target
.byte $25
; indirect data load target
.byte $65
; indirect data load target
.byte $97
; indirect data load target
.byte $80
; indirect data load target
.byte $63
; indirect data load target
.byte $A3
; indirect data load target
.byte $61
; indirect data load target
.byte $E5
; indirect data load target
.byte $A4
; indirect data load target
.byte $8D
; indirect data load target
.byte $61
; indirect data load target
.byte $83
; indirect data load target
.byte $62
; indirect data load target
.byte $85
; indirect data load target
.byte $22
; indirect data load target
.byte $A6
; indirect data load target
.byte $E4
; indirect data load target
.byte $61
; indirect data load target
.byte $21
; indirect data load target
.byte $82
; indirect data load target
.byte $21
; indirect data load target
.byte $A3
; indirect data load target
.byte $68
; indirect data load target
.byte $97
; indirect data load target
.byte $E7
; indirect data load target
.byte $85
; indirect data load target
.byte $E5
; indirect data load target
.byte $85
; indirect data load target
.byte $63
; indirect data load target
.byte $87
; indirect data load target
.byte $6B
; indirect data load target
.byte $3F
; indirect data load target
.byte $2A
; indirect data load target
.byte $EA
; indirect data load target
.byte $A4
; indirect data load target
.byte $23
; indirect data load target
.byte $66
; indirect data load target
.byte $97
; indirect data load target
.byte $80
; indirect data load target
.byte $65
; indirect data load target
.byte $A2
; indirect data load target
.byte $E8
; indirect data load target
.byte $A4
; indirect data load target
.byte $91
; indirect data load target
.byte $61
; indirect data load target
.byte $84
; indirect data load target
.byte $23
; indirect data load target
.byte $A2
; indirect data load target
.byte $E1
; indirect data load target
.byte $A6
; indirect data load target
.byte $E2
; indirect data load target
.byte $20
; indirect data load target
.byte $81
; indirect data load target
.byte $62
; indirect data load target
.byte $A5
; indirect data load target
.byte $67
; indirect data load target
.byte $99
; indirect data load target
.byte $E4
; indirect data load target
.byte $86
; indirect data load target
.byte $E4
; indirect data load target
.byte $85
; indirect data load target
.byte $21
; indirect data load target
.byte $62
; indirect data load target
.byte $88
; indirect data load target
.byte $67
; indirect data load target
.byte $33
; indirect data load target
.byte $63
; indirect data load target
.byte $37
; indirect data load target
.byte $E8
; indirect data load target
.byte $A5
; indirect data load target
.byte $69
; indirect data load target
.byte $97
; indirect data load target
.byte $81
; indirect data load target
.byte $65
; indirect data load target
.byte $A1
; indirect data load target
.byte $EA
; indirect data load target
.byte $A3
; indirect data load target
.byte $8D
; indirect data load target
.byte $61
; indirect data load target
.byte $09
; indirect data load target
.byte $60
; indirect data load target
.byte $84
; indirect data load target
.byte $24
; indirect data load target
.byte $E7
; indirect data load target
.byte $A5
; indirect data load target
.byte $E1
; indirect data load target
.byte $63
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $A6
; indirect data load target
.byte $61
; indirect data load target
.byte $9B
; indirect data load target
.byte $E3
; indirect data load target
.byte $86
; indirect data load target
.byte $E4
; indirect data load target
.byte $86
; indirect data load target
.byte $21
; indirect data load target
.byte $62
; indirect data load target
.byte $89
; indirect data load target
.byte $65
; indirect data load target
.byte $33
; indirect data load target
.byte $66
; indirect data load target
.byte $2C
; indirect data load target
.byte $61
; indirect data load target
.byte $26
; indirect data load target
.byte $C1
; indirect data load target
.byte $E8
; indirect data load target
.byte $A2
; indirect data load target
.byte $69
; indirect data load target
.byte $98
; indirect data load target
.byte $81
; indirect data load target
.byte $62
; indirect data load target
.byte $0B
; indirect data load target
.byte $60
; indirect data load target
.byte $A3
; indirect data load target
.byte $EB
; indirect data load target
.byte $A2
; indirect data load target
.byte $8B
; indirect data load target
.byte $62
; indirect data load target
.byte $85
; indirect data load target
.byte $25
; indirect data load target
.byte $63
; indirect data load target
.byte $E4
; indirect data load target
.byte $A2
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $65
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $A5
; indirect data load target
.byte $9D
; indirect data load target
.byte $E2
; indirect data load target
.byte $84
; indirect data load target
.byte $E6
; indirect data load target
.byte $85
; indirect data load target
.byte $21
; indirect data load target
.byte $62
; indirect data load target
.byte $8A
; indirect data load target
.byte $64
; indirect data load target
.byte $2B
; indirect data load target
.byte $A4
; indirect data load target
.byte $22
; indirect data load target
.byte $69
; indirect data load target
.byte $29
; indirect data load target
.byte $61
; indirect data load target
.byte $26
; indirect data load target
.byte $C3
; indirect data load target
.byte $E7
; indirect data load target
.byte $A2
; indirect data load target
.byte $69
; indirect data load target
.byte $98
; indirect data load target
.byte $82
; indirect data load target
.byte $60
; indirect data load target
.byte $A4
; indirect data load target
.byte $E4
; indirect data load target
.byte $C1
; indirect data load target
.byte $EA
; indirect data load target
.byte $89
; indirect data load target
.byte $63
; indirect data load target
.byte $85
; indirect data load target
.byte $61
; indirect data load target
.byte $27
; indirect data load target
.byte $00
; indirect data load target
.byte $12
; indirect data load target
.byte $21
; indirect data load target
.byte $87
; indirect data load target
.byte $65
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $A1
; indirect data load target
.byte $9F
; indirect data load target
.byte $80
; indirect data load target
.byte $E3
; indirect data load target
.byte $81
; indirect data load target
.byte $E6
; indirect data load target
.byte $86
; indirect data load target
.byte $21
; indirect data load target
.byte $62
; indirect data load target
.byte $8A
; indirect data load target
.byte $63
; indirect data load target
.byte $2B
; indirect data load target
.byte $A7
; indirect data load target
.byte $61
; indirect data load target
.byte $E3
; indirect data load target
.byte $66
; indirect data load target
.byte $2F
; indirect data load target
.byte $C4
; indirect data load target
.byte $E6
; indirect data load target
.byte $A2
; indirect data load target
.byte $67
; indirect data load target
.byte $22
; indirect data load target
.byte $98
; indirect data load target
.byte $82
; indirect data load target
.byte $A4
; indirect data load target
.byte $E4
; indirect data load target
.byte $C3
; indirect data load target
.byte $EA
; indirect data load target
.byte $88
; indirect data load target
.byte $6B
; indirect data load target
.byte $27
; indirect data load target
.byte $10
; indirect data load target
.byte $11
; indirect data load target
.byte $20
; indirect data load target
.byte $89
; indirect data load target
.byte $62
; indirect data load target
.byte $83
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $0C
; indirect data load target
.byte $08
; indirect data load target
.byte $9F
; indirect data load target
.byte $89
; indirect data load target
.byte $E4
; indirect data load target
.byte $86
; indirect data load target
.byte $23
; indirect data load target
.byte $63
; indirect data load target
.byte $89
; indirect data load target
.byte $63
; indirect data load target
.byte $29
; indirect data load target
.byte $44
; indirect data load target
.byte $A4
; indirect data load target
.byte $E5
; indirect data load target
.byte $67
; indirect data load target
.byte $2D
; indirect data load target
.byte $C5
; indirect data load target
.byte $E5
; indirect data load target
.byte $A1
; indirect data load target
.byte $67
; indirect data load target
.byte $24
; indirect data load target
.byte $97
; indirect data load target
.byte $82
; indirect data load target
.byte $A2
; indirect data load target
.byte $E4
; indirect data load target
.byte $24
; indirect data load target
.byte $C2
; indirect data load target
.byte $E8
; indirect data load target
.byte $8A
; indirect data load target
.byte $64
; indirect data load target
.byte $A3
; indirect data load target
.byte $62
; indirect data load target
.byte $27
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $8A
; indirect data load target
.byte $23
; indirect data load target
.byte $64
; indirect data load target
.byte $89
; indirect data load target
.byte $63
; indirect data load target
.byte $2A
; indirect data load target
.byte $45
; indirect data load target
.byte $A3
; indirect data load target
.byte $E5
; indirect data load target
.byte $69
; indirect data load target
.byte $2B
; indirect data load target
.byte $C4
; indirect data load target
.byte $E4
; indirect data load target
.byte $A2
; indirect data load target
.byte $66
; indirect data load target
.byte $25
; indirect data load target
.byte $97
; indirect data load target
.byte $82
; indirect data load target
.byte $E6
; indirect data load target
.byte $26
; indirect data load target
.byte $C2
; indirect data load target
.byte $E8
; indirect data load target
.byte $8A
; indirect data load target
.byte $62
; indirect data load target
.byte $23
; indirect data load target
.byte $A4
; indirect data load target
.byte $E3
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $8C
; indirect data load target
.byte $23
; indirect data load target
.byte $66
; indirect data load target
.byte $87
; indirect data load target
.byte $66
; indirect data load target
.byte $29
; indirect data load target
.byte $44
; indirect data load target
.byte $A3
; indirect data load target
.byte $E5
; indirect data load target
.byte $68
; indirect data load target
.byte $C3
; indirect data load target
.byte $29
; indirect data load target
.byte $C1
; indirect data load target
.byte $E7
; indirect data load target
.byte $A2
; indirect data load target
.byte $65
; indirect data load target
.byte $25
; indirect data load target
.byte $97
; indirect data load target
.byte $82
; indirect data load target
.byte $E4
; indirect data load target
.byte $2A
; indirect data load target
.byte $C1
; indirect data load target
.byte $E7
; indirect data load target
.byte $8A
; indirect data load target
.byte $61
; indirect data load target
.byte $23
; indirect data load target
.byte $62
; indirect data load target
.byte $A3
; indirect data load target
.byte $E1
; indirect data load target
.byte $85
; indirect data load target
.byte $A3
; indirect data load target
.byte $8A
; indirect data load target
.byte $61
; indirect data load target
.byte $08
; indirect data load target
.byte $0C
; indirect data load target
.byte $08
; indirect data load target
.byte $9F
; indirect data load target
.byte $93
; indirect data load target
.byte $23
; indirect data load target
.byte $66
; indirect data load target
.byte $87
; indirect data load target
.byte $67
; indirect data load target
.byte $28
; indirect data load target
.byte $45
; indirect data load target
.byte $A3
; indirect data load target
.byte $E4
; indirect data load target
.byte $66
; indirect data load target
.byte $C6
; indirect data load target
.byte $2A
; indirect data load target
.byte $E8
; indirect data load target
.byte $A2
; indirect data load target
.byte $64
; indirect data load target
.byte $24
; indirect data load target
.byte $98
; indirect data load target
.byte $83
; indirect data load target
.byte $E2
; indirect data load target
.byte $2C
; indirect data load target
.byte $C1
; indirect data load target
.byte $E7
; indirect data load target
.byte $88
; indirect data load target
.byte $25
; indirect data load target
.byte $61
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $A4
; indirect data load target
.byte $82
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $A1
; indirect data load target
.byte $42
; indirect data load target
.byte $09
; indirect data load target
.byte $42
; indirect data load target
.byte $81
; indirect data load target
.byte $41
; indirect data load target
.byte $62
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $E0
; indirect data load target
.byte $81
; indirect data load target
.byte $E1
; indirect data load target
.byte $9F
; indirect data load target
.byte $8F
; indirect data load target
.byte $23
; indirect data load target
.byte $65
; indirect data load target
.byte $88
; indirect data load target
.byte $69
; indirect data load target
.byte $27
; indirect data load target
.byte $44
; indirect data load target
.byte $A2
; indirect data load target
.byte $E3
; indirect data load target
.byte $65
; indirect data load target
.byte $C9
; indirect data load target
.byte $28
; indirect data load target
.byte $E9
; indirect data load target
.byte $A2
; indirect data load target
.byte $63
; indirect data load target
.byte $25
; indirect data load target
.byte $98
; indirect data load target
.byte $83
; indirect data load target
.byte $E2
; indirect data load target
.byte $2F
; indirect data load target
.byte $E6
; indirect data load target
.byte $87
; indirect data load target
.byte $26
; indirect data load target
.byte $61
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $A3
; indirect data load target
.byte $82
; indirect data load target
.byte $08
; indirect data load target
.byte $00
; indirect data load target
.byte $12
; indirect data load target
.byte $08
; indirect data load target
.byte $A1
; indirect data load target
.byte $E1
; indirect data load target
.byte $82
; indirect data load target
.byte $45
; indirect data load target
.byte $63
; indirect data load target
.byte $E6
; indirect data load target
.byte $9F
; indirect data load target
.byte $8F
; indirect data load target
.byte $23
; indirect data load target
.byte $64
; indirect data load target
.byte $89
; indirect data load target
.byte $69
; indirect data load target
.byte $23
; indirect data load target
.byte $0E
; indirect data load target
.byte $0F
; indirect data load target
.byte $22
; indirect data load target
.byte $43
; indirect data load target
.byte $A2
; indirect data load target
.byte $E2
; indirect data load target
.byte $64
; indirect data load target
.byte $C5
; indirect data load target
.byte $44
; indirect data load target
.byte $C3
; indirect data load target
.byte $26
; indirect data load target
.byte $E8
; indirect data load target
.byte $A3
; indirect data load target
.byte $61
; indirect data load target
.byte $25
; indirect data load target
.byte $61
; indirect data load target
.byte $97
; indirect data load target
.byte $83
; indirect data load target
.byte $E1
; indirect data load target
.byte $32
; indirect data load target
.byte $E4
; indirect data load target
.byte $87
; indirect data load target
.byte $25
; indirect data load target
.byte $63
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $A4
; indirect data load target
.byte $82
; indirect data load target
.byte $08
; indirect data load target
.byte $10
; indirect data load target
.byte $11
; indirect data load target
.byte $08
; indirect data load target
.byte $A1
; indirect data load target
.byte $E1
; indirect data load target
.byte $83
; indirect data load target
.byte $45
; indirect data load target
.byte $63
; indirect data load target
.byte $E2
; indirect data load target
.byte $63
; indirect data load target
.byte $9F
; indirect data load target
.byte $8D
; indirect data load target
.byte $23
; indirect data load target
.byte $E1
; indirect data load target
.byte $63
; indirect data load target
.byte $80
; indirect data load target
.byte $60
; indirect data load target
.byte $8B
; indirect data load target
.byte $66
; indirect data load target
.byte $27
; indirect data load target
.byte $42
; indirect data load target
.byte $A1
; indirect data load target
.byte $68
; indirect data load target
.byte $C5
; indirect data load target
.byte $46
; indirect data load target
.byte $C4
; indirect data load target
.byte $25
; indirect data load target
.byte $E8
; indirect data load target
.byte $A4
; indirect data load target
.byte $24
; indirect data load target
.byte $63
; indirect data load target
.byte $96
; indirect data load target
.byte $83
; indirect data load target
.byte $E1
; indirect data load target
.byte $37
; indirect data load target
.byte $88
; indirect data load target
.byte $6B
; indirect data load target
.byte $A3
; indirect data load target
.byte $82
; indirect data load target
.byte $A2
; indirect data load target
.byte $40
; indirect data load target
.byte $A1
; indirect data load target
.byte $E1
; indirect data load target
.byte $85
; indirect data load target
.byte $44
; indirect data load target
.byte $63
; indirect data load target
.byte $E0
; indirect data load target
.byte $64
; indirect data load target
.byte $9F
; indirect data load target
.byte $8D
; indirect data load target
.byte $22
; indirect data load target
.byte $E3
; indirect data load target
.byte $62
; indirect data load target
.byte $80
; indirect data load target
.byte $60
; indirect data load target
.byte $8E
; indirect data load target
.byte $65
; indirect data load target
.byte $24
; indirect data load target
.byte $64
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $65
; indirect data load target
.byte $C6
; indirect data load target
.byte $48
; indirect data load target
.byte $C4
; indirect data load target
.byte $28
; indirect data load target
.byte $E4
; indirect data load target
.byte $A5
; indirect data load target
.byte $21
; indirect data load target
.byte $65
; indirect data load target
.byte $96
; indirect data load target
.byte $83
; indirect data load target
.byte $E1
; indirect data load target
.byte $27
; indirect data load target
.byte $62
; indirect data load target
.byte $2D
; indirect data load target
.byte $87
; indirect data load target
.byte $69
; indirect data load target
.byte $A3
; indirect data load target
.byte $84
; indirect data load target
.byte $A0
; indirect data load target
.byte $42
; indirect data load target
.byte $A0
; indirect data load target
.byte $E2
; indirect data load target
.byte $86
; indirect data load target
.byte $23
; indirect data load target
.byte $6A
; indirect data load target
.byte $9F
; indirect data load target
.byte $8B
; indirect data load target
.byte $23
; indirect data load target
.byte $E2
; indirect data load target
.byte $62
; indirect data load target
.byte $81
; indirect data load target
.byte $60
; indirect data load target
.byte $90
; indirect data load target
.byte $6C
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $64
; indirect data load target
.byte $C5
; indirect data load target
.byte $48
; indirect data load target
.byte $C6
; indirect data load target
.byte $29
; indirect data load target
.byte $E3
; indirect data load target
.byte $A2
; indirect data load target
.byte $68
; indirect data load target
.byte $97
; indirect data load target
.byte $83
; indirect data load target
.byte $E1
; indirect data load target
.byte $26
; indirect data load target
.byte $65
; indirect data load target
.byte $2B
; indirect data load target
.byte $86
; indirect data load target
.byte $68
; indirect data load target
.byte $25
; indirect data load target
.byte $84
; indirect data load target
.byte $A0
; indirect data load target
.byte $41
; indirect data load target
.byte $A1
; indirect data load target
.byte $E1
; indirect data load target
.byte $87
; indirect data load target
.byte $23
; indirect data load target
.byte $A4
; indirect data load target
.byte $43
; indirect data load target
.byte $61
; indirect data load target
.byte $9F
; indirect data load target
.byte $8B
; indirect data load target
.byte $22
; indirect data load target
.byte $E4
; indirect data load target
.byte $61
; indirect data load target
.byte $80
; indirect data load target
.byte $62
; indirect data load target
.byte $8F
; indirect data load target
.byte $6C
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $64
; indirect data load target
.byte $C1
; indirect data load target
.byte $48
; indirect data load target
.byte $81
; indirect data load target
.byte $C8
; indirect data load target
.byte $29
; indirect data load target
.byte $E1
; indirect data load target
.byte $A2
; indirect data load target
.byte $69
; indirect data load target
.byte $97
; indirect data load target
.byte $83
; indirect data load target
.byte $E2
; indirect data load target
.byte $24
; indirect data load target
.byte $68
; indirect data load target
.byte $26
; indirect data load target
.byte $0E
; indirect data load target
.byte $0F
; indirect data load target
.byte $20
; indirect data load target
.byte $86
; indirect data load target
.byte $66
; indirect data load target
.byte $25
; indirect data load target
.byte $87
; indirect data load target
.byte $A0
; indirect data load target
.byte $42
; indirect data load target
.byte $E1
; indirect data load target
.byte $86
; indirect data load target
.byte $23
; indirect data load target
.byte $A7
; indirect data load target
.byte $42
; indirect data load target
.byte $60
; indirect data load target
.byte $9F
; indirect data load target
.byte $8A
; indirect data load target
.byte $23
; indirect data load target
.byte $E4
; indirect data load target
.byte $61
; indirect data load target
.byte $80
; indirect data load target
.byte $63
; indirect data load target
.byte $8F
; indirect data load target
.byte $65
; indirect data load target
.byte $82
; indirect data load target
.byte $63
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $66
; indirect data load target
.byte $47
; indirect data load target
.byte $83
; indirect data load target
.byte $C9
; indirect data load target
.byte $29
; indirect data load target
.byte $A2
; indirect data load target
.byte $69
; indirect data load target
.byte $98
; indirect data load target
.byte $84
; indirect data load target
.byte $E1
; indirect data load target
.byte $23
; indirect data load target
.byte $6C
; indirect data load target
.byte $25
; indirect data load target
.byte $88
; indirect data load target
.byte $64
; indirect data load target
.byte $26
; indirect data load target
.byte $87
; indirect data load target
.byte $A1
; indirect data load target
.byte $41
; indirect data load target
.byte $E1
; indirect data load target
.byte $85
; indirect data load target
.byte $23
; indirect data load target
.byte $A1
; indirect data load target
.byte $25
; indirect data load target
.byte $A2
; indirect data load target
.byte $61
; indirect data load target
.byte $9F
; indirect data load target
.byte $8A
; indirect data load target
.byte $22
; indirect data load target
.byte $E4
; indirect data load target
.byte $62
; indirect data load target
.byte $80
; indirect data load target
.byte $63
; indirect data load target
.byte $90
; indirect data load target
.byte $64
; indirect data load target
.byte $84
; indirect data load target
.byte $62
; indirect data load target
.byte $08
; indirect data load target
.byte $65
; indirect data load target
.byte $48
; indirect data load target
.byte $84
; indirect data load target
.byte $C5
; indirect data load target
.byte $82
; indirect data load target
.byte $C2
; indirect data load target
.byte $27
; indirect data load target
.byte $A1
; indirect data load target
.byte $6A
; indirect data load target
.byte $98
; indirect data load target
.byte $84
; indirect data load target
.byte $E2
; indirect data load target
.byte $22
; indirect data load target
.byte $71
; indirect data load target
.byte $8E
; indirect data load target
.byte $25
; indirect data load target
.byte $89
; indirect data load target
.byte $A0
; indirect data load target
.byte $42
; indirect data load target
.byte $A0
; indirect data load target
.byte $85
; indirect data load target
.byte $62
; indirect data load target
.byte $23
; indirect data load target
.byte $13
; indirect data load target
.byte $13
; indirect data load target
.byte $13
; indirect data load target
.byte $22
; indirect data load target
.byte $A1
; indirect data load target
.byte $61
; indirect data load target
.byte $9F
; indirect data load target
.byte $8B
; indirect data load target
.byte $22
; indirect data load target
.byte $E6
; indirect data load target
.byte $80
; indirect data load target
.byte $63
; indirect data load target
.byte $91
; indirect data load target
.byte $64
; indirect data load target
.byte $84
; indirect data load target
.byte $67
; indirect data load target
.byte $47
; indirect data load target
.byte $85
; indirect data load target
.byte $C4
; indirect data load target
.byte $86
; indirect data load target
.byte $C1
; indirect data load target
.byte $27
; indirect data load target
.byte $A1
; indirect data load target
.byte $6A
; indirect data load target
.byte $97
; indirect data load target
.byte $84
; indirect data load target
.byte $E2
; indirect data load target
.byte $23
; indirect data load target
.byte $6F
; indirect data load target
.byte $8A
; indirect data load target
.byte $E1
; indirect data load target
.byte $21
; indirect data load target
.byte $09
; indirect data load target
.byte $62
; indirect data load target
.byte $21
; indirect data load target
.byte $8A
; indirect data load target
.byte $A1
; indirect data load target
.byte $41
; indirect data load target
.byte $A0
; indirect data load target
.byte $85
; indirect data load target
.byte $65
; indirect data load target
.byte $13
; indirect data load target
.byte $22
; indirect data load target
.byte $13
; indirect data load target
.byte $21
; indirect data load target
.byte $A1
; indirect data load target
.byte $61
; indirect data load target
.byte $9F
; indirect data load target
.byte $8B
; indirect data load target
.byte $21
; indirect data load target
.byte $E5
; indirect data load target
.byte $83
; indirect data load target
.byte $62
; indirect data load target
.byte $92
; indirect data load target
.byte $65
; indirect data load target
.byte $83
; indirect data load target
.byte $65
; indirect data load target
.byte $48
; indirect data load target
.byte $85
; indirect data load target
.byte $C4
; indirect data load target
.byte $88
; indirect data load target
.byte $21
; indirect data load target
.byte $00
; indirect data load target
.byte $12
; indirect data load target
.byte $24
; indirect data load target
.byte $A1
; indirect data load target
.byte $69
; indirect data load target
.byte $97
; indirect data load target
.byte $84
; indirect data load target
.byte $E3
; indirect data load target
.byte $23
; indirect data load target
.byte $6C
; indirect data load target
.byte $8A
; indirect data load target
.byte $E2
; indirect data load target
.byte $22
; indirect data load target
.byte $82
; indirect data load target
.byte $A1
; indirect data load target
.byte $8C
; indirect data load target
.byte $A2
; indirect data load target
.byte $87
; indirect data load target
.byte $64
; indirect data load target
.byte $13
; indirect data load target
.byte $20
; indirect data load target
.byte $60
; indirect data load target
.byte $20
; indirect data load target
.byte $40
; indirect data load target
.byte $21
; indirect data load target
.byte $A1
; indirect data load target
.byte $60
; indirect data load target
.byte $9F
; indirect data load target
.byte $8C
; indirect data load target
.byte $21
; indirect data load target
.byte $E5
; indirect data load target
.byte $80
; indirect data load target
.byte $61
; indirect data load target
.byte $80
; indirect data load target
.byte $61
; indirect data load target
.byte $94
; indirect data load target
.byte $64
; indirect data load target
.byte $84
; indirect data load target
.byte $62
; indirect data load target
.byte $49
; indirect data load target
.byte $85
; indirect data load target
.byte $C2
; indirect data load target
.byte $8C
; indirect data load target
.byte $20
; indirect data load target
.byte $10
; indirect data load target
.byte $11
; indirect data load target
.byte $24
; indirect data load target
.byte $A1
; indirect data load target
.byte $69
; indirect data load target
.byte $97
; indirect data load target
.byte $84
; indirect data load target
.byte $E3
; indirect data load target
.byte $24
; indirect data load target
.byte $63
; indirect data load target
.byte $81
; indirect data load target
.byte $64
; indirect data load target
.byte $8A
; indirect data load target
.byte $E2
; indirect data load target
.byte $22
; indirect data load target
.byte $62
; indirect data load target
.byte $A2
; indirect data load target
.byte $8C
; indirect data load target
.byte $A1
; indirect data load target
.byte $88
; indirect data load target
.byte $64
; indirect data load target
.byte $13
; indirect data load target
.byte $22
; indirect data load target
.byte $13
; indirect data load target
.byte $20
; indirect data load target
.byte $A1
; indirect data load target
.byte $61
; indirect data load target
.byte $9F
; indirect data load target
.byte $8B
; indirect data load target
.byte $22
; indirect data load target
.byte $E4
; indirect data load target
.byte $81
; indirect data load target
.byte $61
; indirect data load target
.byte $80
; indirect data load target
.byte $61
; indirect data load target
.byte $97
; indirect data load target
.byte $64
; indirect data load target
.byte $83
; indirect data load target
.byte $49
; indirect data load target
.byte $85
; indirect data load target
.byte $C3
; indirect data load target
.byte $8D
; indirect data load target
.byte $26
; indirect data load target
.byte $A2
; indirect data load target
.byte $68
; indirect data load target
.byte $97
; indirect data load target
.byte $85
; indirect data load target
.byte $E3
; indirect data load target
.byte $23
; indirect data load target
.byte $62
; indirect data load target
.byte $92
; indirect data load target
.byte $E1
; indirect data load target
.byte $22
; indirect data load target
.byte $62
; indirect data load target
.byte $41
; indirect data load target
.byte $A2
; indirect data load target
.byte $97
; indirect data load target
.byte $64
; indirect data load target
.byte $13
; indirect data load target
.byte $13
; indirect data load target
.byte $13
; indirect data load target
.byte $A2
; indirect data load target
.byte $61
; indirect data load target
.byte $9F
; indirect data load target
.byte $8B
; indirect data load target
.byte $22
; indirect data load target
.byte $E5
; indirect data load target
.byte $80
; indirect data load target
.byte $62
; indirect data load target
.byte $80
; indirect data load target
.byte $60
; indirect data load target
.byte $9F
; indirect data load target
.byte $83
; indirect data load target
.byte $46
; indirect data load target
.byte $85
; indirect data load target
.byte $C2
; indirect data load target
.byte $90
; indirect data load target
.byte $24
; indirect data load target
.byte $A3
; indirect data load target
.byte $68
; indirect data load target
.byte $97
; indirect data load target
.byte $86
; indirect data load target
.byte $E3
; indirect data load target
.byte $23
; indirect data load target
.byte $61
; indirect data load target
.byte $91
; indirect data load target
.byte $E2
; indirect data load target
.byte $22
; indirect data load target
.byte $61
; indirect data load target
.byte $43
; indirect data load target
.byte $A1
; indirect data load target
.byte $97
; indirect data load target
.byte $61
; indirect data load target
.byte $A7
; indirect data load target
.byte $61
; indirect data load target
.byte $9F
; indirect data load target
.byte $8B
; indirect data load target
.byte $23
; indirect data load target
.byte $E5
; indirect data load target
.byte $80
; indirect data load target
.byte $62
; indirect data load target
.byte $80
; indirect data load target
.byte $60
; indirect data load target
.byte $9F
; indirect data load target
.byte $84
; indirect data load target
.byte $43
; indirect data load target
.byte $87
; indirect data load target
.byte $C1
; indirect data load target
.byte $91
; indirect data load target
.byte $23
; indirect data load target
.byte $A4
; indirect data load target
.byte $67
; indirect data load target
.byte $98
; indirect data load target
.byte $86
; indirect data load target
.byte $E3
; indirect data load target
.byte $23
; indirect data load target
.byte $63
; indirect data load target
.byte $8F
; indirect data load target
.byte $E7
; indirect data load target
.byte $43
; indirect data load target
.byte $A1
; indirect data load target
.byte $96
; indirect data load target
.byte $63
; indirect data load target
.byte $A5
; indirect data load target
.byte $62
; indirect data load target
.byte $9F
; indirect data load target
.byte $8B
; indirect data load target
.byte $24
; indirect data load target
.byte $E4
; indirect data load target
.byte $80
; indirect data load target
.byte $62
; indirect data load target
.byte $80
; indirect data load target
.byte $60
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $85
; indirect data load target
.byte $21
; indirect data load target
.byte $A4
; indirect data load target
.byte $68
; indirect data load target
.byte $98
; indirect data load target
.byte $86
; indirect data load target
.byte $E3
; indirect data load target
.byte $22
; indirect data load target
.byte $65
; indirect data load target
.byte $8D
; indirect data load target
.byte $E6
; indirect data load target
.byte $44
; indirect data load target
.byte $83
; indirect data load target
.byte $61
; indirect data load target
.byte $82
; indirect data load target
.byte $A9
; indirect data load target
.byte $86
; indirect data load target
.byte $62
; indirect data load target
.byte $A3
; indirect data load target
.byte $E1
; indirect data load target
.byte $62
; indirect data load target
.byte $9F
; indirect data load target
.byte $8C
; indirect data load target
.byte $23
; indirect data load target
.byte $E5
; indirect data load target
.byte $80
; indirect data load target
.byte $62
; indirect data load target
.byte $80
; indirect data load target
.byte $61
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $84
; indirect data load target
.byte $22
; indirect data load target
.byte $A4
; indirect data load target
.byte $67
; indirect data load target
.byte $98
; indirect data load target
.byte $86
; indirect data load target
.byte $E4
; indirect data load target
.byte $22
; indirect data load target
.byte $63
; indirect data load target
.byte $8E
; indirect data load target
.byte $E2
; indirect data load target
.byte $48
; indirect data load target
.byte $82
; indirect data load target
.byte $64
; indirect data load target
.byte $A1
; indirect data load target
.byte $47
; indirect data load target
.byte $A1
; indirect data load target
.byte $85
; indirect data load target
.byte $62
; indirect data load target
.byte $A2
; indirect data load target
.byte $E1
; indirect data load target
.byte $62
; indirect data load target
.byte $9F
; indirect data load target
.byte $8D
; indirect data load target
.byte $23
; indirect data load target
.byte $E5
; indirect data load target
.byte $80
; indirect data load target
.byte $62
; indirect data load target
.byte $09
; indirect data load target
.byte $62
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $83
; indirect data load target
.byte $24
; indirect data load target
.byte $A3
; indirect data load target
.byte $66
; indirect data load target
.byte $98
; indirect data load target
.byte $87
; indirect data load target
.byte $E3
; indirect data load target
.byte $22
; indirect data load target
.byte $91
; indirect data load target
.byte $E4
; indirect data load target
.byte $49
; indirect data load target
.byte $66
; indirect data load target
.byte $A0
; indirect data load target
.byte $40
; indirect data load target
.byte $A5
; indirect data load target
.byte $40
; indirect data load target
.byte $A3
; indirect data load target
.byte $82
; indirect data load target
.byte $62
; indirect data load target
.byte $A2
; indirect data load target
.byte $E1
; indirect data load target
.byte $62
; indirect data load target
.byte $9F
; indirect data load target
.byte $8D
; indirect data load target
.byte $23
; indirect data load target
.byte $E5
; indirect data load target
.byte $A0
; indirect data load target
.byte $80
; indirect data load target
.byte $62
; indirect data load target
.byte $81
; indirect data load target
.byte $62
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $81
; indirect data load target
.byte $24
; indirect data load target
.byte $A3
; indirect data load target
.byte $66
; indirect data load target
.byte $99
; indirect data load target
.byte $87
; indirect data load target
.byte $E3
; indirect data load target
.byte $20
; indirect data load target
.byte $0A
; indirect data load target
.byte $20
; indirect data load target
.byte $80
; indirect data load target
.byte $62
; indirect data load target
.byte $8C
; indirect data load target
.byte $E5
; indirect data load target
.byte $64
; indirect data load target
.byte $45
; indirect data load target
.byte $84
; indirect data load target
.byte $42
; indirect data load target
.byte $A0
; indirect data load target
.byte $43
; indirect data load target
.byte $A0
; indirect data load target
.byte $61
; indirect data load target
.byte $A2
; indirect data load target
.byte $82
; indirect data load target
.byte $61
; indirect data load target
.byte $E6
; indirect data load target
.byte $61
; indirect data load target
.byte $9F
; indirect data load target
.byte $8D
; indirect data load target
.byte $23
; indirect data load target
.byte $E4
; indirect data load target
.byte $A3
; indirect data load target
.byte $62
; indirect data load target
.byte $80
; indirect data load target
.byte $62
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $81
; indirect data load target
.byte $24
; indirect data load target
.byte $A2
; indirect data load target
.byte $67
; indirect data load target
.byte $99
; indirect data load target
.byte $87
; indirect data load target
.byte $E3
; indirect data load target
.byte $21
; indirect data load target
.byte $81
; indirect data load target
.byte $62
; indirect data load target
.byte $8C
; indirect data load target
.byte $E4
; indirect data load target
.byte $69
; indirect data load target
.byte $42
; indirect data load target
.byte $61
; indirect data load target
.byte $E2
; indirect data load target
.byte $A3
; indirect data load target
.byte $40
; indirect data load target
.byte $A1
; indirect data load target
.byte $63
; indirect data load target
.byte $A0
; indirect data load target
.byte $82
; indirect data load target
.byte $62
; indirect data load target
.byte $E6
; indirect data load target
.byte $61
; indirect data load target
.byte $88
; indirect data load target
.byte $62
; indirect data load target
.byte $9F
; indirect data load target
.byte $81
; indirect data load target
.byte $23
; indirect data load target
.byte $E3
; indirect data load target
.byte $A3
; indirect data load target
.byte $63
; indirect data load target
.byte $80
; indirect data load target
.byte $63
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $81
; indirect data load target
.byte $23
; indirect data load target
.byte $A1
; indirect data load target
.byte $68
; indirect data load target
.byte $99
; indirect data load target
.byte $87
; indirect data load target
.byte $E1
; indirect data load target
.byte $84
; indirect data load target
.byte $62
; indirect data load target
.byte $8D
; indirect data load target
.byte $E2
; indirect data load target
.byte $62
; indirect data load target
.byte $A4
; indirect data load target
.byte $64
; indirect data load target
.byte $41
; indirect data load target
.byte $61
; indirect data load target
.byte $E3
; indirect data load target
.byte $A2
; indirect data load target
.byte $43
; indirect data load target
.byte $61
; indirect data load target
.byte $A0
; indirect data load target
.byte $85
; indirect data load target
.byte $62
; indirect data load target
.byte $E4
; indirect data load target
.byte $60
; indirect data load target
.byte $86
; indirect data load target
.byte $64
; indirect data load target
.byte $21
; indirect data load target
.byte $9F
; indirect data load target
.byte $80
; indirect data load target
.byte $24
; indirect data load target
.byte $E0
; indirect data load target
.byte $A4
; indirect data load target
.byte $64
; indirect data load target
.byte $80
; indirect data load target
.byte $A1
; indirect data load target
.byte $62
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $80
; indirect data load target
.byte $22
; indirect data load target
.byte $A2
; indirect data load target
.byte $67
; indirect data load target
.byte $9A
; indirect data load target
.byte $8A
; indirect data load target
.byte $21
; indirect data load target
.byte $64
; indirect data load target
.byte $8D
; indirect data load target
.byte $E3
; indirect data load target
.byte $A8
; indirect data load target
.byte $62
; indirect data load target
.byte $E8
; indirect data load target
.byte $A6
; indirect data load target
.byte $60
; indirect data load target
.byte $A0
; indirect data load target
.byte $85
; indirect data load target
.byte $63
; indirect data load target
.byte $E1
; indirect data load target
.byte $61
; indirect data load target
.byte $88
; indirect data load target
.byte $62
; indirect data load target
.byte $22
; indirect data load target
.byte $9F
; indirect data load target
.byte $25
; indirect data load target
.byte $A3
; indirect data load target
.byte $66
; indirect data load target
.byte $80
; indirect data load target
.byte $A2
; indirect data load target
.byte $61
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $22
; indirect data load target
.byte $A1
; indirect data load target
.byte $65
; indirect data load target
.byte $9E
; indirect data load target
.byte $87
; indirect data load target
.byte $E2
; indirect data load target
.byte $20
; indirect data load target
.byte $0A
; indirect data load target
.byte $64
; indirect data load target
.byte $8D
; indirect data load target
.byte $E4
; indirect data load target
.byte $A2
; indirect data load target
.byte $63
; indirect data load target
.byte $A3
; indirect data load target
.byte $E3
; indirect data load target
.byte $62
; indirect data load target
.byte $21
; indirect data load target
.byte $81
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $21
; indirect data load target
.byte $A1
; indirect data load target
.byte $84
; indirect data load target
.byte $60
; indirect data load target
.byte $83
; indirect data load target
.byte $63
; indirect data load target
.byte $8B
; indirect data load target
.byte $62
; indirect data load target
.byte $21
; indirect data load target
.byte $9E
; indirect data load target
.byte $24
; indirect data load target
.byte $A3
; indirect data load target
.byte $66
; indirect data load target
.byte $81
; indirect data load target
.byte $A2
; indirect data load target
.byte $62
; indirect data load target
.byte $9F
; indirect data load target
.byte $9E
; indirect data load target
.byte $22
; indirect data load target
.byte $A1
; indirect data load target
.byte $63
; indirect data load target
.byte $82
; indirect data load target
.byte $E2
; indirect data load target
.byte $9A
; indirect data load target
.byte $87
; indirect data load target
.byte $E3
; indirect data load target
.byte $22
; indirect data load target
.byte $62
; indirect data load target
.byte $8D
; indirect data load target
.byte $E5
; indirect data load target
.byte $A1
; indirect data load target
.byte $65
; indirect data load target
.byte $A3
; indirect data load target
.byte $E1
; indirect data load target
.byte $62
; indirect data load target
.byte $20
; indirect data load target
.byte $09
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $22
; indirect data load target
.byte $A1
; indirect data load target
.byte $83
; indirect data load target
.byte $64
; indirect data load target
.byte $09
; indirect data load target
.byte $62
; indirect data load target
.byte $8D
; indirect data load target
.byte $61
; indirect data load target
.byte $21
; indirect data load target
.byte $9D
; indirect data load target
.byte $25
; indirect data load target
.byte $A2
; indirect data load target
.byte $67
; indirect data load target
.byte $80
; indirect data load target
.byte $62
; indirect data load target
.byte $A1
; indirect data load target
.byte $62
; indirect data load target
.byte $9F
; indirect data load target
.byte $9C
; indirect data load target
.byte $23
; indirect data load target
.byte $A2
; indirect data load target
.byte $62
; indirect data load target
.byte $09
; indirect data load target
.byte $E3
; indirect data load target
.byte $9B
; indirect data load target
.byte $87
; indirect data load target
.byte $E3
; indirect data load target
.byte $23
; indirect data load target
.byte $61
; indirect data load target
.byte $8D
; indirect data load target
.byte $E3
; indirect data load target
.byte $A2
; indirect data load target
.byte $63
; indirect data load target
.byte $23
; indirect data load target
.byte $A3
; indirect data load target
.byte $63
; indirect data load target
.byte $82
; indirect data load target
.byte $08
; indirect data load target
.byte $22
; indirect data load target
.byte $61
; indirect data load target
.byte $A0
; indirect data load target
.byte $83
; indirect data load target
.byte $60
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $61
; indirect data load target
.byte $91
; indirect data load target
.byte $61
; indirect data load target
.byte $22
; indirect data load target
.byte $9C
; indirect data load target
.byte $24
; indirect data load target
.byte $A2
; indirect data load target
.byte $68
; indirect data load target
.byte $80
; indirect data load target
.byte $63
; indirect data load target
.byte $A2
; indirect data load target
.byte $40
; indirect data load target
.byte $9F
; indirect data load target
.byte $9C
; indirect data load target
.byte $21
; indirect data load target
.byte $82
; indirect data load target
.byte $A1
; indirect data load target
.byte $61
; indirect data load target
.byte $81
; indirect data load target
.byte $E3
; indirect data load target
.byte $9B
; indirect data load target
.byte $88
; indirect data load target
.byte $E2
; indirect data load target
.byte $24
; indirect data load target
.byte $8F
; indirect data load target
.byte $E3
; indirect data load target
.byte $A2
; indirect data load target
.byte $26
; indirect data load target
.byte $E4
; indirect data load target
.byte $61
; indirect data load target
.byte $83
; indirect data load target
.byte $23
; indirect data load target
.byte $61
; indirect data load target
.byte $A0
; indirect data load target
.byte $83
; indirect data load target
.byte $60
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $65
; indirect data load target
.byte $8E
; indirect data load target
.byte $61
; indirect data load target
.byte $21
; indirect data load target
.byte $9B
; indirect data load target
.byte $25
; indirect data load target
.byte $A1
; indirect data load target
.byte $69
; indirect data load target
.byte $80
; indirect data load target
.byte $63
; indirect data load target
.byte $A2
; indirect data load target
.byte $40
; indirect data load target
.byte $9F
; indirect data load target
.byte $9B
; indirect data load target
.byte $22
; indirect data load target
.byte $09
; indirect data load target
.byte $E0
; indirect data load target
.byte $85
; indirect data load target
.byte $E3
; indirect data load target
.byte $9C
; indirect data load target
.byte $88
; indirect data load target
.byte $E3
; indirect data load target
.byte $23
; indirect data load target
.byte $90
; indirect data load target
.byte $E3
; indirect data load target
.byte $A0
; indirect data load target
.byte $27
; indirect data load target
.byte $E3
; indirect data load target
.byte $62
; indirect data load target
.byte $82
; indirect data load target
.byte $22
; indirect data load target
.byte $62
; indirect data load target
.byte $A0
; indirect data load target
.byte $84
; indirect data load target
.byte $61
; indirect data load target
.byte $21
; indirect data load target
.byte $E5
; indirect data load target
.byte $8E
; indirect data load target
.byte $13
; indirect data load target
.byte $22
; indirect data load target
.byte $9A
; indirect data load target
.byte $26
; indirect data load target
.byte $A1
; indirect data load target
.byte $68
; indirect data load target
.byte $80
; indirect data load target
.byte $64
; indirect data load target
.byte $A1
; indirect data load target
.byte $42
; indirect data load target
.byte $9F
; indirect data load target
.byte $9D
; indirect data load target
.byte $E8
; indirect data load target
.byte $C1
; indirect data load target
.byte $9C
; indirect data load target
.byte $89
; indirect data load target
.byte $E2
; indirect data load target
.byte $24
; indirect data load target
.byte $8F
; indirect data load target
.byte $E2
; indirect data load target
.byte $A1
; indirect data load target
.byte $27
; indirect data load target
.byte $E1
; indirect data load target
.byte $A1
; indirect data load target
.byte $61
; indirect data load target
.byte $83
; indirect data load target
.byte $64
; indirect data load target
.byte $A1
; indirect data load target
.byte $85
; indirect data load target
.byte $21
; indirect data load target
.byte $E8
; indirect data load target
.byte $8C
; indirect data load target
.byte $61
; indirect data load target
.byte $22
; indirect data load target
.byte $98
; indirect data load target
.byte $26
; indirect data load target
.byte $A3
; indirect data load target
.byte $66
; indirect data load target
.byte $81
; indirect data load target
.byte $64
; indirect data load target
.byte $A3
; indirect data load target
.byte $40
; indirect data load target
.byte $9F
; indirect data load target
.byte $99
; indirect data load target
.byte $63
; indirect data load target
.byte $E6
; indirect data load target
.byte $C3
; indirect data load target
.byte $9C
; indirect data load target
.byte $89
; indirect data load target
.byte $E1
; indirect data load target
.byte $25
; indirect data load target
.byte $8F
; indirect data load target
.byte $E5
; indirect data load target
.byte $24
; indirect data load target
.byte $E3
; indirect data load target
.byte $A2
; indirect data load target
.byte $84
; indirect data load target
.byte $63
; indirect data load target
.byte $A1
; indirect data load target
.byte $E1
; indirect data load target
.byte $84
; indirect data load target
.byte $E3
; indirect data load target
.byte $A4
; indirect data load target
.byte $E2
; indirect data load target
.byte $8A
; indirect data load target
.byte $63
; indirect data load target
.byte $21
; indirect data load target
.byte $91
; indirect data load target
.byte $61
; indirect data load target
.byte $84
; indirect data load target
.byte $26
; indirect data load target
.byte $A3
; indirect data load target
.byte $66
; indirect data load target
.byte $80
; indirect data load target
.byte $67
; indirect data load target
.byte $A1
; indirect data load target
.byte $41
; indirect data load target
.byte $9F
; indirect data load target
.byte $98
; indirect data load target
.byte $64
; indirect data load target
.byte $E3
; indirect data load target
.byte $C6
; indirect data load target
.byte $9B
; indirect data load target
.byte $8B
; indirect data load target
.byte $25
; indirect data load target
.byte $8E
; indirect data load target
.byte $E7
; indirect data load target
.byte $22
; indirect data load target
.byte $E3
; indirect data load target
.byte $A3
; indirect data load target
.byte $83
; indirect data load target
.byte $A5
; indirect data load target
.byte $E2
; indirect data load target
.byte $84
; indirect data load target
.byte $E2
; indirect data load target
.byte $A0
; indirect data load target
.byte $64
; indirect data load target
.byte $A0
; indirect data load target
.byte $E1
; indirect data load target
.byte $20
; indirect data load target
.byte $8B
; indirect data load target
.byte $65
; indirect data load target
.byte $8F
; indirect data load target
.byte $62
; indirect data load target
.byte $82
; indirect data load target
.byte $26
; indirect data load target
.byte $A3
; indirect data load target
.byte $66
; indirect data load target
.byte $81
; indirect data load target
.byte $68
; indirect data load target
.byte $A1
; indirect data load target
.byte $41
; indirect data load target
.byte $9F
; indirect data load target
.byte $96
; indirect data load target
.byte $65
; indirect data load target
.byte $E2
; indirect data load target
.byte $C7
; indirect data load target
.byte $9B
; indirect data load target
.byte $8B
; indirect data load target
.byte $25
; indirect data load target
.byte $8E
; indirect data load target
.byte $ED
; indirect data load target
.byte $A1
; indirect data load target
.byte $62
; indirect data load target
.byte $09
; indirect data load target
.byte $63
; indirect data load target
.byte $A3
; indirect data load target
.byte $E2
; indirect data load target
.byte $85
; indirect data load target
.byte $E2
; indirect data load target
.byte $A0
; indirect data load target
.byte $62
; indirect data load target
.byte $0B
; indirect data load target
.byte $60
; indirect data load target
.byte $A1
; indirect data load target
.byte $21
; indirect data load target
.byte $8D
; indirect data load target
.byte $62
; indirect data load target
.byte $13
; indirect data load target
.byte $8F
; indirect data load target
.byte $62
; indirect data load target
.byte $82
; indirect data load target
.byte $26
; indirect data load target
.byte $A2
; indirect data load target
.byte $67
; indirect data load target
.byte $80
; indirect data load target
.byte $6A
; indirect data load target
.byte $A1
; indirect data load target
.byte $40
; indirect data load target
.byte $9F
; indirect data load target
.byte $96
; indirect data load target
.byte $64
; indirect data load target
.byte $E3
; indirect data load target
.byte $C7
; indirect data load target
.byte $9B
; indirect data load target
.byte $8D
; indirect data load target
.byte $22
; indirect data load target
.byte $61
; indirect data load target
.byte $8D
; indirect data load target
.byte $ED
; indirect data load target
.byte $63
; indirect data load target
.byte $81
; indirect data load target
.byte $63
; indirect data load target
.byte $A1
; indirect data load target
.byte $E3
; indirect data load target
.byte $87
; indirect data load target
.byte $E2
; indirect data load target
.byte $A0
; indirect data load target
.byte $62
; indirect data load target
.byte $A0
; indirect data load target
.byte $E1
; indirect data load target
.byte $20
; indirect data load target
.byte $8E
; indirect data load target
.byte $63
; indirect data load target
.byte $13
; indirect data load target
.byte $60
; indirect data load target
.byte $8D
; indirect data load target
.byte $62
; indirect data load target
.byte $28
; indirect data load target
.byte $A1
; indirect data load target
.byte $68
; indirect data load target
.byte $81
; indirect data load target
.byte $67
; indirect data load target
.byte $23
; indirect data load target
.byte $A0
; indirect data load target
.byte $41
; indirect data load target
.byte $9F
; indirect data load target
.byte $94
; indirect data load target
.byte $65
; indirect data load target
.byte $E4
; indirect data load target
.byte $C7
; indirect data load target
.byte $9A
; indirect data load target
.byte $8D
; indirect data load target
.byte $21
; indirect data load target
.byte $62
; indirect data load target
.byte $8D
; indirect data load target
.byte $EC
; indirect data load target
.byte $63
; indirect data load target
.byte $82
; indirect data load target
.byte $63
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $89
; indirect data load target
.byte $E2
; indirect data load target
.byte $A0
; indirect data load target
.byte $60
; indirect data load target
.byte $A0
; indirect data load target
.byte $E3
; indirect data load target
.byte $8F
; indirect data load target
.byte $61
; indirect data load target
.byte $13
; indirect data load target
.byte $13
; indirect data load target
.byte $62
; indirect data load target
.byte $8B
; indirect data load target
.byte $63
; indirect data load target
.byte $28
; indirect data load target
.byte $69
; indirect data load target
.byte $80
; indirect data load target
.byte $67
; indirect data load target
.byte $24
; indirect data load target
.byte $A1
; indirect data load target
.byte $40
; indirect data load target
.byte $9F
; indirect data load target
.byte $94
; indirect data load target
.byte $65
; indirect data load target
.byte $E5
; indirect data load target
.byte $C4
; indirect data load target
.byte $21
; indirect data load target
.byte $9A
; indirect data load target
.byte $8D
; indirect data load target
.byte $22
; indirect data load target
.byte $63
; indirect data load target
.byte $8C
; indirect data load target
.byte $EC
; indirect data load target
.byte $61
; indirect data load target
.byte $84
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $81
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $8B
; indirect data load target
.byte $E7
; indirect data load target
.byte $93
; indirect data load target
.byte $64
; indirect data load target
.byte $8B
; indirect data load target
.byte $63
; indirect data load target
.byte $28
; indirect data load target
.byte $68
; indirect data load target
.byte $09
; indirect data load target
.byte $66
; indirect data load target
.byte $26
; indirect data load target
.byte $A0
; indirect data load target
.byte $41
; indirect data load target
.byte $9F
; indirect data load target
.byte $91
; indirect data load target
.byte $21
; indirect data load target
.byte $65
; indirect data load target
.byte $E6
; indirect data load target
.byte $24
; indirect data load target
.byte $9B
; indirect data load target
.byte $8E
; indirect data load target
.byte $22
; indirect data load target
.byte $62
; indirect data load target
.byte $8E
; indirect data load target
.byte $E4
; indirect data load target
.byte $82
; indirect data load target
.byte $E2
; indirect data load target
.byte $9A
; indirect data load target
.byte $E3
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $8E
; indirect data load target
.byte $60
; indirect data load target
.byte $84
; indirect data load target
.byte $61
; indirect data load target
.byte $44
; indirect data load target
.byte $8A
; indirect data load target
.byte $63
; indirect data load target
.byte $21
; indirect data load target
.byte $61
; indirect data load target
.byte $23
; indirect data load target
.byte $68
; indirect data load target
.byte $80
; indirect data load target
.byte $65
; indirect data load target
.byte $27
; indirect data load target
.byte $A1
; indirect data load target
.byte $41
; indirect data load target
.byte $9F
; indirect data load target
.byte $8F
; indirect data load target
.byte $23
; indirect data load target
.byte $65
; indirect data load target
.byte $E4
; indirect data load target
.byte $25
; indirect data load target
.byte $9B
; indirect data load target
.byte $8F
; indirect data load target
.byte $E2
; indirect data load target
.byte $62
; indirect data load target
.byte $9F
; indirect data load target
.byte $93
; indirect data load target
.byte $E2
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $8F
; indirect data load target
.byte $61
; indirect data load target
.byte $83
; indirect data load target
.byte $46
; indirect data load target
.byte $8A
; indirect data load target
.byte $68
; indirect data load target
.byte $21
; indirect data load target
.byte $64
; indirect data load target
.byte $85
; indirect data load target
.byte $61
; indirect data load target
.byte $E2
; indirect data load target
.byte $28
; indirect data load target
.byte $A2
; indirect data load target
.byte $40
; indirect data load target
.byte $9F
; indirect data load target
.byte $8D
; indirect data load target
.byte $26
; indirect data load target
.byte $64
; indirect data load target
.byte $E5
; indirect data load target
.byte $23
; indirect data load target
.byte $9C
; indirect data load target
.byte $8F
; indirect data load target
.byte $E3
; indirect data load target
.byte $61
; indirect data load target
.byte $9F
; indirect data load target
.byte $93
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $91
; indirect data load target
.byte $61
; indirect data load target
.byte $83
; indirect data load target
.byte $44
; indirect data load target
.byte $8A
; indirect data load target
.byte $65
; indirect data load target
.byte $0E
; indirect data load target
.byte $0F
; indirect data load target
.byte $65
; indirect data load target
.byte $83
; indirect data load target
.byte $63
; indirect data load target
.byte $80
; indirect data load target
.byte $60
; indirect data load target
.byte $E4
; indirect data load target
.byte $28
; indirect data load target
.byte $A1
; indirect data load target
.byte $41
; indirect data load target
.byte $9F
; indirect data load target
.byte $8C
; indirect data load target
.byte $26
; indirect data load target
.byte $65
; indirect data load target
.byte $E4
; indirect data load target
.byte $23
; indirect data load target
.byte $9C
; indirect data load target
.byte $8E
; indirect data load target
.byte $E4
; indirect data load target
.byte $63
; indirect data load target
.byte $9F
; indirect data load target
.byte $91
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $89
; indirect data load target
.byte $62
; indirect data load target
.byte $85
; indirect data load target
.byte $61
; indirect data load target
.byte $90
; indirect data load target
.byte $6B
; indirect data load target
.byte $85
; indirect data load target
.byte $66
; indirect data load target
.byte $80
; indirect data load target
.byte $E5
; indirect data load target
.byte $61
; indirect data load target
.byte $26
; indirect data load target
.byte $A2
; indirect data load target
.byte $40
; indirect data load target
.byte $9F
; indirect data load target
.byte $8B
; indirect data load target
.byte $25
; indirect data load target
.byte $68
; indirect data load target
.byte $E4
; indirect data load target
.byte $21
; indirect data load target
.byte $9D
; indirect data load target
.byte $8E
; indirect data load target
.byte $E3
; indirect data load target
.byte $65
; indirect data load target
.byte $9F
; indirect data load target
.byte $9C
; indirect data load target
.byte $63
; indirect data load target
.byte $99
; indirect data load target
.byte $6B
; indirect data load target
.byte $80
; indirect data load target
.byte $69
; indirect data load target
.byte $81
; indirect data load target
.byte $E6
; indirect data load target
.byte $61
; indirect data load target
.byte $24
; indirect data load target
.byte $61
; indirect data load target
.byte $A1
; indirect data load target
.byte $41
; indirect data load target
.byte $9F
; indirect data load target
.byte $8A
; indirect data load target
.byte $23
; indirect data load target
.byte $6A
; indirect data load target
.byte $E6
; indirect data load target
.byte $9D
; indirect data load target
.byte $8F
; indirect data load target
.byte $E1
; indirect data load target
.byte $68
; indirect data load target
.byte $9F
; indirect data load target
.byte $9A
; indirect data load target
.byte $65
; indirect data load target
.byte $9C
; indirect data load target
.byte $63
; indirect data load target
.byte $89
; indirect data load target
.byte $63
; indirect data load target
.byte $80
; indirect data load target
.byte $E8
; indirect data load target
.byte $62
; indirect data load target
.byte $21
; indirect data load target
.byte $62
; indirect data load target
.byte $A2
; indirect data load target
.byte $40
; indirect data load target
.byte $9F
; indirect data load target
.byte $89
; indirect data load target
.byte $21
; indirect data load target
.byte $64
; indirect data load target
.byte $85
; indirect data load target
.byte $64
; indirect data load target
.byte $E5
; indirect data load target
.byte $9C
; indirect data load target
.byte $8F
; indirect data load target
.byte $E3
; indirect data load target
.byte $65
; indirect data load target
.byte $9F
; indirect data load target
.byte $9A
; indirect data load target
.byte $66
; indirect data load target
.byte $97
; indirect data load target
.byte $63
; indirect data load target
.byte $82
; indirect data load target
.byte $63
; indirect data load target
.byte $09
; indirect data load target
.byte $6A
; indirect data load target
.byte $80
; indirect data load target
.byte $EA
; indirect data load target
.byte $64
; indirect data load target
.byte $E1
; indirect data load target
.byte $A0
; indirect data load target
.byte $41
; indirect data load target
.byte $9F
; indirect data load target
.byte $89
; indirect data load target
.byte $21
; indirect data load target
.byte $63
; indirect data load target
.byte $87
; indirect data load target
.byte $64
; indirect data load target
.byte $E4
; indirect data load target
.byte $9C
; indirect data load target
.byte $90
; indirect data load target
.byte $E5
; indirect data load target
.byte $62
; indirect data load target
.byte $9F
; indirect data load target
.byte $9B
; indirect data load target
.byte $67
; indirect data load target
.byte $8B
; indirect data load target
.byte $C4
; indirect data load target
.byte $83
; indirect data load target
.byte $66
; indirect data load target
.byte $85
; indirect data load target
.byte $6A
; indirect data load target
.byte $81
; indirect data load target
.byte $EF
; indirect data load target
.byte $A1
; indirect data load target
.byte $40
; indirect data load target
.byte $9F
; indirect data load target
.byte $8A
; indirect data load target
.byte $64
; indirect data load target
.byte $8A
; indirect data load target
.byte $63
; indirect data load target
.byte $E4
; indirect data load target
.byte $9B
; indirect data load target
.byte $90
; indirect data load target
.byte $E6
; indirect data load target
.byte $62
; indirect data load target
.byte $9F
; indirect data load target
.byte $9A
; indirect data load target
.byte $66
; indirect data load target
.byte $8B
; indirect data load target
.byte $C6
; indirect data load target
.byte $82
; indirect data load target
.byte $6B
; indirect data load target
.byte $82
; indirect data load target
.byte $69
; indirect data load target
.byte $82
; indirect data load target
.byte $EE
; indirect data load target
.byte $A0
; indirect data load target
.byte $40
; indirect data load target
.byte $9F
; indirect data load target
.byte $8B
; indirect data load target
.byte $62
; indirect data load target
.byte $8D
; indirect data load target
.byte $62
; indirect data load target
.byte $E3
; indirect data load target
.byte $9B
; indirect data load target
.byte $90
; indirect data load target
.byte $E5
; indirect data load target
.byte $62
; indirect data load target
.byte $9F
; indirect data load target
.byte $9C
; indirect data load target
.byte $64
; indirect data load target
.byte $20
; indirect data load target
.byte $8A
; indirect data load target
.byte $C8
; indirect data load target
.byte $7C
; indirect data load target
.byte $80
; indirect data load target
.byte $61
; indirect data load target
.byte $EB
; indirect data load target
.byte $A1
; indirect data load target
.byte $41
; indirect data load target
.byte $9F
; indirect data load target
.byte $8A
; indirect data load target
.byte $61
; indirect data load target
.byte $90
; indirect data load target
.byte $61
; indirect data load target
.byte $E2
; indirect data load target
.byte $9B
; indirect data load target
.byte $90
; indirect data load target
.byte $E4
; indirect data load target
.byte $63
; indirect data load target
.byte $9F
; indirect data load target
.byte $9D
; indirect data load target
.byte $62
; indirect data load target
.byte $22
; indirect data load target
.byte $89
; indirect data load target
.byte $C6
; indirect data load target
.byte $24
; indirect data load target
.byte $74
; indirect data load target
.byte $A4
; indirect data load target
.byte $80
; indirect data load target
.byte $65
; indirect data load target
.byte $E8
; indirect data load target
.byte $A1
; indirect data load target
.byte $40
; indirect data load target
.byte $9F
; indirect data load target
.byte $8B
; indirect data load target
.byte $60
; indirect data load target
.byte $91
; indirect data load target
.byte $61
; indirect data load target
.byte $E1
; indirect data load target
.byte $9B
; indirect data load target
.byte $91
; indirect data load target
.byte $E3
; indirect data load target
.byte $62
; indirect data load target
.byte $21
; indirect data load target
.byte $9F
; indirect data load target
.byte $9C
; indirect data load target
.byte $62
; indirect data load target
.byte $23
; indirect data load target
.byte $86
; indirect data load target
.byte $43
; indirect data load target
.byte $2C
; indirect data load target
.byte $6F
; indirect data load target
.byte $A6
; indirect data load target
.byte $66
; indirect data load target
.byte $E7
; indirect data load target
.byte $A1
; indirect data load target
.byte $41
; indirect data load target
.byte $9F
; indirect data load target
.byte $9E
; indirect data load target
.byte $62
; indirect data load target
.byte $E1
; indirect data load target
.byte $9A
; indirect data load target
.byte $91
; indirect data load target
.byte $E3
; indirect data load target
.byte $61
; indirect data load target
.byte $22
; indirect data load target
.byte $9F
; indirect data load target
.byte $9B
; indirect data load target
.byte $64
; indirect data load target
.byte $22
; indirect data load target
.byte $41
; indirect data load target
.byte $83
; indirect data load target
.byte $43
; indirect data load target
.byte $2F
; indirect data load target
.byte $66
; indirect data load target
.byte $22
; indirect data load target
.byte $62
; indirect data load target
.byte $A2
; indirect data load target
.byte $E5
; indirect data load target
.byte $6A
; indirect data load target
.byte $E2
; indirect data load target
.byte $A0
; indirect data load target
.byte $41
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $80
; indirect data load target
.byte $62
; indirect data load target
.byte $E0
; indirect data load target
.byte $9A
; indirect data load target
.byte $92
; indirect data load target
.byte $E4
; indirect data load target
.byte $22
; indirect data load target
.byte $9F
; indirect data load target
.byte $9A
; indirect data load target
.byte $64
; indirect data load target
.byte $24
; indirect data load target
.byte $47
; indirect data load target
.byte $33
; indirect data load target
.byte $61
; indirect data load target
.byte $25
; indirect data load target
.byte $A2
; indirect data load target
.byte $E8
; indirect data load target
.byte $6B
; indirect data load target
.byte $A1
; indirect data load target
.byte $40
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $81
; indirect data load target
.byte $64
; indirect data load target
.byte $99
; indirect data load target
.byte $92
; indirect data load target
.byte $E5
; indirect data load target
.byte $21
; indirect data load target
.byte $9F
; indirect data load target
.byte $9A
; indirect data load target
.byte $65
; indirect data load target
.byte $23
; indirect data load target
.byte $46
; indirect data load target
.byte $3C
; indirect data load target
.byte $F0
; indirect data load target
.byte $64
; indirect data load target
.byte $A2
; indirect data load target
.byte $61
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $82
; indirect data load target
.byte $63
; indirect data load target
.byte $99
; indirect data load target
.byte $93
; indirect data load target
.byte $E7
; indirect data load target
.byte $9F
; indirect data load target
.byte $98
; indirect data load target
.byte $21
; indirect data load target
.byte $66
; indirect data load target
.byte $22
; indirect data load target
.byte $44
; indirect data load target
.byte $2A
; indirect data load target
.byte $64
; indirect data load target
.byte $2E
; indirect data load target
.byte $F0
; indirect data load target
.byte $A5
; indirect data load target
.byte $62
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $83
; indirect data load target
.byte $62
; indirect data load target
.byte $99
; indirect data load target
.byte $94
; indirect data load target
.byte $E7
; indirect data load target
.byte $9F
; indirect data load target
.byte $80
; indirect data load target
.byte $61
; indirect data load target
.byte $94
; indirect data load target
.byte $21
; indirect data load target
.byte $67
; indirect data load target
.byte $22
; indirect data load target
.byte $42
; indirect data load target
.byte $29
; indirect data load target
.byte $69
; indirect data load target
.byte $2B
; indirect data load target
.byte $EE
; indirect data load target
.byte $A5
; indirect data load target
.byte $64
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $83
; indirect data load target
.byte $62
; indirect data load target
.byte $99
; indirect data load target
.byte $94
; indirect data load target
.byte $E4
; indirect data load target
.byte $42
; indirect data load target
.byte $9F
; indirect data load target
.byte $80
; indirect data load target
.byte $62
; indirect data load target
.byte $92
; indirect data load target
.byte $23
; indirect data load target
.byte $67
; indirect data load target
.byte $2B
; indirect data load target
.byte $6E
; indirect data load target
.byte $E2
; indirect data load target
.byte $25
; indirect data load target
.byte $EA
; indirect data load target
.byte $A5
; indirect data load target
.byte $6A
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $81
; indirect data load target
.byte $62
; indirect data load target
.byte $9A
; indirect data load target
.byte $94
; indirect data load target
.byte $E2
; indirect data load target
.byte $47
; indirect data load target
.byte $9C
; indirect data load target
.byte $63
; indirect data load target
.byte $92
; indirect data load target
.byte $23
; indirect data load target
.byte $66
; indirect data load target
.byte $29
; indirect data load target
.byte $70
; indirect data load target
.byte $E4
; indirect data load target
.byte $23
; indirect data load target
.byte $E7
; indirect data load target
.byte $A5
; indirect data load target
.byte $6A
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $84
; indirect data load target
.byte $62
; indirect data load target
.byte $9B
; indirect data load target
.byte $94
; indirect data load target
.byte $E3
; indirect data load target
.byte $47
; indirect data load target
.byte $99
; indirect data load target
.byte $64
; indirect data load target
.byte $40
; indirect data load target
.byte $92
; indirect data load target
.byte $24
; indirect data load target
.byte $65
; indirect data load target
.byte $26
; indirect data load target
.byte $72
; indirect data load target
.byte $EC
; indirect data load target
.byte $A7
; indirect data load target
.byte $6B
; indirect data load target
.byte $82
; indirect data load target
.byte $E2
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $80
; indirect data load target
.byte $42
; indirect data load target
.byte $9B
; indirect data load target
.byte $95
; indirect data load target
.byte $E2
; indirect data load target
.byte $48
; indirect data load target
.byte $98
; indirect data load target
.byte $63
; indirect data load target
.byte $0A
; indirect data load target
.byte $43
; indirect data load target
.byte $91
; indirect data load target
.byte $22
; indirect data load target
.byte $67
; indirect data load target
.byte $23
; indirect data load target
.byte $6A
; indirect data load target
.byte $82
; indirect data load target
.byte $63
; indirect data load target
.byte $E6
; indirect data load target
.byte $AD
; indirect data load target
.byte $69
; indirect data load target
.byte $84
; indirect data load target
.byte $E5
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $40
; indirect data load target
.byte $0B
; indirect data load target
.byte $40
; indirect data load target
.byte $9B
; indirect data load target
.byte $95
; indirect data load target
.byte $E1
; indirect data load target
.byte $4C
; indirect data load target
.byte $97
; indirect data load target
.byte $63
; indirect data load target
.byte $43
; indirect data load target
.byte $90
; indirect data load target
.byte $23
; indirect data load target
.byte $63
; indirect data load target
.byte $A2
; indirect data load target
.byte $24
; indirect data load target
.byte $67
; indirect data load target
.byte $86
; indirect data load target
.byte $E7
; indirect data load target
.byte $A6
; indirect data load target
.byte $71
; indirect data load target
.byte $09
; indirect data load target
.byte $E9
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $42
; indirect data load target
.byte $9B
; indirect data load target
.byte $95
; indirect data load target
.byte $4F
; indirect data load target
.byte $97
; indirect data load target
.byte $63
; indirect data load target
.byte $42
; indirect data load target
.byte $8E
; indirect data load target
.byte $A2
; indirect data load target
.byte $23
; indirect data load target
.byte $61
; indirect data load target
.byte $A4
; indirect data load target
.byte $24
; indirect data load target
.byte $63
; indirect data load target
.byte $8A
; indirect data load target
.byte $E4
; indirect data load target
.byte $A7
; indirect data load target
.byte $69
; indirect data load target
.byte $81
; indirect data load target
.byte $61
; indirect data load target
.byte $85
; indirect data load target
.byte $E9
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $42
; indirect data load target
.byte $9B
; indirect data load target
.byte $94
; indirect data load target
.byte $54
; indirect data load target
.byte $84
; indirect data load target
.byte $42
; indirect data load target
.byte $8B
; indirect data load target
.byte $66
; indirect data load target
.byte $8D
; indirect data load target
.byte $A5
; indirect data load target
.byte $21
; indirect data load target
.byte $A2
; indirect data load target
.byte $C2
; indirect data load target
.byte $A2
; indirect data load target
.byte $26
; indirect data load target
.byte $8D
; indirect data load target
.byte $A9
; indirect data load target
.byte $8A
; indirect data load target
.byte $64
; indirect data load target
.byte $09
; indirect data load target
.byte $ED
; indirect data load target
.byte $9F
; indirect data load target
.byte $9E
; indirect data load target
.byte $40
; indirect data load target
.byte $9D
; indirect data load target
.byte $93
; indirect data load target
.byte $5E
; indirect data load target
.byte $8B
; indirect data load target
.byte $64
; indirect data load target
.byte $8E
; indirect data load target
.byte $A5
; indirect data load target
.byte $21
; indirect data load target
.byte $C8
; indirect data load target
.byte $27
; indirect data load target
.byte $89
; indirect data load target
.byte $E1
; indirect data load target
.byte $85
; indirect data load target
.byte $A7
; indirect data load target
.byte $66
; indirect data load target
.byte $86
; indirect data load target
.byte $E7
; indirect data load target
.byte $65
; indirect data load target
.byte $9F
; indirect data load target
.byte $9E
; indirect data load target
.byte $40
; indirect data load target
.byte $9D
; indirect data load target
.byte $93
; indirect data load target
.byte $5F
; indirect data load target
.byte $42
; indirect data load target
.byte $9A
; indirect data load target
.byte $A5
; indirect data load target
.byte $22
; indirect data load target
.byte $C5
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $29
; indirect data load target
.byte $86
; indirect data load target
.byte $E8
; indirect data load target
.byte $83
; indirect data load target
.byte $A5
; indirect data load target
.byte $67
; indirect data load target
.byte $09
; indirect data load target
.byte $61
; indirect data load target
.byte $A2
; indirect data load target
.byte $E5
; indirect data load target
.byte $66
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9D
; indirect data load target
.byte $93
; indirect data load target
.byte $5E
; indirect data load target
.byte $68
; indirect data load target
.byte $95
; indirect data load target
.byte $A2
; indirect data load target
.byte $24
; indirect data load target
.byte $C5
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $29
; indirect data load target
.byte $84
; indirect data load target
.byte $EC
; indirect data load target
.byte $84
; indirect data load target
.byte $A1
; indirect data load target
.byte $66
; indirect data load target
.byte $81
; indirect data load target
.byte $60
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $A4
; indirect data load target
.byte $E2
; indirect data load target
.byte $65
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9E
; indirect data load target
.byte $93
; indirect data load target
.byte $48
; indirect data load target
.byte $61
; indirect data load target
.byte $52
; indirect data load target
.byte $6B
; indirect data load target
.byte $93
; indirect data load target
.byte $A1
; indirect data load target
.byte $25
; indirect data load target
.byte $C4
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $00
; indirect data load target
.byte $12
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $2F
; indirect data load target
.byte $C1
; indirect data load target
.byte $EC
; indirect data load target
.byte $83
; indirect data load target
.byte $64
; indirect data load target
.byte $81
; indirect data load target
.byte $61
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $61
; indirect data load target
.byte $A4
; indirect data load target
.byte $66
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $81
; indirect data load target
.byte $60
; indirect data load target
.byte $9B
; indirect data load target
.byte $93
; indirect data load target
.byte $47
; indirect data load target
.byte $60
; indirect data load target
.byte $81
; indirect data load target
.byte $60
; indirect data load target
.byte $53
; indirect data load target
.byte $6B
; indirect data load target
.byte $91
; indirect data load target
.byte $A0
; indirect data load target
.byte $27
; indirect data load target
.byte $C3
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $10
; indirect data load target
.byte $11
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $2E
; indirect data load target
.byte $C4
; indirect data load target
.byte $ED
; indirect data load target
.byte $84
; indirect data load target
.byte $0D
; indirect data load target
.byte $80
; indirect data load target
.byte $66
; indirect data load target
.byte $A3
; indirect data load target
.byte $66
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $82
; indirect data load target
.byte $61
; indirect data load target
.byte $9A
; indirect data load target
.byte $93
; indirect data load target
.byte $47
; indirect data load target
.byte $20
; indirect data load target
.byte $81
; indirect data load target
.byte $20
; indirect data load target
.byte $54
; indirect data load target
.byte $6C
; indirect data load target
.byte $8E
; indirect data load target
.byte $A1
; indirect data load target
.byte $28
; indirect data load target
.byte $C3
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $26
; indirect data load target
.byte $62
; indirect data load target
.byte $27
; indirect data load target
.byte $C6
; indirect data load target
.byte $E6
; indirect data load target
.byte $83
; indirect data load target
.byte $6D
; indirect data load target
.byte $A1
; indirect data load target
.byte $67
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $83
; indirect data load target
.byte $60
; indirect data load target
.byte $9A
; indirect data load target
.byte $94
; indirect data load target
.byte $5E
; indirect data load target
.byte $24
; indirect data load target
.byte $67
; indirect data load target
.byte $21
; indirect data load target
.byte $8D
; indirect data load target
.byte $A0
; indirect data load target
.byte $28
; indirect data load target
.byte $A3
; indirect data load target
.byte $C2
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $24
; indirect data load target
.byte $66
; indirect data load target
.byte $24
; indirect data load target
.byte $CC
; indirect data load target
.byte $82
; indirect data load target
.byte $6F
; indirect data load target
.byte $A2
; indirect data load target
.byte $66
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $80
; indirect data load target
.byte $95
; indirect data load target
.byte $5C
; indirect data load target
.byte $27
; indirect data load target
.byte $63
; indirect data load target
.byte $25
; indirect data load target
.byte $8A
; indirect data load target
.byte $A1
; indirect data load target
.byte $27
; indirect data load target
.byte $A5
; indirect data load target
.byte $C5
; indirect data load target
.byte $6A
; indirect data load target
.byte $25
; indirect data load target
.byte $CB
; indirect data load target
.byte $6C
; indirect data load target
.byte $22
; indirect data load target
.byte $A4
; indirect data load target
.byte $85
; indirect data load target
.byte $0D
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $82
; indirect data load target
.byte $08
; indirect data load target
.byte $9C
; indirect data load target
.byte $95
; indirect data load target
.byte $5A
; indirect data load target
.byte $C2
; indirect data load target
.byte $30
; indirect data load target
.byte $8C
; indirect data load target
.byte $0D
; indirect data load target
.byte $85
; indirect data load target
.byte $A8
; indirect data load target
.byte $C2
; indirect data load target
.byte $6A
; indirect data load target
.byte $26
; indirect data load target
.byte $CE
; indirect data load target
.byte $64
; indirect data load target
.byte $A2
; indirect data load target
.byte $82
; indirect data load target
.byte $21
; indirect data load target
.byte $85
; indirect data load target
.byte $65
; indirect data load target
.byte $9F
; indirect data load target
.byte $88
; indirect data load target
.byte $0B
; indirect data load target
.byte $98
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $9B
; indirect data load target
.byte $96
; indirect data load target
.byte $57
; indirect data load target
.byte $C6
; indirect data load target
.byte $2F
; indirect data load target
.byte $89
; indirect data load target
.byte $47
; indirect data load target
.byte $83
; indirect data load target
.byte $E3
; indirect data load target
.byte $A3
; indirect data load target
.byte $6C
; indirect data load target
.byte $25
; indirect data load target
.byte $CD
; indirect data load target
.byte $65
; indirect data load target
.byte $A1
; indirect data load target
.byte $81
; indirect data load target
.byte $23
; indirect data load target
.byte $80
; indirect data load target
.byte $6A
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $81
; indirect data load target
.byte $61
; indirect data load target
.byte $41
; indirect data load target
.byte $9A
; indirect data load target
.byte $96
; indirect data load target
.byte $55
; indirect data load target
.byte $CA
; indirect data load target
.byte $25
; indirect data load target
.byte $61
; indirect data load target
.byte $26
; indirect data load target
.byte $88
; indirect data load target
.byte $43
; indirect data load target
.byte $62
; indirect data load target
.byte $43
; indirect data load target
.byte $81
; indirect data load target
.byte $E4
; indirect data load target
.byte $A2
; indirect data load target
.byte $6C
; indirect data load target
.byte $25
; indirect data load target
.byte $CC
; indirect data load target
.byte $64
; indirect data load target
.byte $A2
; indirect data load target
.byte $80
; indirect data load target
.byte $61
; indirect data load target
.byte $22
; indirect data load target
.byte $86
; indirect data load target
.byte $65
; indirect data load target
.byte $09
; indirect data load target
.byte $60
; indirect data load target
.byte $9F
; indirect data load target
.byte $9E
; indirect data load target
.byte $61
; indirect data load target
.byte $41
; indirect data load target
.byte $9A
; indirect data load target
.byte $97
; indirect data load target
.byte $50
; indirect data load target
.byte $C8
; indirect data load target
.byte $A6
; indirect data load target
.byte $23
; indirect data load target
.byte $64
; indirect data load target
.byte $27
; indirect data load target
.byte $83
; indirect data load target
.byte $44
; indirect data load target
.byte $64
; indirect data load target
.byte $43
; indirect data load target
.byte $81
; indirect data load target
.byte $E7
; indirect data load target
.byte $6C
; indirect data load target
.byte $27
; indirect data load target
.byte $CA
; indirect data load target
.byte $62
; indirect data load target
.byte $A3
; indirect data load target
.byte $80
; indirect data load target
.byte $62
; indirect data load target
.byte $21
; indirect data load target
.byte $80
; indirect data load target
.byte $44
; indirect data load target
.byte $82
; indirect data load target
.byte $61
; indirect data load target
.byte $82
; indirect data load target
.byte $61
; indirect data load target
.byte $9F
; indirect data load target
.byte $9E
; indirect data load target
.byte $61
; indirect data load target
.byte $41
; indirect data load target
.byte $99
; indirect data load target
.byte $97
; indirect data load target
.byte $4E
; indirect data load target
.byte $C5
; indirect data load target
.byte $AE
; indirect data load target
.byte $66
; indirect data load target
.byte $27
; indirect data load target
.byte $80
; indirect data load target
.byte $46
; indirect data load target
.byte $65
; indirect data load target
.byte $43
; indirect data load target
.byte $09
; indirect data load target
.byte $EA
; indirect data load target
.byte $69
; indirect data load target
.byte $29
; indirect data load target
.byte $C7
; indirect data load target
.byte $A5
; indirect data load target
.byte $E1
; indirect data load target
.byte $80
; indirect data load target
.byte $64
; indirect data load target
.byte $80
; indirect data load target
.byte $40
; indirect data load target
.byte $E2
; indirect data load target
.byte $42
; indirect data load target
.byte $83
; indirect data load target
.byte $63
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $42
; indirect data load target
.byte $99
; indirect data load target
.byte $99
; indirect data load target
.byte $49
; indirect data load target
.byte $C3
; indirect data load target
.byte $AA
; indirect data load target
.byte $E2
; indirect data load target
.byte $A7
; indirect data load target
.byte $65
; indirect data load target
.byte $25
; indirect data load target
.byte $0B
; indirect data load target
.byte $80
; indirect data load target
.byte $0B
; indirect data load target
.byte $46
; indirect data load target
.byte $63
; indirect data load target
.byte $42
; indirect data load target
.byte $A1
; indirect data load target
.byte $81
; indirect data load target
.byte $ED
; indirect data load target
.byte $66
; indirect data load target
.byte $2A
; indirect data load target
.byte $C3
; indirect data load target
.byte $A6
; indirect data load target
.byte $E2
; indirect data load target
.byte $80
; indirect data load target
.byte $62
; indirect data load target
.byte $82
; indirect data load target
.byte $42
; indirect data load target
.byte $E2
; indirect data load target
.byte $43
; indirect data load target
.byte $81
; indirect data load target
.byte $62
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $80
; indirect data load target
.byte $40
; indirect data load target
.byte $9A
; indirect data load target
.byte $99
; indirect data load target
.byte $46
; indirect data load target
.byte $C3
; indirect data load target
.byte $A8
; indirect data load target
.byte $EA
; indirect data load target
.byte $A5
; indirect data load target
.byte $66
; indirect data load target
.byte $24
; indirect data load target
.byte $80
; indirect data load target
.byte $4D
; indirect data load target
.byte $A3
; indirect data load target
.byte $87
; indirect data load target
.byte $E8
; indirect data load target
.byte $65
; indirect data load target
.byte $2A
; indirect data load target
.byte $C3
; indirect data load target
.byte $A3
; indirect data load target
.byte $E4
; indirect data load target
.byte $84
; indirect data load target
.byte $4C
; indirect data load target
.byte $80
; indirect data load target
.byte $61
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9D
; indirect data load target
.byte $9A
; indirect data load target
.byte $45
; indirect data load target
.byte $C2
; indirect data load target
.byte $A5
; indirect data load target
.byte $F1
; indirect data load target
.byte $A3
; indirect data load target
.byte $68
; indirect data load target
.byte $21
; indirect data load target
.byte $81
; indirect data load target
.byte $4A
; indirect data load target
.byte $A7
; indirect data load target
.byte $88
; indirect data load target
.byte $E8
; indirect data load target
.byte $67
; indirect data load target
.byte $27
; indirect data load target
.byte $C2
; indirect data load target
.byte $A1
; indirect data load target
.byte $E2
; indirect data load target
.byte $23
; indirect data load target
.byte $44
; indirect data load target
.byte $8A
; indirect data load target
.byte $60
; indirect data load target
.byte $09
; indirect data load target
.byte $60
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9E
; indirect data load target
.byte $9A
; indirect data load target
.byte $44
; indirect data load target
.byte $C2
; indirect data load target
.byte $A5
; indirect data load target
.byte $E8
; indirect data load target
.byte $84
; indirect data load target
.byte $E5
; indirect data load target
.byte $A2
; indirect data load target
.byte $6B
; indirect data load target
.byte $81
; indirect data load target
.byte $45
; indirect data load target
.byte $A8
; indirect data load target
.byte $8F
; indirect data load target
.byte $E4
; indirect data load target
.byte $68
; indirect data load target
.byte $25
; indirect data load target
.byte $C3
; indirect data load target
.byte $A0
; indirect data load target
.byte $E2
; indirect data load target
.byte $21
; indirect data load target
.byte $0A
; indirect data load target
.byte $23
; indirect data load target
.byte $83
; indirect data load target
.byte $2A
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $80
; indirect data load target
.byte $9A
; indirect data load target
.byte $45
; indirect data load target
.byte $A4
; indirect data load target
.byte $EB
; indirect data load target
.byte $80
; indirect data load target
.byte $62
; indirect data load target
.byte $81
; indirect data load target
.byte $E5
; indirect data load target
.byte $A5
; indirect data load target
.byte $68
; indirect data load target
.byte $83
; indirect data load target
.byte $A7
; indirect data load target
.byte $99
; indirect data load target
.byte $6A
; indirect data load target
.byte $21
; indirect data load target
.byte $C3
; indirect data load target
.byte $A1
; indirect data load target
.byte $E2
; indirect data load target
.byte $32
; indirect data load target
.byte $A4
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9E
; indirect data load target
.byte $9A
; indirect data load target
.byte $42
; indirect data load target
.byte $A6
; indirect data load target
.byte $E6
; indirect data load target
.byte $86
; indirect data load target
.byte $63
; indirect data load target
.byte $82
; indirect data load target
.byte $E5
; indirect data load target
.byte $A7
; indirect data load target
.byte $65
; indirect data load target
.byte $9F
; indirect data load target
.byte $87
; indirect data load target
.byte $6C
; indirect data load target
.byte $A3
; indirect data load target
.byte $E2
; indirect data load target
.byte $2E
; indirect data load target
.byte $A7
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9E
; indirect data load target
.byte $9B
; indirect data load target
.byte $A5
; indirect data load target
.byte $E8
; indirect data load target
.byte $81
; indirect data load target
.byte $6B
; indirect data load target
.byte $81
; indirect data load target
.byte $E5
; indirect data load target
.byte $A8
; indirect data load target
.byte $64
; indirect data load target
.byte $9F
; indirect data load target
.byte $87
; indirect data load target
.byte $67
; indirect data load target
.byte $A8
; indirect data load target
.byte $E4
; indirect data load target
.byte $A3
; indirect data load target
.byte $26
; indirect data load target
.byte $A9
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9D
; indirect data load target
.byte $9B
; indirect data load target
.byte $A3
; indirect data load target
.byte $EA
; indirect data load target
.byte $80
; indirect data load target
.byte $6D
; indirect data load target
.byte $80
; indirect data load target
.byte $E4
; indirect data load target
.byte $AE
; indirect data load target
.byte $9F
; indirect data load target
.byte $88
; indirect data load target
.byte $64
; indirect data load target
.byte $AA
; indirect data load target
.byte $63
; indirect data load target
.byte $B6
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9C
; indirect data load target
.byte $9B
; indirect data load target
.byte $A3
; indirect data load target
.byte $EA
; indirect data load target
.byte $80
; indirect data load target
.byte $6B
; indirect data load target
.byte $82
; indirect data load target
.byte $E2
; indirect data load target
.byte $B5
; indirect data load target
.byte $9F
; indirect data load target
.byte $89
; indirect data load target
.byte $67
; indirect data load target
.byte $A2
; indirect data load target
.byte $63
; indirect data load target
.byte $A4
; indirect data load target
.byte $23
; indirect data load target
.byte $AC
; indirect data load target
.byte $9F
; indirect data load target
.byte $9C
; indirect data load target
.byte $60
; indirect data load target
.byte $9E
; indirect data load target
.byte $9B
; indirect data load target
.byte $A2
; indirect data load target
.byte $E8
; indirect data load target
.byte $A0
; indirect data load target
.byte $82
; indirect data load target
.byte $A2
; indirect data load target
.byte $67
; indirect data load target
.byte $A3
; indirect data load target
.byte $E3
; indirect data load target
.byte $A6
; indirect data load target
.byte $64
; indirect data load target
.byte $AB
; indirect data load target
.byte $9F
; indirect data load target
.byte $87
; indirect data load target
.byte $67
; indirect data load target
.byte $A7
; indirect data load target
.byte $27
; indirect data load target
.byte $AB
; indirect data load target
.byte $9F
; indirect data load target
.byte $9B
; indirect data load target
.byte $61
; indirect data load target
.byte $20
; indirect data load target
.byte $9D
; indirect data load target
.byte $9A
; indirect data load target
.byte $A7
; indirect data load target
.byte $E4
; indirect data load target
.byte $A0
; indirect data load target
.byte $82
; indirect data load target
.byte $A5
; indirect data load target
.byte $62
; indirect data load target
.byte $A6
; indirect data load target
.byte $E4
; indirect data load target
.byte $A2
; indirect data load target
.byte $68
; indirect data load target
.byte $AA
; indirect data load target
.byte $8E
; indirect data load target
.byte $E3
; indirect data load target
.byte $93
; indirect data load target
.byte $44
; indirect data load target
.byte $64
; indirect data load target
.byte $A2
; indirect data load target
.byte $2B
; indirect data load target
.byte $A9
; indirect data load target
.byte $9F
; indirect data load target
.byte $9B
; indirect data load target
.byte $61
; indirect data load target
.byte $21
; indirect data load target
.byte $9D
; indirect data load target
.byte $9A
; indirect data load target
.byte $A8
; indirect data load target
.byte $63
; indirect data load target
.byte $A0
; indirect data load target
.byte $82
; indirect data load target
.byte $A5
; indirect data load target
.byte $62
; indirect data load target
.byte $A6
; indirect data load target
.byte $E6
; indirect data load target
.byte $61
; indirect data load target
.byte $81
; indirect data load target
.byte $A2
; indirect data load target
.byte $68
; indirect data load target
.byte $A9
; indirect data load target
.byte $87
; indirect data load target
.byte $E6
; indirect data load target
.byte $90
; indirect data load target
.byte $48
; indirect data load target
.byte $64
; indirect data load target
.byte $2D
; indirect data load target
.byte $A5
; indirect data load target
.byte $E2
; indirect data load target
.byte $9F
; indirect data load target
.byte $9B
; indirect data load target
.byte $60
; indirect data load target
.byte $21
; indirect data load target
.byte $9E
; indirect data load target
.byte $9B
; indirect data load target
.byte $A6
; indirect data load target
.byte $64
; indirect data load target
.byte $A4
; indirect data load target
.byte $61
; indirect data load target
.byte $A3
; indirect data load target
.byte $61
; indirect data load target
.byte $A4
; indirect data load target
.byte $E7
; indirect data load target
.byte $61
; indirect data load target
.byte $A0
; indirect data load target
.byte $81
; indirect data load target
.byte $A4
; indirect data load target
.byte $68
; indirect data load target
.byte $A8
; indirect data load target
.byte $85
; indirect data load target
.byte $64
; indirect data load target
.byte $E3
; indirect data load target
.byte $90
; indirect data load target
.byte $46
; indirect data load target
.byte $66
; indirect data load target
.byte $2B
; indirect data load target
.byte $EA
; indirect data load target
.byte $9F
; indirect data load target
.byte $9A
; indirect data load target
.byte $60
; indirect data load target
.byte $20
; indirect data load target
.byte $13
; indirect data load target
.byte $9E
; indirect data load target
.byte $9B
; indirect data load target
.byte $A4
; indirect data load target
.byte $62
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $69
; indirect data load target
.byte $A2
; indirect data load target
.byte $62
; indirect data load target
.byte $A1
; indirect data load target
.byte $E6
; indirect data load target
.byte $A5
; indirect data load target
.byte $0E
; indirect data load target
.byte $0F
; indirect data load target
.byte $62
; indirect data load target
.byte $A2
; indirect data load target
.byte $E1
; indirect data load target
.byte $66
; indirect data load target
.byte $A6
; indirect data load target
.byte $61
; indirect data load target
.byte $85
; indirect data load target
.byte $64
; indirect data load target
.byte $E1
; indirect data load target
.byte $88
; indirect data load target
.byte $23
; indirect data load target
.byte $85
; indirect data load target
.byte $44
; indirect data load target
.byte $67
; indirect data load target
.byte $A2
; indirect data load target
.byte $26
; indirect data load target
.byte $EC
; indirect data load target
.byte $9F
; indirect data load target
.byte $99
; indirect data load target
.byte $13
; indirect data load target
.byte $60
; indirect data load target
.byte $21
; indirect data load target
.byte $9E
; indirect data load target
.byte $9C
; indirect data load target
.byte $A2
; indirect data load target
.byte $62
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $68
; indirect data load target
.byte $A3
; indirect data load target
.byte $61
; indirect data load target
.byte $A9
; indirect data load target
.byte $83
; indirect data load target
.byte $40
; indirect data load target
.byte $A0
; indirect data load target
.byte $62
; indirect data load target
.byte $E7
; indirect data load target
.byte $64
; indirect data load target
.byte $A5
; indirect data load target
.byte $63
; indirect data load target
.byte $85
; indirect data load target
.byte $61
; indirect data load target
.byte $8B
; indirect data load target
.byte $21
; indirect data load target
.byte $63
; indirect data load target
.byte $84
; indirect data load target
.byte $41
; indirect data load target
.byte $69
; indirect data load target
.byte $A4
; indirect data load target
.byte $24
; indirect data load target
.byte $62
; indirect data load target
.byte $E9
; indirect data load target
.byte $9F
; indirect data load target
.byte $92
; indirect data load target
.byte $A6
; indirect data load target
.byte $13
; indirect data load target
.byte $13
; indirect data load target
.byte $61
; indirect data load target
.byte $21
; indirect data load target
.byte $9D
; indirect data load target
.byte $9C
; indirect data load target
.byte $A2
; indirect data load target
.byte $63
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $64
; indirect data load target
.byte $E2
; indirect data load target
.byte $A5
; indirect data load target
.byte $61
; indirect data load target
.byte $A8
; indirect data load target
.byte $81
; indirect data load target
.byte $A2
; indirect data load target
.byte $40
; indirect data load target
.byte $A0
; indirect data load target
.byte $EB
; indirect data load target
.byte $62
; indirect data load target
.byte $A5
; indirect data load target
.byte $63
; indirect data load target
.byte $93
; indirect data load target
.byte $21
; indirect data load target
.byte $74
; indirect data load target
.byte $A6
; indirect data load target
.byte $21
; indirect data load target
.byte $65
; indirect data load target
.byte $E7
; indirect data load target
.byte $9F
; indirect data load target
.byte $92
; indirect data load target
.byte $A1
; indirect data load target
.byte $64
; indirect data load target
.byte $A1
; indirect data load target
.byte $13
; indirect data load target
.byte $61
; indirect data load target
.byte $21
; indirect data load target
.byte $9D
; indirect data load target
.byte $9D
; indirect data load target
.byte $A2
; indirect data load target
.byte $66
; indirect data load target
.byte $E5
; indirect data load target
.byte $81
; indirect data load target
.byte $A1
; indirect data load target
.byte $E3
; indirect data load target
.byte $A0
; indirect data load target
.byte $84
; indirect data load target
.byte $A2
; indirect data load target
.byte $80
; indirect data load target
.byte $A3
; indirect data load target
.byte $40
; indirect data load target
.byte $A0
; indirect data load target
.byte $EA
; indirect data load target
.byte $62
; indirect data load target
.byte $A4
; indirect data load target
.byte $63
; indirect data load target
.byte $95
; indirect data load target
.byte $61
; indirect data load target
.byte $AB
; indirect data load target
.byte $65
; indirect data load target
.byte $A9
; indirect data load target
.byte $68
; indirect data load target
.byte $E6
; indirect data load target
.byte $9F
; indirect data load target
.byte $91
; indirect data load target
.byte $A1
; indirect data load target
.byte $64
; indirect data load target
.byte $22
; indirect data load target
.byte $13
; indirect data load target
.byte $13
; indirect data load target
.byte $61
; indirect data load target
.byte $20
; indirect data load target
.byte $9D
; indirect data load target
.byte $9D
; indirect data load target
.byte $A3
; indirect data load target
.byte $64
; indirect data load target
.byte $E6
; indirect data load target
.byte $A0
; indirect data load target
.byte $81
; indirect data load target
.byte $A0
; indirect data load target
.byte $E3
; indirect data load target
.byte $81
; indirect data load target
.byte $E2
; indirect data load target
.byte $81
; indirect data load target
.byte $A0
; indirect data load target
.byte $81
; indirect data load target
.byte $A3
; indirect data load target
.byte $80
; indirect data load target
.byte $A1
; indirect data load target
.byte $E8
; indirect data load target
.byte $62
; indirect data load target
.byte $A3
; indirect data load target
.byte $63
; indirect data load target
.byte $8F
; indirect data load target
.byte $A1
; indirect data load target
.byte $84
; indirect data load target
.byte $BC
; indirect data load target
.byte $6C
; indirect data load target
.byte $E5
; indirect data load target
.byte $9F
; indirect data load target
.byte $8F
; indirect data load target
.byte $A1
; indirect data load target
.byte $64
; indirect data load target
.byte $24
; indirect data load target
.byte $13
; indirect data load target
.byte $13
; indirect data load target
.byte $60
; indirect data load target
.byte $9E
; indirect data load target
.byte $9F
; indirect data load target
.byte $A4
; indirect data load target
.byte $61
; indirect data load target
.byte $E6
; indirect data load target
.byte $A1
; indirect data load target
.byte $82
; indirect data load target
.byte $E8
; indirect data load target
.byte $82
; indirect data load target
.byte $A4
; indirect data load target
.byte $80
; indirect data load target
.byte $A0
; indirect data load target
.byte $E5
; indirect data load target
.byte $A1
; indirect data load target
.byte $E0
; indirect data load target
.byte $A6
; indirect data load target
.byte $63
; indirect data load target
.byte $20
; indirect data load target
.byte $8C
; indirect data load target
.byte $BF
; indirect data load target
.byte $A8
; indirect data load target
.byte $6B
; indirect data load target
.byte $E4
; indirect data load target
.byte $9F
; indirect data load target
.byte $8F
; indirect data load target
.byte $A0
; indirect data load target
.byte $64
; indirect data load target
.byte $26
; indirect data load target
.byte $13
; indirect data load target
.byte $13
; indirect data load target
.byte $9E
; indirect data load target
.byte $9F
; indirect data load target
.byte $A3
; indirect data load target
.byte $62
; indirect data load target
.byte $E6
; indirect data load target
.byte $A0
; indirect data load target
.byte $81
; indirect data load target
.byte $A0
; indirect data load target
.byte $E9
; indirect data load target
.byte $80
; indirect data load target
.byte $62
; indirect data load target
.byte $A3
; indirect data load target
.byte $80
; indirect data load target
.byte $A1
; indirect data load target
.byte $E1
; indirect data load target
.byte $A7
; indirect data load target
.byte $67
; indirect data load target
.byte $22
; indirect data load target
.byte $88
; indirect data load target
.byte $BF
; indirect data load target
.byte $AE
; indirect data load target
.byte $68
; indirect data load target
.byte $E4
; indirect data load target
.byte $9F
; indirect data load target
.byte $8E
; indirect data load target
.byte $A1
; indirect data load target
.byte $64
; indirect data load target
.byte $27
; indirect data load target
.byte $13
; indirect data load target
.byte $9E
; indirect data load target
.byte $9F
; indirect data load target
.byte $80
; indirect data load target
.byte $A6
; indirect data load target
.byte $E4
; indirect data load target
.byte $A1
; indirect data load target
.byte $80
; indirect data load target
.byte $A3
; indirect data load target
.byte $E2
; indirect data load target
.byte $41
; indirect data load target
.byte $E2
; indirect data load target
.byte $80
; indirect data load target
.byte $62
; indirect data load target
.byte $A3
; indirect data load target
.byte $85
; indirect data load target
.byte $A3
; indirect data load target
.byte $E1
; indirect data load target
.byte $67
; indirect data load target
.byte $24
; indirect data load target
.byte $BF
; indirect data load target
.byte $B9
; indirect data load target
.byte $65
; indirect data load target
.byte $E3
; indirect data load target
.byte $9F
; indirect data load target
.byte $8D
; indirect data load target
.byte $A2
; indirect data load target
.byte $62
; indirect data load target
.byte $00
; indirect data load target
.byte $12
; indirect data load target
.byte $26
; indirect data load target
.byte $E1
; indirect data load target
.byte $13
; indirect data load target
.byte $9E
; indirect data load target
.byte $9F
; indirect data load target
.byte $80
; indirect data load target
.byte $64
; indirect data load target
.byte $A2
; indirect data load target
.byte $E1
; indirect data load target
.byte $A3
; indirect data load target
.byte $80
; indirect data load target
.byte $A4
; indirect data load target
.byte $E1
; indirect data load target
.byte $41
; indirect data load target
.byte $E1
; indirect data load target
.byte $81
; indirect data load target
.byte $62
; indirect data load target
.byte $A3
; indirect data load target
.byte $80
; indirect data load target
.byte $63
; indirect data load target
.byte $81
; indirect data load target
.byte $A1
; indirect data load target
.byte $E3
; indirect data load target
.byte $65
; indirect data load target
.byte $24
; indirect data load target
.byte $BF
; indirect data load target
.byte $BD
; indirect data load target
.byte $61
; indirect data load target
.byte $E4
; indirect data load target
.byte $9F
; indirect data load target
.byte $8C
; indirect data load target
.byte $13
; indirect data load target
.byte $A1
; indirect data load target
.byte $63
; indirect data load target
.byte $10
; indirect data load target
.byte $11
; indirect data load target
.byte $25
; indirect data load target
.byte $E2
; indirect data load target
.byte $13
; indirect data load target
.byte $13
; indirect data load target
.byte $9D
; indirect data load target
.byte $9F
; indirect data load target
.byte $81
; indirect data load target
.byte $64
; indirect data load target
.byte $A7
; indirect data load target
.byte $81
; indirect data load target
.byte $A2
; indirect data load target
.byte $61
; indirect data load target
.byte $42
; indirect data load target
.byte $E1
; indirect data load target
.byte $80
; indirect data load target
.byte $62
; indirect data load target
.byte $A4
; indirect data load target
.byte $80
; indirect data load target
.byte $64
; indirect data load target
.byte $80
; indirect data load target
.byte $E6
; indirect data load target
.byte $63
; indirect data load target
.byte $23
; indirect data load target
.byte $BF
; indirect data load target
.byte $BF
; indirect data load target
.byte $A1
; indirect data load target
.byte $E4
; indirect data load target
.byte $9F
; indirect data load target
.byte $8B
; indirect data load target
.byte $13
; indirect data load target
.byte $A1
; indirect data load target
.byte $65
; indirect data load target
.byte $25
; indirect data load target
.byte $E4
; indirect data load target
.byte $13
; indirect data load target
.byte $9D
; indirect data load target
.byte $9F
; indirect data load target
.byte $81
; indirect data load target
.byte $65
; indirect data load target
.byte $A4
; indirect data load target
.byte $E2
; indirect data load target
.byte $83
; indirect data load target
.byte $62
; indirect data load target
.byte $41
; indirect data load target
.byte $E0
; indirect data load target
.byte $81
; indirect data load target
.byte $62
; indirect data load target
.byte $A3
; indirect data load target
.byte $81
; indirect data load target
.byte $64
; indirect data load target
.byte $82
; indirect data load target
.byte $E5
; indirect data load target
.byte $62
; indirect data load target
.byte $22
; indirect data load target
.byte $BF
; indirect data load target
.byte $BF
; indirect data load target
.byte $A4
; indirect data load target
.byte $E2
; indirect data load target
.byte $9F
; indirect data load target
.byte $8A
; indirect data load target
.byte $13
; indirect data load target
.byte $A0
; indirect data load target
.byte $68
; indirect data load target
.byte $A3
; indirect data load target
.byte $E5
; indirect data load target
.byte $13
; indirect data load target
.byte $9D
; indirect data load target
.byte $9F
; indirect data load target
.byte $82
; indirect data load target
.byte $65
; indirect data load target
.byte $A3
; indirect data load target
.byte $E5
; indirect data load target
.byte $81
; indirect data load target
.byte $62
; indirect data load target
.byte $E1
; indirect data load target
.byte $80
; indirect data load target
.byte $E1
; indirect data load target
.byte $A4
; indirect data load target
.byte $81
; indirect data load target
.byte $67
; indirect data load target
.byte $80
; indirect data load target
.byte $E7
; indirect data load target
.byte $21
; indirect data load target
.byte $BF
; indirect data load target
.byte $BF
; indirect data load target
.byte $A5
; indirect data load target
.byte $C4
; indirect data load target
.byte $9F
; indirect data load target
.byte $89
; indirect data load target
.byte $13
; indirect data load target
.byte $A0
; indirect data load target
.byte $63
; indirect data load target
.byte $A9
; indirect data load target
.byte $E4
; indirect data load target
.byte $13
; indirect data load target
.byte $13
; indirect data load target
.byte $9C
; indirect data load target
.byte $9F
; indirect data load target
.byte $82
; indirect data load target
.byte $68
; indirect data load target
.byte $E7
; indirect data load target
.byte $80
; indirect data load target
.byte $62
; indirect data load target
.byte $E1
; indirect data load target
.byte $80
; indirect data load target
.byte $E1
; indirect data load target
.byte $A3
; indirect data load target
.byte $60
; indirect data load target
.byte $80
; indirect data load target
.byte $63
; indirect data load target
.byte $0A
; indirect data load target
.byte $63
; indirect data load target
.byte $80
; indirect data load target
.byte $60
; indirect data load target
.byte $E4
; indirect data load target
.byte $BA
; indirect data load target
.byte $62
; indirect data load target
.byte $A2
; indirect data load target
.byte $67
; indirect data load target
.byte $A3
; indirect data load target
.byte $6A
; indirect data load target
.byte $B1
; indirect data load target
.byte $C4
; indirect data load target
.byte $9F
; indirect data load target
.byte $89
; indirect data load target
.byte $13
; indirect data load target
.byte $A0
; indirect data load target
.byte $63
; indirect data load target
.byte $A3
; indirect data load target
.byte $84
; indirect data load target
.byte $61
; indirect data load target
.byte $E4
; indirect data load target
.byte $13
; indirect data load target
.byte $9C
; indirect data load target
.byte $9F
; indirect data load target
.byte $84
; indirect data load target
.byte $A0
; indirect data load target
.byte $66
; indirect data load target
.byte $E6
; indirect data load target
.byte $80
; indirect data load target
.byte $62
; indirect data load target
.byte $E1
; indirect data load target
.byte $80
; indirect data load target
.byte $E1
; indirect data load target
.byte $A3
; indirect data load target
.byte $60
; indirect data load target
.byte $81
; indirect data load target
.byte $65
; indirect data load target
.byte $82
; indirect data load target
.byte $61
; indirect data load target
.byte $E2
; indirect data load target
.byte $B9
; indirect data load target
.byte $7F
; indirect data load target
.byte $B0
; indirect data load target
.byte $C3
; indirect data load target
.byte $9F
; indirect data load target
.byte $8A
; indirect data load target
.byte $13
; indirect data load target
.byte $A5
; indirect data load target
.byte $88
; indirect data load target
.byte $62
; indirect data load target
.byte $E2
; indirect data load target
.byte $13
; indirect data load target
.byte $9C
; indirect data load target
.byte $9F
; indirect data load target
.byte $84
; indirect data load target
.byte $A1
; indirect data load target
.byte $66
; indirect data load target
.byte $E5
; indirect data load target
.byte $80
; indirect data load target
.byte $62
; indirect data load target
.byte $E1
; indirect data load target
.byte $80
; indirect data load target
.byte $E2
; indirect data load target
.byte $A2
; indirect data load target
.byte $61
; indirect data load target
.byte $82
; indirect data load target
.byte $62
; indirect data load target
.byte $81
; indirect data load target
.byte $65
; indirect data load target
.byte $B6
; indirect data load target
.byte $70
; indirect data load target
.byte $E2
; indirect data load target
.byte $71
; indirect data load target
.byte $AF
; indirect data load target
.byte $C2
; indirect data load target
.byte $9F
; indirect data load target
.byte $92
; indirect data load target
.byte $A1
; indirect data load target
.byte $85
; indirect data load target
.byte $62
; indirect data load target
.byte $E2
; indirect data load target
.byte $13
; indirect data load target
.byte $9C
; indirect data load target
.byte $9F
; indirect data load target
.byte $85
; indirect data load target
.byte $A1
; indirect data load target
.byte $67
; indirect data load target
.byte $E2
; indirect data load target
.byte $82
; indirect data load target
.byte $60
; indirect data load target
.byte $E1
; indirect data load target
.byte $81
; indirect data load target
.byte $E3
; indirect data load target
.byte $A2
; indirect data load target
.byte $62
; indirect data load target
.byte $80
; indirect data load target
.byte $62
; indirect data load target
.byte $80
; indirect data load target
.byte $65
; indirect data load target
.byte $B2
; indirect data load target
.byte $68
; indirect data load target
.byte $A2
; indirect data load target
.byte $84
; indirect data load target
.byte $A4
; indirect data load target
.byte $E2
; indirect data load target
.byte $72
; indirect data load target
.byte $AE
; indirect data load target
.byte $C1
; indirect data load target
.byte $9F
; indirect data load target
.byte $8B
; indirect data load target
.byte $13
; indirect data load target
.byte $A8
; indirect data load target
.byte $85
; indirect data load target
.byte $64
; indirect data load target
.byte $E0
; indirect data load target
.byte $13
; indirect data load target
.byte $9C
; indirect data load target
.byte $9F
; indirect data load target
.byte $86
; indirect data load target
.byte $A1
; indirect data load target
.byte $69
; indirect data load target
.byte $80
; indirect data load target
.byte $60
; indirect data load target
.byte $80
; indirect data load target
.byte $0D
; indirect data load target
.byte $80
; indirect data load target
.byte $E0
; indirect data load target
.byte $80
; indirect data load target
.byte $E4
; indirect data load target
.byte $A4
; indirect data load target
.byte $60
; indirect data load target
.byte $81
; indirect data load target
.byte $61
; indirect data load target
.byte $80
; indirect data load target
.byte $62
; indirect data load target
.byte $B4
; indirect data load target
.byte $67
; indirect data load target
.byte $A2
; indirect data load target
.byte $88
; indirect data load target
.byte $E6
; indirect data load target
.byte $72
; indirect data load target
.byte $AE
; indirect data load target
.byte $9F
; indirect data load target
.byte $8C
; indirect data load target
.byte $13
; indirect data load target
.byte $69
; indirect data load target
.byte $83
; indirect data load target
.byte $21
; indirect data load target
.byte $64
; indirect data load target
.byte $13
; indirect data load target
.byte $9C
; indirect data load target
.byte $9F
; indirect data load target
.byte $87
; indirect data load target
.byte $A1
; indirect data load target
.byte $66
; indirect data load target
.byte $82
; indirect data load target
.byte $62
; indirect data load target
.byte $82
; indirect data load target
.byte $E4
; indirect data load target
.byte $A4
; indirect data load target
.byte $61
; indirect data load target
.byte $83
; indirect data load target
.byte $61
; indirect data load target
.byte $B2
; indirect data load target
.byte $68
; indirect data load target
.byte $A3
; indirect data load target
.byte $89
; indirect data load target
.byte $E7
; indirect data load target
.byte $68
; indirect data load target
.byte $85
; indirect data load target
.byte $62
; indirect data load target
.byte $AD
; indirect data load target
.byte $9F
; indirect data load target
.byte $8D
; indirect data load target
.byte $13
; indirect data load target
.byte $13
; indirect data load target
.byte $65
; indirect data load target
.byte $29
; indirect data load target
.byte $63
; indirect data load target
.byte $13
; indirect data load target
.byte $9C
; indirect data load target
.byte $9F
; indirect data load target
.byte $88
; indirect data load target
.byte $A1
; indirect data load target
.byte $63
; indirect data load target
.byte $82
; indirect data load target
.byte $63
; indirect data load target
.byte $C2
; indirect data load target
.byte $80
; indirect data load target
.byte $E2
; indirect data load target
.byte $A7
; indirect data load target
.byte $E5
; indirect data load target
.byte $B2
; indirect data load target
.byte $66
; indirect data load target
.byte $A5
; indirect data load target
.byte $87
; indirect data load target
.byte $EB
; indirect data load target
.byte $65
; indirect data load target
.byte $88
; indirect data load target
.byte $61
; indirect data load target
.byte $AD
; indirect data load target
.byte $9F
; indirect data load target
.byte $8E
; indirect data load target
.byte $13
; indirect data load target
.byte $63
; indirect data load target
.byte $2C
; indirect data load target
.byte $62
; indirect data load target
.byte $13
; indirect data load target
.byte $9C
; indirect data load target
.byte $9F
; indirect data load target
.byte $89
; indirect data load target
.byte $A0
; indirect data load target
.byte $63
; indirect data load target
.byte $80
; indirect data load target
.byte $A3
; indirect data load target
.byte $C4
; indirect data load target
.byte $81
; indirect data load target
.byte $E2
; indirect data load target
.byte $BF
; indirect data load target
.byte $65
; indirect data load target
.byte $81
; indirect data load target
.byte $A4
; indirect data load target
.byte $83
; indirect data load target
.byte $A1
; indirect data load target
.byte $EF
; indirect data load target
.byte $81
; indirect data load target
.byte $40
; indirect data load target
.byte $8B
; indirect data load target
.byte $AD
; indirect data load target
.byte $9F
; indirect data load target
.byte $8E
; indirect data load target
.byte $13
; indirect data load target
.byte $64
; indirect data load target
.byte $2A
; indirect data load target
.byte $62
; indirect data load target
.byte $13
; indirect data load target
.byte $9D
; indirect data load target
.byte $9F
; indirect data load target
.byte $89
; indirect data load target
.byte $A1
; indirect data load target
.byte $61
; indirect data load target
.byte $A0
; indirect data load target
.byte $81
; indirect data load target
.byte $A1
; indirect data load target
.byte $C4
; indirect data load target
.byte $21
; indirect data load target
.byte $80
; indirect data load target
.byte $E3
; indirect data load target
.byte $BD
; indirect data load target
.byte $64
; indirect data load target
.byte $8B
; indirect data load target
.byte $A1
; indirect data load target
.byte $E4
; indirect data load target
.byte $A5
; indirect data load target
.byte $E2
; indirect data load target
.byte $84
; indirect data load target
.byte $40
; indirect data load target
.byte $85
; indirect data load target
.byte $A1
; indirect data load target
.byte $84
; indirect data load target
.byte $AC
; indirect data load target
.byte $9F
; indirect data load target
.byte $8E
; indirect data load target
.byte $13
; indirect data load target
.byte $66
; indirect data load target
.byte $24
; indirect data load target
.byte $66
; indirect data load target
.byte $13
; indirect data load target
.byte $9D
; indirect data load target
.byte $96
; indirect data load target
.byte $A4
; indirect data load target
.byte $8E
; indirect data load target
.byte $A4
; indirect data load target
.byte $80
; indirect data load target
.byte $A0
; indirect data load target
.byte $C3
; indirect data load target
.byte $22
; indirect data load target
.byte $A0
; indirect data load target
.byte $83
; indirect data load target
.byte $E4
; indirect data load target
.byte $B9
; indirect data load target
.byte $64
; indirect data load target
.byte $8C
; indirect data load target
.byte $E3
; indirect data load target
.byte $A8
; indirect data load target
.byte $86
; indirect data load target
.byte $40
; indirect data load target
.byte $84
; indirect data load target
.byte $A0
; indirect data load target
.byte $0B
; indirect data load target
.byte $61
; indirect data load target
.byte $83
; indirect data load target
.byte $AB
; indirect data load target
.byte $9F
; indirect data load target
.byte $90
; indirect data load target
.byte $13
; indirect data load target
.byte $A0
; indirect data load target
.byte $6F
; indirect data load target
.byte $13
; indirect data load target
.byte $13
; indirect data load target
.byte $9D
; indirect data load target
.byte $95
; indirect data load target
.byte $A1
; indirect data load target
.byte $62
; indirect data load target
.byte $A1
; indirect data load target
.byte $8E
; indirect data load target
.byte $A3
; indirect data load target
.byte $80
; indirect data load target
.byte $A0
; indirect data load target
.byte $C1
; indirect data load target
.byte $23
; indirect data load target
.byte $A4
; indirect data load target
.byte $84
; indirect data load target
.byte $E4
; indirect data load target
.byte $B4
; indirect data load target
.byte $66
; indirect data load target
.byte $8B
; indirect data load target
.byte $E2
; indirect data load target
.byte $A6
; indirect data load target
.byte $89
; indirect data load target
.byte $41
; indirect data load target
.byte $09
; indirect data load target
.byte $60
; indirect data load target
.byte $09
; indirect data load target
.byte $63
; indirect data load target
.byte $84
; indirect data load target
.byte $AB
; indirect data load target
.byte $9F
; indirect data load target
.byte $91
; indirect data load target
.byte $A3
; indirect data load target
.byte $67
; indirect data load target
.byte $A4
; indirect data load target
.byte $13
; indirect data load target
.byte $9E
; indirect data load target
.byte $94
; indirect data load target
.byte $A1
; indirect data load target
.byte $64
; indirect data load target
.byte $A1
; indirect data load target
.byte $92
; indirect data load target
.byte $A2
; indirect data load target
.byte $22
; indirect data load target
.byte $A9
; indirect data load target
.byte $82
; indirect data load target
.byte $E1
; indirect data load target
.byte $61
; indirect data load target
.byte $AF
; indirect data load target
.byte $69
; indirect data load target
.byte $E4
; indirect data load target
.byte $84
; indirect data load target
.byte $A2
; indirect data load target
.byte $E2
; indirect data load target
.byte $A5
; indirect data load target
.byte $90
; indirect data load target
.byte $61
; indirect data load target
.byte $84
; indirect data load target
.byte $AC
; indirect data load target
.byte $9F
; indirect data load target
.byte $93
; indirect data load target
.byte $AC
; indirect data load target
.byte $9F
; indirect data load target
.byte $81
; indirect data load target
.byte $93
; indirect data load target
.byte $A1
; indirect data load target
.byte $62
; indirect data load target
.byte $0B
; indirect data load target
.byte $62
; indirect data load target
.byte $A0
; indirect data load target
.byte $8D
; indirect data load target
.byte $63
; indirect data load target
.byte $80
; indirect data load target
.byte $13
; indirect data load target
.byte $13
; indirect data load target
.byte $A0
; indirect data load target
.byte $13
; indirect data load target
.byte $20
; indirect data load target
.byte $AC
; indirect data load target
.byte $80
; indirect data load target
.byte $64
; indirect data load target
.byte $AE
; indirect data load target
.byte $6A
; indirect data load target
.byte $E8
; indirect data load target
.byte $A3
; indirect data load target
.byte $E1
; indirect data load target
.byte $A5
; indirect data load target
.byte $82
; indirect data load target
.byte $E1
; indirect data load target
.byte $8B
; indirect data load target
.byte $0D
; indirect data load target
.byte $13
; indirect data load target
.byte $83
; indirect data load target
.byte $AD
; indirect data load target
.byte $9F
; indirect data load target
.byte $96
; indirect data load target
.byte $A5
; indirect data load target
.byte $9F
; indirect data load target
.byte $85
; indirect data load target
.byte $93
; indirect data load target
.byte $A0
; indirect data load target
.byte $66
; indirect data load target
.byte $A1
; indirect data load target
.byte $8D
; indirect data load target
.byte $21
; indirect data load target
.byte $63
; indirect data load target
.byte $13
; indirect data load target
.byte $60
; indirect data load target
.byte $09
; indirect data load target
.byte $20
; indirect data load target
.byte $A0
; indirect data load target
.byte $83
; indirect data load target
.byte $A6
; indirect data load target
.byte $60
; indirect data load target
.byte $81
; indirect data load target
.byte $63
; indirect data load target
.byte $AC
; indirect data load target
.byte $64
; indirect data load target
.byte $81
; indirect data load target
.byte $61
; indirect data load target
.byte $86
; indirect data load target
.byte $E6
; indirect data load target
.byte $A3
; indirect data load target
.byte $E1
; indirect data load target
.byte $A4
; indirect data load target
.byte $81
; indirect data load target
.byte $E6
; indirect data load target
.byte $87
; indirect data load target
.byte $61
; indirect data load target
.byte $82
; indirect data load target
.byte $AE
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $82
; indirect data load target
.byte $93
; indirect data load target
.byte $A0
; indirect data load target
.byte $66
; indirect data load target
.byte $A0
; indirect data load target
.byte $8E
; indirect data load target
.byte $22
; indirect data load target
.byte $64
; indirect data load target
.byte $13
; indirect data load target
.byte $13
; indirect data load target
.byte $13
; indirect data load target
.byte $84
; indirect data load target
.byte $A3
; indirect data load target
.byte $62
; indirect data load target
.byte $80
; indirect data load target
.byte $65
; indirect data load target
.byte $AB
; indirect data load target
.byte $62
; indirect data load target
.byte $8C
; indirect data load target
.byte $E7
; indirect data load target
.byte $A3
; indirect data load target
.byte $E1
; indirect data load target
.byte $A5
; indirect data load target
.byte $E7
; indirect data load target
.byte $22
; indirect data load target
.byte $83
; indirect data load target
.byte $13
; indirect data load target
.byte $60
; indirect data load target
.byte $09
; indirect data load target
.byte $60
; indirect data load target
.byte $AF
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $82
; indirect data load target
.byte $93
; indirect data load target
.byte $A0
; indirect data load target
.byte $65
; indirect data load target
.byte $A1
; indirect data load target
.byte $8F
; indirect data load target
.byte $22
; indirect data load target
.byte $64
; indirect data load target
.byte $87
; indirect data load target
.byte $A1
; indirect data load target
.byte $63
; indirect data load target
.byte $80
; indirect data load target
.byte $65
; indirect data load target
.byte $AA
; indirect data load target
.byte $63
; indirect data load target
.byte $87
; indirect data load target
.byte $A5
; indirect data load target
.byte $E6
; indirect data load target
.byte $A4
; indirect data load target
.byte $E2
; indirect data load target
.byte $A1
; indirect data load target
.byte $E7
; indirect data load target
.byte $25
; indirect data load target
.byte $82
; indirect data load target
.byte $13
; indirect data load target
.byte $13
; indirect data load target
.byte $13
; indirect data load target
.byte $60
; indirect data load target
.byte $AE
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $83
; indirect data load target
.byte $93
; indirect data load target
.byte $A1
; indirect data load target
.byte $64
; indirect data load target
.byte $A2
; indirect data load target
.byte $8E
; indirect data load target
.byte $23
; indirect data load target
.byte $63
; indirect data load target
.byte $88
; indirect data load target
.byte $A1
; indirect data load target
.byte $62
; indirect data load target
.byte $81
; indirect data load target
.byte $64
; indirect data load target
.byte $AA
; indirect data load target
.byte $62
; indirect data load target
.byte $85
; indirect data load target
.byte $A1
; indirect data load target
.byte $63
; indirect data load target
.byte $A6
; indirect data load target
.byte $E3
; indirect data load target
.byte $42
; indirect data load target
.byte $A2
; indirect data load target
.byte $EA
; indirect data load target
.byte $2D
; indirect data load target
.byte $AD
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $83
; indirect data load target
.byte $94
; indirect data load target
.byte $A0
; indirect data load target
.byte $62
; indirect data load target
.byte $E2
; indirect data load target
.byte $A2
; indirect data load target
.byte $8E
; indirect data load target
.byte $21
; indirect data load target
.byte $63
; indirect data load target
.byte $8A
; indirect data load target
.byte $A1
; indirect data load target
.byte $62
; indirect data load target
.byte $80
; indirect data load target
.byte $63
; indirect data load target
.byte $AB
; indirect data load target
.byte $62
; indirect data load target
.byte $84
; indirect data load target
.byte $A0
; indirect data load target
.byte $43
; indirect data load target
.byte $62
; indirect data load target
.byte $AA
; indirect data load target
.byte $42
; indirect data load target
.byte $A6
; indirect data load target
.byte $E4
; indirect data load target
.byte $2E
; indirect data load target
.byte $AD
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $83
; indirect data load target
.byte $94
; indirect data load target
.byte $A1
; indirect data load target
.byte $E4
; indirect data load target
.byte $A2
; indirect data load target
.byte $8E
; indirect data load target
.byte $63
; indirect data load target
.byte $8D
; indirect data load target
.byte $62
; indirect data load target
.byte $81
; indirect data load target
.byte $62
; indirect data load target
.byte $AC
; indirect data load target
.byte $62
; indirect data load target
.byte $83
; indirect data load target
.byte $A0
; indirect data load target
.byte $45
; indirect data load target
.byte $62
; indirect data load target
.byte $21
; indirect data load target
.byte $A3
; indirect data load target
.byte $E2
; indirect data load target
.byte $A2
; indirect data load target
.byte $41
; indirect data load target
.byte $A5
; indirect data load target
.byte $E3
; indirect data load target
.byte $25
; indirect data load target
.byte $61
; indirect data load target
.byte $26
; indirect data load target
.byte $AD
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $84
; indirect data load target
.byte $95
; indirect data load target
.byte $A0
; indirect data load target
.byte $E5
; indirect data load target
.byte $A1
; indirect data load target
.byte $9F
; indirect data load target
.byte $84
; indirect data load target
.byte $E3
; indirect data load target
.byte $AB
; indirect data load target
.byte $62
; indirect data load target
.byte $83
; indirect data load target
.byte $A1
; indirect data load target
.byte $40
; indirect data load target
.byte $00
; indirect data load target
.byte $12
; indirect data load target
.byte $43
; indirect data load target
.byte $61
; indirect data load target
.byte $21
; indirect data load target
.byte $A1
; indirect data load target
.byte $E5
; indirect data load target
.byte $A1
; indirect data load target
.byte $41
; indirect data load target
.byte $A9
; indirect data load target
.byte $25
; indirect data load target
.byte $62
; indirect data load target
.byte $23
; indirect data load target
.byte $AF
; indirect data load target
.byte $98
; indirect data load target
.byte $13
; indirect data load target
.byte $13
; indirect data load target
.byte $13
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $88
; indirect data load target
.byte $95
; indirect data load target
.byte $A2
; indirect data load target
.byte $E4
; indirect data load target
.byte $A2
; indirect data load target
.byte $9E
; indirect data load target
.byte $E7
; indirect data load target
.byte $AB
; indirect data load target
.byte $62
; indirect data load target
.byte $83
; indirect data load target
.byte $A1
; indirect data load target
.byte $40
; indirect data load target
.byte $10
; indirect data load target
.byte $11
; indirect data load target
.byte $42
; indirect data load target
.byte $62
; indirect data load target
.byte $22
; indirect data load target
.byte $A4
; indirect data load target
.byte $E1
; indirect data load target
.byte $A1
; indirect data load target
.byte $41
; indirect data load target
.byte $AA
; indirect data load target
.byte $25
; indirect data load target
.byte $61
; indirect data load target
.byte $22
; indirect data load target
.byte $AF
; indirect data load target
.byte $98
; indirect data load target
.byte $13
; indirect data load target
.byte $13
; indirect data load target
.byte $A0
; indirect data load target
.byte $13
; indirect data load target
.byte $13
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $87
; indirect data load target
.byte $95
; indirect data load target
.byte $A3
; indirect data load target
.byte $E4
; indirect data load target
.byte $A3
; indirect data load target
.byte $9D
; indirect data load target
.byte $E5
; indirect data load target
.byte $AC
; indirect data load target
.byte $62
; indirect data load target
.byte $84
; indirect data load target
.byte $A0
; indirect data load target
.byte $45
; indirect data load target
.byte $61
; indirect data load target
.byte $21
; indirect data load target
.byte $A6
; indirect data load target
.byte $E1
; indirect data load target
.byte $A1
; indirect data load target
.byte $40
; indirect data load target
.byte $AB
; indirect data load target
.byte $E3
; indirect data load target
.byte $26
; indirect data load target
.byte $AF
; indirect data load target
.byte $98
; indirect data load target
.byte $13
; indirect data load target
.byte $A2
; indirect data load target
.byte $13
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $87
; indirect data load target
.byte $95
; indirect data load target
.byte $A5
; indirect data load target
.byte $E3
; indirect data load target
.byte $A3
; indirect data load target
.byte $9C
; indirect data load target
.byte $61
; indirect data load target
.byte $E3
; indirect data load target
.byte $AC
; indirect data load target
.byte $63
; indirect data load target
.byte $83
; indirect data load target
.byte $A1
; indirect data load target
.byte $43
; indirect data load target
.byte $61
; indirect data load target
.byte $22
; indirect data load target
.byte $A5
; indirect data load target
.byte $E2
; indirect data load target
.byte $A1
; indirect data load target
.byte $40
; indirect data load target
.byte $AA
; indirect data load target
.byte $E5
; indirect data load target
.byte $24
; indirect data load target
.byte $AF
; indirect data load target
.byte $99
; indirect data load target
.byte $13
; indirect data load target
.byte $A0
; indirect data load target
.byte $0C
; indirect data load target
.byte $A0
; indirect data load target
.byte $13
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $87
; indirect data load target
.byte $96
; indirect data load target
.byte $A5
; indirect data load target
.byte $E4
; indirect data load target
.byte $A4
; indirect data load target
.byte $99
; indirect data load target
.byte $61
; indirect data load target
.byte $E3
; indirect data load target
.byte $AC
; indirect data load target
.byte $63
; indirect data load target
.byte $84
; indirect data load target
.byte $A1
; indirect data load target
.byte $64
; indirect data load target
.byte $21
; indirect data load target
.byte $A4
; indirect data load target
.byte $60
; indirect data load target
.byte $E2
; indirect data load target
.byte $A1
; indirect data load target
.byte $41
; indirect data load target
.byte $A9
; indirect data load target
.byte $E7
; indirect data load target
.byte $23
; indirect data load target
.byte $AE
; indirect data load target
.byte $9A
; indirect data load target
.byte $13
; indirect data load target
.byte $82
; indirect data load target
.byte $13
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $87
; indirect data load target
.byte $97
; indirect data load target
.byte $A1
; indirect data load target
.byte $E3
; indirect data load target
.byte $63
; indirect data load target
.byte $E3
; indirect data load target
.byte $A1
; indirect data load target
.byte $98
; indirect data load target
.byte $61
; indirect data load target
.byte $E4
; indirect data load target
.byte $AB
; indirect data load target
.byte $64
; indirect data load target
.byte $84
; indirect data load target
.byte $A4
; indirect data load target
.byte $21
; indirect data load target
.byte $A3
; indirect data load target
.byte $63
; indirect data load target
.byte $44
; indirect data load target
.byte $A7
; indirect data load target
.byte $C2
; indirect data load target
.byte $E7
; indirect data load target
.byte $22
; indirect data load target
.byte $AF
; indirect data load target
.byte $9A
; indirect data load target
.byte $13
; indirect data load target
.byte $13
; indirect data load target
.byte $80
; indirect data load target
.byte $13
; indirect data load target
.byte $13
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $87
; indirect data load target
.byte $97
; indirect data load target
.byte $A0
; indirect data load target
.byte $E3
; indirect data load target
.byte $65
; indirect data load target
.byte $E3
; indirect data load target
.byte $A1
; indirect data load target
.byte $98
; indirect data load target
.byte $61
; indirect data load target
.byte $E3
; indirect data load target
.byte $AC
; indirect data load target
.byte $62
; indirect data load target
.byte $85
; indirect data load target
.byte $A2
; indirect data load target
.byte $E2
; indirect data load target
.byte $A4
; indirect data load target
.byte $63
; indirect data load target
.byte $A1
; indirect data load target
.byte $41
; indirect data load target
.byte $A6
; indirect data load target
.byte $C5
; indirect data load target
.byte $E6
; indirect data load target
.byte $22
; indirect data load target
.byte $AE
; indirect data load target
.byte $9C
; indirect data load target
.byte $13
; indirect data load target
.byte $13
; indirect data load target
.byte $13
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $88
; indirect data load target
.byte $96
; indirect data load target
.byte $A2
; indirect data load target
.byte $E1
; indirect data load target
.byte $67
; indirect data load target
.byte $E3
; indirect data load target
.byte $A1
; indirect data load target
.byte $97
; indirect data load target
.byte $61
; indirect data load target
.byte $E3
; indirect data load target
.byte $AE
; indirect data load target
.byte $60
; indirect data load target
.byte $84
; indirect data load target
.byte $A2
; indirect data load target
.byte $E3
; indirect data load target
.byte $A3
; indirect data load target
.byte $62
; indirect data load target
.byte $A2
; indirect data load target
.byte $42
; indirect data load target
.byte $A5
; indirect data load target
.byte $C6
; indirect data load target
.byte $E5
; indirect data load target
.byte $24
; indirect data load target
.byte $AD
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $88
; indirect data load target
.byte $96
; indirect data load target
.byte $A1
; indirect data load target
.byte $E1
; indirect data load target
.byte $67
; indirect data load target
.byte $E5
; indirect data load target
.byte $A0
; indirect data load target
.byte $97
; indirect data load target
.byte $61
; indirect data load target
.byte $E3
; indirect data load target
.byte $AE
; indirect data load target
.byte $61
; indirect data load target
.byte $85
; indirect data load target
.byte $A1
; indirect data load target
.byte $E4
; indirect data load target
.byte $A1
; indirect data load target
.byte $62
; indirect data load target
.byte $A1
; indirect data load target
.byte $42
; indirect data load target
.byte $A5
; indirect data load target
.byte $C5
; indirect data load target
.byte $E6
; indirect data load target
.byte $25
; indirect data load target
.byte $AC
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $89
; indirect data load target
.byte $96
; indirect data load target
.byte $A0
; indirect data load target
.byte $E2
; indirect data load target
.byte $62
; indirect data load target
.byte $83
; indirect data load target
.byte $61
; indirect data load target
.byte $E2
; indirect data load target
.byte $A2
; indirect data load target
.byte $85
; indirect data load target
.byte $A4
; indirect data load target
.byte $8C
; indirect data load target
.byte $62
; indirect data load target
.byte $E1
; indirect data load target
.byte $B0
; indirect data load target
.byte $62
; indirect data load target
.byte $84
; indirect data load target
.byte $A1
; indirect data load target
.byte $E3
; indirect data load target
.byte $A5
; indirect data load target
.byte $C1
; indirect data load target
.byte $A8
; indirect data load target
.byte $C5
; indirect data load target
.byte $E4
; indirect data load target
.byte $25
; indirect data load target
.byte $AD
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $89
; indirect data load target
.byte $95
; indirect data load target
.byte $A1
; indirect data load target
.byte $E3
; indirect data load target
.byte $61
; indirect data load target
.byte $85
; indirect data load target
.byte $E2
; indirect data load target
.byte $A2
; indirect data load target
.byte $83
; indirect data load target
.byte $A7
; indirect data load target
.byte $8C
; indirect data load target
.byte $63
; indirect data load target
.byte $B1
; indirect data load target
.byte $62
; indirect data load target
.byte $85
; indirect data load target
.byte $E3
; indirect data load target
.byte $A1
; indirect data load target
.byte $C5
; indirect data load target
.byte $A9
; indirect data load target
.byte $C3
; indirect data load target
.byte $63
; indirect data load target
.byte $26
; indirect data load target
.byte $AE
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $89
; indirect data load target
.byte $94
; indirect data load target
.byte $A3
; indirect data load target
.byte $E2
; indirect data load target
.byte $87
; indirect data load target
.byte $E2
; indirect data load target
.byte $A2
; indirect data load target
.byte $82
; indirect data load target
.byte $A2
; indirect data load target
.byte $E2
; indirect data load target
.byte $A2
; indirect data load target
.byte $8C
; indirect data load target
.byte $64
; indirect data load target
.byte $B2
; indirect data load target
.byte $62
; indirect data load target
.byte $83
; indirect data load target
.byte $E2
; indirect data load target
.byte $A1
; indirect data load target
.byte $C2
; indirect data load target
.byte $22
; indirect data load target
.byte $A1
; indirect data load target
.byte $83
; indirect data load target
.byte $A7
; indirect data load target
.byte $65
; indirect data load target
.byte $25
; indirect data load target
.byte $AD
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $8A
; indirect data load target
.byte $94
; indirect data load target
.byte $A3
; indirect data load target
.byte $E2
; indirect data load target
.byte $85
; indirect data load target
.byte $25
; indirect data load target
.byte $A6
; indirect data load target
.byte $E4
; indirect data load target
.byte $A1
; indirect data load target
.byte $13
; indirect data load target
.byte $13
; indirect data load target
.byte $13
; indirect data load target
.byte $13
; indirect data load target
.byte $89
; indirect data load target
.byte $64
; indirect data load target
.byte $B3
; indirect data load target
.byte $68
; indirect data load target
.byte $C1
; indirect data load target
.byte $24
; indirect data load target
.byte $A0
; indirect data load target
.byte $85
; indirect data load target
.byte $A2
; indirect data load target
.byte $82
; indirect data load target
.byte $67
; indirect data load target
.byte $24
; indirect data load target
.byte $AD
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $8A
; indirect data load target
.byte $94
; indirect data load target
.byte $A4
; indirect data load target
.byte $E3
; indirect data load target
.byte $2F
; indirect data load target
.byte $E7
; indirect data load target
.byte $09
; indirect data load target
.byte $C2
; indirect data load target
.byte $13
; indirect data load target
.byte $8A
; indirect data load target
.byte $62
; indirect data load target
.byte $B6
; indirect data load target
.byte $63
; indirect data load target
.byte $26
; indirect data load target
.byte $A2
; indirect data load target
.byte $8B
; indirect data load target
.byte $67
; indirect data load target
.byte $23
; indirect data load target
.byte $AE
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $8A
; indirect data load target
.byte $94
; indirect data load target
.byte $A5
; indirect data load target
.byte $E1
; indirect data load target
.byte $2F
; indirect data load target
.byte $E7
; indirect data load target
.byte $81
; indirect data load target
.byte $C3
; indirect data load target
.byte $13
; indirect data load target
.byte $8B
; indirect data load target
.byte $61
; indirect data load target
.byte $B9
; indirect data load target
.byte $26
; indirect data load target
.byte $A2
; indirect data load target
.byte $8A
; indirect data load target
.byte $67
; indirect data load target
.byte $23
; indirect data load target
.byte $AE
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $8B
; indirect data load target
.byte $94
; indirect data load target
.byte $A4
; indirect data load target
.byte $E2
; indirect data load target
.byte $2F
; indirect data load target
.byte $E6
; indirect data load target
.byte $81
; indirect data load target
.byte $C4
; indirect data load target
.byte $13
; indirect data load target
.byte $8E
; indirect data load target
.byte $BF
; indirect data load target
.byte $A3
; indirect data load target
.byte $84
; indirect data load target
.byte $E0
; indirect data load target
.byte $83
; indirect data load target
.byte $65
; indirect data load target
.byte $24
; indirect data load target
.byte $AF
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $8B
; indirect data load target
.byte $95
; indirect data load target
.byte $A5
; indirect data load target
.byte $31
; indirect data load target
.byte $E5
; indirect data load target
.byte $80
; indirect data load target
.byte $C5
; indirect data load target
.byte $13
; indirect data load target
.byte $90
; indirect data load target
.byte $BF
; indirect data load target
.byte $A2
; indirect data load target
.byte $87
; indirect data load target
.byte $64
; indirect data load target
.byte $25
; indirect data load target
.byte $B0
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $8B
; indirect data load target
.byte $95
; indirect data load target
.byte $A5
; indirect data load target
.byte $2F
; indirect data load target
.byte $A4
; indirect data load target
.byte $E1
; indirect data load target
.byte $81
; indirect data load target
.byte $C5
; indirect data load target
.byte $13
; indirect data load target
.byte $91
; indirect data load target
.byte $BF
; indirect data load target
.byte $A3
; indirect data load target
.byte $84
; indirect data load target
.byte $2A
; indirect data load target
.byte $B0
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $8C
; indirect data load target
.byte $96
; indirect data load target
.byte $A5
; indirect data load target
.byte $29
; indirect data load target
.byte $A7
; indirect data load target
.byte $84
; indirect data load target
.byte $C5
; indirect data load target
.byte $13
; indirect data load target
.byte $13
; indirect data load target
.byte $92
; indirect data load target
.byte $BF
; indirect data load target
.byte $A4
; indirect data load target
.byte $2D
; indirect data load target
.byte $B0
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $8C
; indirect data load target
.byte $96
; indirect data load target
.byte $B1
; indirect data load target
.byte $48
; indirect data load target
.byte $80
; indirect data load target
.byte $E4
; indirect data load target
.byte $C1
; indirect data load target
.byte $13
; indirect data load target
.byte $95
; indirect data load target
.byte $BF
; indirect data load target
.byte $A1
; indirect data load target
.byte $2D
; indirect data load target
.byte $B0
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $8D
; indirect data load target
.byte $97
; indirect data load target
.byte $AB
; indirect data load target
.byte $4D
; indirect data load target
.byte $80
; indirect data load target
.byte $E5
; indirect data load target
.byte $13
; indirect data load target
.byte $98
; indirect data load target
.byte $BD
; indirect data load target
.byte $27
; indirect data load target
.byte $B7
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $8E
; indirect data load target
.byte $97
; indirect data load target
.byte $A8
; indirect data load target
.byte $50
; indirect data load target
.byte $09
; indirect data load target
.byte $E3
; indirect data load target
.byte $13
; indirect data load target
.byte $13
; indirect data load target
.byte $9A
; indirect data load target
.byte $B8
; indirect data load target
.byte $0C
; indirect data load target
.byte $27
; indirect data load target
.byte $B9
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $8F
; indirect data load target
.byte $97
; indirect data load target
.byte $A5
; indirect data load target
.byte $49
; indirect data load target
.byte $62
; indirect data load target
.byte $45
; indirect data load target
.byte $A0
; indirect data load target
.byte $13
; indirect data load target
.byte $13
; indirect data load target
.byte $E1
; indirect data load target
.byte $13
; indirect data load target
.byte $9E
; indirect data load target
.byte $BF
; indirect data load target
.byte $B8
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $90
; indirect data load target
.byte $97
; indirect data load target
.byte $A3
; indirect data load target
.byte $22
; indirect data load target
.byte $49
; indirect data load target
.byte $62
; indirect data load target
.byte $43
; indirect data load target
.byte $A0
; indirect data load target
.byte $82
; indirect data load target
.byte $13
; indirect data load target
.byte $13
; indirect data load target
.byte $9F
; indirect data load target
.byte $81
; indirect data load target
.byte $BF
; indirect data load target
.byte $B6
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $90
; indirect data load target
.byte $98
; indirect data load target
.byte $A1
; indirect data load target
.byte $25
; indirect data load target
.byte $4D
; indirect data load target
.byte $A1
; indirect data load target
.byte $9F
; indirect data load target
.byte $88
; indirect data load target
.byte $BF
; indirect data load target
.byte $B3
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $91
; indirect data load target
.byte $98
; indirect data load target
.byte $27
; indirect data load target
.byte $84
; indirect data load target
.byte $48
; indirect data load target
.byte $A1
; indirect data load target
.byte $9F
; indirect data load target
.byte $8B
; indirect data load target
.byte $BF
; indirect data load target
.byte $B0
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $91
; indirect data load target
.byte $99
; indirect data load target
.byte $25
; indirect data load target
.byte $87
; indirect data load target
.byte $44
; indirect data load target
.byte $A2
; indirect data load target
.byte $9F
; indirect data load target
.byte $8D
; indirect data load target
.byte $BF
; indirect data load target
.byte $AE
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $92
; indirect data load target
.byte $99
; indirect data load target
.byte $24
; indirect data load target
.byte $82
; indirect data load target
.byte $22
; indirect data load target
.byte $82
; indirect data load target
.byte $43
; indirect data load target
.byte $A3
; indirect data load target
.byte $9F
; indirect data load target
.byte $91
; indirect data load target
.byte $BF
; indirect data load target
.byte $AA
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $92
; indirect data load target
.byte $9A
; indirect data load target
.byte $23
; indirect data load target
.byte $81
; indirect data load target
.byte $61
; indirect data load target
.byte $21
; indirect data load target
.byte $45
; indirect data load target
.byte $A4
; indirect data load target
.byte $9F
; indirect data load target
.byte $93
; indirect data load target
.byte $BF
; indirect data load target
.byte $A9
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $91
; indirect data load target
.byte $9B
; indirect data load target
.byte $22
; indirect data load target
.byte $82
; indirect data load target
.byte $0E
; indirect data load target
.byte $0F
; indirect data load target
.byte $20
; indirect data load target
.byte $82
; indirect data load target
.byte $42
; indirect data load target
.byte $A4
; indirect data load target
.byte $9F
; indirect data load target
.byte $96
; indirect data load target
.byte $B9
; indirect data load target
.byte $E5
; indirect data load target
.byte $A7
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $90
; indirect data load target
.byte $9C
; indirect data load target
.byte $21
; indirect data load target
.byte $88
; indirect data load target
.byte $43
; indirect data load target
.byte $A3
; indirect data load target
.byte $9F
; indirect data load target
.byte $97
; indirect data load target
.byte $B7
; indirect data load target
.byte $E8
; indirect data load target
.byte $A6
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $8F
; indirect data load target
.byte $9C
; indirect data load target
.byte $22
; indirect data load target
.byte $86
; indirect data load target
.byte $43
; indirect data load target
.byte $E1
; indirect data load target
.byte $A2
; indirect data load target
.byte $9F
; indirect data load target
.byte $99
; indirect data load target
.byte $B6
; indirect data load target
.byte $E8
; indirect data load target
.byte $A6
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $8E
; indirect data load target
.byte $9D
; indirect data load target
.byte $24
; indirect data load target
.byte $46
; indirect data load target
.byte $E3
; indirect data load target
.byte $A2
; indirect data load target
.byte $9F
; indirect data load target
.byte $99
; indirect data load target
.byte $AD
; indirect data load target
.byte $C2
; indirect data load target
.byte $A8
; indirect data load target
.byte $E5
; indirect data load target
.byte $A6
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $8D
; indirect data load target
.byte $9F
; indirect data load target
.byte $23
; indirect data load target
.byte $44
; indirect data load target
.byte $E5
; indirect data load target
.byte $A1
; indirect data load target
.byte $9F
; indirect data load target
.byte $99
; indirect data load target
.byte $A7
; indirect data load target
.byte $0C
; indirect data load target
.byte $A3
; indirect data load target
.byte $C4
; indirect data load target
.byte $AB
; indirect data load target
.byte $42
; indirect data load target
.byte $A5
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $8D
; indirect data load target
.byte $9F
; indirect data load target
.byte $80
; indirect data load target
.byte $24
; indirect data load target
.byte $E8
; indirect data load target
.byte $A1
; indirect data load target
.byte $9F
; indirect data load target
.byte $9A
; indirect data load target
.byte $A4
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $C7
; indirect data load target
.byte $A2
; indirect data load target
.byte $62
; indirect data load target
.byte $A4
; indirect data load target
.byte $46
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $8E
; indirect data load target
.byte $9F
; indirect data load target
.byte $81
; indirect data load target
.byte $24
; indirect data load target
.byte $E6
; indirect data load target
.byte $A2
; indirect data load target
.byte $9F
; indirect data load target
.byte $9A
; indirect data load target
.byte $A4
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $C7
; indirect data load target
.byte $A0
; indirect data load target
.byte $62
; indirect data load target
.byte $0B
; indirect data load target
.byte $61
; indirect data load target
.byte $A3
; indirect data load target
.byte $46
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $8E
; indirect data load target
.byte $9F
; indirect data load target
.byte $82
; indirect data load target
.byte $22
; indirect data load target
.byte $E5
; indirect data load target
.byte $A3
; indirect data load target
.byte $9F
; indirect data load target
.byte $9C
; indirect data load target
.byte $A4
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $08
; indirect data load target
.byte $C8
; indirect data load target
.byte $67
; indirect data load target
.byte $A1
; indirect data load target
.byte $43
; indirect data load target
.byte $A5
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $8C
; indirect data load target
.byte $9F
; indirect data load target
.byte $83
; indirect data load target
.byte $23
; indirect data load target
.byte $E2
; indirect data load target
.byte $A4
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $80
; indirect data load target
.byte $A5
; indirect data load target
.byte $C5
; indirect data load target
.byte $A0
; indirect data load target
.byte $69
; indirect data load target
.byte $A1
; indirect data load target
.byte $43
; indirect data load target
.byte $62
; indirect data load target
.byte $A3
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $8A
; indirect data load target
.byte $9F
; indirect data load target
.byte $84
; indirect data load target
.byte $21
; indirect data load target
.byte $E2
; indirect data load target
.byte $A5
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $83
; indirect data load target
.byte $AA
; indirect data load target
.byte $67
; indirect data load target
.byte $A3
; indirect data load target
.byte $41
; indirect data load target
.byte $65
; indirect data load target
.byte $A1
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $81
; indirect data load target
.byte $61
; indirect data load target
.byte $9F
; indirect data load target
.byte $86
; indirect data load target
.byte $9F
; indirect data load target
.byte $85
; indirect data load target
.byte $E4
; indirect data load target
.byte $A4
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $85
; indirect data load target
.byte $A9
; indirect data load target
.byte $65
; indirect data load target
.byte $A3
; indirect data load target
.byte $E2
; indirect data load target
.byte $66
; indirect data load target
.byte $A2
; indirect data load target
.byte $9F
; indirect data load target
.byte $9E
; indirect data load target
.byte $E1
; indirect data load target
.byte $62
; indirect data load target
.byte $9F
; indirect data load target
.byte $84
; indirect data load target
.byte $9F
; indirect data load target
.byte $87
; indirect data load target
.byte $64
; indirect data load target
.byte $A1
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $8A
; indirect data load target
.byte $A6
; indirect data load target
.byte $63
; indirect data load target
.byte $A2
; indirect data load target
.byte $E3
; indirect data load target
.byte $A1
; indirect data load target
.byte $66
; indirect data load target
.byte $A3
; indirect data load target
.byte $9F
; indirect data load target
.byte $9C
; indirect data load target
.byte $E3
; indirect data load target
.byte $C1
; indirect data load target
.byte $9F
; indirect data load target
.byte $83
; indirect data load target
.byte $9F
; indirect data load target
.byte $88
; indirect data load target
.byte $65
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $8B
; indirect data load target
.byte $AB
; indirect data load target
.byte $E3
; indirect data load target
.byte $A3
; indirect data load target
.byte $63
; indirect data load target
.byte $A5
; indirect data load target
.byte $9F
; indirect data load target
.byte $9E
; indirect data load target
.byte $E3
; indirect data load target
.byte $9F
; indirect data load target
.byte $83
; indirect data load target
.byte $9F
; indirect data load target
.byte $88
; indirect data load target
.byte $65
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $8D
; indirect data load target
.byte $A6
; indirect data load target
.byte $E7
; indirect data load target
.byte $80
; indirect data load target
.byte $A7
; indirect data load target
.byte $22
; indirect data load target
.byte $A3
; indirect data load target
.byte $9F
; indirect data load target
.byte $9C
; indirect data load target
.byte $E1
; indirect data load target
.byte $9F
; indirect data load target
.byte $84
; indirect data load target
.byte $9F
; indirect data load target
.byte $88
; indirect data load target
.byte $65
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $8E
; indirect data load target
.byte $A4
; indirect data load target
.byte $E7
; indirect data load target
.byte $81
; indirect data load target
.byte $A1
; indirect data load target
.byte $C4
; indirect data load target
.byte $26
; indirect data load target
.byte $A1
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $82
; indirect data load target
.byte $9F
; indirect data load target
.byte $87
; indirect data load target
.byte $65
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $92
; indirect data load target
.byte $A3
; indirect data load target
.byte $E5
; indirect data load target
.byte $09
; indirect data load target
.byte $63
; indirect data load target
.byte $C5
; indirect data load target
.byte $24
; indirect data load target
.byte $A1
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $82
; indirect data load target
.byte $9F
; indirect data load target
.byte $87
; indirect data load target
.byte $65
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $95
; indirect data load target
.byte $A3
; indirect data load target
.byte $83
; indirect data load target
.byte $61
; indirect data load target
.byte $C4
; indirect data load target
.byte $0E
; indirect data load target
.byte $0F
; indirect data load target
.byte $C1
; indirect data load target
.byte $22
; indirect data load target
.byte $A3
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $81
; indirect data load target
.byte $9F
; indirect data load target
.byte $85
; indirect data load target
.byte $66
; indirect data load target
.byte $9C
; indirect data load target
.byte $66
; indirect data load target
.byte $9F
; indirect data load target
.byte $95
; indirect data load target
.byte $A0
; indirect data load target
.byte $80
; indirect data load target
.byte $65
; indirect data load target
.byte $C7
; indirect data load target
.byte $21
; indirect data load target
.byte $A6
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $85
; indirect data load target
.byte $66
; indirect data load target
.byte $9B
; indirect data load target
.byte $61
; indirect data load target
.byte $E2
; indirect data load target
.byte $62
; indirect data load target
.byte $9F
; indirect data load target
.byte $9B
; indirect data load target
.byte $64
; indirect data load target
.byte $C3
; indirect data load target
.byte $65
; indirect data load target
.byte $A4
; indirect data load target
.byte $91
; indirect data load target
.byte $23
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $88
; indirect data load target
.byte $9F
; indirect data load target
.byte $84
; indirect data load target
.byte $64
; indirect data load target
.byte $9E
; indirect data load target
.byte $61
; indirect data load target
.byte $E2
; indirect data load target
.byte $61
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $6E
; indirect data load target
.byte $A4
; indirect data load target
.byte $8C
; indirect data load target
.byte $28
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $85
; indirect data load target
.byte $9F
; indirect data load target
.byte $84
; indirect data load target
.byte $62
; indirect data load target
.byte $9F
; indirect data load target
.byte $80
; indirect data load target
.byte $62
; indirect data load target
.byte $E0
; indirect data load target
.byte $61
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $84
; indirect data load target
.byte $67
; indirect data load target
.byte $41
; indirect data load target
.byte $A6
; indirect data load target
.byte $88
; indirect data load target
.byte $66
; indirect data load target
.byte $26
; indirect data load target
.byte $83
; indirect data load target
.byte $61
; indirect data load target
.byte $9F
; indirect data load target
.byte $9D
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $89
; indirect data load target
.byte $63
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $89
; indirect data load target
.byte $62
; indirect data load target
.byte $46
; indirect data load target
.byte $A4
; indirect data load target
.byte $8A
; indirect data load target
.byte $66
; indirect data load target
.byte $87
; indirect data load target
.byte $61
; indirect data load target
.byte $9F
; indirect data load target
.byte $9C
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $98
; indirect data load target
.byte $64
; indirect data load target
.byte $42
; indirect data load target
.byte $67
; indirect data load target
.byte $89
; indirect data load target
.byte $62
; indirect data load target
.byte $98
; indirect data load target
.byte $C3
; indirect data load target
.byte $9F
; indirect data load target
.byte $8C
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9A
; indirect data load target
.byte $63
; indirect data load target
.byte $42
; indirect data load target
.byte $67
; indirect data load target
.byte $9F
; indirect data load target
.byte $81
; indirect data load target
.byte $C3
; indirect data load target
.byte $0B
; indirect data load target
.byte $60
; indirect data load target
.byte $9F
; indirect data load target
.byte $8D
; indirect data load target
.byte $9F
; indirect data load target
.byte $85
; indirect data load target
.byte $60
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $94
; indirect data load target
.byte $6C
; indirect data load target
.byte $A2
; indirect data load target
.byte $9F
; indirect data load target
.byte $80
; indirect data load target
.byte $63
; indirect data load target
.byte $9F
; indirect data load target
.byte $8E
; indirect data load target
.byte $9F
; indirect data load target
.byte $85
; indirect data load target
.byte $61
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $95
; indirect data load target
.byte $68
; indirect data load target
.byte $A7
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $90
; indirect data load target
.byte $9F
; indirect data load target
.byte $84
; indirect data load target
.byte $63
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $97
; indirect data load target
.byte $64
; indirect data load target
.byte $A8
; indirect data load target
.byte $89
; indirect data load target
.byte $A4
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $81
; indirect data load target
.byte $9F
; indirect data load target
.byte $84
; indirect data load target
.byte $63
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $80
; indirect data load target
.byte $A8
; indirect data load target
.byte $84
; indirect data load target
.byte $A1
; indirect data load target
.byte $42
; indirect data load target
.byte $A1
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $80
; indirect data load target
.byte $9F
; indirect data load target
.byte $83
; indirect data load target
.byte $62
; indirect data load target
.byte $21
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $82
; indirect data load target
.byte $A5
; indirect data load target
.byte $85
; indirect data load target
.byte $42
; indirect data load target
.byte $60
; indirect data load target
.byte $41
; indirect data load target
.byte $A0
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $80
; indirect data load target
.byte $9F
; indirect data load target
.byte $82
; indirect data load target
.byte $62
; indirect data load target
.byte $21
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $8F
; indirect data load target
.byte $A0
; indirect data load target
.byte $44
; indirect data load target
.byte $A0
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $80
; indirect data load target
.byte $9F
; indirect data load target
.byte $82
; indirect data load target
.byte $61
; indirect data load target
.byte $22
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $8B
; indirect data load target
.byte $13
; indirect data load target
.byte $82
; indirect data load target
.byte $A1
; indirect data load target
.byte $42
; indirect data load target
.byte $A1
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $80
; indirect data load target
.byte $9F
; indirect data load target
.byte $83
; indirect data load target
.byte $62
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $8D
; indirect data load target
.byte $13
; indirect data load target
.byte $82
; indirect data load target
.byte $A4
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $81
; indirect data load target
.byte $9F
; indirect data load target
.byte $83
; indirect data load target
.byte $61
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $99
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $8F
; indirect data load target
.byte $61
; indirect data load target
.byte $8D
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $8E
; indirect data load target
.byte $0E
; indirect data load target
.byte $0F
; indirect data load target
.byte $61
; indirect data load target
.byte $8C
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $8F
; indirect data load target
.byte $21
; indirect data load target
.byte $8D
; indirect data load target
.byte $9F

.byte $9F
; data -> unknown

.byte $9F
.byte $9F
; unknown -> data
; indirect data load target
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $8B
; indirect data load target
.byte $0B
; indirect data load target
.byte $C0
; indirect data load target
.byte $91
; indirect data load target
.byte $9F

.byte $9F
; data -> unknown

.byte $9F
.byte $9F
; unknown -> data
; indirect data load target
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F

.byte $9F
; data -> unknown

.byte $9F
.byte $9F
; unknown -> data
; indirect data load target
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F

.byte $9F
; data -> unknown

.byte $9F
.byte $9F
; unknown -> data
; indirect data load target
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F

.byte $9F
; data -> unknown

.byte $9F
.byte $9F
; unknown -> data
; indirect data load target
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F

.byte $9F
; data -> unknown

.byte $9F
.byte $9F
; unknown -> data
; indirect data load target
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F

.byte $9F
; data -> unknown

.byte $9F
.byte $9F
; unknown -> data
; indirect data load target
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F

.byte $9F
; data -> unknown

.byte $9F
.byte $9F
; unknown -> data
; indirect data load target
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F

.byte $9F
; data -> unknown

.byte $9F
.byte $9F
; unknown -> data
; indirect data load target
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F

.byte $9F
; data -> unknown

.byte $9F
.byte $9F
; unknown -> data
; indirect data load target
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F

.byte $9F
; data -> unknown

.byte $9F
.byte $9F
; unknown -> data
; indirect data load target
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F

.byte $9F
; data -> unknown

.byte $9F
.byte $9F
; unknown -> data
; indirect data load target
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F

.byte $9F
; data -> unknown

.byte $9F
.byte $9F
; unknown -> data
; indirect data load target
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9D
; indirect data load target
.byte $13
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $80
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; indirect data load target
.byte $9F
; external indirect data load target (via $0F:$DD3D)
.byte $9F
; indirect data load target
; indirect data load target
.byte $09
; indirect data load target
.byte $00
; indirect data load target
.byte $0B
; indirect data load target
.byte $00
; indirect data load target
.byte $08
; indirect data load target
.byte $00
; indirect data load target
.byte $0A
; indirect data load target
.byte $00
; indirect data load target
.byte $0D
; indirect data load target
.byte $00
; indirect data load target
.byte $0F
; indirect data load target
.byte $00
; indirect data load target
.byte $0C
; indirect data load target
.byte $00
; indirect data load target
.byte $0E
; indirect data load target
.byte $00
; indirect data load target
.byte $19
; indirect data load target
.byte $00
; indirect data load target
.byte $1B
; indirect data load target
.byte $00
; indirect data load target
.byte $18
; indirect data load target
.byte $00
; indirect data load target
.byte $1A
; indirect data load target
.byte $00
; indirect data load target
.byte $1D
; indirect data load target
.byte $00
; indirect data load target
.byte $1F
; indirect data load target
.byte $00
; indirect data load target
.byte $1C
; indirect data load target
.byte $00
; indirect data load target
.byte $1E
; indirect data load target
.byte $00
; indirect data load target
.byte $01
; indirect data load target
.byte $00
; indirect data load target
.byte $03
; indirect data load target
.byte $00
; indirect data load target
.byte $00
; indirect data load target
.byte $00
; indirect data load target
.byte $02
; indirect data load target
.byte $00
; indirect data load target
.byte $05
; indirect data load target
.byte $00
; indirect data load target
.byte $07
; indirect data load target
.byte $00
; indirect data load target
.byte $04
; indirect data load target
.byte $00
; indirect data load target
.byte $06
; indirect data load target
.byte $00
; indirect data load target
.byte $11
; indirect data load target
.byte $00
; indirect data load target
.byte $13
; indirect data load target
.byte $00
; indirect data load target
.byte $10
; indirect data load target
.byte $00
; indirect data load target
.byte $12
; indirect data load target
.byte $00
; indirect data load target
.byte $15
; indirect data load target
.byte $00
; indirect data load target
.byte $17
; indirect data load target
.byte $00
; indirect data load target
.byte $14
; indirect data load target
.byte $00
; indirect data load target
.byte $16
; indirect data load target
.byte $00
; indirect data load target
.byte $29
; indirect data load target
.byte $01
; indirect data load target
.byte $2B
; indirect data load target
.byte $01
; indirect data load target
.byte $28
; indirect data load target
.byte $01
; indirect data load target
.byte $2A
; indirect data load target
.byte $01
; indirect data load target
.byte $2D
; indirect data load target
.byte $01
; indirect data load target
.byte $2F
; indirect data load target
.byte $01
; indirect data load target
.byte $2C
; indirect data load target
.byte $01
; indirect data load target
.byte $2E
; indirect data load target
.byte $01
; indirect data load target
.byte $39
; indirect data load target
.byte $01
; indirect data load target
.byte $3B
; indirect data load target
.byte $01
; indirect data load target
.byte $38
; indirect data load target
.byte $01
; indirect data load target
.byte $3A
; indirect data load target
.byte $01
; indirect data load target
.byte $3D
; indirect data load target
.byte $01
; indirect data load target
.byte $3F
; indirect data load target
.byte $01
; indirect data load target
.byte $3C
; indirect data load target
.byte $01
; indirect data load target
.byte $3E
; indirect data load target
.byte $01
; indirect data load target
.byte $21
; indirect data load target
.byte $01
; indirect data load target
.byte $23
; indirect data load target
.byte $01
; indirect data load target
.byte $20
; indirect data load target
.byte $01
; indirect data load target
.byte $22
; indirect data load target
.byte $01
; indirect data load target
.byte $25
; indirect data load target
.byte $01
; indirect data load target
.byte $27
; indirect data load target
.byte $01
; indirect data load target
.byte $24
; indirect data load target
.byte $01
; indirect data load target
.byte $26
; indirect data load target
.byte $01
; indirect data load target
.byte $31
; indirect data load target
.byte $01
; indirect data load target
.byte $33
; indirect data load target
.byte $01
; indirect data load target
.byte $30
; indirect data load target
.byte $01
; indirect data load target
.byte $32
; indirect data load target
.byte $01
; indirect data load target
.byte $35
; indirect data load target
.byte $01
; indirect data load target
.byte $37
; indirect data load target
.byte $01
; indirect data load target
.byte $34
; indirect data load target
.byte $01
; indirect data load target
.byte $36
; indirect data load target
.byte $01
; indirect data load target
.byte $49
; indirect data load target
.byte $02
; indirect data load target
.byte $4B
; indirect data load target
.byte $02
; indirect data load target
.byte $48
; indirect data load target
.byte $02
; indirect data load target
.byte $4A
; indirect data load target
.byte $02
; indirect data load target
.byte $4D
; indirect data load target
.byte $02
; indirect data load target
.byte $4F
; indirect data load target
.byte $02
; indirect data load target
.byte $4C
; indirect data load target
.byte $02
; indirect data load target
.byte $4E
; indirect data load target
.byte $02
; indirect data load target
.byte $59
; indirect data load target
.byte $02
; indirect data load target
.byte $5B
; indirect data load target
.byte $02
; indirect data load target
.byte $58
; indirect data load target
.byte $02
; indirect data load target
.byte $5A
; indirect data load target
.byte $02
; indirect data load target
.byte $5D
; indirect data load target
.byte $02
; indirect data load target
.byte $5F
; indirect data load target
.byte $02
; indirect data load target
.byte $5C
; indirect data load target
.byte $02
; indirect data load target
.byte $5E
; indirect data load target
.byte $02
; indirect data load target
.byte $41
; indirect data load target
.byte $02
; indirect data load target
.byte $43
; indirect data load target
.byte $02
; indirect data load target
.byte $40
; indirect data load target
.byte $02
; indirect data load target
.byte $42
; indirect data load target
.byte $02
; indirect data load target
.byte $45
; indirect data load target
.byte $02
; indirect data load target
.byte $47
; indirect data load target
.byte $02
; indirect data load target
.byte $44
; indirect data load target
.byte $02
; indirect data load target
.byte $46
; indirect data load target
.byte $02
; indirect data load target
.byte $51
; indirect data load target
.byte $02
; indirect data load target
.byte $53
; indirect data load target
.byte $02
; indirect data load target
.byte $50
; indirect data load target
.byte $02
; indirect data load target
.byte $52
; indirect data load target
.byte $02
; indirect data load target
.byte $55
; indirect data load target
.byte $02
; indirect data load target
.byte $57
; indirect data load target
.byte $02
; indirect data load target
.byte $54
; indirect data load target
.byte $02
; indirect data load target
.byte $56

.byte $02
; data -> unknown

.byte $85,$03,$87,$03,$84,$03,$86,$03
.byte $89,$03,$87,$03
.byte $88,$03
.byte $86
.byte $03
; unknown -> data
; indirect data load target
; indirect data load target
.byte $85
; indirect data load target
.byte $03
; indirect data load target
.byte $87
; indirect data load target
.byte $03
; indirect data load target
.byte $84
; indirect data load target
.byte $03
; indirect data load target
.byte $86
; indirect data load target
.byte $03
; indirect data load target
.byte $89
; indirect data load target
.byte $03
; indirect data load target
.byte $87
; indirect data load target
.byte $03
; indirect data load target
.byte $88
; indirect data load target
.byte $03
; indirect data load target
.byte $86
; indirect data load target
.byte $03
; indirect data load target
.byte $85
; indirect data load target
.byte $03
; indirect data load target
.byte $87
; indirect data load target
.byte $03
; indirect data load target
.byte $84
; indirect data load target
.byte $03
; indirect data load target
.byte $86
; indirect data load target
.byte $03
; indirect data load target
.byte $89
; indirect data load target
.byte $03
; indirect data load target
.byte $87
; indirect data load target
.byte $03
; indirect data load target
.byte $88
; indirect data load target
.byte $03
; indirect data load target
.byte $86
; indirect data load target
.byte $03
; indirect data load target
.byte $85
; indirect data load target
.byte $03
; indirect data load target
.byte $87
; indirect data load target
.byte $03
; indirect data load target
.byte $84
; indirect data load target
.byte $03
; indirect data load target
.byte $86
; indirect data load target
.byte $03
; indirect data load target
.byte $89
; indirect data load target
.byte $03
; indirect data load target
.byte $87
; indirect data load target
.byte $03
; indirect data load target
.byte $88
; indirect data load target
.byte $03
; indirect data load target
.byte $86
; indirect data load target
.byte $03
; indirect data load target
.byte $81
; indirect data load target
.byte $01
; indirect data load target
.byte $83
; indirect data load target
.byte $01
; indirect data load target
.byte $80
; indirect data load target
.byte $01
; indirect data load target
.byte $82
; indirect data load target
.byte $01
; indirect data load target
.byte $83
; indirect data load target
.byte $41
; indirect data load target
.byte $81
; indirect data load target
.byte $41
; indirect data load target
.byte $82
; indirect data load target
.byte $41
; indirect data load target
.byte $80
; indirect data load target
.byte $41
; indirect data load target
.byte $81
; indirect data load target
.byte $01
; indirect data load target
.byte $83
; indirect data load target
.byte $01
; indirect data load target
.byte $80
; indirect data load target
.byte $01
; indirect data load target
.byte $82
; indirect data load target
.byte $01
; indirect data load target
.byte $83
; indirect data load target
.byte $41
; indirect data load target
.byte $81
; indirect data load target
.byte $41
; indirect data load target
.byte $82
; indirect data load target
.byte $41
; indirect data load target
.byte $80
; indirect data load target
.byte $41
; indirect data load target
.byte $81
; indirect data load target
.byte $01
; indirect data load target
.byte $83
; indirect data load target
.byte $01
; indirect data load target
.byte $80
; indirect data load target
.byte $01
; indirect data load target
.byte $82
; indirect data load target
.byte $01
; indirect data load target
.byte $83
; indirect data load target
.byte $41
; indirect data load target
.byte $81
; indirect data load target
.byte $41
; indirect data load target
.byte $82
; indirect data load target
.byte $41
; indirect data load target
.byte $80
; indirect data load target
.byte $41
; indirect data load target
.byte $81
; indirect data load target
.byte $01
; indirect data load target
.byte $83
; indirect data load target
.byte $01
; indirect data load target
.byte $80
; indirect data load target
.byte $01
; indirect data load target
.byte $82
; indirect data load target
.byte $01
; indirect data load target
.byte $83
; indirect data load target
.byte $41
; indirect data load target
.byte $81
; indirect data load target
.byte $41
; indirect data load target
.byte $82
; indirect data load target
.byte $41
; indirect data load target
.byte $80
; indirect data load target
.byte $41
; indirect data load target
.byte $69
; indirect data load target
.byte $02
; indirect data load target
.byte $6B
; indirect data load target
.byte $02
; indirect data load target
.byte $68
; indirect data load target
.byte $02
; indirect data load target
.byte $6A
; indirect data load target
.byte $02
; indirect data load target
.byte $6D
; indirect data load target
.byte $02
; indirect data load target
.byte $6F
; indirect data load target
.byte $02
; indirect data load target
.byte $6C
; indirect data load target
.byte $02
; indirect data load target
.byte $6E
; indirect data load target
.byte $02
; indirect data load target
.byte $79
; indirect data load target
.byte $02
; indirect data load target
.byte $7B
; indirect data load target
.byte $02
; indirect data load target
.byte $78
; indirect data load target
.byte $02
; indirect data load target
.byte $7A
; indirect data load target
.byte $02
; indirect data load target
.byte $7D
; indirect data load target
.byte $02
; indirect data load target
.byte $7F
; indirect data load target
.byte $02
; indirect data load target
.byte $7C
; indirect data load target
.byte $02
; indirect data load target
.byte $7E
; indirect data load target
.byte $02
; indirect data load target
.byte $61
; indirect data load target
.byte $02
; indirect data load target
.byte $63
; indirect data load target
.byte $02
; indirect data load target
.byte $60
; indirect data load target
.byte $02
; indirect data load target
.byte $62
; indirect data load target
.byte $02
; indirect data load target
.byte $65
; indirect data load target
.byte $02
; indirect data load target
.byte $67
; indirect data load target
.byte $02
; indirect data load target
.byte $64
; indirect data load target
.byte $02
; indirect data load target
.byte $66
; indirect data load target
.byte $02
; indirect data load target
.byte $71
; indirect data load target
.byte $02
; indirect data load target
.byte $73
; indirect data load target
.byte $02
; indirect data load target
.byte $70
; indirect data load target
.byte $02
; indirect data load target
.byte $72
; indirect data load target
.byte $02
; indirect data load target
.byte $75
; indirect data load target
.byte $02
; indirect data load target
.byte $77
; indirect data load target
.byte $02
; indirect data load target
.byte $74
; indirect data load target
.byte $02
; indirect data load target
.byte $76
; indirect data load target
.byte $02
; indirect data load target
.byte $B2
; indirect data load target
.byte $01
; indirect data load target
.byte $B2
; indirect data load target
.byte $41
; indirect data load target
.byte $B1
; indirect data load target
.byte $01
; indirect data load target
.byte $B3
; indirect data load target
.byte $01
; indirect data load target
.byte $B2
; indirect data load target
.byte $01
; indirect data load target
.byte $B2
; indirect data load target
.byte $41
; indirect data load target
.byte $B3
; indirect data load target
.byte $41
; indirect data load target
.byte $B1
; indirect data load target
.byte $41
; indirect data load target
.byte $B7
; indirect data load target
.byte $41
; indirect data load target
.byte $B5
; indirect data load target
.byte $41
; indirect data load target
.byte $B6
; indirect data load target
.byte $41
; indirect data load target
.byte $B4
; indirect data load target
.byte $41
; indirect data load target
.byte $B7
; indirect data load target
.byte $41
; indirect data load target
.byte $B5
; indirect data load target
.byte $41
; indirect data load target
.byte $B9
; indirect data load target
.byte $41
; indirect data load target
.byte $B8
; indirect data load target
.byte $41
; indirect data load target
.byte $AF
; indirect data load target
.byte $01
; indirect data load target
.byte $AF
; indirect data load target
.byte $41
; indirect data load target
.byte $AE
; indirect data load target
.byte $01
; indirect data load target
.byte $B0
; indirect data load target
.byte $01
; indirect data load target
.byte $AF
; indirect data load target
.byte $01
; indirect data load target
.byte $AF
; indirect data load target
.byte $41
; indirect data load target
.byte $B0
; indirect data load target
.byte $41
; indirect data load target
.byte $AE
; indirect data load target
.byte $41
; indirect data load target
.byte $B5
; indirect data load target
.byte $01
; indirect data load target
.byte $B7
; indirect data load target
.byte $01
; indirect data load target
.byte $B4
; indirect data load target
.byte $01
; indirect data load target
.byte $B6
; indirect data load target
.byte $01
; indirect data load target
.byte $B5
; indirect data load target
.byte $01
; indirect data load target
.byte $B7
; indirect data load target
.byte $01
; indirect data load target
.byte $B8
; indirect data load target
.byte $01
; indirect data load target
.byte $B9
; indirect data load target
.byte $01
; indirect data load target
.byte $8E
; indirect data load target
.byte $03
; indirect data load target
.byte $8E
; indirect data load target
.byte $43
; indirect data load target
.byte $8D
; indirect data load target
.byte $03
; indirect data load target
.byte $8F
; indirect data load target
.byte $03
; indirect data load target
.byte $8E
; indirect data load target
.byte $03
; indirect data load target
.byte $8E
; indirect data load target
.byte $43
; indirect data load target
.byte $8F
; indirect data load target
.byte $43
; indirect data load target
.byte $8D
; indirect data load target
.byte $43
; indirect data load target
.byte $93
; indirect data load target
.byte $43
; indirect data load target
.byte $91
; indirect data load target
.byte $43
; indirect data load target
.byte $92
; indirect data load target
.byte $43
; indirect data load target
.byte $90
; indirect data load target
.byte $43
; indirect data load target
.byte $93
; indirect data load target
.byte $43
; indirect data load target
.byte $91
; indirect data load target
.byte $43
; indirect data load target
.byte $95
; indirect data load target
.byte $43
; indirect data load target
.byte $94
; indirect data load target
.byte $43
; indirect data load target
.byte $8B
; indirect data load target
.byte $03
; indirect data load target
.byte $8B
; indirect data load target
.byte $43
; indirect data load target
.byte $8A
; indirect data load target
.byte $03
; indirect data load target
.byte $8C
; indirect data load target
.byte $03
; indirect data load target
.byte $8B
; indirect data load target
.byte $03
; indirect data load target
.byte $8B
; indirect data load target
.byte $43
; indirect data load target
.byte $8C
; indirect data load target
.byte $43
; indirect data load target
.byte $8A
; indirect data load target
.byte $43
; indirect data load target
.byte $91
; indirect data load target
.byte $03
; indirect data load target
.byte $93
; indirect data load target
.byte $03
; indirect data load target
.byte $90
; indirect data load target
.byte $03
; indirect data load target
.byte $92
; indirect data load target
.byte $03
; indirect data load target
.byte $91
; indirect data load target
.byte $03
; indirect data load target
.byte $93
; indirect data load target
.byte $03
; indirect data load target
.byte $94
; indirect data load target
.byte $03
; indirect data load target
.byte $95
; indirect data load target
.byte $03
; indirect data load target
.byte $A6
; indirect data load target
.byte $03
; indirect data load target
.byte $A6
; indirect data load target
.byte $43
; indirect data load target
.byte $A5
; indirect data load target
.byte $03
; indirect data load target
.byte $A7
; indirect data load target
.byte $03
; indirect data load target
.byte $A6
; indirect data load target
.byte $03
; indirect data load target
.byte $A6
; indirect data load target
.byte $43
; indirect data load target
.byte $A7
; indirect data load target
.byte $43
; indirect data load target
.byte $A5
; indirect data load target
.byte $43
; indirect data load target
.byte $AB
; indirect data load target
.byte $43
; indirect data load target
.byte $A9
; indirect data load target
.byte $43
; indirect data load target
.byte $AA
; indirect data load target
.byte $43
; indirect data load target
.byte $A8
; indirect data load target
.byte $43
; indirect data load target
.byte $AB
; indirect data load target
.byte $43
; indirect data load target
.byte $A9
; indirect data load target
.byte $43
; indirect data load target
.byte $AD
; indirect data load target
.byte $43
; indirect data load target
.byte $AC
; indirect data load target
.byte $43
; indirect data load target
.byte $A3
; indirect data load target
.byte $03
; indirect data load target
.byte $A3
; indirect data load target
.byte $43
; indirect data load target
.byte $A2
; indirect data load target
.byte $03
; indirect data load target
.byte $A4
; indirect data load target
.byte $03
; indirect data load target
.byte $A3
; indirect data load target
.byte $03
; indirect data load target
.byte $A3
; indirect data load target
.byte $43
; indirect data load target
.byte $A4
; indirect data load target
.byte $43
; indirect data load target
.byte $A2
; indirect data load target
.byte $43
; indirect data load target
.byte $A9
; indirect data load target
.byte $03
; indirect data load target
.byte $AB
; indirect data load target
.byte $03
; indirect data load target
.byte $A8
; indirect data load target
.byte $03
; indirect data load target
.byte $AA
; indirect data load target
.byte $03
; indirect data load target
.byte $A9
; indirect data load target
.byte $03
; indirect data load target
.byte $AB
; indirect data load target
.byte $03
; indirect data load target
.byte $AC
; indirect data load target
.byte $03
; indirect data load target
.byte $AD
; indirect data load target
.byte $03
; indirect data load target
.byte $9A
; indirect data load target
.byte $01
; indirect data load target
.byte $9A
; indirect data load target
.byte $41
; indirect data load target
.byte $99
; indirect data load target
.byte $01
; indirect data load target
.byte $9B
; indirect data load target
.byte $01
; indirect data load target
.byte $9A
; indirect data load target
.byte $01
; indirect data load target
.byte $9A
; indirect data load target
.byte $41
; indirect data load target
.byte $9B
; indirect data load target
.byte $41
; indirect data load target
.byte $99
; indirect data load target
.byte $41
; indirect data load target
.byte $9F
; indirect data load target
.byte $41
; indirect data load target
.byte $9D
; indirect data load target
.byte $41
; indirect data load target
.byte $9E
; indirect data load target
.byte $41
; indirect data load target
.byte $9C
; indirect data load target
.byte $41
; indirect data load target
.byte $9F
; indirect data load target
.byte $41
; indirect data load target
.byte $9D
; indirect data load target
.byte $41
; indirect data load target
.byte $A1
; indirect data load target
.byte $41
; indirect data load target
.byte $A0
; indirect data load target
.byte $41
; indirect data load target
.byte $97
; indirect data load target
.byte $01
; indirect data load target
.byte $97
; indirect data load target
.byte $41
; indirect data load target
.byte $96
; indirect data load target
.byte $01
; indirect data load target
.byte $98
; indirect data load target
.byte $01
; indirect data load target
.byte $97
; indirect data load target
.byte $01
; indirect data load target
.byte $97
; indirect data load target
.byte $41
; indirect data load target
.byte $98
; indirect data load target
.byte $41
; indirect data load target
.byte $96
; indirect data load target
.byte $41
; indirect data load target
.byte $9D
; indirect data load target
.byte $01
; indirect data load target
.byte $9F
; indirect data load target
.byte $01
; indirect data load target
.byte $9C
; indirect data load target
.byte $01
; indirect data load target
.byte $9E
; indirect data load target
.byte $01
; indirect data load target
.byte $9D
; indirect data load target
.byte $01
; indirect data load target
.byte $9F
; indirect data load target
.byte $01
; indirect data load target
.byte $A0
; indirect data load target
.byte $01
; indirect data load target
.byte $A1
; indirect data load target
.byte $01
; indirect data load target
.byte $C2
; indirect data load target
.byte $03
; indirect data load target
.byte $C4
; indirect data load target
.byte $03
; indirect data load target
.byte $C1
; indirect data load target
.byte $03
; indirect data load target
.byte $C3
; indirect data load target
.byte $03
; indirect data load target
.byte $C6
; indirect data load target
.byte $03
; indirect data load target
.byte $C4
; indirect data load target
.byte $03
; indirect data load target
.byte $C5
; indirect data load target
.byte $03
; indirect data load target
.byte $C7
; indirect data load target
.byte $03
; indirect data load target
.byte $CB
; indirect data load target
.byte $43
; indirect data load target
.byte $CD
; indirect data load target
.byte $43
; indirect data load target
.byte $D0
; indirect data load target
.byte $03
; indirect data load target
.byte $D1
; indirect data load target
.byte $03
; indirect data load target
.byte $CB
; indirect data load target
.byte $43
; indirect data load target
.byte $CD
; indirect data load target
.byte $43
; indirect data load target
.byte $D2
; indirect data load target
.byte $03
; indirect data load target
.byte $D3
; indirect data load target
.byte $03
; indirect data load target
.byte $BB
; indirect data load target
.byte $03
; indirect data load target
.byte $BD
; indirect data load target
.byte $03
; indirect data load target
.byte $BA
; indirect data load target
.byte $03
; indirect data load target
.byte $BC
; indirect data load target
.byte $03
; indirect data load target
.byte $BB
; indirect data load target
.byte $03
; indirect data load target
.byte $C0
; indirect data load target
.byte $03
; indirect data load target
.byte $BE
; indirect data load target
.byte $03
; indirect data load target
.byte $BF
; indirect data load target
.byte $03
; indirect data load target
.byte $C9
; indirect data load target
.byte $03
; indirect data load target
.byte $CB
; indirect data load target
.byte $03
; indirect data load target
.byte $C8
; indirect data load target
.byte $03
; indirect data load target
.byte $CA
; indirect data load target
.byte $03
; indirect data load target
.byte $CD
; indirect data load target
.byte $03
; indirect data load target
.byte $CF
; indirect data load target
.byte $03
; indirect data load target
.byte $CC
; indirect data load target
.byte $03
; indirect data load target
.byte $CE
; indirect data load target
.byte $03
; indirect data load target
.byte $EE
; indirect data load target
.byte $00
; indirect data load target
.byte $F0
; indirect data load target
.byte $00
; indirect data load target
.byte $ED
; indirect data load target
.byte $00
; indirect data load target
.byte $EF
; indirect data load target
.byte $00
; indirect data load target
.byte $F2
; indirect data load target
.byte $00
; indirect data load target
.byte $F4
; indirect data load target
.byte $00
; indirect data load target
.byte $F1
; indirect data load target
.byte $00
; indirect data load target
.byte $F3
; indirect data load target
.byte $00
; indirect data load target
.byte $FC
; indirect data load target
.byte $40
; indirect data load target
.byte $FA
; indirect data load target
.byte $40
; indirect data load target
.byte $FD
; indirect data load target
.byte $00
; indirect data load target
.byte $F5
; indirect data load target
.byte $40
; indirect data load target
.byte $FC
; indirect data load target
.byte $40
; indirect data load target
.byte $FA
; indirect data load target
.byte $40
; indirect data load target
.byte $FE
; indirect data load target
.byte $00
; indirect data load target
.byte $FF
; indirect data load target
.byte $00
; indirect data load target
.byte $E6
; indirect data load target
.byte $00
; indirect data load target
.byte $E8
; indirect data load target
.byte $00
; indirect data load target
.byte $E5
; indirect data load target
.byte $00
; indirect data load target
.byte $E7
; indirect data load target
.byte $00
; indirect data load target
.byte $EA
; indirect data load target
.byte $00
; indirect data load target
.byte $EC
; indirect data load target
.byte $00
; indirect data load target
.byte $E9
; indirect data load target
.byte $00
; indirect data load target
.byte $EB
; indirect data load target
.byte $00
; indirect data load target
.byte $F6
; indirect data load target
.byte $00
; indirect data load target
.byte $F8
; indirect data load target
.byte $00
; indirect data load target
.byte $F5
; indirect data load target
.byte $00
; indirect data load target
.byte $F7
; indirect data load target
.byte $00
; indirect data load target
.byte $FA
; indirect data load target
.byte $00
; indirect data load target
.byte $FC
; indirect data load target
.byte $00
; indirect data load target
.byte $F9
; indirect data load target
.byte $00
; indirect data load target
.byte $FB
; indirect data load target
.byte $00
; indirect data load target
.byte $DD
; indirect data load target
.byte $00
; indirect data load target
.byte $DD
; indirect data load target
.byte $40
; indirect data load target
.byte $DC
; indirect data load target
.byte $00
; indirect data load target
.byte $DE
; indirect data load target
.byte $00
; indirect data load target
.byte $DD
; indirect data load target
.byte $00
; indirect data load target
.byte $DD
; indirect data load target
.byte $40
; indirect data load target
.byte $DE
; indirect data load target
.byte $40
; indirect data load target
.byte $DC
; indirect data load target
.byte $40
; indirect data load target
.byte $E2
; indirect data load target
.byte $40
; indirect data load target
.byte $E0
; indirect data load target
.byte $40
; indirect data load target
.byte $E1
; indirect data load target
.byte $40
; indirect data load target
.byte $DF
; indirect data load target
.byte $40
; indirect data load target
.byte $E2
; indirect data load target
.byte $40
; indirect data load target
.byte $E0
; indirect data load target
.byte $40
; indirect data load target
.byte $E4
; indirect data load target
.byte $40
; indirect data load target
.byte $E3
; indirect data load target
.byte $40
; indirect data load target
.byte $D9
; indirect data load target
.byte $00
; indirect data load target
.byte $DB
; indirect data load target
.byte $00
; indirect data load target
.byte $D8
; indirect data load target
.byte $00
; indirect data load target
.byte $DA
; indirect data load target
.byte $00
; indirect data load target
.byte $D9
; indirect data load target
.byte $00
; indirect data load target
.byte $DB
; indirect data load target
.byte $00
; indirect data load target
.byte $DA
; indirect data load target
.byte $40
; indirect data load target
.byte $D8
; indirect data load target
.byte $40
; indirect data load target
.byte $E0
; indirect data load target
.byte $00
; indirect data load target
.byte $E2
; indirect data load target
.byte $00
; indirect data load target
.byte $DF
; indirect data load target
.byte $00
; indirect data load target
.byte $E1
; indirect data load target
.byte $00
; indirect data load target
.byte $E0
; indirect data load target
.byte $00
; indirect data load target
.byte $E2
; indirect data load target
.byte $00
; indirect data load target
.byte $E3
; indirect data load target
.byte $00
; indirect data load target
.byte $E4
; indirect data load target
.byte $00
; indirect data load target
.byte $D5
; indirect data load target
.byte $02
; indirect data load target
.byte $D7
; indirect data load target
.byte $02
; indirect data load target
.byte $D4
; indirect data load target
.byte $02
; indirect data load target
.byte $D6
; indirect data load target
.byte $02
; indirect data load target
.byte $D5
; indirect data load target
.byte $02
; indirect data load target
.byte $D7
; indirect data load target
.byte $02
; indirect data load target
.byte $D4
; indirect data load target
.byte $02
; indirect data load target
.byte $D6

.byte $02
; data -> unknown

.byte $D5,$02,$D7,$02,$D4,$02,$D6,$02,$D5,$02,$D7,$02,$D4,$02,$D6,$02
.byte $D5,$02,$D7,$02,$D4,$02,$D6,$02,$D5,$02,$D7,$02,$D4,$02,$D6,$02
.byte $D5,$02,$D7,$02,$D4,$02,$D6,$02,$D5,$02,$D7,$02,$D4,$02,$D6
.byte $02,$0F,$0F,$0F,$0F,$0F,$0F
.byte $0F,$0F,$0F,$0F
.byte $0F,$0F
.byte $0F
; unknown -> data
; palette data
; external indirect data load target (via $0F:$E27A)
; indirect data load target
; external indirect data load target (via $0F:$E27C)
.byte $0F,$36,$30,$11,$36,$19,$16
.byte $36,$30,$13
.byte $36,$30
.byte $17
; warp points (map ID, X-pos, Y-pos); other end is same index in $02:$A27E
.byte $0F,$30,$11,$21,$29,$37,$17,$29,$00,$10,$29,$1A,$27,$0F,$30,$11
.byte $21,$15,$37,$16,$15,$10,$00,$29,$1A,$27,$0F,$30,$01,$11,$00,$10
.byte $16,$10,$16,$06,$17,$27,$0A,$0F,$30,$01,$11,$00,$10,$16,$21,$10
.byte $00,$00,$10,$15,$0F,$30,$01,$11,$00,$10,$16,$10,$16,$06,$00,$10
.byte $0A,$0F,$30,$01,$11,$00,$10,$16,$19,$10,$00,$00,$10,$15,$0F,$30
.byte $06,$16,$00,$10,$16,$10,$16,$06,$00,$10,$0A,$0F,$30,$16,$06,$00
.byte $10,$16,$10,$16,$06,$00,$10,$0A,$0F,$20,$11,$21,$20,$37,$17,$20
.byte $00,$10,$20,$1A,$27,$0F,$36,$30,$11
.byte $36,$30,$17,$36,$30
.byte $13,$36
.byte $30
.byte $17
; external indirect data load target (via $0F:$D7EC)
; indirect data load target
; external indirect data load target (via $06:$9959)
.byte $83,$0F,$17,$85,$0B,$17,$86,$07,$19,$87,$00,$0D,$89,$10,$13,$8B
.byte $0E,$19,$8C,$15,$13,$8F,$17,$16,$90,$06,$17,$91,$13,$18,$93,$00
.byte $05,$95,$19,$0C,$80,$0F,$17,$19,$00,$05,$9A,$03,$00,$1B,$01,$01
.byte $1C,$00,$04,$9D,$05,$05,$9E,$04,$05,$1F,$00,$04,$20,$02,$02,$20
.byte $06,$00,$21,$02,$05,$A2,$09,$02,$23,$00,$00,$2A,$00,$00,$2B,$03
.byte $20,$2C,$1D,$02,$2E,$17,$0A,$D8,$0B,$00,$34,$19,$02,$D0,$27,$00
.byte $B8,$04,$17,$C9,$0D,$00,$E0,$09,$0F
.byte $E6,$07,$00,$43,$05
.byte $02,$40
.byte $05
.byte $24

.byte $96,$0D,$19,$2B,$03,$26,$3F,$21,$0E,$43,$05,$18,$83,$0F,$17,$85
.byte $0B,$17,$86,$07,$19,$87,$00,$0D,$89,$10,$13,$8B,$0E,$19,$8C,$15
.byte $13,$8F,$17,$16,$90,$06,$17,$91,$13,$18,$93,$00,$05,$95,$19,$0C
.byte $80,$0F,$17,$34,$19,$02,$03,$0F,$01,$04,$04,$01,$08,$01,$06,$08
.byte $06,$06,$0A,$00,$01,$0C,$03,$06,$0C,$13,$06,$12,$01,$04,$14,$0B
.byte $01,$16,$0D,$04,$2B,$09,$02,$24,$00,$00,$25,$00,$00,$26,$00,$00
.byte $27,$00,$00,$28,$00,$00,$29,$01,$01,$03,$07,$0C,$2A,$01,$01,$0F
.byte $02,$15,$22,$02,$03,$1A,$05,$0A,$1D,$03,$02,$1C,$07,$04,$1E,$06
.byte $02,$1B,$03,$03,$1E,$02,$02,$1D,$05,$02,$1E,$04,$02,$20,$00,$01
.byte $1D,$07,$02,$21,$04,$03,$15,$0C,$02,$1F,$04,$07,$2D,$0F,$02,$2F
.byte $21,$02,$30,$05,$0C,$31,$15,$02,$30,$03,$08,$30,$07,$06,$30,$03
.byte $02,$30,$0B,$02,$30,$0F,$08,$31,$1D,$1C,$30,$11,$02,$32,$1F,$02
.byte $32,$0D,$08,$32,$1F,$20,$32,$15,$02,$32,$07,$02,$32,$17,$0C,$32
.byte $19,$08,$32,$1B,$0E,$32,$15,$10,$32,$0F,$14,$32,$19,$14,$32,$21
.byte $10,$32,$03,$1A,$32,$0D,$1A,$32,$15,$20,$33,$03,$02,$33,$09,$02
.byte $33,$03,$0C,$49,$15,$02,$49,$15,$12,$49,$0D,$14,$49,$05,$14,$49
.byte $09,$02,$4A,$0F,$0A,$4A,$07,$0A,$4A,$15,$02,$4B,$0B,$08,$4B,$11
.byte $0A,$4C,$0D,$02,$4C,$0D,$0A,$4D,$09,$04,$4E,$07,$02,$34,$13,$06
.byte $35,$05,$0C,$34,$19,$16,$34,$11,$0E,$35,$07,$06,$36,$07,$0C,$35
.byte $15,$14,$36,$0D,$08,$18,$05,$13,$35,$15,$0E,$35,$11,$18,$36,$15
.byte $02,$35,$15,$02,$50,$11,$10,$50,$1B,$10,$50,$1B,$1A,$50,$11,$1A
.byte $51,$21,$02,$51,$21,$0A,$51,$23,$1E,$51,$19,$10,$51,$17,$20,$51
.byte $0D,$1C,$51,$07,$00,$52,$1B,$16,$52,$13,$1E,$52,$01,$18,$52,$0B
.byte $04,$53,$11,$02,$53,$1B,$12,$53,$19,$0C,$53,$01,$02,$53,$05,$04
.byte $53,$03,$18,$54,$15,$18,$54,$19,$18,$54,$05,$0A,$54,$0F,$0A,$54
.byte $19,$0A,$55,$01,$02,$55,$05,$04,$55,$05,$16,$55,$01,$18,$56,$05
.byte $0A,$37,$07,$06,$37,$0D,$04,$37,$07,$0E,$37,$0D,$0C,$38,$15,$10
.byte $38,$0F,$08,$38,$07,$02,$3A,$1D,$02,$3B,$15,$02,$3C,$17,$02,$3C
.byte $17,$0C,$3C,$0F,$28,$3C,$1D,$18,$3D,$05,$20,$3D,$0D,$20,$3D,$15
.byte $20,$3D,$1D,$20,$3D,$1D,$02,$3E,$0F,$24,$58,$05,$14,$58,$0D,$08
.byte $58,$17,$00,$59,$01,$00,$59,$07,$04,$59,$09,$0E,$5A,$05,$06,$5A
.byte $0F,$0A,$5A,$01,$16,$5B,$03,$02,$5B,$09,$0C,$5B,$0B,$10,$5B,$13
.byte $10,$5C,$0B,$06,$5C,$13,$08,$5D,$07,$08,$5D,$0B,$06,$5D,$05,$0C
.byte $5D,$09,$0C,$5D,$0D,$0A,$5E,$03,$00,$60,$0B,$0C,$61,$0B,$0C,$62
.byte $0B,$0C,$63,$0B,$0C,$64,$0B,$0C,$66,$07,$0A,$67,$09,$06,$68,$09
.byte $06,$69,$09,$06,$6A,$09,$06,$6B,$09,$06,$44,$11,$08
.byte $45,$07,$02,$46,$0D,$0C
.byte $47,$05,$02
.byte $48,$19
.byte $06
; data -> free
.res 8
; ... skipping $8 FF bytes
.byte $FF

.byte $FF
; free -> unknown

.byte $78,$EE,$DF,$BF,$4C,$86,$FF,$80
.literal "DRAGON WARRIORS2"
.byte $FF,$FF,$00,$00,$48,$04,$01,$0F
.byte $07,$9D,$D8,$BF,$D8,$BF,$D8,$BF

