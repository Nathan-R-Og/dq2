.segment        "CONSTANT":absolute
; code bytes:	$3C56 (94.27% of bytes in this ROM bank)
; data bytes:	$035F (5.27% of bytes in this ROM bank)
; pcm bytes:	$0000 (0.00% of bytes in this ROM bank)
; chr bytes:	$0000 (0.00% of bytes in this ROM bank)
; free bytes:	$0023 (0.21% of bytes in this ROM bank)
; unknown bytes:	$002A (0.26% of bytes in this ROM bank)
; $003B bytes last seen in RAM bank $8000 - $BFFF (0.36% of bytes seen in this ROM bank, 0.36% of bytes in this ROM bank):
;	$002E code bytes (77.97% of bytes seen in this RAM bank, 0.28% of bytes in this ROM bank)
;	$000D data bytes (22.03% of bytes seen in this RAM bank, 0.08% of bytes in this ROM bank)
; $3F78 bytes last seen in RAM bank $C000 - $FFFF (99.64% of bytes seen in this ROM bank, 99.17% of bytes in this ROM bank):
;	$3C28 code bytes (94.78% of bytes seen in this RAM bank, 93.99% of bytes in this ROM bank)
;	$0352 data bytes (5.23% of bytes seen in this RAM bank, 5.19% of bytes in this ROM bank)

; PRG Bank 0x0F: the fixed bank, contains a little bit of everything

; [bank start] -> code
; NMI vector
; indirect control flow target (via $FFFA)
    sei
    pha
    tya
    pha
    txa
    pha
    lda $6007
    bne B0F_C015
    lda $93 ; NMI counter, decremented once per NMI until it reaches 0

    beq B0F_C011
    dec $93 ; NMI counter, decremented once per NMI until it reaches 0

; control flow target (from $C00D)
B0F_C011:
    ldy $00
    bpl B0F_C018
; control flow target (from $C009)
B0F_C015:
    jmp $C0C3

; control flow target (from $C013)
B0F_C018:
    lda $6145
    bpl B0F_C020
    jmp $C148

; control flow target (from $C01B)
B0F_C020:
    ldy $00
    beq B0F_C080
    dey
    beq B0F_C080
    dey
; control flow target (from $C07C)
B0F_C028:
    lda $C138,Y
    sta $2006 ; VRAM Address Register #2 (write twice; $2007 address)

    iny
    lda $C138,Y
    sta $2006 ; VRAM Address Register #2 (write twice; $2007 address)

    iny
    lda #$5F
    sta $2007 ; VRAM I/O Register

    sta $2007 ; VRAM I/O Register

    sta $2007 ; VRAM I/O Register

    sta $2007 ; VRAM I/O Register

    sta $2007 ; VRAM I/O Register

    sta $2007 ; VRAM I/O Register

    sta $2007 ; VRAM I/O Register

    sta $2007 ; VRAM I/O Register

    sta $2007 ; VRAM I/O Register

    sta $2007 ; VRAM I/O Register

    sta $2007 ; VRAM I/O Register

    sta $2007 ; VRAM I/O Register

    sta $2007 ; VRAM I/O Register

    sta $2007 ; VRAM I/O Register

    sta $2007 ; VRAM I/O Register

    sta $2007 ; VRAM I/O Register

    sta $2007 ; VRAM I/O Register

    sta $2007 ; VRAM I/O Register

    sta $2007 ; VRAM I/O Register

    sta $2007 ; VRAM I/O Register

    sta $2007 ; VRAM I/O Register

    sta $2007 ; VRAM I/O Register

    cpy #$10
    bne B0F_C028
    beq B0F_C0B1
; control flow target (from $C022, $C025)
B0F_C080:
    lda $0183
    beq B0F_C088
    jmp $C1A0

; control flow target (from $C083)
B0F_C088:
    lda $02
    cmp #$18
    bcs B0F_C093
    lda #$02
    sta $4014 ; Sprite DMA Register (copy $100 bytes from $100 * N)

; control flow target (from $C08C)
B0F_C093:
    ldx #$00
; control flow target (from $C0AE)
    cpx $02
    beq B0F_C0B1
    lda $0300,X ; PPU write buffer start

    sta $2006 ; VRAM Address Register #2 (write twice; $2007 address)

    inx
    lda $0300,X ; PPU write buffer start

    sta $2006 ; VRAM Address Register #2 (write twice; $2007 address)

    inx
    lda $0300,X ; PPU write buffer start

    sta $2007 ; VRAM I/O Register

    inx
    jmp $C095

; control flow target (from $C07E, $C097, $C19D, $C1D9)
B0F_C0B1:
    lda #$00
    sta $01
    sta $02
    sta $0183
    jsr $C103
    lda #$00
    sta $00
    inc $03 ; game clock?

; control flow target (from $C015)
    jsr $C60B ; initialize MMC control mode and CHR banks

    lda #$03
    jsr $C3D8 ; CLI and load bank specified by A

; call to code in a different bank ($03:$8000)
    jsr $8000
    lda $05F6 ; current bank

    jsr $C3D8 ; CLI and load bank specified by A

    tsx
; ummm... skipping X/Y/A on stack, if second caller is $FFC0 - $FFD4 inclusive, mess around with stack, pull X/Y/A, clobber A with current bank, and RTI
; else pull X/Y/A and RTI
    lda $0106,X
    cmp #$FF
    bne B0F_C0FD
    lda $0105,X
    cmp #$C0
    bcc B0F_C0FD
    cmp #$D5
    bcs B0F_C0FD
    lda #$04
    ora $0104,X
    sta $0104,X
    lda #$C0
    sta $0105,X
    pla
    tax
    pla
    tay
    pla
    lda $05F6 ; current bank

    rti

; control flow target (from $C0DA, $C0E1, $C0E5)
B0F_C0FD:
    pla
    tax
    pla
    tay
    pla
    rti

; control flow target (from $C0BA)
    lda #$3F
    sta $2006 ; VRAM Address Register #2 (write twice; $2007 address)

    lda #$00
    sta $2006 ; VRAM Address Register #2 (write twice; $2007 address)

    lda $30
    and #$0F
    sta $2007 ; VRAM I/O Register

    lda #$00
    sta $2006 ; VRAM Address Register #2 (write twice; $2007 address)

    sta $2006 ; VRAM Address Register #2 (write twice; $2007 address)

    lda $04
    bne B0F_C125
    lda $61AE
    bne B0F_C128
; control flow target (from $C11E)
B0F_C125:
    lda $61AF
; control flow target (from $C123)
B0F_C128:
    ora #$80
    sta $2000 ; PPU Control Register #1 (#$80: Execute NMI on VBlank, #$40: unused, #$20: Sprite Size [8x8/8x16], #$10: Background Pattern Table Address [$0000/$1000], #$08: Sprite Pattern Table Address [$0000/$1000], #$04: PPU Address Increment [1/32], #$03: Name Table Address [$2000/$2400/$2800/$2C00])

    lda $05
    sta $2005 ; VRAM Address Register #1 (write twice; BG scroll)

    lda $06
    sta $2005 ; VRAM Address Register #1 (write twice; BG scroll)

    rts


; code -> data
; PPU addresses
; indexed data load target (from $C028, $C02F)

.byte $22,$65,$22,$85,$22,$A5,$22,$C5
.byte $22,$E5,$23,$05
.byte $23,$25
.byte $23
.byte $45
; data -> code
; control flow target (from $C01D)
    ldx #$00
    ldy $01
    beq B0F_C19A
; control flow target (from $C198)
B0F_C14E:
    lda $0300,X ; PPU write buffer start

    sta $2006 ; VRAM Address Register #2 (write twice; $2007 address)

    lda $0301,X
    sta $2006 ; VRAM Address Register #2 (write twice; $2007 address)

    lda $0302,X
    sta $2007 ; VRAM I/O Register

    lda $0303,X
    sta $2007 ; VRAM I/O Register

    lda $0300,X ; PPU write buffer start

    sta $2006 ; VRAM Address Register #2 (write twice; $2007 address)

    lda $0301,X
    ora #$20
    sta $2006 ; VRAM Address Register #2 (write twice; $2007 address)

    lda $0304,X
    sta $2007 ; VRAM I/O Register

    lda $0305,X
    sta $2007 ; VRAM I/O Register

    lda $0306,X
    sta $2006 ; VRAM Address Register #2 (write twice; $2007 address)

    lda $0307,X
    sta $2006 ; VRAM Address Register #2 (write twice; $2007 address)

    lda $0308,X
    sta $2007 ; VRAM I/O Register

    txa
    clc
    adc #$09
    tax
    dey
    bne B0F_C14E
; control flow target (from $C14C)
B0F_C19A:
    sty $6145
    jmp $C0B1

; control flow target (from $C085)
    ldx #$00
    lda $2002 ; PPU Status Register (#$80: In VBlank, #$40: Sprite #0 Hit, #$20: Scanline Sprite Count > 8, #$10: Ignore VRAM Writes); after read, #$80 and $2005-$2006 are reset

    lda $02
    beq B0F_C1CF
; control flow target (from $C1CD)
B0F_C1A9:
    ldy #$01
    lda $0300,X ; PPU write buffer start

    bpl B0F_C1B4
    inx
    ldy $0300,X ; PPU write buffer start

; control flow target (from $C1AE)
B0F_C1B4:
    inx
    and #$3F
    sta $2006 ; VRAM Address Register #2 (write twice; $2007 address)

    lda $0300,X ; PPU write buffer start

    inx
    sta $2006 ; VRAM Address Register #2 (write twice; $2007 address)

; control flow target (from $C1C9)
B0F_C1C1:
    lda $0300,X ; PPU write buffer start

    inx
    sta $2007 ; VRAM I/O Register

    dey
    bne B0F_C1C1
    dec $01
    bne B0F_C1A9
; control flow target (from $C1A7)
B0F_C1CF:
    lda $6008
    bne B0F_C1D9
    lda #$02
    sta $4014 ; Sprite DMA Register (copy $100 bytes from $100 * N)

; control flow target (from $C1D2)
B0F_C1D9:
    jmp $C0B1

; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF
; control flow target (from $C1EE, $C22C, $C23F, $C30A, $C3E8, $C421, $C465, $C595, $C67D, $C747, $C7EC, $C975, $C9A8, $CCD9, $CFA5, $D0E2, $D13D, $D317, $D48C, $D65B, $D6EE, $D72B, $D73F, $E2B8, $E2CE, $E5EC, $E609, $E660, $E69D, $E6D6, $E6EC, $E719, $E743, $E764, $E7B7, $E7EA, $E817, $E841, $E862, $E972, $E980, $E9F9, $EB6D, $F476, $F862, $F868, $FB05, $FD08, $FD9C)
; external control flow target (from $00:$803C, $00:$807B, $00:$8328, $00:$83A4, $00:$B783, $00:$B80A, $00:$B822, $00:$B95C, $02:$AB9B, $02:$B1FA, $02:$B717, $04:$8CE9, $04:$8D9B, $04:$8DE1, $04:$8E02, $04:$8E05, $04:$8E3F, $04:$8E9A, $04:$8EAE, $04:$8EB1, $04:$8FE7, $04:$902C, $04:$909B, $04:$90B7, $04:$99F9, $04:$9A39, $06:$8048, $06:$8905, $06:$8929, $06:$895F, $06:$8988, $06:$A262, $06:$A270, $06:$A273, $06:$A617, $06:$A620, $06:$A984, $06:$AF9B, $06:$B21B, $07:$81C3, $07:$8654, $07:$86E5, $07:$8715, $07:$8908, $07:$89BD, $07:$89CF, $08:$804F, $08:$8296, $08:$832E, $09:$802D, $09:$8070, $09:$8098, $09:$80CC, $09:$80DD, $09:$82A0, $09:$82EA, $09:$82ED, $09:$8310, $09:$8313, $09:$9E19, $09:$9EFB, $09:$9F59, $09:$9F95, $09:$9FFC, $09:$A02E, $09:$A03F, $09:$A07D, $09:$A0F3, $0A:$8049, $0A:$81DF)
    lda #$00
    sta $6007
    lda #$01
    sta $00
; control flow target (from $C1E7)
B0F_C1E5:
    lda $00
    bne B0F_C1E5
    lda #$FF
    sta $00
    rts

; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF
; control flow target (from $C1F2, $C329, $C520, $C592, $C5A5, $C6A5, $C82C, $C83B, $CAE6, $CC4A, $CD74, $CD83, $D0F9, $D5D7, $FC3A)
; external control flow target (from $00:$B7B5, $00:$B8BF, $04:$9019, $06:$824C, $06:$8A57, $06:$8B01, $06:$96AD, $06:$96C0, $06:$970E, $06:$97CB, $06:$98F5, $06:$9941, $06:$A2EB, $06:$A316, $06:$BBEC, $06:$BC3A, $06:$BC88, $06:$BD1E, $06:$BD76, $06:$BD86, $06:$BD93, $07:$81CB, $07:$81F0, $07:$81F9, $07:$85C8, $07:$863F, $07:$866D, $07:$8672, $07:$867A, $07:$867F, $07:$898F, $09:$8002, $09:$80A4, $09:$80D7, $09:$9E13, $09:$9E4C, $09:$9E5B, $09:$9E62, $09:$9F44, $09:$9FDC, $0A:$801C, $0A:$8024, $0A:$8038)
B0F_C1EE:
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    dex
    bne B0F_C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

    rts

; wait for battle message delay to expire
; control flow target (from $C1F7)
; external control flow target (from $04:$9A13)
B0F_C1F5:
    lda $93 ; NMI counter, decremented once per NMI until it reaches 0

    bne B0F_C1F5 ; wait for battle message delay to expire

    rts

; wait for $02 to not be #$C0, write PPU address in $07-$08 and data in $09 to PPU write buffer at $0300,$02, $01 += 1, $02 += 3, and set $0183 to #$00
; control flow target (from $C1FE, $C2C9, $D65E, $D661, $D66F, $D672, $DEBA, $DED7, $DEE7, $DF03, $DF14, $DF3D, $FD26, $FD99)
; external control flow target (from $00:$83AC, $00:$B95F, $02:$B74F, $04:$8D92, $04:$8DD8, $04:$8E91, $04:$909E, $04:$9A36, $06:$8996, $06:$AF73, $06:$B0A9, $07:$897A, $07:$8A90, $09:$8089, $09:$81ED)
B0F_C1FA:
    ldx $02
    cpx #$C0
    beq B0F_C1FA ; wait for $02 to not be #$C0, write PPU address in $07-$08 and data in $09 to PPU write buffer at $0300,$02, $01 += 1, $02 += 3, and set $0183 to #$00; wait for $02 to not be #$C0

    lda $08 ; PPU address, high byte

    sta $0300,X ; PPU write buffer start

    inx
    lda $07 ; PPU address, low byte

    sta $0300,X ; PPU write buffer start

    inx
    lda $09 ; PPU tile ID

    sta $0300,X ; PPU write buffer start

    inx
    inc $01
    stx $02
    inc $07 ; INC 16-bit PPU address $07-$08

    bne B0F_C21C
    inc $08
; control flow target (from $C218)
B0F_C21C:
    pha
    lda #$00
    sta $0183
    pla
    rts

; control flow target (from $C315)
    lda #$10
    bne B0F_C24C
; control flow target (from $C324)
; external control flow target (from $06:$A284, $07:$8668)
    lda #$00
    beq B0F_C24C
; external control flow target (from $00:$B92E, $04:$8738, $04:$90D1, $04:$90D7, $04:$A0F5, $06:$866C, $06:$8BF0, $06:$8CC5, $06:$9431, $06:$951F, $06:$95F6, $06:$A1ED, $06:$AEB4, $06:$BD53)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    lda #$00
    sta $0C
    ldx #$02
    jsr $C242
    ldx #$00
    lda #$10
    jsr $C242
    jmp $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF


; control flow target (from $C235, $C23C)
    ldy $C2E7,X
    sty $0A
    ldy $C2E8,X
    sty $0B
; control flow target (from $C226, $C22A)
B0F_C24C:
    sta $07
    lda #$3F
    sta $08
    ldy #$01
; control flow target (from $C266)
B0F_C254:
    lda $30
    and #$0F
    jsr $C2BE
    jsr $C269
    jsr $C2BB
    jsr $C2BB
    cpy #$0D
    bne B0F_C254
    rts

; control flow target (from $C25B)
    lda $30
    bmi B0F_C2BB
    lda $07
    cmp #$01
    bne B0F_C2BB
    clc
    php
    ldx #$00
; control flow target (from $C2B1)
B0F_C277:
    lda $062D,X ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    asl
    and #$08
    beq B0F_C2AA
    bcs B0F_C287
    plp
    lda #$26
    jmp $C2BD

; control flow target (from $C27F)
B0F_C287:
    lda $0630,X ; Midenhall Max HP low byte

    pha
    lda $0631,X ; Midenhall Max HP high byte

    lsr
    ror $0630,X ; Midenhall Max HP low byte

    lsr
    ror $0630,X ; Midenhall Max HP low byte

    cmp $063C,X ; Midenhall Current HP, high byte

    bne B0F_C2A1
    lda $0630,X ; Midenhall Max HP low byte

    cmp $063B,X ; Midenhall Current HP, low byte

; control flow target (from $C299)
B0F_C2A1:
    pla
    sta $0630,X ; Midenhall Max HP low byte

    bcc B0F_C2AA
    plp
    sec
    php
; control flow target (from $C27D, $C2A5)
B0F_C2AA:
    txa
    clc
    adc #$12
    tax
    cmp #$36
    bcc B0F_C277
    plp
    bcc B0F_C2BB
    lda #$37
    jmp $C2BD

; control flow target (from $C25E, $C261, $C26B, $C271, $C2B4)
B0F_C2BB:
    lda ($0A),Y
; control flow target (from $C284, $C2B8)
    iny
; control flow target (from $C258)
    sec
    sbc $0C
    bcs B0F_C2C7
    lda $30
    and #$0F
; control flow target (from $C2C1)
B0F_C2C7:
    sta $09
    jsr $C1FA ; wait for $02 to not be #$C0, write PPU address in $07-$08 and data in $09 to PPU write buffer at $0300,$02, $01 += 1, $02 += 3, and set $0183 to #$00

    rts

; control flow target (from $E32C)
; external control flow target (from $07:$8A76, $09:$815D, $0A:$8134, $0B:$8084)
    ldy #$00
; control flow target (from $C2DC)
B0F_C2CF:
    lda ($0E),Y
    sta $0500,Y
    lda ($10),Y
    sta $050D,Y
    iny
    cpy #$0D
    bne B0F_C2CF
; external control flow target (from $06:$828A)
    lda #$30
    sta $0C
    lda #$F0
; external indexed data load target (from $06:$827F)
    jmp $C309


; code -> data
; indexed data load target (from $C242, $C2FB)
; indexed data load target (from $C247)
.byte $00
; external data load target (from $06:$A276)
.byte $05
; external data load target (from $06:$A27B)
.byte $0D

.byte $05
; data -> code
; control flow target (from $C42E)
; external control flow target (from $06:$8253, $0A:$8114)
    lda $3C
    cmp #$30
    bne B0F_C2F9
    lda #$00
    jsr $C3D5 ; save A to $05F6, X to $43, and load bank specified by A

; call to code in a different bank ($00:$800F)
    jsr $800F
; control flow target (from $C2EF)
B0F_C2F9:
    ldx #$03
; control flow target (from $C301)
B0F_C2FB:
    lda $C2E7,X
    sta $0E,X
    dex
    bpl B0F_C2FB
    lda #$00
    sta $0C
    lda #$10
; control flow target (from $C2E4)
    pha
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

; control flow target (from $C335)
B0F_C30D:
    lda $0E
    sta $0A
    lda $0F
    sta $0B
    jsr $C224
    lda $0D
    beq B0F_C327
    lda $10
    sta $0A
    lda $11
    sta $0B
    jsr $C228
; control flow target (from $C31A)
B0F_C327:
    ldx #$04
    jsr $C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

    pla
    pha
    clc
    adc $0C
    sta $0C
    cmp #$50
    bcc B0F_C30D
    pla
    rts

; 16-bit multiplication: ($10-$11) = ($0C-$0D) * ($0E-$0F); consumes $0C-$0F
; control flow target (from $D692, $E19F, $E472)
; external control flow target (from $02:$B03E, $06:$86B4, $0A:$8171)
    lda #$00
    sta $10
    sta $11
; control flow target (from $C35C)
    lda $0C
    ora $0D
    beq B0F_C35F
    lsr $0D
    ror $0C
    bcc B0F_C358
    lda $0E
    clc
    adc $10
    sta $10
    lda $0F
    adc $11
    sta $11
; control flow target (from $C349)
B0F_C358:
    asl $0E
    rol $0F
    jmp $C33F

; control flow target (from $C343)
B0F_C35F:
    rts

; 16-bit division: ($0C-$0D) / ($0E-$0F) = quotient in ($0C-$0D), remainder in ($10-$11)
; external control flow target (from $02:$B063)
    ldy #$10 ; 16 bit logic

    lda #$00 ; initialize remainder

    sta $10
    sta $11
; control flow target (from $C390)
B0F_C368:
    asl $0C ; 16-bit ASL $0C-$0D into 16-bit $10-$11

    rol $0D
    rol $10
    rol $11
    inc $0C ; assume ($10-$11) >= ($0E-$0F), INC quotient and MOD remainder

    lda $10
    sec
    sbc $0E
    sta $10
    lda $11
    sbc $0F
    sta $11
    bcs B0F_C38F ; branch if assumption was correct; otherwise undo INC/MOD

    lda $10
    adc $0E
    sta $10
    lda $11
    adc $0F
    sta $11
    dec $0C
; control flow target (from $C37F)
B0F_C38F:
    dey
    bne B0F_C368 ; if more bits to divide, divide them

    rts

; control flow target (from $DF71)
    ldy #$08
    lda #$00
; control flow target (from $C3A6)
B0F_C397:
    asl $0C
    rol
    inc $0C
    sec
    sbc $0E
    bcs B0F_C3A5
    adc $0E
    dec $0C
; control flow target (from $C39F)
B0F_C3A5:
    dey
    bne B0F_C397
    sta $10
    rts

; generate a random number and store it in $32-$33 (two passes)
; control flow target (from $C490, $D685, $D99C)
; external control flow target (from $04:$802D, $04:$80DC, $04:$824F, $04:$97CC, $04:$9880, $04:$A005, $04:$A044, $04:$AEDF, $04:$B078, $04:$B6C1, $04:$B793, $06:$846C, $06:$8744, $06:$8847, $06:$921E, $06:$9B5D, $06:$9BBE, $06:$9C41, $06:$BC6B, $06:$BCE8, $06:$BCF4, $06:$BD0E, $09:$9E5E)
    lda #$FF
    sta $0C
    jsr $C3B6 ; generate a random number and store it in $32-$33 (one pass)

    lda #$FF
    sta $0C
; generate a random number and store it in $32-$33 (one pass)
; control flow target (from $C3AF)
; external control flow target (from $06:$ACC6)
    ldy #$08
; control flow target (from $C3D2)
B0F_C3B8:
    lda $33 ; RNG byte 1

    eor $0C
    asl $32 ; RNG byte 0

    rol $33 ; RNG byte 1

    asl $0C
    asl
    bcc B0F_C3D1
    lda $32 ; RNG byte 0

    eor #$21
    sta $32 ; RNG byte 0

    lda $33 ; RNG byte 1

    eor #$10
    sta $33 ; RNG byte 1

; control flow target (from $C3C3)
B0F_C3D1:
    dey
    bne B0F_C3B8
    rts

; save A to $05F6, X to $43, and load bank specified by A
; control flow target (from $C2F3, $C3DC, $C4E8, $C4FA, $C506, $C50E, $C544, $C55E, $C569, $C574, $C57F, $C58A, $C688, $C690, $CCEE, $CFA2, $D09B, $D0E7, $D2FF, $D31C, $D34A, $F782, $F86D, $FCFA)
; external control flow target (from $02:$B205, $06:$BC85)
    jmp $FFBB ; save A to $05F6, X to $43, and load bank specified by A


; CLI and load bank specified by A
; control flow target (from $C0C8, $C0D1)
    cli
    jmp $FFC0 ; load bank specified by A

; load bank specified by A, wait for interrupt, set $6007 to #$FF, turn screen off, copy ($0C) inclusive - ($0E) exclusive to PPU at ($10), wait for interrupt, turn screen sprites and backround on
; external control flow target (from $00:$8039, $00:$80FF)
    jsr $C3D5 ; save A to $05F6, X to $43, and load bank specified by A

    jsr $C3E8 ; wait for interrupt, set $6007 to #$FF, turn screen off

    jsr $C3F6 ; copy ($0C) inclusive - ($0E) exclusive to PPU at ($10)

    jmp $C41C ; wait for interrupt, turn screen sprites and backround on


; wait for interrupt, set $6007 to #$FF, turn screen off
; control flow target (from $C3DF, $C446)
; external control flow target (from $00:$803F, $00:$807E, $00:$823A, $04:$8715, $08:$801B, $0A:$8010, $0A:$80BC, $0A:$81E2, $0B:$8087)
B0F_C3E8:
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    lda #$FF
    sta $6007
    lda #$00 ; screen off

    sta $2001 ; PPU Control Register #2 (#$E0: Full Background Colour, #$01 set [None, Green, Blue, Red], #$E0: Colour Intensity, #$01 not set [None, Green, Blue, Red], #$10: Sprite Visibility, #$80: Background Visibility, #$40: No Sprite Clipping, #$20: No Background Clipping, #$01: Monochrome Display)

    rts

; copy ($0C) inclusive - ($0E) exclusive to PPU at ($10)
; control flow target (from $C3E2)
; external control flow target (from $00:$8081, $00:$80C0, $00:$8396, $04:$8A84, $0A:$81E5, $0B:$808A)
    lda $11 ; PPU address high byte; PPU address low byte

    sta $2006 ; VRAM Address Register #2 (write twice; $2007 address)

    lda $10
    sta $2006 ; VRAM Address Register #2 (write twice; $2007 address)

    ldy #$00
; control flow target (from $C416, $C41A)
B0F_C402:
    lda ($0C),Y ; CHR data

    sta $2007 ; VRAM I/O Register

    lda $0C
    cmp $0E ; CHR end address low byte (exclusive)

    bne B0F_C414 ; update $0C-$0D

    lda $0D
    cmp $0F ; CHR end address high byte (exclusive)

    bne B0F_C414 ; update $0C-$0D

    rts

; update $0C-$0D
; control flow target (from $C40B, $C411)
B0F_C414:
    inc $0C
    bne B0F_C402
    inc $0D
    bne B0F_C402
; wait for interrupt, turn screen sprites and backround on
; control flow target (from $C3E5, $C462)
; external control flow target (from $00:$8078, $00:$80E2, $00:$8325, $04:$8730, $06:$A98C)
    lda #$00 ; useless op

    sta $6007 ; useless op

    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    lda #$18 ; turn sprites and backround on

    sta $2001 ; PPU Control Register #2 (#$E0: Full Background Colour, #$01 set [None, Green, Blue, Red], #$E0: Colour Intensity, #$01 not set [None, Green, Blue, Red], #$10: Sprite Visibility, #$80: Background Visibility, #$40: No Sprite Clipping, #$20: No Background Clipping, #$01: Monochrome Display)

    rts

; control flow target (from $C52D, $C6F3, $C97B, $D2B6, $D2DE, $E27E, $E287)
; external control flow target (from $04:$870F, $06:$A97E, $07:$81BD, $07:$81D6, $07:$84DD, $07:$851F, $07:$853B, $07:$85F6, $07:$88FF, $08:$8018, $09:$8005, $0A:$800D)
    lda #$FF
    sta $0D
    jsr $C2EB
    ldx #$00
    txa
; control flow target (from $C438)
B0F_C434:
    sta $0400,X ; menu-based palette overrides start

    inx
    bne B0F_C434
    ldx #$C0
; control flow target (from $C443)
B0F_C43C:
    sta $0300,X ; PPU write buffer start

    sta $0700,X
    inx
    bne B0F_C43C
    rts

; turn screen off, write $800 [space] tiles to PPU $2000, turn screen on
; control flow target (from $C533, $D2E1)
; external control flow target (from $04:$870C, $06:$A981, $07:$81C0, $07:$8902, $08:$801E, $09:$8008)
    jsr $C3E8 ; wait for interrupt, set $6007 to #$FF, turn screen off

    lda #$20
    sta $2006 ; VRAM Address Register #2 (write twice; $2007 address)

    lda #$00
    sta $2006 ; VRAM Address Register #2 (write twice; $2007 address)

    lda #$5F
    ldx #$08
; control flow target (from $C460)
B0F_C457:
    ldy #$00
; control flow target (from $C45D)
B0F_C459:
    sta $2007 ; VRAM I/O Register

    dey
    bne B0F_C459
    dex
    bne B0F_C457
    jmp $C41C ; wait for interrupt, turn screen sprites and backround on


; wait for interrupt and then set every 4th byte of $0200 - $02FC to #$F0
; control flow target (from $C530, $D2E4, $E281, $E28A)
; external control flow target (from $04:$86FE, $07:$8905, $09:$800B, $0A:$805C)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

; set every 4th byte of $0200 - $02FC to #$F0
; control flow target (from $C67A, $D8E0)
; external control flow target (from $07:$81BA, $08:$8021, $0A:$8013)
    ldx #$00
    lda #$F0
; control flow target (from $C473)
B0F_C46C:
    sta $0200,X ; sprite buffer start

    inx
    inx
    inx
    inx
    bne B0F_C46C
    rts

; read joypad 1 data into $2F
; control flow target (from $C704, $D140)
; external control flow target (from $02:$B71A, $04:$9A4D, $06:$8930, $06:$A976, $06:$AFAE, $06:$BC5D, $06:$BC74, $06:$BC7B, $08:$8299, $08:$8335, $0A:$804C)
    lda #$01
    sta $4016 ; Joypad #1 (READ: #$10: Zapper Trigger Not Pulled, #$08: Zapper Sprite Detection, #$01: Joypad Data; WRITE: #$01: Reset Joypad Strobe, set Expansion Port Method to Read)

    lda #$00
    sta $4016 ; Joypad #1 (READ: #$10: Zapper Trigger Not Pulled, #$08: Zapper Sprite Detection, #$01: Joypad Data; WRITE: #$01: Reset Joypad Strobe, set Expansion Port Method to Read)

    ldy #$08 ; 8 bits of data to read

; control flow target (from $C48C)
B0F_C482:
    lda $4016 ; Joypad #1 (READ: #$10: Zapper Trigger Not Pulled, #$08: Zapper Sprite Detection, #$01: Joypad Data; WRITE: #$01: Reset Joypad Strobe, set Expansion Port Method to Read)

    and #$03 ; mask off the non-joypad data (should be AND #$01?)

    cmp #$01 ; set C to low bit of joypad data

    ror $2F ; joypad 1 data

    dey
    bne B0F_C482 ; loop until all 8 bits read

    ldx $0C ; save value of $0C in X

    jsr $C3AB ; generate a random number and store it in $32-$33 (two passes)

    stx $0C ; restore value of $0C from X

    rts

; given a hero ID in $9C and an item ID in A, SEC if hero has that item, CLC otherwise
; control flow target (from $C4B0, $C4B6)
    stx $CB ; save X for later

    sta $9B ; item ID

    lda $9C ; hero ID

    asl ; 8 inventory slots per hero

    asl
    asl
    tax
    ldy #$08 ; 8 inventory slots per hero

; control flow target (from $C4AC)
B0F_C4A2:
    lda $0600,X ; Midenhall inventory item 1 (| #$40 if equipped)

    cmp $9B ; item ID

    sec
    beq B0F_C4AF ; if found, RTS

    inx
    dey
    bne B0F_C4A2 ; if more inventory to check, check it

    clc ; if we get here, then hero does not posses item $9B

; control flow target (from $C4A8)
B0F_C4AF:
    rts

; given a hero ID in $9C and an item ID in A, SEC if hero has that item, CLC otherwise
; external control flow target (from $04:$A4ED, $04:$A9E4, $04:$AFCF, $04:$AFE3, $04:$AFEC, $04:$B3D1, $06:$8DC0, $06:$A1C1)
    jsr $C496 ; given a hero ID in $9C and an item ID in A, SEC if hero has that item, CLC otherwise

    ldx $CB ; restore the original value of X

    rts

; given a hero ID in $9C and an item ID in A, remove that item from hero's inventory if present and SEC, CLC otherwise
; external control flow target (from $06:$8DC9, $06:$92CF, $06:$92DE, $06:$97A7)
    jsr $C496 ; given a hero ID in $9C and an item ID in A, SEC if hero has that item, CLC otherwise

    bcs B0F_C4BE ; given a party inventory offset in X and a number of items to be moved up in Y, move that many inventory items up

    ldx $CB ; restore the original value of X

    rts

; given a party inventory offset in X and a number of items to be moved up in Y, move that many inventory items up
; control flow target (from $C4B9, $C4C8, $C4E3)
B0F_C4BE:
    dey ; number of items to move up

    beq B0F_C4CB ; if zero, then done moving items up

; copy item N+1 to item N
    lda $0601,X ; Midenhall inventory item 2 (| #$40 if equipped)

    sta $0600,X ; Midenhall inventory item 1 (| #$40 if equipped)

    inx
    jmp $C4BE ; given a party inventory offset in X and a number of items to be moved up in Y, move that many inventory items up


; control flow target (from $C4BF)
B0F_C4CB:
    lda #$00 ; set the final inventory slot to #$00 (no item)

    sta $0600,X ; Midenhall inventory item 1 (| #$40 if equipped)

    ldx $CB ; restore the original value of X

    sec
    rts

; given hero ID in A and hero inventory offset in X, remove that item from hero's inventory and move all lower items up 1 slot
; external control flow target (from $04:$A4F6, $06:$853D, $06:$95FC, $06:$9621, $06:$9706, $06:$9A1C, $06:$9AB7)
    stx $CB
    asl
    asl
    asl
    clc
    adc $CB
    tax ; X = A * 8 + X, i.e. convert hero inventory offset to party inventory offset

    lda #$08
    sec
    sbc $CB
    tay ; Y = number of items to bubble up

    jmp $C4BE ; given a party inventory offset in X and a number of items to be moved up in Y, move that many inventory items up


; return 1 byte from bank 1's ($00,Y) in A, INC 16-bit $00,Y-$01,Y
; external control flow target (from $04:$8F9F)
    lda #$01
    jsr $C3D5 ; save A to $05F6, X to $43, and load bank specified by A

    tya
    tax
    lda ($00,X)
    inc $00,X
    bne B0F_C4F5
    inc $01,X
; control flow target (from $C4F1)
B0F_C4F5:
    pha
    ldx $43
    lda #$04
    jsr $C3D5 ; save A to $05F6, X to $43, and load bank specified by A

    pla
    rts

; external control flow target (from $00:$B798, $00:$B7B0)
    bcc B0F_C504
    jsr $C511 ; flash screen 5 times

; control flow target (from $C4FF, $D328, $FF66)
B0F_C504:
    lda #$04
    jsr $C3D5 ; save A to $05F6, X to $43, and load bank specified by A

; call to code in a different bank ($04:$8015)
    jsr $8015
    lda #$00
    jmp $C3D5 ; save A to $05F6, X to $43, and load bank specified by A


; flash screen 5 times
; control flow target (from $C501)
; external control flow target (from $06:$BD17, $06:$BD81, $06:$BD8E, $07:$84F9, $07:$8687)
    ldx #$05
    bne B0F_C517
; flash screen 10 times
; external control flow target (from $04:$86ED, $04:$9CA0, $06:$85AF, $06:$8606, $06:$8BC6, $06:$9172, $06:$940B, $06:$9519, $06:$96C3, $06:$9944, $06:$9947, $06:$BD3B, $06:$BD3E, $07:$8625)
    ldx #$0A
; control flow target (from $C513, $C52A)
B0F_C517:
    txa ; save X on the stack

    pha
    and #$01 ; pick out the even/odd bit

    eor #$19 ; enable sprites and background, toggle monochrome

    pha ; new PPU setting

    ldx #$03
    jsr $C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

    pla ; new PPU setting

    sta $2001 ; PPU Control Register #2 (#$E0: Full Background Colour, #$01 set [None, Green, Blue, Red], #$E0: Colour Intensity, #$01 not set [None, Green, Blue, Red], #$10: Sprite Visibility, #$80: Background Visibility, #$40: No Sprite Clipping, #$20: No Background Clipping, #$01: Monochrome Display)

    pla ; restore X from the stack

    tax
    dex
    bne B0F_C517 ; loop until no more flashes left

    rts

; external control flow target (from $09:$8027)
    jsr $C42A
    jsr $C465 ; wait for interrupt and then set every 4th byte of $0200 - $02FC to #$F0

    jsr $C446 ; turn screen off, write $800 [space] tiles to PPU $2000, turn screen on

    lda #$8F
    sta $30
    lda #$00
    sta $05
    sta $06
    sta $04
    lda #$00
    jsr $C3D5 ; save A to $05F6, X to $43, and load bank specified by A

    lda #$06
    sta $0C
; call to code in a different bank ($00:$8000)
    jsr $8000
    lda #$0E
    sta $0C
; call to code in a different bank ($00:$8000)
    jsr $8000
    lda #$0F
    sta $0C
; call to code in a different bank ($00:$8000)
    jsr $8000
    lda #$09
    jmp $C3D5 ; save A to $05F6, X to $43, and load bank specified by A


; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])
; control flow target (from $C58D, $C5A0, $CAD2, $CFF6, $D03D, $D0D2, $D21A, $D22E, $D4E8, $D4FE, $D53E, $D6E3, $E383, $F693, $F69C, $FD82)
; external control flow target (from $00:$B793, $00:$B7AB, $00:$B8ED, $02:$B728, $04:$86FB, $04:$8AD5, $04:$8AEA, $04:$8FE4, $04:$959A, $04:$969E, $04:$973F, $04:$980B, $04:$98FA, $04:$9B61, $04:$9B71, $04:$9C84, $04:$9C9D, $04:$9CB4, $06:$81AC, $06:$882F, $06:$89F7, $06:$8BC3, $06:$8C5A, $06:$97C6, $06:$A18C, $06:$A254, $06:$A298, $06:$A2BC, $06:$B0D3, $06:$BC17, $06:$BD08, $06:$BD27, $06:$BD6E, $06:$BD7E, $06:$BD8B, $07:$8207, $07:$8218, $07:$83F1, $07:$84DA, $07:$8512, $07:$8538, $07:$85F3, $07:$8605, $07:$8613, $07:$8618, $07:$861D, $07:$8622, $07:$862B, $07:$8635, $07:$8684, $07:$868F, $08:$81E7, $08:$81F6, $08:$820E)
    sei
    tax
    lda $05F6 ; current bank

    pha ; save current bank on the stack

    lda #$03
    jsr $C3D5 ; save A to $05F6, X to $43, and load bank specified by A

    txa
; call to code in a different bank ($03:$8003)
    jsr $8003 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    pla ; restore current bank from stack

    sta $05F6 ; current bank

    jmp $C3D5 ; save A to $05F6, X to $43, and load bank specified by A


; set $6144 to #$05
; external control flow target (from $06:$AA60, $07:$81C6, $07:$81FF, $07:$83E9, $07:$84E0, $08:$8015)
    sei
    tax
    lda $05F6 ; current bank

    pha
    lda #$03
    jsr $C3D5 ; save A to $05F6, X to $43, and load bank specified by A

    txa
; call to code in a different bank ($03:$8009)
    jsr $8009
    pla
    sta $05F6 ; current bank

    jmp $C3D5 ; save A to $05F6, X to $43, and load bank specified by A


; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM]), wait for it to finish, then play previous BGM
; external control flow target (from $06:$8111, $06:$8258, $06:$8656, $06:$8735, $06:$8A4F, $06:$9742, $06:$998A, $06:$A956)
    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    ldx #$03
    jsr $C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

; control flow target (from $C59B)
; external control flow target (from $04:$975B, $04:$9902)
B0F_C595:
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    lda $0156 ; probably music playing flag? set to #$00 when music finishes

    bne B0F_C595
; control flow target (from $C5A8)
; external control flow target (from $06:$A2F5)
    lda $05F7 ; probably BGM for current area

    jmp $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])


; external control flow target (from $04:$968F, $04:$9731)
    ldx #$3C
    jsr $C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

    jmp $C59D

; IRQ/BRK vector handler
; indirect control flow target (via $FFFE)
    bit $4015 ; READ: pAPU Sound/Vertical Clock Signal Register (#$40: Vertical Clock Signal IRQ Availability, #$10: Delta Modulation, #$08: Noise, #$04: Triangle, #$02: Pulse #2, #$01: Pulse #1), WRITE: pAPU Channel Control (#$10: Delta Modulation, #$08: Noise, #$04: Triangle, #$02: Pulse #2, #$01: Pulse #1)

    rti

; reset vector handler
; control flow target (from $FFDB)
    cld
; control flow target (from $C5B3)
B0F_C5B0:
    lda $2002 ; PPU Status Register (#$80: In VBlank, #$40: Sprite #0 Hit, #$20: Scanline Sprite Count > 8, #$10: Ignore VRAM Writes); after read, #$80 and $2005-$2006 are reset

    bpl B0F_C5B0 ; wait for VBlank

; control flow target (from $C5B8)
B0F_C5B5:
    lda $2002 ; PPU Status Register (#$80: In VBlank, #$40: Sprite #0 Hit, #$20: Scanline Sprite Count > 8, #$10: Ignore VRAM Writes); after read, #$80 and $2005-$2006 are reset

    bpl B0F_C5B5 ; wait for VBlank again

    lda #$08
    sta $2000 ; PPU Control Register #1 (#$80: Execute NMI on VBlank, #$40: unused, #$20: Sprite Size [8x8/8x16], #$10: Background Pattern Table Address [$0000/$1000], #$08: Sprite Pattern Table Address [$0000/$1000], #$04: PPU Address Increment [1/32], #$03: Name Table Address [$2000/$2400/$2800/$2C00])

    lda #$00
    sta $2001 ; PPU Control Register #2 (#$E0: Full Background Colour, #$01 set [None, Green, Blue, Red], #$E0: Colour Intensity, #$01 not set [None, Green, Blue, Red], #$10: Sprite Visibility, #$80: Background Visibility, #$40: No Sprite Clipping, #$20: No Background Clipping, #$01: Monochrome Display)

    sta $FFFF ; swap in bank 0

    sta $FFFF
    sta $FFFF
    sta $FFFF
    sta $FFFF
    sta $6145
    sta $6146
    lda #$88
    sta $61AE
    lda #$89
    sta $61AF
    ldx #$FF ; reset stack pointer

    txs
    ldy #$00
    sty $00
    sty $01
    tya
; control flow target (from $C5F9)
B0F_C5ED:
    sta ($00),Y ; reset all $800 of system RAM to #$00

    inc $00
    bne B0F_C5F5
    inc $01
; control flow target (from $C5F1)
B0F_C5F5:
    ldx $01
    cpx #$08
    bne B0F_C5ED
    lda #$0E ; 8kb CHR, 16kb+fixed-last PRG, vertical mirroring

    sta $0192 ; MMC1 control mode (#$10 = CHR mode [1 8k block/2 4k blocks], #$0C = PRG mode [32kb/32kb/fixed-first+16kb/16kb+fixed-last], #$03 = Mirroring [1 low/1 high/vertical/horizontal])

    lda #$00 ; CHR bank 0

    sta $0193 ; CHR bank 0

    jsr $C60B ; initialize MMC control mode and CHR banks

    jmp $C661

; initialize MMC control mode and CHR banks
; control flow target (from $C0C3, $C605)
    inc $FFDE ; #$80; used to reset MMC1 shift register and switch to last-fixed-bank mode

    lda $0192 ; MMC1 control mode (#$10 = CHR mode [1 8k block/2 4k blocks], #$0C = PRG mode [32kb/32kb/fixed-first+16kb/16kb+fixed-last], #$03 = Mirroring [1 low/1 high/vertical/horizontal])

    jsr $C61F ; set MMC control mode based on A

    lda $0193 ; CHR bank 0

    jsr $C636 ; set CHR bank 0 based on A

    lda #$00
    jmp $C64D ; set CHR bank 1 based on A


; set MMC control mode based on A
; control flow target (from $C611)
; external control flow target (from $07:$8917, $07:$89C2, $09:$801A)
    sta $0192 ; MMC1 control mode (#$10 = CHR mode [1 8k block/2 4k blocks], #$0C = PRG mode [32kb/32kb/fixed-first+16kb/16kb+fixed-last], #$03 = Mirroring [1 low/1 high/vertical/horizontal])

    sta $9FFF
    lsr
    sta $9FFF
    lsr
    sta $9FFF
    lsr
    sta $9FFF
    lsr
    sta $9FFF
    rts

; set CHR bank 0 based on A
; control flow target (from $C617, $D19B)
    sta $0193 ; CHR bank 0

    sta $BFFF
    lsr
    sta $BFFF
    lsr
    sta $BFFF
    lsr
    sta $BFFF
    lsr
    sta $BFFF
    rts

; set CHR bank 1 based on A
; control flow target (from $C61C)
    sta $DFFF
    lsr
    sta $DFFF
    lsr
    sta $DFFF
    lsr
    sta $DFFF
    lsr
    sta $DFFF
    rts

; control flow target (from $C608)
    lda #$FF
    sta $00
    sty $01 ; Y is still #$00

    lda #$8F
    sta $30
    lda #$00
    sta $6007
    lda #$88
    sta $2000 ; PPU Control Register #1 (#$80: Execute NMI on VBlank, #$40: unused, #$20: Sprite Size [8x8/8x16], #$10: Background Pattern Table Address [$0000/$1000], #$08: Sprite Pattern Table Address [$0000/$1000], #$04: PPU Address Increment [1/32], #$03: Name Table Address [$2000/$2400/$2800/$2C00])

    lda #$00
    sta $2001 ; PPU Control Register #2 (#$E0: Full Background Colour, #$01 set [None, Green, Blue, Red], #$E0: Colour Intensity, #$01 not set [None, Green, Blue, Red], #$10: Sprite Visibility, #$80: Background Visibility, #$40: No Sprite Clipping, #$20: No Background Clipping, #$01: Monochrome Display)

    jsr $C468 ; set every 4th byte of $0200 - $02FC to #$F0

    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    jsr $F775 ; load ROM bank #$03

; call to code in a different bank ($03:$8006)
    jsr $8006
    lda #$0A
    jsr $C3D5 ; save A to $05F6, X to $43, and load bank specified by A

; call to code in a different bank ($0A:$8000)
    jsr $8000
    lda #$0B
    jsr $C3D5 ; save A to $05F6, X to $43, and load bank specified by A

; call to code in a different bank ($0B:$8000)
    jsr $8000
    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $00
; data -> code
    lda #$FF
    sta $6008
    lda #$8F
    sta $30
    ldx #$1E
    jsr $C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

    jsr $F75C ; load ROM bank #$00

    lda #$05
    sta $0C
; call to code in a different bank ($00:$8000)
    jsr $8000
    jsr $C75E ; copy $C7A7-$C7AE to $053A-$0541, set $1F to #$FF

    ldx #$17
; control flow target (from $C6BE)
B0F_C6B7:
    lda $C78F,X ; hero starting equipment

    sta $0600,X ; Midenhall inventory item 1 (| #$40 if equipped)

    dex
    bpl B0F_C6B7
    lda #$FF
    sta $8E ; flag for in battle or not (#$FF)?

    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $C2
; data -> code
    lda #$00
    sta $8E ; flag for in battle or not (#$FF)?

    sta $61AD
    lda $7070 ; ????, SRAM buffer

    bne B0F_C6ED
    jsr $C76C
    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $CF
; data -> code
    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $E0
; data -> code
    lda #$07
    sta $48 ; last save point ID

    jsr $C81F
    lda #$00 ; Save Point ID #$00: Midenhall 2F

    sta $48 ; last save point ID

    jmp $C700

; control flow target (from $C6D2)
B0F_C6ED:
    jsr $F761 ; load ROM bank #$06

    jsr $C76C
    jsr $C42A
    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $C3
; data -> code
    jsr $D2B9
; call to code in a different bank ($06:$8F4E)
    jsr $8F4E
; control flow target (from $C6EA, $C716, $C898, $C91E, $C928, $C9BD, $CA4A, $CA91, $CAB0, $CAB7, $CB39, $CB5F, $CBA2, $CBDC, $CC07, $CC5D, $CC9F, $D292)
    lda #$00
    sta $03 ; game clock?

; control flow target (from $C75B)
    jsr $C476 ; read joypad 1 data into $2F

    lda $2F ; joypad 1 data

    lsr
    bcc B0F_C719
    jsr $F761 ; load ROM bank #$06

; call to code in a different bank ($06:$8048)
    jsr $8048
    lda #$00
    sta $35 ; flag indicating whether any menu is currently open

    jmp $C700

; control flow target (from $C70A)
B0F_C719:
    lda $2F ; joypad 1 data

    and #$10
    beq B0F_C725
    jsr $E797
    jmp $C87F

; control flow target (from $C71D)
B0F_C725:
    lda $2F ; joypad 1 data

    and #$20
    beq B0F_C731
    jsr $E6B4
    jmp $C87F

; control flow target (from $C729)
B0F_C731:
    lda $2F ; joypad 1 data

    and #$40
    beq B0F_C73D
    jsr $E636
    jmp $C87F

; control flow target (from $C735)
B0F_C73D:
    lda $2F ; joypad 1 data

    bpl B0F_C747
    jsr $E5C2
    jmp $C87F

; control flow target (from $C73F, $D426, $E5CD, $E641, $E6BF, $E7A2)
B0F_C747:
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    lda $03 ; game clock?

    cmp #$51
    bne B0F_C758
    jsr $EB76 ; open menu specified by next byte


; code -> data
; indirect data load target

.byte $00
; data -> code
    lda #$51
    sta $03 ; game clock?

; control flow target (from $C74E)
B0F_C758:
    jsr $D8CB
    jmp $C704

; copy $C7A7-$C7AE to $053A-$0541, set $1F to #$FF
; control flow target (from $C6B2)
    ldy #$07
; control flow target (from $C767)
B0F_C760:
    lda $C7A7,Y
    sta $053A,Y
    dey
    bpl B0F_C760
    sty $1F ; some kind of map type (#$00: World Map, #$01: other non-dungeon maps, #$02: maps #$2B - #$43 inclusive, #$03: maps >= #$44, #$FF => game menu); $1F = #$FF

    rts

; control flow target (from $C6D4, $C6F0)
    lda #$84
    sta $062D ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    jsr $F766 ; load ROM bank #$04

; call to code in a different bank ($04:$8009)
    jsr $8009 ; update each hero's stats based on their current EXP

    lda #$0F
    sta $30
; restore full HP/MP to all living party members
; control flow target (from $D2D5)
; external control flow target (from $06:$9419, $06:$BD4C)
    lda #$01 ; make sure each hero has at least 1 HP so that $06:$8DCC will fully heal them

    sta $063B ; Midenhall Current HP, low byte

    sta $064D ; Cannock Current HP, low byte

    sta $065F ; Moonbrooke Current HP, low byte

    jsr $F761 ; load ROM bank #$06

; call to code in a different bank ($06:$8DCC)
    jsr $8DCC ; restore full HP to all living party members

; call to code in a different bank ($06:$8DEC)
    jmp $8DEC ; restore full MP to all living party members



; code -> data
; hero starting equipment
; Midenhall
; indexed data load target (from $C6B7)
; Cannock
.byte $55,$00,$00,$00
.byte $00,$00
.byte $00
.byte $00
; Moonbrooke
.byte $45,$55,$00,$00
.byte $00,$00
.byte $00
.byte $00
; indexed data load target (from $C760)
.byte $41,$51,$00,$00
.byte $00,$00
.byte $00
.byte $00

.byte $80,$6F,$00,$00
.byte $00,$00
.byte $02
.byte $00
; data -> code
; control flow target (from $C81F, $D2D8, $FF5A)
    lda #$FF
    sta $44 ; non-saved event status (#$00 = event start, #$01 = Lianport Gremlins defeated, #$02 = met with Lianport grandfather/have no friends at Shrine SW of Cannock, #$03 = King Midenhall moved to stairs, #$04 = King Midenhall moved down stairs, #$05 = King Midenhall spoke on Midenhall 1F, #$0B = Lighthouse Wizard 7F, #$1B Lighthouse Wizard 2F spoke, #$64 = Hargon dead, #$FF = event end)

    lda $48 ; last save point ID

    asl
    asl
    tay
    lda $C7EF,Y ; save point map ID

    sta $31 ; current map ID

    lda $C7F0,Y ; save point X-pos

    sta $16 ; current map X-pos (1)

    sta $28 ; current map X-pos (2)

    sta $2A ; current map X-pos pixel, low byte

    lda $C7F1,Y ; save point Y-pos

    sta $17 ; current map Y-pos (1)

    sta $29 ; current map Y-pos (2)

    sta $2C ; current map Y-pos pixel, low byte

    lda $C7F2,Y ; save point ???

    sta $45
    lda #$00
    sta $38
    sta $2B ; current map X-pos pixel, high byte

    sta $2D ; current map Y-pos pixel, high byte

    ldx #$04 ; convert 16x16 map positions to pixels

; control flow target (from $C7E7)
B0F_C7DE:
    asl $2A ; current map X-pos pixel, low byte

    rol $2B ; current map X-pos pixel, high byte

    asl $2C ; current map Y-pos pixel, low byte

    rol $2D ; current map Y-pos pixel, high byte

    dex
    bne B0F_C7DE
    jsr $E28A
    jmp $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF



; code -> data
; save point map ID
; indexed data load target (from $C7B8)
; save point X-pos
.byte $02
; indexed data load target (from $C7BD)
; save point Y-pos
.byte $03
; indexed data load target (from $C7C6)
; save point ???
.byte $04
; indexed data load target (from $C7CF)
; indirect data load target
.byte $05

.byte $06,$03,$05,$05,$0C,$1B,$07,$05,$0F,$0E,$06,$05,$15,$02,$02,$05
.byte $1F,$04,$03,$05,$07,$0F,$02,$05,$02,$06,$03,$00,$09,$07
.byte $0A,$FF,$03,$0F,$11,$FF,$01
.byte $63,$6F,$FF,$01
.byte $CF,$38
.byte $FF
; data -> code
; control flow target (from $C6E3)
    jsr $C7AF
    lda #$0A
    sta $0571 ; NPC #$06 sprite ID

    jsr $D8CB
    ldx #$3C
    jsr $C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

    jsr $CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)


; code -> data
; indirect data load target
; indirect data load target
.byte $83
; indirect data load target
.byte $20

.byte $C1
.byte $80
; data -> code
    jsr $CCD2 ; execute scripted motion

    ldx #$3C
    jsr $C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

    jsr $F6EA ; open main dialogue window and display string ID specified by byte following JSR


; code -> data
; indirect data load target

.byte $73
; data -> code
    lda #$FF
    sta $0571 ; NPC #$06 sprite ID

    jsr $D8CB
    jsr $D0F5 ; wait for a while and then wipe menu regions #$03, #$00, and #$01

    jsr $EB76 ; open menu specified by next byte


; code -> data
; indirect data load target

.byte $04
; data -> code
    lda #$00
    jsr $FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    jsr $FA2A ; display string ID specified by next byte


; code -> data
; indirect data load target

.byte $74
; data -> code
    jsr $D0F5 ; wait for a while and then wipe menu regions #$03, #$00, and #$01

    jsr $CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)


; code -> data
; indirect data load target
; indirect data load target
.byte $81
; indirect data load target
.byte $22

.byte $4A
.byte $80
; data -> code
    jsr $CCD2 ; execute scripted motion

    lda #$03
    sta $44 ; non-saved event status (#$00 = event start, #$01 = Lianport Gremlins defeated, #$02 = met with Lianport grandfather/have no friends at Shrine SW of Cannock, #$03 = King Midenhall moved to stairs, #$04 = King Midenhall moved down stairs, #$05 = King Midenhall spoke on Midenhall 1F, #$0B = Lighthouse Wizard 7F, #$1B Lighthouse Wizard 2F spoke, #$64 = Hargon dead, #$FF = event end)

    lda #$00
    sta $35 ; flag indicating whether any menu is currently open

    rts


; code -> data
; Hargon's minion map ID
; indexed data load target (from $C8AF)
; Hargon's minion X-pos
.byte $46
; indexed data load target (from $C8B7)
; indirect data load target
; Hargon's minion Y-pos
.byte $06
; indexed data load target (from $C8BF)
; Hargon's minion $05FD value
.byte $05
; indexed data load target (from $C8C4)
; Hargon's minion fixed encounter ID
.byte $04
; indexed data load target (from $C8CE)

.byte $08,$47,$01,$01,$08,$09
.byte $48,$0B,$03
.byte $10
.byte $0A
; data -> code
; control flow target (from $C722, $C72E, $C73A, $C744)
    jsr $D46B
    lda $D0 ; Malroth status flag (#$FF = defeated, #$00 = alive, others = countdown to battle)

    bpl B0F_C89B
    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $DD
; data -> code
    lda $31 ; current map ID

    cmp #$03 ; Map ID #$03: Midenhall 1F

    bne B0F_C898
    lda #$06
    sta $94 ; return bank for various function calls, doubles as index of selected option for multiple-choice menus

    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $DC
; data -> code
; control flow target (from $C88E)
B0F_C898:
    jmp $C700

; control flow target (from $C884)
B0F_C89B:
    jsr $F761 ; load ROM bank #$06

; call to code in a different bank ($06:$A09E)
    jsr $A09E
    nop
    nop
    nop
    nop
    nop
    nop
    lda $31 ; current map ID

    cmp #$0F ; Map ID #$0F: Osterfair

    beq B0F_C90B
    ldy #$00
; control flow target (from $C8EA)
B0F_C8AF:
    cmp $C870,Y ; Hargon's minion map ID

    bne B0F_C8E3
    lda $16 ; current map X-pos (1)

    lsr
    cmp $C871,Y ; Hargon's minion X-pos

    bne B0F_C8EC
    lda $17 ; current map Y-pos (1)

    lsr
    cmp $C872,Y ; Hargon's minion Y-pos

    bne B0F_C8EC
    lda $C873,Y ; Hargon's minion $05FD value

    sta $05FD
    and $D1 ; fixed battle status bits (#$10 = Zarlox, #$08 = Bazuzu, #$04 = Atlas, #$02 = Hamlin Waterway Gremlins, #$01 = Evil Clown)

    bne B0F_C8EC ; branch if minion already dead

    lda $C874,Y ; Hargon's minion fixed encounter ID

    jsr $D25C ; trigger fixed battle A

    lda $98 ; outcome of last fight?

    cmp #$FC
    beq B0F_C8EC
    lda $D1 ; fixed battle status bits (#$10 = Zarlox, #$08 = Bazuzu, #$04 = Atlas, #$02 = Hamlin Waterway Gremlins, #$01 = Evil Clown)

    ora $05FD
    sta $D1 ; fixed battle status bits (#$10 = Zarlox, #$08 = Bazuzu, #$04 = Atlas, #$02 = Hamlin Waterway Gremlins, #$01 = Evil Clown)

    bne B0F_C8EC
; control flow target (from $C8B2)
B0F_C8E3:
    iny
    iny
    iny
    iny
    iny
    cpy #$0F
    bne B0F_C8AF
; control flow target (from $C8BA, $C8C2, $C8CC, $C8D8, $C8E1)
B0F_C8EC:
    jsr $F766 ; load ROM bank #$04

    lda $1D
    beq B0F_C905
    lda #$00
    ldx $05FD
    sta $05FD
    cpx #$00
    beq B0F_C905
; call to code in a different bank ($04:$8018)
    jsr $8018
    jmp $C908

; control flow target (from $C8F1, $C8FD)
; call to code in a different bank ($04:$8000)
B0F_C905:
    jsr $8000
; control flow target (from $C902)
    jsr $D262
; control flow target (from $C8AB)
B0F_C90B:
    lda $31 ; current map ID

    cmp #$29 ; Map ID #$29: Rubiss' Shrine B7

    bne B0F_C921
    jsr $CD26 ; set Z if your current map position is the (X, Y) co-ordinates given by the next 2 bytes


; code -> data
; indirect data load target
; indirect data load target
.byte $03

.byte $03
; data -> code
    bne B0F_C921
    jsr $D2FB ; load ROM bank 6

; call to code in a different bank ($06:$A2A7)
    jsr $A2A7
    jmp $C700

; control flow target (from $C90F, $C916)
B0F_C921:
    lda $44 ; non-saved event status (#$00 = event start, #$01 = Lianport Gremlins defeated, #$02 = met with Lianport grandfather/have no friends at Shrine SW of Cannock, #$03 = King Midenhall moved to stairs, #$04 = King Midenhall moved down stairs, #$05 = King Midenhall spoke on Midenhall 1F, #$0B = Lighthouse Wizard 7F, #$1B Lighthouse Wizard 2F spoke, #$64 = Hargon dead, #$FF = event end)

    beq B0F_C92B
    jmp $C9C0

; control flow target (from $C930)
B0F_C928:
    jmp $C700

; control flow target (from $C923)
B0F_C92B:
    jsr $CD26 ; set Z if your current map position is the (X, Y) co-ordinates given by the next 2 bytes


; code -> data
; indirect data load target
; indirect data load target
.byte $05

.byte $08
; data -> code
    bne B0F_C928
    jsr $CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)


; code -> data
; indirect data load target
; indirect data load target
.byte $88
; indirect data load target
.byte $22

.byte $10
.byte $80
; data -> code
    lda #$00
    sta $98 ; outcome of last fight?

    jsr $CCD2 ; execute scripted motion

; control flow target (from $C978)
    jsr $F6F6 ; open main dialogue window and display string ID specified by byte following JSR + #$0200


; code -> data
; indirect data load target

.byte $B3
; data -> code
    jsr $D0F5 ; wait for a while and then wipe menu regions #$03, #$00, and #$01

    lda $98 ; outcome of last fight?

    bne B0F_C95C
    jsr $CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)


; code -> data
; indirect data load target
; indirect data load target
.byte $87
; indirect data load target
.byte $20

.byte $1D
.byte $80
; data -> code
    jsr $CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)


; code -> data
; indirect data load target
; indirect data load target
.byte $86
; indirect data load target
.byte $23

.byte $18
.byte $80
; data -> code
    jsr $CCD2 ; execute scripted motion

; control flow target (from $C949)
B0F_C95C:
    jsr $F766 ; load ROM bank #$04

    lda #$00 ; Fixed Battle #$00: 2 Gremlins (Map ID #$0B: Lianport)

; call to code in a different bank ($04:$800F)
    jsr $800F
    lda #$00
    sta $8E ; flag for in battle or not (#$FF)?

    lda $98 ; outcome of last fight?

    cmp #$FC
    beq B0F_C972
    cmp #$FF
    bne B0F_C97B
; control flow target (from $C96C)
B0F_C972:
    jsr $D262
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    jmp $C940

; control flow target (from $C970)
B0F_C97B:
    jsr $C42A
    lda #$FF
    sta $0589 ; NPC #$09 sprite ID

    sta $0591 ; NPC #$0A sprite ID

    lda #$05
    sta $0594 ; NPC #$0B X-pos

    lda #$08
    sta $0595 ; NPC #$0B Y-pos

    lda #$03
    sta $0598 ; NPC #$0B motion nybble + direction nybble

    lda #$04
    sta $16 ; current map X-pos (1)

    sta $28 ; current map X-pos (2)

    lda #$40
    sta $2A ; current map X-pos pixel, low byte

    lda #$01 ; update ship status: you beat the Gremlins

    sta $CF ; ship status (#$04 = on ship, #$02 = own ship, #$01 = beat Lianport Gremlins)

    lda #$06
    jsr $D29A
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    jsr $F6F6 ; open main dialogue window and display string ID specified by byte following JSR + #$0200


; code -> data
; indirect data load target

.byte $B4
; data -> code
    jsr $D0F5 ; wait for a while and then wipe menu regions #$03, #$00, and #$01

    jsr $CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)


; code -> data
; indirect data load target
; indirect data load target
.byte $88
; indirect data load target
.byte $21

.byte $22
.byte $80
; data -> code
    lda #$01
    sta $44 ; non-saved event status (#$00 = event start, #$01 = Lianport Gremlins defeated, #$02 = met with Lianport grandfather/have no friends at Shrine SW of Cannock, #$03 = King Midenhall moved to stairs, #$04 = King Midenhall moved down stairs, #$05 = King Midenhall spoke on Midenhall 1F, #$0B = Lighthouse Wizard 7F, #$1B Lighthouse Wizard 2F spoke, #$64 = Hargon dead, #$FF = event end)

    jmp $C700

; control flow target (from $C925)
    cmp #$01
    beq B0F_C9C7
    jmp $CA4D

; control flow target (from $C9C2)
B0F_C9C7:
    jsr $CD26 ; set Z if your current map position is the (X, Y) co-ordinates given by the next 2 bytes


; code -> data
; indirect data load target
; indirect data load target
.byte $0F

.byte $08
; data -> code
    bne B0F_C9D2
    lda #$01
    bne B0F_C9ED
; control flow target (from $C9CC)
B0F_C9D2:
    jsr $CD26 ; set Z if your current map position is the (X, Y) co-ordinates given by the next 2 bytes


; code -> data
; indirect data load target
; indirect data load target
.byte $11

.byte $08
; data -> code
    bne B0F_C9DD
    lda #$03
    bne B0F_C9ED
; control flow target (from $C9D7)
B0F_C9DD:
    jsr $CD26 ; set Z if your current map position is the (X, Y) co-ordinates given by the next 2 bytes


; code -> data
; indirect data load target
; indirect data load target
.byte $10

.byte $09
; data -> code
    bne B0F_CA4A
    lda #$00
    sta $0540 ; NPC #$00 ? + direction nybble

    lda #$02
    bne B0F_C9F0
; control flow target (from $C9D0, $C9DB)
B0F_C9ED:
    sta $0540 ; NPC #$00 ? + direction nybble

; control flow target (from $C9EB)
B0F_C9F0:
    sta $44 ; non-saved event status (#$00 = event start, #$01 = Lianport Gremlins defeated, #$02 = met with Lianport grandfather/have no friends at Shrine SW of Cannock, #$03 = King Midenhall moved to stairs, #$04 = King Midenhall moved down stairs, #$05 = King Midenhall spoke on Midenhall 1F, #$0B = Lighthouse Wizard 7F, #$1B Lighthouse Wizard 2F spoke, #$64 = Hargon dead, #$FF = event end)

    jsr $F6F6 ; open main dialogue window and display string ID specified by byte following JSR + #$0200


; code -> data
; indirect data load target

.byte $B5
; data -> code
    lda $44 ; non-saved event status (#$00 = event start, #$01 = Lianport Gremlins defeated, #$02 = met with Lianport grandfather/have no friends at Shrine SW of Cannock, #$03 = King Midenhall moved to stairs, #$04 = King Midenhall moved down stairs, #$05 = King Midenhall spoke on Midenhall 1F, #$0B = Lighthouse Wizard 7F, #$1B Lighthouse Wizard 2F spoke, #$64 = Hargon dead, #$FF = event end)

    cmp #$01
    bne B0F_CA05
    jsr $CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)


; code -> data
; indirect data load target
; indirect data load target
.byte $88
; indirect data load target
.byte $20

.byte $2F
.byte $80
; data -> code
    bcc B0F_CA0C
; control flow target (from $C9FA)
B0F_CA05:
    jsr $CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)


; code -> data
; indirect data load target
; indirect data load target
.byte $88
; indirect data load target
.byte $20

.byte $33
.byte $80
; data -> code
; control flow target (from $CA03)
B0F_CA0C:
    jsr $CCD2 ; execute scripted motion

    lda $44 ; non-saved event status (#$00 = event start, #$01 = Lianport Gremlins defeated, #$02 = met with Lianport grandfather/have no friends at Shrine SW of Cannock, #$03 = King Midenhall moved to stairs, #$04 = King Midenhall moved down stairs, #$05 = King Midenhall spoke on Midenhall 1F, #$0B = Lighthouse Wizard 7F, #$1B Lighthouse Wizard 2F spoke, #$64 = Hargon dead, #$FF = event end)

    cmp #$01
    bne B0F_CA1E
    jsr $CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)


; code -> data
; indirect data load target
; indirect data load target
.byte $89
; indirect data load target
.byte $22

.byte $36
.byte $80
; data -> code
    bcc B0F_CA32
; control flow target (from $CA13)
B0F_CA1E:
    cmp #$02
    bne B0F_CA2B
    jsr $CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)


; code -> data
; indirect data load target
; indirect data load target
.byte $89
; indirect data load target
.byte $22

.byte $39
.byte $80
; data -> code
    bcc B0F_CA32
; control flow target (from $CA20)
B0F_CA2B:
    jsr $CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)


; code -> data
; indirect data load target
; indirect data load target
.byte $89
; indirect data load target
.byte $22

.byte $3C
.byte $80
; data -> code
; control flow target (from $CA1C, $CA29)
B0F_CA32:
    jsr $CCD2 ; execute scripted motion

    jsr $FA32 ; display string ID specified by next byte + #$0200


; code -> data
; indirect data load target

.byte $B6
; data -> code
    jsr $D0F5 ; wait for a while and then wipe menu regions #$03, #$00, and #$01

    jsr $CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)


; code -> data
; indirect data load target
; indirect data load target
.byte $89
; indirect data load target
.byte $20

.byte $3F
.byte $80
; data -> code
; control flow target (from $CA6D)
B0F_CA43:
    jsr $CCD2 ; execute scripted motion

    lda #$FF
    sta $44 ; non-saved event status (#$00 = event start, #$01 = Lianport Gremlins defeated, #$02 = met with Lianport grandfather/have no friends at Shrine SW of Cannock, #$03 = King Midenhall moved to stairs, #$04 = King Midenhall moved down stairs, #$05 = King Midenhall spoke on Midenhall 1F, #$0B = Lighthouse Wizard 7F, #$1B Lighthouse Wizard 2F spoke, #$64 = Hargon dead, #$FF = event end)

; control flow target (from $C9E2, $CA5D)
B0F_CA4A:
    jmp $C700

; control flow target (from $C9C4)
    cmp #$02
    bne B0F_CA6F
    jsr $CD26 ; set Z if your current map position is the (X, Y) co-ordinates given by the next 2 bytes


; code -> data
; indirect data load target
; indirect data load target
.byte $03

.byte $03
; data -> code
    beq B0F_CA5F
    jsr $CD26 ; set Z if your current map position is the (X, Y) co-ordinates given by the next 2 bytes


; code -> data
; indirect data load target
; indirect data load target
.byte $04

.byte $03
; data -> code
    bne B0F_CA4A
; control flow target (from $CA56)
B0F_CA5F:
    jsr $CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)


; code -> data
; indirect data load target
; indirect data load target
.byte $82
; indirect data load target
.byte $23

.byte $47
.byte $80
; data -> code
    jsr $CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)


; code -> data
; indirect data load target
; indirect data load target
.byte $81
; indirect data load target
.byte $21

.byte $44
.byte $80
; data -> code
    bcc B0F_CA43
; control flow target (from $CA4F)
B0F_CA6F:
    cmp #$03
    bne B0F_CA94
    jsr $CD26 ; set Z if your current map position is the (X, Y) co-ordinates given by the next 2 bytes


; code -> data
; indirect data load target
; indirect data load target
.byte $03

.byte $06
; data -> code
    beq B0F_CA88
    jsr $CD26 ; set Z if your current map position is the (X, Y) co-ordinates given by the next 2 bytes


; code -> data
; indirect data load target
; indirect data load target
.byte $03

.byte $08
; data -> code
    beq B0F_CA88
    jsr $CD26 ; set Z if your current map position is the (X, Y) co-ordinates given by the next 2 bytes


; code -> data
; indirect data load target
; indirect data load target
.byte $02

.byte $07
; data -> code
    bne B0F_CA91
; control flow target (from $CA78, $CA7F)
B0F_CA88:
    lda #$FF
    sta $0561 ; NPC #$04 sprite ID

    lda #$04
    sta $44 ; non-saved event status (#$00 = event start, #$01 = Lianport Gremlins defeated, #$02 = met with Lianport grandfather/have no friends at Shrine SW of Cannock, #$03 = King Midenhall moved to stairs, #$04 = King Midenhall moved down stairs, #$05 = King Midenhall spoke on Midenhall 1F, #$0B = Lighthouse Wizard 7F, #$1B Lighthouse Wizard 2F spoke, #$64 = Hargon dead, #$FF = event end)

; control flow target (from $CA86, $CA9C, $CAA3)
B0F_CA91:
    jmp $C700

; control flow target (from $CA71)
B0F_CA94:
    cmp #$04
    bne B0F_CAB3
    lda $31 ; current map ID

    cmp #$03 ; Map ID #$03: Midenhall 1F

    bne B0F_CA91
    jsr $CD26 ; set Z if your current map position is the (X, Y) co-ordinates given by the next 2 bytes


; code -> data
; indirect data load target
; indirect data load target
.byte $0F

.byte $02
; data -> code
    bne B0F_CA91
    jsr $F6EA ; open main dialogue window and display string ID specified by byte following JSR


; code -> data
; indirect data load target

.byte $75
; data -> code
    jsr $D0F5 ; wait for a while and then wipe menu regions #$03, #$00, and #$01

    lda #$05
    sta $44 ; non-saved event status (#$00 = event start, #$01 = Lianport Gremlins defeated, #$02 = met with Lianport grandfather/have no friends at Shrine SW of Cannock, #$03 = King Midenhall moved to stairs, #$04 = King Midenhall moved down stairs, #$05 = King Midenhall spoke on Midenhall 1F, #$0B = Lighthouse Wizard 7F, #$1B Lighthouse Wizard 2F spoke, #$64 = Hargon dead, #$FF = event end)

    jmp $C700

; control flow target (from $CA96)
B0F_CAB3:
    cmp #$05
    bne B0F_CB02
    jmp $C700

; external control flow target (from $06:$91C0)
    jsr $E6B4
    jsr $E6B4
    jsr $E6B4
    jsr $D058
    lda #$0A
    sta $052A,Y
    lda #$09
    sta $052B,Y
    lda #$87 ; Music ID #$87: hit 2 SFX

    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    lda #$F8
    sta $18
    lda #$00
    sta $19
    sta $1E
    sta $1C
    jsr $DEC5
    ldx #$0A
    jsr $C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

    jsr $CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)


; code -> data
; indirect data load target
; indirect data load target
.byte $85
; indirect data load target
.byte $21

.byte $4F
.byte $80
; data -> code
    jsr $CCD2 ; execute scripted motion

    lda #$FF
    sta $0581 ; NPC #$08 sprite ID

    sta $44 ; non-saved event status (#$00 = event start, #$01 = Lianport Gremlins defeated, #$02 = met with Lianport grandfather/have no friends at Shrine SW of Cannock, #$03 = King Midenhall moved to stairs, #$04 = King Midenhall moved down stairs, #$05 = King Midenhall spoke on Midenhall 1F, #$0B = Lighthouse Wizard 7F, #$1B Lighthouse Wizard 2F spoke, #$64 = Hargon dead, #$FF = event end)

    lda #$02 ; Fixed Battle #$02: 1 Saber Lion (Map ID #$0F: Osterfair)

    jsr $D25C ; trigger fixed battle A

    jmp $D2FB ; load ROM bank 6


; control flow target (from $CAB5)
B0F_CB02:
    cmp #$09
    bne B0F_CB3C
    jsr $CD26 ; set Z if your current map position is the (X, Y) co-ordinates given by the next 2 bytes


; code -> data
; indirect data load target
; indirect data load target
.byte $13

.byte $08
; data -> code
    bne B0F_CB16
    jsr $CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)


; code -> data
; indirect data load target
; indirect data load target
.byte $85
; indirect data load target
.byte $20

.byte $55
.byte $80
; data -> code
    bcc B0F_CB2B
; control flow target (from $CB0B)
B0F_CB16:
    jsr $CD26 ; set Z if your current map position is the (X, Y) co-ordinates given by the next 2 bytes


; code -> data
; indirect data load target
; indirect data load target
.byte $12

.byte $07
; data -> code
    beq B0F_CB24
    jsr $CD26 ; set Z if your current map position is the (X, Y) co-ordinates given by the next 2 bytes


; code -> data
; indirect data load target
; indirect data load target
.byte $11

.byte $08
; data -> code
    bne B0F_CB39
; control flow target (from $CB1B)
B0F_CB24:
    jsr $CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)


; code -> data
; indirect data load target
; indirect data load target
.byte $85
; indirect data load target
.byte $21

.byte $51
.byte $80
; data -> code
; control flow target (from $CB14)
B0F_CB2B:
    jsr $CCD2 ; execute scripted motion

    jsr $F6F6 ; open main dialogue window and display string ID specified by byte following JSR + #$0200


; code -> data
; indirect data load target

.byte $D0
; data -> code
    lda #$FF
    sta $44 ; non-saved event status (#$00 = event start, #$01 = Lianport Gremlins defeated, #$02 = met with Lianport grandfather/have no friends at Shrine SW of Cannock, #$03 = King Midenhall moved to stairs, #$04 = King Midenhall moved down stairs, #$05 = King Midenhall spoke on Midenhall 1F, #$0B = Lighthouse Wizard 7F, #$1B Lighthouse Wizard 2F spoke, #$64 = Hargon dead, #$FF = event end)

    jsr $D0F5 ; wait for a while and then wipe menu regions #$03, #$00, and #$01

; control flow target (from $CB22, $CB52)
B0F_CB39:
    jmp $C700

; control flow target (from $CB04)
B0F_CB3C:
    cmp #$0A
    bne B0F_CB62
    lda $31 ; current map ID

    cmp #$56 ; Map ID #$56: Lighthouse 7F

    bne B0F_CB5F
    jsr $CD26 ; set Z if your current map position is the (X, Y) co-ordinates given by the next 2 bytes


; code -> data
; indirect data load target
; indirect data load target
.byte $0A

.byte $04
; data -> code
    beq B0F_CB54
    jsr $CD26 ; set Z if your current map position is the (X, Y) co-ordinates given by the next 2 bytes


; code -> data
; indirect data load target
; indirect data load target
.byte $0B

.byte $04
; data -> code
    bne B0F_CB39
; control flow target (from $CB4B)
B0F_CB54:
    jsr $CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)


; code -> data
; indirect data load target
; indirect data load target
.byte $81
; indirect data load target
.byte $22

.byte $4A
.byte $80
; data -> code
    lda #$0B
    sta $44 ; non-saved event status (#$00 = event start, #$01 = Lianport Gremlins defeated, #$02 = met with Lianport grandfather/have no friends at Shrine SW of Cannock, #$03 = King Midenhall moved to stairs, #$04 = King Midenhall moved down stairs, #$05 = King Midenhall spoke on Midenhall 1F, #$0B = Lighthouse Wizard 7F, #$1B Lighthouse Wizard 2F spoke, #$64 = Hargon dead, #$FF = event end)

; control flow target (from $CB44, $CB6B, $CB76, $CB80, $CB8E)
B0F_CB5F:
    jmp $C700

; control flow target (from $CB3E)
B0F_CB62:
    cmp #$0B
    bne B0F_CB78
    lda $0560 ; NPC #$04 motion nybble + direction nybble

    and #$F0
    bne B0F_CB5F
    lda #$FF
    sta $0561 ; NPC #$04 sprite ID

    lda #$0C
    sta $44 ; non-saved event status (#$00 = event start, #$01 = Lianport Gremlins defeated, #$02 = met with Lianport grandfather/have no friends at Shrine SW of Cannock, #$03 = King Midenhall moved to stairs, #$04 = King Midenhall moved down stairs, #$05 = King Midenhall spoke on Midenhall 1F, #$0B = Lighthouse Wizard 7F, #$1B Lighthouse Wizard 2F spoke, #$64 = Hargon dead, #$FF = event end)

    bne B0F_CB5F
; control flow target (from $CB64)
B0F_CB78:
    cmp #$0C
    bne B0F_CBA5
    lda $31 ; current map ID

    cmp #$56 ; Map ID #$56: Lighthouse 7F

    bne B0F_CB5F
    jsr $CD26 ; set Z if your current map position is the (X, Y) co-ordinates given by the next 2 bytes


; code -> data
; indirect data load target
; indirect data load target
.byte $0E

.byte $09
; data -> code
    beq B0F_CB90
    jsr $CD26 ; set Z if your current map position is the (X, Y) co-ordinates given by the next 2 bytes


; code -> data
; indirect data load target
; indirect data load target
.byte $0F

.byte $09
; data -> code
    bne B0F_CB5F
; control flow target (from $CB87)
B0F_CB90:
    jsr $F6EA ; open main dialogue window and display string ID specified by byte following JSR


; code -> data
; indirect data load target

.byte $66
; data -> code
    jsr $D0F5 ; wait for a while and then wipe menu regions #$03, #$00, and #$01

    jsr $CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)


; code -> data
; indirect data load target
; indirect data load target
.byte $80
; indirect data load target
.byte $22

.byte $59
.byte $80
; data -> code
    lda #$0D
    sta $44 ; non-saved event status (#$00 = event start, #$01 = Lianport Gremlins defeated, #$02 = met with Lianport grandfather/have no friends at Shrine SW of Cannock, #$03 = King Midenhall moved to stairs, #$04 = King Midenhall moved down stairs, #$05 = King Midenhall spoke on Midenhall 1F, #$0B = Lighthouse Wizard 7F, #$1B Lighthouse Wizard 2F spoke, #$64 = Hargon dead, #$FF = event end)

    jmp $C700

; control flow target (from $CB7A)
B0F_CBA5:
    ldy #$00
; control flow target (from $CBE2)
B0F_CBA7:
    cmp $CCAF,Y
    bne B0F_CBDF
    lda $31 ; current map ID

    cmp $CCB4,Y
    bne B0F_CBDC
    lda $16 ; current map X-pos (1)

    cmp $CCB9,Y
    bcc B0F_CBDC
    cmp $CCBE,Y
    bcs B0F_CBDC
    lda $17 ; current map Y-pos (1)

    cmp $CCC3,Y
    bcc B0F_CBDC
    cmp $CCC8,Y
    bcs B0F_CBDC
    lda $0558 ; NPC #$03 motion nybble + direction nybble

    and #$F0
    bne B0F_CBDC
    lda #$FF
    sta $0559 ; NPC #$03 sprite ID

    lda $CCCD,Y
    sta $44 ; non-saved event status (#$00 = event start, #$01 = Lianport Gremlins defeated, #$02 = met with Lianport grandfather/have no friends at Shrine SW of Cannock, #$03 = King Midenhall moved to stairs, #$04 = King Midenhall moved down stairs, #$05 = King Midenhall spoke on Midenhall 1F, #$0B = Lighthouse Wizard 7F, #$1B Lighthouse Wizard 2F spoke, #$64 = Hargon dead, #$FF = event end)

; control flow target (from $CBB1, $CBB8, $CBBD, $CBC4, $CBC9, $CBD0, $CBEC, $CBFA)
B0F_CBDC:
    jmp $C700

; control flow target (from $CBAA)
B0F_CBDF:
    iny
    cpy #$05
    bne B0F_CBA7
    cmp #$17
    bne B0F_CC60
    lda $31 ; current map ID

    cmp #$51 ; Map ID #$51: Lighthouse 2F

    bne B0F_CBDC
    jsr $CD26 ; set Z if your current map position is the (X, Y) co-ordinates given by the next 2 bytes


; code -> data
; indirect data load target
; indirect data load target
.byte $1C

.byte $1F
; data -> code
    beq B0F_CBFC
    jsr $CD26 ; set Z if your current map position is the (X, Y) co-ordinates given by the next 2 bytes


; code -> data
; indirect data load target
; indirect data load target
.byte $1D

.byte $1F
; data -> code
    bne B0F_CBDC
; control flow target (from $CBF3)
B0F_CBFC:
    jsr $F6EA ; open main dialogue window and display string ID specified by byte following JSR


; code -> data
; indirect data load target

.byte $67
; data -> code
    jsr $D0F5 ; wait for a while and then wipe menu regions #$03, #$00, and #$01

    lda #$1B
    sta $44 ; non-saved event status (#$00 = event start, #$01 = Lianport Gremlins defeated, #$02 = met with Lianport grandfather/have no friends at Shrine SW of Cannock, #$03 = King Midenhall moved to stairs, #$04 = King Midenhall moved down stairs, #$05 = King Midenhall spoke on Midenhall 1F, #$0B = Lighthouse Wizard 7F, #$1B Lighthouse Wizard 2F spoke, #$64 = Hargon dead, #$FF = event end)

    jmp $C700

; trigger Stars Crest battle
; external control flow target (from $06:$9BA0)
    jsr $FA2A ; display string ID specified by next byte


; code -> data
; indirect data load target

.byte $69
; data -> code
    jsr $D0F5 ; wait for a while and then wipe menu regions #$03, #$00, and #$01

    lda #$05
    ldy #$2F
    jsr $CD5C
    lda #$05
    ldy #$27
    jsr $CD5C
    lda #$05
    ldy #$37
    jsr $CD5C
    lda #$FF
    sta $0559 ; NPC #$03 sprite ID

    sta $0561 ; NPC #$04 sprite ID

    sta $0569 ; NPC #$05 sprite ID

    sta $0571 ; NPC #$06 sprite ID

    sta $44 ; non-saved event status (#$00 = event start, #$01 = Lianport Gremlins defeated, #$02 = met with Lianport grandfather/have no friends at Shrine SW of Cannock, #$03 = King Midenhall moved to stairs, #$04 = King Midenhall moved down stairs, #$05 = King Midenhall spoke on Midenhall 1F, #$0B = Lighthouse Wizard 7F, #$1B Lighthouse Wizard 2F spoke, #$64 = Hargon dead, #$FF = event end)

    lda #$05 ; Fixed Battle #$05: 4 Gremlins (Map ID #$51: Lighthouse 2F)

    jsr $D25C ; trigger fixed battle A

    lda $98 ; outcome of last fight?

    cmp #$FC
    beq B0F_CC5C
    lda $0112 ; Crests found bit field (#$10 = Life, #$80 = Water, #$04 = Moon, #$02 = Stars, #$01 = Sun)

    and #$02
    bne B0F_CC5C
    ldx #$46
    jsr $C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

    jsr $F6F6 ; open main dialogue window and display string ID specified by byte following JSR + #$0200


; code -> data
; indirect data load target

.byte $32
; data -> code
    lda $0112 ; Crests found bit field (#$10 = Life, #$80 = Water, #$04 = Moon, #$02 = Stars, #$01 = Sun)

    ora #$02
    sta $0112 ; Crests found bit field (#$10 = Life, #$80 = Water, #$04 = Moon, #$02 = Stars, #$01 = Sun)

    jsr $D0F5 ; wait for a while and then wipe menu regions #$03, #$00, and #$01

; control flow target (from $CC3F, $CC46)
B0F_CC5C:
    rts

; control flow target (from $CC70, $CC99)
B0F_CC5D:
    jmp $C700

; control flow target (from $CBE6)
B0F_CC60:
    cmp #$18
    bne B0F_CC97
    jsr $CD26 ; set Z if your current map position is the (X, Y) co-ordinates given by the next 2 bytes


; code -> data
; indirect data load target
; indirect data load target
.byte $10

.byte $0C
; data -> code
    beq B0F_CC72
    jsr $CD26 ; set Z if your current map position is the (X, Y) co-ordinates given by the next 2 bytes


; code -> data
; indirect data load target
; indirect data load target
.byte $10

.byte $0D
; data -> code
    bne B0F_CC5D
; control flow target (from $CC69)
B0F_CC72:
    jsr $F6EA ; open main dialogue window and display string ID specified by byte following JSR


; code -> data
; indirect data load target

.byte $6C
; data -> code
    jsr $D0F5 ; wait for a while and then wipe menu regions #$03, #$00, and #$01

    jsr $CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)


; code -> data
; indirect data load target
; indirect data load target
.byte $81
; indirect data load target
.byte $23

.byte $CB
.byte $80
; data -> code
    lda #$05
    sta $0561 ; NPC #$04 sprite ID

    jsr $CCD2 ; execute scripted motion

    lda #$FF
    sta $0559 ; NPC #$03 sprite ID

    sta $0561 ; NPC #$04 sprite ID

    sta $44 ; non-saved event status (#$00 = event start, #$01 = Lianport Gremlins defeated, #$02 = met with Lianport grandfather/have no friends at Shrine SW of Cannock, #$03 = King Midenhall moved to stairs, #$04 = King Midenhall moved down stairs, #$05 = King Midenhall spoke on Midenhall 1F, #$0B = Lighthouse Wizard 7F, #$1B Lighthouse Wizard 2F spoke, #$64 = Hargon dead, #$FF = event end)

    lda #$06 ; Fixed Battle #$06: 2 Evil Clown (Map ID #$33: Sea Cave B5)

    jsr $D25C ; trigger fixed battle A

; control flow target (from $CC62)
B0F_CC97:
    cmp #$64
    bne B0F_CC5D
    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $A0
; data -> code
    jmp $C700

; external control flow target (from $06:$90C6)
    jsr $CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)


; code -> data
; indirect data load target
; indirect data load target
.byte $89
; indirect data load target
.byte $20

.byte $40
.byte $80
; data -> code
    jsr $CCD2 ; execute scripted motion

    jmp $F761 ; load ROM bank #$06



; code -> data
; indexed data load target (from $CBA7)
; indexed data load target (from $CBAE)
.byte $0D,$0F,$11
.byte $13
.byte $15
; indirect data load target
; indirect data load target
.byte $56
; indirect data load target
.byte $55
; indirect data load target
.byte $54
; indirect data load target
.byte $53
; indexed data load target (from $CBB5)
.byte $52
; indirect data load target
; indirect data load target
.byte $00
; indirect data load target
.byte $10
; indirect data load target
.byte $1A
; indirect data load target
.byte $16
; indexed data load target (from $CBBA)
.byte $1E
; indirect data load target
; indirect data load target
.byte $03
; indirect data load target
.byte $14
; indirect data load target
.byte $1C
; indirect data load target
.byte $19
; indexed data load target (from $CBC1)
.byte $20
; indirect data load target
; indirect data load target
.byte $11
; indirect data load target
.byte $1A
; indirect data load target
.byte $0E
; indirect data load target
.byte $19
; indexed data load target (from $CBC6)
.byte $16
; indirect data load target
; indirect data load target
.byte $14
; indirect data load target
.byte $1C
; indirect data load target
.byte $12
; indirect data load target
.byte $1C
; indexed data load target (from $CBD7)
.byte $1A
; indirect data load target
; indirect data load target
.byte $0E
; indirect data load target
.byte $10
; indirect data load target
.byte $12
; indirect data load target
.byte $14

.byte $16
; data -> code
; execute scripted motion
; control flow target (from $C836, $C864, $C93D, $C959, $CA0C, $CA32, $CA43, $CAF0, $CB2B, $CC85, $CCA9, $CCE7, $FF84)
; external control flow target (from $06:$BB3A)
    lda $35 ; flag indicating whether any menu is currently open

    pha
    lda #$00
    sta $35 ; flag indicating whether any menu is currently open

; control flow target (from $CCE1)
B0F_CCD9:
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    jsr $D8CB
    lda $38
    bmi B0F_CCD9
    pla
    sta $35 ; flag indicating whether any menu is currently open

    rts

; external control flow target (from $06:$BB91, $06:$BBA5)
    jsr $CCD2 ; execute scripted motion

    lda #$06
    sta $94 ; return bank for various function calls, doubles as index of selected option for multiple-choice menus

    jmp $C3D5 ; save A to $05F6, X to $43, and load bank specified by A


; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)
; control flow target (from $C82F, $C85D, $C932, $C94B, $C952, $C9B2, $C9FC, $CA05, $CA15, $CA22, $CA2B, $CA3C, $CA5F, $CA66, $CAE9, $CB0D, $CB24, $CB54, $CB97, $CC79, $CCA2, $CEC2)
; external control flow target (from $06:$BACC, $06:$BAD5, $06:$BADF, $06:$BB83, $06:$BB8A, $06:$BB97, $06:$BB9E, $07:$822A, $07:$823B, $07:$8271, $07:$82CB, $07:$82EE, $07:$8329, $07:$8358, $07:$836D, $07:$837E, $07:$83F4, $07:$845C, $07:$8495, $07:$84CE, $07:$84EF, $07:$84FC, $07:$8515, $07:$852C, $07:$8559, $07:$8571, $07:$8578, $07:$85B3, $07:$85BA, $07:$85E7)
    pla ; return address low byte

    sta $0C ; return address low byte

    pla ; return address high byte

    sta $0D ; return address high byte

    ldy #$01
    lda ($0C),Y ; data byte 0

    sta $38
    and #$7F ; useless op

    asl
    asl
    asl
    tax
    iny
    lda ($0C),Y ; data byte 1

    sta $0558,X ; NPC #$03 motion nybble + direction nybble

    iny
    lda ($0C),Y ; data byte 2

    sta $0552,X ; NPC #$02 scripted motion low byte

    iny
    lda ($0C),Y ; data byte 3

    sta $0553,X ; NPC #$02 scripted motion high byte

    lda $0C ; return address low byte

    clc
    adc #$04 ; 4 data bytes

    sta $0C ; return address low byte

    lda $0D ; return address high byte

    adc #$00 ; add carry from low byte

    pha ; return address high byte

    lda $0C ; return address low byte

    pha ; return address low byte

    clc
    rts

; set Z if your current map position is the (X, Y) co-ordinates given by the next 2 bytes
; control flow target (from $C911, $C92B, $C9C7, $C9D2, $C9DD, $CA51, $CA58, $CA73, $CA7A, $CA81, $CA9E, $CB06, $CB16, $CB1D, $CB46, $CB4D, $CB82, $CB89, $CBEE, $CBF5, $CC64, $CC6B)
; external control flow target (from $06:$96B7, $06:$9793, $06:$BB3D)
    pla ; original return address, low byte

    sta $0C ; original return address, low byte

    clc
    adc #$02 ; calls to this routine are followed by 2 bytes of data

    sta $0E ; new return address, low byte

    pla ; original return address, high byte

    sta $0D ; original return address, high byte

    adc #$00 ; add carry from low address

    pha ; new return address, high byte

    lda $0E ; new return address, low byte

    pha ; new return address, low byte

    ldy #$01 ; 1 byte after the original return address

    lda $16 ; current map X-pos (1)

    cmp ($0C),Y
    bne B0F_CD44 ; not the same X-pos => Z not set

    lda $17 ; current map Y-pos (1)

    iny ; 2 bytes after the original return address

    cmp ($0C),Y ; set or clear Z based on whether your Y-pos matches

; control flow target (from $CD3D)
B0F_CD44:
    rts

; external control flow target (from $06:$971D)
    jsr $CD51
; control flow target (from $CD4E)
    jmp $F761 ; load ROM bank #$06


; external control flow target (from $06:$9724)
    jsr $CD5C
    jmp $CD48

; control flow target (from $CD45)
    sta $C9
    sty $97 ; subject hero ID $97

    lda #$FF
    sta $96 ; temp storage for item/spell/type/etc. IDs

    jmp $CD64

; control flow target (from $CC15, $CC1C, $CC23, $CD4B)
    sta $96 ; temp storage for item/spell/type/etc. IDs

    sty $97 ; subject hero ID $97

    lda #$FF
    sta $C9
; control flow target (from $CD59)
    lda #$01
    sta $49 ; object hero/target/item/string ID $49

; control flow target (from $CD8C)
B0F_CD68:
    lda $C9
    ldy $97 ; subject hero ID $97

    sta $053A,Y
    jsr $D8CB
    ldx #$04
    jsr $C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

    lda $96 ; temp storage for item/spell/type/etc. IDs

    ldy $97 ; subject hero ID $97

    sta $053A,Y
    jsr $D8CB
    ldx $49 ; object hero/target/item/string ID $49

    jsr $C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

    inc $49 ; object hero/target/item/string ID $49

    lda $49 ; object hero/target/item/string ID $49

    cmp #$08
    bcc B0F_CD68
    rts

; control flow target (from $E56C)
    lda $31 ; current map ID

    cmp #$01 ; Map ID #$01: World Map

    bne B0F_CD9A
; control flow target (from $CDAA, $CDB8)
B0F_CD95:
    lda #$FF
    sta $44 ; non-saved event status (#$00 = event start, #$01 = Lianport Gremlins defeated, #$02 = met with Lianport grandfather/have no friends at Shrine SW of Cannock, #$03 = King Midenhall moved to stairs, #$04 = King Midenhall moved down stairs, #$05 = King Midenhall spoke on Midenhall 1F, #$0B = Lighthouse Wizard 7F, #$1B Lighthouse Wizard 2F spoke, #$64 = Hargon dead, #$FF = event end)

    rts

; control flow target (from $CD93)
B0F_CD9A:
    cmp #$0B ; Map ID #$0B: Lianport

    bne B0F_CDB1
    lda $CF ; ship status (#$04 = on ship, #$02 = own ship, #$01 = beat Lianport Gremlins)

    beq B0F_CDAC
    lda #$FF
    sta $0589 ; NPC #$09 sprite ID

    sta $0591 ; NPC #$0A sprite ID

    bne B0F_CD95
; control flow target (from $CDA0)
B0F_CDAC:
    lda #$00
    sta $44 ; non-saved event status (#$00 = event start, #$01 = Lianport Gremlins defeated, #$02 = met with Lianport grandfather/have no friends at Shrine SW of Cannock, #$03 = King Midenhall moved to stairs, #$04 = King Midenhall moved down stairs, #$05 = King Midenhall spoke on Midenhall 1F, #$0B = Lighthouse Wizard 7F, #$1B Lighthouse Wizard 2F spoke, #$64 = Hargon dead, #$FF = event end)

    rts

; control flow target (from $CD9C)
B0F_CDB1:
    cmp #$1A ; Map ID #$1A: Shrine SW of Cannock

    bne B0F_CDBF
    jsr $F6CE ; return number of party members - 1 in A/X

    bne B0F_CD95
    lda #$02
    sta $44 ; non-saved event status (#$00 = event start, #$01 = Lianport Gremlins defeated, #$02 = met with Lianport grandfather/have no friends at Shrine SW of Cannock, #$03 = King Midenhall moved to stairs, #$04 = King Midenhall moved down stairs, #$05 = King Midenhall spoke on Midenhall 1F, #$0B = Lighthouse Wizard 7F, #$1B Lighthouse Wizard 2F spoke, #$64 = Hargon dead, #$FF = event end)

    rts

; control flow target (from $CDB3)
B0F_CDBF:
    cmp #$02 ; Map ID #$02: Midenhall 2F

    bne B0F_CDD3
    lda $44 ; non-saved event status (#$00 = event start, #$01 = Lianport Gremlins defeated, #$02 = met with Lianport grandfather/have no friends at Shrine SW of Cannock, #$03 = King Midenhall moved to stairs, #$04 = King Midenhall moved down stairs, #$05 = King Midenhall spoke on Midenhall 1F, #$0B = Lighthouse Wizard 7F, #$1B Lighthouse Wizard 2F spoke, #$64 = Hargon dead, #$FF = event end)

    cmp #$04
    beq B0F_CDCD
    cmp #$05
    bne B0F_CDF6
; control flow target (from $CDC7)
B0F_CDCD:
    lda #$FF
    sta $0561 ; NPC #$04 sprite ID

    rts

; control flow target (from $CDC1)
B0F_CDD3:
    cmp #$03 ; Map ID #$03: Midenhall 1F

    bne B0F_CDFB
    lda $44 ; non-saved event status (#$00 = event start, #$01 = Lianport Gremlins defeated, #$02 = met with Lianport grandfather/have no friends at Shrine SW of Cannock, #$03 = King Midenhall moved to stairs, #$04 = King Midenhall moved down stairs, #$05 = King Midenhall spoke on Midenhall 1F, #$0B = Lighthouse Wizard 7F, #$1B Lighthouse Wizard 2F spoke, #$64 = Hargon dead, #$FF = event end)

    cmp #$04
    beq B0F_CDF5
    cmp #$05
    beq B0F_CDF5
    lda #$FF
    sta $05C1 ; NPC #$10 sprite ID

    lda $61AD
    bne B0F_CDF5
    lda #$0E
    sta $051A ; something to do with whether you've opened the chest containing the Shield of Erdrick

    lda #$02
    sta $051B
; control flow target (from $CDDB, $CDDF, $CDE9)
B0F_CDF5:
    rts

; control flow target (from $CDCB, $CE0A)
B0F_CDF6:
    lda #$FF
    sta $44 ; non-saved event status (#$00 = event start, #$01 = Lianport Gremlins defeated, #$02 = met with Lianport grandfather/have no friends at Shrine SW of Cannock, #$03 = King Midenhall moved to stairs, #$04 = King Midenhall moved down stairs, #$05 = King Midenhall spoke on Midenhall 1F, #$0B = Lighthouse Wizard 7F, #$1B Lighthouse Wizard 2F spoke, #$64 = Hargon dead, #$FF = event end)

    rts

; control flow target (from $CDD5)
B0F_CDFB:
    cmp #$05 ; Map ID #$05: Leftwyne

    bne B0F_CE12
    lda $063F ; Cannock status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    and #$04
    bne B0F_CE0C
    lda $CA ; Cannock runaround quest status (0 = start of game, 0 -> 1 = talked to King Cannock, 1 -> 2 = said YES to seeking Cannock in Spring of Bravery, 2 -> 3 = talked to King Midenhall; adding Cannock sets this to 3; some code checks for 4)

    cmp #$02
    bcs B0F_CDF6
; control flow target (from $CE04)
B0F_CE0C:
    lda #$FF
    sta $05C1 ; NPC #$10 sprite ID

    rts

; control flow target (from $CDFD)
B0F_CE12:
    cmp #$0F ; Map ID #$0F: Osterfair

    bne B0F_CE1B
    lda #$00
    sta $98 ; outcome of last fight?

    rts

; control flow target (from $CE14)
B0F_CE1B:
    cmp #$10 ; Map ID #$10: Zahan

    bne B0F_CE24
    lda #$09
    sta $44 ; non-saved event status (#$00 = event start, #$01 = Lianport Gremlins defeated, #$02 = met with Lianport grandfather/have no friends at Shrine SW of Cannock, #$03 = King Midenhall moved to stairs, #$04 = King Midenhall moved down stairs, #$05 = King Midenhall spoke on Midenhall 1F, #$0B = Lighthouse Wizard 7F, #$1B Lighthouse Wizard 2F spoke, #$64 = Hargon dead, #$FF = event end)

    rts

; control flow target (from $CE1D)
B0F_CE24:
    cmp #$20 ; Map ID #$20: Shrine SW of Moonbrooke

    bne B0F_CE40
    ldy #$00
; control flow target (from $CE38)
B0F_CE2A:
    lda $062D,Y ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    and #$04
    beq B0F_CE3F
    tya
    clc
    adc #$12
    tay
    cmp #$36
    bne B0F_CE2A
    lda #$06
    sta $0554 ; NPC #$03 X-pos

; control flow target (from $CE2F)
B0F_CE3F:
    rts

; control flow target (from $CE26)
B0F_CE40:
    cmp #$57 ; Map ID #$57: Lighthouse 8F

    bne B0F_CE45
    rts

; control flow target (from $CE42)
B0F_CE45:
    cmp #$56 ; Map ID #$56: Lighthouse 7F

    bne B0F_CE87
    lda $0112 ; Crests found bit field (#$10 = Life, #$80 = Water, #$04 = Moon, #$02 = Stars, #$01 = Sun)

    and #$02
    bne B0F_CE7C
    lda $44 ; non-saved event status (#$00 = event start, #$01 = Lianport Gremlins defeated, #$02 = met with Lianport grandfather/have no friends at Shrine SW of Cannock, #$03 = King Midenhall moved to stairs, #$04 = King Midenhall moved down stairs, #$05 = King Midenhall spoke on Midenhall 1F, #$0B = Lighthouse Wizard 7F, #$1B Lighthouse Wizard 2F spoke, #$64 = Hargon dead, #$FF = event end)

    cmp #$FF
    beq B0F_CE5A
    cmp #$0A
    bne B0F_CE5F
; control flow target (from $CE54)
B0F_CE5A:
    lda #$0A
    sta $44 ; non-saved event status (#$00 = event start, #$01 = Lianport Gremlins defeated, #$02 = met with Lianport grandfather/have no friends at Shrine SW of Cannock, #$03 = King Midenhall moved to stairs, #$04 = King Midenhall moved down stairs, #$05 = King Midenhall spoke on Midenhall 1F, #$0B = Lighthouse Wizard 7F, #$1B Lighthouse Wizard 2F spoke, #$64 = Hargon dead, #$FF = event end)

    rts

; control flow target (from $CE58)
B0F_CE5F:
    cmp #$0B
    beq B0F_CE81
    cmp #$0C
    beq B0F_CE81
    cmp #$0D
    bne B0F_CE7C
    lda #$00
    sta $0554 ; NPC #$03 X-pos

    lda #$13
    sta $0555 ; NPC #$03 Y-pos

    lda #$01
    sta $0558 ; NPC #$03 motion nybble + direction nybble

    bne B0F_CE81
; control flow target (from $CE4E, $CE69)
B0F_CE7C:
    lda #$FF
    sta $0559 ; NPC #$03 sprite ID

; control flow target (from $CE61, $CE65, $CE7A)
B0F_CE81:
    lda #$FF
    sta $0561 ; NPC #$04 sprite ID

    rts

; control flow target (from $CE47)
B0F_CE87:
    ldy #$00
; control flow target (from $CEE2)
B0F_CE89:
    cmp $CF2C,Y
    bne B0F_CEDF
    lda $44 ; non-saved event status (#$00 = event start, #$01 = Lianport Gremlins defeated, #$02 = met with Lianport grandfather/have no friends at Shrine SW of Cannock, #$03 = King Midenhall moved to stairs, #$04 = King Midenhall moved down stairs, #$05 = King Midenhall spoke on Midenhall 1F, #$0B = Lighthouse Wizard 7F, #$1B Lighthouse Wizard 2F spoke, #$64 = Hargon dead, #$FF = event end)

    cmp $CF31,Y
    bne B0F_CEA8
    lda $CF36,Y
    sta $0554 ; NPC #$03 X-pos

    lda $CF3B,Y
    sta $0555 ; NPC #$03 Y-pos

    lda $CF40,Y
    sta $0558 ; NPC #$03 motion nybble + direction nybble

    rts

; control flow target (from $CE93)
B0F_CEA8:
    cmp $CF45,Y
    bne B0F_CED9
    lda $16 ; current map X-pos (1)

    cmp $CF4A,Y
    bne B0F_CED9
    lda $17 ; current map Y-pos (1)

    cmp $CF4F,Y
    bne B0F_CED9
    lda $CF31,Y
    sta $44 ; non-saved event status (#$00 = event start, #$01 = Lianport Gremlins defeated, #$02 = met with Lianport grandfather/have no friends at Shrine SW of Cannock, #$03 = King Midenhall moved to stairs, #$04 = King Midenhall moved down stairs, #$05 = King Midenhall spoke on Midenhall 1F, #$0B = Lighthouse Wizard 7F, #$1B Lighthouse Wizard 2F spoke, #$64 = Hargon dead, #$FF = event end)

    tya
    pha
    jsr $CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)


; code -> data
; indirect data load target
; indirect data load target
.byte $80
; indirect data load target
.byte $22

.byte $72
.byte $80
; data -> code
    pla
    asl
    tay
    lda $CF54,Y ; motion script pointers for Lighthouse Wizard

    sta $0552 ; NPC #$02 scripted motion low byte

    lda $CF55,Y
    sta $0553 ; NPC #$02 scripted motion high byte

    rts

; control flow target (from $CEAB, $CEB2, $CEB9)
B0F_CED9:
    lda #$FF
    sta $0559 ; NPC #$03 sprite ID

; control flow target (from $CEE6)
B0F_CEDE:
    rts

; control flow target (from $CE8C)
B0F_CEDF:
    iny
    cpy #$05
    bne B0F_CE89
    cmp #$50 ; Map ID #$50: Lighthouse 1F

    beq B0F_CEDE
    cmp #$33 ; Map ID #$33: Sea Cave B5

    bne B0F_CEF1
    lda #$18
    sta $44 ; non-saved event status (#$00 = event start, #$01 = Lianport Gremlins defeated, #$02 = met with Lianport grandfather/have no friends at Shrine SW of Cannock, #$03 = King Midenhall moved to stairs, #$04 = King Midenhall moved down stairs, #$05 = King Midenhall spoke on Midenhall 1F, #$0B = Lighthouse Wizard 7F, #$1B Lighthouse Wizard 2F spoke, #$64 = Hargon dead, #$FF = event end)

    rts

; control flow target (from $CEEA)
B0F_CEF1:
    cmp #$04 ; Map ID #$04: Midenhall B1

    bne B0F_CF01
    lda $D1 ; fixed battle status bits (#$10 = Zarlox, #$08 = Bazuzu, #$04 = Atlas, #$02 = Hamlin Waterway Gremlins, #$01 = Evil Clown)

    lsr
    bcc B0F_CF27
    lda #$FF
    sta $0569 ; NPC #$05 sprite ID

    bne B0F_CF27
; control flow target (from $CEF3)
B0F_CF01:
    cmp #$07 ; Map ID #$07: Hamlin

    bne B0F_CF13
    lda $0651 ; Moonbrooke status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    and #$04 ; In Party

    beq B0F_CF13
    lda #$FF
    sta $0559 ; NPC #$03 sprite ID

    bne B0F_CF27
; control flow target (from $CF03, $CF0A)
B0F_CF13:
    cmp #$08 ; Map ID #$08: Hamlin Waterway

    bne B0F_CF27
    lda $D1 ; fixed battle status bits (#$10 = Zarlox, #$08 = Bazuzu, #$04 = Atlas, #$02 = Hamlin Waterway Gremlins, #$01 = Evil Clown)

    and #$02
    beq B0F_CF27
    lda #$FF
    sta $0559 ; NPC #$03 sprite ID

    sta $0561 ; NPC #$04 sprite ID

    bne B0F_CF27
; control flow target (from $CEF8, $CEFF, $CF11, $CF15, $CF1B, $CF25)
B0F_CF27:
    lda #$FF
    sta $44 ; non-saved event status (#$00 = event start, #$01 = Lianport Gremlins defeated, #$02 = met with Lianport grandfather/have no friends at Shrine SW of Cannock, #$03 = King Midenhall moved to stairs, #$04 = King Midenhall moved down stairs, #$05 = King Midenhall spoke on Midenhall 1F, #$0B = Lighthouse Wizard 7F, #$1B Lighthouse Wizard 2F spoke, #$64 = Hargon dead, #$FF = event end)

    rts


; code -> data
; indexed data load target (from $CE89)
; indexed data load target (from $CE90, $CEBB)
.byte $55,$54,$53
.byte $52
.byte $51
; indirect data load target
; indirect data load target
.byte $0F
; indirect data load target
.byte $11
; indirect data load target
.byte $13
; indirect data load target
.byte $15
; indexed data load target (from $CE95)
.byte $17
; indirect data load target
; indirect data load target
.byte $12
; indirect data load target
.byte $1A
; indirect data load target
.byte $16
; indirect data load target
.byte $1E
; indexed data load target (from $CE9B)
.byte $1D
; indirect data load target
; indirect data load target
.byte $1B
; indirect data load target
.byte $0F
; indirect data load target
.byte $1B
; indirect data load target
.byte $17
; indexed data load target (from $CEA1)
.byte $1E
; indirect data load target
; indirect data load target
.byte $03
; indirect data load target
.byte $02
; indirect data load target
.byte $01
; indirect data load target
.byte $02
; indexed data load target (from $CEA8)
.byte $02
; indirect data load target
; indirect data load target
.byte $0E
; indirect data load target
.byte $10
; indirect data load target
.byte $12
; indirect data load target
.byte $14
; indexed data load target (from $CEAF)
.byte $16
; indirect data load target
; indirect data load target
.byte $01
; indirect data load target
.byte $19
; indirect data load target
.byte $1B
; indirect data load target
.byte $13
; indexed data load target (from $CEB6)
.byte $23
; indirect data load target
; indirect data load target
.byte $18
; indirect data load target
.byte $18
; indirect data load target
.byte $12
; indirect data load target
.byte $1E
; motion script pointers for Lighthouse Wizard
.byte $1E
; indexed data load target (from $CECC)
; indirect data load target
; indexed data load target (from $CED2)
.byte $72

.byte $80,$87,$80,$92,$80
.byte $A0,$80
.byte $B3
.byte $80
; data -> code
; external control flow target (from $02:$B1FD)
    jsr $D8CB
    jmp $F770 ; load ROM bank #$02


; external control flow target (from $06:$8053, $06:$827A, $06:$9371, $06:$A311, $06:$BBC4, $06:$BC2D)
    jsr $D8CB
; load ROM bank #$06
; control flow target (from $CF6D, $CF73, $CF79)
    jmp $F761 ; load ROM bank #$06


; wipe selected menu region
; external control flow target (from $06:$806F, $06:$8097, $06:$84C9, $06:$8A16, $06:$8A5C, $06:$8B09, $06:$9555, $06:$9CE0)
    jsr $F78C ; wipe selected menu region

    jmp $CF67 ; load ROM bank #$06


; external control flow target (from $06:$80AD, $06:$96E1)
    jsr $F787
    jmp $CF67 ; load ROM bank #$06


; external control flow target (from $06:$826D)
    jsr $D2F7
    jmp $CF67 ; load ROM bank #$06


; external control flow target (from $06:$8C6A, $06:$8C77, $06:$8C84, $06:$9775)
    lda #$00
    sta $49 ; object hero/target/item/string ID $49

    jsr $D06B ; copy $16 to $0C, $17 to $0E

    dec $0E ; check up

    jsr $CFA5
    jsr $D06B ; copy $16 to $0C, $17 to $0E

    inc $0C ; check right

    jsr $CFA5
    jsr $D06B ; copy $16 to $0C, $17 to $0E

    inc $0E ; check down

    jsr $CFA5
    jsr $D06B ; copy $16 to $0C, $17 to $0E

    dec $0C ; check left

    jsr $CFA5
    lda $94 ; return bank for various function calls, doubles as index of selected option for multiple-choice menus

    jmp $C3D5 ; save A to $05F6, X to $43, and load bank specified by A


; control flow target (from $CF85, $CF8D, $CF95, $CF9D)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    jsr $DF89
    lda $1F ; some kind of map type (#$00: World Map, #$01: other non-dungeon maps, #$02: maps #$2B - #$43 inclusive, #$03: maps >= #$44, #$FF => game menu)

    bne B0F_CFB0
; control flow target (from $CFB8, $CFBC, $CFCB, $D000, $D006, $D00A)
B0F_CFAF:
    rts

; control flow target (from $CFAD)
B0F_CFB0:
    cmp #$01
    bne B0F_CFFC
    lda $0C
    cmp #$18
    bcc B0F_CFAF
    cmp #$1B
    bcs B0F_CFAF
    lda #$01
    ora $49 ; object hero/target/item/string ID $49

    sta $49 ; object hero/target/item/string ID $49

    lda $C9
    clc
    adc #$18
    cmp $0C
    bne B0F_CFAF
    jsr $D058
    lda #$FF
    sta $49 ; object hero/target/item/string ID $49

    lda $12
    sta $052A,Y
    lda $13
    sta $052B,Y
    lda $12
    sec
    sbc $16 ; current map X-pos (1)

    asl
    sta $18
    lda $13
    sec
    sbc $17 ; current map Y-pos (1)

    asl
    sta $19
    lda #$00
    sta $1C
    sta $1E
    lda #$93 ; Music ID #$93: door open SFX

    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    jmp $D074

; control flow target (from $CFB2)
B0F_CFFC:
    lda $C9
    cmp #$02
    bcs B0F_CFAF
    lda $0C
    cmp #$18
    bcc B0F_CFAF
    cmp #$1C
    bcs B0F_CFAF
    lda #$01
    ora $49 ; object hero/target/item/string ID $49

    sta $49 ; object hero/target/item/string ID $49

    jsr $D058
    lda #$FF
    sta $49 ; object hero/target/item/string ID $49

    lda $12
    sta $052A,Y
    lda $13
    sta $052B,Y
    lda $12
    asl
    sec
    sbc $16 ; current map X-pos (1)

    asl
    sta $18
    lda $13
    asl
    sec
    sbc $17 ; current map Y-pos (1)

    asl
    sta $19
    lda #$00
    sta $1C
    sta $1E
    lda #$93 ; Music ID #$93: door open SFX

    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    jsr $D074
    inc $18
    inc $18
    jsr $D074
    inc $19
    inc $19
    jsr $D074
    dec $18
    dec $18
    jmp $D074

; control flow target (from $CAC3, $CFCD, $D012)
    ldy #$00
; control flow target (from $D066)
B0F_D05A:
    lda $052A,Y
    ora $052B,Y
    beq B0F_D06A
    iny
    iny
    cpy #$10
    bne B0F_D05A
    pla
    pla
; control flow target (from $D060)
B0F_D06A:
    rts

; copy $16 to $0C, $17 to $0E
; control flow target (from $CF80, $CF88, $CF90, $CF98, $D0A0)
    lda $16 ; current map X-pos (1)

    sta $0C
    lda $17 ; current map Y-pos (1)

    sta $0E
    rts

; control flow target (from $CFF9, $D040, $D047, $D04E, $D055)
    lda $18
    clc
    adc #$10
    sta $0C
    lda $19
    clc
    adc #$0E
    sta $0E
    jsr $DE2D
    ldy #$00
    lda ($07),Y
    beq B0F_D08C
    rts

; control flow target (from $D089)
B0F_D08C:
    lda #$00
    sta $1C
    sta $1E
    jmp $DEC5

; external control flow target (from $06:$9B30)
    lda $1F ; some kind of map type (#$00: World Map, #$01: other non-dungeon maps, #$02: maps #$2B - #$43 inclusive, #$03: maps >= #$44, #$FF => game menu)

    bne B0F_D0A0
; control flow target (from $D0AA, $D0BC)
B0F_D099:
    lda $94 ; return bank for various function calls, doubles as index of selected option for multiple-choice menus

    jsr $C3D5 ; save A to $05F6, X to $43, and load bank specified by A

    clc
    rts

; control flow target (from $D097)
B0F_D0A0:
    jsr $D06B ; copy $16 to $0C, $17 to $0E

    jsr $DF89
    lda $0C
    cmp #$14
    bne B0F_D099
    ldy #$00
; control flow target (from $D0BA)
B0F_D0AE:
    lda $051A,Y ; something to do with whether you've opened the chest containing the Shield of Erdrick

    ora $051B,Y
    beq B0F_D0BE
    iny
    iny
    cpy #$10
    bne B0F_D0AE
    beq B0F_D099
; control flow target (from $D0B4)
B0F_D0BE:
    lda $12
    sta $051A,Y ; something to do with whether you've opened the chest containing the Shield of Erdrick

    lda $13
    sta $051B,Y
    ldy #$00
    lda ($10),Y
    and #$E0
    sta ($10),Y
    lda #$92 ; Music ID #$92: open chest SFX

    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    lda #$00
    sta $18
    sta $19
    sta $1C
    sta $1E
    jsr $DEC5
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    lda $94 ; return bank for various function calls, doubles as index of selected option for multiple-choice menus

    jsr $C3D5 ; save A to $05F6, X to $43, and load bank specified by A

    sec
    rts

; update each hero's stats based on their current EXP
; control flow target (from $F5AE)
; external control flow target (from $06:$8B04)
    jsr $F766 ; load ROM bank #$04

; call to code in a different bank ($04:$8009)
    jsr $8009 ; update each hero's stats based on their current EXP

    jmp $F761 ; load ROM bank #$06


; wait for a while and then wipe menu regions #$03, #$00, and #$01
; control flow target (from $C84A, $C85A, $C944, $C9AF, $CA39, $CAA9, $CB36, $CB94, $CC00, $CC0E, $CC59, $CC76, $D1A1, $D1C6)
; external control flow target (from $06:$90C3, $06:$91B7, $06:$935C, $06:$9374, $06:$96A8, $06:$9709, $06:$979E, $06:$98F0, $06:$A1B1, $06:$A2F8, $06:$BB80, $06:$BBB3, $06:$BBD7, $07:$81FC, $07:$8227, $07:$8238, $07:$827F, $07:$82EB, $07:$8355, $07:$8366, $07:$837B, $07:$8402, $07:$84CB, $07:$8595)
    txa ; save X on the stack; pointless since X gets overwritten before next use

    pha
    ldx #$1E
    jsr $C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

    pla ; restore X from the stack

    tax
    lda $062C ; current battle message delay

    cmp #$28 ; FAST uses #$82

    beq B0F_D111
    cmp #$46 ; NORMAL uses #$AA

    beq B0F_D10D
    lda #$E6 ; ergo SLOW uses #$E6

    bne B0F_D113
; control flow target (from $D107)
B0F_D10D:
    lda #$AA ; from NORMAL

    bne B0F_D113
; control flow target (from $D103)
B0F_D111:
    lda #$82 ; from FAST

; control flow target (from $D10B, $D10F)
B0F_D113:
    sta $93 ; NMI counter, decremented once per NMI until it reaches 0

; wait until battle message delay reaches zero or no buttons pressed
; control flow target (from $D11E)
B0F_D115:
    jsr $D13D ; wait for interrupt, read joypad data into $2F and A

    ldx $93 ; NMI counter, decremented once per NMI until it reaches 0

    beq B0F_D12B
    cmp #$00
    bne B0F_D115
; wait until battle message delay reaches is zero or some button pressed
; control flow target (from $D129)
B0F_D120:
    jsr $D13D ; wait for interrupt, read joypad data into $2F and A

    ldx $93 ; NMI counter, decremented once per NMI until it reaches 0

    beq B0F_D12B
    cmp #$00
    beq B0F_D120
; control flow target (from $D11A, $D125)
B0F_D12B:
    jsr $FA89 ; useless JSR to RTS?!

    lda #$03
    jsr $F78C ; wipe selected menu region

    lda #$00
    jsr $F78C ; wipe selected menu region

    lda #$01
    jmp $F78C ; wipe selected menu region


; wait for interrupt, read joypad data into $2F and A
; control flow target (from $D115, $D120)
; external control flow target (from $06:$809D, $06:$80A2)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    jsr $C476 ; read joypad 1 data into $2F

    lda $2F ; joypad 1 data

    rts

; heal hero ID in A by random amount based on healing power in X
; external control flow target (from $06:$8BED)
    jsr $F766 ; load ROM bank #$04

; call to code in a different bank ($04:$8006)
    jsr $8006
    jmp $F761 ; load ROM bank #$06


; control flow target (from $FF60)
; external control flow target (from $06:$A848, $06:$A98F)
    lda #$00
    sta $27 ; map palette; offset from ($E27C)

    jsr $E2F9
    jmp $F761 ; load ROM bank #$06


; external control flow target (from $06:$A35D)
    lda $94 ; return bank for various function calls, doubles as index of selected option for multiple-choice menus

    pha
    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $C4
; data -> code
    jsr $FA2A ; display string ID specified by next byte


; code -> data
; indirect data load target

.byte $7A
; data -> code
; control flow target (from $D172)
    jsr $F761 ; load ROM bank #$06

    pla
    sta $94 ; return bank for various function calls, doubles as index of selected option for multiple-choice menus

    rts

; external control flow target (from $06:$8F20)
    lda $94 ; return bank for various function calls, doubles as index of selected option for multiple-choice menus

    pha
    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $C4
; data -> code
    jmp $D164

; external control flow target (from $06:$A882)
    lda #$8F
    sta $30
    jsr $D2DE
    jsr $F775 ; load ROM bank #$03

; call to code in a different bank ($03:$8006)
    jsr $8006
    lda #$FF
    sta $8E ; flag for in battle or not (#$FF)?

    lda #$04 ; Menu ID #$04: Dialogue window

    jsr $EB89 ; open menu specified by A

    lda #$00
    sta $27 ; map palette; offset from ($E27C)

    jsr $E2F9
    inc $8E ; flag for in battle or not (#$FF)?

    lda #$7B ; String ID #$007B: In that case, return when thou can, for Hargon does not sleep.[wait][line]In order to preserve the Imperial Scrolls of honor, please hold the REST button in while pushing the POWER button off.[wait][line]If you turn off the POWER first, you may lose the record of your great deeds, and that would be a shame.[line][FD][FD] [line][end-FC]

    jsr $FA4A ; display string ID specified by A

    lda #$10
    jsr $C636 ; set CHR bank 0 based on A

; infinite loop
; control flow target (from $D19E)
    jmp $D19E ; infinite loop


; handle Hamlin Waterway Gremlins fight
; external control flow target (from $06:$906E)
    jsr $D0F5 ; wait for a while and then wipe menu regions #$03, #$00, and #$01

    jsr $F766 ; load ROM bank #$04

    lda #$03 ; Fixed Battle #$03: 2 Ozwargs (Map ID #$08: Hamlin Waterway)

; call to code in a different bank ($04:$800F)
    jsr $800F
    lda $98 ; outcome of last fight?

    cmp #$FC
    beq B0F_D1C0
    lda #$02
    ora $D1 ; fixed battle status bits (#$10 = Zarlox, #$08 = Bazuzu, #$04 = Atlas, #$02 = Hamlin Waterway Gremlins, #$01 = Evil Clown)

    sta $D1 ; fixed battle status bits (#$10 = Zarlox, #$08 = Bazuzu, #$04 = Atlas, #$02 = Hamlin Waterway Gremlins, #$01 = Evil Clown)

    lda #$FF
    sta $0559 ; NPC #$03 sprite ID

    sta $0561 ; NPC #$04 sprite ID

; control flow target (from $D1B0)
B0F_D1C0:
    jsr $D262
    jmp $D2FB ; load ROM bank 6


; external control flow target (from $06:$9342)
    jsr $D0F5 ; wait for a while and then wipe menu regions #$03, #$00, and #$01

    jsr $F766 ; load ROM bank #$04

    lda #$04 ; Fixed Battle #$04: 2 Gold Batboons (Map ID #$16: Hargon's Castle 1F)

; call to code in a different bank ($04:$800F)
    jsr $800F
    lda $98 ; outcome of last fight?

    cmp #$FC
    beq B0F_D1DF
    lda #$FF
    sta $0581 ; NPC #$08 sprite ID

    sta $0589 ; NPC #$09 sprite ID

; control flow target (from $D1D5)
B0F_D1DF:
    jsr $D262
    jmp $D2FB ; load ROM bank 6


; trigger Fixed Battle #$01: 1 Evil Clown (Map ID #$04: Midenhall B1)
; external control flow target (from $06:$80E5)
    lda #$FF
    sta $0569 ; NPC #$05 sprite ID

    lda #$01 ; Fixed Battle #$01: 1 Evil Clown (Map ID #$04: Midenhall B1)

    jsr $D25C ; trigger fixed battle A

    lda #$01
    ora $D1 ; fixed battle status bits (#$10 = Zarlox, #$08 = Bazuzu, #$04 = Atlas, #$02 = Hamlin Waterway Gremlins, #$01 = Evil Clown)

    sta $D1 ; fixed battle status bits (#$10 = Zarlox, #$08 = Bazuzu, #$04 = Atlas, #$02 = Hamlin Waterway Gremlins, #$01 = Evil Clown)

    jmp $D2FB ; load ROM bank 6


; trigger Fixed Battle #$0B: 1 Hargon (Map ID #$17: Hargon's Castle 7F)
; external control flow target (from $06:$935F)
    lda #$0B ; Fixed Battle #$0B: 1 Hargon (Map ID #$17: Hargon's Castle 7F)

    jsr $D25C ; trigger fixed battle A

    jmp $D2FB ; load ROM bank 6


; external control flow target (from $06:$BD2A)
    jsr $F766 ; load ROM bank #$04

    lda #$0C ; Fixed Battle #$0C: 1 Malroth (Map ID #$17: Hargon's Castle 7F)

; call to code in a different bank ($04:$800F)
    jsr $800F
    lda #$FF
    sta $44 ; non-saved event status (#$00 = event start, #$01 = Lianport Gremlins defeated, #$02 = met with Lianport grandfather/have no friends at Shrine SW of Cannock, #$03 = King Midenhall moved to stairs, #$04 = King Midenhall moved down stairs, #$05 = King Midenhall spoke on Midenhall 1F, #$0B = Lighthouse Wizard 7F, #$1B Lighthouse Wizard 2F spoke, #$64 = Hargon dead, #$FF = event end)

    lda $98 ; outcome of last fight?

    cmp #$FF
    bne B0F_D215
    jmp $D267

; control flow target (from $D210)
B0F_D215:
    jmp $F761 ; load ROM bank #$06


; open path to Sea Cave
; external control flow target (from $06:$98FD)
    lda #$97 ; Music ID #$97: shoals submerging SFX

    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    jsr $F75C ; load ROM bank #$00

    lda #$00
; call to code in a different bank ($00:$8006)
    jsr $8006
    lda #$32
    sta $41
    jsr $E938
    lda #$97 ; Music ID #$97: shoals submerging SFX

    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    jsr $F75C ; load ROM bank #$00

    lda #$FF
; call to code in a different bank ($00:$8006)
    jsr $8006
    pla
    pla
    jmp $F761 ; load ROM bank #$06


; external control flow target (from $06:$96B0)
    jsr $F75C ; load ROM bank #$00

; call to code in a different bank ($00:$8009)
    jsr $8009
    lda #$01
    sta $05F9 ; flag for Cave to Rhone open

    lda #$32
    sta $41
    jsr $E938
    jsr $F75C ; load ROM bank #$00

; call to code in a different bank ($00:$800C)
    jmp $800C

; external control flow target (from $06:$97BA, $06:$97C1)
    jsr $DEC5
    jmp $F761 ; load ROM bank #$06


; trigger fixed battle A
; control flow target (from $C8D1, $CAFC, $CC38, $CC94, $D1EC, $D1FA)
    jsr $F766 ; load ROM bank #$04

; call to code in a different bank ($04:$800F)
    jsr $800F
; control flow target (from $C908, $C972, $D1C0, $D1DF)
    lda $98 ; outcome of last fight?

    bne B0F_D267
    rts

; control flow target (from $D212, $D264)
B0F_D267:
    lda #$00
    sta $8E ; flag for in battle or not (#$FF)?

    lda $98 ; outcome of last fight?

    cmp #$FF
    bne B0F_D295
; external control flow target (from $06:$A25A)
    lda #$26
    sta $050E
    jsr $D2DE
    lda #$84
    sta $062D ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    ldx #$FF
    txs
    lda #$01
    sta $063B ; Midenhall Current HP, low byte

    jsr $D2FB ; load ROM bank 6

; call to code in a different bank ($06:$8DCC)
    jsr $8DCC ; restore full HP to all living party members

    jsr $D2B9
; call to code in a different bank ($06:$8F39)
    jsr $8F39
    jmp $C700

; control flow target (from $D26F)
B0F_D295:
    jsr $D2DE
    lda #$FF
; control flow target (from $C9A5)
    sta $45
    jsr $F75C ; load ROM bank #$00

    lda $1F ; some kind of map type (#$00: World Map, #$01: other non-dungeon maps, #$02: maps #$2B - #$43 inclusive, #$03: maps >= #$44, #$FF => game menu)

    sta $0C
; call to code in a different bank ($00:$8000)
    jsr $8000
    jsr $D2F7
    jsr $F75C ; load ROM bank #$00

    lda #$04
    sta $0C
; call to code in a different bank ($00:$8000)
    jsr $8000
    jmp $E281

    jsr $C42A
; control flow target (from $C6FA, $D28C)
    jsr $D2FB ; load ROM bank 6

    jsr $E5A2
    ldx #$03
    jsr $D2E7 ; X = 1 => CLC and update $0C-$0D to warp point data to use if Outside allowed from current map, SEC otherwise, X = 2 => CLC and update $0C-$0D to warp point data to use if Return allowed from current map, SEC otherwise, X = 3 => disembark from ship and update ship position based on last save point ID $48

    lda $48 ; last save point ID

    cmp #$05 ; Save Point ID #$05: Rhone Shrine

    bne B0F_D2D8
    lda #$84
    sta $062D ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    sta $063F ; Cannock status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    sta $0651 ; Moonbrooke status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    jsr $C77B ; restore full HP/MP to all living party members

; control flow target (from $D2C8)
B0F_D2D8:
    jsr $C7AF
    jmp $D2FB ; load ROM bank 6


; control flow target (from $D179, $D276, $D295)
    jsr $C42A
    jsr $C446 ; turn screen off, write $800 [space] tiles to PPU $2000, turn screen on

    jmp $C465 ; wait for interrupt and then set every 4th byte of $0200 - $02FC to #$F0


; X = 1 => CLC and update $0C-$0D to warp point data to use if Outside allowed from current map, SEC otherwise, X = 2 => CLC and update $0C-$0D to warp point data to use if Return allowed from current map, SEC otherwise, X = 3 => disembark from ship and update ship position based on last save point ID $48
; control flow target (from $D2C1, $D2F1)
; external control flow target (from $06:$8C53, $06:$8CD6)
    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $A3
; data -> code
    php
    jsr $F761 ; load ROM bank #$06

    plp
    rts

; external control flow target (from $06:$BD62)
    jsr $D2E7 ; X = 1 => CLC and update $0C-$0D to warp point data to use if Outside allowed from current map, SEC otherwise, X = 2 => CLC and update $0C-$0D to warp point data to use if Return allowed from current map, SEC otherwise, X = 3 => disembark from ship and update ship position based on last save point ID $48

    jmp $F761 ; load ROM bank #$06


; control flow target (from $CF76, $D2A6, $D311, $D3C2, $D4A6, $E4BE, $E9B7)
    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $A2
; data -> code
; load ROM bank 6
; control flow target (from $C918, $CAFF, $D1C3, $D1E2, $D1F5, $D1FD, $D286, $D2B9, $D2DB, $D340)
    lda #$06
    sta $94 ; return bank for various function calls, doubles as index of selected option for multiple-choice menus

    jmp $C3D5 ; save A to $05F6, X to $43, and load bank specified by A


; external control flow target (from $06:$8669, $06:$8CC2, $06:$9420, $06:$9427, $06:$942E, $06:$A225)
    jsr $F75C ; load ROM bank #$00

    ldy $97 ; subject hero ID $97

    lda $D31F,Y
; call to code in a different bank ($00:$8003)
    jsr $8003
    lda #$FF
    sta $45
    jsr $D2F7
    jsr $D8CB
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    lda $94 ; return bank for various function calls, doubles as index of selected option for multiple-choice menus

    jmp $C3D5 ; save A to $05F6, X to $43, and load bank specified by A



; code -> data
; indexed data load target (from $D307)
; indirect data load target
; indirect data load target
.byte $5C
; indirect data load target
.byte $61
; indirect data load target
.byte $66
; indirect data load target
.byte $58
.byte $59

.byte $5A
; data -> code
; external control flow target (from $06:$BD0B)
    jsr $DEC5
    jsr $C504
; control flow target (from $D331)
    jmp $F761 ; load ROM bank #$06


; external control flow target (from $06:$BD71)
    jsr $D8CB
    jmp $D32B

; post-Malroth dialogue
; external control flow target (from $06:$80B9)
    jsr $F75C ; load ROM bank #$00

; call to code in a different bank ($00:$8012)
    jsr $8012 ; return value for $0D for post-Malroth dialogue

    sta $0D
    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $43
; data -> code
    jmp $D2FB ; load ROM bank 6


; external control flow target (from $06:$BC2A)
    nop
    nop
    nop
    lda #$09
    sta $94 ; return bank for various function calls, doubles as index of selected option for multiple-choice menus

    jsr $C3D5 ; save A to $05F6, X to $43, and load bank specified by A

; call to code in a different bank ($09:$8000)
    jsr $8000
; control flow target (from $D353)
B0F_D350:
    lda $0156 ; probably music playing flag? set to #$00 when music finishes

    bne B0F_D350
    sei
    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $DF
; data -> code
    rts

; control flow target (from $E5E1, $E655, $E6D3, $E7B4)
    lda $28 ; current map X-pos (2)

    sta $0C
    lda $29 ; current map Y-pos (2)

    sta $0E
    jsr $DF89
    jsr $DF4A
    jsr $F770 ; load ROM bank #$02

    ldy #$04
    lda ($10),Y
    and #$FC
    sta $3B ; high nybble = terrain ID

    lda $61AD
    beq B0F_D37A
    rts

; control flow target (from $D377)
B0F_D37A:
    lda $FFBA
    bne B0F_D388
    lda $2F ; joypad 1 data

    and #$02
    beq B0F_D388
    jmp $D429

; control flow target (from $D37D, $D383)
B0F_D388:
    lda $CF ; ship status (#$04 = on ship, #$02 = own ship, #$01 = beat Lianport Gremlins)

    and #$04
    beq B0F_D3CF
    lda $3B ; high nybble = terrain ID

    and #$F0
    cmp #$40
    bne B0F_D399
    jmp $D429

; control flow target (from $D394)
B0F_D399:
    cmp #$A0
    bcs B0F_D414
    lda $CF ; ship status (#$04 = on ship, #$02 = own ship, #$01 = beat Lianport Gremlins)

    and #$FB
    sta $CF ; ship status (#$04 = on ship, #$02 = own ship, #$01 = beat Lianport Gremlins)

    lda $16 ; current map X-pos (1)

    sta $D2 ; ship X-pos (when you aren't on it)

    sta $05D4 ; NPC #$13 X-pos

    lda $17 ; current map Y-pos (1)

    sta $D3 ; ship Y-pos (when you aren't on it)

    sta $05D5 ; NPC #$13 Y-pos

    lda #$05
    sta $05D9 ; NPC #$13 sprite ID

    lda $0540 ; NPC #$00 ? + direction nybble

    and #$03
    sta $05D8 ; NPC #$13 motion nybble + direction nybble

    lda #$01
    sta $45
    jsr $D2F7
    jsr $E32F
    lda #$00
    sta $38
    jmp $D429

; control flow target (from $D38C)
B0F_D3CF:
    lda $3B ; high nybble = terrain ID

    and #$F0
    cmp #$40
    bne B0F_D3F8
    lda $31 ; current map ID

    cmp #$01 ; Map ID #$01: World Map

    beq B0F_D3E1
    cmp #$0B ; Map ID #$0B: Lianport

    bne B0F_D414
; control flow target (from $D3DB)
B0F_D3E1:
    lda $05D4 ; NPC #$13 X-pos

    cmp $28 ; current map X-pos (2)

    bne B0F_D414
    lda $05D5 ; NPC #$13 Y-pos

    cmp $29 ; current map Y-pos (2)

    bne B0F_D414
    lda $05D9 ; NPC #$13 sprite ID

    cmp #$FF
    beq B0F_D414
    bne B0F_D449
; control flow target (from $D3D5)
B0F_D3F8:
    lda $3B ; high nybble = terrain ID

    and #$F0
    cmp #$A0
    bne B0F_D410
    lda $31 ; current map ID

    cmp #$2C ; Map ID #$2C: Lake Cave B1

    beq B0F_D414
    cmp #$2D ; Map ID #$2D: Lake Cave B2

    beq B0F_D414
    cmp #$40
    beq B0F_D414
    bne B0F_D429
; control flow target (from $D3FE)
B0F_D410:
    cmp #$B0
    bcc B0F_D429
; control flow target (from $D39B, $D3DF, $D3E6, $D3ED, $D3F4, $D404, $D408, $D40C, $D43E)
B0F_D414:
    lda $16 ; current map X-pos (1)

    sta $28 ; current map X-pos (2)

    lda $17 ; current map Y-pos (1)

    sta $29 ; current map Y-pos (2)

    pla
    pla
    pla
    pla
    lda #$00
    sta $03 ; game clock?

    sta $3B ; high nybble = terrain ID

    jmp $C747

; control flow target (from $D385, $D396, $D3CC, $D40E, $D412)
B0F_D429:
    ldy #$18
; control flow target (from $D447)
B0F_D42B:
    lda $0541,Y ; NPC #$00 sprite ID

    cmp #$FF
    beq B0F_D440
    lda $053C,Y ; NPC #$00 ?

    cmp $28 ; current map X-pos (2)

    bne B0F_D440
    lda $053D,Y ; NPC #$00 ?

    cmp $29 ; current map Y-pos (2)

    beq B0F_D414
; control flow target (from $D430, $D437)
B0F_D440:
    tya
    clc
    adc #$08
    tay
    cmp #$B8
    bne B0F_D42B
; control flow target (from $D3F6)
B0F_D449:
    ldy #$00
    jsr $D450
    ldy #$08
; control flow target (from $D44B)
    lda $0542,Y ; NPC #$00 ?

    ora $0543,Y ; NPC #$00 ?

    bne B0F_D459
    rts

; control flow target (from $D456)
B0F_D459:
    lda $053C ; NPC #$00 ?

    jsr $D463
    iny
    lda $053D ; NPC #$00 ?

; control flow target (from $D45C)
    sec
    sbc $0544,Y ; NPC #$01 ?

    sta $0546,Y ; NPC #$01 ?

    rts

; control flow target (from $C87F)
    lda $CF ; ship status (#$04 = on ship, #$02 = own ship, #$01 = beat Lianport Gremlins)

    and #$04
    bne B0F_D4B1
    lda $31 ; current map ID

    cmp #$01 ; Map ID #$01: World Map

    beq B0F_D47B
    cmp #$0B ; Map ID #$0B: Lianport

    bne B0F_D4B1
; control flow target (from $D475)
B0F_D47B:
    lda $05D4 ; NPC #$13 X-pos

    cmp $16 ; current map X-pos (1)

    bne B0F_D4B1
    lda $05D5 ; NPC #$13 Y-pos

    cmp $17 ; current map Y-pos (1)

    bne B0F_D4B1
    jsr $D6DA
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    lda #$FF
    sta $05D9 ; NPC #$13 sprite ID

    jsr $F75C ; load ROM bank #$00

    lda #$6B
; call to code in a different bank ($00:$8003)
    jsr $8003
    lda #$06
    ora $CF ; ship status (#$04 = on ship, #$02 = own ship, #$01 = beat Lianport Gremlins)

    sta $CF ; ship status (#$04 = on ship, #$02 = own ship, #$01 = beat Lianport Gremlins)

    lda #$FF
    sta $45
    jsr $D2F7
    jsr $E32F
    lda #$00
    sta $35 ; flag indicating whether any menu is currently open

    rts

; control flow target (from $D46F, $D479, $D480, $D487)
B0F_D4B1:
    lda $31 ; current map ID

    cmp #$0B ; Map ID #$0B: Lianport

    bne B0F_D4D2
    lda $16 ; current map X-pos (1)

    cmp #$19
    bne B0F_D4D2
    lda $17 ; current map Y-pos (1)

    cmp #$01
    bne B0F_D4D2
    lda $D6B0
    sta $0C
    lda $D6B1
    sta $0D
    lda #$FF
    jmp $D88F ; warp to warp point given by ($0C)


; control flow target (from $D4B5, $D4BB, $D4C1)
B0F_D4D2:
    ldx $3C
    lda $3B ; high nybble = terrain ID

    and #$F0
    sta $3C
    ldy $31 ; current map ID

    beq B0F_D504 ; Map ID #$00: Fake Midenhall

    cpx #$10
    beq B0F_D4EE
    cmp #$10
    bne B0F_D4EE
    lda #$82 ; Music ID #$82: Stairs SFX

    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    jmp $D7EE

; control flow target (from $D4E0, $D4E4)
B0F_D4EE:
    cmp #$20
    beq B0F_D4FC
    cmp #$30
    bne B0F_D504
    jsr $E5A2
    jmp $D7A6

; control flow target (from $D4F0)
B0F_D4FC:
    lda #$82 ; Music ID #$82: Stairs SFX

    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    jmp $D7A6

; control flow target (from $D4DC, $D4F4)
B0F_D504:
    lda $1F ; some kind of map type (#$00: World Map, #$01: other non-dungeon maps, #$02: maps #$2B - #$43 inclusive, #$03: maps >= #$44, #$FF => game menu)

    cmp #$02
    bcs B0F_D544
    lda $21 ; map width

    cmp $16 ; current map X-pos (1)

    bcc B0F_D517
    lda $22 ; map height

    cmp $17 ; current map Y-pos (1)

    bcc B0F_D517
    rts

; control flow target (from $D50E, $D514, $D55E)
B0F_D517:
    jsr $F775 ; load ROM bank #$03

    lda $D7EC ; -> $03:$BD13: warp points (map ID, X-pos, Y-pos); other end is same index in $02:$A27E

    sta $0C
    lda $D7ED
    sta $0D
    ldy #$00
; control flow target (from $D535, $D539)
B0F_D526:
    lda ($0C),Y
    and #$7F
    cmp $31 ; current map ID

    beq B0F_D53C
    lda $0C
    clc
    adc #$03
    sta $0C
    bcc B0F_D526
    inc $0D
    bne B0F_D526
    rts

; control flow target (from $D52C)
B0F_D53C:
    lda #$82 ; Music ID #$82: Stairs SFX

    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    jmp $D7B6

; control flow target (from $D508)
B0F_D544:
    lda $16 ; current map X-pos (1)

    lsr
    clc
    sbc $21 ; map width

    bcs B0F_D557
    lda $17 ; current map Y-pos (1)

    lsr
    clc
    sbc $22 ; map height

    bcs B0F_D557
    jmp $D5E9

; control flow target (from $D54A, $D552)
B0F_D557:
    lda $31 ; current map ID

    ldy #$05
; control flow target (from $D561)
B0F_D55B:
    cmp $D69B,Y
    beq B0F_D517
    dey
    bpl B0F_D55B
    lda $0540 ; NPC #$00 ? + direction nybble

    and #$03
    tax
    asl
    tay
    lda $D6A9,X
    sta $0F
    lda $D6A1,Y
    sta $12
    sta $10
    lda $D6A2,Y
    sta $13
    sta $11
    jsr $F761 ; load ROM bank #$06

    lda $0F
    pha
    lda $10
    pha
    lda #$6E
; call to code in a different bank ($06:$A369)
    jsr $A369 ; check for item A in party inventory, returning inventory index of item in A/X if found, #$FF if not

    tax
    pla
    sta $10
    pla
    sta $0F
    cpx #$FF
    bne B0F_D59D
; call to code in a different bank ($06:$8CD4)
    jsr $8CD4 ; handler for Outside spell effect

    jmp $D5B6

; control flow target (from $D595)
; call to code in a different bank ($06:$8CD4)
B0F_D59D:
    jsr $8CD4 ; handler for Outside spell effect

    lsr $0E
    beq B0F_D5B6
; control flow target (from $D5B4)
B0F_D5A4:
    lda $10
    clc
    adc $12
    sta $12
    lda $11
    clc
    adc $13
    sta $13
    dec $0E
    bne B0F_D5A4
; control flow target (from $D59A, $D5A2)
B0F_D5B6:
    jsr $F770 ; load ROM bank #$02

    ldy #$00
    lda ($0C),Y
    sta $5A ; Crest/direction name write buffer start

    iny
    lda ($0C),Y
    clc
    adc $12
    sta $5B
    iny
    lda ($0C),Y
    clc
    adc $13
    sta $5C
; control flow target (from $D617)
    lda $0F
    pha
    jsr $D6E1
    ldx #$28
    jsr $C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

    lda $D699
    sta $0C
    lda $D69A
    sta $0D
    pla
    jmp $D88F ; warp to warp point given by ($0C)


; control flow target (from $D5ED, $D5FA, $D5FE, $D61C, $D620, $D629)
B0F_D5E8:
    rts

; control flow target (from $D554)
    lda $31 ; current map ID

    cmp #$65 ; Map ID #$65: Dragon Horn South 6F

    bcs B0F_D5E8
    cmp #$61 ; Map ID #$61: Dragon Horn South 2F

    bcc B0F_D61A
    jsr $D678
    lda $0C
    cmp #$08
    bcs B0F_D5E8
    cmp #$04
    bcc B0F_D5E8
    lda #$60
    sta $5A ; Crest/direction name write buffer start

    lda $16 ; current map X-pos (1)

    sta $5B
    lda $17 ; current map Y-pos (1)

    sta $5C
; control flow target (from $D675)
    lda $0540 ; NPC #$00 ? + direction nybble

    and #$03
    tay
    lda $D6A9,Y
    sta $0F
    jmp $D5CF

; control flow target (from $D5F1)
B0F_D61A:
    cmp #$40 ; Map ID #$40: Spring of Bravery

    bcs B0F_D5E8
    cmp #$38 ; Map ID #$38: Cave to Rhone 1F

    bcc B0F_D5E8
    jsr $D678
    lda $0C
    cmp #$05
    bne B0F_D5E8
    lda $31 ; current map ID

    sec
    sbc #$38 ; Map ID #$38: Cave to Rhone 1F

    tax
    lda $D6B2,X
    sta $5A ; Crest/direction name write buffer start

    lda $D6BA,X
    jsr $D683
    adc $D6CA,X
    sta $5B
    lda $D6C2,X
    jsr $D683
    adc $D6D2,X
    sta $5C
    lda $14
    sta $0C
    lda $15
    sta $0E
    jsr $DDFC
    lda #$5F
    sta $09
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    jsr $C1FA ; wait for $02 to not be #$C0, write PPU address in $07-$08 and data in $09 to PPU write buffer at $0300,$02, $01 += 1, $02 += 3, and set $0183 to #$00

    jsr $C1FA ; wait for $02 to not be #$C0, write PPU address in $07-$08 and data in $09 to PPU write buffer at $0300,$02, $01 += 1, $02 += 3, and set $0183 to #$00

    lda $07
    clc
    adc #$1E
    sta $07
    bcc B0F_D66F
    inc $08
; control flow target (from $D66B)
B0F_D66F:
    jsr $C1FA ; wait for $02 to not be #$C0, write PPU address in $07-$08 and data in $09 to PPU write buffer at $0300,$02, $01 += 1, $02 += 3, and set $0183 to #$00

    jsr $C1FA ; wait for $02 to not be #$C0, write PPU address in $07-$08 and data in $09 to PPU write buffer at $0300,$02, $01 += 1, $02 += 3, and set $0183 to #$00

    jmp $D60C

; control flow target (from $D5F3, $D622)
    lda $16 ; current map X-pos (1)

    sta $0C
    lda $17 ; current map Y-pos (1)

    sta $0E
    jmp $DF89

; control flow target (from $D639, $D644)
    sta $0E
    jsr $C3AB ; generate a random number and store it in $32-$33 (two passes)

    lda $32 ; RNG byte 0

    sta $0C
    lda #$00
    sta $0D
    sta $0F
    jsr $C339 ; 16-bit multiplication: ($10-$11) = ($0C-$0D) * ($0E-$0F); consumes $0C-$0F

    lda $11
    asl
    rts


; code -> data
; data load target (from $D5DA)
; indirect data load target
; data load target (from $D5DF)
.byte $5A
; indirect data load target
; indexed data load target (from $D55B)
.byte $00
; indirect data load target
; indirect data load target
.byte $38
; indirect data load target
.byte $49
; indirect data load target
.byte $50
; indirect data load target
.byte $58
; indirect data load target
.byte $60
; indexed data load target (from $D570)
.byte $66
; indirect data load target
; indexed data load target (from $D577)
.byte $00
; indirect data load target
; indirect data load target
.byte $FF
; indirect data load target
.byte $01
; indirect data load target
.byte $00
; indirect data load target
.byte $00
; indirect data load target
.byte $01
; indirect data load target
.byte $FF
; indexed data load target (from $D56B, $D612)
.byte $00
; indirect data load target
; indirect data load target
.byte $09
; indirect data load target
.byte $04
; indirect data load target
.byte $0A
; indirect data load target
.byte $03
; indirect data load target
.byte $01
; indirect data load target
.byte $1E
; data load target (from $D4C3)
.byte $38
; indirect data load target
; data load target (from $D4C8)
.byte $AD
; indirect data load target
; indexed data load target (from $D631)
.byte $D6
; indirect data load target
; indirect data load target
.byte $37
; indirect data load target
.byte $38
; indirect data load target
.byte $38
; indirect data load target
.byte $38
; indirect data load target
.byte $3B
; indirect data load target
.byte $3C
; indirect data load target
.byte $3D
; indexed data load target (from $D636)
.byte $3E
; indirect data load target
; indirect data load target
.byte $08
; indirect data load target
.byte $02
; indirect data load target
.byte $02
; indirect data load target
.byte $02
; indirect data load target
.byte $02
; indirect data load target
.byte $02
; indirect data load target
.byte $08
; indexed data load target (from $D641)
.byte $08
; indirect data load target
; indirect data load target
.byte $07
; indirect data load target
.byte $02
; indirect data load target
.byte $02
; indirect data load target
.byte $02
; indirect data load target
.byte $04
; indirect data load target
.byte $03
; indirect data load target
.byte $08
; indexed data load target (from $D63C)
.byte $03
; indirect data load target
; indirect data load target
.byte $02
; indirect data load target
.byte $06
; indirect data load target
.byte $06
; indirect data load target
.byte $06
; indirect data load target
.byte $0E
; indirect data load target
.byte $0C
; indirect data load target
.byte $08
; indexed data load target (from $D647)
.byte $12
; indirect data load target
; indirect data load target
.byte $02
; indirect data load target
.byte $0E
; indirect data load target
.byte $0E
; indirect data load target
.byte $0E
; indirect data load target
.byte $0A
; indirect data load target
.byte $30
; indirect data load target
.byte $08

.byte $02
; data -> code
; control flow target (from $D489)
    jsr $E3CC
    lda #$10
    bne B0F_D6E8
; control flow target (from $D5D2)
    lda #$98 ; Music ID #$98: more Watergate? SFX

    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    lda #$08
; control flow target (from $D6DF)
B0F_D6E8:
    sta $97 ; subject hero ID $97

    lda #$FF
    sta $35 ; flag indicating whether any menu is currently open

    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    lda #$00
    sta $053A
    sta $053B
    jsr $D8CB
    lda $0549 ; NPC #$01 sprite ID

    pha
    lda $0551 ; NPC #$02 sprite ID

    pha
    jsr $D71D
    jsr $D71D
    lda #$80
    sta $053A
    lda #$6F
    sta $053B
    pla
    sta $0551 ; NPC #$02 sprite ID

    pla
    sta $0549 ; NPC #$01 sprite ID

    rts

; control flow target (from $D704, $D707)
    lda $97 ; subject hero ID $97

    sta $49 ; object hero/target/item/string ID $49

; control flow target (from $D733)
B0F_D721:
    ldy #$08
    jsr $D769
    ldy #$10
    jsr $D769
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    jsr $D8CB
    dec $49 ; object hero/target/item/string ID $49

    bne B0F_D721
    ldy #$10
    jsr $D777
    ldy #$08
    jsr $D777
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    jmp $D8CB

; control flow target (from $D770, $D773)
    lda $053A,Y
    sec
    sbc $053C,Y ; NPC #$00 ?

    sta $053A,Y
    lda $97 ; subject hero ID $97

    cmp #$10
    beq B0F_D75F
    lda $053A,Y
    sec
    sbc $053C,Y ; NPC #$00 ?

    sta $053A,Y
; control flow target (from $D753)
B0F_D75F:
    iny
    rts

; control flow target (from $D7A0, $D7A3)
    lda $0534,Y
    sta $053C,Y ; NPC #$00 ?

    iny
    rts

; control flow target (from $D723, $D728)
    lda $0541,Y ; NPC #$00 sprite ID

    cmp #$FF
    beq B0F_D776
    jsr $D745
    jsr $D745
; control flow target (from $D76E, $D77C)
B0F_D776:
    rts

; control flow target (from $D737, $D73C)
    lda $0541,Y ; NPC #$00 sprite ID

    cmp #$FF
    beq B0F_D776
    lda $053A,Y
    cmp #$80
    bne B0F_D79A
    lda $053B,Y
    cmp #$6F
    bne B0F_D79A
    lda #$FF
    sta $0541,Y ; NPC #$00 sprite ID

    lda #$00
    sta $053A,Y
    sta $053B,Y
    rts

; control flow target (from $D783, $D78A)
B0F_D79A:
    lda $0538,Y
    sta $0540,Y ; NPC #$00 ? + direction nybble

    jsr $D761
    jmp $D761

; control flow target (from $D4F9, $D501)
; external control flow target (from $06:$96C6)
    jsr $F775 ; load ROM bank #$03

    lda $D7EC ; -> $03:$BD13: warp points (map ID, X-pos, Y-pos); other end is same index in $02:$A27E

    sta $0C
    lda $D7ED
    sta $0D
    jsr $D869 ; scan through warp point list (not sure what stops this from scanning through entire ROM...), updating $0C-$0D to address of the relevant warp point

; control flow target (from $D541)
    lda $0C
    sec
    sbc $D7EC ; -> $03:$BD13: warp points (map ID, X-pos, Y-pos); other end is same index in $02:$A27E

    sta $0C
    lda $0D
    sbc $D7ED
    sta $0D
    lda $0C
    clc
    adc $D7EA ; -> $02:$A27E: warp points (map ID, X-pos, Y-pos); other end is same index in $03:$BD13

    sta $0C
    lda $0D
    adc $D7EB
    sta $0D
    jsr $F770 ; load ROM bank #$02

    ldy #$00
    lda ($0C),Y
    bpl B0F_D7E0
    tya
    beq B0F_D837
; control flow target (from $D7DB)
B0F_D7E0:
    lda ($0C),Y
    and #$7F
    cmp #$2B
    bcs B0F_D831
    bcc B0F_D835

; code -> data
; -> $02:$A27E: warp points (map ID, X-pos, Y-pos); other end is same index in $03:$BD13
; data load target (from $D7C8, $D7F1, $D801)
; data load target (from $D7CF, $D7F6, $D808)
.byte $7E
; -> $03:$BD13: warp points (map ID, X-pos, Y-pos); other end is same index in $02:$A27E
.byte $A2
; data load target (from $D51A, $D7A9, $D7B9, $D810)
; data load target (from $D51F, $D7AE, $D7C0, $D817)
.byte $13

.byte $BD
; data -> code
; control flow target (from $D4EB)
    jsr $F770 ; load ROM bank #$02

    lda $D7EA ; -> $02:$A27E: warp points (map ID, X-pos, Y-pos); other end is same index in $03:$BD13; set $0C-$0D to the bank 2 end of the warp point data

    sta $0C
    lda $D7EB
    sta $0D
    jsr $D869 ; scan through warp point list (not sure what stops this from scanning through entire ROM...), updating $0C-$0D to address of the relevant warp point

    lda $0C ; now that we have the warp point address in $0C-$0D, subtract the original pointer to get the relative offset

    sec
    sbc $D7EA ; -> $02:$A27E: warp points (map ID, X-pos, Y-pos); other end is same index in $03:$BD13

    sta $0C
    lda $0D
    sbc $D7EB
    sta $0D
    lda $0C ; and then add the bank 3 pointer to get the corresponding bank 3 end of the warp point data

    clc
    adc $D7EC ; -> $03:$BD13: warp points (map ID, X-pos, Y-pos); other end is same index in $02:$A27E

    sta $0C
    lda $0D
    adc $D7ED
    sta $0D
; external control flow target (from $06:$9956)
    jsr $F775 ; load ROM bank #$03

    ldy #$00
    lda ($0C),Y ; map ID

    bpl B0F_D829
    lda #$02
    bne B0F_D837
; control flow target (from $D823)
B0F_D829:
    lda ($0C),Y ; useless op; A hasn't changed since the last LDA

    and #$7F ; useless op; we got here from BPL

    cmp #$2B
    bcs B0F_D835
; control flow target (from $D7E6)
B0F_D831:
    lda #$04
    bne B0F_D837
; control flow target (from $D7E8, $D82F)
B0F_D835:
    lda #$03
; control flow target (from $D7DE, $D827, $D833, $D894)
B0F_D837:
    sta $45
    ldy #$00
    lda ($0C),Y ; warp destination map ID

    and #$7F
    sta $31 ; current map ID

    iny
    lda ($0C),Y ; warp destination X-pos

    sta $16 ; current map X-pos (1)

    sta $28 ; current map X-pos (2)

    sta $2A ; current map X-pos pixel, low byte

    iny
    lda ($0C),Y ; warp destination Y-pos

    sta $17 ; current map Y-pos (1)

    sta $29 ; current map Y-pos (2)

    sta $2C ; current map Y-pos pixel, low byte

    lda #$00
    sta $2B ; current map X-pos pixel, high byte

    sta $2D ; current map Y-pos pixel, high byte

    ldx #$04 ; convert 16x16 map positions to pixels

; control flow target (from $D864)
B0F_D85B:
    asl $2A ; current map X-pos pixel, low byte

    rol $2B ; current map X-pos pixel, high byte

    asl $2C ; current map Y-pos pixel, low byte

    rol $2D ; current map Y-pos pixel, high byte

    dex
    bne B0F_D85B
    jmp $E287

; scan through warp point list (not sure what stops this from scanning through entire ROM...), updating $0C-$0D to address of the relevant warp point
; control flow target (from $D7B3, $D7FB, $D889, $D88D)
B0F_D869:
    ldy #$00
    lda ($0C),Y ; Map ID

    and #$7F
    cmp $31 ; current map ID

    bne B0F_D882 ; if different map/pos, update $0C-$0D to next index

    iny
    lda $16 ; current map X-pos (1)

    cmp ($0C),Y
    bne B0F_D882 ; if different map/pos, update $0C-$0D to next index

    iny
    lda $17 ; current map Y-pos (1)

    cmp ($0C),Y
    bne B0F_D882 ; if different map/pos, update $0C-$0D to next index

    rts

; if different map/pos, update $0C-$0D to next index
; control flow target (from $D871, $D878, $D87F)
B0F_D882:
    lda $0C
    clc
    adc #$03 ; warp data is 3 bytes each

    sta $0C
    bcc B0F_D869 ; scan through warp point list (not sure what stops this from scanning through entire ROM...), updating $0C-$0D to address of the relevant warp point

    inc $0D
    bne B0F_D869 ; scan through warp point list (not sure what stops this from scanning through entire ROM...), updating $0C-$0D to address of the relevant warp point

; warp to warp point given by ($0C)
; control flow target (from $D4CF, $D5E5)
; external control flow target (from $06:$8C39, $06:$8C5F, $06:$BD69)
    pha
    jsr $F770 ; load ROM bank #$02

    pla
    jmp $D837

; control flow target (from $E600, $E630, $E694, $E6AE, $E6DD, $E704, $E72E, $E75B, $E791, $E7DB, $E802, $E82C, $E859, $E877)
    ldy #$08
    jsr $DBD1
    ldy #$10
    jsr $DBD1
    lda $03 ; game clock?

    and #$0F
    bne B0F_D8CB
    ldy #$00
    lda $0549,Y ; NPC #$01 sprite ID

    cmp #$FF
    beq B0F_D8B3
    jsr $DBE0
; control flow target (from $D8AE)
B0F_D8B3:
    ldy #$08
    lda $0549,Y ; NPC #$01 sprite ID

    cmp #$FF
    beq B0F_D8BF
    jsr $DBE0
; control flow target (from $D8BA)
B0F_D8BF:
    lda $0548 ; NPC #$01 ? + direction nybble

    sta $0550 ; NPC #$02 ? + direction nybble

    lda $0540 ; NPC #$00 ? + direction nybble

    sta $0548 ; NPC #$01 ? + direction nybble

; control flow target (from $C758, $C827, $C847, $CCDC, $CD6F, $CD7E, $CF5E, $CF64, $D314, $D32E, $D6F9, $D72E, $D742, $D8A5, $E2F2, $E979, $F470, $F865, $FF8A)
B0F_D8CB:
    lda $8E ; flag for in battle or not (#$FF)?

    beq B0F_D8D0
    rts

; control flow target (from $D8CD)
B0F_D8D0:
    jsr $F775 ; load ROM bank #$03

    lda $03 ; game clock?

    and #$0F
    bne B0F_D8E0
    lda $36
    clc
    adc #$08
    sta $36
; control flow target (from $D8D7)
B0F_D8E0:
    jsr $C468 ; set every 4th byte of $0200 - $02FC to #$F0

    ldx #$00
    ldy #$00
    sty $37
    jsr $DC9A
    ldy #$08
    ldx #$50
    jsr $DC9A
    ldy #$10
    ldx #$B0
    jsr $DC9A
    lda $38
    cmp #$FF
    bne B0F_D903
    jmp $DBB6

; control flow target (from $D8FE)
B0F_D903:
    lda $35 ; flag indicating whether any menu is currently open

    beq B0F_D90A
    jmp $DB35

; control flow target (from $D905)
B0F_D90A:
    lda $38
    bpl B0F_D910
    and #$7F
; control flow target (from $D90C)
B0F_D910:
    asl
    asl
    asl
    adc #$18
    tax
    lda #$02
    sta $34
; control flow target (from $DB32)
    lda $0541,X ; NPC #$00 sprite ID

    cmp #$FF
    bne B0F_D924
    jmp $DB29

; control flow target (from $D91F)
B0F_D924:
    lda $03 ; game clock?

    and #$0F
    cmp #$01
    beq B0F_D92F
    jmp $DAC4

; control flow target (from $D92A)
B0F_D92F:
    lda $35 ; flag indicating whether any menu is currently open

    beq B0F_D94F
; control flow target (from $D95C, $D9F9)
    lda $38
    bpl B0F_D944
    dec $053A,X
    lda $053A,X
    cmp #$FF
    bne B0F_D944
    dec $053B,X
; control flow target (from $D935, $D93F, $D997)
B0F_D944:
    lda $0540,X ; NPC #$00 ? + direction nybble

    and #$F3
    sta $0540,X ; NPC #$00 ? + direction nybble

    jmp $DB29

; control flow target (from $D931)
B0F_D94F:
    lda $0540,X ; NPC #$00 ? + direction nybble

    and #$F0
    cmp #$10
    beq B0F_D99C
    cmp #$20
    beq B0F_D95F
    jmp $D933

; control flow target (from $D95A)
B0F_D95F:
    lda $053A,X
    sta $0C
    lda $053B,X
    sta $0D
    jsr $F77A ; load ROM bank #$07

    ldy #$00
    lda ($0C),Y
    bpl B0F_D983
    lda $0540,X ; NPC #$00 ? + direction nybble

    and #$03
    sta $0540,X ; NPC #$00 ? + direction nybble

    lda $38
    and #$7F
    sta $38
    jmp $DB29

; control flow target (from $D970)
B0F_D983:
    inc $053A,X
    bne B0F_D98B
    inc $053B,X
; control flow target (from $D986)
B0F_D98B:
    lda $0540,X ; NPC #$00 ? + direction nybble

    and #$F0
    ora ($0C),Y
    sta $0540,X ; NPC #$00 ? + direction nybble

    and #$08
    bne B0F_D944
    jmp $DABC

; control flow target (from $D956)
B0F_D99C:
    jsr $C3AB ; generate a random number and store it in $32-$33 (two passes)

    lda $32 ; RNG byte 0

    and #$03
    sta $0C
    lda $0540,X ; NPC #$00 ? + direction nybble

    and #$F0
    ora $0C
    sta $0540,X ; NPC #$00 ? + direction nybble

    jsr $DBF8
    jsr $DC03
    lda $11
    beq B0F_D9BD
    lda $10
    bne B0F_D9F9
; control flow target (from $D9B7)
B0F_D9BD:
    jsr $E218
    lda $0540,X ; NPC #$00 ? + direction nybble

    and #$03
    bne B0F_D9CC
    dec $13
    jmp $D9E0

; control flow target (from $D9C5)
B0F_D9CC:
    cmp #$01
    bne B0F_D9D5
    inc $12
    jmp $D9E0

; control flow target (from $D9CE)
B0F_D9D5:
    cmp #$02
    bne B0F_D9DE
    inc $13
    jmp $D9E0

; control flow target (from $D9D7)
B0F_D9DE:
    dec $12
; control flow target (from $D9C9, $D9D2, $D9DB)
    lda $38
    bmi B0F_DA16
    ldy #$0C
; control flow target (from $D9EE)
B0F_D9E6:
    lda $31 ; current map ID

    cmp $D9FC,Y
    beq B0F_D9F2
; control flow target (from $D9F7)
B0F_D9ED:
    dey
    bpl B0F_D9E6
    bmi B0F_DA16
; control flow target (from $D9EB)
B0F_D9F2:
    lda $13
    cmp $DA09,Y
    bne B0F_D9ED
; control flow target (from $D9BB, $DA1A, $DA20, $DA2B, $DA37)
B0F_D9F9:
    jmp $D933


; code -> data
; indexed data load target (from $D9E8)
; indexed data load target (from $D9F4)
.byte $15,$0B,$0F,$1A,$10,$03,$05
.byte $06,$07,$0B
.byte $0C,$11
.byte $14
; indirect data load target
; indirect data load target
.byte $10
; indirect data load target
.byte $08
; indirect data load target
.byte $0D
.byte $04
; indirect data load target
.byte $08,$13,$0D
.byte $0F
.byte $0F
; indirect data load target
.byte $14
; indirect data load target
.byte $0C
; indirect data load target
.byte $0E

.byte $12
; data -> code
; control flow target (from $D9E2, $D9F0)
B0F_DA16:
    lda $22 ; map height

    cmp $13
    bcc B0F_D9F9
    lda $21 ; map width

    cmp $12
    bcc B0F_D9F9
    jsr $DC03
    lda $11
    beq B0F_DA2D
    lda $10
; control flow target (from $DAA7)
B0F_DA2B:
    bne B0F_D9F9
; control flow target (from $DA27)
B0F_DA2D:
    lda $12
    cmp $16 ; current map X-pos (1)

    bne B0F_DA39
    lda $13
    cmp $17 ; current map Y-pos (1)

; control flow target (from $DA43, $DA5D, $DA71, $DA88)
B0F_DA37:
    beq B0F_D9F9
; control flow target (from $DA31)
B0F_DA39:
    lda $12
    cmp $28 ; current map X-pos (2)

    bne B0F_DA45
    lda $13
    cmp $29 ; current map Y-pos (2)

    beq B0F_DA37
; control flow target (from $DA3D)
B0F_DA45:
    lda $17 ; current map Y-pos (1)

    clc
    adc $0545 ; NPC #$01 ?

    sta $0F
    lda $16 ; current map X-pos (1)

    clc
    adc $0544 ; NPC #$01 ?

    sta $0E
    cmp $12
    bne B0F_DA5F
    lda $0F
    cmp $13
    beq B0F_DA37
; control flow target (from $DA57)
B0F_DA5F:
    lda $0E
    clc
    adc $054C ; NPC #$02 ?

    cmp $12
    bne B0F_DA73
    lda $0F
    clc
    adc $054D ; NPC #$02 ?

    cmp $13
    beq B0F_DA37
; control flow target (from $DA67)
B0F_DA73:
    ldy #$18
; control flow target (from $DA91)
B0F_DA75:
    lda $0541,Y ; NPC #$00 sprite ID

    cmp #$FF
    beq B0F_DA8A
    lda $053C,Y ; NPC #$00 ?

    cmp $12
    bne B0F_DA8A
    lda $053D,Y ; NPC #$00 ?

    cmp $13
    beq B0F_DA37
; control flow target (from $DA7A, $DA81)
B0F_DA8A:
    tya
    clc
    adc #$08
    tay
    cmp #$B8
    bne B0F_DA75
    lda $0D
    pha
    lda $12
    sta $0C
    lda $13
    sta $0E
    jsr $DF89
    jsr $E222
    pla
    cmp $0D
; control flow target (from $DABA)
B0F_DAA7:
    bne B0F_DA2B
    jsr $DF4A
    ldy #$04
    lda ($10),Y
    and #$F0
    beq B0F_DABC
    cmp #$10
    beq B0F_DABC
    cmp #$20
    bne B0F_DAA7
; control flow target (from $D999, $DAB2, $DAB6)
B0F_DABC:
    lda $0540,X ; NPC #$00 ? + direction nybble

    ora #$08
    sta $0540,X ; NPC #$00 ? + direction nybble

; control flow target (from $D92C)
    lda $0540,X ; NPC #$00 ? + direction nybble

    and #$08
    beq B0F_DB29
    lda $35 ; flag indicating whether any menu is currently open

    bne B0F_DB29
    lda $0540,X ; NPC #$00 ? + direction nybble

    and #$03
    bne B0F_DAEB
    lda $053F,X ; NPC #$00 ?

    sec
    sbc #$01
    and #$0F
    sta $053F,X ; NPC #$00 ?

    cmp #$0F
    bne B0F_DB29
    dec $053D,X ; NPC #$00 ?

    jmp $DB29

; control flow target (from $DAD4)
B0F_DAEB:
    cmp #$01
    bne B0F_DB01
    lda $053E,X ; NPC #$00 ?

    clc
    adc #$01
    and #$0F
    sta $053E,X ; NPC #$00 ?

    bne B0F_DB29
    inc $053C,X ; NPC #$00 ?

    bne B0F_DB29
; control flow target (from $DAED)
B0F_DB01:
    cmp #$02
    bne B0F_DB17
    lda $053F,X ; NPC #$00 ?

    clc
    adc #$01
    and #$0F
    sta $053F,X ; NPC #$00 ?

    bne B0F_DB29
    inc $053D,X ; NPC #$00 ?

    bne B0F_DB29
; control flow target (from $DB03)
B0F_DB17:
    lda $053E,X ; NPC #$00 ?

    sec
    sbc #$01
    and #$0F
    sta $053E,X ; NPC #$00 ?

    cmp #$0F
    bne B0F_DB29
    dec $053C,X ; NPC #$00 ?

; control flow target (from $D921, $D94C, $D980, $DAC9, $DACD, $DAE3, $DAE8, $DAFA, $DAFF, $DB10, $DB15, $DB24)
B0F_DB29:
    txa
    clc
    adc #$08
    tax
    dec $34
    beq B0F_DB35
    jmp $D91A

; control flow target (from $D907, $DB30)
B0F_DB35:
    ldx $3A
; control flow target (from $DBB3)
    lda $0541,X ; NPC #$00 sprite ID

    cmp #$FF
    beq B0F_DB9E
    jsr $DC33
    lda $0E
    clc
    adc #$07
    sta $0E
    lda $0F
    adc #$00
    beq B0F_DB58
    cmp #$01
    bne B0F_DB9E
    lda $0E
    cmp #$07
    bcs B0F_DB9E
; control flow target (from $DB4C)
B0F_DB58:
    jsr $DC65
    lda $10
    clc
    adc #$0D
    lda $11
    adc #$00
    bne B0F_DB9E
    jsr $DBF8
    jsr $DC03
    lda $11
    beq B0F_DB74
    lda $10
    bne B0F_DB9E
; control flow target (from $DB6E)
B0F_DB74:
    jsr $E218
    lda $0D
    cmp $1D
    bne B0F_DB9E
    lda $6148
    sta $0E
    lda $6149
    sta $0F
    lda $614A
    sta $10
    lda $614B
    sta $11
    txa
    tay
    jsr $DDCB
    jsr $F775 ; load ROM bank #$03

    jsr $DCDD
    tya
    tax
; control flow target (from $DB3C, $DB50, $DB56, $DB64, $DB72, $DB7B)
B0F_DB9E:
    txa
    clc
    adc #$08
    tax
    cpx #$B8
    bne B0F_DBA9
    ldx #$18
; control flow target (from $DBA5)
B0F_DBA9:
    cpx $3A
    beq B0F_DBB6
    lda $37
    cmp #$0D
    beq B0F_DBB6
    jmp $DB37

; control flow target (from $D900, $DBAB, $DBB1)
B0F_DBB6:
    stx $3A
    lda $03 ; game clock?

    and #$0F
    bne B0F_DBD0
    lda $38
    bmi B0F_DBD0
    inc $38
    inc $38
    lda $38
    cmp #$0A
    bcc B0F_DBD0
    lda #$00
    sta $38
; control flow target (from $DBBC, $DBC0, $DBCA)
B0F_DBD0:
    rts

; control flow target (from $D899, $D89E)
    jsr $DBD4
; control flow target (from $DBD1)
    lda $053A,Y
    clc
    adc $053E,Y ; NPC #$00 ?

    sta $053A,Y
    iny
    rts

; control flow target (from $D8B0, $D8BC)
    jsr $DBE3
; control flow target (from $DBE0)
    lda $0546,Y ; NPC #$01 ?

    sec
    sbc $053E,Y ; NPC #$00 ?

    clc
    adc $0544,Y ; NPC #$01 ?

    sta $0544,Y ; NPC #$01 ?

    lda #$00
    sta $053E,Y ; NPC #$00 ?

    iny
    rts

; control flow target (from $D9AF, $DB66)
    lda $053C,X ; NPC #$00 ?

    sta $12
    lda $053D,X ; NPC #$00 ?

    sta $13
    rts

; control flow target (from $D9B2, $DA22, $DB69)
    lda #$00
    sta $11
    lda $12
    sec
    sbc $16 ; current map X-pos (1)

    clc
    adc #$08
    sta $0C
    cmp #$10
    bcc B0F_DC16
    rts

; control flow target (from $DC13)
B0F_DC16:
    lda $13
    sec
    sbc $17 ; current map Y-pos (1)

    clc
    adc #$07
    sta $0E
    cmp #$0F
    bcc B0F_DC25
    rts

; control flow target (from $DC22)
B0F_DC25:
    jsr $DE31
    ldy #$00
    lda ($07),Y
    sta $10
    lda #$FF
    sta $11
    rts

; control flow target (from $DB3E)
    lda $053C,X ; NPC #$00 ?

    sta $0F
    lda #$00
    lsr $0F
    ror
    lsr $0F
    ror
    lsr $0F
    ror
    lsr $0F
    ror
    ora $053E,X ; NPC #$00 ?

    sec
    sbc $2A ; current map X-pos pixel, low byte

    eor #$80
    sta $0E
    lda $0F
    sbc $2B ; current map X-pos pixel, high byte

    sta $0F
    lda $0E
    sta $6148
    bmi B0F_DC5F
    inc $0F
; control flow target (from $DC5B)
B0F_DC5F:
    lda $0F
    sta $6149
    rts

; control flow target (from $DB58)
    lda $053D,X ; NPC #$00 ?

    sta $11
    lda #$00
    lsr $11
    ror
    lsr $11
    ror
    lsr $11
    ror
    lsr $11
    ror
    ora $053F,X ; NPC #$00 ?

    sec
    sbc $2C ; current map Y-pos pixel, low byte

    sta $10
    lda $11
    sbc $2D ; current map Y-pos pixel, high byte

    sta $11
    lda $10
    clc
    adc #$6F
    sta $10
    sta $614A
    bcc B0F_DC94
    inc $11
; control flow target (from $DC90)
B0F_DC94:
    lda $11
    sta $614B
    rts

; control flow target (from $D8E9, $D8F0, $D8F7)
    txa
    pha
    jsr $F775 ; load ROM bank #$03

    pla
    tax
    lda $053A,Y
    ora $053B,Y
    beq B0F_DCCC
    lda $053A,Y
    lsr
    lsr
    lsr
    lsr
    sta $0C
    lda $053B,Y
    lsr
    lsr
    lsr
    lsr
    sta $0E
    inc $0E
    jsr $DE31
    sty $0C
    ldy #$00
    lda ($07),Y
    ldy $0C
    cmp #$00
    beq B0F_DCCD
; control flow target (from $DCA7)
B0F_DCCC:
    rts

; control flow target (from $DCCA)
B0F_DCCD:
    lda $053A,Y
    sta $0E
    lda $053B,Y
    sta $10
    lda #$00
    sta $0F
    sta $11
; control flow target (from $DB99)
    jsr $DD3F
    tya
    pha
    lda #$00
    tay
    lda $1F ; some kind of map type (#$00: World Map, #$01: other non-dungeon maps, #$02: maps #$2B - #$43 inclusive, #$03: maps >= #$44, #$FF => game menu)

    beq B0F_DCEB
    lda #$FC
; control flow target (from $DCE7)
B0F_DCEB:
    sta $0C
; control flow target (from $DD38)
B0F_DCED:
    lda #$00
    sta $0D
; control flow target (from $DD2D)
B0F_DCF1:
    lda $0E
    clc
    adc $0D
    sta $0203,X
    lda $0F
    adc #$00
    bne B0F_DD22
    lda $10
    clc
    adc $0C
    sta $0200,X ; sprite buffer start

    lda ($12),Y
    sta $0201,X
    iny
    lda $6D
    cmp #$03
    bcs B0F_DD18
    jsr $DD75
    bcs B0F_DD1A
; control flow target (from $DD11)
B0F_DD18:
    lda ($12),Y
; control flow target (from $DD16)
B0F_DD1A:
    dey
    sta $0202,X
    inx
    inx
    inx
    inx
; control flow target (from $DCFD)
B0F_DD22:
    iny
    iny
    lda $0D
    clc
    adc #$08
    sta $0D
    cmp #$10
    bne B0F_DCF1
    lda $0C
    clc
    adc #$08
    sta $0C
    cmp #$0C
    bcc B0F_DCED
    pla
    tay
    rts


; code -> data
; data load target (from $DD65)
; data load target (from $DD6D)
.byte $F7

.byte $B8
; data -> code
; control flow target (from $DCDD)
    lda #$00
    sta $13
    lda $0540,Y ; NPC #$00 ? + direction nybble

    and #$03
    sta $12
    lda $0541,Y ; NPC #$00 sprite ID

    sta $6D
    asl
    asl
    ora $12
    asl
    asl
    asl
    rol $13
    asl
    rol $13
    sta $12
    lda $36
    and #$08
    ora $12
    sta $12
    lda $DD3D
    clc
    adc $12
    sta $12
    lda $DD3E
    adc $13
    sta $13
    rts

; control flow target (from $DD13)
    pha
    lda $61AD
    bne B0F_DDC0
    pla
    bne B0F_DD8C
    lda $062D ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    and #$04
    beq B0F_DDAA
    lda $062D ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    bpl B0F_DDAC
    clc
    rts

; control flow target (from $DD7C)
B0F_DD8C:
    cmp #$02
    beq B0F_DD9E
    lda $063F ; Cannock status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    and #$04
    beq B0F_DDAA
    lda $063F ; Cannock status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    bpl B0F_DDAC
    clc
    rts

; control flow target (from $DD8E)
B0F_DD9E:
    lda $0651 ; Moonbrooke status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    and #$04
    beq B0F_DDAA
    lda $0651 ; Moonbrooke status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    bpl B0F_DDAC
; control flow target (from $DD83, $DD95, $DDA3, $DDC5)
B0F_DDAA:
    clc
    rts

; control flow target (from $DD88, $DD9A, $DDA8)
B0F_DDAC:
    lda $27 ; map palette; offset from ($E27C)

    cmp #$68
    beq B0F_DDB8
    lda ($12),Y
    and #$FC
    sec
    rts

; control flow target (from $DDB0)
B0F_DDB8:
    lda ($12),Y
    and #$FC
    ora #$03
    sec
    rts

; control flow target (from $DD79)
B0F_DDC0:
    pla
    beq B0F_DDC7
    cmp #$01
    bne B0F_DDAA
; control flow target (from $DDC1)
B0F_DDC7:
    lda #$03
    sec
    rts

; control flow target (from $DB93)
    inc $39
    lda $39
    cmp #$0D
    bcc B0F_DDD7
    lda #$00
    sta $39
; control flow target (from $DDD1)
B0F_DDD7:
    clc
    adc $37
    tax
    lda $DDE2,X
    tax
    inc $37
    rts


; code -> data
; indexed data load target (from $DDDB)
; indirect data load target
.byte $90,$40,$E0,$30,$80,$D0,$10,$C0,$70,$20,$F0,$60
.byte $A0,$90,$40,$E0,$30,$80
.byte $D0,$10,$C0
.byte $70,$20
.byte $F0
; indirect data load target
.byte $60

.byte $A0
; data -> code
; control flow target (from $D654)
    asl $0C
    asl $0E
; control flow target (from $EB07)
; external control flow target (from $02:$B119)
    lda $0E
    sta $08
    lda #$00
    lsr $08
    ror
    lsr $08
    ror
    lsr $08
    ror
    sta $07
    lda $0C
    and #$1F
    clc
    adc $07
    sta $07
    php
    lda $0C
    and #$20
    bne B0F_DE25
    lda #$20
    bne B0F_DE27
; control flow target (from $DE1F)
B0F_DE25:
    lda #$24
; control flow target (from $DE23)
B0F_DE27:
    plp
    adc $08
    sta $08
    rts

; control flow target (from $D082, $F441)
    lsr $0C
    lsr $0E
; control flow target (from $DC25, $DCBD, $F7E3)
    lda $0E
    asl
    asl
    asl
    asl
    adc $0C
    sta $07
    lda #$04
    sta $08
    rts

; control flow target (from $DE68, $DEA0)
    asl $0C
    asl $0E
; control flow target (from $DE6E, $DEA6)
    lda $0E
    and #$FC
    asl
    sta $07
    lda $0C
    and #$1F
    lsr
    lsr
    clc
    adc $07
    clc
    adc #$C0
    sta $07
    lda $0C
    and #$20
    bne B0F_DE63
    lda #$03
    bne B0F_DE65
; control flow target (from $DE5D)
B0F_DE63:
    lda #$07
; control flow target (from $DE61)
B0F_DE65:
    sta $08
    rts

    jsr $DE40
    jmp $DE71

; control flow target (from $DF2F, $EADF)
; external control flow target (from $04:$8D88)
    jsr $DE44
; control flow target (from $DE6B)
    tya
    pha
    lda $0E
    and #$02
    asl
    sta $0D
    lda $0C
    and #$02
    clc
    adc $0D
    tay
    lda #$FC
    cpy #$00
    beq B0F_DE8F
; control flow target (from $DE8D)
B0F_DE88:
    sec
    rol
    asl $09
    dey
    bne B0F_DE88
; control flow target (from $DE86)
B0F_DE8F:
    and ($07),Y
    ora $09
    sta ($07),Y
    sta $09
    pla
    tay
    rts

; control flow target (from $E71C, $E81A)
    jsr $DF62
    jmp $DEA6

    jsr $DE40
    jmp $DEA9

; control flow target (from $DE9D)
    jsr $DE44
; control flow target (from $DEA3)
    tya
    pha
    ldy #$00
    lda ($07),Y
    sta $09
    pla
    tay
    lda $08
    clc
    adc #$20
    sta $08
    jmp $C1FA ; wait for $02 to not be #$C0, write PPU address in $07-$08 and data in $09 to PPU write buffer at $0300,$02, $01 += 1, $02 += 3, and set $0183 to #$00



; code -> data
; indexed data load target (from $DF54, $DF5A, $E951, $E957)
; indirect data load target
.byte $CB,$83,$6B
.byte $84,$33
.byte $85

.byte $FB
.byte $85
; data -> code
; control flow target (from $CAE1, $D092, $D0DF, $D256, $D325, $E2C5, $E2D7, $E5F5, $E669, $E6F5, $E74C, $E7F3, $E84A)
    jsr $EAFC
    bcc B0F_DECB
    rts

; control flow target (from $DEC8)
B0F_DECB:
    jsr $DF4A
    jsr $F770 ; load ROM bank #$02

    ldy #$00
    lda ($10),Y
    sta $09
    jsr $C1FA ; wait for $02 to not be #$C0, write PPU address in $07-$08 and data in $09 to PPU write buffer at $0300,$02, $01 += 1, $02 += 3, and set $0183 to #$00

    lda $1C
    lsr
    bcc B0F_DEE2
    jsr $DF41
; control flow target (from $DEDD)
B0F_DEE2:
    iny
    lda ($10),Y
    sta $09
    jsr $C1FA ; wait for $02 to not be #$C0, write PPU address in $07-$08 and data in $09 to PPU write buffer at $0300,$02, $01 += 1, $02 += 3, and set $0183 to #$00

    lda $1C
    and #$02
    beq B0F_DEF3
    jsr $DF41
; control flow target (from $DEEE)
B0F_DEF3:
    iny
    lda $07
    clc
    adc #$1E
    sta $07
    bcc B0F_DEFF
    inc $08
; control flow target (from $DEFB)
B0F_DEFF:
    lda ($10),Y
    sta $09
    jsr $C1FA ; wait for $02 to not be #$C0, write PPU address in $07-$08 and data in $09 to PPU write buffer at $0300,$02, $01 += 1, $02 += 3, and set $0183 to #$00

    lda $1C
    and #$04
    beq B0F_DF0F
    jsr $DF41
; control flow target (from $DF0A)
B0F_DF0F:
    iny
    lda ($10),Y
    sta $09
    jsr $C1FA ; wait for $02 to not be #$C0, write PPU address in $07-$08 and data in $09 to PPU write buffer at $0300,$02, $01 += 1, $02 += 3, and set $0183 to #$00

    lda $1C
    and #$08
    beq B0F_DF20
    jsr $DF41
; control flow target (from $DF1B)
B0F_DF20:
    iny
    lda ($10),Y
    and #$03
    sta $09
    lda $1A
    sta $0C
    lda $1B
    sta $0E
    jsr $DE6E
    lda $1E
    bne B0F_DF40
    lda $08
    clc
    adc #$20
    sta $08
    jsr $C1FA ; wait for $02 to not be #$C0, write PPU address in $07-$08 and data in $09 to PPU write buffer at $0300,$02, $01 += 1, $02 += 3, and set $0183 to #$00

; control flow target (from $DF34)
B0F_DF40:
    rts

; control flow target (from $DEDF, $DEF0, $DF0C, $DF1D)
    dec $02
    dec $02
    dec $02
    dec $01
    rts

; control flow target (from $D366, $DAA9, $DECB, $E3E5)
    lda $1F ; some kind of map type (#$00: World Map, #$01: other non-dungeon maps, #$02: maps #$2B - #$43 inclusive, #$03: maps >= #$44, #$FF => game menu)

    asl
    tay
    lda $0C
    asl
    asl
    adc $0C
    adc $DEBD,Y
    sta $10
    iny
    lda $DEBD,Y
    adc #$00
    sta $11
    rts

; control flow target (from $DE9A, $EAFC)
; external control flow target (from $02:$B116)
    lda $15
    asl
    clc
    adc $19
    clc
    adc #$1E
    sta $0C
    lda #$1E
    sta $0E
    jsr $C393
    sta $0E
    lda $14
    asl
    clc
    adc $18
    and #$3F
    sta $0C
    rts


; code -> data
; data load target (from $E0CB)
; data load target (from $E0D2)
.byte $95

.byte $9D
; data -> code
; external control flow target (from $02:$B266)
    jsr $DF89
    jmp $F770 ; load ROM bank #$02


; control flow target (from $CFA8, $D0A3, $D363, $D680, $DA9E, $DF83, $E3E2, $EB20, $F95D)
    lda $1F ; some kind of map type (#$00: World Map, #$01: other non-dungeon maps, #$02: maps #$2B - #$43 inclusive, #$03: maps >= #$44, #$FF => game menu)

    cmp #$02
    bcc B0F_DFA7
    lda $0E
    pha
    lda $0C
    pha
    lsr $0C
    lsr $0E
    jsr $DFA7
    pla
    lsr
    pla
    rol
    and #$03
    ora $0C
    sta $0C
    rts

; control flow target (from $DF8D, $DF99)
B0F_DFA7:
    lda $0C
    sta $12
    lda $0E
    sta $13
    lda $21 ; map width

    cmp $0C
    bcs B0F_DFBA
; control flow target (from $DFBE)
B0F_DFB5:
    lda $20 ; map exterior border tile ID (#$00 = Road, #$01 = Grass, #$02 = Sand, #$03 = Tree, #$04 = Water, #$05 = Vertical Wall, #$06 = Shrub, #$07 = Horizontal Wall, #$08 = Swamp, ..., #$20 = Ceiling Alternating?, #$21 = Ceiling Down?, #$24 = Black?, #$28 = Blue?)

    sta $0C
    rts

; control flow target (from $DFB3)
B0F_DFBA:
    lda $22 ; map height

    cmp $0E
    bcc B0F_DFB5
    tya
    pha
    lda $1F ; some kind of map type (#$00: World Map, #$01: other non-dungeon maps, #$02: maps #$2B - #$43 inclusive, #$03: maps >= #$44, #$FF => game menu)

    beq B0F_DFC9
    jmp $E169

; control flow target (from $DFC4)
B0F_DFC9:
    jsr $F775 ; load ROM bank #$03

    lda $D0 ; Malroth status flag (#$FF = defeated, #$00 = alive, others = countdown to battle)

    beq B0F_DFE9
    lda $12
    cmp #$5E
    bcc B0F_DFE9
    cmp #$60
    bcs B0F_DFE9
    lda $13
    cmp #$A4
    bcc B0F_DFE9
    cmp #$A6
    bcs B0F_DFE9
    lda #$02
    jmp $E087

; control flow target (from $DFCE, $DFD4, $DFD8, $DFDE, $DFE2)
B0F_DFE9:
    lda $CE ; Tuhn Watergate open flag (#$00 = closed, #$01 = open)

    beq B0F_E000
    lda $12
    cmp #$44
    bne B0F_E000
    lda $13
    cmp #$86
    bcc B0F_E000
    cmp #$89
    bcs B0F_E000
    jmp $E085

; control flow target (from $DFEB, $DFF1, $DFF7, $DFFB)
B0F_E000:
    lda $05F9 ; flag for Cave to Rhone open

    bne B0F_E015
    lda $12
    cmp #$73
    bne B0F_E015
    lda $13
    cmp #$C5
    bne B0F_E015
    lda #$05
    bne B0F_E087
; control flow target (from $E003, $E009, $E00F)
B0F_E015:
    jsr $E0C0
    cmp #$04
    beq B0F_E01F
    pla
    tay
    rts

; control flow target (from $E01A)
B0F_E01F:
    ldy #$00
    sty $D4
    sty $05F4
; control flow target (from $E057)
B0F_E026:
    lda $E0B4,Y
    clc
    adc $12
    sta $0C
    lda $E0B8,Y
    clc
    adc $13
    sta $0E
    jsr $E0C0
    cmp #$04
    beq B0F_E04F
    cmp #$09
    beq B0F_E04F
    cmp #$0D
    beq B0F_E04F
    ldy $05F4
    lda $E0BC,Y
    ora $D4
    sta $D4
; control flow target (from $E03B, $E03F, $E043)
B0F_E04F:
    inc $05F4
    ldy $05F4
    cpy #$04
    bne B0F_E026
    ldy $D4
    lda $E08C,Y
    sta $D4
    bmi B0F_E085
    cmp #$15
    bcs B0F_E087
    tay
    lda $E09C,Y
    clc
    adc $12
    sta $0C
    lda $E0A4,Y
    clc
    adc $13
    sta $0E
    jsr $E0C0
    cmp #$04
    bne B0F_E085
    ldy $D4
    lda $E0AC,Y
    bne B0F_E087
; control flow target (from $DFFD, $E060, $E07C, $E191)
B0F_E085:
    lda #$04
; control flow target (from $DFE6, $E013, $E064, $E083, $E174)
B0F_E087:
    sta $0C
    pla
    tay
    rts


; code -> data
; indexed data load target (from $E05B)
; indirect data load target
.byte $FF,$04,$05,$00,$06,$FF
.byte $01,$FF,$07
.byte $02
.byte $FF
; indirect data load target
.byte $FF,$03
.byte $FF
.byte $FF
; indexed data load target (from $E067)
.byte $FF
; indexed data load target (from $E06F)
.byte $FF,$FF,$01,$01
.byte $01,$FF
.byte $FF
.byte $01
; indexed data load target (from $E080)
.byte $01,$FF,$01,$FF
.byte $01,$01
.byte $FF
.byte $FF
; indexed data load target (from $E026)
.byte $16,$1B,$14,$19
.byte $15,$18
.byte $1A
.byte $17
; indexed data load target (from $E02E)
.byte $00,$01
.byte $00
.byte $FF
; indexed data load target (from $E048)
.byte $FF,$00
.byte $01
.byte $00

.byte $01,$02
.byte $04
.byte $08
; data -> code
; control flow target (from $E015, $E036, $E077)
; indirect data load target
; WARNING! $E0C0 was also seen as data
; WARNING! $E0C1 was also seen as data
    lda #$00
    sta $0F
    asl $0E
    rol $0F
    lda $0E
    clc
    adc $DF81
    sta $0E
    lda $0F
    adc $DF82
    sta $0F
    ldy #$00
    lda ($0E),Y
    sta $10
    iny
    lda ($0E),Y
    sta $11
    lda $0C
    cmp #$80
    bcc B0F_E112
    eor #$FF
    sta $0C
    iny
    lda ($0E),Y
    clc
    sbc $10
    tay
    lda #$00
    sta $0D
; control flow target (from $E10F)
    lda ($10),Y
    inc $0D
    and #$E0
    beq B0F_E108
    lda ($10),Y
    and #$1F
    clc
    adc $0D
    sta $0D
; control flow target (from $E0FD)
B0F_E108:
    lda $0C
    cmp $0D
    bcc B0F_E130
    dey
    jmp $E0F7

; control flow target (from $E0E6)
B0F_E112:
    dey
    sty $0D
; control flow target (from $E12D)
    lda ($10),Y
    inc $0D
    and #$E0
    beq B0F_E126
    lda ($10),Y
    and #$1F
    clc
    adc $0D
    sta $0D
; control flow target (from $E11B)
B0F_E126:
    lda $0C
    cmp $0D
    bcc B0F_E130
    iny
    jmp $E115

; control flow target (from $E10C, $E12A)
B0F_E130:
    lda ($10),Y
    and #$E0
    bne B0F_E162
    lda ($10),Y
    and #$1F
; control flow target (from $E167)
B0F_E13A:
    sta $0C
    lda $05F8 ; Sea Cave shoal status (#$00 = shoals up, others = shoals down)

    beq B0F_E15F
    lda $12
    cmp #$B2
    bcc B0F_E15F
    cmp #$B9
    bcs B0F_E15F
    lda $13
    cmp #$A3
    bcc B0F_E15F
    cmp #$AC
    bcs B0F_E15F
    lda $0C
    cmp #$13
    bcc B0F_E15F
    lda #$04
    sta $0C
; control flow target (from $E13F, $E145, $E149, $E14F, $E153, $E159)
B0F_E15F:
    lda $0C
    rts

; control flow target (from $E134)
B0F_E162:
    lsr
    lsr
    lsr
    lsr
    lsr
    bcc B0F_E13A
; control flow target (from $DFC6)
    jsr $F770 ; load ROM bank #$02

    lda $D0 ; Malroth status flag (#$FF = defeated, #$00 = alive, others = countdown to battle)

    bmi B0F_E177
    beq B0F_E177
    lda #$17
    jmp $E087

; control flow target (from $E16E, $E170)
B0F_E177:
    lda $31 ; current map ID

    cmp #$12 ; Map ID #$12: Tuhn Watergate

    bne B0F_E194
    lda $CE ; Tuhn Watergate open flag (#$00 = closed, #$01 = open)

    beq B0F_E194
    lda $13
    cmp #$05
    bne B0F_E194
    lda $12
    cmp #$02
    beq B0F_E191
    cmp #$03
    bne B0F_E194
; control flow target (from $E18B)
B0F_E191:
    jmp $E085

; control flow target (from $E17B, $E17F, $E185, $E18F)
B0F_E194:
    lda #$00
    sta $0D
    sta $0F
    ldy $21 ; map width

    iny
    sty $0C
    jsr $C339 ; 16-bit multiplication: ($10-$11) = ($0C-$0D) * ($0E-$0F); consumes $0C-$0F

    lda $12
    clc
    adc $10
    sta $10
    sta $0E
    lda $11
    adc #$00
    sta $0F
    clc
    adc #$78
    sta $11
    ldy #$00
    lda $1F ; some kind of map type (#$00: World Map, #$01: other non-dungeon maps, #$02: maps #$2B - #$43 inclusive, #$03: maps >= #$44, #$FF => game menu)

    cmp #$02
    bcs B0F_E1C5
    lda ($10),Y
    and #$1F
    jmp $E1CB

; control flow target (from $E1BC)
B0F_E1C5:
    lda ($10),Y
    and #$1F
    asl
    asl
; control flow target (from $E1C2)
    sta $0C
    cmp #$14
    bne B0F_E1EF
    ldy #$00
; control flow target (from $E1ED)
B0F_E1D3:
    lda $12
    cmp $051A,Y ; something to do with whether you've opened the chest containing the Shield of Erdrick

    bne B0F_E1E9
    iny
    lda $13
    cmp $051A,Y ; something to do with whether you've opened the chest containing the Shield of Erdrick

    bne B0F_E1EA
; control flow target (from $E20E)
B0F_E1E2:
    lda #$00
    sta $0C
; control flow target (from $E1FB, $E216)
B0F_E1E6:
    pla
    tay
    rts

; control flow target (from $E1D8)
B0F_E1E9:
    iny
; control flow target (from $E1E0)
B0F_E1EA:
    iny
    cpy #$10
    bne B0F_E1D3
; control flow target (from $E1CF)
B0F_E1EF:
    lda $0C
    cmp #$18
    beq B0F_E1FD
    cmp #$19
    beq B0F_E1FD
    cmp #$1A
    bne B0F_E1E6
; control flow target (from $E1F3, $E1F7)
B0F_E1FD:
    ldy #$00
; control flow target (from $E214)
B0F_E1FF:
    lda $12
    cmp $052A,Y
    bne B0F_E210
    iny
    lda $13
    cmp $052A,Y
    bne B0F_E211
    beq B0F_E1E2
; control flow target (from $E204)
B0F_E210:
    iny
; control flow target (from $E20C)
B0F_E211:
    iny
    cpy #$10
    bne B0F_E1FF
    beq B0F_E1E6
; control flow target (from $D9BD, $DB74, $E882, $E92D)
    lda $1F ; some kind of map type (#$00: World Map, #$01: other non-dungeon maps, #$02: maps #$2B - #$43 inclusive, #$03: maps >= #$44, #$FF => game menu)

    cmp #$02
    bcc B0F_E222
    lsr $12
    lsr $13
; control flow target (from $DAA1, $E21C, $E3F3, $EB23, $F960)
B0F_E222:
    lda $25 ; map header byte 5

    ora $26 ; map header byte 6, always #$00

    bne B0F_E22D
; control flow target (from $E231, $E237)
B0F_E228:
    lda #$00
    sta $0D
    rts

; control flow target (from $E226)
B0F_E22D:
    lda $21 ; map width

    cmp $12
    bcc B0F_E228
    lda $22 ; map height

    cmp $13
    bcc B0F_E228
    tya
    pha
    txa
    pha
    ldx $21 ; map width

    inx
    stx $74
    lda #$00
    sta $72
    ldx #$78
    ldy $13
    beq B0F_E259
; control flow target (from $E257)
B0F_E24C:
    lda $72
    clc
    adc $74
    sta $72
    bcc B0F_E256
    inx
; control flow target (from $E253)
B0F_E256:
    dey
    bne B0F_E24C
; control flow target (from $E24A)
B0F_E259:
    stx $73
    ldy $12
    lda ($72),Y
    lsr
    lsr
    lsr
    lsr
    lsr
    sta $0D
    pla
    tax
    pla
    tay
    rts


; code -> data
; indirect data load target (via $E278)
; indirect data load target
.byte $0F
; indirect data load target
.byte $36
; indirect data load target
.byte $30
; indirect data load target
.byte $11
; indirect data load target
.byte $36
; indirect data load target
.byte $19
; indirect data load target
.byte $16
; indirect data load target
.byte $36
; indirect data load target
.byte $30
; indirect data load target
.byte $13
; indirect data load target
.byte $01
; indirect data load target
.byte $01
; data load target (from $E30D)
.byte $01
; data load target (from $E312)
.byte $6B
; data load target (from $E302)
.byte $E2
; data load target (from $E307)
.byte $84
; data load target (from $E319)
.byte $BC
; data load target (from $E321)
.byte $91

.byte $BC
; data -> code
    jsr $C42A
; control flow target (from $D2B3)
    jsr $C465 ; wait for interrupt and then set every 4th byte of $0200 - $02FC to #$F0

    jmp $E290

; control flow target (from $D866)
    jsr $C42A
; control flow target (from $C7E9)
    jsr $C465 ; wait for interrupt and then set every 4th byte of $0200 - $02FC to #$F0

    jsr $E3FD
; control flow target (from $E284)
    jsr $E3CC
    lda $31 ; current map ID

    cmp #$01 ; Map ID #$01: World Map

    bne B0F_E2B1
    lda $16 ; current map X-pos (1)

    cmp #$54 ; Rhone region is from #$54 <= X-pos < #$90

    bcc B0F_E2B1
    cmp #$90
    bcs B0F_E2B1
    lda $17 ; current map Y-pos (1)

    cmp #$91 ; Rhone region is from #$91 <= Y-pos < #$BA

    bcc B0F_E2B1
    cmp #$BA
    bcs B0F_E2B1
    lda #$68 ; palette for Rhone region of Wolrd Map

    sta $27 ; map palette; offset from ($E27C)

; control flow target (from $E297, $E29D, $E2A1, $E2A7, $E2AB)
B0F_E2B1:
    jsr $E3DA
    lda #$F2
    sta $19
; control flow target (from $E2EC)
B0F_E2B8:
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    lda #$EE
    sta $18
; control flow target (from $E2CC)
B0F_E2BF:
    lda #$00
    sta $1C
    sta $1E
    jsr $DEC5
    inc $18
    inc $18
    bne B0F_E2BF
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

; control flow target (from $E2E2)
B0F_E2D1:
    lda #$00
    sta $1C
    sta $1E
    jsr $DEC5
    inc $18
    inc $18
    lda $18
    cmp #$12
    bne B0F_E2D1
    inc $19
    inc $19
    lda $19
    cmp #$10
    bne B0F_E2B8
    lda #$FF
    sta $35 ; flag indicating whether any menu is currently open

    jsr $D8CB
    lda #$00
    sta $35 ; flag indicating whether any menu is currently open

; control flow target (from $D153, $D18F)
    jsr $F775 ; load ROM bank #$03

    lda $27 ; map palette; offset from ($E27C)

    cmp #$68
    beq B0F_E30D
    lda $E27A
    sta $0E
    lda $E27B
    jmp $E317

; control flow target (from $E300)
B0F_E30D:
    lda $E278
    sta $0E
    lda $E279
    sta $0F ; useless op

; control flow target (from $E30A)
    sta $0F
    lda $E27C
    clc
    adc $27 ; map palette; offset from ($E27C)

    sta $10
    lda $E27D
    adc #$00
    sta $11
    lda #$FF
    sta $0D
    jsr $C2CD
; control flow target (from $D3C5, $D4A9)
    lda $1F ; some kind of map type (#$00: World Map, #$01: other non-dungeon maps, #$02: maps #$2B - #$43 inclusive, #$03: maps >= #$44, #$FF => game menu)

    bpl B0F_E337
    lda #$0C ; Music ID #$0C: game menu / Wellgarth singer BGM

    bne B0F_E37B
; control flow target (from $E331)
B0F_E337:
    bne B0F_E387
    lda $CF ; ship status (#$04 = on ship, #$02 = own ship, #$01 = beat Lianport Gremlins)

    and #$04
    beq B0F_E343
    lda #$16 ; Music ID #$16: sea BGM

    bne B0F_E37B
; control flow target (from $E33D)
B0F_E343:
    lda $16 ; current map X-pos (1)

    cmp #$20
    bcc B0F_E35B
    cmp #$57
    bcs B0F_E35B
    lda $17 ; current map Y-pos (1)

    cmp #$17
    bcc B0F_E35B
    cmp #$56
    bcs B0F_E35B
    lda #$0D ; Music ID #$0D: Tantegel BGM

    bne B0F_E37B
; control flow target (from $E347, $E34B, $E351, $E355)
B0F_E35B:
    ldy #$00
    sty $0C
; control flow target (from $E36D)
B0F_E35F:
    lda $062D,Y ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    bpl B0F_E366
    inc $0C
; control flow target (from $E362)
B0F_E366:
    tya
    clc
    adc #$12
    tay
    cmp #$36
    bcc B0F_E35F
    lda $0C
    cmp #$03
    beq B0F_E379
    lda #$15 ; Music ID #$15: small party BGM

    bne B0F_E37B
; control flow target (from $E373)
B0F_E379:
    lda #$14 ; Music ID #$14: full party BGM

; control flow target (from $E335, $E341, $E359, $E377, $E38D, $E395, $E3A4, $E3AC, $E3B1)
B0F_E37B:
    cmp $05F7 ; probably BGM for current area

    beq B0F_E386
    sta $05F7 ; probably BGM for current area

    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

; control flow target (from $E37E)
B0F_E386:
    rts

; control flow target (from $E337)
B0F_E387:
    cmp #$03
    bne B0F_E38F
    lda #$11 ; Music ID #$11: tower BGM

    bne B0F_E37B
; control flow target (from $E389)
B0F_E38F:
    cmp #$02
    bne B0F_E397
    lda #$10 ; Music ID #$10: cave BGM

    bne B0F_E37B
; control flow target (from $E391)
B0F_E397:
    ldx $31 ; current map ID

    cpx #$09 ; Map ID #$09: Moonbrooke

    bne B0F_E3A6
    lda $61AD
    beq B0F_E3A6
    lda #$0E ; Music ID #$0E: town music 1 BGM

    bne B0F_E37B
; control flow target (from $E39B, $E3A0)
B0F_E3A6:
    cpx #$19 ; Map ID #$19: Shrine NW of Midenhall

    bcc B0F_E3AE
    lda #$13 ; Music ID #$13: shrine BGM

    bne B0F_E37B
; control flow target (from $E3A8)
B0F_E3AE:
    lda $E3B3,X ; map BGM

    bne B0F_E37B

; code -> data
; map BGM
; indexed data load target (from $E3AE)

.byte $0E,$0E,$0E,$0E,$0E,$0F,$0E,$0F,$0F,$10,$10,$0F,$0E
.byte $0E,$0E,$0E,$0F,$0F,$0F
.byte $0F,$0F,$0F
.byte $10,$11
.byte $10
; data -> code
; control flow target (from $D6DA, $E290)
    lda #$00
    sta $3B ; high nybble = terrain ID

    sta $0159
    sta $015A
    sta $015B
    rts

; control flow target (from $E2B1)
    lda $16 ; current map X-pos (1)

    sta $0C
    lda $17 ; current map Y-pos (1)

    sta $0E
    jsr $DF89
    jsr $DF4A
    jsr $F770 ; load ROM bank #$02

    ldy #$04
    lda ($10),Y
    and #$F0
    sta $3C
    jsr $E222
    lda $0D
    sta $1D
    rts


; code -> data
; -> $02:$8018: map header info (exterior border tile ID, width, height, pointer low byte, pointer high byte, ?, ?, palette)
; data load target (from $E475)
; data load target (from $E47D)
.byte $18

.byte $80
; data -> code
; control flow target (from $E28D)
    lda $31 ; current map ID

    cmp #$01 ; Map ID #$01: World Map

    bne B0F_E407
    lda #$00 ; World Map uses #$00

    beq B0F_E419
; control flow target (from $E401)
B0F_E407:
    cmp #$2B ; Map ID #$2B: Cave to Hamlin

    bcs B0F_E40F
    lda #$01 ; other non-dungeon maps use #$01

    bne B0F_E419
; control flow target (from $E409)
B0F_E40F:
    cmp #$44 ; Map ID #$44: Hargon's Castle 2F

    bcs B0F_E417
    lda #$02 ; other maps up to #$44 use #$02

    bne B0F_E419
; control flow target (from $E411)
B0F_E417:
    lda #$03 ; maps >= #$44 use #$03

; control flow target (from $E405, $E40D, $E415)
B0F_E419:
    sta $1F ; some kind of map type (#$00: World Map, #$01: other non-dungeon maps, #$02: maps #$2B - #$43 inclusive, #$03: maps >= #$44, #$FF => game menu)

    sta $0C
    jsr $F75C ; load ROM bank #$00

; call to code in a different bank ($00:$8000)
    jsr $8000
    lda $31 ; current map ID

    bne B0F_E42B ; Map ID #$00: Fake Midenhall

    lda #$FF
    bne B0F_E432
; control flow target (from $E425)
B0F_E42B:
    lda $05FC
    beq B0F_E43B
    lda #$00
; control flow target (from $E429)
B0F_E432:
    sta $05FC
    jsr $F761 ; load ROM bank #$06

; call to code in a different bank ($06:$A319)
    jsr $A319 ; if $05FC is #$00, copy battle stats at $015D,Y to field stats at $0600,X, otherwise copy field stats at $0600,X to battle stats at $015D,Y

; control flow target (from $E42E)
B0F_E43B:
    lda #$04
    sta $0C
    jsr $F75C ; load ROM bank #$00

; call to code in a different bank ($00:$8000)
    jsr $8000
    jsr $F770 ; load ROM bank #$02

    lda $31 ; current map ID

    cmp #$01 ; Map ID #$01: World Map

    bne B0F_E451
    jsr $E5A2
; control flow target (from $E44C)
B0F_E451:
    lda #$08
    sta $14
    lda #$07
    sta $15
    lda #$00
    sta $05
    sta $06
    sta $04
; control flow target (from $E92A)
    jsr $F770 ; load ROM bank #$02

    lda #$00
    sta $0D ; multiplication high byte

    sta $0F ; multiplication high byte

    lda $31 ; current map ID

    sta $0C ; multiplication low byte

    lda #$08
    sta $0E ; multiplication low byte

    jsr $C339 ; 16-bit multiplication: ($10-$11) = ($0C-$0D) * ($0E-$0F); consumes $0C-$0F

    lda $E3FB ; -> $02:$8018: map header info (exterior border tile ID, width, height, pointer low byte, pointer high byte, ?, ?, palette)

    clc
    adc $10 ; add low byte of map ID * 8

    sta $10
    lda $E3FC
    adc $11 ; add high byte of map ID * 8

    sta $11
    ldy #$00
; control flow target (from $E48E)
B0F_E486:
    lda ($10),Y
    sta $0020,Y ; map exterior border tile ID (#$00 = Road, #$01 = Grass, #$02 = Sand, #$03 = Tree, #$04 = Water, #$05 = Vertical Wall, #$06 = Shrub, #$07 = Horizontal Wall, #$08 = Swamp, ..., #$20 = Ceiling Alternating?, #$21 = Ceiling Down?, #$24 = Black?, #$28 = Blue?)

    iny
    cpy #$08 ; copy 8 byte map header to $20

    bne B0F_E486
    lda $61AD
    beq B0F_E4A9
    lda $31 ; current map ID

    cmp #$09 ; Map ID #$09: Moonbrooke

    bne B0F_E4A9
    lda $86D7 ; -> $02:$A201: Map ID #$6D: Moonbrooke (prologue)

    sta $23 ; map pointer, low byte

    lda $86D8
    sta $24 ; map pointer, high byte

    lda #$02
    sta $20 ; map exterior border tile ID (#$00 = Road, #$01 = Grass, #$02 = Sand, #$03 = Tree, #$04 = Water, #$05 = Vertical Wall, #$06 = Shrub, #$07 = Horizontal Wall, #$08 = Swamp, ..., #$20 = Ceiling Alternating?, #$21 = Ceiling Down?, #$24 = Black?, #$28 = Blue?)

; control flow target (from $E493, $E499)
B0F_E4A9:
    lda $1F ; some kind of map type (#$00: World Map, #$01: other non-dungeon maps, #$02: maps #$2B - #$43 inclusive, #$03: maps >= #$44, #$FF => game menu)

    beq B0F_E4B0
; call to code in a different bank ($02:$AB89)
    jsr $AB89
; control flow target (from $E4AB)
B0F_E4B0:
    lda $31 ; current map ID

    cmp #$12 ; Map ID #$12: Tuhn Watergate

    bne B0F_E4BE
    lda $CE ; Tuhn Watergate open flag (#$00 = closed, #$01 = open)

    beq B0F_E4BE
    lda #$04
    sta $20 ; map exterior border tile ID (#$00 = Road, #$01 = Grass, #$02 = Sand, #$03 = Tree, #$04 = Water, #$05 = Vertical Wall, #$06 = Shrub, #$07 = Horizontal Wall, #$08 = Swamp, ..., #$20 = Ceiling Alternating?, #$21 = Ceiling Down?, #$24 = Black?, #$28 = Blue?)

; control flow target (from $E4B4, $E4B8)
B0F_E4BE:
    jsr $D2F7
    lda #$00
    sta $39
    sta $35 ; flag indicating whether any menu is currently open

    sta $36
    sta $03 ; game clock?

    lda #$18
    sta $3A
    ldy #$18
; control flow target (from $E4DD)
B0F_E4D1:
    lda #$FF
    sta $0541,Y ; NPC #$00 sprite ID

    tya
    clc
    adc #$08
    tay
    cmp #$B8
    bne B0F_E4D1
    jsr $F770 ; load ROM bank #$02

    lda $D0 ; Malroth status flag (#$FF = defeated, #$00 = alive, others = countdown to battle)

    bpl B0F_E4FF
    lda $31 ; current map ID

    cmp #$03 ; Map ID #$03: Midenhall 1F

    bne B0F_E4FF
    jsr $FEDA ; parse byte following JSR for bank and pointer index, set $D6-$D7 to $8000,X-$8001,X in selected bank


; code -> data
; indirect data load target

.byte $49
; data -> code
    lda $D6
    sta $0C
    lda $D7
    sta $0D
    jsr $FEFA ; increment JSR's return address, read byte following JSR, parse it for bank and pointer index, set $D6-$D7 to $8000,X-$8001,X in selected bank


; code -> data
; indirect data load target

.byte $49
; data -> code
    jmp $E570

; control flow target (from $E4E4, $E4EA)
B0F_E4FF:
    lda $61AD
    beq B0F_E523
    lda $31 ; current map ID

    cmp #$09 ; Map ID #$09: Moonbrooke

    beq B0F_E512
    cmp #$01 ; Map ID #$01: World Map

    beq B0F_E516
    lda #$6E
    bne B0F_E525
; control flow target (from $E508)
B0F_E512:
    lda #$6D
    bne B0F_E525
; control flow target (from $E50C)
B0F_E516:
    ldy #$6F
    lda $61AD
    cmp #$FE
    bne B0F_E520
    iny
; control flow target (from $E51D)
B0F_E520:
    tya
    bne B0F_E525
; control flow target (from $E502)
B0F_E523:
    lda $31 ; current map ID

; control flow target (from $E510, $E514, $E521)
B0F_E525:
    asl
    tay
    lda $A539,Y ; pointers to per-map NPC setup (X-pos, Y-pos, ???, sprite ID, dialogue [not string] ID)

    sta $0C
    lda $A53A,Y
    sta $0D
    ora $0C
    bne B0F_E570 ; zero pointer => no NPCs

    lda $31 ; current map ID

    cmp #$01 ; Map ID #$01: World Map

    bne B0F_E568 ; if we're on the world map, check to see if we need to add the ship sprite

    lda $61AD
    bne B0F_E552
    lda $CF ; ship status (#$04 = on ship, #$02 = own ship, #$01 = beat Lianport Gremlins)

    and #$06
    cmp #$02
    bne B0F_E568
    lda $D2 ; ship X-pos (when you aren't on it)

    sta $05D4 ; NPC #$13 X-pos

    lda $D3 ; ship Y-pos (when you aren't on it)

    sta $05D5 ; NPC #$13 Y-pos

; control flow target (from $E53E)
B0F_E552:
    lda #$00
    sta $05D6 ; NPC #$13 ?

    sta $05D7 ; NPC #$13 ?

    sta $38
    lda #$01
    sta $05D8 ; NPC #$13 motion nybble + direction nybble

    lda #$05
    sta $05D9 ; NPC #$13 sprite ID

    bne B0F_E56C
; control flow target (from $E539, $E546)
B0F_E568:
    lda #$FF
    sta $38
; control flow target (from $E566, $E57A)
B0F_E56C:
    jsr $CD8F
    rts

; control flow target (from $E4FC, $E533)
B0F_E570:
    ldy #$00
    sty $38
    ldx #$18
; control flow target (from $E5A0)
B0F_E576:
    lda ($0C),Y
    cmp #$FF
    beq B0F_E56C
    sta $053C,X ; NPC #$00 ?

    iny
    lda ($0C),Y
    sta $053D,X ; NPC #$00 ?

    iny
    lda #$00
    sta $053E,X ; NPC #$00 ?

    sta $053F,X ; NPC #$00 ?

    lda ($0C),Y
    sta $0540,X ; NPC #$00 ? + direction nybble

    iny
    lda ($0C),Y
    sta $0541,X ; NPC #$00 sprite ID

    iny
    iny
    txa
    clc
    adc #$08
    tax
    bne B0F_E576
; control flow target (from $D2BC, $D4F6, $E44E)
    ldx #$00
    txa
; control flow target (from $E5AB)
B0F_E5A5:
    sta $051A,X ; something to do with whether you've opened the chest containing the Shield of Erdrick

    inx
    cpx #$20
    bne B0F_E5A5
    rts

; control flow target (from $E5C2, $E636, $E6B4, $E797)
    lda $04C5
    bne B0F_E5B4
    rts

; control flow target (from $E5B1)
B0F_E5B4:
    lda $03 ; game clock?

    pha
    lda #$00
    sta $0C
    jsr $F78C ; wipe selected menu region

    pla
    sta $03 ; game clock?

    rts

; control flow target (from $C741, $FF6C)
    jsr $E5AE
    lda $03 ; game clock?

    and #$0F
    beq B0F_E5D0
    pla
    pla
    jmp $C747

; control flow target (from $E5C9)
B0F_E5D0:
    inc $28 ; current map X-pos (2)

    lda #$FF
    sta $053C ; NPC #$00 ?

    lda #$00
    sta $053D ; NPC #$00 ?

    lda #$01
    sta $0540 ; NPC #$00 ? + direction nybble

    jsr $D35B
    lda #$12
    sta $18
    lda #$F2
    sta $19
; control flow target (from $E607)
B0F_E5EC:
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    lda #$00
    sta $1C
    sta $1E
    jsr $DEC5
    inc $19
    inc $19
    inc $05
    inc $2A ; current map X-pos pixel, low byte

    jsr $D897
    lda $19
    cmp #$10
    bne B0F_E5EC
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    inc $05
    bne B0F_E616
    lda $04
    eor #$01
    sta $04
; control flow target (from $E60E)
B0F_E616:
    inc $14
    lda #$1F
    and $14
    sta $14
    inc $16 ; current map X-pos (1)

    inc $2A ; current map X-pos pixel, low byte

    bne B0F_E630
    inc $2B ; current map X-pos pixel, high byte

    lda $1F ; some kind of map type (#$00: World Map, #$01: other non-dungeon maps, #$02: maps #$2B - #$43 inclusive, #$03: maps >= #$44, #$FF => game menu)

    bne B0F_E630
    lda $2B ; current map X-pos pixel, high byte

    and #$0F
    sta $2B ; current map X-pos pixel, high byte

; control flow target (from $E622, $E628)
B0F_E630:
    jsr $D897
    jmp $E87A

; control flow target (from $C737, $FF72)
    jsr $E5AE
    lda $03 ; game clock?

    and #$0F
    beq B0F_E644
    pla
    pla
    jmp $C747

; control flow target (from $E63D)
B0F_E644:
    dec $28 ; current map X-pos (2)

    lda #$01
    sta $053C ; NPC #$00 ?

    lda #$00
    sta $053D ; NPC #$00 ?

    lda #$03
    sta $0540 ; NPC #$00 ? + direction nybble

    jsr $D35B
    lda #$EC
    sta $18
    lda #$F2
    sta $19
; control flow target (from $E69B)
B0F_E660:
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    lda #$00
    sta $1C
    sta $1E
    jsr $DEC5
    inc $19
    inc $19
    lda $05
    sec
    sbc #$01
    sta $05
    bcs B0F_E67F
    lda $04
    eor #$01
    sta $04
; control flow target (from $E677)
B0F_E67F:
    lda $2A ; current map X-pos pixel, low byte

    sec
    sbc #$01
    sta $2A ; current map X-pos pixel, low byte

    bcs B0F_E694
    dec $2B ; current map X-pos pixel, high byte

    lda $1F ; some kind of map type (#$00: World Map, #$01: other non-dungeon maps, #$02: maps #$2B - #$43 inclusive, #$03: maps >= #$44, #$FF => game menu)

    bne B0F_E694
    lda $2B ; current map X-pos pixel, high byte

    and #$0F
    sta $2B ; current map X-pos pixel, high byte

; control flow target (from $E686, $E68C)
B0F_E694:
    jsr $D897
    lda $19
    cmp #$10
    bne B0F_E660
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    dec $05
    dec $14
    lda #$1F
    and $14
    sta $14
    dec $16 ; current map X-pos (1)

    dec $2A ; current map X-pos pixel, low byte

    jsr $D897
    jmp $E87A

; control flow target (from $C72B, $CABA, $CABD, $CAC0, $FF7E)
    jsr $E5AE
    lda $03 ; game clock?

    and #$0F
    beq B0F_E6C2
    pla
    pla
    jmp $C747

; control flow target (from $E6BB)
B0F_E6C2:
    inc $29 ; current map Y-pos (2)

    lda #$00
    sta $053C ; NPC #$00 ?

    lda #$FF
    sta $053D ; NPC #$00 ?

    lda #$02
    sta $0540 ; NPC #$00 ? + direction nybble

    jsr $D35B
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    inc $06
    inc $2C ; current map Y-pos pixel, low byte

    jsr $D897
    lda #$10
    sta $19
    lda #$EE
    sta $18
; control flow target (from $E70B)
B0F_E6E8:
    lda #$03
    sta $2E
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

; control flow target (from $E6FE)
B0F_E6EF:
    lda #$0C
    sta $1C
    sta $1E
    jsr $DEC5
    inc $18
    inc $18
    dec $2E
    bne B0F_E6EF
    inc $06
    inc $2C ; current map Y-pos pixel, low byte

    jsr $D897
    lda $18
    cmp #$12
    bne B0F_E6E8
    lda #$10
    sta $19
    lda #$EC
    sta $18
; control flow target (from $E735)
B0F_E715:
    lda #$05
    sta $2E
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

; control flow target (from $E728)
B0F_E71C:
    jsr $DE9A
    lda $18
    clc
    adc #$04
    sta $18
    dec $2E
    bne B0F_E71C
    inc $06
    inc $2C ; current map Y-pos pixel, low byte

    jsr $D897
    lda $18
    cmp #$14
    bne B0F_E715
    lda #$10
    sta $19
    lda #$EE
    sta $18
; control flow target (from $E762)
B0F_E73F:
    lda #$03
    sta $2E
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

; control flow target (from $E755)
B0F_E746:
    lda #$03
    sta $1C
    sta $1E
    jsr $DEC5
    inc $18
    inc $18
    dec $2E
    bne B0F_E746
    inc $06
    inc $2C ; current map Y-pos pixel, low byte

    jsr $D897
    lda $18
    cmp #$12
    bne B0F_E73F
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    inc $06
    lda $06
    cmp #$F0
    bne B0F_E773
    lda #$00
    sta $06
; control flow target (from $E76D)
B0F_E773:
    inc $15
    lda $15
    cmp #$0F
    bne B0F_E77F
    lda #$00
    sta $15
; control flow target (from $E779)
B0F_E77F:
    inc $17 ; current map Y-pos (1)

    inc $2C ; current map Y-pos pixel, low byte

    bne B0F_E791
    inc $2D ; current map Y-pos pixel, high byte

    lda $1F ; some kind of map type (#$00: World Map, #$01: other non-dungeon maps, #$02: maps #$2B - #$43 inclusive, #$03: maps >= #$44, #$FF => game menu)

    bne B0F_E791
    lda $2D ; current map Y-pos pixel, high byte

    and #$0F
    sta $2D ; current map Y-pos pixel, high byte

; control flow target (from $E783, $E789)
B0F_E791:
    jsr $D897
    jmp $E87A

; control flow target (from $C71F, $FF78)
    jsr $E5AE
    lda $03 ; game clock?

    and #$0F
    beq B0F_E7A5
    pla
    pla
    jmp $C747

; control flow target (from $E79E)
B0F_E7A5:
    dec $29 ; current map Y-pos (2)

    lda #$00
    sta $053C ; NPC #$00 ?

    sta $0540 ; NPC #$00 ? + direction nybble

    lda #$01
    sta $053D ; NPC #$00 ?

    jsr $D35B
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    dec $06
    lda $06
    cmp #$FF
    bne B0F_E7C6
    lda #$EF
    sta $06
; control flow target (from $E7C0)
B0F_E7C6:
    lda $2C ; current map Y-pos pixel, low byte

    sec
    sbc #$01
    sta $2C ; current map Y-pos pixel, low byte

    bcs B0F_E7DB
    dec $2D ; current map Y-pos pixel, high byte

    lda $1F ; some kind of map type (#$00: World Map, #$01: other non-dungeon maps, #$02: maps #$2B - #$43 inclusive, #$03: maps >= #$44, #$FF => game menu)

    bne B0F_E7DB
    lda $2D ; current map Y-pos pixel, high byte

    and #$0F
    sta $2D ; current map Y-pos pixel, high byte

; control flow target (from $E7CD, $E7D3)
B0F_E7DB:
    jsr $D897
    lda #$F0
    sta $19
    lda #$EE
    sta $18
; control flow target (from $E809)
B0F_E7E6:
    lda #$03
    sta $2E
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

; control flow target (from $E7FC)
B0F_E7ED:
    lda #$03
    sta $1C
    sta $1E
    jsr $DEC5
    inc $18
    inc $18
    dec $2E
    bne B0F_E7ED
    dec $06
    dec $2C ; current map Y-pos pixel, low byte

    jsr $D897
    lda $18
    cmp #$12
    bne B0F_E7E6
    lda #$F0
    sta $19
    lda #$EC
    sta $18
; control flow target (from $E833)
B0F_E813:
    lda #$05
    sta $2E
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

; control flow target (from $E826)
B0F_E81A:
    jsr $DE9A
    lda $18
    clc
    adc #$04
    sta $18
    dec $2E
    bne B0F_E81A
    dec $06
    dec $2C ; current map Y-pos pixel, low byte

    jsr $D897
    lda $18
    cmp #$14
    bne B0F_E813
    lda #$F0
    sta $19
    lda #$EE
    sta $18
; control flow target (from $E860)
B0F_E83D:
    lda #$03
    sta $2E
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

; control flow target (from $E853)
B0F_E844:
    lda #$0C
    sta $1C
    sta $1E
    jsr $DEC5
    inc $18
    inc $18
    dec $2E
    bne B0F_E844
    dec $06
    dec $2C ; current map Y-pos pixel, low byte

    jsr $D897
    lda $18
    cmp #$12
    bne B0F_E83D
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    dec $06
    dec $15
    lda $15
    cmp #$FF
    bne B0F_E873
    lda #$0E
    sta $15
; control flow target (from $E86D)
B0F_E873:
    dec $17 ; current map Y-pos (1)

    dec $2C ; current map Y-pos pixel, low byte

    jsr $D897
; control flow target (from $E633, $E6B1, $E794)
    lda $16 ; current map X-pos (1)

    sta $12
    lda $17 ; current map Y-pos (1)

    sta $13
    jsr $E218
    lda $0D
    cmp $1D
    bne B0F_E8A2
    lda $1F ; some kind of map type (#$00: World Map, #$01: other non-dungeon maps, #$02: maps #$2B - #$43 inclusive, #$03: maps >= #$44, #$FF => game menu)

    cmp #$02
    bne B0F_E8A1
    lda $16 ; current map X-pos (1)

    lsr
    clc
    sbc $21 ; map width

    bcs B0F_E8A9
    lda $17 ; current map Y-pos (1)

    lsr
    clc
    sbc $22 ; map height

    bcs B0F_E8A9
; control flow target (from $E88F)
B0F_E8A1:
    rts

; control flow target (from $E889)
B0F_E8A2:
    sta $1D
    lda #$FF
    sta $05FD
; control flow target (from $E897, $E89F)
B0F_E8A9:
    lda $1F ; some kind of map type (#$00: World Map, #$01: other non-dungeon maps, #$02: maps #$2B - #$43 inclusive, #$03: maps >= #$44, #$FF => game menu)

    cmp #$02
    beq B0F_E8B2
    jmp $E934

; control flow target (from $E8AD)
B0F_E8B2:
    jsr $F761 ; load ROM bank #$06

    lda $31 ; current map ID

    sec
    sbc #$2B ; only maps between #$2B and #$47 inclusive are checked for irregularities

    asl
    tay
    lda $A3E1,Y ; pointers to warp spaces for irregularly-shaped maps

    sta $10
    lda $A3E2,Y
    sta $11
    ora $10
    beq B0F_E934 ; no irregularity => skip over handling irregularities

    lda $16 ; current map X-pos (1)

    and #$FE ; maps are designed with 2-tile wide transitions between visible segments, so ignore the low bit of map position to cover a 2-tile-wide space

    sta $0C ; current X-pos, 2-tile granularity

    lda $17 ; current map Y-pos (1)

    and #$FE ; maps are designed with 2-tile high transitions between visible segments, so ignore the low bit of map position to cover a 2-tile-high space

    sta $0E ; current Y-pos, 2-tile granularity

    ldy #$FF ; initialize index to -1 so that when we INY we'll be at #$00

; control flow target (from $E8E7, $E8ED)
B0F_E8D8:
    iny ; offset for destination map ID

    lda ($10),Y ; destination map ID

    cmp #$FF ; #$FF => end of list

    beq B0F_E934
    iny ; offset for destination X-pos

    iny ; offset for destination Y-pos

    iny ; offset for transition X-pos

    lda ($10),Y ; transition X-pos

    iny
    cmp $0C ; current X-pos, 2-tile granularity

    bne B0F_E8D8 ; not the right X-pos space => loop to next irregularity

    lda ($10),Y ; transition Y-pos

    cmp $0E ; current Y-pos, 2-tile granularity

    bne B0F_E8D8 ; not the right X-pos space => loop to next irregularity

    dey ; offset for transition X-pos

    dey ; offset for destination Y-pos

    lda $17 ; current map Y-pos (1)

    and #$01 ; pick out difference between real position and 2-tile granularity

    ora ($10),Y ; set low bit of destination Y-pos

    sta $17 ; current map Y-pos (1)

    sta $29 ; current map Y-pos (2)

    sta $13
    sta $2C ; current map Y-pos pixel, low byte

    dey ; offset for destination X-pos

    lda $16 ; current map X-pos (1)

    and #$01 ; pick out difference between real position and 2-tile granularity

    ora ($10),Y ; set low bit of destination X-pos

    sta $16 ; current map X-pos (1)

    sta $28 ; current map X-pos (2)

    sta $12
    sta $2A ; current map X-pos pixel, low byte

    dey ; offset for destination map ID

    lda ($10),Y
    sta $31 ; current map ID

    lda #$00
    sta $2B ; current map X-pos pixel, high byte

    sta $2D ; current map Y-pos pixel, high byte

    ldx #$04 ; shift 16x16 map position into pixel position variables

; control flow target (from $E924)
B0F_E91B:
    asl $2A ; current map X-pos pixel, low byte

    rol $2B ; current map X-pos pixel, high byte

    asl $2C ; current map Y-pos pixel, low byte

    rol $2D ; current map Y-pos pixel, high byte

    dex
    bne B0F_E91B
    lda #$FF
    sta $45
    jsr $E461
    jsr $E218
    lda $0D
    sta $1D
; control flow target (from $E8AF, $E8C8, $E8DD)
B0F_E934:
    lda #$FF
    sta $41
; control flow target (from $D229, $D24D)
; external control flow target (from $06:$97D2)
    lda #$00
    sta $18
    sta $19
    sta $42
    lda #$FE
    sta $3D
    sta $3F
    sta $3E
    sta $40
    jsr $F770 ; load ROM bank #$02

    lda $1F ; some kind of map type (#$00: World Map, #$01: other non-dungeon maps, #$02: maps #$2B - #$43 inclusive, #$03: maps >= #$44, #$FF => game menu)

    asl
    tay
    lda $DEBD,Y
    sta $6F
    iny
    lda $DEBD,Y
    sta $70
    ldy #$00
; control flow target (from $E964)
B0F_E95E:
    lda ($6F),Y
    sta $6E00,Y
    dey
    bne B0F_E95E
    jsr $EB6D
    jsr $E9FC
    lda $41
    cmp #$32
    beq B0F_E9BA
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    lda #$FF
    sta $35 ; flag indicating whether any menu is currently open

    jsr $D8CB
    lda #$00
    sta $35 ; flag indicating whether any menu is currently open

    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    lda #$F2
    sta $19
    lda #$F0
    sta $18
    lda #$02
    sta $3D
    sta $3E
    lda #$0E
    sta $3F
    sta $40
    lda #$00
    sta $41
    ldx #$FF
    stx $6145
    jsr $EA38
    lda $1F ; some kind of map type (#$00: World Map, #$01: other non-dungeon maps, #$02: maps #$2B - #$43 inclusive, #$03: maps >= #$44, #$FF => game menu)

    cmp #$03
    beq B0F_E9B3
    lda $1D
    bne B0F_E9BA
    lda $1F ; some kind of map type (#$00: World Map, #$01: other non-dungeon maps, #$02: maps #$2B - #$43 inclusive, #$03: maps >= #$44, #$FF => game menu)

    cmp #$02
    beq B0F_E9BA
; control flow target (from $E9A7)
B0F_E9B3:
    lda #$01
    sta $45
    jsr $D2F7
; control flow target (from $E970, $E9AB, $E9B1)
B0F_E9BA:
    lda #$EE
    sta $18
; control flow target (from $E9F7)
B0F_E9BE:
    jsr $EB6D
    lda #$F2
    sta $19
; control flow target (from $E9D6)
B0F_E9C5:
    lda #$00
    sta $1C
    sta $1E
    jsr $EA9F
    inc $19
    inc $19
    lda $19
    cmp #$02
    bne B0F_E9C5
    jsr $EB6D
; control flow target (from $E9EC)
B0F_E9DB:
    lda #$00
    sta $1C
    sta $1E
    jsr $EA9F
    inc $19
    inc $19
    lda $19
    cmp #$10
    bne B0F_E9DB
    lda $18
    clc
    adc #$22
    sta $18
    cmp #$32
    bne B0F_E9BE
    jmp $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF


; control flow target (from $E969, $EA08, $EA6D, $EA73)
B0F_E9FC:
    jsr $EA76
    lda $18
    clc
    adc $3D
    sta $18
    cmp $3F
    bne B0F_E9FC
    lda $3D
    eor #$FF
    sta $3D
    inc $3D
    lda $3F
    eor #$FF
    sta $3F
    inc $3F
    bpl B0F_EA27
    lda $41
    beq B0F_EA2F
    dec $3F
    dec $3F
    jmp $EA2F

; control flow target (from $EA1A)
B0F_EA27:
    lda $41
    bne B0F_EA2F
    dec $3F
    dec $3F
; control flow target (from $EA1E, $EA24, $EA29)
B0F_EA2F:
    lda $41
    bne B0F_EA38
    lda $19
    bne B0F_EA38
    rts

; control flow target (from $E9A0, $EA31, $EA35, $EA44)
B0F_EA38:
    jsr $EA76
    lda $19
    clc
    adc $3E
    sta $19
    cmp $40
    bne B0F_EA38
    lda $3E
    eor #$FF
    sta $3E
    inc $3E
    lda $40
    eor #$FF
    sta $40
    inc $40
    bpl B0F_EA63
    lda $41
    beq B0F_EA6B
    dec $40
    dec $40
    jmp $EA6B

; control flow target (from $EA56)
B0F_EA63:
    lda $41
    bne B0F_EA6B
    dec $40
    dec $40
; control flow target (from $EA5A, $EA60, $EA65)
B0F_EA6B:
    lda $41
    beq B0F_E9FC
    lda $40
    cmp #$10
    bne B0F_E9FC
    rts

; control flow target (from $E9FC, $EA38)
    lda #$00
    sta $1E
    lda $41
    beq B0F_EA82
    lda #$FF
    bne B0F_EA84
; control flow target (from $EA7C)
B0F_EA82:
    lda #$FE
; control flow target (from $EA80)
B0F_EA84:
    sta $1C
    jsr $EA9F
    inc $42
    lda $42
    cmp #$1E
    beq B0F_EA97
    lda $01
    cmp #$12
    bcc B0F_EA9E
; control flow target (from $EA8F)
B0F_EA97:
    jsr $EB6D
    lda #$00
    sta $42
; control flow target (from $EA95)
B0F_EA9E:
    rts

; control flow target (from $E9CB, $E9E1, $EA86)
    jsr $EAFC
    bcc B0F_EAA5
    rts

; control flow target (from $EAA2)
B0F_EAA5:
    lda $0C
    asl
    asl
    adc $0C
    tay
    ldx $02
    lda $08
    sta $0300,X ; PPU write buffer start

    lda $07
    sta $0301,X
    lda $6E00,Y
    sta $0302,X
    lda $6E01,Y
    sta $0303,X
    lda $6E02,Y
    sta $0304,X
    lda $6E03,Y
    sta $0305,X
    lda $6E04,Y
    and #$03
    sta $09
    lda $1A
    sta $0C
    lda $1B
    sta $0E
    jsr $DE6E
    lda $08
    ora #$20
    sta $0306,X
    lda $07
    sta $0307,X
    lda $09
    sta $0308,X
    txa
    clc
    adc #$09
    sta $02
    inc $01
    rts

; control flow target (from $DEC5, $EA9F)
    jsr $DF62
    lda $0C
    sta $1A
    lda $0E
    sta $1B
    jsr $DE00
    lda $18
    asl
    lda $18
    ror
    clc
    adc $16 ; current map X-pos (1)

    sta $0C
    lda $19
    asl
    lda $19
    ror
    clc
    adc $17 ; current map Y-pos (1)

    sta $0E
    jsr $DF89
    jsr $E222
    lda $1D
    cmp $0D
    beq B0F_EB4E
    lda $0C
    cmp #$28
    bcs B0F_EB4E
    lda $1D
    bne B0F_EB4A
    lda $1F ; some kind of map type (#$00: World Map, #$01: other non-dungeon maps, #$02: maps #$2B - #$43 inclusive, #$03: maps >= #$44, #$FF => game menu)

    cmp #$01
    beq B0F_EB46
    lda $0C
    cmp #$08
    bcc B0F_EB46
    cmp #$0C
    bcc B0F_EB4E
; control flow target (from $EB3A, $EB40)
B0F_EB46:
    lda #$20
    bne B0F_EB4C
; control flow target (from $EB34)
B0F_EB4A:
    lda #$24
; control flow target (from $EB48)
B0F_EB4C:
    sta $0C
; control flow target (from $EB2A, $EB30, $EB44)
B0F_EB4E:
    lda $1C
    cmp #$FF
    bne B0F_EB5B
    lda $0C
    cmp #$20
    bcc B0F_EB67
    rts

; control flow target (from $EB52)
B0F_EB5B:
    cmp #$FE
    bne B0F_EB6B
    lda $0C
    cmp #$20
    bcs B0F_EB67
    sec
    rts

; control flow target (from $EB58, $EB63)
B0F_EB67:
    lda #$00
    sta $1C
; control flow target (from $EB5D)
B0F_EB6B:
    clc
    rts

; control flow target (from $E966, $E9BE, $E9D8, $EA97)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    lda #$FF
    sta $6145
    rts

; open menu specified by next byte
; control flow target (from $C750, $C84D, $F6FC)
; external control flow target (from $02:$B29D, $06:$8061, $06:$8065, $06:$8232, $06:$8242, $06:$8374, $06:$83A3, $06:$8455, $06:$84BB, $06:$8540, $06:$855B, $06:$867D, $06:$868D, $06:$8BFC, $06:$8C29, $06:$9584, $06:$95FF, $06:$9ACB, $06:$9AD0, $06:$9B17, $06:$A0CA, $06:$A204, $06:$BB4E, $06:$BB5F, $06:$BBAB, $06:$BBCA, $06:$BC22, $06:$BD4F)
    pla ; low byte of return address

    clc
    adc #$01 ; increment it (byte following the JSR is data)

    sta $0E ; store to $0E

    pla ; high byte of return address

    adc #$00 ; add carry from incrementing low byte

    sta $0F ; store to $0F

    pha ; push the new return address's high byte

    lda $0E
    pha ; push the new return address's low byte

    ldy #$00
    lda ($0E),Y ; read the byte following the original JSR

; open menu specified by A
; control flow target (from $D188, $F494, $F49B, $F4A2, $F4BE, $F514, $F521, $F526, $F531, $F53F, $F54F, $F565, $F573, $F581, $F58F, $F59D, $F5CF, $F5D8, $F5DC, $F5F0, $F60C, $F620, $F625, $F63F, $F648, $F652, $F657)
; external control flow target (from $04:$9AB1, $04:$9AC4, $06:$A997, $06:$AEAC, $06:$AEB1)
    jsr $F66E ; do special effects for certain menus; sets A to menu ID

    bcc B0F_EB91 ; all $F66E code paths end with SEC, so this branch is never taken

    jsr $EB98
; control flow target (from $EB8C)
B0F_EB91:
    pha
    lda a:$94 ; return bank for various function calls, doubles as index of selected option for multiple-choice menus

    jmp $F782 ; load bank specified by A then PLA


; control flow target (from $EB8E)
    sta $59 ; menu ID

    lda #$01
    sta $60B4 ; menu phase (1 = first, 0 = second)

    jsr $EBA8
    jsr $F435
    dec $60B4 ; menu phase (1 = first, 0 = second)

; control flow target (from $EB9F)
    jsr $EBB2 ; given menu ID in $59, set $55-$56 to start of menu data

    jsr $EBC5 ; parse menu setup header

    jsr $EC11
    rts

; given menu ID in $59, set $55-$56 to start of menu data
; control flow target (from $EBA8)
    lda #$20 ; menu pointer table

    jsr $F3E2 ; parse bank/pointer indices from A, load desired bank, set $57-$58 to desired pointer value

    lda $59 ; menu ID

    asl ; 2 bytes per pointer

    tay
    lda ($57),Y ; pointer to start of main pointer table, low byte; copy menu pointer to $55-$56

    sta $55 ; pointer to start of sub pointer data, low byte

    iny
    lda ($57),Y ; pointer to start of main pointer table, low byte

    sta $56 ; pointer to start of sub pointer data, high byte

    rts

; parse menu setup header
; control flow target (from $EBAB)
    ldy #$00 ; start at the start

    lda ($55),Y ; pointer to start of sub pointer data, low byte

    sta $60AA ; menu format (#$80 = has cursor, #$40 = is linked, #$20 = is single spaced, #$02 = only display equipped items, #$01 = display [left border, equipped] if equipped)

    iny
    lda ($55),Y ; pointer to start of sub pointer data, low byte

    sta $60A2 ; menu window height (from ROM)

    asl
    sta $60A3 ; menu window height (ROM value * 2)

    iny
    lda ($55),Y ; pointer to start of sub pointer data, low byte

    sta $60A1 ; menu window width

    iny
    lda ($55),Y ; pointer to start of sub pointer data, low byte

    sta $60A4 ; menu window position (from ROM; X-pos = low nybble * 2, Y-pos = high nybble * 2)

    pha
    and #$0F
    asl
    sta $4D ; menu window X-pos

    pla
    and #$F0
    lsr
    lsr
    lsr
    sta $4E ; menu window Y-pos

    iny
    lda $60AA ; menu format (#$80 = has cursor, #$40 = is linked, #$20 = is single spaced, #$02 = only display equipped items, #$01 = display [left border, equipped] if equipped)

    bpl B0F_EC02 ; if no cursor, skip ahead

    lda ($55),Y ; pointer to start of sub pointer data, low byte

    sta $60A5 ; menu cursor second column X-offset (from left edge of menu)

    iny
    lda ($55),Y ; pointer to start of sub pointer data, low byte

    sta $60A9 ; menu cursor initial position (from ROM; X-pos = low nybble, Y-pos = high nybble)

    iny
; control flow target (from $EBF4)
B0F_EC02:
    bit $60AA ; menu format (#$80 = has cursor, #$40 = is linked, #$20 = is single spaced, #$02 = only display equipped items, #$01 = display [left border, equipped] if equipped)

    bvc B0F_EC0D ; if menu is not linked, skip ahead

    lda ($55),Y ; pointer to start of sub pointer data, low byte

    sta $60AE ; menu link ID

    iny
; control flow target (from $EC05)
B0F_EC0D:
    sty $60A6 ; current menu read index

    rts

; control flow target (from $EBAE)
    jsr $EC29 ; initialize menu vars, remove battle item menu link if not enough items

; control flow target (from $EC23, $ECEE)
B0F_EC14:
    jsr $EC78 ; set menu text $609B to [space] or the appropriate border tile

    jsr $ECC5 ; tweak dynamic list height if necessary, otherwise set menu function index and parameter

    jsr $ED1C ; given menu function index in $609C, set $57-$58 to corresponding function address and execute it

    jsr $F02B
    jsr $F057 ; CLC if more menu rows to display, SEC otherwise

    bcc B0F_EC14
    jsr $F0B7
    rts

; initialize menu vars, remove battle item menu link if not enough items
; control flow target (from $EC11)
    jsr $F0C1 ; write [space] to $600B-$6046

    lda #$FF
    sta $60B9
    lda #$00
    sta $609E ; menu current column

    sta $609F ; menu current row

    sta $60AC ; menu list index

    sta $60AB ; which list segment we're dealing with

    sta $60A8 ; remaining number of rows for dynamic menu lists

    sta $10
    sta $11
    sta $12
    lda $59 ; menu ID

    cmp #$22 ; Menu ID #$22: Battle menu: item list window 2

    bne B0F_EC53
    lda #$04
    sta $60AC ; menu list index

; control flow target (from $EC4C)
B0F_EC53:
    lda $59 ; menu ID

    cmp #$08 ; Menu ID #$08: Battle menu: item list window 1

    bne B0F_EC6D
    lda #$04 ; count all items

    sta $609D ; menu function parameter

    jsr $F1B7 ; given hero ID in $4A and item type in $609D, set A = number of items of desired type in hero's inventory

    cmp #$05 ; max 4 items per screen

    bcs B0F_EC6D ; if < 5 items, disable menu link

    lda $60AA ; menu format (#$80 = has cursor, #$40 = is linked, #$20 = is single spaced, #$02 = only display equipped items, #$01 = display [left border, equipped] if equipped)

    and #$BF ; clear bit 6

    sta $60AA ; menu format (#$80 = has cursor, #$40 = is linked, #$20 = is single spaced, #$02 = only display equipped items, #$01 = display [left border, equipped] if equipped)

; control flow target (from $EC57, $EC63)
B0F_EC6D:
    lda #$00 ; write #$00 to $606B-$607A

    ldx #$0F
; control flow target (from $EC75)
B0F_EC71:
    sta $606B,X
    dex
    bpl B0F_EC71
    rts

; set menu text $609B to [space] or the appropriate border tile
; control flow target (from $EC14)
    lda #$5F ; [space]

    sta $609B ; menu text

    ldx $609E ; menu current column

    beq B0F_EC9F ; if we're at column 0, branch to figure out what kind of left border to draw

    inx
    cpx $60A1 ; menu window width

    bne B0F_ECB6 ; if we're not at width - 1, branch over figuring out what kind of right border to draw

    ldx $609F ; menu current row

    beq B0F_EC97 ; if we're on row 0, use a [top-right border]

    inx
    cpx $60A3 ; menu window height (ROM value * 2)

    beq B0F_EC9B ; if we're on the last row, use a [bottom-right border], otherwise we're in between, so use a plain [right border]

    lda #$7B ; [right border]

    bne B0F_ECC1
; control flow target (from $EC8B)
B0F_EC97:
    lda #$7C ; [top-right border]

    bne B0F_ECC1
; control flow target (from $EC91)
B0F_EC9B:
    lda #$7E ; [bottom-right border]

    bne B0F_ECC1
; control flow target (from $EC80)
B0F_EC9F:
    ldx $609F ; menu current row

    beq B0F_ECAE ; if we're on row 0, use a [top-left border]

    inx
    cpx $60A3 ; menu window height (ROM value * 2)

    beq B0F_ECB2 ; if we're on the last row, use a [bottom-left border], otherwise we're in between, so use a plain [left border]

    lda #$76 ; [left border]

    bne B0F_ECC1
; control flow target (from $ECA2)
B0F_ECAE:
    lda #$79 ; [top-left border]

    bne B0F_ECC1
; control flow target (from $ECA8)
B0F_ECB2:
    lda #$7A ; [bottom-left border]

    bne B0F_ECC1
; control flow target (from $EC86)
B0F_ECB6:
    ldx $609F ; menu current row

    inx
    cpx $60A3 ; menu window height (ROM value * 2)

    bne B0F_ECC4 ; if we're on the last row, use a [bottom border], otherwise keep that [space] we started with

    lda #$7D ; [bottom border]

; control flow target (from $EC95, $EC99, $EC9D, $ECAC, $ECB0, $ECB4)
B0F_ECC1:
    sta $609B ; menu text

; control flow target (from $ECBD)
B0F_ECC4:
    rts

; tweak dynamic list height if necessary, otherwise set menu function index and parameter
; control flow target (from $EC17)
    lda $609B ; menu text

    cmp #$5F ; [space]

    bne B0F_ED16 ; if menu text is not a [space], set menu function index to #$10 (print one byte of menu text) and RTS

    lda $60AA ; menu format (#$80 = has cursor, #$40 = is linked, #$20 = is single spaced, #$02 = only display equipped items, #$01 = display [left border, equipped] if equipped)

    and #$20 ; pick out the single-spaced bit

    bne B0F_ECF5 ; read current menu byte and set menu function index and parameter; branch if single-spaced

    lda $609F ; menu current row

    lsr
    bcc B0F_ECF5 ; read current menu byte and set menu function index and parameter; branch if even row

    lda $60A8 ; remaining number of rows for dynamic menu lists

    cmp #$01
    bne B0F_ECF1 ; set menu function index and parameter to #$00 (i.e. setup for newline function)

    lda #$00 ; reset menu current column

    sta $609E ; menu current column

    ldx $609F ; menu current row

    inx
    stx $60A3 ; menu window height (ROM value * 2)

    pla ; skip over the next few menu processing functions

    pla
    jmp $EC14

; set menu function index and parameter to #$00 (i.e. setup for newline function)
; control flow target (from $ECDE)
B0F_ECF1:
    lda #$00
    beq B0F_ED03 ; split A into menu function index and parameter and save them

; read current menu byte and set menu function index and parameter
; control flow target (from $ECD1, $ECD7)
B0F_ECF5:
    ldy $60A6 ; current menu read index

    inc $60A6 ; current menu read index

    jsr $FEFA ; increment JSR's return address, read byte following JSR, parse it for bank and pointer index, set $D6-$D7 to $8000,X-$8001,X in selected bank


; code -> data
; indirect data load target

.byte $20
; data -> code
    lda ($55),Y ; pointer to start of sub pointer data, low byte

    bpl B0F_ED13 ; high bit determines whether byte is function (set) or text (clear)

; split A into menu function index and parameter and save them
; control flow target (from $ECF3)
B0F_ED03:
    and #$7F ; clear function bit

    pha
    and #$07 ; menu function parameter is 3 bits wide

    sta $609D ; menu function parameter

    pla
    lsr ; menu function index is 4 bits wide

    lsr
    lsr
    sta $609C ; menu function index

    rts

; control flow target (from $ED01)
B0F_ED13:
    sta $609B ; menu text

; control flow target (from $ECCA)
B0F_ED16:
    lda #$10
    sta $609C ; menu function index

    rts

; given menu function index in $609C, set $57-$58 to corresponding function address and execute it
; control flow target (from $EC1A)
    lda $609C ; menu function index

    asl
    tax
    lda $F0CC,X ; menu control code jump table low byte

    sta $57 ; pointer to start of main pointer table, low byte

    lda $F0CD,X ; menu control code jump table high byte

    sta $58 ; pointer to start of main pointer table, high byte

    jmp ($0057) ; pointer to start of main pointer table, low byte


; menu control code #$80-#$87 handler: print number of spaces specified by $609D (or rest of line if $609D is #$00) to current menu position
; control flow target (from $EF8A)
; indirect control flow target (via $F0CC)
    lda #$5F ; Tile ID #$5F: [space]

    sta $609B ; menu text

    jsr $F05E ; set $60A0 based on menu function parameter $609D and number of remaining tiles in the current line

; control flow target (from $ED3C)
B0F_ED36:
    jsr $F013 ; update menu current column and row

    dec $60A0 ; maximum string length

    bne B0F_ED36 ; if more tiles to print, print them

    rts

; menu control code #$88-#$8F handler: print number of top border tiles specified by $609D (or rest of line if $609D is #$00) to current menu position, accounting for possible linked menu
; indirect control flow target (via $F0CE)
    bit $60AA ; menu format (#$80 = has cursor, #$40 = is linked, #$20 = is single spaced, #$02 = only display equipped items, #$01 = display [left border, equipped] if equipped)

    bvc B0F_ED54 ; if not linked, skip ahead

    lda #$5F ; Tile ID #$5F: [space]

    sta $609B ; menu text

    jsr $EFE4 ; print one byte of menu text

    lda #$63 ; Tile ID #$63: [right arrow]

    sta $609B ; menu text

    jsr $EFE4 ; print one byte of menu text

; control flow target (from $ED42)
B0F_ED54:
    lda #$77 ; Tile ID #$77: [top border]

    sta $609B ; menu text

    jsr $F05E ; set $60A0 based on menu function parameter $609D and number of remaining tiles in the current line

; control flow target (from $ED62)
B0F_ED5C:
    jsr $EFE4 ; print one byte of menu text

    dec $60A0 ; maximum string length

    bne B0F_ED5C ; if more tiles to print, print them

    rts

; menu control code #$90-#$97 handler: print selected hero's current HP or MP
; indirect control flow target (via $F0D0)
    lda #$03
    jsr $F07A ; set maximum string length $60A0 to A and update menu function parameter $609D: if its bits 0-1 are both set, use $4A | bit 2 of $609D, else use the low 3 bits of $609D

    ldx #$0E ; offset for current HP

    lda $609D ; menu function parameter

    and #$04 ; MP control codes set bit 2

    beq B0F_ED75
    ldx #$10 ; offset for current MP

; control flow target (from $ED71)
B0F_ED75:
    ldy #$01 ; print one byte (ignores 2nd byte of current HP)

    jmp $F096 ; given hero ID in ID $609D, stat offset in X, and stat byte size in Y (max of #$03), print that stat in base 10 to current menu position, replacing leading zeroes with spaces


; menu control code #$98-#$9F handler: print party gold or crests or "ADVENTURE LOG"
; indirect control flow target (via $F0D2)
    lda #$05 ; start by assuming crests

    sta $60A0 ; maximum string length

    lda $609D ; menu function parameter

    beq B0F_EDA7 ; menu control code #$98 handler: print party gold

    cmp #$01
    bne B0F_EDAD ; menu control code #$9A-#$9F handler: print "ADVENTURE LOG"

; menu control code #$99 handler: print obtained crests
    jsr $F19F ; initialize string buffer $0100-$010C with [space]s

    lda $0112 ; Crests found bit field (#$10 = Life, #$80 = Water, #$04 = Moon, #$02 = Stars, #$01 = Sun)

    and #$1F ; pretty sure nothing writes to the high 3 bits, but better safe than sorry

    sta $10 ; crests found

    ldx #$04 ; maximum of 5 crests

    ldy #$5A ; Tile ID #$5A: [sun]

; control flow target (from $EDA2)
B0F_ED96:
    lsr $10 ; shift crest bit into C

    bcc B0F_ED9F ; branch if crest not found

    tya
    sta $0100,X ; string copy buffer start (often referenced as $00FF,X)

    dex
; control flow target (from $ED98)
B0F_ED9F:
    iny ; crest tile ID

    lda $10 ; remaining crests

    bne B0F_ED96 ; if more crests to copy, copy them

    jmp $F0A5 ; print string at $0100 in reverse to current menu position


; menu control code #$98 handler: print party gold
; control flow target (from $ED82)
B0F_EDA7:
    jsr $F479 ; print party gold to $0100 in decimal in reverse, replacing leading (now trailing) zeroes with spaces, leaving X at most significant digit

    jmp $F0A5 ; print string at $0100 in reverse to current menu position


; menu control code #$9A-#$9F handler: print "ADVENTURE LOG"
; 9B-9F are unused
; control flow target (from $ED86)
B0F_EDAD:
    lda #$0D ; length of "ADVENTRUE LOG"

    sta $60A0 ; maximum string length

    tax
; control flow target (from $EDBA)
B0F_EDB3:
    lda $EDBE,X ; built-in offset from $EDBF: "GOL ERUTNEVDA", i.e. "ADVENTRUE LOG" backwards

    sta a:$FF,X ; built-in offset from string copy buffer start at $0100

    dex
    bne B0F_EDB3
; built-in offset from $EDBF: "GOL ERUTNEVDA", i.e. "ADVENTRUE LOG" backwards
; indexed data load target (from $EDB3)
    jmp $F0A5 ; print string at $0100 in reverse to current menu position



; code -> data
; "GOL ERUTNEVDA", i.e. "ADVENTRUE LOG" backwards

.byte $2A,$32,$2F,$5F,$28,$35,$38
.byte $37,$31,$28
.byte $39,$27
.byte $24
; data -> code
; menu control code #$A0-#$A7 handler: print level of selected hero or Midenhall's level in current save file
; indirect control flow target (via $F0D4)
    lda $609D ; menu function parameter

    cmp #$04
    beq B0F_EE01 ; menu control code #$A4 handler: print Midenhall's level in current save file

    lda #$02
    jsr $F07A ; set maximum string length $60A0 to A and update menu function parameter $609D: if its bits 0-1 are both set, use $4A | bit 2 of $609D, else use the low 3 bits of $609D

    ldx #$00 ; offset for hero status

    ldy #$01 ; which is one byte long

    jsr $F14A ; given stat offset in X and stat byte size in Y (max of #$03), copy that many bytes of hero ID $609D's stats to $10-$12

    lda $10 ; hero status

    bpl B0F_EDEE ; dead hero

    and #$20 ; pick out the poison bit

    bne B0F_EDF4 ; poisoned hero

    ldx #$11 ; offset for level

    ldy #$01 ; which is one byte long

    jmp $F096 ; given hero ID in ID $609D, stat offset in X, and stat byte size in Y (max of #$03), print that stat in base 10 to current menu position, replacing leading zeroes with spaces


; dead hero
; control flow target (from $EDE1)
B0F_EDEE:
    lda #$27 ; Tile ID #$27: D

    ldx #$28 ; Tile ID #$28: E

    bne B0F_EDF8
; poisoned hero
; control flow target (from $EDE5)
B0F_EDF4:
    lda #$33 ; Tile ID #$33: P

    ldx #$32 ; Tile ID #$32: O

; control flow target (from $EDF2)
B0F_EDF8:
    sta $0101
    stx $0100 ; string copy buffer start (often referenced as $00FF,X)

    jmp $F0A5 ; print string at $0100 in reverse to current menu position


; menu control code #$A4 handler: print Midenhall's level in current save file
; control flow target (from $EDD1)
B0F_EE01:
    lda #$02
    sta $60A0 ; maximum string length

    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $C6
; data -> code
    lda $0E ; useless op

    sta $10
    lda #$00
    sta $11 ; this is either useless if we're relying on $11 still being #$00 from the earlier call to $EC29 or a bug since we aren't setting $12

    jsr $F09F ; given a 24-bit number N in $10-$12, print its base 10 digits in reverse to $0100 up to maximum string length $60A0, replacing leading (trailing in reverse) zeroes with spaces

    jmp $F0A5 ; print string at $0100 in reverse to current menu position


; menu control code #$A8-#$AF handler: print selected hero's current EXP
; indirect control flow target (via $F0D6)
    lda #$07
    jsr $F07A ; set maximum string length $60A0 to A and update menu function parameter $609D: if its bits 0-1 are both set, use $4A | bit 2 of $609D, else use the low 3 bits of $609D

    ldx #$06 ; offset for current EXP

    ldy #$03 ; which is 3 bytes long

    jmp $F096 ; given hero ID in ID $609D, stat offset in X, and stat byte size in Y (max of #$03), print that stat in base 10 to current menu position, replacing leading zeroes with spaces


; menu control code #$B0-#$B7 handler: print selected hero's short name, current hero's full name, or Midenhall's short name from selected save game
; indirect control flow target (via $F0D8)
    lda $609D ; menu function parameter

    cmp #$04
    beq B0F_EE4D ; menu control code #$B4 handler: print current hero's full name

    cmp #$05
    bcs B0F_EE70 ; menu control code #$B5-#$B7 handler: print short save name

; menu control code #$B0-#$B3 handler: print short name of hero ID in $609D
; control flow target (from $EE52)
    lda #$04
    jsr $F07A ; set maximum string length $60A0 to A and update menu function parameter $609D: if its bits 0-1 are both set, use $4A | bit 2 of $609D, else use the low 3 bits of $609D; for #$B3, set hero ID = $4A

    lda $609D ; menu function parameter

    asl
    asl
    adc $609D ; menu function parameter; A = hero ID * 5

    tax
    ldy $60A0 ; maximum string length

; control flow target (from $EE48)
B0F_EE40:
    lda $0113,X ; Midenhall name bytes 0-3 + terminator

    sta a:$FF,Y ; built-in offset from string copy buffer start at $0100

    inx ; read index

    dey ; write index

    bne B0F_EE40 ; if more tiles to print, print them

    jmp $F0A5 ; print string at $0100 in reverse to current menu position


; menu control code #$B4 handler: print current hero's full name
; control flow target (from $EE29)
B0F_EE4D:
    lda #$03 ; start by printing selected hero's short name

    sta $609D ; menu function parameter

    jsr $EE2F ; menu control code #$B0-#$B3 handler: print short name of hero ID in $609D

    lda #$04
    sta $60A0 ; maximum string length

    lda $609D ; menu function parameter

    asl
    asl
    tax ; A = hero ID * 4

    ldy $60A0 ; maximum string length

; control flow target (from $EE6B)
B0F_EE63:
    lda $0186,X ; Midenhall name bytes 4-7

    sta a:$FF,Y ; built-in offset from string copy buffer start at $0100

    inx ; read index

    dey ; write index

    bne B0F_EE63 ; if more tiles to print, print them

    jmp $F0A5 ; print string at $0100 in reverse to current menu position


; menu control code #$B5-#$B7 handler: print short save name
; control flow target (from $EE2D)
B0F_EE70:
    lda #$04
    sta $60A0 ; maximum string length

    lda $609D ; menu function parameter

    sec
    sbc #$05 ; #$05-#$07 -> #$00-#$02

    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $CE
; data -> code
    jmp $F0A5 ; print string at $0100 in reverse to current menu position


; menu control code #$B8-#$BF handler: print various item names based on menu format
; indirect control flow target (via $F0DA)
    lda #$0D
    sta $60A0 ; maximum string length

    lda $60AA ; menu format (#$80 = has cursor, #$40 = is linked, #$20 = is single spaced, #$02 = only display equipped items, #$01 = display [left border, equipped] if equipped)

    and #$02
    beq B0F_EE93 ; if this menu only displays equipped items (i.e. it's Menu ID #$1C: Main menu: status screen equipped items), set menu list index $60AC = #$00

    lda #$00
    sta $60AC ; menu list index

; control flow target (from $EE8C)
B0F_EE93:
    lda $609D ; menu function parameter

    cmp #$05
    bcs B0F_EEA6 ; menu control code #$BD-#$BF handler: given shop ID in $60AF and menu list index in $60AC, print name of the corresponding item ID or #$00 if it's the Jailor's Key to $0100; depending on settings, possibly update menu's [left border] to [left border, equipped], then toggle list segment $60AB; if list segment becomes #$01, INC menu list index $60AC

    jsr $F219 ; return the $60AC'th item of item type $609D in A and the party inventory index of that item in X, or #$00 in A and #$FF in X if no such item exists; also sets $60BA,X to #$FF if found and #$00 otherwise

    jsr $F29D ; given party inventory offset in X, print name of that item ID to $0100 in reverse; depending on settings, possibly update menu's [left border] to [left border, equipped]

; print string at $0100 in reverse to current menu position and toggle list segment $60AB; if list segment becomes #$01, INC menu list index $60AC
; control flow target (from $EEAC)
    jsr $F0A5 ; print string at $0100 in reverse to current menu position

    jmp $F321 ; toggle list segment $60AB; if list segment becomes #$01, INC menu list index $60AC


; menu control code #$BD-#$BF handler: given shop ID in $60AF and menu list index in $60AC, print name of the corresponding item ID or #$00 if it's the Jailor's Key to $0100; depending on settings, possibly update menu's [left border] to [left border, equipped], then toggle list segment $60AB; if list segment becomes #$01, INC menu list index $60AC
; control flow target (from $EE98)
B0F_EEA6:
    jsr $F27F ; given shop ID in $60AF and menu list index in $60AC, set A to the corresponding item ID or #$00 if it's the Jailor's Key

    jsr $F2A7 ; print name of item ID in A to $0100 in reverse; depending on settings, possibly update menu's [left border] to [left border, equipped]

    jmp $EEA0 ; print string at $0100 in reverse to current menu position and toggle list segment $60AB; if list segment becomes #$01, INC menu list index $60AC


; menu control code #$C0-#$C7 handler: draw spell name stuff
; indirect control flow target (via $F0DC)
    lda #$09
    sta $60A0 ; maximum string length

    jsr $F335
    jsr $F39F ; given spell name index in A, print spell name to $0100 in reverse, set Y to length of string copied, then load bank specified by $60D7 (set by last call to $F3E2)

    jsr $F0A5 ; print string at $0100 in reverse to current menu position

    inc $60AC ; menu list index

    rts

; menu control code #$C8-#$CF handler: draw item price stuff
; indirect control flow target (via $F0DE)
    jsr $F19F ; initialize string buffer $0100-$010C with [space]s

    lda #$05
    sta $60A0 ; maximum string length

    jsr $F761 ; load ROM bank #$06

    lda $60AD ; item ID

    beq B0F_EEE4
    asl
    tax
    lda $9FFC,X ; Item Prices, low byte

    sta $10
    lda $9FFD,X ; Item Prices, high byte

    sta $11
    lda #$00
    sta $12
    jsr $F09F ; given a 24-bit number N in $10-$12, print its base 10 digits in reverse to $0100 up to maximum string length $60A0, replacing leading (trailing in reverse) zeroes with spaces

; control flow target (from $EECF)
B0F_EEE4:
    jmp $F0A5 ; print string at $0100 in reverse to current menu position


; menu control code #$D0-#$D7 handler: start lists
; indirect control flow target (via $F0E0)
    lda $609D ; menu function parameter

    cmp #$06
    beq B0F_EF13 ; menu control code #$D6 handler: start field spell list

    cmp #$07
    beq B0F_EF25 ; menu control code #$D7 handler: start monster list

    cmp #$05
    bne B0F_EEFC ; menu control code #$D0-#$D4 handler: start item lists

; menu control code #$D5 handler: start shop item list
    jsr $F255 ; given shop ID in $60AF and menu list index in $60AC, set A to the corresponding item ID and X to the number of items in the shop

    txa
    bne B0F_EF09 ; set remaining number of rows for dynamic menu lists to A, set menu read index for start of repeating lists to current menu read index

; menu control code #$D0-#$D4 handler: start item lists
; control flow target (from $EEF4)
B0F_EEFC:
    lda #$00
    sta $60AC ; menu list index

    lda #$00
    sta $60AB ; which list segment we're dealing with

    jsr $F1B7 ; given hero ID in $4A and item type in $609D, set A = number of items of desired type in hero's inventory

; set remaining number of rows for dynamic menu lists to A, set menu read index for start of repeating lists to current menu read index
; control flow target (from $EEFA, $EF22, $EF34)
B0F_EF09:
    sta $60A8 ; remaining number of rows for dynamic menu lists

    lda $60A6 ; current menu read index

    sta $60A7 ; menu read index for start of repeating lists

    rts

; menu control code #$D6 handler: start field spell list
; control flow target (from $EEEC)
B0F_EF13:
    ldy #$00 ; number of learned spells

    ldx $4A ; hero ID

    lda $061A,X ; Cannock's learned field spell list

; control flow target (from $EF1F)
B0F_EF1A:
    asl
    bcc B0F_EF1F ; branch if spell not learned

    iny ; number of learned spells

    tax ; set Z (updated by INY) back to A

; control flow target (from $EF1B)
B0F_EF1F:
    bne B0F_EF1A
    tya ; number of learned spells

    jmp $EF09 ; set remaining number of rows for dynamic menu lists to A, set menu read index for start of repeating lists to current menu read index


; menu control code #$D7 handler: start monster list
; control flow target (from $EEF0)
B0F_EF25:
    ldx #$00 ; number of monster groups

; control flow target (from $EF30)
B0F_EF27:
    lda $061C,X ; monster group 1 monster ID

    beq B0F_EF32
    inx ; this part of monster group data is 2 bytes each

    inx
    cpx #$08 ; maximum 4 groups * 2 bytes each = 8 bytes

    bne B0F_EF27
; control flow target (from $EF2A)
B0F_EF32:
    txa
    lsr ; 2 bytes per group, so divide by 2

    jmp $EF09 ; set remaining number of rows for dynamic menu lists to A, set menu read index for start of repeating lists to current menu read index


; menu control code #$E8-#$EF handler: repeat/end list and full save name handlers
; indirect control flow target (via $F0E6)
    lda $609D ; menu function parameter

    cmp #$02
    beq B0F_EF53 ; menu control code #$EA handler: print Midenhall's full name from save slot in $75DB

    and #$03
    bne B0F_EF5F ; menu control code #$E9 handler: end current repeating list

; menu control code #$E8 handler: update remaining number of rows for dynamic menu lists, reset current menu read index if applicable
    lda $60A8 ; remaining number of rows for dynamic menu lists

    beq B0F_EF52
    dec $60A8 ; remaining number of rows for dynamic menu lists

    beq B0F_EF52
    lda $60A7 ; menu read index for start of repeating lists

    sta $60A6 ; current menu read index

; control flow target (from $EF45, $EF4A)
B0F_EF52:
    rts

; menu control code #$EA handler: print Midenhall's full name from save slot in $75DB
; control flow target (from $EF3C)
B0F_EF53:
    lda #$08
    sta $60A0 ; maximum string length

    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $C5
; data -> code
    jmp $F0A5 ; print string at $0100 in reverse to current menu position


; menu control code #$E9 handler: end current repeating list
; control flow target (from $EF40)
B0F_EF5F:
    lda #$00
    sta $609E ; menu current column

    sta $609D ; menu function parameter

    lda $609F ; menu current row

    and #$01
    eor #$01
    clc
    adc #$01
    adc $609F ; menu current row

    sta $60A3 ; menu window height (ROM value * 2); height = number of rows + 1 if odd, + 2 if even

    lsr
    sta $60A2 ; menu window height (from ROM)

    lda $609F ; menu current row

    and #$01
    bne B0F_EF8D
    lda #$76 ; Tile ID #$76: [left border]

    sta $609B ; menu text

    jsr $EFE4 ; print one byte of menu text

    jmp $ED2E ; menu control code #$80-#$87 handler: print number of spaces specified by $609D (or rest of line if $609D is #$00) to current menu position


; control flow target (from $EF80)
B0F_EF8D:
    rts

; menu control code #$D8-#$DF handler: print selected stat
; indirect control flow target (via $F0E2)
    ldx $609D ; menu function parameter

    lda $F0EE,X ; stat offsets

    pha ; stat offset

    lda #$03
    sta $609D ; menu function parameter

    jsr $F07A ; set maximum string length $60A0 to A and update menu function parameter $609D: if its bits 0-1 are both set, use $4A | bit 2 of $609D, else use the low 3 bits of $609D

    pla ; stat offset

    tax ; stat offset

    ldy #$01 ; number of bytes

    jmp $F096 ; given hero ID in ID $609D, stat offset in X, and stat byte size in Y (max of #$03), print that stat in base 10 to current menu position, replacing leading zeroes with spaces


; menu control code #$E0-#$E7 handler: draw monster text stuff
; indirect control flow target (via $F0E4)
    lda $609D ; menu function parameter

    bne B0F_EFCC
    lda #$0B
    sta $60A0 ; maximum string length

    lda $60AB ; which list segment we're dealing with

    lsr
    bcc B0F_EFB9
    lda #$09
    sta $60A0 ; maximum string length

; control flow target (from $EFB2)
B0F_EFB9:
    lda $60AC ; menu list index

    asl
    tax
    lda $061C,X ; monster group 1 monster ID

    ldx #$00
    jsr $F3B7 ; given monster ID in A, copy monster name segment to $0100 in reverse

    jsr $F0A5 ; print string at $0100 in reverse to current menu position

    jmp $F321 ; toggle list segment $60AB; if list segment becomes #$01, INC menu list index $60AC


; control flow target (from $EFA7)
B0F_EFCC:
    lda #$01
    sta $60A0 ; maximum string length

    lda $60AC ; menu list index

    asl
    tax
    lda $061D,X ; monster group 1 monster count

    sta $10
    jsr $F17C ; given a 24-bit number N in $10-$12, print its base 10 digits in reverse to $0100 up to maximum string length $60A0

    jmp $F0A5 ; print string at $0100 in reverse to current menu position


; menu control code #$F0-#$FF + text handler: print one byte of menu text to current position
; indirect control flow target (via $F0E8, $F0EA, $F0EC)
    jmp $EFE4 ; print one byte of menu text


; print one byte of menu text
; control flow target (from $ED49, $ED51, $ED5C, $EF87, $EFE1, $F0AE, $F332)
    lda $60B4 ; menu phase (1 = first, 0 = second)

    bne B0F_F013 ; update menu current column and row; if it's first phase, skip ahead

    lda $609F ; menu current row

    and #$01
    beq B0F_EFF3
    lda $60A1 ; menu window width

; control flow target (from $EFEE)
B0F_EFF3:
    clc
    adc $609E ; menu current column

    tax
    lda $609B ; menu text

    sta $600B,X
    cmp #$76 ; [left border]

    bcs B0F_F013 ; update menu current column and row

    lda $600A,X
    cmp #$77 ; [top border]

    bne B0F_F013 ; update menu current column and row

    lda $609E ; menu current column

    beq B0F_F013 ; update menu current column and row

    lda #$78 ; [top border short]

    sta $600A,X
; update menu current column and row
; control flow target (from $ED36, $EFE7, $F000, $F007, $F00C)
B0F_F013:
    inc $609E ; menu current column

    lda $609E ; menu current column

    cmp $60A1 ; menu window width

    bcc B0F_F02A ; if current column < window width, nothing else to do here

    ldx #$01 ; otherwise set string length to #$01 (for the left border of the next row)

    stx $60A0 ; maximum string length

    dex ; and reset the current column to #$00

    stx $609E ; menu current column

    inc $609F ; menu current row

; control flow target (from $F01C)
B0F_F02A:
    rts

; control flow target (from $EC1D)
    lda $609F ; menu current row

    and #$01
    ora $609E ; menu current column

    bne B0F_F056
    lda $60B4 ; menu phase (1 = first, 0 = second)

    bne B0F_F056
    lda $60A1 ; menu window width

    lsr
    ora #$10
    sta $607B
    lda $60A4 ; menu window position (from ROM; X-pos = low nybble * 2, Y-pos = high nybble * 2)

    sta $607C
    clc
    adc #$10
    sta $60A4 ; menu window position (from ROM; X-pos = low nybble * 2, Y-pos = high nybble * 2)

    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $C0
; data -> code
    jsr $F0C1 ; write [space] to $600B-$6046

; control flow target (from $F033, $F038)
B0F_F056:
    rts

; CLC if more menu rows to display, SEC otherwise
; control flow target (from $EC20)
    lda $609F ; menu current row

    cmp $60A3 ; menu window height (ROM value * 2)

    rts

; set $60A0 based on menu function parameter $609D and number of remaining tiles in the current line
; control flow target (from $ED33, $ED59)
    lda $609D ; menu function parameter

    bne B0F_F065 ; control codes #$80 and #$88 fill out the rest of the line, so default length to #$FF

    lda #$FF
; control flow target (from $F061)
B0F_F065:
    sta $60A0 ; maximum string length

    clc
    lda $60A1 ; menu window width

    sbc $609E ; menu current column

    bcc B0F_F079 ; branch if we're already done this line

    cmp $60A0 ; maximum string length

    bcs B0F_F079 ; if number of tiles remaining is less than string length, update string length

    sta $60A0 ; maximum string length

; control flow target (from $F06F, $F074)
B0F_F079:
    rts

; set maximum string length $60A0 to A and update menu function parameter $609D: if its bits 0-1 are both set, use $4A | bit 2 of $609D, else use the low 3 bits of $609D
; control flow target (from $ED67, $EDD5, $EE1A, $EE31, $EF9A)
    sta $60A0 ; maximum string length

    lda $609D ; menu function parameter

    pha
    and #$03
    cmp #$03
    bne B0F_F089
    lda $4A
; control flow target (from $F085)
B0F_F089:
    sta $609D ; menu function parameter

    pla
    and #$04
    ora $609D ; menu function parameter

    sta $609D ; menu function parameter

    rts

; given hero ID in ID $609D, stat offset in X, and stat byte size in Y (max of #$03), print that stat in base 10 to current menu position, replacing leading zeroes with spaces
; control flow target (from $ED77, $EDEB, $EE21, $EFA1)
    jsr $F09C ; given hero ID in ID $609D, stat offset in X, and stat byte size in Y (max of #$03), print that stat's base 10 digits in reverse to $0100 up to maximum string length $60A0, replacing leading (trailing in reverse) zeroes with spaces

    jmp $F0A5 ; print string at $0100 in reverse to current menu position


; given hero ID in ID $609D, stat offset in X, and stat byte size in Y (max of #$03), print that stat's base 10 digits in reverse to $0100 up to maximum string length $60A0, replacing leading (trailing in reverse) zeroes with spaces
; control flow target (from $F096)
    jsr $F14A ; given stat offset in X and stat byte size in Y (max of #$03), copy that many bytes of hero ID $609D's stats to $10-$12

; given a 24-bit number N in $10-$12, print its base 10 digits in reverse to $0100 up to maximum string length $60A0, replacing leading (trailing in reverse) zeroes with spaces
; control flow target (from $EE12, $EEE1)
    jsr $F17C ; given a 24-bit number N in $10-$12, print its base 10 digits in reverse to $0100 up to maximum string length $60A0

    jmp $F18D ; scan through $0100 + maximum string length $60A0 in reverse, replacing zeroes with spaces until the first non-zero or $0100 is reached; leaves X at most significant digit


; print string at $0100 in reverse to current menu position
; control flow target (from $EDA4, $EDAA, $EDBC, $EDFE, $EE15, $EE4A, $EE6D, $EE7F, $EEA0, $EEBA, $EEE4, $EF5C, $EFC6, $EFDE, $F099, $F0B4)
B0F_F0A5:
    ldx $60A0 ; maximum string length

    lda a:$FF,X ; built-in offset from string copy buffer start at $0100

    sta $609B ; menu text

    jsr $EFE4 ; print one byte of menu text

    dec $60A0 ; maximum string length

    bne B0F_F0A5 ; print string at $0100 in reverse to current menu position

    rts

; control flow target (from $EC25)
    lda $60AA ; menu format (#$80 = has cursor, #$40 = is linked, #$20 = is single spaced, #$02 = only display equipped items, #$01 = display [left border, equipped] if equipped)

    bpl B0F_F0C0
    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $CC
; data -> code
; control flow target (from $F0BA)
B0F_F0C0:
    rts

; write [space] to $600B-$6046
; control flow target (from $EC29, $F053)
    lda #$5F
    ldx #$3B
; control flow target (from $F0C9)
B0F_F0C5:
    sta $600B,X
    dex
    bpl B0F_F0C5
    rts


; code -> data
; menu control code jump table low byte
; indexed data load target (from $ED21)
; menu control code jump table high byte
.byte $2E
; indexed data load target (from $ED26)
; stat offsets
.byte $ED,$3F,$ED,$65,$ED,$7A,$ED,$CC,$ED,$18,$EE,$24,$EE,$82,$EE,$AF
.byte $EE,$C1,$EE,$E7,$EE,$8E,$EF,$A4,$EF
.byte $37,$EF,$E1,$EF
.byte $E1,$EF
.byte $E1
.byte $EF
; indexed data load target (from $EF91)

.byte $09,$0A,$0B
.byte $0C,$03
.byte $05
; data -> code
; 16-bit multiplication: set 16-bit ($00,X-$01,X) = ($00,X-$01,X) * A
; control flow target (from $FDAC)
; external control flow target (from $06:$B2A8)
    sta $6084
    lda #$00
    sta $6085
    sta $6086
; control flow target (from $F11C)
B0F_F0FF:
    lsr $6084
    bcc B0F_F115
    lda $00,X
    clc
    adc $6085
    sta $6085
    lda $01,X
    adc $6086
    sta $6086
; control flow target (from $F102)
B0F_F115:
    asl $00,X
    rol $01,X
    lda $6084
    bne B0F_F0FF
    lda $6085
    sta $00,X
    lda $6086
    sta $01,X
    rts

; given a 24-bit number N in $10-$12, set $10-$12 to quotient of N / 10 and $13 to the remainder of N / 10, i.e. for base 10 N, $13 = the low digit, $10-$12 = the high digits
; control flow target (from $F17E)
    txa ; save X on the stack

    pha
    lda #$00
    sta $13 ; initialize remainder to #$00

    ldx #$18 ; we're wokring with 24-bit input

; control flow target (from $F145)
B0F_F131:
    asl $10 ; ASL 24-bit value into $13

    rol $11
    rol $12
    rol $13
    sec
    lda $13
    sbc #$0A ; converting to base 10

    bcc B0F_F144 ; if remainder < 10, nothing else to do

    sta $13 ; reduce remainder by 10

    inc $10 ; set quotient bit for next call to $F129

; control flow target (from $F13E)
B0F_F144:
    dex
    bne B0F_F131 ; keep looping until we've gone through all 24 original bits

    pla ; restore X from the stack

    tax
    rts

; given stat offset in X and stat byte size in Y (max of #$03), copy that many bytes of hero ID $609D's stats to $10-$12
; control flow target (from $EDDC, $F09C)
    stx $10
    sty $6084
    lda #$00 ; useless op

    lda $609D ; menu function parameter

    and #$03 ; hero ID

    tax
    beq B0F_F161 ; if Midenhall, no need to adjust offsets

    lda #$00 ; update offset into hero data based on hero ID

; control flow target (from $F15F)
B0F_F15B:
    clc
    adc #$12 ; hero data is #$12 bytes each

    dex
    bne B0F_F15B
; control flow target (from $F157)
B0F_F161:
    clc
    adc $10 ; desired stat offset

    tax
    lda #$00 ; initialize $10-$12 and Y to #$00

    sta $10
    sta $11
    sta $12
    tay
; control flow target (from $F179)
B0F_F16E:
    lda $062D,X ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    sta $0010,Y
    inx
    iny
    cpy $6084
    bne B0F_F16E
    rts

; given a 24-bit number N in $10-$12, print its base 10 digits in reverse to $0100 up to maximum string length $60A0
; control flow target (from $EFDB, $F09F, $F48C)
; external control flow target (from $02:$BE4A)
    ldy #$00
; control flow target (from $F18A)
B0F_F17E:
    jsr $F129 ; given a 24-bit number N in $10-$12, set $10-$12 to quotient of N / 10 and $13 to the remainder of N / 10, i.e. for base 10 N, $13 = the low digit, $10-$12 = the high digits

    lda $13 ; remainder

    sta $0100,Y ; string copy buffer start (often referenced as $00FF,X)

    iny
    cpy $60A0 ; maximum string length

    bne B0F_F17E ; if more digits to print, keep printing

    rts

; scan through $0100 + maximum string length $60A0 in reverse, replacing zeroes with spaces until the first non-zero or $0100 is reached; leaves X at most significant digit
; control flow target (from $F0A2, $F48F)
; external control flow target (from $02:$BE4D)
    ldx $60A0 ; maximum string length

    dex
; control flow target (from $F19C)
B0F_F191:
    lda $0100,X ; string copy buffer start (often referenced as $00FF,X)

    bne B0F_F19E
    lda #$5F
    sta $0100,X ; string copy buffer start (often referenced as $00FF,X)

    dex
    bne B0F_F191
; control flow target (from $F194)
B0F_F19E:
    rts

; initialize string buffer $0100-$010C with [space]s
; control flow target (from $ED88, $EEC1, $F2F0, $F3A0, $F3D7)
    pha
    txa
    pha
    ldx #$0C
    lda #$5F ; [space]

; control flow target (from $F1AA)
B0F_F1A6:
    sta $0100,X ; string copy buffer start (often referenced as $00FF,X)

    dex
    bpl B0F_F1A6
    pla
    tax
    pla
    rts

; given a hero ID in $4A, set A and X to hero ID * 8, a.k.a. offset for start of hero's inventory
; control flow target (from $F1B7, $F22D)
; external control flow target (from $06:$AE05)
    lda $4A
    asl
    asl
    asl
    tax
    rts

; given hero ID in $4A and item type in $609D, set A = number of items of desired type in hero's inventory
; control flow target (from $EC5E, $EF06, $F4B7, $F5C3, $F605)
    jsr $F1B0 ; given a hero ID in $4A, set A and X to hero ID * 8, a.k.a. offset for start of hero's inventory

    ldy #$00
    sty $10 ; number of items in hero's inventory

; control flow target (from $F1D1)
B0F_F1BE:
    lda $0600,X ; Midenhall inventory item 1 (| #$40 if equipped)

    beq B0F_F1CD ; branch if no item

    jsr $F1D6 ; determine item type (#$00 = weapon, #$01 = armour, #$02 = shield, #$03 = helmet, #$04 = menu function wants all items or item is non-equipment, #$05 = menu format wants equipped items only and item not equipped)

    cmp $609D ; menu function parameter

    bne B0F_F1CD ; branch if wrong type of item

    inc $10 ; number of items of desired type in hero's inventory

; control flow target (from $F1C1, $F1C9)
B0F_F1CD:
    inx ; increment total inventory offset

    iny ; increment hero inventory offset

    cpy #$08 ; 8 inventory slots per hero

    bne B0F_F1BE ; if more inventory to check, check it

    lda $10 ; number of items of desired type in hero's inventory

    rts

; determine item type (#$00 = weapon, #$01 = armour, #$02 = shield, #$03 = helmet, #$04 = menu function wants all items or item is non-equipment, #$05 = menu format wants equipped items only and item not equipped)
; control flow target (from $F1C3, $F235)
; external control flow target (from $06:$AE10)
    pha ; item ID

    lda $60AA ; menu format (#$80 = has cursor, #$40 = is linked, #$20 = is single spaced, #$02 = only display equipped items, #$01 = display [left border, equipped] if equipped)

    and #$02
    beq B0F_F1E4
    pla ; item ID

    pha ; item ID

    and #$40 ; #$40 => equipped

    beq B0F_F205 ; item is not equipped

; control flow target (from $F1DC)
B0F_F1E4:
    lda $609D ; menu function parameter

    cmp #$04 ; #$04 => count all items as non-equipment

    beq B0F_F215 ; item is non-equipment

    pla ; item ID

    and #$3F ; strip off equipped bit

    cmp #$00 ; no item

    beq B0F_F216
    cmp #$11 ; first armour ID

    bcc B0F_F209 ; item is a weapon

    cmp #$1C ; first shield ID

    bcc B0F_F20C ; item is an armour

    cmp #$21 ; first helmet ID

    bcc B0F_F20F ; item is a shield

    cmp #$24 ; first non-equipment item ID

    bcc B0F_F212 ; item is a helmet

    lda #$04 ; item is non-equipment

    rts

; item is not equipped
; control flow target (from $F1E2)
B0F_F205:
    pla
    lda #$05
    rts

; item is a weapon
; control flow target (from $F1F4)
B0F_F209:
    lda #$00
    rts

; item is an armour
; control flow target (from $F1F8)
B0F_F20C:
    lda #$01
    rts

; item is a shield
; control flow target (from $F1FC)
B0F_F20F:
    lda #$02
    rts

; item is a helmet
; control flow target (from $F200)
B0F_F212:
    lda #$03
    rts

; item is non-equipment
; control flow target (from $F1E9)
B0F_F215:
    pla
; control flow target (from $F1F0)
B0F_F216:
    lda #$04
    rts

; return the $60AC'th item of item type $609D in A and the party inventory index of that item in X, or #$00 in A and #$FF in X if no such item exists; also sets $60BA,X to #$FF if found and #$00 otherwise
; control flow target (from $EE9A)
    lda $60AC ; menu list index

    and #$03
    tax
    lda #$FF
    sta $60BA,X
    lda $60AC ; menu list index

    and #$07
    sta $10
    inc $10
    jsr $F1B0 ; given a hero ID in $4A, set A and X to hero ID * 8, a.k.a. offset for start of hero's inventory

; control flow target (from $F245)
B0F_F230:
    lda $0600,X ; Midenhall inventory item 1 (| #$40 if equipped)

    beq B0F_F247
    jsr $F1D6 ; determine item type (#$00 = weapon, #$01 = armour, #$02 = shield, #$03 = helmet, #$04 = menu function wants all items or item is non-equipment, #$05 = menu format wants equipped items only and item not equipped)

    cmp $609D ; menu function parameter

    bne B0F_F241
    dec $10
    beq B0F_F254
; control flow target (from $F23B)
B0F_F241:
    inx
    txa
    and #$07
    bne B0F_F230
; control flow target (from $F233)
B0F_F247:
    lda $60AC ; menu list index

    and #$03
    tax
    lda #$00
    sta $60BA,X
    ldx #$FF
; control flow target (from $F23F)
B0F_F254:
    rts

; given shop ID in $60AF and menu list index in $60AC, set A to the corresponding item ID and X to the number of items in the shop
; control flow target (from $EEF6)
    jsr $F761 ; load ROM bank #$06

    lda $60AF ; shop ID

    asl
    sta $10
    asl
    adc $10 ; A = A * 6; 6 items per shop

    tay
    sty $10 ; start of shop's inventory list

    ldx #$00 ; number of items in shop

; control flow target (from $F26F)
B0F_F266:
    lda $9F8A,Y ; Weapon Shop inventories

    beq B0F_F271 ; #$00 marks the end of shop's item list

    inx
    iny
    cpx #$06 ; 6 items per shop

    bne B0F_F266 ; if more items to check, check them

; control flow target (from $F269)
B0F_F271:
    lda $60AC ; menu list index

    clc
    adc $10 ; start of shop's inventory list

    tay ; selected item

    lda $9F8A,Y ; Weapon Shop inventories

    rts

; given shop ID in $60AF and menu list index in $60AC, set A to the corresponding item ID
; control flow target (from $F62F)
    jmp $F289 ; given shop ID in $60AF and menu list index in $60AC, set A to the corresponding item ID


; given shop ID in $60AF and menu list index in $60AC, set A to the corresponding item ID or #$00 if it's the Jailor's Key
; control flow target (from $EEA6)
    jsr $F289 ; given shop ID in $60AF and menu list index in $60AC, set A to the corresponding item ID

    cmp #$39 ; Item ID #$39: Jailor’s Key

    bne B0F_F288 ; if Jailor's Key, display [blank] instead

    lda #$00
; control flow target (from $F284)
B0F_F288:
    rts

; given shop ID in $60AF and menu list index in $60AC, set A to the corresponding item ID
; control flow target (from $F27C, $F27F)
    jsr $F761 ; load ROM bank #$06

    lda $60AF ; shop ID

    asl
    sta $10
    asl
    adc $10 ; A = A * 6; 6 items per shop

    adc $60AC ; menu list index

    tax
    lda $9F8A,X ; Weapon Shop inventories

    rts

; given party inventory offset in X, print name of that item ID to $0100 in reverse; depending on settings, possibly update menu's [left border] to [left border, equipped]
; control flow target (from $EE9D)
    jsr $F2F0 ; initialize string buffer $0100-$010C with [space]s, set maximum string length to #$0B if we're dealing with the second segment

    cpx #$FF
    beq B0F_F2EF
    lda $0600,X ; Midenhall inventory item 1 (| #$40 if equipped)

; print name of item ID in A to $0100 in reverse; depending on settings, possibly update menu's [left border] to [left border, equipped]
; control flow target (from $EEA9)
; external control flow target (from $02:$BE95)
    sta $60AD ; item ID

    and #$40 ; pick out the equipped bit

    beq B0F_F2B4 ; skip ahead if item is not equipped

    lda $60AC ; menu list index

    sta $60B9
; control flow target (from $F2AC)
B0F_F2B4:
    jsr $F2F0 ; initialize string buffer $0100-$010C with [space]s, set maximum string length to #$0B if we're dealing with the second segment

    lda $60AB ; which list segment we're dealing with

    and #$01 ; pretty sure the only options are 0 and 1, so this seems useless

    beq B0F_F2C0 ; if 0, use 0

    lda #$01 ; else use 1 (... but it already was 1)

; control flow target (from $F2BC)
B0F_F2C0:
    tay ; set item pointer list index

    lda $60AD ; item ID

    pha ; item ID

    and #$40 ; pick out the equipped bit

    beq B0F_F2E4 ; if not equipped, skip ahead

    lda $60AA ; menu format (#$80 = has cursor, #$40 = is linked, #$20 = is single spaced, #$02 = only display equipped items, #$01 = display [left border, equipped] if equipped)

    lsr
    bcc B0F_F2E4 ; if not replacing [left border] with [left border, equipped], skip ahead

    lda $60AB ; which list segment we're dealing with

    lsr
    bcs B0F_F2E4 ; if not dealing with list segmetn 1, skip ahead

    lda #$00 ; otherwise reset current column

    sta $609E ; menu current column

    lda #$8B ; [left border, equipped]

    jsr $F32F ; print A to menu

    lda #$5F ; [space]

    jsr $F32F ; print A to menu

; control flow target (from $F2C7, $F2CD, $F2D3)
B0F_F2E4:
    pla ; item ID

    and #$3F ; strip off the equipped bit

    sta $60AD ; item ID

    beq B0F_F2EF ; if no item, just RTS

    jsr $F2FF ; given item ID in A, print name of item to $0100 in reverse

; control flow target (from $F2A2, $F2EA)
B0F_F2EF:
    rts

; initialize string buffer $0100-$010C with [space]s, set maximum string length to #$0B if we're dealing with the second segment
; control flow target (from $F29D, $F2B4)
    jsr $F19F ; initialize string buffer $0100-$010C with [space]s

    lda $60AB ; which list segment we're dealing with

    lsr
    bcc B0F_F2FE ; if first segment, skip ahead

    lda #$0B ; max length of second segment

    sta $60A0 ; maximum string length

; control flow target (from $F2F7)
B0F_F2FE:
    rts

; given item ID in A, print name of item to $0100 in reverse
; control flow target (from $F2EC)
    pha ; item ID

    cmp #$21 ; split point for item list pointers

    bcc B0F_F30A ; if < #$21, use the first set of pointers

    pla ; item ID

    sbc #$20 ; adjust item ID for second set of pointers; note that C is set since we got here by not taking BCC

    iny ; pointer address += 2

    iny
    pha ; item ID within list segment

; control flow target (from $F302)
B0F_F30A:
    lda $F316,Y ; item list bank/pointers

    jsr $F3E2 ; parse bank/pointer indices from A, load desired bank, set $57-$58 to desired pointer value

    pla ; item ID within list segment

    beq B0F_F31A ; load bank specified by $60D7 (set by last call to $F3E2)

    jmp $F3F8 ; find desired list item A (one-based) in ($57), copy it to $0100 (referenced as $00FF,X) in reverse; set Y to length of string copied, then load bank specified by $60D7 (set by last call to $F3E2)



; code -> data
; item list bank/pointers
; indexed data load target (from $F30A)

.byte $D1,$D2
.byte $D8
.byte $D9
; data -> code
; load bank specified by $60D7 (set by last call to $F3E2)
; control flow target (from $F311, $F3FB)
B0F_F31A:
    pha
    lda $60D7 ; backup copy of current bank set by calls to $F3E2; used by $F31A

    jmp $F782 ; load bank specified by A then PLA


; toggle list segment $60AB; if list segment becomes #$01, INC menu list index $60AC
; control flow target (from $EEA3, $EFC9)
    lda $60AB ; which list segment we're dealing with

    eor #$01
    bne B0F_F32B
    inc $60AC ; menu list index

; control flow target (from $F326)
B0F_F32B:
    sta $60AB ; which list segment we're dealing with

    rts

; print A to menu
; control flow target (from $F2DC, $F2E1)
    sta $609B ; menu text

    jmp $EFE4 ; print one byte of menu text


; control flow target (from $EEB4)
    ldx $60AC ; menu list index

    lda #$FF
    sta $60BA,X
    lda $609D ; menu function parameter

    asl ; A is either #$00 (battle spells) or #$01 (field spells), so this is either #$00 or #$02

    adc $4A ; hero ID - 1

    tax
    lda $0618,X ; Cannock's learned battle spell list

    sta $10 ; selected hero's learned spell list

    lda #$80
    sta $11
    lda $60AC ; menu list index

    ldx $609D ; menu function parameter

    bne B0F_F35A ; branch if field spells

    lsr
    ldx #$88
    stx $11
; control flow target (from $F353)
B0F_F35A:
    tax
; control flow target (from $F360)
B0F_F35B:
    dex
    bmi B0F_F362
    lsr $11
    bcc B0F_F35B
; control flow target (from $F35C)
B0F_F362:
    lda $609D ; menu function parameter

    and #$01
    bne B0F_F376 ; branch if field spells

    lda $60AC ; menu list index

    and #$01
    tax
    lda $F39D,X
    and $11
    sta $11
; control flow target (from $F367)
B0F_F376:
    lda $10 ; selected hero's learned spell list

    and $11
    beq B0F_F392
    lda $4A ; hero ID - 1

    asl
    asl
    asl
    asl
    pha
    lda $609D ; menu function parameter

    asl
    asl
    asl
    sta $12
    pla
    adc $12
    adc $60AC ; menu list index

    rts

; control flow target (from $F37A)
B0F_F392:
    lda #$00
    ldx $60AC ; menu list index

    sta $60BA,X
    lda #$FF
    rts


; code -> data
; indexed data load target (from $F36F)

.byte $F0
.byte $0F
; data -> code
; given spell name index in A, print spell name to $0100 in reverse, set Y to length of string copied, then load bank specified by $60D7 (set by last call to $F3E2)
; control flow target (from $EEB7)
; external control flow target (from $02:$BEA5)
    pha ; spell name index

    jsr $F19F ; initialize string buffer $0100-$010C with [space]s

    pla ; spell name index

    sta $10 ; spell name index

    cmp #$FF
    beq B0F_F3B6 ; #$FF => not a real spell

    lda #$D3 ; spell list bank/pointer

    jsr $F3E2 ; parse bank/pointer indices from A, load desired bank, set $57-$58 to desired pointer value

    ldx $10 ; spell name index

    inx ; $F3F8 is one-based, so convert from zero-based

    txa
    jsr $F3F8 ; find desired list item A (one-based) in ($57), copy it to $0100 (referenced as $00FF,X) in reverse; set Y to length of string copied, then load bank specified by $60D7 (set by last call to $F3E2)

; control flow target (from $F3A8)
B0F_F3B6:
    rts

; given monster ID in A, copy monster name segment to $0100 in reverse
; control flow target (from $EFC3, $FC98, $FCB5)
    sta $10 ; save desired monster index for later (both here and in calling code)

    stx $11 ; pointless?

    ldy #$00 ; start by assuming we're dealing with Monsters 1 Line 1 (LDY $60AB would save 6 bytes?)

    lda $60AB ; which list segment we're dealing with

    lsr ; shift low bit to C

    bcc B0F_F3C4 ; C = 0 => first segment, so keep Y at #$00

    iny ; otherwise it's the second segment, so set Y = #$01

; control flow target (from $F3C1)
B0F_F3C4:
    lda $10 ; restore monster index

    pha ; save monster index

    cmp #$33 ; is monster index < 51?

    bcc B0F_F3D1 ; if monster index < 51, skip ahead

    pla ; pop old monster index

    sbc #$32 ; otherwise subtract 50

    iny ; and use the second half of the pointer list

    iny
    pha ; push new monster index

; control flow target (from $F3C9)
B0F_F3D1:
    lda $F3DE,Y ; monster list bank/pointers

    jsr $F3E2 ; parse bank/pointer indices from A, load desired bank, set $57-$58 to desired pointer value

    jsr $F19F ; initialize string buffer $0100-$010C with [space]s

    pla ; monster index

    jmp $F3F8 ; find desired list item A (one-based) in ($57), copy it to $0100 (referenced as $00FF,X) in reverse; set Y to length of string copied, then load bank specified by $60D7 (set by last call to $F3E2)



; code -> data
; monster list bank/pointers
; indexed data load target (from $F3D1)

.byte $D4,$D5
.byte $DA
.byte $DB
; data -> code
; parse bank/pointer indices from A, load desired bank, set $57-$58 to desired pointer value
; control flow target (from $EBB4, $F30D, $F3AC, $F3D4)
    pha
    lda $05F6 ; current bank

    sta $60D7 ; backup copy of current bank set by calls to $F3E2; used by $F31A

    pla
    jsr $FF33 ; parse A into bank and pointer indices and load specified bank

    lda $8000,X
    sta $57 ; pointer to start of main pointer table, low byte

    lda $8001,X
    sta $58 ; pointer to start of main pointer table, high byte

    rts

; find desired list item A (one-based) in ($57), copy it to $0100 (referenced as $00FF,X) in reverse; set Y to length of string copied, then load bank specified by $60D7 (set by last call to $F3E2)
; control flow target (from $F313, $F3B3, $F3DB)
    jsr $F3FE ; find desired list item A (one-based) in ($57), copy it to $0100 (referenced as $00FF,X) in reverse; set Y to length of string copied

    jmp $F31A ; load bank specified by $60D7 (set by last call to $F3E2)


; find desired list item A (one-based) in ($57), copy it to $0100 (referenced as $00FF,X) in reverse; set Y to length of string copied
; control flow target (from $F3F8)
    tax
    ldy #$00
; control flow target (from $F412, $F416)
B0F_F401:
    dex
    beq B0F_F418
; control flow target (from $F40B, $F40F)
B0F_F404:
    lda ($57),Y ; pointer to start of main pointer table, low byte; scan through ($57),Y, counting #$FF bytes until we've reached the right list item

    cmp #$FF
    beq B0F_F411
    iny
    bne B0F_F404
    inc $58 ; pointer to start of main pointer table, high byte

    bne B0F_F404
; control flow target (from $F408)
B0F_F411:
    iny
    bne B0F_F401
    inc $58 ; pointer to start of main pointer table, high byte

    bne B0F_F401
; control flow target (from $F402)
B0F_F418:
    tya
    clc
    adc $57 ; pointer to start of main pointer table, low byte

    sta $57 ; pointer to start of main pointer table, low byte

    bcc B0F_F422
    inc $58 ; pointer to start of main pointer table, high byte

; control flow target (from $F41E)
B0F_F422:
    ldy #$00
    ldx $60A0 ; maximum string length

; control flow target (from $F432)
B0F_F427:
    lda ($57),Y ; pointer to start of main pointer table, low byte

    cmp #$FF
    beq B0F_F434
    sta a:$FF,X ; built-in offset from string copy buffer start at $0100

    iny
    dex
    bne B0F_F427
; control flow target (from $F42B, $F437)
B0F_F434:
    rts

; control flow target (from $EBA2)
    lda $8E ; flag for in battle or not (#$FF)?

    bne B0F_F434
    lda $4D
    sta $0C
    lda $4E
    sta $0E
    jsr $DE2D
    ldy #$00
    sty $12
    lda $60A3 ; menu window height (ROM value * 2)

    lsr
    sta $10
; control flow target (from $F467)
B0F_F44E:
    lda $60A1 ; menu window width

    lsr
    sta $11
    lda #$01
; control flow target (from $F45B)
B0F_F456:
    sta ($07),Y ; mark menu open

    iny
    dec $11
    bne B0F_F456
    lda $12
    clc
    adc #$10
    sta $12
    tay
    dec $10
    bne B0F_F44E
    lda $35 ; flag indicating whether any menu is currently open

    pha
    lda #$FF
    sta $35 ; flag indicating whether any menu is currently open

    jsr $D8CB
    pla
    sta $35 ; flag indicating whether any menu is currently open

    jmp $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF


; print party gold to $0100 in decimal in reverse, replacing leading (now trailing) zeroes with spaces, leaving X at most significant digit
; control flow target (from $EDA7)
    lda #$05
    sta $60A0 ; maximum string length

    lda $0624 ; party gold, low byte

    sta $10
    lda $0625 ; party gold, high byte

    sta $11
    lda #$00
    sta $12
    jsr $F17C ; given a 24-bit number N in $10-$12, print its base 10 digits in reverse to $0100 up to maximum string length $60A0

    jmp $F18D ; scan through $0100 + maximum string length $60A0 in reverse, replacing zeroes with spaces until the first non-zero or $0100 is reached; leaves X at most significant digit


; display Menu ID #$02: Main menu: gold/crests
; external control flow target (from $06:$89DC)
    lda #$02 ; Menu ID #$02: Main menu: gold/crests

    jmp $EB89 ; open menu specified by A


; display Menu ID #$03: Main menu: selected hero's status
; external control flow target (from $06:$89D6)
    sta $4A
    lda #$03 ; Menu ID #$03: Main menu: selected hero's status

    jmp $EB89 ; open menu specified by A


; external control flow target (from $04:$B5D8)
    sta $4A
    lda #$07 ; Menu ID #$07: Battle menu: spell list

    jsr $EB89 ; open menu specified by A

    cmp #$FF
    beq B0F_F4AD
    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $CA
; data -> code
; control flow target (from $F4A7)
B0F_F4AD:
    jmp $F6C2 ; load bank specified by $94


; given hero ID in A, display that hero's battle item list window and return the selected item ID in A
; external control flow target (from $04:$B5E1)
    sta $4A ; hero ID

    lda #$04 ; count all items

    sta $609D ; menu function parameter

    jsr $F1B7 ; given hero ID in $4A and item type in $609D, set A = number of items of desired type in hero's inventory

    beq B0F_F4EC ; no items => set A = #$FE and RTS

    lda #$08 ; Menu ID #$08: Battle menu: item list window 1

; control flow target (from $F4CD)
B0F_F4BE:
    jsr $EB89 ; open menu specified by A

    ldx $60B1
    bne B0F_F4CF
    cmp #$FF
    beq B0F_F4E9
    lda $60AE ; menu link ID

    bne B0F_F4BE
; control flow target (from $F4C4)
B0F_F4CF:
    ldx $60AE ; menu link ID

    cpx #$08 ; Menu ID #$08: Battle menu: item list window 1

    bne B0F_F4DD ; menu link ID != #$08 => we're currently in Menu ID #$08: Battle menu: item list window 1, so no need to adjust A

    cmp #$FF ; #$FF stays #$FF

    beq B0F_F4E9
    clc ; otherwise, we're in Menu ID #$22: Battle menu: item list window 2; menu displays 4 items per page, so add 4 to the selected item index

    adc #$04
; control flow target (from $F4D4)
B0F_F4DD:
    ldx #$04 ; count all items

    cmp #$FE
    bcs B0F_F4E9
    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $C8
; data -> code
    and #$3F ; strip off the equipped bit

; control flow target (from $F4C8, $F4D8, $F4E1)
B0F_F4E9:
    jmp $F6C2 ; load bank specified by $94


; control flow target (from $F4BA)
B0F_F4EC:
    lda #$FE
    rts

; open battle command menu for hero A
; external control flow target (from $04:$B56E)
    sta $4A
    tax
    beq B0F_F511 ; if it's Midenhall, just display Midenhall's command menu

    cpx #$01
    bne B0F_F4FF ; branch if not Cannock

    bit $062D ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    bpl B0F_F50D ; Cannock: if Midenhall is dead, display alternate Cannock command menu

    bvs B0F_F50D ; Cannock: if Midenhall is asleep, display alternate Cannock command menu

; control flow target (from $F4F6)
B0F_F4FF:
    bit $062D ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    bpl B0F_F506 ; Cannock would have taken the earlier BPL, so this is just Moonbrooke: if Midenhall is dead, check Cannock

    bvc B0F_F511 ; Cannock/Moonbrooke: if Midenhall is awake, display normal Cannock/Moonbrooke command menu

; control flow target (from $F502)
B0F_F506:
    bit $063F ; Cannock status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    bpl B0F_F50D ; Cannock must have taken one of the earlier BPL/BVS/BVC, so this is just Moonbrooke: if Cannock is dead, display alternate Moonbrooke command menu

    bvc B0F_F511 ; Cannock must have taken one of the earlier BPL/BVS/BVC, so this is just Moonbrooke: if Cannock is awake, display normal Moonbrooke command menu

; control flow target (from $F4FB, $F4FD, $F509)
B0F_F50D:
    ldx #$03 ; index for alternate command menu

    bne B0F_F511 ; useless op

; control flow target (from $F4F2, $F504, $F50B, $F50F)
B0F_F511:
    lda $F517,X ; Battle command menus

    jmp $EB89 ; open menu specified by A



; code -> data
; Battle command menus
; indexed data load target (from $F511)

.byte $09,$23
.byte $23
.byte $49
; data -> code
; display appropriate battle menu monster list
; external control flow target (from $04:$B5A9)
    lda $4B ; flag for whether to display the selectable or non-selectable monster list

    bne B0F_F524 ; display Menu ID #$05: Battle menu: monster list, non-selectable

    lda #$0A ; Menu ID #$0A: Battle menu: monster list, selectable

    jmp $EB89 ; open menu specified by A


; display Menu ID #$05: Battle menu: monster list, non-selectable
; control flow target (from $F51D)
B0F_F524:
    lda #$05 ; Menu ID #$05: Battle menu: monster list, non-selectable

    jmp $EB89 ; open menu specified by A


; display appropriate battle menu item/spell target
; external control flow target (from $04:$B5E8)
    jsr $F65A ; set A and X to the current number of party members

    beq B0F_F534 ; if just Midenhall, no need to display hero select menu

    lda $F534,X
    jsr $EB89 ; open menu specified by A

; control flow target (from $F52C)
; indexed data load target (from $F52E)
B0F_F534:
    rts


; code -> data
; Battle item/spell target menus

.byte $0B
.byte $24
; data -> code
; display hero select STATUS menu if necessary
; external control flow target (from $06:$89CA)
    jsr $F65A ; set A and X to the current number of party members

    beq B0F_F542 ; if just Midenhall, no need to display hero select menu

    lda $F542,X
    jsr $EB89 ; open menu specified by A

; control flow target (from $F53A)
; indexed data load target (from $F53C)
B0F_F542:
    rts


; code -> data
; main STATUS hero select menus

.byte $0C
.byte $25
; data -> code
; depending on number of casters in party, maybe open caster select menu
; external control flow target (from $06:$8B36)
    jsr $F65A ; set A and X to the current number of party members

    beq B0F_F55A ; if just Midenhall, no need to display hero select menu

    dex
    beq B0F_F557 ; if only 2 party members, Midenhall can't use magic, so no need to display menu

    lda #$0D ; Menu ID #$0D: Main menu: SPELL with Cannock + Moonbrooke

    jsr $EB89 ; open menu specified by A

    cmp #$FF
    beq B0F_F559 ; this is never true?

    tax
; control flow target (from $F54B)
B0F_F557:
    inx
    txa
; control flow target (from $F554)
B0F_F559:
    rts

; control flow target (from $F548)
B0F_F55A:
    lda #$FE
    rts

; display appropriate main ITEM hero select menu
; external control flow target (from $06:$955B, $06:$9CC9)
    jsr $F65A ; set A and X to the current number of party members

    beq B0F_F568 ; if just Midenhall, no need to display hero select menu

    lda $F568,X
    jsr $EB89 ; open menu specified by A

; control flow target (from $F560)
; indexed data load target (from $F562)
B0F_F568:
    rts


; code -> data
; main ITEM hero select menus

.byte $0E
.byte $26
; data -> code
; display appropriate main EQUIP hero select menu
; external control flow target (from $06:$8A02)
    jsr $F65A ; set A and X to the current number of party members

    beq B0F_F576 ; if just Midenhall, no need to display hero select menu

    lda $F576,X
    jsr $EB89 ; open menu specified by A

; control flow target (from $F56E)
; indexed data load target (from $F570)
B0F_F576:
    rts


; code -> data
; main EQUIP hero select menus

.byte $0F
.byte $27
; data -> code
; display appropriate main SPELL target menu
; external control flow target (from $06:$8B98)
    jsr $F65A ; set A and X to the current number of party members

    beq B0F_F584 ; if just Midenhall, no need to display hero select menu

    lda $F584,X
    jsr $EB89 ; open menu specified by A

; control flow target (from $F57C)
; indexed data load target (from $F57E)
B0F_F584:
    rts


; code -> data
; main COMMAND menu SPELL target menus

.byte $10
.byte $28
; data -> code
; display appropriate main ITEM target menu
; external control flow target (from $06:$95B1, $06:$9629, $06:$99C1)
    jsr $F65A ; set A and X to the current number of party members

    beq B0F_F592 ; if just Midenhall, no need to display hero select menu

    lda $F592,X
    jsr $EB89 ; open menu specified by A

; control flow target (from $F58A)
; indexed data load target (from $F58C)
B0F_F592:
    rts


; code -> data
; main COMMAND menu ITEM target menus

.byte $11
.byte $29
; data -> code
; display appropriate shop BUY/SELL hero select menu
; external control flow target (from $06:$830E, $06:$8427, $06:$8490, $06:$8589, $06:$85D2, $06:$862B)
    jsr $F65A ; set A and X to the current number of party members

    beq B0F_F5A0 ; if just Midenhall, no need to display hero select menu

    lda $F5A0,X
    jsr $EB89 ; open menu specified by A

; control flow target (from $F598)
; indexed data load target (from $F59A)
B0F_F5A0:
    rts


; code -> data
; shop menu BUY/SELL hero select menus

.byte $12
.byte $2A
; data -> code
; given a hero ID in A and an item type in X, display the EQUIP sub-menu for hero A and item type X, returning the selected item ID in A
; ##>hero ID
; external control flow target (from $06:$8A1D, $06:$8A2E)
    sta $4A
    stx $96 ; temp storage for item/spell/type/etc. IDs; item type

    lda $F5E8,X ; EQUIP sub-menu IDs

    pha ; EQUIP sub-menu ID

    lda $A5
    pha
    jsr $D0EC ; update each hero's stats based on their current EXP

    pla
    sta $A5
    lda #$07
    jsr $F78C ; wipe selected menu region

    lda $96 ; temp storage for item/spell/type/etc. IDs; item type

    sta $609D ; menu function parameter

    lda #$00
    sta $60AA ; menu format (#$80 = has cursor, #$40 = is linked, #$20 = is single spaced, #$02 = only display equipped items, #$01 = display [left border, equipped] if equipped)

    jsr $F1B7 ; given hero ID in $4A and item type in $609D, set A = number of items of desired type in hero's inventory

    bne B0F_F5D6 ; if hero has items of this type, branch to display the EQUIP sub-menu

    pla ; EQUIP sub-menu ID

    cmp #$2F ; Menu ID #$2F: Main menu: equip helmet

    bne B0F_F5D2 ; if we're processing the final EQUIP sub-menu but hero has no helmets, leave the current Attack/Defense menu on the screen for a bit

    lda #$48 ; Menu ID #$48: Main menu: Equip menu's current Attack/Defense

    jsr $EB89 ; open menu specified by A

; control flow target (from $F5CB)
B0F_F5D2:
    lda #$FE
    bne B0F_F5E5 ; load bank specified by $94

; control flow target (from $F5C6)
B0F_F5D6:
    lda #$48 ; Menu ID #$48: Main menu: Equip menu's current Attack/Defense

    jsr $EB89 ; open menu specified by A

    pla ; EQUIP sub-menu

    jsr $EB89 ; open menu specified by A

    ldx $96 ; temp storage for item/spell/type/etc. IDs; item type

    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $C8
; data -> code
; load bank specified by $94
; control flow target (from $F5D4, $F5F5)
B0F_F5E5:
    jmp $F6C2 ; load bank specified by $94



; code -> data
; EQUIP sub-menu IDs
; indexed data load target (from $F5A7)

.byte $13,$2D
.byte $2E
.byte $2F
; data -> code
; given hero ID - 1 in A, open hero's spell list and return selected spell ID in A
; external control flow target (from $06:$8B6E)
    sta $4A ; hero ID - 1

    lda #$14 ; Menu ID #$14: Main menu: spell list

    jsr $EB89 ; open menu specified by A

    cmp #$FF
    beq B0F_F5E5 ; load bank specified by $94

    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $C9
; data -> code
    jmp $F6C2 ; load bank specified by $94


; given a hero ID in A, open hero's item list and return selected item ID (or #$FE if they have no items)
; external control flow target (from $06:$84C1, $06:$9564, $06:$9CD8)
    sta $4A ; hero ID

    lda #$04 ; count all items

    sta $609D ; menu function parameter

    jsr $F1B7 ; given hero ID in $4A and item type in $609D, set A = number of items of desired type in hero's inventory

    beq B0F_F618 ; if no items, don't open the item list

    lda #$15 ; Menu ID #$15: Main menu: item list

    jsr $EB89 ; open menu specified by A

    ldx #$04 ; parameter for $06:$ADFC: count all items

    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $C8
; data -> code
    jmp $F6C2 ; load bank specified by $94


; control flow target (from $F608)
B0F_F618:
    lda #$FE
    rts

; display shop menu item list for shop ID given in A, returning selected item (with Jailor's Key replaced by blank) in A
; external control flow target (from $06:$82DE, $06:$83CA)
    sta $60AF ; shop ID

    lda #$1B ; Menu ID #$1B: Shop menu: current gold

    jsr $EB89 ; open menu specified by A

    lda #$16 ; Menu ID #$16: Shop menu: Item BUY list

    jsr $EB89 ; open menu specified by A

    cmp #$FF
    beq B0F_F638
    sta $60AC ; menu list index

    jsr $F27C ; given shop ID in $60AF and menu list index in $60AC, set A to the corresponding item ID

    cmp #$39 ; Item ID #$39: Jailor’s Key

    bne B0F_F638
    lda #$00
; control flow target (from $F62A, $F634)
B0F_F638:
    jmp $F6C2 ; load bank specified by $94


; display Menu ID #$1C: Main menu: status screen equipped items
; external control flow target (from $06:$89E1)
    sta $4A
    lda #$1C ; Menu ID #$1C: Main menu: status screen equipped items

    jmp $EB89 ; open menu specified by A


; display appropriate battle EXP + Gold menu
; external control flow target (from $04:$9940)
    jsr $F65A ; set A and X to the current number of party members

    lda $F64B,X ; Battle menu EXP + Gold

    jmp $EB89 ; open menu specified by A



; code -> data
; Battle menu EXP + Gold
; indexed data load target (from $F645)

.byte $1D,$2B
.byte $2C
; data -> code
; display spell lists
; external control flow target (from $06:$89FC)
    sta $4A
    lda #$30 ; Menu ID #$30: Main menu: out-of-battle spell list

    jsr $EB89 ; open menu specified by A

    lda #$31 ; Menu ID #$31: Main menu: battle spell list

    jmp $EB89 ; open menu specified by A


; set A and X to the current number of party members
; control flow target (from $F529, $F537, $F545, $F55D, $F56B, $F579, $F587, $F595, $F642, $F685)
    ldx #$00 ; you always have Midenhall

    lda $063F ; Cannock status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    and #$04 ; pick out the In Party bit

    beq B0F_F664 ; if Cannock not in party, don't INX; no Cannock => no Moonbrooke, so BEQ $F66C would be faster

    inx
; control flow target (from $F661)
B0F_F664:
    lda $0651 ; Moonbrooke status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    and #$04 ; pick out the In Party bit

    beq B0F_F66C ; if Moonbrooke not in party, don't INX

    inx
; control flow target (from $F669)
B0F_F66C:
    txa
    rts

; do special effects for certain menus; sets A to menu ID
; control flow target (from $EB89)
    cmp #$19 ; Menu ID #$19: General menu: YES/NO

    beq B0F_F691 ; YES/NO menu extra: play double beep SFX

    cmp #$04 ; Menu ID #$04: Dialogue window

    beq B0F_F6A3 ; initialize main dialogue window

    cmp #$06 ; Menu ID #$06: Map menu: main COMMAND menu

    beq B0F_F69A ; COMMAND menu extra: play single beep SFX

    cmp #$02 ; Menu ID #$02: Main menu: gold/crests

    bcs B0F_F68F ; anything else > 1 just does SEC and RTS

    sta $10 ; at this point A is either Menu ID #$00: Mini status window, bottom or Menu ID #$01: Mini status window, top and C is clear

    asl
    adc $10
    sta $10 ; A = A * 3; 3 versions of each menu

    jsr $F65A ; set A and X to the current number of party members

    clc
    adc $10 ; add number of party members to menu type offset

    tax
    lda $F6C8,X ; mini status menu IDs

; control flow target (from $F67C)
B0F_F68F:
    sec
    rts

; YES/NO menu extra: play double beep SFX
; control flow target (from $F670)
B0F_F691:
    lda #$86 ; Music ID #$86: double beep SFX

    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    lda #$19
    sec
    rts

; COMMAND menu extra: play single beep SFX
; control flow target (from $F678)
B0F_F69A:
    lda #$85 ; Music ID #$85: single beep SFX

    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    lda #$06
    sec
    rts

; initialize main dialogue window
; control flow target (from $F674)
B0F_F6A3:
    lda #$00
    sta $60D0
    sta $60D1
    ldx #$B0 ; write #$B0 [space] to $06F8-$07A7, a.k.a. blank out the main dialogue window

    lda #$5F
; control flow target (from $F6B3)
B0F_F6AF:
    sta $06F7,X
    dex
    bne B0F_F6AF
    lda #$00
    sta $7C
    sta $7D
    sta $60C8 ; speech sound effect / auto-indent flag

    lda #$04
    sec
    rts

; load bank specified by $94
; control flow target (from $F4AD, $F4E9, $F5E5, $F5FB, $F615, $F638, $FA65, $FC85, $FF94)
    pha
    lda $94 ; return bank for various function calls, doubles as index of selected option for multiple-choice menus

    jmp $F782 ; load bank specified by A then PLA



; code -> data
; mini status menu IDs
; indexed data load target (from $F68C)

.byte $00,$1E,$1F
.byte $01,$20
.byte $21
; data -> code
; return number of party members - 1 in A/X
; control flow target (from $CDB5)
; external control flow target (from $06:$8223, $06:$82F1, $06:$83EE, $06:$8485, $06:$857E, $06:$85C7, $06:$8620, $06:$8FD2, $06:$9023, $06:$93A3, $06:$99AF, $06:$9C80, $06:$A241)
    ldy #$00 ; status index

    ldx #$00 ; party member counter

    lda #$03 ; maximum number of party members

    sta $0C ; remaining party members to check

; control flow target (from $F6E5)
B0F_F6D6:
    lda $062D,Y ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    and #$04 ; pick out the "In Party" bit

    beq B0F_F6DE ; if member is in party, increment party member counter

    inx
; control flow target (from $F6DB)
B0F_F6DE:
    tya ; update status index for next party member

    clc
    adc #$12 ; hero data is #$12 bytes long

    tay
    dec $0C ; remaining party members to check

    bne B0F_F6D6 ; if more members to check, check them

    dex
    txa
    rts

; open main dialogue window and display string ID specified by byte following JSR
; control flow target (from $C83E, $CAA5, $CB90, $CBFC, $CC72)
; external control flow target (from $06:$80EF, $06:$8B83, $07:$81F3, $07:$8223, $07:$8234, $07:$827B, $07:$82E7, $07:$8351, $07:$8362, $07:$8369, $07:$83FE, $07:$84C7, $07:$8582)
    jsr $F6FC ; open main dialogue window, set A to string ID specified by byte following second JSR

    jmp $FA4A ; display string ID specified by A


; open main dialogue window and display string ID specified by byte following JSR + #$0100
; external control flow target (from $06:$80C3, $06:$822E, $06:$82C3, $06:$839F, $06:$8553, $06:$86C0, $06:$8A49)
    jsr $F6FC ; open main dialogue window, set A to string ID specified by byte following second JSR

    jmp $FA4E ; display string ID specified by A + #$0100


; open main dialogue window and display string ID specified by byte following JSR + #$0200
; control flow target (from $C940, $C9AB, $C9F2, $CB2E, $CC4D)
; external control flow target (from $06:$80E1, $06:$81A6, $06:$82BC, $06:$9368, $06:$A2C6)
    jsr $F6FC ; open main dialogue window, set A to string ID specified by byte following second JSR

    jmp $FA52 ; display string ID specified by A + #$0200


; open main dialogue window, set A to string ID specified by byte following second JSR
; control flow target (from $F6EA, $F6F0, $F6F6)
    jsr $EB76 ; open menu specified by next byte


; code -> data
; indirect data load target

.byte $04
; data -> code
    pla ; first JSR's return address, low byte

    sta $0C ; first JSR's return address, low byte

    pla ; first JSR's return address, high byte

    sta $0D ; first JSR's return address, high byte

    pla ; second JSR's return address, low byte

    clc
    adc #$01 ; byte following second JSR is data

    sta $0E ; second JSR's new return address, low byte

    pla ; second JSR's return address, high byte

    adc #$00 ; add carry from incrementing low byte

    sta $0F
    pha ; second JSR's new return address, high byte

    lda $0E ; second JSR's new return address, low byte

    pha ; second JSR's new return address, low byte

    ldy #$00
    lda ($0E),Y ; read byte following second JSR

    tay ; stash in Y for now

    lda $0D ; first JSR's return address, high byte

    pha ; first JSR's return address, high byte

    lda $0C ; first JSR's return address, low byte

    pha ; first JSR's return address, low byte

    tya ; copy desired menu ID to A

    rts

; restore the hero ID in A's MP by a random amount based on the Wizard's Ring's power; returns a random number between $03 and #$0A in A and $99
; external control flow target (from $06:$97FE)
    jsr $F766 ; load ROM bank #$04

; call to code in a different bank ($04:$8003)
    jsr $8003 ; restore the hero ID in A's MP by a random amount based on the Wizard's Ring's power; returns a random number between $03 and #$0A in A and $99

    jmp $F761 ; load ROM bank #$06


; heal hero ID in A by random amount based on healing power in X
; identical to $0F:$D146
; external control flow target (from $06:$95F3)
    jsr $F766 ; load ROM bank #$04

; call to code in a different bank ($04:$8006)
    jsr $8006
    jmp $F761 ; load ROM bank #$06


; set $8F-$90 to EXP required to reach next level
; external control flow target (from $06:$9473)
    jsr $F766 ; load ROM bank #$04

; call to code in a different bank ($04:$800C)
    jsr $800C ; set $8F-$90 to EXP required to reach next level

    jmp $F761 ; load ROM bank #$06


; calls $04:$99E6
; external control flow target (from $06:$9900, $06:$990C, $06:$995B, $06:$99A0)
    jsr $F766 ; load ROM bank #$04

; call to code in a different bank ($04:$8012)
    jsr $8012
    jmp $F761 ; load ROM bank #$06


; external control flow target (from $04:$A176)
    jsr $F761 ; load ROM bank #$06

    ldy #$06
    sty $94 ; return bank for various function calls, doubles as index of selected option for multiple-choice menus

; call to code in a different bank ($06:$9829)
    jsr $9829
    ldy #$04
    sty $94 ; return bank for various function calls, doubles as index of selected option for multiple-choice menus

    jmp $F766 ; load ROM bank #$04



; code -> data
; table of first item IDs for each item type
; external indexed data load target (from $06:$8A68)
; external indexed data load target (from $06:$8A6D)
.byte $01

.byte $11,$1C
.byte $21
.byte $24
; data -> code
; load ROM bank #$00
; control flow target (from $C6A8, $D21D, $D231, $D23E, $D250, $D29C, $D2A9, $D302, $D334, $D494, $E41D, $E43F)
    pha
    lda #$00
    beq B0F_F782 ; load bank specified by A then PLA

; load ROM bank #$06
; control flow target (from $C6ED, $C70C, $C786, $C89B, $CCAC, $CD48, $CF67, $D0F2, $D14C, $D156, $D164, $D215, $D23B, $D259, $D2EC, $D2F4, $D32B, $D57E, $E435, $E8B2, $EEC9, $F255, $F289, $F728, $F731, $F73A, $F743, $F746)
    pha
    lda #$06
    bne B0F_F782 ; load bank specified by A then PLA

; load ROM bank #$04
; control flow target (from $C771, $C8EC, $C95C, $D0EC, $D146, $D1A4, $D1C9, $D200, $D25C, $F722, $F72B, $F734, $F73D, $F754)
    pha
    lda #$04
    bne B0F_F782 ; load bank specified by A then PLA

; laod ROM bank #$01
    pha
    lda #$01
    bne B0F_F782 ; load bank specified by A then PLA

; load ROM bank #$02
; control flow target (from $CF61, $D369, $D5B6, $D7D4, $D7EE, $D890, $DECE, $DF86, $E169, $E3E8, $E445, $E461, $E4DF, $E94A, $F9AA, $FA8A, $FE3A)
    pha
    lda #$02
    bne B0F_F782 ; load bank specified by A then PLA

; load ROM bank #$03
; control flow target (from $C680, $D17C, $D517, $D7A6, $D81C, $D8D0, $DB96, $DC9C, $DFC9, $E2F9)
    pha
    lda #$03
    bne B0F_F782 ; load bank specified by A then PLA

; load ROM bank #$07
; control flow target (from $D969)
    pha
    lda #$07
    bne B0F_F782 ; load bank specified by A then PLA

; load ROM bank #$05
    pha
    lda #$05
; load bank specified by A then PLA
; control flow target (from $EB95, $F31E, $F6C5, $F75F, $F764, $F769, $F76E, $F773, $F778, $F77D)
B0F_F782:
    jsr $C3D5 ; save A to $05F6, X to $43, and load bank specified by A

    pla
    rts

; control flow target (from $CF70)
    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $41
; data -> code
    rts

; wipe selected menu region
; control flow target (from $CF6A, $D130, $D135, $D13A, $E5BB, $F5B6)
; external control flow target (from $04:$9ACC)
    sta $0C ; A values of #$00, #$01, #$02, and #$05 wipe all menus; #$03, #$04, #$06, and #$07 do not

    cmp #$05
    beq B0F_F796
    cmp #$03
    bcs B0F_F798
; control flow target (from $F790)
B0F_F796:
    lda #$00
; control flow target (from $F794)
B0F_F798:
    sta $2E ; whether to wipe all menus (#$00) or not

    lda $0C
    asl
    asl
    tay
    lda $F8DB,Y
    and #$0F
    sta $0C
    sec
    sbc #$08
    asl
    sta $18
    lda $F8DC,Y
    sta $0E
    pha
    asl
    asl
    asl
    asl
    ora $0C
    sta $607C
    pla
    sec
    sbc #$07
    asl
    sta $19
    lda $F8DD,Y
    sta $53
    sta $4E
    lda $F8DE,Y
    sta $54
    lda $53
    asl
    adc $18
    sta $18
    sta $4D
    lda $4E
    and #$0F
    clc
    adc #$01
    ora #$10
    sta $607B
    jsr $DE31
    lda $07
    sta $4F
    lda $08
    sta $50
; control flow target (from $F85C)
B0F_F7EE:
    lda $4E
    asl
    sta $609E ; menu current column

; control flow target (from $F838)
B0F_F7F4:
    ldy $53
    lda $2E ; whether to wipe all menus (#$00) or not

    beq B0F_F825 ; display background tiles

    cmp #$03
    beq B0F_F808
    cmp #$07
    beq B0F_F808
    lda #$10
    sta $1E
    bne B0F_F816
; control flow target (from $F7FC, $F800)
B0F_F808:
    lda #$00
    sta $1E
    lda ($4F),Y ; screen map of background vs. menu tile

    beq B0F_F825 ; display background tiles

    cmp #$FF
    beq B0F_F825 ; display background tiles

    lda #$00
; control flow target (from $F806)
B0F_F816:
    jsr $F870
    bcc B0F_F825 ; display background tiles

    lda #$00
    sta $1C
    jsr $F9AA ; display menu tiles

    jmp $F832

; control flow target (from $F7F8, $F80E, $F812, $F819)
B0F_F825:
    lda #$00
    ldy $53
    sta ($4F),Y ; update screen map to show background tiles

    sta $1C
    sta $1E
    jsr $F947
; menu and background code paths rejoin here
; control flow target (from $F822)
    dec $18
    dec $18
    dec $53
    bpl B0F_F7F4
    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $C0
; data -> code
    lda $607C
    sec
    sbc #$10
    sta $607C
    lda $4F
    sec
    sbc #$10
    sta $4F
    lda $4D
    sta $18
    lda $4E
    sta $53
    dec $19
    dec $19
    dec $54
    bpl B0F_F7EE
    lda $35 ; flag indicating whether any menu is currently open

    beq B0F_F86B
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    jsr $D8CB
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

; control flow target (from $F860)
B0F_F86B:
    lda $94 ; return bank for various function calls, doubles as index of selected option for multiple-choice menus

    jmp $C3D5 ; save A to $05F6, X to $43, and load bank specified by A


; control flow target (from $F816)
    tay
    bne B0F_F88A
    lda $54
    ldx $609E ; menu current column

    cmp #$04
    bcs B0F_F89B
    cpx #$08
    bcs B0F_F89B
    asl
    asl
    asl
    asl
    sta $10
    txa
    asl
    adc $10
; control flow target (from $F871)
B0F_F88A:
    clc
    adc $F8FD
    sta $10
    lda #$00
    adc $F8FE
    sta $11
    sta $1E
    bne B0F_F8D7
; control flow target (from $F87A, $F87E)
B0F_F89B:
    cmp #$08
    bne B0F_F8D9
    lda $0492
    beq B0F_F8D9
    lda $F8FB
    sta $10
    lda $F8FC
    sta $11
    lda #$77
    sta $60B5
    sta $60B6
    sta $1E
    txa
    clc
    adc #$07
    tax
    lda $06F8,X ; start of main dialogue window

    sta $60B7
    lda $06F9,X
    sta $60B8
    cpx #$15
    bne B0F_F8D7
    lda #$7C
    sta $60B6
    lda #$7B
    sta $60B8
; control flow target (from $F899, $F8CB)
B0F_F8D7:
    sec
    rts

; control flow target (from $F89D, $F8A2)
B0F_F8D9:
    clc
    rts


; code -> data
; byte 1 sets $0C and ((byte 1) - #$08) << 1 sets $18
; byte 2 sets $0E, ((byte 2) << 4) | (byte 1) sets $607C, ((byte 2) - #$07) << 1 sets $19
; byte 3 sets $53 and $4E
; byte 4 sets $54 and stuff: $18, $4D, $607B
; maybe (X start, Y start, width, height)?
; indexed data load target (from $F79F)
; indexed data load target (from $F7AC)
.byte $02
; indexed data load target (from $F7C2)
.byte $0D
; indexed data load target (from $F7C9)
.byte $0C
; data load target (from $F8A4)
.byte $03,$02,$09,$0C,$08,$0A,$06,$03,$03,$06,$09,$07,$08,$02,$0D
.byte $0B,$04,$02,$0D,$0B,$04,$02
.byte $0D,$03,$04,$06
.byte $0A,$07
.byte $09
; data load target (from $F8A9)
.byte $B5
; data load target (from $F88B)
.byte $60
; data load target (from $F892)
.byte $FF
; tiles for redrawing the part of the main COMMAND menu obscured by the EQUIP sub-menu when the EQUIP sub-menu is closed; (only?) read outside of battle
.byte $F8
; indirect data load target
; indexed data load target (from $FA00, $FA06)
.byte $24,$31,$5F,$5F,$27,$77,$5F,$5F,$77,$77,$5F,$5F,$77,$7C,$5F,$7B
.byte $5F,$5F,$5F,$5F,$36,$33,$5F,$5F,$28,$2F,$5F,$5F,$2F,$7B,$5F,$7B
.byte $5F,$5F,$5F,$5F,$2C,$37,$5F,$5F,$28,$30,$5F,$5F,$5F,$7B,$5F,$7B
.byte $5F,$5F,$7D,$7D,$28,$34,$7D,$7D
.byte $38,$2C,$7D,$7D
.byte $33,$7B
.byte $7D
.byte $7E

.byte $CB,$83,$6B,$84
.byte $33,$85
.byte $FB
.byte $85
; data -> code
; control flow target (from $F82F)
    lda $18
    asl
    lda $18
    ror
    clc
    adc $16 ; current map X-pos (1)

    sta $0C
    lda $19
    asl
    lda $19
    ror
    clc
    adc $17 ; current map Y-pos (1)

    sta $0E
    jsr $DF89
    jsr $E222
    lda $1D
    cmp $0D
    beq B0F_F98B
    lda $0C
    cmp #$28
    bcs B0F_F98B
    lda $1D
    bne B0F_F987
    lda $1F ; some kind of map type (#$00: World Map, #$01: other non-dungeon maps, #$02: maps #$2B - #$43 inclusive, #$03: maps >= #$44, #$FF => game menu)

    cmp #$01
    beq B0F_F983
    lda $0C
    cmp #$08
    bcc B0F_F983
    cmp #$0C
    bcc B0F_F98B
; control flow target (from $F977, $F97D)
B0F_F983:
    lda #$20
    bne B0F_F989
; control flow target (from $F971)
B0F_F987:
    lda #$24
; control flow target (from $F985)
B0F_F989:
    sta $0C
; control flow target (from $F967, $F96D, $F981)
B0F_F98B:
    lda $1C
    cmp #$FF
    bne B0F_F998
    lda $0C
    cmp #$20
    bcc B0F_F9A3
    rts

; control flow target (from $F98F)
B0F_F998:
    cmp #$FE
    bne B0F_F9A7
    lda $0C
    cmp #$20
    bcs B0F_F9A3
    rts

; control flow target (from $F995, $F9A0)
B0F_F9A3:
    lda #$00
    sta $1C
; control flow target (from $F99A)
B0F_F9A7:
    jsr $F9F6
; control flow target (from $F81F)
    jsr $F770 ; load ROM bank #$02

    ldy #$00
    sty $609F ; menu current row

    lda ($10),Y
    jsr $FA0E
    iny
    lda ($10),Y
    jsr $FA0E
    iny
    dec $609E ; menu current column

    dec $609E ; menu current column

    lda #$01
    sta $609F ; menu current row

    lda ($10),Y
    jsr $FA0E
    iny
    lda ($10),Y
    jsr $FA0E
    iny
    lda #$00
    ldx $1E
    bne B0F_F9DF
    lda ($10),Y
    and #$03
; control flow target (from $F9D9)
B0F_F9DF:
    pha
    lda $609E ; menu current column

    sec
    sbc #$02
    lsr
    tax
    pla
    sta $606B,X
    lda $609E ; menu current column

    sec
    sbc #$04
    sta $609E ; menu current column

    rts

; control flow target (from $F9A7)
    lda $1F ; some kind of map type (#$00: World Map, #$01: other non-dungeon maps, #$02: maps #$2B - #$43 inclusive, #$03: maps >= #$44, #$FF => game menu)

    asl
    tay
    lda $0C
    asl
    asl
    adc $0C
    adc $F93F,Y
    sta $10
    iny
    lda $F93F,Y
    adc #$00
    sta $11
    rts

; control flow target (from $F9B4, $F9BA, $F9CB, $F9D1)
    pha
    ldx #$00
    lda $609F ; menu current row

    beq B0F_FA1C
    lda $4E
    asl
    adc #$02
    tax
; control flow target (from $FA14)
B0F_FA1C:
    txa
    clc
    adc $609E ; menu current column

    tax
    pla
    sta $600B,X
    inc $609E ; menu current column

    rts

; display string ID specified by next byte
; control flow target (from $C856, $CC0A, $D160)
; external control flow target (from $06:$80D6, $06:$8BBD, $06:$8BF8, $06:$8C18, $06:$8CCD, $06:$947F, $06:$94ED, $06:$94FB, $06:$950E, $06:$9515, $06:$9534, $06:$9538, $06:$9BEB, $06:$9C5B, $06:$A228, $07:$8377, $07:$8591)
    ldx #$00
    beq B0F_FA34
; display string ID specified by next byte + #$0100
; external control flow target (from $02:$B2D2, $06:$8102, $06:$810B, $06:$8246, $06:$828D, $06:$8291, $06:$8298, $06:$829C, $06:$82CE, $06:$82D5, $06:$82EA, $06:$82FF, $06:$830A, $06:$8327, $06:$8341, $06:$8348, $06:$8358, $06:$835C, $06:$837C, $06:$83B2, $06:$83B9, $06:$83C4, $06:$83E7, $06:$83FF, $06:$840D, $06:$8423, $06:$843B, $06:$843F, $06:$844A, $06:$8451, $06:$8465, $06:$847E, $06:$848C, $06:$84B0, $06:$84B7, $06:$84FE, $06:$8502, $06:$8514, $06:$851F, $06:$8532, $06:$8547, $06:$8557, $06:$8563, $06:$856A, $06:$8585, $06:$859C, $06:$85AB, $06:$85CE, $06:$85F3, $06:$8602, $06:$8627, $06:$8641, $06:$8650, $06:$8672, $06:$8679, $06:$8694, $06:$869D, $06:$86CB, $06:$86DE, $06:$86EA, $06:$86F5, $06:$86FC, $06:$8707, $06:$871F, $06:$8738, $06:$8AB6, $06:$8ADC, $06:$8AF8, $06:$8B4E, $06:$8B62, $06:$8C3C, $06:$8C8D, $06:$91DC, $06:$9529, $06:$9577, $06:$95A0, $06:$95C9, $06:$963D, $06:$9647, $06:$965A, $06:$9668, $06:$9673, $06:$9685, $06:$96C9, $06:$96D7, $06:$96F2, $06:$96FE, $06:$973C, $06:$9750, $06:$979A, $06:$97ED, $06:$97F8, $06:$9805, $06:$9813, $06:$981E, $06:$988E, $06:$98CB, $06:$9903, $06:$9908, $06:$990F, $06:$992F, $06:$993B, $06:$995E, $06:$9963, $06:$999C, $06:$99A3, $06:$99BA, $06:$99E8, $06:$99F5, $06:$99F9, $06:$9A10, $06:$9A29, $06:$9A5B, $06:$9A62, $06:$9A72, $06:$9A7D, $06:$9AA2, $06:$9AAF, $06:$9ABD, $06:$9AC4, $06:$9AF4, $06:$9B7D, $06:$9B8A, $06:$9B92, $06:$9BAF, $06:$9BB3, $06:$9BBA, $06:$9BFE, $06:$9C30, $06:$9C62, $06:$9CAA, $06:$9CBA, $06:$9CC5, $06:$9CD2, $06:$9CF9, $06:$9D0E, $06:$9D30, $06:$9D3F, $06:$A24B, $06:$BB57, $06:$BB5B, $06:$BB67, $06:$BB73, $06:$BB7C, $06:$BBAF, $06:$BBD3, $06:$BC26)
    ldx #$20
    bne B0F_FA34
; display string ID specified by next byte + #$0200
; control flow target (from $CA35)
; external control flow target (from $02:$B2EB, $06:$8163, $06:$83D5, $06:$841A, $06:$8E39, $06:$8E3D, $06:$8ED5, $06:$8EF6, $06:$8EFA, $06:$8F05, $06:$8F11, $06:$8F1C, $06:$8F29, $06:$8F32, $06:$8F47, $06:$8F58, $06:$8F63, $06:$8F94, $06:$8FB1, $06:$8FD7, $06:$8FEF, $06:$8FFE, $06:$9002, $06:$9012, $06:$9028, $06:$9055, $06:$905E, $06:$9065, $06:$907C, $06:$908E, $06:$909A, $06:$90A1, $06:$90BF, $06:$9102, $06:$910B, $06:$9117, $06:$916E, $06:$917E, $06:$9185, $06:$9190, $06:$91A8, $06:$91B3, $06:$91D0, $06:$91E6, $06:$91ED, $06:$91FA, $06:$9201, $06:$920C, $06:$9213, $06:$928B, $06:$9292, $06:$92E7, $06:$930B, $06:$933E, $06:$9348, $06:$9384, $06:$93EB, $06:$93F2, $06:$93F9, $06:$9407, $06:$9437, $06:$9446, $06:$9458, $06:$945F, $06:$9486, $06:$9817, $06:$A2E5, $06:$BD37, $06:$BD56)
    ldx #$40
; control flow target (from $FA2C, $FA30)
B0F_FA34:
    pla ; low byte of return address

    clc
    adc #$01 ; increment it (byte following the JSR is data)

    sta $0E ; store to $0E

    pla ; high byte of return address

    adc #$00 ; add carry from incrementing low byte

    sta $0F ; store to $0F

    pha ; push the new return address's high byte

    lda $0E
    pha ; push the new return address's low byte

    ldy #$00
    lda ($0E),Y ; load the byte following the original JSR

    jmp $FA54

; display string ID specified by A
; control flow target (from $D196, $F6ED)
; external control flow target (from $04:$97F4, $04:$98C3, $04:$9CC7, $06:$94B8, $06:$94CB, $06:$94DE, $06:$A99F)
    ldx #$00
    beq B0F_FA54
; display string ID specified by A + #$0100
; control flow target (from $F6F3)
; external control flow target (from $02:$B334, $04:$9CC4, $06:$95D8, $06:$97E3, $06:$98AC, $06:$98C7, $06:$992B, $06:$9A41, $06:$9B2D, $06:$9D49, $06:$A0CF)
    ldx #$20
    bne B0F_FA54
; display string ID specified by A + #$0200
; control flow target (from $F6F9)
; external control flow target (from $06:$8E30, $06:$8E51, $06:$8E64, $06:$8F7F, $06:$8FA6, $06:$8FC6, $06:$9039, $06:$90B9, $06:$90E9, $06:$90FC, $06:$9147, $06:$9168, $06:$9248, $06:$92F8, $06:$9326, $06:$9338, $06:$9359, $06:$9395, $06:$93B8, $06:$93DB)
    ldx #$40
; control flow target (from $FA47, $FA4C, $FA50)
B0F_FA54:
    jsr $FA68 ; figure out which bank the string is in, scan to start of string

    jsr $FAA7 ; initialize text engine variables

; control flow target (from $FA63)
B0F_FA5A:
    jsr $FB24
    jsr $FB63
    jsr $FAC8 ; CLC if we've read an end token, otherwise (probably?) print word to screen and SEC

    bcc B0F_FA5A
    jmp $F6C2 ; load bank specified by $94


; figure out which bank the string is in, scan to start of string
; control flow target (from $FA54)
    jsr $FA6E ; text engine: determine which ROM bank to load based on string index

    jmp $FA8A ; given a string ID in X (high, << 5) + A (low), scan to start of string


; text engine: determine which ROM bank to load based on string index
; IN:
; A = low byte of string index
; X = high byte of string index << 5 (for easy adding later)
; Y and C irrelevant
;
; OUT: no change to A or X
; Y = index of ROM bank to swap in to read the string from
; C not used, but does indicate whether we ended up choosing bank 5 (clear) or 2 (set)
; control flow target (from $FA68)
    ldy #$05 ; default to bank 5

    pha ; save the original string index in A

    and #$F0 ; useless op

    lsr
    lsr
    lsr
    lsr
    sta $10 ; 16 strings per pointer, so low byte of string index >> 4 = low nybble of pointer index

    txa
    and #$E0
    lsr ; A = high nybble of pointer index

    ora $10 ; glue the high and low nybbles of the pointer index together into a single byte

    cmp #$2E
    bcc B0F_FA85 ; if the pointer index < #$2E, keep the bank 5 default

    ldy #$02 ; if the pointer index >= #$2E, load bank 2 instead

; control flow target (from $FA81)
B0F_FA85:
    sty $60C6 ; ROM bank containing the desired text string

    pla ; restore the original string index in A

; control flow target (from $D12B)
; external control flow target (from $06:$9542, $06:$9550)
    rts

; given a string ID in X (high, << 5) + A (low), scan to start of string
; control flow target (from $FA6B)
    jsr $F770 ; load ROM bank #$02

    stx $11 ; save high byte of string index to $11

    sta $10 ; save low byte of string index to $10

    lsr ; 16 strings per 2-byte pointer = >> 4 + << 1 a.k.a. >> 3 + & #$1E

    lsr
    lsr
    and #$1E
    clc
    adc $11 ; add high byte of string index to get pointer index

    tay
    lda $B752,Y ; -> $05:$8000: main script strings, part 1

    sta $55 ; pointer to start of sub pointer data, low byte

    lda $B753,Y
    sta $56 ; pointer to start of sub pointer data, high byte

    jmp $FDB3 ; scan through group of strings until we find the start of the desired string


; initialize text engine variables
; control flow target (from $FA57)
    lda #$00
    sta $60C8 ; speech sound effect / auto-indent flag

    sta $60CA ; unused text engine variable

    sta $60CC ; text engine end token flag

    sta $60C9 ; count (only used as flag) of interpolated variable bytes read from $60F1

    sta $60D2 ; read index within current dictionary entry

    lda #$08
    sta $60C7
    lda $7C
    sta $60CE
    lda $7D
    sta $60CF
    rts

; CLC if we've read an end token, otherwise (probably?) print word to screen and SEC
; control flow target (from $FA60)
    lda $60CC ; text engine end token flag

    bne B0F_FACF
    clc
    rts

; control flow target (from $FACB)
B0F_FACF:
    ldx $7D
    lda $60D0
    bne B0F_FAD9
    stx $60D0
; control flow target (from $FAD4)
B0F_FAD9:
    lda $60D1
    bne B0F_FAE1
    stx $60D1
; control flow target (from $FADC)
B0F_FAE1:
    lda $8E ; flag for in battle or not (#$FF)?

    bpl B0F_FB0B
    lda $7D
    cmp #$01
    beq B0F_FAEC
    lsr
; control flow target (from $FAE9)
B0F_FAEC:
    clc
    adc #$01
    sta $9C
; control flow target (from $FB08)
    sec
    lda $7D
    sbc $60CF
    bcc B0F_FB0B
    beq B0F_FB0B
    cmp #$01
    beq B0F_FB02
    jsr $FB0D
; control flow target (from $FAFD)
B0F_FB02:
    jsr $FB0D
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    jmp $FAF1

; control flow target (from $FAE3, $FAF7, $FAF9)
B0F_FB0B:
    sec
    rts

; control flow target (from $FAFF, $FB02)
    lda $60CF
    pha
    inc $60CF
    jsr $FDA2 ; 16-bit multiplication: set 16-bit ($10-$11) = A * #$16; returns low byte in A and clears C

    sta $6085
    pla
    clc
    adc #$13
    sta $6084
    jmp $FD0F

; control flow target (from $FA5A)
    jsr $FBB8 ; read a main script word into word buffer $60D9

    bit $60CA ; unused text engine variable

    bmi B0F_FB62
    lda $7C
    sta $609E ; menu current column

    lda #$00
    sta $6089 ; string word buffer index 2

; control flow target (from $FB4E)
B0F_FB36:
    ldx $6089 ; string word buffer index 2

    lda $60D9,X ; start of string word buffer

    inc $6089 ; string word buffer index 2

    cmp #$5F ; [space]

    beq B0F_FB50
    cmp #$FA ; [end-FA]

    bcs B0F_FB50
    inc $609E ; menu current column

    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $45
; data -> code
    bcs B0F_FB36
; control flow target (from $FB41, $FB45)
B0F_FB50:
    dec $609E ; menu current column

    lda $609E ; menu current column

    bpl B0F_FB5E
    lda $60C8 ; speech sound effect / auto-indent flag

    sta $609E ; menu current column

; control flow target (from $FB56)
B0F_FB5E:
    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $47
; data -> code
; control flow target (from $FB2A)
B0F_FB62:
    rts

; control flow target (from $FA5D)
    ldx #$00
    stx $60CB ; string word buffer index 1

; control flow target (from $FB7E)
B0F_FB68:
    ldx $60CB ; string word buffer index 1

    lda $60D9,X ; start of string word buffer

    inc $60CB ; string word buffer index 1

    cmp #$FA
    bcs B0F_FB81
    pha
    jsr $FD37
    pla
    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $45
; data -> code
    bcs B0F_FB68
    rts

; control flow target (from $FB73)
B0F_FB81:
    cmp #$FB ; [wait]; implies [line]

    beq B0F_FB97
    cmp #$FC ; [end-FC]

    beq B0F_FBAD
    cmp #$FD
    beq B0F_FBA8
    cmp #$FE ; [line]

    beq B0F_FBA3
; set text engine end token flag $60CC and RTS
; FA/FF handler + end of FC handler
; control flow target (from $FBB5)
    lda #$FF
    sta $60CC ; text engine end token flag

    rts

; FB handler: [wait]
; control flow target (from $FB83)
B0F_FB97:
    lda $8E ; flag for in battle or not (#$FF)?

    bmi B0F_FBA7
    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $46
; data -> code
    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $48
; data -> code
; FE handler: [line]
; control flow target (from $FB8F)
B0F_FBA3:
    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $46
; data -> code
; control flow target (from $FB99)
B0F_FBA7:
    rts

; FD handler
; control flow target (from $FB8B)
B0F_FBA8:
    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $40
; data -> code
    rts

; FC handler: [end-FC]
; control flow target (from $FB87)
B0F_FBAD:
    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $46
; data -> code
    lda #$00
    sta $7C
    jmp $FB91 ; set text engine end token flag $60CC and RTS


; read a main script word into word buffer $60D9
; control flow target (from $FB24)
    lda #$00
    sta $60CB ; string word buffer index 1

; control flow target (from $FBDA)
B0F_FBBD:
    jsr $FBDD ; return next byte of string in A

    cmp #$FE ; useless op

    bne B0F_FBC4 ; useless op

; control flow target (from $FBC2)
B0F_FBC4:
    cmp #$65 ; "‘"

    bne B0F_FBCD ; "‘" enables speech sound effect

    ldx #$01
    stx $60C8 ; speech sound effect / auto-indent flag

; control flow target (from $FBC6)
B0F_FBCD:
    ldx $60CB ; string word buffer index 1

    sta $60D9,X ; start of string word buffer

    inc $60CB ; string word buffer index 1

    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $45
; data -> code
    bcs B0F_FBBD ; if not end of word, keep reading more string bytes

    rts

; return next byte of string in A
; control flow target (from $FBBD)
    ldx $60C9 ; count (only used as flag) of interpolated variable bytes read from $60F1

    beq B0F_FBF4 ; if we're not in "read from $60F1" mode, read next string byte from ROM

; control flow target (from $FBFC)
    lda $60F1,X ; start of text variable buffer

    inc $60C9 ; count (only used as flag) of interpolated variable bytes read from $60F1

    cmp #$FA ; [end-FA]

    bne B0F_FBF3 ; if not [end-FA], use it

    ldx #$00 ; otherwise reset read index and "read from $60F1" flag

    stx $60C9 ; count (only used as flag) of interpolated variable bytes read from $60F1

    beq B0F_FBF4 ; and read next string token from ROM

; control flow target (from $FBEA, $FBF8)
B0F_FBF3:
    rts

; control flow target (from $FBE0, $FBF1)
B0F_FBF4:
    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $4A
; data -> code
    bcc B0F_FBF3 ; CLC means to use value in A, so RTS

    ldx #$00 ; else, SEC means to read from $60F1, so initialize read index to #$00

    jmp $FBE2 ; and start reading


; external control flow target (from $04:$9ADB, $04:$9B46)
    and #$0F
    cmp #$0F
    beq B0F_FC13
    cmp #$0E
    beq B0F_FC1D
    cmp #$0C
    bne B0F_FC13
    lda $60D1
    jmp $FC25

; control flow target (from $FC03, $FC0B)
B0F_FC13:
    lda #$00
    sta $60D0
    sta $60D1
    beq B0F_FC25
; control flow target (from $FC07)
B0F_FC1D:
    lda #$00
    sta $60D1
    lda $60D0
; control flow target (from $FC10, $FC1B)
B0F_FC25:
    sta $7D
    asl
    adc #$02
    sta $00
    lda #$00
    sta $7C
; control flow target (from $FC32)
B0F_FC30:
    lda $00
    bne B0F_FC30
    lda #$FF
    sta $00
    ldx #$08
    jsr $C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

    lda $7D
    jsr $FDA2 ; 16-bit multiplication: set 16-bit ($10-$11) = A * #$16; returns low byte in A and clears C

    adc $7C
    tax
    lda #$5F
; control flow target (from $FC4D)
B0F_FC47:
    sta $06F8,X ; start of main dialogue window

    inx
    cpx #$B0
    bne B0F_FC47
    rts

; print name of hero given by low 2 bits of A to $6119, terminated by #$FA
; control flow target (from $C853)
; external control flow target (from $02:$B2CF, $02:$B2E8, $02:$B330, $04:$9CD3, $06:$80D3, $06:$80FF, $06:$8108, $06:$8B4B, $06:$8BF5, $06:$8C15, $06:$8CCA, $06:$8D27, $06:$8E11, $06:$8E2C, $06:$8ED2, $06:$8EDE, $06:$8F0E, $06:$8F2F, $06:$8F44, $06:$8F55, $06:$8F60, $06:$8F6C, $06:$8F87, $06:$8FCF, $06:$8FE0, $06:$900F, $06:$9079, $06:$908B, $06:$91F7, $06:$9381, $06:$93E8, $06:$9404, $06:$9443, $06:$9574, $06:$95CF, $06:$9644, $06:$96FB, $06:$9739, $06:$9CA7, $06:$A21B, $06:$A248, $06:$BB54, $06:$BB70, $06:$BB79, $06:$BBD0, $07:$82E4)
    pha
    and #$03
    sta $10
    asl
    asl
    sta $12 ; A & #$03 * 4

    adc $10
    sta $11 ; A & #$03 * 5

    ldy #$00
; control flow target (from $FC76)
B0F_FC5F:
    ldx $11
    lda $0113,X ; Midenhall name bytes 0-3 + terminator

    sta $6119,Y ; start of buffer for [monster(s)], [name], maybe more

    ldx $12
    lda $0186,X ; Midenhall name bytes 4-7

    sta $611D,Y
    inc $11
    inc $12
    iny
    cpy #$04
    bne B0F_FC5F
    ldy #$08
    jsr $FCD7 ; update write index to trim trailing spaces

    pla
    bpl B0F_FC80 ; append [end-FA] to string and swap return bank $94 back in; useless op

; append [end-FA] to string and swap return bank $94 back in
; control flow target (from $FC7E, $FCC3, $FCC5, $FCD5)
B0F_FC80:
    lda #$FA ; [end-FA]

    sta $6119,Y ; start of buffer for [monster(s)], [name], maybe more

    jsr $F6C2 ; load bank specified by $94

    rts

; write monster name in A (+ monster number within its group in X, if > 0) to $6119
; external control flow target (from $04:$9CD9)
    stx $608B ; monster number within its group

    pha ; monster ID

    lda #$00 ; start with the first segment

    sta $60AB ; which list segment we're dealing with

    lda #$0B ; max length of first segment

    sta $60A0 ; maximum string length; max segment length

    pla ; monster ID

    jsr $F3B7 ; given monster ID in A, copy monster name segment to $0100 in reverse

    ldy #$00 ; initialize write index to #$00

    jsr $FCE8 ; copy $60A0 bytes of data from $00FF to $6119

    jsr $FCD7 ; update write index to trim trailing spaces

    lda #$5F ; [space]

    sta $6119,Y ; start of buffer for [monster(s)], [name], maybe more; write [space] to $6119,Y

    iny ; increment write index

    tya
    pha ; save write index for later

    inc $60AB ; which list segment we're dealing with

    lda #$09 ; max length of second segment

    sta $60A0 ; maximum string length; max segment length

    lda $10 ; monster ID, set by previous call to $F3B7

    jsr $F3B7 ; given monster ID in A, copy monster name segment to $0100 in reverse

    pla ; pull write index back into Y

    tay
    jsr $FCE8 ; copy $60A0 bytes of data from $00FF to $6119

    jsr $FCD7 ; update write index to trim trailing spaces

    ldx $608B ; monster number within its group

    beq B0F_FC80 ; append [end-FA] to string and swap return bank $94 back in

    bmi B0F_FC80 ; append [end-FA] to string and swap return bank $94 back in

    lda #$6A ; "-"

    sta $6119,Y ; start of buffer for [monster(s)], [name], maybe more

    iny
    txa ; monster number within its group

    clc
    adc #$23 ; #$23 == "z" and A > 0, so this is the uppercase letter corresponding to the monster number within its group; net effect is e.g. "-A", "-B", etc.

    sta $6119,Y ; start of buffer for [monster(s)], [name], maybe more

    iny
    bne B0F_FC80 ; append [end-FA] to string and swap return bank $94 back in

; update write index to trim trailing spaces
; control flow target (from $FC7A, $FCA0, $FCBD, $FCE5)
B0F_FCD7:
    lda $6118,Y ; last byte written

    cmp #$60 ; [no voice]

    beq B0F_FCE2
    cmp #$5F ; [space]

    bne B0F_FCE7
; control flow target (from $FCDC)
B0F_FCE2:
    dey ; if it's some kind of whitespace, decrement the write index

    bmi B0F_FCE7 ; if Y became negative (oops - string is now 0 bytes), stop

    bne B0F_FCD7 ; update write index to trim trailing spaces

; control flow target (from $FCE0, $FCE3)
B0F_FCE7:
    rts

; copy $60A0 bytes of data from $00FF to $6119
; X is used as a read index, Y as a write index
; data gets copied in reverse order
; IN:
; A/X/C = irrelevant
; Y = current write index
; OUT:
; A = last byte copied (but calling code doesn't care)
; X = 0
; Y = current write index; this is important since the calling code needs to remember the write index from the first segment when dealing with the second segment
; C = unchanged
; control flow target (from $FC9D, $FCBA)
    ldx $60A0 ; maximum string length; initialize the read index to the value of $60A0

; control flow target (from $FCF3)
B0F_FCEB:
    lda a:$FF,X ; built-in offset from string copy buffer start at $0100

    sta $6119,Y ; start of buffer for [monster(s)], [name], maybe more; write data to $6119,Y

    iny ; increment write index

    dex ; decrement read index

    bne B0F_FCEB ; if the read index is not 0, loop back to $FCEB

    rts ; otherwise the read index is 0, so we're done


; text engine: load bank specified by $60C6 (bank containing the desired text string)
; control flow target (from $FDD3, $FE16, $FE34)
    pha
    lda $60C6 ; ROM bank containing the desired text string

    jsr $C3D5 ; save A to $05F6, X to $43, and load bank specified by A

    pla
    rts

; external control flow target (from $02:$B6DB)
    jsr $FD0F
    inc $6084
    jsr $FD0F
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    inc $6084
    rts

; control flow target (from $FB21, $FCFF, $FD05)
    lda $6084
    sta $608C
    lda #$05
    sta $608B
; control flow target (from $FD34)
B0F_FD1A:
    ldx $6085
    lda $06F8,X ; start of main dialogue window

    sta $09
    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $C1
; data -> code
    jsr $C1FA ; wait for $02 to not be #$C0, write PPU address in $07-$08 and data in $09 to PPU write buffer at $0300,$02, $01 += 1, $02 += 3, and set $0183 to #$00

    inc $6085
    inc $608B
    lda $608B
    cmp #$1B
    bne B0F_FD1A
    rts

; control flow target (from $FB76)
    pha
    lda $7C
    sta $609E ; menu current column

    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $47
; data -> code
    lda $7D
    jsr $FDA2 ; 16-bit multiplication: set 16-bit ($10-$11) = A * #$16; returns low byte in A and clears C

    adc $7C
    tax
    pla
    cmp #$5F
    beq B0F_FD5F
    cmp #$65
    bne B0F_FD66
    ldy $7C
    cpy #$01
    bne B0F_FD66
    dey
    sty $7C
    dex
    jmp $FD66

; control flow target (from $FD4C)
B0F_FD5F:
    ldy $7C
    cpy $60C8 ; speech sound effect / auto-indent flag

    beq B0F_FDA1
; control flow target (from $FD50, $FD56, $FD5C)
B0F_FD66:
    pha
    lda $06F8,X ; start of main dialogue window

    sta $09
    tay
    pla
    cpy #$5F
    bne B0F_FD77
    sta $06F8,X ; start of main dialogue window

    sta $09
; control flow target (from $FD70)
B0F_FD77:
    lda $8E ; flag for in battle or not (#$FF)?

    bmi B0F_FD9F
    lda $60C8 ; speech sound effect / auto-indent flag

    beq B0F_FD85
    lda #$8F ; Music ID #$8F: speech SFX

    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

; control flow target (from $FD7E)
B0F_FD85:
    lda $7C
    clc
    adc #$05
    sta $608B
    lda $7D
    clc
    adc #$13
    sta $608C
    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $C1
; data -> code
    jsr $C1FA ; wait for $02 to not be #$C0, write PPU address in $07-$08 and data in $09 to PPU write buffer at $0300,$02, $01 += 1, $02 += 3, and set $0183 to #$00

    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

; control flow target (from $FD79)
B0F_FD9F:
    inc $7C
; control flow target (from $FD64)
B0F_FDA1:
    rts

; 16-bit multiplication: set 16-bit ($10-$11) = A * #$16; returns low byte in A and clears C
; control flow target (from $FB14, $FC3F, $FD43)
    sta $10
    lda #$00
    sta $11
    ldx #$10
    lda #$16
    jsr $F0F4 ; 16-bit multiplication: set 16-bit ($00,X-$01,X) = ($00,X-$01,X) * A

    lda $10
    clc
    rts

; scan through group of strings until we find the start of the desired string
; control flow target (from $FAA4)
    lda #$00
    sta $60D6 ; bit index into the byte containing the 5-bit text token currently being processed

    sta $60D2 ; read index within current dictionary entry

    lda $10 ; low byte of string index

    and #$0F ; chop it down to index within the current pointer

    tax
    beq B0F_FDC8 ; if we want the first string in the pointer, nothing more to do here, so RTS

; otherwise scan through the pointer data to find the start of the desired string
; control flow target (from $FDC6)
B0F_FDC2:
    jsr $FDC9 ; scan through current string pointer to find the start of the next string

    dex
    bne B0F_FDC2
; control flow target (from $FDC0)
B0F_FDC8:
    rts

; scan through current string pointer to find the start of the next string
; control flow target (from $FDC2)
    txa
    pha
    jsr $FDD3 ; scan through string until we reach an end token; updates read address in $55-$56

    pla
    tax
    lda $6D
    rts

; scan through string until we reach an end token; updates read address in $55-$56
; control flow target (from $FDCB, $FDF0)
B0F_FDD3:
    jsr $FCF6 ; text engine: load bank specified by $60C6 (bank containing the desired text string)

    lda #$00
    sta $60D3 ; secondary text table offset for C0 - C3 tables

; control flow target (from $FDE8)
    jsr $FE3D ; set A to the current text dictionary index

    jsr $FDF7 ; after reading a text token, update the read address in $55-$56 and bit index in $60D6

    cmp #$1C ; #$1C - #$1F are the C0 - C3 table switch tokens

    bcc B0F_FDEB ; if token >= #$1C, we know it's a switch token and the next token is not an end token, so skip over the next token

    jsr $FDF7 ; after reading a text token, update the read address in $55-$56 and bit index in $60D6

    jmp $FDDB ; loop to read the next token


; control flow target (from $FDE3)
B0F_FDEB:
    lda $608B ; text engine: $608B = dictionary index

    cmp #$05 ; the text tokens 0 - 4 are end tokens

    bcs B0F_FDD3 ; scan through string until we reach an end token; updates read address in $55-$56; if not an end token, keep scanning

    lda #$FC ; if end token, set A and $6D to #$FC and RTS

    sta $6D ; stash #$FC in $6A since caller needs to pop stuff off the stack

    rts

; after reading a text token, update the read address in $55-$56 and bit index in $60D6
; control flow target (from $FDDE, $FDE5)
; external control flow target (from $02:$B3C6, $02:$B3E3)
    pha
    lda $60D6 ; bit index into the byte containing the 5-bit text token currently being processed

    cmp #$03 ; if all 5 bits we need are already in A, keep using it, otherwise update read position in $55-$56

    bcc B0F_FE25 ; $FE29 would be a better target :p

    inc $55 ; pointer to start of sub pointer data, low byte

    bne B0F_FE05
    inc $56 ; pointer to start of sub pointer data, high byte

; control flow target (from $FE01)
B0F_FE05:
    lda $55 ; pointer to start of sub pointer data, low byte; check for $55-$56 == $BFD7; if yes, switch to bank #$02, if no, keep using current address

    cmp #$D7
    bne B0F_FE25
    lda $56 ; pointer to start of sub pointer data, high byte

    cmp #$BF
    bne B0F_FE25
    lda #$02
    sta $60C6 ; ROM bank containing the desired text string

    jsr $FCF6 ; text engine: load bank specified by $60C6 (bank containing the desired text string)

    lda #$2E ; useless

    lda $FE32 ; set $55-$56 to new address in bank #$02

    sta $55 ; pointer to start of sub pointer data, low byte

    lda $FE33
    sta $56 ; pointer to start of sub pointer data, high byte

; control flow target (from $FDFD, $FE09, $FE0F)
B0F_FE25:
    lda $60D6 ; bit index into the byte containing the 5-bit text token currently being processed

    clc
    adc #$05 ; we read 5 bits, so update the bit index

    and #$07
    sta $60D6 ; bit index into the byte containing the 5-bit text token currently being processed

    pla
    rts


; code -> data
; data load target (from $FE1B)
; data load target (from $FE20)
.byte $B2

.byte $B7
; data -> code
; swap in the right text bank, set A to the current dictionary index, swap in bank #$02
; external control flow target (from $02:$B3AB)
    jsr $FCF6 ; text engine: load bank specified by $60C6 (bank containing the desired text string)

    jsr $FE3D ; set A to the current text dictionary index

    jmp $F770 ; load ROM bank #$02


; set A to the current text dictionary index
; control flow target (from $FDDB, $FE37)
    lda $60D6 ; bit index into the byte containing the 5-bit text token currently being processed

    asl
    tay
    lda $FE5C,Y ; jump table for functions to convert the current 5-bit text token into a dictionary index in A

    sta $57 ; pointer to start of main pointer table, low byte

    lda $FE5D,Y
    sta $58 ; pointer to start of main pointer table, high byte

; BUG: this reads the first 2 bytes of ($55) *before* the code for checking whether the read position needs to jump to bank 2 runs
    ldy #$01
    lda ($55),Y ; pointer to start of sub pointer data, low byte

    sta $608C ; text engine: $608C = string byte #2

    dey
    lda ($55),Y ; pointer to start of sub pointer data, low byte

    sta $608B ; text engine: $608B = string byte #1

    jmp ($0057) ; pointer to start of main pointer table, low byte; convert the current 5-bit text token into a dictionary index in A



; code -> data
; jump table for functions to convert the current 5-bit text token into a dictionary index in A
; indexed data load target (from $FE42)
; indexed data load target (from $FE47)
.byte $6C

.byte $FE,$6D,$FE,$6E,$FE,$8D,$FE,$84
.byte $FE,$7E,$FE,$78
.byte $FE,$72
.byte $FE
; data -> code
; token is in bits 7-3 of A
; indirect control flow target (via $FE5C)
    lsr
; token is in bits 6-2 of A
; indirect control flow target (via $FE5E)
    lsr
; token is in bits 5-1 of A
; indirect control flow target (via $FE60)
    lsr
    jmp $FE8D ; token is in bits 4-0 of A (yay)


; token is in bit 0 of A + bits 7-4 of $608C
; indirect control flow target (via $FE6A)
    asl $608C ; string byte #2

    rol $608B ; text engine: $608B = string byte #1

; token is in bits 1-0 of A + bits 7-5 of $608C
; indirect control flow target (via $FE68)
    asl $608C ; string byte #2

    rol $608B ; text engine: $608B = string byte #1

; token is in bits 2-0 of A + bits 7-6 of $608C
; indirect control flow target (via $FE66)
    asl $608C ; string byte #2

    rol $608B ; text engine: $608B = string byte #1

; token is in bits 3-0 of A + bit 7 of $608C
; indirect control flow target (via $FE64)
    asl $608C ; string byte #2

    rol $608B ; text engine: $608B = string byte #1

    lda $608B ; text engine: $608B = string byte #1

; token is in bits 4-0 of A (yay)
; control flow target (from $FE6F)
; indirect control flow target (via $FE62)
    and #$1F
    clc
    adc $60D3 ; secondary text table offset for C0 - C3 tables

    sta $608B ; text engine: $608B = dictionary index

    rts

; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank
; BUG: does LDA before PHP, so status of N and Z flags are lost
; control flow target (from $C696, $C6C4, $C6D7, $C6DB, $C6F6, $C886, $C894, $CC9B, $D15C, $D16E, $D2E7, $D2F7, $D33C, $D356, $EE06, $EE7B, $EF58, $F04F, $F0BC, $F4A9, $F4E3, $F5E1, $F5F7, $F611, $F787, $F83A, $FB4A, $FB5E, $FB7A, $FB9B, $FB9F, $FBA3, $FBA8, $FBAD, $FBD6, $FBF4, $FD22, $FD3D, $FD95)
; external control flow target (from $02:$B74B, $02:$BE00, $02:$BE2C, $02:$BE34, $02:$BEA1, $06:$B0A5, $07:$87F1, $08:$80C9, $0A:$80F2, $0A:$813B)
    sta $0194
    stx $0195
    sty $0196
    lda $05F6 ; current bank

    pha
    php
    jsr $FF0E ; from the perspective of the caller (which always pushes 2 extra bytes to the stack before calling us), increment JSR's return address, read byte following JSR, parse it for bank and pointer index, set $D6-$D7 to $8000,X-$8001,X in selected bank

    plp
    ldy $0196
    ldx $0195
    lda $0194
    jsr $FEC8 ; execute ($D6)

    php
    sta $0194
    pla
    sta $D6
    pla ; original value of $05F6 (current bank)

    jsr $FFBB ; save A to $05F6, X to $43, and load bank specified by A

    lda $D6 ; P

    pha
    lda $0194
    plp
    rts

; execute ($D6)
; control flow target (from $FEB2)
    jmp ($00D6)


; code -> unknown
; must be unused since it's invalid

.byte $20,$DA,$FE,$A5,$D6,$95,$00,$A5
.byte $D7,$95,$01,$AD
.byte $94,$01
.byte $60
; unknown -> code
; parse byte following JSR for bank and pointer index, set $D6-$D7 to $8000,X-$8001,X in selected bank
; control flow target (from $E4EC)
; external control flow target (from $02:$B1C0)
    sta $0194
    stx $0195
    sty $0196
    lda $05F6 ; current bank

    pha
    pha
    jsr $FF0E ; from the perspective of the caller (which always pushes 2 extra bytes to the stack before calling us), increment JSR's return address, read byte following JSR, parse it for bank and pointer index, set $D6-$D7 to $8000,X-$8001,X in selected bank

    pla
    pla
    jsr $FFBB ; save A to $05F6, X to $43, and load bank specified by A

    ldy $0196
    ldx $0195
    lda $0194
    rts

; increment JSR's return address, read byte following JSR, parse it for bank and pointer index, set $D6-$D7 to $8000,X-$8001,X in selected bank
; control flow target (from $E4F8, $ECFB)
    php
    pha
    stx $0195
    sty $0196
    jsr $FF0E ; from the perspective of the caller (which always pushes 2 extra bytes to the stack before calling us), increment JSR's return address, read byte following JSR, parse it for bank and pointer index, set $D6-$D7 to $8000,X-$8001,X in selected bank

    ldy $0196
    ldx $0195
    pla
    plp
    rts

; from the perspective of the caller (which always pushes 2 extra bytes to the stack before calling us), increment JSR's return address, read byte following JSR, parse it for bank and pointer index, set $D6-$D7 to $8000,X-$8001,X in selected bank
; control flow target (from $FEA5, $FEE8, $FF02)
    tsx
    inc $0105,X
    bne B0F_FF17
    inc $0106,X
; control flow target (from $FF12)
B0F_FF17:
    lda $0105,X
    sta $D6
    lda $0106,X
    sta $D7
    ldy #$00
    lda ($D6),Y
    jsr $FF33 ; parse A into bank and pointer indices and load specified bank

    lda $8000,X
    sta $D6
    lda $8001,X
    sta $D7
    rts

; parse A into bank and pointer indices and load specified bank
; bank is high 3 bits of A (but 8 if 0 and 6 if 5), pointer is low 5 bits of A (but low 6 if bank is 6)
; control flow target (from $F3EA, $FF25)
    pha
    rol
    rol
    rol
    rol
    and #$07
    bne B0F_FF40
    lda #$08
    bne B0F_FF46
; control flow target (from $FF3A)
B0F_FF40:
    cmp #$05
    bne B0F_FF46
    lda #$06
; control flow target (from $FF3E, $FF42)
B0F_FF46:
    jsr $FFBB ; save A to $05F6, X to $43, and load bank specified by A

    pla
    pha
    and #$E0
    tax
    pla
    and #$3F
    cpx #$A0
    beq B0F_FF57
    and #$1F
; control flow target (from $FF53)
B0F_FF57:
    asl
    tax
    rts

; external control flow target (from $07:$81E7, $07:$84EC, $07:$8529, $07:$8556)
    jsr $C7AF
    jmp $FF90 ; load bank 7


; external control flow target (from $07:$81CE)
    jsr $D14F
    jmp $FF90 ; load bank 7


; external control flow target (from $07:$8692)
    jsr $C504
    jmp $FF90 ; load bank 7


; external indirect control flow target (via $07:$8798)
; indirect control flow target
    jsr $E5C2
    jmp $FF90 ; load bank 7


; external indirect control flow target (via $07:$879C)
; indirect control flow target
    jsr $E636
    jmp $FF90 ; load bank 7


; external indirect control flow target (via $07:$8796)
; indirect control flow target
    jsr $E797
    jmp $FF90 ; load bank 7


; external indirect control flow target (via $07:$879A)
; indirect control flow target
    jsr $E6B4
    jmp $FF90 ; load bank 7


; external control flow target (from $07:$8231, $07:$8242, $07:$8278, $07:$8330, $07:$835F, $07:$8374, $07:$8385, $07:$83FB, $07:$849C, $07:$84D5, $07:$84F6, $07:$8503, $07:$851C, $07:$8533, $07:$8560, $07:$857F, $07:$85EE, $07:$8776)
    jsr $CCD2 ; execute scripted motion

    jmp $FF90 ; load bank 7


; external control flow target (from $07:$8291, $07:$82B1, $07:$82DC, $07:$856B, $07:$85AC, $07:$85E4, $07:$8651, $07:$8675, $07:$86E2, $07:$8712)
    jsr $D8CB
    jmp $FF90 ; load bank 7


; load bank 7
; control flow target (from $FF5D, $FF63, $FF69, $FF6F, $FF75, $FF7B, $FF81, $FF87, $FF8D)
    lda #$07
    sta $94 ; return bank for various function calls, doubles as index of selected option for multiple-choice menus

    jmp $F6C2 ; load bank specified by $94



; code -> free
.res $21
; ... skipping $21 FF bytes
.byte $FF

.byte $FF
; free -> data
; data load target (from $D37A)

.byte $FF
; data -> code
; save A to $05F6, X to $43, and load bank specified by A
; control flow target (from $C3D5, $FEBD, $FEED, $FF46)
    sta $05F6 ; current bank

    stx $43
; load bank specified by A
; control flow target (from $C3D9)
    sei
    sta $FFFF
    lsr
    sta $FFFF
    lsr
    sta $FFFF
    lsr
    sta $FFFF
    lsr
    sta $FFFF
    nop
    nop
    rts

; reset vector
; indirect control flow target (via $FFFC)
    sei
    inc $FFDE ; #$80; used to reset MMC1 shift register and switch to last-fixed-bank mode

    jmp $C5AF ; reset vector handler



; code -> data
; #$80; used to reset MMC1 shift register and switch to last-fixed-bank mode
; data load target (from $C60B, $FFD8)

.byte $80
; data -> unknown

.byte $44,$52,$41,$47,$4F,$4E,$20,$57,$41,$52,$52,$49,$4F,$52
.byte $20,$49,$49,$C7,$AA,$00,$00
.byte $48,$04,$01
.byte $0F,$07
.byte $9D
; unknown -> data
.byte $00,$C0,$D7
.byte $FF,$AB
.byte $C5
