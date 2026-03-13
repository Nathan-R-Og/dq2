.segment        "PRGA":absolute
; code bytes:	$01FE (3.11% of bytes in this ROM bank)
; data bytes:	$01F7 (3.07% of bytes in this ROM bank)
; pcm bytes:	$0000 (0.00% of bytes in this ROM bank)
; chr bytes:	$0D60 (20.90% of bytes in this ROM bank)
; free bytes:	$2E83 (72.67% of bytes in this ROM bank)
; unknown bytes:	$0028 (0.24% of bytes in this ROM bank)
; $1155 bytes last seen in RAM bank $8000 - $BFFF (100.00% of bytes seen in this ROM bank, 27.08% of bytes in this ROM bank):
;	$01FE code bytes (11.49% of bytes seen in this RAM bank, 3.11% of bytes in this ROM bank)
;	$01F7 data bytes (11.34% of bytes seen in this RAM bank, 3.07% of bytes in this ROM bank)
;	$0D60 chr bytes (77.17% of bytes seen in this RAM bank, 20.90% of bytes in this ROM bank)

; PRG Bank 0x0A: haven't looked at this much, contains the splash screen

; [bank start] -> code
; external control flow target (from $0F:$C68B)
; possible external indexed data load target (from $0F:$F3ED, $0F:$FF28)
; possible external indexed data load target (from $0F:$F3F2, $0F:$FF2D)
    jsr $805C
    jsr $80CF
    jsr $8016
    lda #$0F
    sta $30
; call to code in a different bank ($0F:$C42A)
    jsr $C42A
; call to code in a different bank ($0F:$C3E8)
    jsr $C3E8 ; wait for interrupt, set $6007 to #$FF, turn screen off

; call to code in a different bank ($0F:$C468)
    jmp $C468 ; set every 4th byte of $0200 - $02FC to #$F0


; control flow target (from $8006)
    lda #$00
    sta $99
    ldx #$28
; call to code in a different bank ($0F:$C1EE)
    jsr $C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

    jsr $802F
    ldx #$3C
; call to code in a different bank ($0F:$C1EE)
    jsr $C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

    jsr $802F
    lda #$50
    jmp $8043

; control flow target (from $801F, $8027)
    ldx #$01
; control flow target (from $8040)
B0A_8031:
    txa
    pha
    jsr $818D
    ldx #$02
; call to code in a different bank ($0F:$C1EE)
    jsr $C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

    pla
    tax
    inx
    cpx #$06
    bcc B0A_8031
    rts

; control flow target (from $802C)
    ldx $99
    bne B0A_805B
    sta $0C
; control flow target (from $8059)
; call to code in a different bank ($0F:$C1DC)
B0A_8049:
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

; call to code in a different bank ($0F:$C476)
    jsr $C476 ; read joypad 1 data into $2F

    lda $2F ; joypad 1 data

    beq B0A_8057
    inc $99
    bne B0A_805B
; control flow target (from $8051)
B0A_8057:
    dec $0C
    bne B0A_8049
; control flow target (from $8045, $8055)
B0A_805B:
    rts

; control flow target (from $8000)
; call to code in a different bank ($0F:$C465)
    jsr $C465 ; wait for interrupt and then set every 4th byte of $0200 - $02FC to #$F0

    lda #$08
    sta $30
    lda $8201
    sta $0C
    lda $8202
    sta $0D
    lda $8203
    sta $0E
    lda $8204
    sta $0F
    lda #$00
    sta $10
    sta $11
    lda #$07
    jsr $81E2
    lda $8205
    sta $0C
    lda $8206
    sta $0D
    lda $8207
    sta $0E
    lda $8208
    sta $0F
    lda #$00
    sta $10
    lda #$10
    sta $11
    lda #$07
    jsr $81E2
    lda #$20
    sta $2006 ; VRAM Address Register #2 (write twice; $2007 address)

    lda #$00
    sta $2006 ; VRAM Address Register #2 (write twice; $2007 address)

    lda #$00
    ldx #$08
; control flow target (from $80BA)
B0A_80B1:
    ldy #$00
; control flow target (from $80B7)
B0A_80B3:
    sta $2007 ; VRAM I/O Register

    dey
    bne B0A_80B3
    dex
    bne B0A_80B1
; call to code in a different bank ($0F:$C3E8)
    jsr $C3E8 ; wait for interrupt, set $6007 to #$FF, turn screen off

    lda #$23
    jsr $81E8
    lda #$27
    jsr $81E8
    lda #$00
    sta $6007
    rts

