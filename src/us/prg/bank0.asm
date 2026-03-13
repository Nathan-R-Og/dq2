.segment        "PRG0":absolute
; code bytes:	$04B1 (7.33% of bytes in this ROM bank)
; data bytes:	$0113 (1.68% of bytes in this ROM bank)
; pcm bytes:	$0000 (0.00% of bytes in this ROM bank)
; chr bytes:	$33A0 (80.66% of bytes in this ROM bank)
; free bytes:	$0676 (10.10% of bytes in this ROM bank)
; unknown bytes:	$0027 (0.24% of bytes in this ROM bank)
; $3963 bytes last seen in RAM bank $8000 - $BFFF (100.00% of bytes seen in this ROM bank, 89.67% of bytes in this ROM bank):
;	$04B1 code bytes (8.18% of bytes seen in this RAM bank, 7.33% of bytes in this ROM bank)
;	$0113 data bytes (1.87% of bytes seen in this RAM bank, 1.68% of bytes in this ROM bank)
;	$33A0 chr bytes (89.96% of bytes seen in this RAM bank, 80.66% of bytes in this ROM bank)

; PRG Bank 0x00: mostly CHR and code for loading it

; [bank start] -> code
; external control flow target (from $0F:$C54B, $0F:$C552, $0F:$C559, $0F:$C6AF, $0F:$D2A3, $0F:$D2B0, $0F:$E420, $0F:$E442)
; possible external indexed data load target (from $0F:$F3ED, $0F:$FF28)
; possible external indexed data load target (from $0F:$F3F2, $0F:$FF2D)
    jmp $8015

; external control flow target (from $0F:$D30A, $0F:$D499)
    jmp $821B ; A format is (bit 6 = ?, bits 5-2 = index into $8331, bits 1-0 = ?)


; external control flow target (from $0F:$D222, $0F:$D236)
    jmp $B820

; external control flow target (from $0F:$D241)
    jmp $B7BD

; external control flow target (from $0F:$D253)
    jmp $B783

; external control flow target (from $0F:$C2F6)
    jmp $B8EB

; return value for $0D for post-Malroth dialogue
; external control flow target (from $0F:$D337)
    jmp $814D ; return value for $0D for post-Malroth dialogue