; control flow target (from $8003)
    lda #$00
    tax
    jsr $8138
    lda #$01
    ldx #$00
    jsr $8138
    lda #$02
    ldx #$00
    jsr $8138
    lda #$03
    ldx #$00
    jsr $8140
    lda #$01
    sta $606D
    sta $6074
; call to code in a different bank ($0F:$FE97)
    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $C0
; data -> code
    lda #$04
    ldx #$02
    jsr $8138
    lda #$05
    ldx #$02
    jsr $8138
    lda #$06
    ldx #$02
    jsr $8138
    lda #$00
    jsr $818D
    lda #$FF
    sta $0D
; call to code in a different bank ($0F:$C2EB)
    jsr $C2EB
    lda #$1E
    sta $2001 ; PPU Control Register #2 (#$E0: Full Background Colour, #$01 set [None, Green, Blue, Red], #$E0: Colour Intensity, #$01 not set [None, Green, Blue, Red], #$10: Sprite Visibility, #$80: Background Visibility, #$40: No Sprite Clipping, #$20: No Background Clipping, #$01: Monochrome Display)

    lda #$FF
    sta $0D
    lda $8209
    sta $0E
    lda $820A
    sta $0F
    lda $820B
    sta $10
    lda $820C
    sta $11
; call to code in a different bank ($0F:$C2CD)
    jmp $C2CD


; code -> unknown

.byte $60
; unknown -> code
; control flow target (from $80D2, $80D9, $80E0, $80FA, $8101, $8108)
    jsr $8140
; call to code in a different bank ($0F:$FE97)
    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $C0
; data -> code
    rts

; control flow target (from $80E7, $8138)
    stx $6F
    asl
    tax
    lda $8F87,X
    sta $6D
    lda $8F88,X
    sta $6E
    ldy #$00
    lda ($6D),Y
    sta $607B
    iny
    lda ($6D),Y
    sta $607C
    iny
    lda #$00
    sta $0D
    sta $0F
    lda $607B
    pha
    and #$0F
    sta $0C
    pla
    lsr
    lsr
    lsr
    lsr
    sta $0E
; call to code in a different bank ($0F:$C339)
    jsr $C339 ; 16-bit multiplication: ($10-$11) = ($0C-$0D) * ($0E-$0F); consumes $0C-$0F

    lda $10
    asl
    asl
    tax
; control flow target (from $8180)
B0A_8179:
    lda ($6D),Y
    sta $6009,Y
    iny
    dex
    bne B0A_8179
    lda $6F
    ldx #$0F
; control flow target (from $818A)
B0A_8186:
    sta $606B,X
    dex
    bpl B0A_8186
    rts

; control flow target (from $8033, $810D)
    pha
    lda #$00
    sta $70
    sta $71
    sta $72
    pla
    stx $6F
    asl
    tax
    lda $90C3,X
    sta $6D
    lda $90C4,X
    sta $6E
    ldy #$00
; control flow target (from $81DD)
B0A_81A7:
    lda $6F
    asl
    asl
    tax
    lda ($6D),Y
    cmp #$FF
    beq B0A_81DF
    clc
    adc $70
    sta $0203,X
    iny
    lda ($6D),Y
    clc
    adc $71
    bcs B0A_81C4
    cmp #$F8
    bcc B0A_81C6
; control flow target (from $81BE)
B0A_81C4:
    lda #$F8
; control flow target (from $81C2)
B0A_81C6:
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
    bne B0A_81A7
; control flow target (from $81B0)
; call to code in a different bank ($0F:$C1DC)
B0A_81DF:
    jmp $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF


; control flow target (from $807F, $80A0)
; call to code in a different bank ($0F:$C3E8)
    jsr $C3E8 ; wait for interrupt, set $6007 to #$FF, turn screen off

; call to code in a different bank ($0F:$C3F6)
    jmp $C3F6 ; copy ($0C) inclusive - ($0E) exclusive to PPU at ($10)


; control flow target (from $80C1, $80C6)
    sta $2006 ; VRAM Address Register #2 (write twice; $2007 address)

    lda #$C0
    sta $2006 ; VRAM Address Register #2 (write twice; $2007 address)

    lda #$FF
    ldx #$3F
; control flow target (from $81FE)
B0A_81F4:
    sta $2007 ; VRAM I/O Register

    sta $03C0,X
    sta $07C0,X
    dex
    bpl B0A_81F4
    rts


; code -> data
; start/stop CHR addresses
; data load target (from $8063)
; data load target (from $8068)
.byte $27
; data load target (from $806D)
.byte $82
; data load target (from $8072)
.byte $97
; data load target (from $8082)
.byte $8D
; data load target (from $8087)
.byte $97
; data load target (from $808C)
.byte $8D
; data load target (from $8091)
.byte $87
; data load target (from $8120)
.byte $8F
; data load target (from $8125)
.byte $0D
; data load target (from $812A)
.byte $82
; data load target (from $812F)
.byte $1A
; probably palette
.byte $82
; indirect data load target (via $8209)
; indirect data load target (via $820B)
.byte $08,$0F,$20,$10,$20,$15,$05
.byte $00,$00,$00
.byte $00,$00
.byte $00

.byte $08,$0F,$37,$27,$0F,$27,$17
.byte $0F,$28,$18
.byte $00,$00
.byte $00
; data -> chr
; indirect CHR load target (via $8201)
; indirect CHR load target (via $8203, $8205)
.incbin "../../split/us/gfx/title_splash.bin"

; chr -> data
; indexed data load target (from $8144)
; indirect data load target (via $8207)
; indexed data load target (from $8149)
.byte $95
; indirect data load target (via $8F87)
.byte $8F,$B7,$8F,$E9,$8F,$1B,$90
.byte $4D,$90,$7F
.byte $90,$A9
.byte $90
; indirect data load target
.byte $18
; indirect data load target
.byte $44
; indirect data load target
.byte $2D
; indirect data load target
.byte $2E
; indirect data load target
.byte $2F
; indirect data load target
.byte $30
; indirect data load target
.byte $2F
; indirect data load target
.byte $30
; indirect data load target
.byte $2F
; indirect data load target
.byte $30
; indirect data load target
.byte $2F
; indirect data load target
.byte $30
; indirect data load target
.byte $2F
; indirect data load target
.byte $30
; indirect data load target
.byte $2F
; indirect data load target
.byte $30
; indirect data load target
.byte $31
; indirect data load target
.byte $32
; indirect data load target
.byte $3B
; indirect data load target
.byte $3C
; indirect data load target
.byte $3E
; indirect data load target
.byte $3E
; indirect data load target
.byte $01
; indirect data load target
.byte $02
; indirect data load target
.byte $03
; indirect data load target
.byte $04
; indirect data load target
.byte $05
; indirect data load target
.byte $06
; indirect data load target
.byte $07
; indirect data load target
.byte $08
; indirect data load target
.byte $3E
; indirect data load target
.byte $3E
; indirect data load target
.byte $3D
; indirect data load target (via $8F89)
.byte $3F
; indirect data load target
.byte $1C
; indirect data load target
.byte $52
; indirect data load target
.byte $00
; indirect data load target
.byte $09
; indirect data load target
.byte $35
; indirect data load target
.byte $36
; indirect data load target
.byte $46
; indirect data load target
.byte $3C
; indirect data load target
.byte $3E
; indirect data load target
.byte $0B
; indirect data load target
.byte $0C
; indirect data load target
.byte $0D
; indirect data load target
.byte $0E
; indirect data load target
.byte $0F
; indirect data load target
.byte $10
; indirect data load target
.byte $11
; indirect data load target
.byte $12
; indirect data load target
.byte $13
; indirect data load target
.byte $14
; indirect data load target
.byte $3E
; indirect data load target
.byte $3E
; indirect data load target
.byte $47
; indirect data load target
.byte $35
; indirect data load target
.byte $36
; indirect data load target
.byte $0A
; indirect data load target
.byte $00
; indirect data load target
.byte $15
; indirect data load target
.byte $16
; indirect data load target
.byte $33
; indirect data load target
.byte $34
; indirect data load target
.byte $4C
; indirect data load target
.byte $3E
; indirect data load target
.byte $3E
; indirect data load target
.byte $3E
; indirect data load target
.byte $3E
; indirect data load target
.byte $19
; indirect data load target
.byte $1A
; indirect data load target
.byte $1B
; indirect data load target
.byte $1C
; indirect data load target
.byte $1D
; indirect data load target
.byte $1E
; indirect data load target
.byte $1F
; indirect data load target
.byte $3E
; indirect data load target
.byte $3E
; indirect data load target
.byte $3D
; indirect data load target
.byte $4D
; indirect data load target
.byte $33
; indirect data load target
.byte $34
; indirect data load target
.byte $17
; indirect data load target (via $8F8B)
.byte $18
; indirect data load target
.byte $1C
; indirect data load target
.byte $62
; indirect data load target
.byte $37
; indirect data load target
.byte $38
; indirect data load target
.byte $33
; indirect data load target
.byte $34
; indirect data load target
.byte $46
; indirect data load target
.byte $3C
; indirect data load target
.byte $20
; indirect data load target
.byte $21
; indirect data load target
.byte $22
; indirect data load target
.byte $23
; indirect data load target
.byte $24
; indirect data load target
.byte $25
; indirect data load target
.byte $26
; indirect data load target
.byte $27
; indirect data load target
.byte $28
; indirect data load target
.byte $29
; indirect data load target
.byte $2A
; indirect data load target
.byte $2B
; indirect data load target
.byte $2C
; indirect data load target
.byte $47
; indirect data load target
.byte $33
; indirect data load target
.byte $34
; indirect data load target
.byte $39
; indirect data load target
.byte $3A
; indirect data load target
.byte $42
; indirect data load target
.byte $43
; indirect data load target
.byte $33
; indirect data load target
.byte $34
; indirect data load target
.byte $52
; indirect data load target
.byte $53
; indirect data load target
.byte $54
; indirect data load target
.byte $53
; indirect data load target
.byte $54
; indirect data load target
.byte $53
; indirect data load target
.byte $54
; indirect data load target
.byte $53
; indirect data load target
.byte $54
; indirect data load target
.byte $53
; indirect data load target
.byte $54
; indirect data load target
.byte $53
; indirect data load target
.byte $54
; indirect data load target
.byte $53
; indirect data load target
.byte $54
; indirect data load target
.byte $55
; indirect data load target
.byte $33
; indirect data load target
.byte $34
; indirect data load target
.byte $44
; indirect data load target (via $8F8D)
.byte $45
; indirect data load target
.byte $1C
; indirect data load target
.byte $72
; indirect data load target
.byte $48
; indirect data load target
.byte $49
; indirect data load target
.byte $33
; indirect data load target
.byte $34
; indirect data load target
.byte $5C
; indirect data load target
.byte $5D
; indirect data load target
.byte $5F
; indirect data load target
.byte $5E
; indirect data load target
.byte $5F
; indirect data load target
.byte $5E
; indirect data load target
.byte $5F
; indirect data load target
.byte $5E
; indirect data load target
.byte $5F
; indirect data load target
.byte $5E
; indirect data load target
.byte $5F
; indirect data load target
.byte $5E
; indirect data load target
.byte $5F
; indirect data load target
.byte $5E
; indirect data load target
.byte $60
; indirect data load target
.byte $61
; indirect data load target
.byte $33
; indirect data load target
.byte $34
; indirect data load target
.byte $4A
; indirect data load target
.byte $4B
; indirect data load target
.byte $4E
; indirect data load target
.byte $4F
; indirect data load target
.byte $40
; indirect data load target
.byte $41
; indirect data load target
.byte $69
; indirect data load target
.byte $6A
; indirect data load target
.byte $00
; indirect data load target
.byte $00
; indirect data load target
.byte $00
; indirect data load target
.byte $00
; indirect data load target
.byte $00
; indirect data load target
.byte $00
; indirect data load target
.byte $00
; indirect data load target
.byte $00
; indirect data load target
.byte $00
; indirect data load target
.byte $00
; indirect data load target
.byte $00
; indirect data load target
.byte $00
; indirect data load target
.byte $6B
; indirect data load target
.byte $6C
; indirect data load target
.byte $40
; indirect data load target
.byte $41
; indirect data load target
.byte $50
; indirect data load target (via $8F8F)
.byte $51
; indirect data load target
.byte $34
; indirect data load target
.byte $86
; indirect data load target
.byte $00
; indirect data load target
.byte $00
; indirect data load target
.byte $76
; indirect data load target
.byte $77
; indirect data load target
.byte $78
; indirect data load target
.byte $79
; indirect data load target
.byte $00
; indirect data load target
.byte $00
; indirect data load target
.byte $00
; indirect data load target
.byte $00
; indirect data load target
.byte $84
; indirect data load target
.byte $85
; indirect data load target
.byte $86
; indirect data load target
.byte $87
; indirect data load target
.byte $00
; indirect data load target
.byte $00
; indirect data load target
.byte $00
; indirect data load target
.byte $96
; indirect data load target
.byte $91
; indirect data load target
.byte $92
; indirect data load target
.byte $93
; indirect data load target
.byte $94
; indirect data load target
.byte $95
; indirect data load target
.byte $00
; indirect data load target
.byte $00
; indirect data load target
.byte $A6
; indirect data load target
.byte $A1
; indirect data load target
.byte $A2
; indirect data load target
.byte $A3
; indirect data load target
.byte $A4
; indirect data load target
.byte $A5
; indirect data load target
.byte $00
; indirect data load target
.byte $00
; indirect data load target
.byte $B6
; indirect data load target
.byte $B1
; indirect data load target
.byte $B2
; indirect data load target
.byte $B3
; indirect data load target
.byte $B4
; indirect data load target
.byte $B5
; indirect data load target
.byte $00
; indirect data load target
.byte $00
; indirect data load target
.byte $56
; indirect data load target
.byte $57
; indirect data load target
.byte $58
; indirect data load target
.byte $59
; indirect data load target
.byte $5A
; indirect data load target
.byte $5B
; indirect data load target (via $8F91)
.byte $00
; indirect data load target
.byte $25
; indirect data load target
.byte $B6
; indirect data load target
.byte $00
; indirect data load target
.byte $62
; indirect data load target
.byte $63
; indirect data load target
.byte $64
; indirect data load target
.byte $65
; indirect data load target
.byte $66
; indirect data load target
.byte $67
; indirect data load target
.byte $68
; indirect data load target
.byte $00
; indirect data load target
.byte $00
; indirect data load target
.byte $00
; indirect data load target
.byte $6D
; indirect data load target
.byte $6E
; indirect data load target
.byte $6F
; indirect data load target
.byte $70
; indirect data load target
.byte $71
; indirect data load target
.byte $72
; indirect data load target
.byte $73
; indirect data load target
.byte $74
; indirect data load target
.byte $75
; indirect data load target
.byte $7A
; indirect data load target
.byte $7B
; indirect data load target
.byte $7C
; indirect data load target
.byte $7D
; indirect data load target
.byte $7E
; indirect data load target
.byte $7F
; indirect data load target
.byte $80
; indirect data load target
.byte $81
; indirect data load target
.byte $82
; indirect data load target
.byte $83
; indirect data load target
.byte $88
; indirect data load target
.byte $89
; indirect data load target
.byte $8A
; indirect data load target
.byte $8B
; indirect data load target
.byte $8C
; indirect data load target
.byte $8D
; indirect data load target
.byte $8E
; indirect data load target
.byte $8F
; indirect data load target
.byte $90
; indirect data load target (via $8F93)
.byte $00
; indirect data load target
.byte $16
; indirect data load target
.byte $D5
; indirect data load target
.byte $00
; indirect data load target
.byte $A0
; indirect data load target
.byte $97
; indirect data load target
.byte $98
; indirect data load target
.byte $99
; indirect data load target
.byte $9A
; indirect data load target
.byte $9B
; indirect data load target
.byte $9C
; indirect data load target
.byte $9D
; indirect data load target
.byte $9E
; indirect data load target
.byte $9F
; indirect data load target
.byte $00
; indirect data load target
.byte $00
; indirect data load target
.byte $B0
; indirect data load target
.byte $A7
; indirect data load target
.byte $A8
; indirect data load target
.byte $A9
; indirect data load target
.byte $AA
; indirect data load target
.byte $AB
; indirect data load target
.byte $AC
; indirect data load target
.byte $AD
; indirect data load target
.byte $AE
; indirect data load target
.byte $AF
; indexed data load target (from $819B)
.byte $00
; indexed data load target (from $81A0)
.byte $CF
; indirect data load target (via $90C3)
.byte $90,$10,$91,$21,$91,$32
.byte $91,$43,$91
.byte $FF
.byte $90
; indirect data load target
.byte $78
; indirect data load target
.byte $80
; indirect data load target
.byte $00
; indirect data load target
.byte $00
; indirect data load target
.byte $80
; indirect data load target
.byte $80
; indirect data load target
.byte $01
; indirect data load target
.byte $00
; indirect data load target
.byte $78
; indirect data load target
.byte $88
; indirect data load target
.byte $06
; indirect data load target
.byte $00
; indirect data load target
.byte $80
; indirect data load target
.byte $88
; indirect data load target
.byte $07
; indirect data load target
.byte $00
; indirect data load target
.byte $68
; indirect data load target
.byte $90
; indirect data load target
.byte $02
; indirect data load target
.byte $00
; indirect data load target
.byte $90
; indirect data load target
.byte $90
; indirect data load target
.byte $03
; indirect data load target
.byte $00
; indirect data load target
.byte $71
; indirect data load target
.byte $C8
; indirect data load target
.byte $04
; indirect data load target
.byte $00
; indirect data load target
.byte $87
; indirect data load target
.byte $C8
; indirect data load target
.byte $05
; indirect data load target
.byte $00
; indirect data load target
.byte $68
; indirect data load target
.byte $D8
; indirect data load target
.byte $08
; indirect data load target
.byte $00
; indirect data load target
.byte $90
; indirect data load target
.byte $D8
; indirect data load target
.byte $08
; indirect data load target
.byte $00
; indirect data load target
.byte $78
; indirect data load target
.byte $98
; indirect data load target
.byte $09
; indirect data load target
.byte $00
; indirect data load target
.byte $80
; indirect data load target
.byte $98
; indirect data load target
.byte $0A
; indirect data load target (via $90CD)
.byte $00
; indirect data load target
.byte $78
; indirect data load target
.byte $B0
; indirect data load target
.byte $0B
; indirect data load target
.byte $01
; indirect data load target
.byte $80
; indirect data load target
.byte $B0
; indirect data load target
.byte $0C
; indirect data load target
.byte $01
; indirect data load target
.byte $78
; indirect data load target
.byte $B8
; indirect data load target
.byte $0D
; indirect data load target
.byte $01
; indirect data load target
.byte $80
; indirect data load target
.byte $B8
; indirect data load target
.byte $0E
; indirect data load target
.byte $01
; indirect data load target (via $90C5)
.byte $FF
; indirect data load target
.byte $78
; indirect data load target
.byte $B0
; indirect data load target
.byte $0F
; indirect data load target
.byte $01
; indirect data load target
.byte $80
; indirect data load target
.byte $B0
; indirect data load target
.byte $10
; indirect data load target
.byte $01
; indirect data load target
.byte $78
; indirect data load target
.byte $B8
; indirect data load target
.byte $11
; indirect data load target
.byte $01
; indirect data load target
.byte $80
; indirect data load target
.byte $B8
; indirect data load target
.byte $12
; indirect data load target
.byte $01
; indirect data load target (via $90C7)
.byte $FF
; indirect data load target
.byte $78
; indirect data load target
.byte $B0
; indirect data load target
.byte $13
; indirect data load target
.byte $01
; indirect data load target
.byte $80
; indirect data load target
.byte $B0
; indirect data load target
.byte $14
; indirect data load target
.byte $01
; indirect data load target
.byte $78
; indirect data load target
.byte $B8
; indirect data load target
.byte $15
; indirect data load target
.byte $01
; indirect data load target
.byte $80
; indirect data load target
.byte $B8
; indirect data load target
.byte $16
; indirect data load target
.byte $01
; indirect data load target (via $90C9)
.byte $FF
; indirect data load target
.byte $78
; indirect data load target
.byte $B0
; indirect data load target
.byte $17
; indirect data load target
.byte $01
; indirect data load target
.byte $80
; indirect data load target
.byte $B0
; indirect data load target
.byte $18
; indirect data load target
.byte $01
; indirect data load target
.byte $78
; indirect data load target
.byte $B8
; indirect data load target
.byte $19
; indirect data load target
.byte $01
; indirect data load target
.byte $80
; indirect data load target
.byte $B8
; indirect data load target
.byte $1A
; indirect data load target
.byte $01
; indirect data load target (via $90CB)
.byte $FF
; indirect data load target
.byte $78
; indirect data load target
.byte $B0
; indirect data load target
.byte $1B
; indirect data load target
.byte $01
; indirect data load target
.byte $80
; indirect data load target
.byte $B0
; indirect data load target
.byte $1C
; indirect data load target
.byte $01
; indirect data load target
.byte $78
; indirect data load target
.byte $B8
; indirect data load target
.byte $1D
; indirect data load target
.byte $01
; indirect data load target
.byte $80
; indirect data load target
.byte $B8
; indirect data load target
.byte $1E
; indirect data load target
.byte $01

.byte $FF
; data -> free
; ... skipping $EA9 FF bytes
.byte $FF

.byte $FF
; free -> data

.byte $FF
; data -> free
.res $1fd6+$ea9
; ... skipping $1FD6 FF bytes
.byte $FF

.byte $FF
; free -> unknown

.byte $78,$EE,$DF,$BF,$4C,$86,$FF,$80
.literal "DRAGON WARRIORS2"
.byte $FF,$FF,$00,$00,$48,$04,$01,$0F
.byte $07,$9D,$D8,$BF,$D8,$BF,$D8,$BF