; control flow target (from $8000)
    lda $0C ; index into the CHR pointer structure at $8161

    pha ; save $0C since $80E5 will overwrite it

    jsr $80E5 ; given an index into the CHR pointer structure at $8161 in $0C, copy the appropriate 6 bytes from $8161 into $0C-$11

    pla
    cmp #$0E
    beq B00_8037 ; load bank 0 (... but it's already loaded...), wait for interrupt, set $6007 to #$FF, turn screen off, copy ($0C) inclusive - ($0E) exclusive to PPU at ($10), wait for interrupt, turn screen sprites and backround on

    cmp #$0F
    beq B00_8037 ; load bank 0 (... but it's already loaded...), wait for interrupt, set $6007 to #$FF, turn screen off, copy ($0C) inclusive - ($0E) exclusive to PPU at ($10), wait for interrupt, turn screen sprites and backround on

    cmp #$05 ; anything else #$05 or greater

    bcs B00_803C ; copy 1bpp CHR data from ($0C) inclusive - ($0E) exclusive to PPU at ($10)

    cmp #$02
    beq B00_807B ; load dungeon tileset for current map ID >= #$2B

    cmp #$03
    beq B00_807B ; load dungeon tileset for current map ID >= #$2B

    cmp #$04
    bne B00_8037 ; load bank 0 (... but it's already loaded...), wait for interrupt, set $6007 to #$FF, turn screen off, copy ($0C) inclusive - ($0E) exclusive to PPU at ($10), wait for interrupt, turn screen sprites and backround on

; #$04
    jmp $80FD

; load bank 0 (... but it's already loaded...), wait for interrupt, set $6007 to #$FF, turn screen off, copy ($0C) inclusive - ($0E) exclusive to PPU at ($10), wait for interrupt, turn screen sprites and backround on
; control flow target (from $801E, $8022, $8032)
B00_8037:
    lda #$00
; call to code in a different bank ($0F:$C3DC)
    jmp $C3DC ; load bank specified by A, wait for interrupt, set $6007 to #$FF, turn screen off, copy ($0C) inclusive - ($0E) exclusive to PPU at ($10), wait for interrupt, turn screen sprites and backround on


; copy 1bpp CHR data from ($0C) inclusive - ($0E) exclusive to PPU at ($10)
; control flow target (from $8026)
; call to code in a different bank ($0F:$C1DC)
B00_803C:
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

; call to code in a different bank ($0F:$C3E8)
    jsr $C3E8 ; wait for interrupt, set $6007 to #$FF, turn screen off

    lda $10
    sta $2006 ; VRAM Address Register #2 (write twice; $2007 address)

    lda $11
    sta $2006 ; VRAM Address Register #2 (write twice; $2007 address)

; control flow target (from $8076)
B00_804C:
    ldy #$00
; control flow target (from $8056)
B00_804E:
    lda ($0C), y ; PPU data

    sta $2007 ; VRAM I/O Register

    iny
    cpy #$08 ; copy 8 bytes of 1bpp data

    bne B00_804E
    ldy #$08 ; useless op

    lda #$00 ; fill the other half of the required 2bpp data with #$00

; control flow target (from $8060)
B00_805C:
    sta $2007 ; VRAM I/O Register

    dey
    bne B00_805C
    lda $0C ; read address, low byte

    clc
    adc #$08 ; we read 8 bytes of data

    sta $0C ; new read address, low byte

    bcc B00_806D
    inc $0D ; if low byte overflowed, increment high byte

; control flow target (from $8069)
B00_806D:
    lda $0E ; stop address, low byte

    sec
    sbc $0C ; new read address, low byte

    lda $0F ; stop address, high byte

    sbc $0D ; new read address, high byte

    bcs B00_804C ; if more data to copy, copy it

; call to code in a different bank ($0F:$C41C)
    jmp $C41C ; wait for interrupt, turn screen sprites and backround on


; load dungeon tileset for current map ID >= #$2B
; control flow target (from $802A, $802E)
; call to code in a different bank ($0F:$C1DC)
B00_807B:
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

; call to code in a different bank ($0F:$C3E8)
    jsr $C3E8 ; wait for interrupt, set $6007 to #$FF, turn screen off

; call to code in a different bank ($0F:$C3F6)
    jsr $C3F6 ; copy ($0C) inclusive - ($0E) exclusive to PPU at ($10)

    lda $31 ; current map ID

    sec
    sbc #$2B ; aside from the world map and Moonbrooke, map IDs < #$2B do not have random encounters

    tax
    lda $81C1, x ; tilesets for map IDs >= #$2B

    sta $12 ; bit field of tilesets to load

    lda #$07
    sta $13 ; loop counter

; control flow target (from $80E0)
B00_8093:
    asl $12 ; pick the next bit to process

    bcc B00_80DA ; bit not set => move to next loop iteration

    lda $13 ; loop counter

    sta $0C ; index into the CHR pointer structure at $8161

    cmp #$0A ; tileset bit field #$10 (Solid colour tile #1) gets copied #$10 times

    bne B00_80A3
    lda #$10
    bne B00_80B5
; control flow target (from $809D)
B00_80A3:
    cmp #$0B ; tileset bit field #$08 (Solid colour tile #2) gets copied #$10 times

    bne B00_80AB
    lda #$10
    bne B00_80B5
; control flow target (from $80A5)
B00_80AB:
    cmp #$0C ; tileset bit field #$04 (Spackled tile) gets copied #$02 times

    bne B00_80B3
    lda #$02
    bne B00_80B5
; control flow target (from $80AD)
B00_80B3:
    lda #$01 ; all other tileset bit fields get copied once

; control flow target (from $80A1, $80A9, $80B1)
B00_80B5:
    sta $49 ; object hero/target/item/string ID $49

    jsr $80E5 ; given an index into the CHR pointer structure at $8161 in $0C, copy the appropriate 6 bytes from $8161 into $0C-$11

; control flow target (from $80D8)
B00_80BA:
    lda $0C ; save $0C-$0D on the stack

    pha
    lda $0D
    pha
; call to code in a different bank ($0F:$C3F6)
    jsr $C3F6 ; copy ($0C) inclusive - ($0E) exclusive to PPU at ($10)

    pla ; restore $0C-$0D from the stack

    sta $0D
    pla
    sta $0C
    lda $10 ; PPU write start address

    clc
    adc #$10 ; for loop iterations that set $49 > #$01, we'll copy the same tile multiple times

    sta $10 ; so update the PPU write address in preparation for the next copy

    lda $11
    adc #$00 ; add carry from low byte

    sta $11
    dec $49 ; object hero/target/item/string ID $49

    bne B00_80BA ; if we need to copy the same tile again, go copy it

; control flow target (from $8095)
B00_80DA:
    inc $13 ; loop counter

    lda $13 ; loop counter

    cmp #$0E ; we started at #$07, so there are a max of 7 loops

    bne B00_8093
; call to code in a different bank ($0F:$C41C)
    jmp $C41C ; wait for interrupt, turn screen sprites and backround on


; given an index into the CHR pointer structure at $8161 in $0C, copy the appropriate 6 bytes from $8161 into $0C-$11
; control flow target (from $8018, $80B7)
    lda $0C
    asl
    asl
    asl $0C
    adc $0C ; A = $0C * 6

    tax
    ldy #$00
; control flow target (from $80FA)
B00_80F0:
    lda $8161, x ; group of 3 pointers: copy CHR data from RAM pointer #1 - pointer #2 to PPU starting at pointer #3

    sta $000C, y
    inx
    iny
    cpy #$06
    bne B00_80F0
    rts

; control flow target (from $8034)
    lda #$00
; call to code in a different bank ($0F:$C3DC)
    jsr $C3DC ; load bank specified by A, wait for interrupt, set $6007 to #$FF, turn screen off, copy ($0C) inclusive - ($0E) exclusive to PPU at ($10), wait for interrupt, turn screen sprites and backround on

    jsr $814D ; return value for $0D for post-Malroth dialogue

    jsr $821B ; A format is (bit 6 = ?, bits 5-2 = index into $8331, bits 1-0 = ?)

    lda $61AD
    beq B00_8122
    lda #$95
    jsr $821B ; A format is (bit 6 = ?, bits 5-2 = index into $8331, bits 1-0 = ?)

    lda #$B0
    jsr $821B ; A format is (bit 6 = ?, bits 5-2 = index into $8331, bits 1-0 = ?)

    lda $31 ; current map ID

    cmp #$03 ; Map ID #$03: Midenhall 1F

    bne B00_8122
    lda #$AC
    jsr $821B ; A format is (bit 6 = ?, bits 5-2 = index into $8331, bits 1-0 = ?)

; control flow target (from $810B, $811B)
B00_8122:
    lda $062D ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    and #$84
    cmp #$04
    bne B00_8130
    lda #$18
    jsr $821B ; A format is (bit 6 = ?, bits 5-2 = index into $8331, bits 1-0 = ?)

; control flow target (from $8129)
B00_8130:
    lda $063F ; Cannock status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    and #$84
    cmp #$04
    bne B00_813E
    lda #$19
    jsr $821B ; A format is (bit 6 = ?, bits 5-2 = index into $8331, bits 1-0 = ?)

; control flow target (from $8137)
B00_813E:
    lda $0651 ; Moonbrooke status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    and #$84
    cmp #$04
    bne B00_814C
    lda #$1A
    jsr $821B ; A format is (bit 6 = ?, bits 5-2 = index into $8331, bits 1-0 = ?)

; control flow target (from $8145)
B00_814C:
    rts

; return value for $0D for post-Malroth dialogue
; control flow target (from $8012, $8102)
    lda $31 ; current map ID

    ldy #$0B
; control flow target (from $8157)
B00_8151:
    cmp $8203, y
    beq B00_815D ; if current map ID is one of the listed maps, use the corresponding value from $820F

    dey
    bpl B00_8151
    lda #$13 ; if current map ID is not one of the listed maps, use #$13

    bne B00_8160
; control flow target (from $8154)
B00_815D:
    lda $820F, y
; control flow target (from $815B)
B00_8160:
    rts

; code -> data
; group of 3 pointers: copy CHR data from RAM pointer #1 - pointer #2 to PPU starting at pointer #3
; indexed data load target (from $80F0)
.addr gfx_WorldMap	 ; $00:$8C43; World Map tileset
.addr gfx_WorldMap_END-1	 ; $00:$9192
.addr $0900	 ; $0900

.addr gfx_Town	 ; $00:$9193; Town tileset
.addr gfx_Town_END-1	 ; $00:$9832
.addr $0900	 ; $0900

.addr gfx_Cave	 ; $00:$9833; Cave tileset #1
.addr gfx_Cave_END-1	 ; $00:$9C42
.addr $0900	 ; $0900

.addr gfx_Tower	 ; $00:$9C43; Tower tileset
.addr gfx_Tower_END-1	 ; $00:$A042
.addr $0900	 ; $0900

.addr gfx_Npc	 ; $00:$A043; NPC sprite tiles
.addr gfx_Npc_END-1	 ; $00:$B042
.addr $1000	 ; $1000

.addr gfx_ui	 ; $00:$B043; Text/menu tiles
.addr gfx_ui_END-1	 ; $00:$B4AA
.addr $0000	 ; $0000

.addr gfx_credits	 ; $00:$B4AB; End Credits text tiles
.addr gfx_credits_END-1	 ; $00:$B773
.addr $0000	 ; $0000

.addr gfx_Cave1	 ; $00:$9833; Cave tileset #1
.addr gfx_Cave1_END-1	 ; $00:$9932
.addr $0A00	 ; $0A00

.addr gfx_Cave2	 ; $00:$9933; Cave tileset #2
.addr gfx_Cave2_END-1	 ; $00:$9A32
.addr $0900	 ; $0900

.addr $9B23	 ; $00:$9B23; Cave lava tileset
.addr $9B42	 ; $00:$9B42
.addr $0BD0	 ; $0BD0

.addr $A023	 ; $00:$A023; Solid colour tile #1
.addr $A032	 ; $00:$A032
.addr $0A00	 ; $0A00

.addr $A033	 ; $00:$A033; Solid colour tile #2
.addr $A042	 ; $00:$A042
.addr $0E00	 ; $0E00

.addr $9A33	 ; $00:$9A33; Spackled tile
.addr $9A42	 ; $00:$9A42
.addr $0BD0	 ; $0BD0

.addr $9C43	 ; $00:$9C43; Tower tileset
.addr $9D42	 ; $00:$9D42
.addr $0E00	 ; $0E00

.addr $B773	 ; $00:$B773
.addr $B783	 ; $00:$B783
.addr $05F0	 ; $05F0

.addr $B783	 ; $00:$B783
.addr $B783	 ; $00:$B783
.addr $1000	 ; $1000
; tilesets for map IDs >= #$2B
; indexed data load target (from $808A)
.byte $80	 ; Map ID #$2B: Cave to Hamlin; Cave tileset #1
.byte $40	 ; Map ID #$2C: Lake Cave B1; Cave tileset #1
.byte $40	 ; Map ID #$2D: Lake Cave B2; Cave tileset #1
.byte $60	 ; Map ID #$2E: Sea Cave B1; Cave tileset #1 + Cave lava tileset
.byte $60	 ; Map ID #$2F: Sea Cave B2; Cave tileset #1 + Cave lava tileset
.byte $60	 ; Map ID #$30: Sea Cave B3-1; Cave tileset #1 + Cave lava tileset
.byte $60	 ; Map ID #$31: Sea Cave B3-2; Cave tileset #1 + Cave lava tileset
.byte $60	 ; Map ID #$32: Sea Cave B4; Cave tileset #1 + Cave lava tileset
.byte $60	 ; Map ID #$33: Sea Cave B5; Cave tileset #1 + Cave lava tileset
.byte $80	 ; Map ID #$34: Charlock Castle B1/B2; Cave tileset #1
.byte $80	 ; Map ID #$35: Charlock Castle B3/B4-1/B5-1; Cave tileset #1
.byte $80	 ; Map ID #$36: Charlock Castle B4-2/B5-2/B6; Cave tileset #1
.byte $80	 ; Map ID #$37: Cave to Rhone B1; Cave tileset #1
.byte $44	 ; Map ID #$38: Cave to Rhone 1F; Cave tileset #1 + Spackled tile
.byte $44	 ; Map ID #$39: Cave to Rhone 2F-1; Cave tileset #1 + Spackled tile
.byte $44	 ; Map ID #$3A: Cave to Rhone 2F-2; Cave tileset #1 + Spackled tile
.byte $44	 ; Map ID #$3B: Cave to Rhone 2F-3; Cave tileset #1 + Spackled tile
.byte $44	 ; Map ID #$3C: Cave to Rhone 3F; Cave tileset #1 + Spackled tile
.byte $44	 ; Map ID #$3D: Cave to Rhone 4F; Cave tileset #1 + Spackled tile
.byte $44	 ; Map ID #$3E: Cave to Rhone 5F; Cave tileset #1 + Spackled tile
.byte $44	 ; Map ID #$3F: Cave to Rhone 6F; Cave tileset #1 + Spackled tile
.byte $40	 ; Map ID #$40: Spring of Bravery; Cave tileset #1
.byte $40	 ; Map ID #$41: unused?; Cave tileset #1
.byte $40	 ; Map ID #$42: unused?; Cave tileset #1
.byte $80	 ; Map ID #$43: Cave to Rimuldar; Cave tileset #1
.byte $02	 ; Map ID #$44: Hargon's Castle 2F; Tower tileset
.byte $02	 ; Map ID #$45: Hargon's Castle 3F; Tower tileset
.byte $02	 ; Map ID #$46: Hargon's Castle 4F; Tower tileset
.byte $02	 ; Map ID #$47: Hargon's Castle 5F; Tower tileset
.byte $02	 ; Map ID #$48: Hargon's Castle 6F; Tower tileset
.byte $02	 ; Map ID #$49: Moon Tower 1F; Tower tileset
.byte $02	 ; Map ID #$4A: Moon Tower 2F; Tower tileset
.byte $02	 ; Map ID #$4B: Moon Tower 3F; Tower tileset
.byte $02	 ; Map ID #$4C: Moon Tower 4F; Tower tileset
.byte $02	 ; Map ID #$4D: Moon Tower 5F; Tower tileset
.byte $02	 ; Map ID #$4E: Moon Tower 6F; Tower tileset
.byte $02	 ; Map ID #$4F: Moon Tower 7F; Tower tileset
.byte $02	 ; Map ID #$50: Lighthouse 1F; Tower tileset
.byte $02	 ; Map ID #$51: Lighthouse 2F; Tower tileset
.byte $02	 ; Map ID #$52: Lighthouse 3F; Tower tileset
.byte $02	 ; Map ID #$53: Lighthouse 4F; Tower tileset
.byte $02	 ; Map ID #$54: Lighthouse 5F; Tower tileset
.byte $02	 ; Map ID #$55: Lighthouse 6F; Tower tileset
.byte $02	 ; Map ID #$56: Lighthouse 7F; Tower tileset
.byte $02	 ; Map ID #$57: Lighthouse 8F; Tower tileset
.byte $02	 ; Map ID #$58: Wind Tower 1F; Tower tileset
.byte $02	 ; Map ID #$59: Wind Tower 2F; Tower tileset
.byte $02	 ; Map ID #$5A: Wind Tower 3F; Tower tileset
.byte $02	 ; Map ID #$5B: Wind Tower 4F; Tower tileset
.byte $02	 ; Map ID #$5C: Wind Tower 5F; Tower tileset
.byte $02	 ; Map ID #$5D: Wind Tower 6F; Tower tileset
.byte $02	 ; Map ID #$5E: Wind Tower 7F; Tower tileset
.byte $02	 ; Map ID #$5F: Wind Tower 8F; Tower tileset
.byte $08	 ; Map ID #$60: Dragon Horn South 1F; Solid colour tile #2
.byte $18	 ; Map ID #$61: Dragon Horn South 2F; Solid colour tile #1 + Solid colour tile #2
.byte $18	 ; Map ID #$62: Dragon Horn South 3F; Solid colour tile #1 + Solid colour tile #2
.byte $18	 ; Map ID #$63: Dragon Horn South 4F; Solid colour tile #1 + Solid colour tile #2
.byte $18	 ; Map ID #$64: Dragon Horn South 5F; Solid colour tile #1 + Solid colour tile #2
.byte $08	 ; Map ID #$65: Dragon Horn South 6F; Solid colour tile #2
.byte $08	 ; Map ID #$66: Dragon Horn North 1F; Solid colour tile #2
.byte $08	 ; Map ID #$67: Dragon Horn North 2F; Solid colour tile #2
.byte $08	 ; Map ID #$68: Dragon Horn North 3F; Solid colour tile #2
.byte $08	 ; Map ID #$69: Dragon Horn North 4F; Solid colour tile #2
.byte $08	 ; Map ID #$6A: Dragon Horn North 5F; Solid colour tile #2
.byte $08	 ; Map ID #$6B: Dragon Horn North 6F; Solid colour tile #2
.byte $08	 ; Map ID #$6C: Dragon Horn North 7F; Solid colour tile #2
; indexed data load target (from $8151)
.byte $01	 ; Map ID #$01: World Map
.byte $08	 ; Map ID #$08: Hamlin Waterway
.byte $0B	 ; Map ID #$0B: Lianport
.byte $10	 ; Map ID #$10: Zahan
.byte $16	 ; Map ID #$16: Hargon's Castle 1F
.byte $17	 ; Map ID #$17: Hargon's Castle 7F
.byte $18	 ; Map ID #$18: Charlock Castle B8
.byte $21	 ; Map ID #$21: Rhone Cave Shrine
.byte $4B	 ; Map ID #$4B: Moon Tower 3F
.byte $51	 ; Map ID #$51: Lighthouse 2F
.byte $56	 ; Map ID #$56: Lighthouse 7F
.byte $09	 ; Map ID #$09: Moonbrooke
; indexed data load target (from $815D)
.byte $2B
.byte $0B
.byte $0B
.byte $0F
.byte $0B
.byte $03
.byte $07
.byte $0B
.byte $0F
.byte $0B
.byte $0B
.byte $0B

; data -> code
; A format is (bit 6 = ?, bits 5-2 = index into $8331, bits 1-0 = ?)
; control flow target (from $8003, $8105, $810F, $8114, $811F, $812D, $813B, $8149)
B00_821B:
    sta $D5
    lsr
    and #$1E
    tax
    lda GFX_TABLE_1, x
    sta UNK_D6
    lda GFX_TABLE_1+1, x
    sta UNK_D6+1
    lda #$00
    sta $D9
    lda $D5
    pha
    asl
    and #$86
    sta $D5
    asl
    bcs B00_823D
; call to code in a different bank ($0F:$C3E8)
    jsr $C3E8 ; wait for interrupt, set $6007 to #$FF, turn screen off

; control flow target (from $8238)
B00_823D:
    pla
    and #$3C
    cmp #$2C
    beq B00_825C
    cmp #$30
    beq B00_825C
    cmp #$1C
    bcc B00_825C
    ldx #$00
; control flow target (from $8255)
B00_824E:
    txa
    sta $0663, x ; monster ID, group 1

    inx
    cpx #$20
    bne B00_824E
    stx $DA
    jmp $82B4

; control flow target (from $8242, $8246, $824A)
B00_825C:
    ldy #$00
    sty $DA
; control flow target (from $82B2)
B00_8260:
    sty $DB
    jsr B00_83BE
    bcs B00_8272
    lda $DA
    sta $0663, y ; monster ID, group 1

    inc $DA
    iny
    jmp $82B0

; control flow target (from $8265)
B00_8272:
    jsr B00_83BE
    bcs B00_828A
    ldy #$05
    jsr $83B4
    asl
    jsr B00_83BE
    ror
    ldy $DB
    sta $0663, y ; monster ID, group 1

    iny
    jmp $82B0

; control flow target (from $8275)
B00_828A:
    ldy #$03
    jsr $83B4
    ldy $DB
    asl
    asl
    jsr B00_83BE
    tax
    bcs B00_82A1
    lda #$04
    jsr $834D
    jmp $82B0

; control flow target (from $8297)
B00_82A1:
    pha
    inx
    inx
    lda #$82
    jsr $834D
    pla
    tax
    lda #$82
    jsr $834D
; control flow target (from $826F, $8287, $829E)
    cpy #$20
    bne B00_8260
; control flow target (from $8259)
    lda #$00
; control flow target (from $831F)
B00_82B6:
    sta $DB
    ldy #$00
; control flow target (from $82C3)
B00_82BA:
    jsr B00_83D7 ; return ($D6) in A, INC 16-bit $D6

    sta $0683, y
    iny
    cpy #$10
    bne B00_82BA
    ldy #$00
; control flow target (from $8315)
B00_82C7:
    lda $0663, y ; monster ID, group 1

    eor $DB
    and #$1F
    bne B00_8312
    sty $DC
    lda $834B
    sta $0C
    lda $834C
    sta $0D
    lda $0663, y ; monster ID, group 1

    bpl B00_830D
    lda #$10
    clc
    adc $0C
    sta $0C
    bcc B00_82EC
    inc $0D
; control flow target (from $82E8)
B00_82EC:
    lda $DB
    bmi B00_830D
    ora #$80
    sta $DB
    ldx #$00
; control flow target (from $830B)
B00_82F6:
    lda $0683, x
    sta $DD
    ldy #$08
    lda #$00
; control flow target (from $8303)
B00_82FF:
    asl $DD
    ror
    dey
    bne B00_82FF
    sta $0693, x
    inx
    cpx #$10
    bne B00_82F6
; control flow target (from $82DF, $82EE)
B00_830D:
    jsr $8366
    ldy $DC
; control flow target (from $82CE)
B00_8312:
    iny
    cpy #$20
    bne B00_82C7
    inc $DB
    lda $DB
    and #$7F
    cmp $DA
    bne B00_82B6
    lda $D5
    bmi B00_8328
; call to code in a different bank ($0F:$C41C)
    jsr $C41C ; wait for interrupt, turn screen sprites and backround on

; control flow target (from $8323)
; call to code in a different bank ($0F:$C1DC)
B00_8328:
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    lda #$18
    sta $2001 ; PPU Control Register #2 (#$E0: Full Background Colour, #$01 set [None, Green, Blue, Red], #$E0: Colour Intensity, #$01 not set [None, Green, Blue, Red], #$10: Sprite Visibility, #$80: Background Visibility, #$40: No Sprite Clipping, #$20: No Background Clipping, #$01: Monochrome Display)

    rts


; code -> data
; indexed data load target (from $8221)
; indexed data load target (from $8226)
; indirect data load target (via $B8D7)
; data load target (from $82D2)
; data load target (from $82D7)

; data -> code
; control flow target (from $829B, $82A6, $82AD)
GFX_TABLE_1:
.addr gfx_hargon_overworld
.addr gfx_dragonlords_son_overworld
.addr gfx_gremlin_overworld
.addr gfx_kid_overworld
.addr gfx_healer_overworld
.addr gfx_moonbrooke_king_overworld
.addr gfx_party_dead_overworld
.addr B00_A043
.addr B00_A243
.addr B00_A443
.addr B00_A643
.addr gfx_guard_dead_overworld
.addr gfx_moonebrooke_king_dead_overworld

.byte $83,$06
    pha
    and #$80
    sta $DD
    pla
    and #$7F
    sta $DC
; control flow target (from $8363)
B00_8357:
    lda $0663, x ; monster ID, group 1

    eor $DD
    sta $0663, y ; monster ID, group 1

    inx
    iny
    dec $DC
    bne B00_8357
    rts

; control flow target (from $830D)
    lda #$00
    sta $07
    ldy #$04
    lda $DC
; control flow target (from $8372)
B00_836E:
    lsr
    ror $07
    dey
    bne B00_836E
    clc
    adc $D5
    and #$0F
    ora #$10
    sta $08
    lda $D5
    bmi B00_839A
    lda $07
    sta $10
    lda $08
    sta $11
    lda $0C
    clc
    adc #$0F
    sta $0E
    lda $0D
    adc #$00
    sta $0F
; call to code in a different bank ($0F:$C3F6)
    jsr $C3F6 ; copy ($0C) inclusive - ($0E) exclusive to PPU at ($10)

    rts

; control flow target (from $837F)
B00_839A:
    lda #$10
    sta $DD
; control flow target (from $83B1)
B00_839E:
    lda $02
    cmp #$A5
    bcc B00_83A7
; call to code in a different bank ($0F:$C1DC)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

; control flow target (from $83A2)
B00_83A7:
    jsr $83D2 ; return ($0C) in A, INC 16-bit $0C

    sta $09
; call to code in a different bank ($0F:$C1FA)
    jsr $C1FA ; wait for $02 to not be #$C0, write PPU address in $07-$08 and data in $09 to PPU write buffer at $0300,$02, $01 += 1, $02 += 3, and set $0183 to #$00

    dec $DD
    bne B00_839E
    rts

; control flow target (from $8279, $828C)
    lda #$00
; control flow target (from $83BB)
B00_83B6:
    jsr B00_83BE
    rol
    dey
    bne B00_83B6
    rts

; control flow target (from $8262, $8272, $827D, $8293, $83B6)
B00_83BE:
    ldx $D9
    bne B00_83CD
    pha
    jsr B00_83D7 ; return ($D6) in A, INC 16-bit $D6

    sta $D8
    lda #$08
    sta $D9
    pla
; control flow target (from $83C0)
B00_83CD:
    dec $D9
    asl $D8
    rts

; return ($0C) in A, INC 16-bit $0C
; control flow target (from $83A7)
    ldx #$0C
    jmp $83D9

B00_83D7:
; return ($D6) in A, INC 16-bit $D6
; control flow target (from $82BA, $83C3)
    ldx #UNK_D6
; control flow target (from $83D4)
    lda (0, x)
    inc 0, x
    bne @not_16
    inc 1, x
; control flow target (from $83DD)
    @not_16:
    rts

; code -> data
; indirect data load target (via $8331)
; data -> chr
; CHR data, 2bpp
;Hargon
gfx_hargon_overworld:
.byte $02,$12,$1B,$0C,$B0,$CB,$0C,$80
.incbin "../../split/us/gfx/hargon.bin"

; indirect CHR load target (via $8333)
;Dragonlord's Grandson
gfx_dragonlords_son_overworld:
.byte $08,$08,$23,$0C,$B0,$CB,$0C,$80
.incbin "../../split/us/gfx/dragonlords_grandson.bin"

; indirect CHR load target (via $8335)
;Gremlin
gfx_gremlin_overworld:
.byte $00,$00,$00,$A5,$A7,$2B,$6B,$EA,$40
.incbin "../../split/us/gfx/gremlin.bin"

; indirect CHR load target (via $8337)
;Kid
gfx_kid_overworld:
.byte $10,$78,$88,$9D,$50,$42,$09,$21,$CF,$60
.incbin "../../split/us/gfx/kid.bin"

; indirect CHR load target (via $8339)
;Healer
gfx_healer_overworld:
.byte $01,$0C,$09,$00,$05,$10,$28,$C0
.incbin "../../split/us/gfx/healer.bin"

; indirect CHR load target (via $833B)
gfx_moonbrooke_king_overworld:
.byte $00,$00,$00,$00
.incbin "../../split/us/gfx/moonbrooke_king.bin"

; indirect CHR load target (via $833D)
gfx_party_dead_overworld:
.byte $0C,$03,$40,$E3,$9E,$40
.incbin "../../split/us/gfx/party_dead.bin"

; indirect CHR load target (via $8347)
gfx_guard_dead_overworld:
.byte $0C,$30,$C3,$0C,$30,$C0
.incbin "../../split/us/gfx/guard_dead.bin"

; indirect CHR load target (via $8349)
gfx_moonebrooke_king_dead_overworld:
.byte $0C,$30,$C3,$0C,$30,$C0
.incbin "../../split/us/gfx/moonebrooke_king_dead.bin"

; World Map tileset
; indirect CHR load target (via $8161)
gfx_WorldMap:
.incbin "../../split/us/gfx/WorldMap.bin"
gfx_WorldMap_END:


; indexed data load target (from $B7EC)
;B00_8C73:
; indexed data load target (from $B7E0)
;B00_8CB3:
; indirect CHR load target (via $B8D5)
;pure water tile #1
;B00_8D43:
;B00_8D53:
; indirect CHR load target (via $B8D3)
;pure water tile #2
;B00_8D63:

; Town tileset
; indirect CHR load target (via $8167)
gfx_Town:
.incbin "../../split/us/gfx/Town.bin"
gfx_Town_END:

gfx_Cave:
.incbin "../../split/us/gfx/Cave.bin"
gfx_Cave_END:

; Cave tileset #1
; indirect CHR load target (via $816D, $818B)
gfx_Cave1 := $9833
gfx_Cave1_END := $9933
gfx_Cave2 := $9933
gfx_Cave2_END := $9A33
; Spackled tile
; indirect CHR load target (via $81A9)
;B00_9A33:
;B00_9A43:
; Cave lava tileset
; indirect CHR load target (via $8197)
;B00_9B23:
;B00_9B43:


; Tower tileset
; indirect CHR load target (via $8173, $81AF)

; indirect CHR load target (via $81B1)
gfx_Tower:
.incbin "../../split/us/gfx/Tower.bin"
gfx_Tower_END:

; Solid colour tile #2
; indirect CHR load target (via $81A3)
; Solid colour tile #1
; indirect CHR load target (via $819D)
;B00_A023:
; indirect CHR load target (via $819F)
;B00_A033:
; indirect CHR load target (via $8175, $81A5)
;B00_9C43:


; NPC sprite tiles
; indirect CHR load target (via $8179, $833F)
gfx_Npc:
.incbin "../../split/us/gfx/Npc.bin"
gfx_Npc_END:

; indirect CHR load target (via $8341)
B00_A043 := $a043
; indirect CHR load target (via $8341)
B00_A243 := $a243
; indirect CHR load target (via $8343)
B00_A443 := $a443
; indirect CHR load target (via $8345)
B00_A643 := $a643

; Text/menu tiles
; CHR data, 1bpp
; indirect CHR load target (via $817F)
gfx_ui:
.incbin "../../split/us/gfx/ui.bin"
gfx_ui_END:


; End Credits text tiles
; indirect CHR load target (via $8185)
gfx_credits:
.incbin "../../split/us/gfx/credits.bin"
gfx_credits_END:

; indirect CHR load target (via $8187, $81B5)
.res 15, 0


; chr -> code
; control flow target (from $800C)
; indirect data load target (via $81B7, $81BB, $81BD)
; call to code in a different bank ($0F:$C1DC)
; WARNING! $B783 was also seen as data
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    lda #$00
    sta $D8
    lda #$46
    sta $D9
; control flow target (from $B79F)
B00_B78E:
    jsr $B7C1
    lda #$94 ; Music ID #$94: burning SFX

; call to code in a different bank ($0F:$C561)
    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    lsr $D9
; call to code in a different bank ($0F:$C4FF)
    jsr $C4FF
    lda $D8
    cmp #$12
    bne B00_B78E
    lda #$03
    sta $D8
    lda #$02
    sta $D9
; control flow target (from $B7BA)
B00_B7A9:
    lda #$94 ; Music ID #$94: burning SFX

; call to code in a different bank ($0F:$C561)
    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    lsr $D9
; call to code in a different bank ($0F:$C4FF)
    jsr $C4FF
    ldx #$02
; call to code in a different bank ($0F:$C1EE)
    jsr $C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

    dec $D8
    bne B00_B7A9
    rts

; control flow target (from $8009)
    lda #$00
    sta $D8
; control flow target (from $B78E)
    lda #$60 ; RTS

    sta $DB
    ldx #$70
    ldy #$00
    lda #$0A ; ASL

    jsr $B7D4
    ldx #$90
    ldy #$20
    lda #$4A ; LSR

; control flow target (from $B7CB)
    sta $DA
    stx $07
    lda #$09
    sta $08
; control flow target (from $B806)
B00_B7DC:
    sty $DC
    ldx $D8
    lda $8CB3, y
    and $B80E, x
    sta $DD
    lda $D8
    lsr
    tax
    lda $8C73, y
    inx
; control flow target (from $B7F6)
    dex
    beq B00_B7F9
; call to code in RAM
    jsr $00DA
    jmp $B7F0

; control flow target (from $B7F1)
B00_B7F9:
    ora $DD
    sta $09
    jsr $B956
    ldy $DC
    iny
    tya
    and #$1F
    bne B00_B7DC
    inc $D8
; call to code in a different bank ($0F:$C1DC)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    rts


; code -> data
; indexed data load target (from $B7E3)

; data -> code
; control flow target (from $8006)
.byte $00,$00,$01,$80,$03,$C0,$07,$E0,$0F
.byte $F0,$1F,$F8,$3F,$FC
.byte $7F,$FE
.byte $FF
.byte $FF
    sta $D5
; call to code in a different bank ($0F:$C1DC)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    ldx #$00
; control flow target (from $B84F)
B00_B827:
    stx UNK_D6
    lda $B8C3, x
    pha
    lsr
    lsr
    and #$0F
    sta $D9
    pla
    asl
    asl
    and #$F0
    ora $D9
    eor $D5
    sta $D9
    ldx #$00 ; pure water tile #2

    stx UNK_D6+1
    jsr $B852
    ldx #$02 ; pure water tile #1

    jsr $B852
    ldx UNK_D6
    inx
    cpx #$10
    bne B00_B827
    rts

; control flow target (from $B842, $B847)
    lda $B8D3, x
    sta $DA
    lda $B8D4, x
    sta $DB
    lda #$09
    sta $D8
; control flow target (from $B8BB)
B00_B860:
    ldx $D7
    lda $B8D9, x
    pha
    and #$0F
    sta $08 ; current PPU write address, high byte

    pla
    and #$F0
    sta $07 ; current PPU write address, low byte

    clc
    adc $B8D7
    sta $DC
    lda $08 ; current PPU write address, high byte

    adc $B8D8
    sta $DD
    ldx UNK_D6
    lda $B8C3, x
    and #$03
    tay
    clc
    adc $07 ; current PPU write address, low byte

    sta $07 ; current PPU write address, low byte

    bcc B00_B88D
    inc $08 ; current PPU write address, high byte

; control flow target (from $B889, $B8B5)
B00_B88D:
    lda ($DA), y
    and $D9
    sta $DE
    lda $D9
    eor #$FF
    and ($DC), y
    ora $DE
    sta $09
    sty $DE
    jsr $B956
    ldy $DE
    iny
    iny
    iny
    iny
    lda $07 ; current PPU write address, low byte

    clc
    adc #$03
    sta $07 ; current PPU write address, low byte

    bcc B00_B8B3
    inc $08 ; current PPU write address, high byte

; control flow target (from $B8AF)
B00_B8B3:
    cpy #$10
    bcc B00_B88D
    inc $D7
    dec $D8
    bne B00_B860
    ldx #$05
; call to code in a different bank ($0F:$C1EE)
    jsr $C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

    rts


; code -> data
; indexed data load target (from $B829, $B87E)
; indexed data load target (from $B852)
; indexed data load target (from $B857)
; data load target (from $B870)
; data load target (from $B877)
; indexed data load target (from $B862)

; data -> code
; control flow target (from $800F)
.byte $20,$0A,$28,$2A,$11,$07,$15,$17,$38,$2E,$3C,$3E,$35,$1F,$3D,$3F
.byte $53,$8D,$43,$8D,$43,$83,$4A,$5A,$8A,$9A,$AA,$DA
.byte $FA,$2E,$3E,$3A,$6A,$7A
.byte $BA,$CA,$EA
.byte $0B,$1E
.byte $4E
    lda #$99 ; Music ID #$99: teleport SFX

; call to code in a different bank ($0F:$C561)
    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    ldx #$00
; control flow target (from $B8FB)
B00_B8F2:
    lda $050D, x
    sta $0663, x ; monster ID, group 1

    inx
    cpx #$0D
    bne B00_B8F2
    lda #$30
    sta $DB
    ldy #$00
; control flow target (from $B946)
B00_B903:
    sty $DA
    ldx #$00
; control flow target (from $B936)
B00_B907:
    stx $D9
    ldx #$00
; control flow target (from $B92C)
B00_B90B:
    lda $0663, x ; monster ID, group 1

    tay
    and #$30
    cmp $DB
    bcc B00_B917
    lda $DB
; control flow target (from $B913)
B00_B917:
    sta $D8
    tya
    clc
    adc $D9
; control flow target (from $B921)
B00_B91D:
    tay
    sec
    sbc #$0C
    bcs B00_B91D
    tya
    ora $D8
    sta $050D, x
    inx
    cpx #$0D
    bne B00_B90B
; call to code in a different bank ($0F:$C22C)
    jsr $C22C
    ldx $D9
    inx
    cpx #$0C
    bne B00_B907
    lda $DB
    beq B00_B941
    sec
    sbc #$10
    sta $DB
; control flow target (from $B93A)
B00_B941:
    ldy $DA
    iny
    cpy #$04
    bne B00_B903
    ldx #$00
; control flow target (from $B953)
B00_B94A:
    lda $0663, x ; monster ID, group 1

    sta $050D, x
    inx
    cpx #$0D
    bne B00_B94A
    rts

; control flow target (from $B7FD, $B89F)
    lda $02
    cmp #$A5
    bcc B00_B95F
; call to code in a different bank ($0F:$C1DC)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

; control flow target (from $B95A)
; call to code in a different bank ($0F:$C1FA)
B00_B95F:
    jmp $C1FA ; wait for $02 to not be #$C0, write PPU address in $07-$08 and data in $09 to PPU write buffer at $0300,$02, $01 += 1, $02 += 3, and set $0183 to #$00

.res $676

.byte $78,$EE,$DF,$BF,$4C,$86,$FF,$80
.literal "DRAGON WARRIORS2"
.byte $FF,$FF,$00,$00,$48,$04,$01,$0F
.byte $07,$9D,$D8,$BF,$D8,$BF,$D8,$BF