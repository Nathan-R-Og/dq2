.segment        "PRG4":absolute
; code bytes:	$2F45 (73.86% of bytes in this ROM bank)
; data bytes:	$101B (25.16% of bytes in this ROM bank)
; pcm bytes:	$0000 (0.00% of bytes in this ROM bank)
; chr bytes:	$0000 (0.00% of bytes in this ROM bank)
; free bytes:	$0078 (0.73% of bytes in this ROM bank)
; unknown bytes:	$0029 (0.25% of bytes in this ROM bank)
; $3F5F bytes last seen in RAM bank $8000 - $BFFF (100.00% of bytes seen in this ROM bank, 99.02% of bytes in this ROM bank):
;	$2F45 code bytes (74.59% of bytes seen in this RAM bank, 73.86% of bytes in this ROM bank)
;	$101B data bytes (25.41% of bytes seen in this RAM bank, 25.16% of bytes in this ROM bank)

; PRG Bank 0x04: mostly stuff related to getting into, through, and out of battles, including monster stats, hero EXP table, and equipment stats

; [bank start] -> code
; external control flow target (from $0F:$C905)
; possible external indexed data load target (from $0F:$F3ED, $0F:$FF28)
; possible external indexed data load target (from $0F:$F3F2, $0F:$FF2D)
    jmp $8022

; restore the hero ID in A's MP by a random amount based on the Wizard's Ring's power; returns a random number between $03 and #$0A in A and $99
; external control flow target (from $0F:$F725)
    jmp $A49E ; restore the hero ID in A's MP by a random amount based on the Wizard's Ring's power; returns a random number between $03 and #$0A in A and $99


; external control flow target (from $0F:$D149, $0F:$F72E)
    jmp $A402 ; heal hero ID in A by random amount based on healing power in X


; update each hero's stats based on their current EXP
; external control flow target (from $0F:$C774, $0F:$D0EF)
    jmp $9D0E ; update each hero's stats based on their current EXP


; set $8F-$90 to EXP required to reach next level
; external control flow target (from $0F:$F737)
    jmp $9CF1 ; set $8F-$90 to EXP required to reach next level


; external control flow target (from $0F:$C961, $0F:$D1A9, $0F:$D1CE, $0F:$D205, $0F:$D25F)
    jmp $82B9 ; trigger fixed battle A


; external control flow target (from $0F:$F740)
    jmp $99E6

; external control flow target (from $0F:$C509)
    jmp $8FE7

; external control flow target (from $0F:$C8FF)
    jmp $801D


; code -> unknown

.byte $00
.byte $00
; unknown -> code
; control flow target (from $8018)
    lda #$01 ; Terrain ID #$01: Transitions, Chamber of Horks

    jmp $8024

; control flow target (from $8000)
    lda #$02 ; Terrain ID #$02: Dungeon, Lava, Tower, Castle

; control flow target (from $801F)
    pha
    lda #$00
    sta $98 ; outcome of last fight?

    lda #$08 ; maximum # of attempts at starting a battle

    sta $D9
; control flow target (from $8032)
; call to code in a different bank ($0F:$C3AB)
B04_802D:
    jsr $C3AB ; generate a random number and store it in $32-$33 (two passes)

    lda $32 ; RNG byte 0

    beq B04_802D ; keep cycling through random numbers until $32 is not #$00; we'll maybe use $32 later on

    pla
    tax
    lda $31 ; current map ID

    cmp #$01 ; Map ID #$01: World Map

    beq B04_806E ; determine world map battle formation

    cmp #$09 ; Map ID #$09: Moonbrooke

    beq B04_8066 ; override terrain ID to Terrain ID #$02: Dungeon, Lava, Tower, Castle and use battle formation #$11: Zombie, Big Cobra, ---, Smoke, Centipod, Metal Slime

    sec
    sbc #$2B ; aside from the world map and Moonbrooke, map IDs < #$2B do not have random encounters

    bcc B04_806D ; no encounter

    tay
    lda $84C6,Y ; Dungeon Encounter Formations

    cpx #$01 ; Terrain ID #$01: Transitions, Chamber of Horks

    beq B04_80A4 ; use the current battle formation ID

    cpy #$0C ; Map ID #$37: Cave to Rhone B1

    beq B04_805C ; override terrain ID to Terrain ID #$01: Transitions, Chamber of Horks

    cpy #$12 ; Map ID #$3D: Cave to Rhone 4F

    beq B04_8061 ; override terrain ID to Terrain ID #$07: Cave to Rhone floors 5-7

    cpy #$13 ; Map ID #$3E: Cave to Rhone 5F

    beq B04_8061 ; override terrain ID to Terrain ID #$07: Cave to Rhone floors 5-7

    jmp $80A4

; override terrain ID to Terrain ID #$01: Transitions, Chamber of Horks
; control flow target (from $804F)
B04_805C:
    ldx #$01 ; Terrain ID #$01: Transitions, Chamber of Horks

    jmp $80A4

; override terrain ID to Terrain ID #$07: Cave to Rhone floors 5-7
; control flow target (from $8053, $8057)
B04_8061:
    ldx #$07 ; Terrain ID #$07: Cave to Rhone floors 5-7

    jmp $80A4

; override terrain ID to Terrain ID #$02: Dungeon, Lava, Tower, Castle and use battle formation #$11: Zombie, Big Cobra, ---, Smoke, Centipod, Metal Slime
; control flow target (from $803E)
B04_8066:
    ldx #$02 ; Terrain ID #$02: Dungeon, Lava, Tower, Castle

    lda #$11
    jmp $80A4

; no encounter
; control flow target (from $8043, $809E, $80A2, $80AD)
B04_806D:
    rts

; determine world map battle formation
; control flow target (from $803A)
B04_806E:
    lda $16 ; current map X-pos (1)

    lsr ; world map encounters are based on which 16x16 block you're in

    lsr
    lsr
    lsr
    sta $D5
    lda $17 ; current map Y-pos (1)

    and #$F0
    ora $D5 ; $D5 = high nybble of Y-pos | (high nybble of X-pos >> 4)

    tax
    lda $83C6,X ; World Map Encounters

    pha ; battle formation

    lda $3B ; high nybble = terrain ID

    lsr
    lsr
    lsr
    lsr
    tax
    pla ; battle formation

    cpx #$00 ; Terrain ID #$00: Grass

    beq B04_80A4
    dex
    cpx #$03 ; Terrain ID #$03: Sea

    bne B04_809E
    rol ; move high 2 bits to low 2 bits

    rol
    rol
    and #$03
    clc
    adc $8508 ; ocean battle formations come after terrestrial battle formations; why not just ADC #$40 directly?

    jmp $80A6

; control flow target (from $8090)
B04_809E:
    bcc B04_806D ; no encounter; terrains #$01 and #$02 are invalid on the world map

    cpx #$07 ; Terrain ID #$07: Cave to Rhone floors 5-7

    bcs B04_806D ; no encounter; terrains >= #$07 are invalid on the world map

; control flow target (from $804B, $8059, $805E, $8063, $806A, $808B)
B04_80A4:
    and #$3F
; control flow target (from $809B)
    sta $D8 ; battle formation index

    lda $832C,X ; per-terrain encounter rates

    cmp $32 ; RNG byte 0; compare to previously generated non-zero number

    bcc B04_806D ; no encounter; encounter rate < RNG => no encounter

; control flow target (from $80F9, $8149, $8162, $8188, $81C3)
    dec $D9 ; maximum # of attempts at starting a battle

    beq B04_80B9
    lda $D8 ; battle formation index

    cmp #$3F ; #$3F => no encounters

    bne B04_80BA
; control flow target (from $80B1)
B04_80B9:
    rts

; control flow target (from $80B7)
B04_80BA:
    ldx #$00 ; pointer high byte offset

    asl
    bcc B04_80C1 ; high bit of battle formation is never set, but if it were, this would add 3 to the high byte of the battle formation pointer

    ldx #$03
; control flow target (from $80BD)
B04_80C1:
    sta $D5 ; $D5 = battle formation * 2

    asl
    bcc B04_80C7 ; if second highest bit of battle formation is set, add 1 to the high byte of the battle formation pointer

    inx
; control flow target (from $80C4)
B04_80C7:
    clc
    adc $D5
    bcc B04_80CD ; if (battle formation * 6) overflows, add 1 to the high byte of the battle formation pointer

    inx
; control flow target (from $80CA)
B04_80CD:
    clc
    adc $8334 ; -> $04:$8509: Battle Formations

    sta $D5 ; $D5 = low byte of pointer to desired battle formation

    txa
    adc $8335
    sta $D6 ; battle formation; $D6 = high byte of pointer to desired battle formation

    jsr $837E ; initialize enemy group data at $0663-$068F to #$FF

; call to code in a different bank ($0F:$C3AB)
    jsr $C3AB ; generate a random number and store it in $32-$33 (two passes)

    lda $32 ; RNG byte 0

    and #$07
    bne B04_813B ; 1/8 chance for a special formation

    ldy #$00
    sty $D7 ; high bits of IDs in selected battle formation

; control flow target (from $80F1)
B04_80E9:
    lda ($D5),Y ; copy the high bits of the regular formation's 6 enemies into $D7

    asl
    rol $D7 ; high bits of IDs in selected battle formation

    iny
    cpy #$06 ; battle formation data is 6 bytes each

    bne B04_80E9
    lda $D7 ; high bits of IDs in selected battle formation

    cmp #$3F
    bne B04_80FC ; if all 6 enemies had their high bit set, try again with a different random number

    jmp $80AF ; otherwise loop to try again


; control flow target (from $80F7)
B04_80FC:
    asl ; special formations are 4 bytes each

    asl
    tax
    ldy #$00
; control flow target (from $8115)
B04_8101:
    lda $86A1,X ; Special Formations

    and #$7F
    cmp #$7F
    beq B04_810D ; #$FF and #$7F => no enemy

    sta $0663,Y ; monster ID, group 1; store monster ID

; control flow target (from $8108)
B04_810D:
    inx ; update special formation enemy read index

    tya ; update monster group write index

    clc
    adc #$0B ; monster group data is #$0B bytes

    tay
    cpy #$2C ; and there are a maximum of 4 groups (#$0B * #$04 = #$2C)

    bne B04_8101 ; if more groups to fill, go fill them

    lda $32 ; RNG byte 0

    asl
    asl
    asl
    asl
    pha ; RNG byte 0 << 4

    lda #$00
    adc #$02
    sta $0682 ; $0682 = #$02 + 1 bit of randomness

    pla ; RNG byte 0 << 4

    asl ; RNG byte 0 << 5

    lda #$00
    adc #$01
    sta $0677 ; $0677 = #$01 + 1 bit of randomness

    lda #$01
    sta $066C
    lda #$08
    sta $068D
    jmp $81F5

; control flow target (from $80E3)
B04_813B:
    cmp #$07 ; low 3 bits of RNG byte 0 are not all 0; check if they're all 1

    bne B04_8154
    ldy #$05
    lda ($D5),Y
    and #$7F
    cmp #$7F
    bne B04_814C
    jmp $80AF

; control flow target (from $8147)
B04_814C:
    ldx #$02
    jsr $83A3
    jmp $81F5

; control flow target (from $813D)
B04_8154:
    cmp #$06
    bne B04_817A
    ldy #$04
    lda ($D5),Y
    and #$7F
    cmp #$7F
    bne B04_8165
    jmp $80AF

; control flow target (from $8160)
B04_8165:
    ldx #$02
    jsr $83B7 ; given a monster group index in X, write the monster ID in A to the appropriate monster group data at $0663

    lda $32 ; RNG byte 0

    lsr
    lsr
    lsr
    and #$03
    clc
    adc #$03
    sta $066C,Y
    jmp $81F5

; control flow target (from $8156)
B04_817A:
    cmp #$05
    bne B04_81B2
    ldy #$03
    lda ($D5),Y
    and #$7F
    cmp #$7F
    bne B04_818B
    jmp $80AF

; control flow target (from $8186)
B04_818B:
    ldx #$02
    jsr $83A3
    ldx #$00
    jsr $8389 ; take current RNG value $33, figure out which $8398 bucket it fits into, and store that index in Y

    cpy #$06
    bcs B04_81E6
    cpy #$03
    bcc B04_81AC
    dey
    dey
    dey
    tya
    pha
    bne B04_81A6
    ldy #$03
; control flow target (from $81A2)
B04_81A6:
    dey
    jsr $83AC ; given a weird value <= #$03 in Y, get the monster ID from ($D5),Y and if it's not #$FF/#$7F, get the monster group index corresponding to Y from $83BE and write the monster ID to the appropriate monster group data at $0663

    pla
    tay
; control flow target (from $819B)
B04_81AC:
    jsr $83AC ; given a weird value <= #$03 in Y, get the monster ID from ($D5),Y and if it's not #$FF/#$7F, get the monster group index corresponding to Y from $83BE and write the monster ID to the appropriate monster group data at $0663

    jmp $81F5

; control flow target (from $817C)
B04_81B2:
    tay
    cpy #$02
    bcc B04_81B8
    dey
; control flow target (from $81B5)
B04_81B8:
    dey
    sty $D7 ; high bits of IDs in selected battle formation

    lda ($D5),Y
    and #$7F
    cmp #$7F
    bne B04_81C6
    jmp $80AF

; control flow target (from $81C1)
B04_81C6:
    jsr $83B4 ; given a weird value <= #$03 in Y, get the corresponding monster group index from $83BE and write the monster ID in A to the appropriate monster group data at $0663

    ldx #$07
    jsr $8389 ; take current RNG value $33, figure out which $8398 bucket it fits into, and store that index in Y

    tya
    beq B04_81E3
    cmp #$03
    bcs B04_81E6
    clc
    adc $D7 ; high bits of IDs in selected battle formation

    cmp #$03
    bcc B04_81DF
    sec
    sbc #$03
; control flow target (from $81DA)
B04_81DF:
    tay
    jsr $83AC ; given a weird value <= #$03 in Y, get the monster ID from ($D5),Y and if it's not #$FF/#$7F, get the monster group index corresponding to Y from $83BE and write the monster ID to the appropriate monster group data at $0663

; control flow target (from $81CF)
B04_81E3:
    jmp $81F5

; control flow target (from $8197, $81D3)
B04_81E6:
    lda #$00
; control flow target (from $81F3)
B04_81E8:
    pha
    tay
    jsr $83AC ; given a weird value <= #$03 in Y, get the monster ID from ($D5),Y and if it's not #$FF/#$7F, get the monster group index corresponding to Y from $83BE and write the monster ID to the appropriate monster group data at $0663

    pla
    clc
    adc #$01
    cmp #$03
    bne B04_81E8
; control flow target (from $8138, $8151, $8177, $81AF, $81E3)
    lda a:$46 ; Repel (#$FE) / Fairy Water (#$FF) flag

    beq B04_824F
    lda $31 ; current map ID

    cmp #$01 ; Map ID #$01: World Map

    bne B04_824F
    lda #$00
    sta $D5
; control flow target (from $8240)
B04_8204:
    tax
    ldy $0663,X ; monster ID, group 1

    cpy #$FF
    beq B04_823A
    lda #$00
    sta $D7 ; high bits of IDs in selected battle formation

    dey
    sty $D6 ; battle formation

    tya
    ldy #$04
; control flow target (from $821A)
B04_8216:
    asl
    rol $D7 ; high bits of IDs in selected battle formation

    dey
    bne B04_8216
    sec
    sbc $D6 ; battle formation

    bcs B04_8223
    dec $D7 ; high bits of IDs in selected battle formation

; control flow target (from $821F)
B04_8223:
    clc
    adc $824D
    sta $D6 ; battle formation

    lda $D7 ; high bits of IDs in selected battle formation

    adc $824E
    sta $D7 ; high bits of IDs in selected battle formation

    ldy #$05
    lda ($D6),Y ; battle formation

    cmp $D5
    bcc B04_823A
    sta $D5
; control flow target (from $820A, $8236)
B04_823A:
    txa
    clc
    adc #$0B
    cmp #$2C
    bne B04_8204
    lda $0638 ; Midenhall Attack Power

    lsr
    cmp $D5
    beq B04_824F
    bcc B04_824F
    rts


; code -> data
; data load target (from $8224)
; data load target (from $822B)
.byte $F5

.byte $B7
; data -> code
; control flow target (from $81F8, $81FE, $8248, $824A)
; call to code in a different bank ($0F:$C3AB)
B04_824F:
    jsr $C3AB ; generate a random number and store it in $32-$33 (two passes)

    ldx #$00
    stx $D5
; control flow target (from $8284)
B04_8256:
    lda #$FF
    cmp $0663,X ; monster ID, group 1

    beq B04_827D
    cmp $066C,X
    bne B04_8275
    ldy #$04
; control flow target (from $826A)
B04_8264:
    asl $32 ; RNG byte 0; pull 4 bits from RNG, updating RNG in the process

    rol $33 ; RNG byte 1

    rol
    dey
    bne B04_8264
    and #$0F
    tay ; use random 4-bit index

    lda $8336,Y
    sta $066C,X
; control flow target (from $8260)
B04_8275:
    lda $D5
    clc
    adc $066C,X
    sta $D5
; control flow target (from $825B)
B04_827D:
    txa
    clc
    adc #$0B
    tax
    cpx #$2C ; #$2C = #$0B * 4, at which point we will have exhausted the 16-bit RNG supply

    bne B04_8256
    lda $D8 ; battle formation index

    cmp #$12 ; formation size

    bcs B04_82DE
    ldx #$05
    cmp #$0D
    bcs B04_8293
    dex
; control flow target (from $8290)
B04_8293:
    stx $D6 ; battle formation

; control flow target (from $82B6)
    lda $D5
    cmp $D6 ; battle formation

    bcc B04_82DE
; control flow target (from $82AA, $82AF)
B04_829B:
    iny
    cpy #$04
    bcc B04_82A2
    ldy #$00
; control flow target (from $829E)
B04_82A2:
    ldx $837A,Y ; pre-computed multiples of #$0B

    lda $0663,X ; monster ID, group 1

    cmp #$FF
    beq B04_829B
    lda $066C,X
    beq B04_829B
    dec $066C,X
    dec $D5
    jmp $8295

; trigger fixed battle A
; control flow target (from $800F)
    pha
    lda #$00
    sta $98 ; outcome of last fight?

    jsr $837E ; initialize enemy group data at $0663-$068F to #$FF

    pla
    asl
    asl
    tax
    ldy #$00
; control flow target (from $82DC)
B04_82C7:
    lda $8346,X ; Fixed Encounters (group 1 Monster ID, group 1 count, group 2 Monster ID, group 2 count)

    inx
    sta $0663,Y ; monster ID, group 1

    lda $8346,X ; Fixed Encounters (group 1 Monster ID, group 1 count, group 2 Monster ID, group 2 count)

    inx
    sta $066C,Y
    tya
    clc
    adc #$0B
    tay
    cmp #$16
    bne B04_82C7
; control flow target (from $828A, $8299)
B04_82DE:
    jsr $86ED
    ldx #$00
; control flow target (from $8324)
B04_82E3:
    stx $D6 ; battle formation

    ldy $837A,X ; pre-computed multiples of #$0B

    lda #$00
    sta $D5
    lda $066C,Y
    beq B04_831A
    lda $0663,Y ; monster ID, group 1

    cmp #$FF
    beq B04_831A
; control flow target (from $8318)
B04_82F8:
    ldy $D5
    iny
    ldx $D6 ; battle formation

    jsr $8A9E
    ldx $D6 ; battle formation

    ldy $837A,X ; pre-computed multiples of #$0B

    bcs B04_831A
    tya
    clc
    adc $D5
    tax
    lda #$00
    sta $0664,X
    inc $D5
    lda $D5
    cmp $066C,Y
    bne B04_82F8
; control flow target (from $82EF, $82F6, $8305)
B04_831A:
    lda $D5
    sta $066C,Y
    ldx $D6 ; battle formation

    inx
    cpx #$04
    bne B04_82E3
    jsr $871E
    jmp $94B5


; code -> data
; per-terrain encounter rates
; indexed data load target (from $80A8)
; -> $04:$8509: Battle Formations
.byte $0A,$54,$08,$04
.byte $10,$19
.byte $10
.byte $10
; data load target (from $80CE)
; data load target (from $80D4)
.byte $09
; indexed data load target (from $826F)
.byte $85
; Fixed Encounters (group 1 Monster ID, group 1 count, group 2 Monster ID, group 2 count)
.byte $01,$02,$01,$02,$03,$01,$02,$01
.byte $02,$03,$01,$02
.byte $01,$02
.byte $03
.byte $05
; indexed data load target (from $82C7, $82CE)
; pre-computed multiples of #$0B
.byte $FF,$00,$1E,$02,$FF,$00,$36,$01,$FF,$00,$3A,$01,$FF,$00,$3C,$02
.byte $FF,$00,$4C,$02,$FF,$00,$1E,$04,$FF,$00,$36,$02,$36,$01,$37,$02
.byte $FF,$00,$4E,$01,$FF,$00,$4F,$01,$FF,$00
.byte $50,$01,$FF,$00,$51
.byte $01,$FF,$00
.byte $52
.byte $01
; indexed data load target (from $82A2, $82E5, $8302)

.byte $00,$0B
.byte $16
.byte $21
; data -> code
; initialize enemy group data at $0663-$068F to #$FF
; control flow target (from $80D9, $82BE)
    lda #$FF
    ldx #$2C
; control flow target (from $8386)
B04_8382:
    sta $0662,X ; Moonbrooke Level

    dex
    bne B04_8382
    rts

; take current RNG value $33, figure out which $8398 bucket it fits into, and store that index in Y
; control flow target (from $8192, $81CB)
    ldy #$00
    lda $33 ; RNG byte 1

; control flow target (from $8394)
    cmp $8398,X
    bcs B04_8397
    iny
    inx
    jmp $838D

; control flow target (from $8390)
B04_8397:
    rts


; code -> data
; indexed data load target (from $838D)

.byte $D6,$AC,$82,$68,$4E,$34
.byte $00,$82,$5B
.byte $34
.byte $00
; data -> code
; control flow target (from $814E, $818D)
    jsr $83B7 ; given a monster group index in X, write the monster ID in A to the appropriate monster group data at $0663

    lda #$01
    sta $066C,Y
    rts

; given a weird value <= #$03 in Y, get the monster ID from ($D5),Y and if it's not #$FF/#$7F, get the monster group index corresponding to Y from $83BE and write the monster ID to the appropriate monster group data at $0663
; control flow target (from $81A7, $81AC, $81E0, $81EA)
    lda ($D5),Y
    and #$7F
    cmp #$7F
    beq B04_83BD
; given a weird value <= #$03 in Y, get the corresponding monster group index from $83BE and write the monster ID in A to the appropriate monster group data at $0663
; control flow target (from $81C6)
    ldx $83BE,Y
; given a monster group index in X, write the monster ID in A to the appropriate monster group data at $0663
; control flow target (from $8167, $83A3)
    ldy $83C2,X ; pre-computed multiples of #$0B (what was wrong with the identical data at $04:$837A?)

    sta $0663,Y ; monster ID, group 1

; control flow target (from $83B2)
B04_83BD:
    rts


; code -> data
; indexed data load target (from $83B4)
; pre-computed multiples of #$0B (what was wrong with the identical data at $04:$837A?)
.byte $01,$00
.byte $03
.byte $02
; indexed data load target (from $83B7)
; World Map Encounters
.byte $00,$0B
.byte $16
.byte $21
; indexed data load target (from $807D)
; Dungeon Encounter Formations
.byte $61,$21,$21,$08,$08,$08,$07,$07,$05,$05,$04,$04,$45,$45,$46,$E1
.byte $18,$18,$19,$19,$1A,$08,$08,$06,$06,$04,$03,$04,$04,$44,$46,$58
.byte $18,$17,$19,$19,$1A,$1A,$08,$07,$07,$04,$03,$02,$02,$03,$45,$58
.byte $17,$17,$18,$19,$1B,$1B,$1B,$0D,$0D,$04,$03,$02,$01,$00,$05,$18
.byte $16,$16,$19,$1A,$1B,$1B,$1B,$0D,$0D,$0E,$03,$03,$03,$01,$05,$18
.byte $16,$16,$19,$1A,$1B,$10,$0F,$0D,$0E,$0E,$0E,$58,$04,$03,$04,$58
.byte $18,$16,$15,$15,$1B,$10,$0F,$0E,$0F,$0F,$0F,$58,$58,$23,$05,$58
.byte $18,$15,$95,$B9,$15,$10,$CF,$CF,$D0,$10,$51,$D8,$E3,$63,$23,$58
.byte $61,$24,$A4,$A4,$A5,$A5,$CF,$CF,$E5,$23,$63,$E3,$63,$23,$23,$23
.byte $21,$21,$24,$A4,$A5,$A5,$F3,$F3,$F3,$23,$63,$E3,$23,$23,$23,$63
.byte $21,$21,$21,$61,$64,$B3,$B3,$B2,$B2,$62,$63,$E5,$23,$23,$23,$63
.byte $61,$21,$21,$21,$21,$32,$32,$32,$32,$E2,$4F,$50,$63,$63,$63,$63
.byte $21,$20,$20,$21,$08,$08,$25,$25,$25,$62,$47,$41,$42,$41,$42,$56
.byte $61,$21,$21,$21,$7B,$7B,$62,$22,$22,$22,$22,$22,$22,$E2,$DB,$DB
.byte $4D,$0E,$21,$21,$5B,$65,$DB,$5B,$5B,$5B,$22,$62,$62,$E2,$C1,$E3
.byte $4D,$0E,$21,$21,$5B,$65,$DB,$5B
.byte $5B,$5B,$22,$62
.byte $62,$E2
.byte $C1
.byte $E3
; indexed data load target (from $8046)
; data load target (from $8098)
.byte $0C,$0A,$0B,$2A,$2B,$2C,$2C,$36,$37,$1C,$1C,$1C,$38,$2D,$2E,$2E
.byte $2E,$2F,$30,$31,$31,$09,$3F,$3F,$3F,$35,$34,$3F,$3F,$3F,$26,$27
.byte $27,$28,$28,$29,$29,$1D,$1E,$1E,$1F,$1F,$1F,$1F,$3F,$12,$12,$13
.byte $13,$14,$14,$14,$3F,$39,$39,$39,$3A
.byte $3A,$3A,$39,$39,$39
.byte $3A,$3A
.byte $3A
.byte $3F
; Battle Formations
.byte $40
; indirect data load target (via $8334)

.byte $81,$FF,$FF,$FF,$81,$82,$81,$82,$81,$82,$FF,$FF,$82,$81,$81,$83
.byte $82,$FF,$83,$84,$82,$84,$83,$87,$84,$85,$82,$83,$84,$87,$85,$84
.byte $88,$82,$85,$86,$88,$84,$85,$88,$88,$8A,$8C,$88,$8B,$82,$89,$86
.byte $0C,$0B,$07,$0A,$09,$7F,$85,$82,$83,$84,$85,$8C,$0B,$07,$0C,$06
.byte $0C,$8D,$8C,$8B,$8A,$8A,$89,$8F,$87,$8B,$8A,$FF,$8C,$8F,$0F,$8A
.byte $0C,$0E,$0B,$92,$95,$91,$8F,$8A,$89,$93,$0F,$8E,$11,$0D,$8B,$12
.byte $08,$13,$0D,$92,$0D,$17,$12,$0C,$FF,$93,$8F,$30,$12,$0A,$8B,$92
.byte $8C,$17,$93,$92,$92,$87,$94,$97,$14,$12,$0E,$8D,$14,$FF,$15,$14
.byte $16,$B0,$15,$A0,$96,$95,$94,$8E,$97,$92,$1B,$16,$12,$1A,$9C,$1D
.byte $1C,$1B,$1A,$9D,$92,$30,$1B,$1D,$1B,$1A,$9E,$01,$1E,$1C,$1D,$81
.byte $9F,$04,$1F,$13,$8E,$22,$A2,$28,$20,$21,$A2,$9E,$FF,$A6,$A1,$A0
.byte $A2,$9A,$9D,$FF,$A2,$A0,$A1,$A5,$A3,$FF,$A5,$A1,$8D,$9E,$A3,$B5
.byte $24,$23,$A6,$26,$27,$A8,$28,$26,$A4,$28,$26,$FF,$2B,$2C,$27,$8D
.byte $FF,$AF,$2E,$7F,$AC,$2F,$AB,$2D,$31,$29,$33,$AF,$AD,$C2,$33,$31
.byte $B4,$35,$2F,$35,$2A,$32,$B4,$7F,$37,$36,$35,$38,$A9,$35,$B7,$FF
.byte $38,$7F,$B7,$7F,$B6,$C2,$BE,$BE,$B5,$B6,$FF,$C2,$B2,$B4,$AC,$B6
.byte $FF,$FF,$B5,$B4,$AB,$B5,$A9,$C2,$BA,$B5,$AA,$B5,$BA,$BA,$B9,$BA
.byte $BB,$B6,$BD,$C2,$3C,$39,$BD,$3C,$B7,$7F,$BF,$BE,$C1,$AD,$FF,$C2
.byte $C8,$C1,$C3,$C3,$C1,$C5,$41,$40,$C6,$C5,$46,$C9,$C4,$C9,$C5,$CA
.byte $C4,$FF,$CB,$CA,$CC,$CD,$CC,$CD,$7F,$42,$CB,$C7,$47,$7F,$C6,$C8
.byte $C9,$C5,$C6,$CD,$B9,$BA,$A9,$B5,$B9,$C2,$BB,$B9,$A3,$B6,$BB,$BB
.byte $AD,$AD,$AD,$AD,$AD,$FF,$14,$15,$16,$17,$92,$B0,$19,$15,$16,$1A
.byte $99,$9D,$8C,$9F,$A4,$85,$B1,$A9,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $FF,$FF,$FF,$FF
.byte $FF,$FF
.byte $FF
.byte $FF
; Ocean Formations (high 2 bits of encounter group)
; Special Formations
.byte $90,$98,$99,$FF,$87,$FF,$98,$8E,$90,$AE,$FF,$BE
.byte $31,$AE,$2D,$2C,$7F,$7F
.byte $B8,$93,$91
.byte $BE,$FF
.byte $FF
; indexed data load target (from $8101)

.byte $FF,$FF,$09,$FF,$FF,$FF,$0D,$FF,$FF,$1C,$FF,$0E,$FF,$15,$FF,$06
.byte $FF,$FF,$FF,$09,$FF,$17,$FF,$13,$FF,$1D,$FF,$0D,$FF,$28,$FF,$06
.byte $FF,$FF,$31,$0E,$35,$FF,$FF,$13,$FF,$FF,$FF,$30,$36,$FF,$FF,$2D
.byte $47,$FF,$FF,$41,$FF,$42,$FF,$06,$FF,$FF,$FF,$11,$FF,$FF
.byte $23,$FF,$38,$31,$FF,$FF,$FF
.byte $FF,$FF,$0A,$12
.byte $FF,$06
.byte $FF
; data -> code
; control flow target (from $82DE)
; call to code in a different bank ($0F:$C515)
    jsr $C515 ; flash screen 10 times

    lda #$17 ; Music ID #$17: normal battle BGM

    ldx $066E
    cpx #$52
    bne B04_86FB
    lda #$18 ; Music ID #$18: Malroth battle BGM

; control flow target (from $86F7)
; call to code in a different bank ($0F:$C561)
B04_86FB:
    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

; call to code in a different bank ($0F:$C465)
    jsr $C465 ; wait for interrupt and then set every 4th byte of $0200 - $02FC to #$F0

    jsr $902C
    lda #$00
    sta $04
    sta $05
    sta $06
; call to code in a different bank ($0F:$C446)
    jsr $C446 ; turn screen off, write $800 [space] tiles to PPU $2000, turn screen on

; call to code in a different bank ($0F:$C42A)
    jsr $C42A
    jsr $8F26
; call to code in a different bank ($0F:$C3E8)
    jsr $C3E8 ; wait for interrupt, set $6007 to #$FF, turn screen off

    ldx #$00
    stx $0400 ; menu-based palette overrides start

    rts

; control flow target (from $8326)
    lda #$F0
    ldx #$00
; control flow target (from $8729)
B04_8722:
    sta $0200,X ; sprite buffer start

    inx
    inx
    inx
    inx
    bne B04_8722
    lda #$00
    sta $0405
; call to code in a different bank ($0F:$C41C)
    jsr $C41C ; wait for interrupt, turn screen sprites and backround on

    lda #$01
    sta $0400 ; menu-based palette overrides start

; call to code in a different bank ($0F:$C22C)
    jsr $C22C
    ldx #$40
    lda #$00
; control flow target (from $8743)
B04_873F:
    sta $0449,X
    dex
    bne B04_873F
    ldx #$00
    stx $DA
; control flow target (from $877D)
B04_8749:
    lda $042A,X
    bpl B04_8777
    sta $DB
    and #$7F
    sta $042A,X
    and #$03
    asl
    asl
    asl
    sta $DC
    lda $DB
    lsr
    lsr
    and #$07
    ora $DC
    tay
    lda $042C,X
    sec
    adc $DA
    cmp #$1E
    bcs B04_8777
    sta $DA
    txa
    ora #$80
    sta $044A,Y
; control flow target (from $874C, $876D)
B04_8777:
    inx
    inx
    inx
    inx
    cpx #$20
    bne B04_8749
    dec $DA
    lda #$20
    sec
    sbc $DA
    lsr
    sta $DA
    ldy #$00
; control flow target (from $87AB)
B04_878B:
    lda $DA
    lda $044A,Y
    bpl B04_87A8
    and #$1F
    tax
    lda $042A,X
    ora #$80
    sta $042A,X
    lda $DA
    sta $042B,X
    sec
    adc $042C,X
    sta $DA
; control flow target (from $8790)
B04_87A8:
    iny
    cpy #$20
    bne B04_878B
    rts

; control flow target (from $954A)
    ldx #$00
; control flow target (from $87C2)
B04_87B0:
    stx $DA
    lda $042A,X
    bpl B04_87BC
    jsr $8C80
    ldx $DA
; control flow target (from $87B5)
B04_87BC:
    inx
    inx
    inx
    inx
    cpx #$20
    bne B04_87B0
    clc
    rts

; control flow target (from $8B48)
    lda $0400 ; menu-based palette overrides start

    beq B04_87CD
    sec
    rts

; control flow target (from $87C9)
B04_87CD:
    ldx $DB
    lda $0406,X
    beq B04_87D6
    sec
    rts

; control flow target (from $87D2)
B04_87D6:
    lda $0403
    sta $E6
    lda $0404
    sta $E7
    lda $0401
    sta $E8
    lda $0402
    sta $E9
    lda #$00
    sta $E0
    lda $DB
    and #$03
    asl
    clc
    adc $DB
    tay
    lda $0663,Y ; monster ID, group 1

    cmp #$53
    bcc B04_8800
    sec
    rts

; control flow target (from $87FC)
B04_8800:
    asl
    rol $E0
    asl
    rol $E0
    clc
    adc $0663,Y ; monster ID, group 1

    bcc B04_880E
    inc $E0
; control flow target (from $880A)
B04_880E:
    clc
    adc $88BE ; -> $04:$90FC: count? + pointer to enemy graphics? + pointer to enemy palette

    sta $DF
    lda $88BF
    adc $E0
    sta $E0
    ldx $DB
    jsr $8FA2 ; read ($DF), INC 16-bit $DF-$E0

    sta $040E,X
    jsr $8FA2 ; read ($DF), INC 16-bit $DF-$E0

    sta $040C,X
    jsr $8FA2 ; read ($DF), INC 16-bit $DF-$E0

    sta $040D,X
    jsr $8FA2 ; read ($DF), INC 16-bit $DF-$E0

    pha
    jsr $8FA2 ; read ($DF), INC 16-bit $DF-$E0

    sta $E0
    pla
    sta $DF
    jsr $8FA2 ; read ($DF), INC 16-bit $DF-$E0

    sta $DC
    and #$0F
    beq B04_886B
    sta $DE
    lda #$00
    sta $DD
    jsr $88C0
    bcc B04_8851
    sec
    rts

; control flow target (from $884D)
B04_8851:
    ldx $DB
    lda $E4
    sta $040A,X
    lda $DC
    and #$0F
    sta $DD
    asl
    clc
    adc $DD
    clc
    adc $DF
    sta $DF
    bcc B04_886B
    inc $E0
; control flow target (from $8842, $8867)
B04_886B:
    lda $DC
    lsr
    lsr
    lsr
    lsr
    and #$0F
    beq B04_8889
    sta $DE
    lda #$0D
    sta $DD
    jsr $88C0
    bcc B04_8882
    sec
    rts

; control flow target (from $887E)
B04_8882:
    ldx $DB
    lda $E4
    sta $040B,X
; control flow target (from $8873)
B04_8889:
    jsr $8971
    bcc B04_8890
    sec
    rts

; control flow target (from $888C)
B04_8890:
    ldx $DB
    lda $E6
    sta $0403
    lda $E7
    sta $0404
    lda $E5
    sta $0406,X
    lda $0401
    sta $0408,X
    lda $0402
    sta $0407,X
    lda $E4
    sta $0409,X
    lda $E8
    sta $0401
    lda $E9
    sta $0402
    clc
    rts


; code -> data
; -> $04:$90FC: count? + pointer to enemy graphics? + pointer to enemy palette
; data load target (from $880F)
; data load target (from $8814)
.byte $FC

.byte $90
; data -> code
; control flow target (from $884A, $887B)
    lda #$00
    sta $E1
    sta $E4
    lda $DD
    and #$01
    tax
    lda $E6,X
    sta $E2
    beq B04_892A
; control flow target (from $8963)
    ldx $DD
    beq B04_88F4
    ldy #$03
; control flow target (from $88DF)
B04_88D7:
    lda $050D,Y
    cmp #$30
    bne B04_88F4
    dey
    bne B04_88D7
    lda $E1
    asl
    clc
    adc $E1
    tay
    lda ($DF),Y
    cmp #$30
    bne B04_88F4
    lda #$00
    pha
    jmp $893C

; control flow target (from $88D3, $88DC, $88EC)
B04_88F4:
    lda #$00
    sta $E3
    ldx $DD
; control flow target (from $8922)
B04_88FA:
    lda $E1
    asl
    clc
    adc $E1
    tay
    lda #$03
    sta $E5
; control flow target (from $8910)
B04_8905:
    lda $0501,X
    cmp ($DF),Y
    bne B04_8917
    inx
    iny
    dec $E5
    bne B04_8905
    lda $E3
    jmp $894C

; control flow target (from $890A, $891A)
B04_8917:
    inx
    dec $E5
    bne B04_8917
    inc $E3
    lda $E2
    cmp $E3
    bne B04_88FA
    cmp #$04
    bne B04_892A
    sec
    rts

; control flow target (from $88CF, $8926)
B04_892A:
    pha
    asl
    clc
    adc $E2
    clc
    adc $DD
    tax
    inc $E2
    lda $E1
    asl
    clc
    adc $E1
    tay
; control flow target (from $88F1)
    lda #$03
    sta $E5
; control flow target (from $8949)
B04_8940:
    lda ($DF),Y
    sta $0501,X
    inx
    iny
    dec $E5
    bne B04_8940
    pla
; control flow target (from $8914)
    ldx $E1
    inx
    stx $E1
; control flow target (from $8956)
    dex
    beq B04_8959
    asl
    asl
    jmp $8951

; control flow target (from $8952)
B04_8959:
    ora $E4
    sta $E4
    lda $E1
    cmp $DE
    beq B04_8966
    jmp $88D1

; control flow target (from $8961)
B04_8966:
    lda $DD
    and #$01
    tax
    lda $E2
    sta $E6,X
    clc
    rts

; control flow target (from $8889)
    ldx $DB
    lda $040C,X
    sta $DF
    lda $040D,X
    sta $E0
    lda $040E,X
    sta $E1
    lda #$00
    sta $E4
    sta $E5
; control flow target (from $8A95)
    lda $DF
    pha
    lda $E0
    pha
    lda #$00
    sta $DC
    lda #$FF
    sta $DD
    sta $DE
; control flow target (from $89A7)
B04_8998:
    jsr $8F9D ; return 1 byte from bank 1's ($DF) in A, INC 16-bit $DF-$E0

    tax
    and #$40
    bne B04_89A3
    jsr $8FA6 ; INC 16-bit $DF-$E0

; control flow target (from $899E)
B04_89A3:
    jsr $8FA6 ; INC 16-bit $DF-$E0

    txa
    bpl B04_8998
    lsr
    and #$04
    beq B04_89BF
    bcc B04_89B5
    jsr $8F9D ; return 1 byte from bank 1's ($DF) in A, INC 16-bit $DF-$E0

    sta $DC
; control flow target (from $89AE)
B04_89B5:
    jsr $8F9D ; return 1 byte from bank 1's ($DF) in A, INC 16-bit $DF-$E0

    sta $DD
    jsr $8F9D ; return 1 byte from bank 1's ($DF) in A, INC 16-bit $DF-$E0

    sta $DE
; control flow target (from $89AC)
B04_89BF:
    ldx #$00
; control flow target (from $89DB)
B04_89C1:
    lda $DC
    asl $DD
    rol $DE
    bcc B04_89CC
    jsr $8F9D ; return 1 byte from bank 1's ($DF) in A, INC 16-bit $DF-$E0

; control flow target (from $89C7)
B04_89CC:
    sta $044A,X
    ldy #$08
; control flow target (from $89D6)
B04_89D1:
    asl
    ror $045A,X
    dey
    bne B04_89D1
    inx
    cpx #$10
    bne B04_89C1
    ldx #$00
; control flow target (from $89F2)
B04_89DF:
    txa
    ora #$07
    tay
; control flow target (from $89EE)
B04_89E3:
    lda $044A,X
    sta $046A,Y
    inx
    dey
    txa
    and #$07
    bne B04_89E3
    cpx #$20
    bne B04_89DF
    pla
    sta $E0
    pla
    sta $DF
    lda #$00
    sta $E2
; control flow target (from $8A8B)
    jsr $8F9D ; return 1 byte from bank 1's ($DF) in A, INC 16-bit $DF-$E0

    sta $E3
    lsr
    and #$03
    tax
    inx
    lda $E3
    and #$40
    bne B04_8A1B
    inc $E4
    jsr $8FA6 ; INC 16-bit $DF-$E0

    jsr $8FA6 ; INC 16-bit $DF-$E0

    ldx #$00
    jmp $8A26

; control flow target (from $8A0C)
B04_8A1B:
    jsr $8F9D ; return 1 byte from bank 1's ($DF) in A, INC 16-bit $DF-$E0

    and #$0F
    cmp $E5
    bcc B04_8A26
    sta $E5
; control flow target (from $8A18, $8A22)
B04_8A26:
    txa
    tay
    iny
    lda #$20
; control flow target (from $8A2D)
B04_8A2B:
    lsr
    dey
    bne B04_8A2B
    tay
    and $E2
    bne B04_8A87
    tya
    ora $E2
    sta $E2
    ldy #$00
    txa
    bne B04_8A41
    ldy #$10
    inx
; control flow target (from $8A3C)
B04_8A41:
    sty $11
    dex
    txa
    asl
    asl
    asl
    asl
    clc
    adc $8A9C
    sta $0C
    lda #$00
    adc $8A9D
    sta $0D
    lda #$0F
    clc
    adc $0C
    sta $0E
    lda #$00
    adc $0D
    sta $0F
    lda #$00
    sta $10
    lda $11
    lsr
    lsr
    lsr
    lsr
    eor #$01
    tax
    lda $E8,X
    inc $E8,X
    bne B04_8A78
    sec
    rts

; control flow target (from $8A74)
B04_8A78:
    ldy #$04
; control flow target (from $8A7E)
B04_8A7A:
    lsr
    ror $10
    dey
    bne B04_8A7A
    ora $11
    sta $11
; call to code in a different bank ($0F:$C3F6)
    jsr $C3F6 ; copy ($0C) inclusive - ($0E) exclusive to PPU at ($10)

; control flow target (from $8A32)
B04_8A87:
    lda $E3
    bmi B04_8A8E
    jmp $89FE

; control flow target (from $8A89)
B04_8A8E:
    jsr $8FAD
    dec $E1
    beq B04_8A98
    jmp $8988

; control flow target (from $8A93)
B04_8A98:
    inc $E5
    clc
    rts


; code -> data
; data load target (from $8A4A)
; data load target (from $8A51)
.byte $4A

.byte $04
; data -> code
; control flow target (from $82FD, $9CA3)
    jsr $8B09
    bcs B04_8AAF
    lda $042A,X
    ora #$80
    sta $042A,X
    jsr $8C80
    clc
; control flow target (from $8AA1)
B04_8AAF:
    rts

; control flow target (from $9C87)
    jsr $8F58
    bcc B04_8AB7
    sec
    rts

; control flow target (from $8AB3)
B04_8AB7:
    stx $DA
    lda $042A,X
    and #$03
    sta $DB
    asl
    sta $DC
    asl
    asl
    clc
    adc $DB
    clc
    adc $DC
    tay
    lda $0663,Y ; monster ID, group 1

    cmp #$4E
    bcs B04_8AE8
    lda #$87 ; Music ID #$87: hit 2 SFX

; call to code in a different bank ($0F:$C561)
    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    ldx #$04 ; Number of flashes when Enemies take a hit

; control flow target (from $8AE5)
B04_8ADA:
    txa
    pha
    jsr $8E09
    jsr $8C80
    pla
    tax
    dex
    bne B04_8ADA
    rts

; control flow target (from $8AD1)
B04_8AE8:
    lda #$81 ; Music ID #$81: hit 1 SFX

; call to code in a different bank ($0F:$C561)
    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    jsr $90BB
    rts

; control flow target (from $9C8F, $A22A)
    jsr $8F58
    bcc B04_8AF8
    sec
    rts

; control flow target (from $8AF4)
B04_8AF8:
    stx $DA
    jsr $8E09
    ldx $DA
    lda $042A,X
    and #$7F
    sta $042A,X
    clc
    rts

; control flow target (from $8A9E, $B29E)
    jsr $8B23
    bcs B04_8B22
    ldx $DA
    ldy $DB
    lda $0406,Y
    sta $042C,X
    jsr $8BDD
    bcs B04_8B22
    ldx $DA
    sta $042B,X
; control flow target (from $8B0C, $8B1B)
B04_8B22:
    rts

; control flow target (from $8B09)
    jsr $8F58
    bcs B04_8B2A
    sec
    rts

; control flow target (from $8B26)
B04_8B2A:
    tya
    bne B04_8B2F
    sec
    rts

; control flow target (from $8B2B)
B04_8B2F:
    lda $DA
    sta $042A,X
    stx $DA
    and #$03
    sta $DB
    asl
    asl
    asl
    clc
    adc $DB
    sta $DB
    tay
    lda $0406,Y
    bne B04_8B52
    jsr $87C6
    ldy $DB
    ldx $DA
    bcc B04_8B52
    rts

; control flow target (from $8B46, $8B4F)
B04_8B52:
    sta $042C,X
    lda $0409,Y
    clc
    bne B04_8B5C
    rts

; control flow target (from $8B59)
B04_8B5C:
    adc $0405
    cmp #$41
    bcc B04_8B65
    sec
    rts

; control flow target (from $8B61)
B04_8B65:
    lda $040E,Y
    sta $DE
    lda $040C,Y
    sta $DF
    lda $040D,Y
    sta $E0
    ldx #$00
; control flow target (from $8B8C, $8B93)
B04_8B76:
    jsr $8F9D ; return 1 byte from bank 1's ($DF) in A, INC 16-bit $DF-$E0

    pha
    jsr $8FA6 ; INC 16-bit $DF-$E0

    and #$40
    bne B04_8B8B
    jsr $8F9D ; return 1 byte from bank 1's ($DF) in A, INC 16-bit $DF-$E0

    clc
    adc #$17
    sta $044A,X
    inx
; control flow target (from $8B7F)
B04_8B8B:
    pla
    bpl B04_8B76
    jsr $8FAD
    dec $DE
    bne B04_8B76
    stx $DD
    lda #$10
    sta $DE
; control flow target (from $8BD9)
B04_8B9B:
    ldx #$00
    lda $0405
    beq B04_8BBB
    sta $DF
    ldx #$00
    ldy #$00
; control flow target (from $8BB9)
B04_8BA8:
    lda $0200,Y ; sprite buffer start

    sec
    sbc $DE
    cmp #$08
    bcs B04_8BB3
    inx
; control flow target (from $8BB0)
B04_8BB3:
    iny
    iny
    iny
    iny
    dec $DF
    bne B04_8BA8
; control flow target (from $8BA0)
B04_8BBB:
    ldy #$00
; control flow target (from $8BCB)
B04_8BBD:
    lda $044A,Y
    sec
    sbc $DE
    cmp #$08
    bcs B04_8BC8
    inx
; control flow target (from $8BC5)
B04_8BC8:
    iny
    cpy $DD
    bne B04_8BBD
    cpx #$09
    bcc B04_8BD3
    sec
    rts

; control flow target (from $8BCF)
B04_8BD3:
    inc $DE
    lda $DE
    cmp #$90
    bne B04_8B9B
    clc
    rts

; control flow target (from $8B18)
    ldx $DB
    lda $0406,X
    bne B04_8BE6
    sec
    rts

; control flow target (from $8BE2)
B04_8BE6:
    sta $DC
    lda $0400 ; menu-based palette overrides start

    beq B04_8C4E
    lda #$1D
    sec
    sbc $DC
    sta $DD
    ldx $DC
    dex
    txa
    lsr
    eor #$FF
    sec
    adc #$0F
    sta $DE
    lda #$00
    sta $DF
; control flow target (from $8C3E)
    lda #$00
; control flow target (from $8C48)
B04_8C06:
    sta $E0
    tax
    lda $042A,X
    bpl B04_8C41
    lda $042B,X
    clc
    adc $042C,X
    cmp $DE
    bcc B04_8C41
    lda $042B,X
    clc
    sbc $DC
    cmp #$20
    bcs B04_8C27
    cmp $DE
    bcs B04_8C41
; control flow target (from $8C21)
B04_8C27:
    inc $DF
    lda $DF
    cmp $DD
    bne B04_8C31
    sec
    rts

; control flow target (from $8C2D)
B04_8C31:
    eor #$01
    lsr
    lda $DF
    bcc B04_8C3A
    eor #$FF
; control flow target (from $8C36)
B04_8C3A:
    adc $DE
    sta $DE
    jmp $8C04

; control flow target (from $8C0C, $8C17, $8C25)
B04_8C41:
    lda $E0
    clc
    adc #$04
    cmp #$20
    bne B04_8C06
    lda $DE
    clc
    rts

; control flow target (from $8BEB)
B04_8C4E:
    lda #$02
    sta $DE
    ldx #$00
; control flow target (from $8C6C)
B04_8C54:
    lda $042A,X
    bpl B04_8C66
    lda $042B,X
    sec
    adc $042C,X
    cmp $DE
    bcc B04_8C66
    sta $DE
; control flow target (from $8C57, $8C62)
B04_8C66:
    inx
    inx
    inx
    inx
    cpx #$20
    bne B04_8C54
    lda $DE
    ldx $DA
    clc
    adc $042C,X
    cmp #$1F
    bcc B04_8C7C
    sec
    rts

; control flow target (from $8C78)
B04_8C7C:
    lda $DE
    clc
    rts

; control flow target (from $87B7, $8AAB, $8ADF)
    ldy $DA
    lda $042A,Y
    and #$03
    sta $DB
    asl
    asl
    asl
    clc
    adc $DB
    sta $DB
    tax
    lda $0405
    sta $DC
    lda $040C,X
    sta $DF
    lda $040D,X
    sta $E0
    lda $040E,X
    sta $E1
    lda $0400 ; menu-based palette overrides start; xx HP reduced

    bne B04_8CD6
; control flow target (from $8CC7, $8CCE)
B04_8CAB:
    jsr $8F9D ; return 1 byte from bank 1's ($DF) in A, INC 16-bit $DF-$E0

    pha
    jsr $8FA6 ; INC 16-bit $DF-$E0

    and #$40
    bne B04_8CC6
    lda $DC
    asl
    asl
    tax
    jsr $8F9D ; return 1 byte from bank 1's ($DF) in A, INC 16-bit $DF-$E0

    clc
    adc #$17
    sta $0200,X ; sprite buffer start

    inc $DC
; control flow target (from $8CB4)
B04_8CC6:
    pla
    bpl B04_8CAB
    jsr $8FAD
    dec $E1
    bne B04_8CAB
    lda $DC
    sta $0405
    rts

; control flow target (from $8CA9)
B04_8CD6:
    lda $042B,Y
    sta $E2
    lda $0407,X
    sta $DE
    dec $DE
    lda $0408,X
    sta $DD
    dec $DD
; call to code in a different bank ($0F:$C1DC)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

; control flow target (from $8DF2)
    lda #$00
    sta $E3
; control flow target (from $8DE8)
    jsr $8F9D ; return 1 byte from bank 1's ($DF) in A, INC 16-bit $DF-$E0

    sta $E4
    and #$40
    bne B04_8D56
    lda $DC
    asl
    asl
    tax
    lda $E3
    and #$10
    bne B04_8D0C
    inc $DD
    lda $E3
    ora #$10
    sta $E3
; control flow target (from $8D02)
B04_8D0C:
    lda $DD
    sta $0201,X
    lda $E4
    ror
    ror
    ror
    ror
    pha
    and #$03
    sta $E5
    ldy $DB
    lda $040A,Y
    ldy $E5
    iny
; control flow target (from $8D29)
    dey
    beq B04_8D2C
    lsr
    lsr
    jmp $8D24

; control flow target (from $8D25)
B04_8D2C:
    and #$03
    sta $E5
    pla
    and #$C0
    ora $E5
    sta $0202,X
    lda $E2
    asl
    asl
    asl
    sta $E5
    jsr $8F9D ; return 1 byte from bank 1's ($DF) in A, INC 16-bit $DF-$E0

    clc
    adc $E5
    sta $0203,X
    jsr $8F9D ; return 1 byte from bank 1's ($DF) in A, INC 16-bit $DF-$E0

    clc
    adc #$17
    sta $0200,X ; sprite buffer start

    inc $DC
    jmp $8DE4

; control flow target (from $8CF7)
B04_8D56:
    lda $E4
    lsr
    lsr
    lsr
    lsr
    and #$03
    tay
    ldx $DB
    lda $040B,X
    iny
; control flow target (from $8D6A)
    dey
    beq B04_8D6D
    lsr
    lsr
    jmp $8D65

; control flow target (from $8D66)
B04_8D6D:
    and #$03
    sta $09
    jsr $8F9D ; return 1 byte from bank 1's ($DF) in A, INC 16-bit $DF-$E0

    pha
    and #$0F
    clc
    adc $E2
    sta $0C
    pla
    lsr
    lsr
    lsr
    lsr
    and #$07
    clc
    adc #$0A
    sta $0E
; call to code in a different bank ($0F:$DE6E)
    jsr $DE6E
    lda $08 ; current PPU write address, high byte

    clc
    adc #$20
    sta $08 ; current PPU write address, high byte

; call to code in a different bank ($0F:$C1FA)
    jsr $C1FA ; wait for $02 to not be #$C0, write PPU address in $07-$08 and data in $09 to PPU write buffer at $0300,$02, $01 += 1, $02 += 3, and set $0183 to #$00

    lda $02
    cmp #$A5
    bcc B04_8D9E
; call to code in a different bank ($0F:$C1DC)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

; control flow target (from $8D99)
B04_8D9E:
    lda $E4
    lsr
    and #$03
    tax
    tay
    iny
    lda #$10
; control flow target (from $8DAA)
B04_8DA8:
    lsr
    dey
    bne B04_8DA8
    sta $E5
    and $E3
    bne B04_8DBE
    lda $E3
    ora $E5
    sta $E3
    inc $DE
    lda $DE
    sta $E6,X
; control flow target (from $8DB0)
B04_8DBE:
    lda $E6,X
    sta $09
    lda #$00
    lsr $0E
    ror
    lsr $0E
    ror
    lsr $0E
    ror
    ora $0C
    sta $07 ; current PPU write address, low byte

    lda $0E
    clc
    adc #$20
    sta $08 ; current PPU write address, high byte

; call to code in a different bank ($0F:$C1FA)
    jsr $C1FA ; wait for $02 to not be #$C0, write PPU address in $07-$08 and data in $09 to PPU write buffer at $0300,$02, $01 += 1, $02 += 3, and set $0183 to #$00

    lda $02
    cmp #$A5
    bcc B04_8DE4
; call to code in a different bank ($0F:$C1DC)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

; control flow target (from $8D53, $8DDF)
B04_8DE4:
    lda $E4
    bmi B04_8DEB
    jmp $8CF0

; control flow target (from $8DE6)
B04_8DEB:
    jsr $8FAD
    dec $E1
    beq B04_8DF5
    jmp $8CEC

; control flow target (from $8DF0)
B04_8DF5:
    ldx $DA
    lda $0405
    sta $042D,X
    lda $DC
    sta $0405
; call to code in a different bank ($0F:$C1DC)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

; call to code in a different bank ($0F:$C1DC)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    rts

; control flow target (from $8ADC, $8AFA)
    lda $0400 ; menu-based palette overrides start

    bne B04_8E10
    sec
    rts

; control flow target (from $8E0C)
B04_8E10:
    ldy $DA
    lda $042A,Y
    bmi B04_8E19
    sec
    rts

; control flow target (from $8E15)
B04_8E19:
    and #$03
    sta $DB
    asl
    asl
    asl
    clc
    adc $DB
    sta $DB
    tax
    lda $042B,Y
    sta $E2
    lda $042D,Y
    sta $E3
    lda $040C,X
    sta $DF
    lda $040D,X
    sta $E0
    lda $040E,X
    sta $E1
; call to code in a different bank ($0F:$C1DC)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

; control flow target (from $8EA1, $8EAB)
    jsr $8F9D ; return 1 byte from bank 1's ($DF) in A, INC 16-bit $DF-$E0

    sta $E4
    and #$40
    bne B04_8E60
    lda $E3
    asl
    asl
    tax
    lda #$F8
    sta $0200,X ; sprite buffer start

    inc $E3
    jsr $8FA6 ; INC 16-bit $DF-$E0

    jsr $8FA6 ; INC 16-bit $DF-$E0

    jmp $8E9D

; control flow target (from $8E49)
B04_8E60:
    jsr $8F9D ; return 1 byte from bank 1's ($DF) in A, INC 16-bit $DF-$E0

    pha
    and #$0F
    clc
    adc $E2
    sta $0C
    pla
    lsr
    lsr
    lsr
    lsr
    and #$07
    clc
    adc #$0A
    sta $0E
    lda #$5F
    sta $09
    lda #$00
    lsr $0E
    ror
    lsr $0E
    ror
    lsr $0E
    ror
    ora $0C
    sta $07 ; current PPU write address, low byte

    lda $0E
    clc
    adc #$20
    sta $08 ; current PPU write address, high byte

; call to code in a different bank ($0F:$C1FA)
    jsr $C1FA ; wait for $02 to not be #$C0, write PPU address in $07-$08 and data in $09 to PPU write buffer at $0300,$02, $01 += 1, $02 += 3, and set $0183 to #$00

    lda $02
    cmp #$A5
    bcc B04_8E9D
; call to code in a different bank ($0F:$C1DC)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

; control flow target (from $8E5D, $8E98)
B04_8E9D:
    lda $E4
    bmi B04_8EA4
    jmp $8E42

; control flow target (from $8E9F)
B04_8EA4:
    jsr $8FAD
    dec $E1
    beq B04_8EAE
    jmp $8E42

; control flow target (from $8EA9)
; call to code in a different bank ($0F:$C1DC)
B04_8EAE:
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

; call to code in a different bank ($0F:$C1DC)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    ldy $DA
    ldx $DB
    lda $0409,X
    bne B04_8EBF
    clc
    rts

; control flow target (from $8EBB)
B04_8EBF:
    sta $DD
    lda $042D,Y
    sta $DC
    lda $0405
    sec
    sbc $DD
    sta $0405
    sec
    sbc $DC
    beq B04_8EF1
    asl
    asl
    sta $DE
    lda $DC
    clc
    adc $DD
    asl
    asl
    tay
    lda $DC
    asl
    asl
    tax
; control flow target (from $8EEF)
B04_8EE5:
    lda $0200,Y ; sprite buffer start

    sta $0200,X ; sprite buffer start

    inx
    iny
    dec $DE
    bne B04_8EE5
; control flow target (from $8ED2)
B04_8EF1:
    lda $DD
    sta $DE
    lda $0405
    asl
    asl
    tax
    lda #$F8
; control flow target (from $8F06)
B04_8EFD:
    sta $0200,X ; sprite buffer start

    inx
    inx
    inx
    inx
    dec $DE
    bne B04_8EFD
    ldx #$00
; control flow target (from $8F22)
B04_8F0A:
    lda $042A,X
    bpl B04_8F1C
    lda $042D,X
    cmp $DC
    bcc B04_8F1C
    sec
    sbc $DD
    sta $042D,X
; control flow target (from $8F0D, $8F14)
B04_8F1C:
    inx
    inx
    inx
    inx
    cpx #$20
    bne B04_8F0A
    clc
    rts

; control flow target (from $8712)
    lda #$00
    sta $0405
    ldx #$44
; control flow target (from $8F31)
B04_8F2D:
    sta $0405,X
    dex
    bne B04_8F2D
    sta $0403
    lda #$01
    sta $0404
    lda #$00
    sta $0401
    lda #$8D
    sta $0402
    lda #$0F
    sta $0500
    sta $050D
    lda #$30
    ldx #$03
; control flow target (from $8F55)
B04_8F51:
    sta $050D,X
    dex
    bne B04_8F51
    rts

; control flow target (from $8AB0, $8AF1, $8B23)
    dey
    cpy #$08
    bcs B04_8F61
    cpx #$04
    bcc B04_8F65
; control flow target (from $8F5B)
B04_8F61:
    ldy #$00
    sec
    rts

; control flow target (from $8F5F)
B04_8F65:
    tya
    asl
    asl
    and #$1C
    sta $DA
    txa
    and #$03
    ora $DA
    sta $DA
    ldx #$00
    ldy #$08
; control flow target (from $8F87)
B04_8F77:
    lda $042A,X
    bpl B04_8F82
    and #$1F
    cmp $DA
    beq B04_8F9B
; control flow target (from $8F7A)
B04_8F82:
    inx
    inx
    inx
    inx
    dey
    bne B04_8F77
    ldx #$00
    ldy #$08
; control flow target (from $8F97)
B04_8F8D:
    lda $042A,X
    bpl B04_8F99
    inx
    inx
    inx
    inx
    dey
    bne B04_8F8D
; control flow target (from $8F90)
B04_8F99:
    sec
    rts

; control flow target (from $8F80)
B04_8F9B:
    clc
    rts

; return 1 byte from bank 1's ($DF) in A, INC 16-bit $DF-$E0
; control flow target (from $8998, $89B0, $89B5, $89BA, $89C9, $89FE, $8A1B, $8B76, $8B81, $8CAB, $8CBB, $8CF0, $8D3F, $8D48, $8D71, $8E42, $8E60, $8FC3, $8FC7)
    ldy #$DF
; call to code in a different bank ($0F:$C4E6)
    jmp $C4E6 ; return 1 byte from bank 1's ($00,Y) in A, INC 16-bit $00,Y-$01,Y


; read ($DF), INC 16-bit $DF-$E0
; control flow target (from $881D, $8823, $8829, $882F, $8833, $883B)
    ldy #$00
    lda ($DF),Y
; INC 16-bit $DF-$E0
; control flow target (from $89A0, $89A3, $8A10, $8A13, $8B7A, $8CAF, $8E57, $8E5A, $8FC0, $8FD0, $8FDB)
    inc $DF
    bne B04_8FAC
    inc $E0
; control flow target (from $8FA8)
B04_8FAC:
    rts

; control flow target (from $8A8E, $8B8E, $8CC9, $8DEB, $8EA4)
    lsr
    and #$04
    bne B04_8FBE
    lda #$10
    clc
    adc $DF
    sta $DF
    bcc B04_8FBD
    inc $E0
; control flow target (from $8FB9)
B04_8FBD:
    rts

; control flow target (from $8FB0)
B04_8FBE:
    bcc B04_8FC3
    jsr $8FA6 ; INC 16-bit $DF-$E0

; control flow target (from $8FBE)
B04_8FC3:
    jsr $8F9D ; return 1 byte from bank 1's ($DF) in A, INC 16-bit $DF-$E0

    pha
    jsr $8F9D ; return 1 byte from bank 1's ($DF) in A, INC 16-bit $DF-$E0

    tay
    pla
; control flow target (from $8FD4)
B04_8FCC:
    asl
    bcc B04_8FD4
    pha
    jsr $8FA6 ; INC 16-bit $DF-$E0

    pla
; control flow target (from $8FCD)
B04_8FD4:
    bne B04_8FCC
    tya
; control flow target (from $8FDF)
B04_8FD7:
    asl
    bcc B04_8FDF
    pha
    jsr $8FA6 ; INC 16-bit $DF-$E0

    pla
; control flow target (from $8FD8)
B04_8FDF:
    bne B04_8FD7
    rts

; control flow target (from $9CA9)
    lda #$8A ; Music ID #$8A: hit 3 SFX

; call to code in a different bank ($0F:$C561)
    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

; control flow target (from $8015)
; call to code in a different bank ($0F:$C1DC)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    lda #$02
    sta $DB
    ldx #$00
; control flow target (from $9029)
B04_8FF0:
    stx $DA
    txa
    ldx #$01
    and #$02
    beq B04_8FFD
    lda #$03
    ldx #$00
; control flow target (from $8FF7)
B04_8FFD:
    tay
    lda $05,X
    clc
    adc $DB
    sta $05,X
    ldx #$40
; control flow target (from $9015)
B04_9007:
    lda $0200,Y ; sprite buffer start

    sec
    sbc $DB
    sta $0200,Y ; sprite buffer start

    iny
    iny
    iny
    iny
    dex
    bne B04_9007
    ldx #$02
; call to code in a different bank ($0F:$C1EE)
    jsr $C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

    lda $DB
    eor #$FF
    sta $DB
    inc $DB
    ldx $DA
    inx
    cpx #$0C ; Amount of shaking when Characters take a hit

    bne B04_8FF0
    rts

; control flow target (from $8701)
; call to code in a different bank ($0F:$C1DC)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    lda #$3C
    sta $DB
    lda #$10
    sta $DC
    lda #$0F
    sta $DD
; control flow target (from $90B5)
B04_903B:
    dec $DB
    ldx #$FF
    lda $DB
    lsr
    ror
    bcs B04_904E
    ldx #$01
    eor #$1F
    bmi B04_904E
    sec
    sbc #$01
; control flow target (from $9043, $9049)
B04_904E:
    and #$1F
    sta $DE
    stx $DF
; control flow target (from $90B1)
B04_9054:
    lda $06
    lsr
    lsr
    lsr
    clc
    adc $DD
; control flow target (from $9060)
B04_905C:
    tay
    sec
    sbc #$1E
    bcs B04_905C
    lda $04
    beq B04_906A
    tya
    ora #$20
    tay
; control flow target (from $9064)
B04_906A:
    lda $05
    lsr
    lsr
    lsr
    sec
    adc $DC
    cmp #$20
    bcc B04_907C
    tax
    tya
    eor #$20
    tay
    txa
; control flow target (from $9074)
B04_907C:
    and #$1F
    sta $07 ; current PPU write address, low byte

    sty $08 ; current PPU write address, high byte

    lda #$00
    ldx #$03
    sec
; control flow target (from $908B)
B04_9087:
    ror $08 ; current PPU write address, high byte

    ror
    dex
    bne B04_9087
    ora $07 ; current PPU write address, low byte

    sta $07 ; current PPU write address, low byte

    lda #$5F
    sta $09
    lda $02
    cmp #$A5
    bcc B04_909E
; call to code in a different bank ($0F:$C1DC)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

; control flow target (from $9099)
; call to code in a different bank ($0F:$C1FA)
B04_909E:
    jsr $C1FA ; wait for $02 to not be #$C0, write PPU address in $07-$08 and data in $09 to PPU write buffer at $0300,$02, $01 += 1, $02 += 3, and set $0183 to #$00

    lda $DB
    eor #$01
    and #$01
    tax
    lda $DC,X
    clc
    adc $DF
    sta $DC,X
    cmp $DE
    bne B04_9054
    lda $DB
    bne B04_903B
; call to code in a different bank ($0F:$C1DC)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    rts

; control flow target (from $8AED)
    ldx #$08
; control flow target (from $90DD)
B04_90BD:
    txa
    pha
    jsr $90E0
    ldx #$00
    lda #$30
; control flow target (from $90CF)
B04_90C6:
    sta $050E,X
    sta $0501,X
    inx
    cpx #$0D
    bne B04_90C6
; call to code in a different bank ($0F:$C22C)
    jsr $C22C
    jsr $90EE
; call to code in a different bank ($0F:$C22C)
    jsr $C22C
    pla
    tax
    dex
    bne B04_90BD
    rts

; control flow target (from $90BF)
    ldx #$00
; control flow target (from $90EB)
B04_90E2:
    lda $0500,X
    sta $044A,X
    inx
    cpx #$1A
    bne B04_90E2
    rts

; control flow target (from $90D4)
    ldx #$00
; control flow target (from $90F9)
B04_90F0:
    lda $044A,X
    sta $0500,X
    inx
    cpx #$1A
    bne B04_90F0
    rts


; code -> data
; count? + pointer to enemy graphics? + pointer to enemy palette
; indirect data load target (via $88BE)
.byte $01

.byte $00

.byte $80

.byte $00

.byte $80

.byte $04	 ; count
.addr $8002	 ; $01:$8002; Monster ID #$01: Slime + Monster ID #$30: Metal Slime
.addr $929B	 ; $04:$929B; monster palettes
.byte $0B	 ; count
.byte $3D,$80	 ; $01:$803D; Monster ID #$02: Big Slug + Monster ID #$18: Sea Slug
.byte $9F,$92	 ; $04:$929F
.byte $0D	 ; count
.byte $CE,$80	 ; $01:$80CE; Monster ID #$03: Iron Ant + Monster ID #$09: Army Ant + Monster ID #$0D: Magic Ant
.byte $A6,$92	 ; $04:$92A6
.byte $06	 ; count
.byte $75,$81	 ; $01:$8175; Monster ID #$04: Drakee + Monster ID #$0E: Magidrakee
.byte $AD,$92	 ; $04:$92AD
.byte $10	 ; count
.byte $CA,$81	 ; $01:$81CA; Monster ID #$05: Wild Mouse + Monster ID #$0B: Big Rat + Monster ID #$14: Ghost Rat
.byte $B1,$92	 ; $04:$92B1
.byte $06	 ; count
.byte $8E,$82	 ; $01:$828E; Monster ID #$06: Healer + Monster ID #$10: Man O’ War
.byte $B5,$92	 ; $04:$92B5
.byte $0F	 ; count
.byte $DB,$82	 ; $01:$82DB; Monster ID #$07: Ghost Mouse + Monster ID #$1D: Demighost
.byte $B9,$92	 ; $04:$92B9
.byte $06	 ; count
.byte $04,$84	 ; $01:$8404; Monster ID #$08: Babble + Monster ID #$42: Metal Babble
.byte $C0,$92	 ; $04:$92C0
.byte $0D	 ; count
.byte $CE,$80	 ; $01:$80CE; Monster ID #$03: Iron Ant + Monster ID #$09: Army Ant + Monster ID #$0D: Magic Ant
.byte $C4,$92	 ; $04:$92C4
.byte $19	 ; count
.byte $4F,$84	 ; $01:$844F; Monster ID #$0A: Magician + Monster ID #$1A: Enchanter + Monster ID #$2F: Sorcerer
.byte $CB,$92	 ; $04:$92CB
.byte $10	 ; count
.byte $CA,$81	 ; $01:$81CA; Monster ID #$05: Wild Mouse + Monster ID #$0B: Big Rat + Monster ID #$14: Ghost Rat
.byte $D2,$92	 ; $04:$92D2
.byte $10	 ; count
.byte $E0,$85	 ; $01:$85E0; Monster ID #$0C: Big Cobra + Monster ID #$26: Basilisk
.byte $D6,$92	 ; $04:$92D6
.byte $0D	 ; count
.byte $CE,$80	 ; $01:$80CE; Monster ID #$03: Iron Ant + Monster ID #$09: Army Ant + Monster ID #$0D: Magic Ant
.byte $DD,$92	 ; $04:$92DD
.byte $06	 ; count
.byte $75,$81	 ; $01:$8175; Monster ID #$04: Drakee + Monster ID #$0E: Magidrakee
.byte $E4,$92	 ; $04:$92E4
.byte $10	 ; count
.byte $CF,$86	 ; $01:$86CF; Monster ID #$0F: Centipod + Monster ID #$17: Megapede
.byte $E8,$92	 ; $04:$92E8
.byte $06	 ; count
.byte $8E,$82	 ; $01:$828E; Monster ID #$06: Healer + Monster ID #$10: Man O’ War
.byte $EF,$92	 ; $04:$92EF
.byte $09	 ; count
.byte $A5,$87	 ; $01:$87A5; Monster ID #$11: Lizard Fly + Monster ID #$23: Dragon Fly
.byte $F3,$92	 ; $04:$92F3
.byte $1D	 ; count
.byte $3B,$88	 ; $01:$883B; Monster ID #$12: Zombie + Monster ID #$2D: Hork + Monster ID #$37: Ghoul
.byte $FA,$92	 ; $04:$92FA
.byte $10	 ; count
.byte $B1,$89	 ; $01:$89B1; Monster ID #$13: Smoke + Monster ID #$2C: Gas
.byte $01,$93	 ; $04:$9301
.byte $10	 ; count
.byte $CA,$81	 ; $01:$81CA; Monster ID #$05: Wild Mouse + Monster ID #$0B: Big Rat + Monster ID #$14: Ghost Rat
.byte $05,$93	 ; $04:$9305
.byte $10	 ; count
.byte $BB,$8A	 ; $01:$8ABB; Monster ID #$15: Baboon + Monster ID #$1C: Magic Baboon + Monster ID #$33: Hibabango
.byte $09,$93	 ; $04:$9309
.byte $17	 ; count
.byte $9F,$8B	 ; $01:$8B9F; Monster ID #$16: Carnivog + Monster ID #$1F: Poison Lily
.byte $10,$93	 ; $04:$9310
.byte $10	 ; count
.byte $CF,$86	 ; $01:$86CF; Monster ID #$0F: Centipod + Monster ID #$17: Megapede
.byte $17,$93	 ; $04:$9317
.byte $0B	 ; count
.byte $3D,$80	 ; $01:$803D; Monster ID #$02: Big Slug + Monster ID #$18: Sea Slug
.byte $1E,$93	 ; $04:$931E
.byte $1B	 ; count
.byte $D0,$8C	 ; $01:$8CD0; Monster ID #$19: Medusa Ball + Monster ID #$21: Gorgon
.byte $25,$93	 ; $04:$9325
.byte $1D	 ; count
.byte $4F,$84	 ; $01:$844F; Monster ID #$0A: Magician + Monster ID #$1A: Enchanter + Monster ID #$2F: Sorcerer
.byte $2C,$93	 ; $04:$932C
.byte $12	 ; count
.byte $84,$8E	 ; $01:$8E84; Monster ID #$1B: Mud Man + Monster ID #$29: Puppet Man
.byte $33,$93	 ; $04:$9333
.byte $10	 ; count
.byte $BB,$8A	 ; $01:$8ABB; Monster ID #$15: Baboon + Monster ID #$1C: Magic Baboon + Monster ID #$33: Hibabango
.byte $37,$93	 ; $04:$9337
.byte $14	 ; count
.byte $DB,$82	 ; $01:$82DB; Monster ID #$07: Ghost Mouse + Monster ID #$1D: Demighost
.byte $3E,$93	 ; $04:$933E
.byte $0D	 ; count
.byte $AF,$8F	 ; $01:$8FAF; Monster ID #$1E: Gremlin + Monster ID #$3C: Ozwarg
.byte $45,$93	 ; $04:$9345
.byte $17	 ; count
.byte $9F,$8B	 ; $01:$8B9F; Monster ID #$16: Carnivog + Monster ID #$1F: Poison Lily
.byte $4C,$93	 ; $04:$934C
.byte $1A	 ; count
.byte $66,$90	 ; $01:$9066; Monster ID #$20: Mummy Man + Monster ID #$2A: Mummy
.byte $53,$93	 ; $04:$9353
.byte $1B	 ; count
.byte $D0,$8C	 ; $01:$8CD0; Monster ID #$19: Medusa Ball + Monster ID #$21: Gorgon
.byte $5A,$93	 ; $04:$935A
.byte $19	 ; count
.byte $E0,$91	 ; $01:$91E0; Monster ID #$22: Saber Tiger + Monster ID #$3A: Saber Lion
.byte $61,$93	 ; $04:$9361
.byte $09	 ; count
.byte $A5,$87	 ; $01:$87A5; Monster ID #$11: Lizard Fly + Monster ID #$23: Dragon Fly
.byte $68,$93	 ; $04:$9368
.byte $20	 ; count
.byte $41,$93	 ; $01:$9341; Monster ID #$24: Titan Tree + Monster ID #$2B: Evil Tree
.byte $6F,$93	 ; $04:$936F
.byte $18	 ; count
.byte $DA,$94	 ; $01:$94DA; Monster ID #$25: Undead + Monster ID #$39: Mega Knight + Monster ID #$43: Hargon’s Knight
.byte $76,$93	 ; $04:$9376
.byte $10	 ; count
.byte $E0,$85	 ; $01:$85E0; Monster ID #$0C: Big Cobra + Monster ID #$26: Basilisk
.byte $7A,$93	 ; $04:$937A
.byte $0C	 ; count
.byte $27,$96	 ; $01:$9627; Monster ID #$27: Goopi + Monster ID #$34: Graboopi
.byte $81,$93	 ; $04:$9381
.byte $20	 ; count
.byte $CA,$96	 ; $01:$96CA; Monster ID #$28: Orc + Monster ID #$35: Gold Orc + Monster ID #$3F: Orc King
.byte $85,$93	 ; $04:$9385
.byte $12	 ; count
.byte $84,$8E	 ; $01:$8E84; Monster ID #$1B: Mud Man + Monster ID #$29: Puppet Man
.byte $8C,$93	 ; $04:$938C
.byte $1A	 ; count
.byte $66,$90	 ; $01:$9066; Monster ID #$20: Mummy Man + Monster ID #$2A: Mummy
.byte $90,$93	 ; $04:$9390
.byte $20	 ; count
.byte $41,$93	 ; $01:$9341; Monster ID #$24: Titan Tree + Monster ID #$2B: Evil Tree
.byte $97,$93	 ; $04:$9397
.byte $10	 ; count
.byte $B1,$89	 ; $01:$89B1; Monster ID #$13: Smoke + Monster ID #$2C: Gas
.byte $9E,$93	 ; $04:$939E
.byte $1D	 ; count
.byte $3B,$88	 ; $01:$883B; Monster ID #$12: Zombie + Monster ID #$2D: Hork + Monster ID #$37: Ghoul
.byte $A2,$93	 ; $04:$93A2
.byte $14	 ; count
.byte $B2,$98	 ; $01:$98B2; Monster ID #$2E: Hawk Man + Monster ID #$3E: Gargoyle
.byte $A9,$93	 ; $04:$93A9
.byte $1D	 ; count
.byte $4F,$84	 ; $01:$844F; Monster ID #$0A: Magician + Monster ID #$1A: Enchanter + Monster ID #$2F: Sorcerer
.byte $B0,$93	 ; $04:$93B0
.byte $04	 ; count
.byte $02,$80	 ; $01:$8002; Monster ID #$01: Slime + Monster ID #$30: Metal Slime
.byte $B7,$93	 ; $04:$93B7
.byte $20	 ; count
.byte $09,$9A	 ; $01:$9A09; Monster ID #$31: Hunter + Monster ID #$41: Berserker
.byte $BB,$93	 ; $04:$93BB
.byte $13	 ; count
.byte $36,$9C	 ; $01:$9C36; Monster ID #$32: Evil Eye + Monster ID #$3D: Dark Eye
.byte $C2,$93	 ; $04:$93C2
.byte $10	 ; count
.byte $BB,$8A	 ; $01:$8ABB; Monster ID #$15: Baboon + Monster ID #$1C: Magic Baboon + Monster ID #$33: Hibabango
.byte $C6,$93	 ; $04:$93C6
.byte $0C	 ; count
.byte $27,$96	 ; $01:$9627; Monster ID #$27: Goopi + Monster ID #$34: Graboopi
.byte $CD,$93	 ; $04:$93CD
.byte $22	 ; count
.byte $CA,$96	 ; $01:$96CA; Monster ID #$28: Orc + Monster ID #$35: Gold Orc + Monster ID #$3F: Orc King
.byte $D1,$93	 ; $04:$93D1
.byte $13	 ; count
.byte $50,$9D	 ; $01:$9D50; Monster ID #$36: Evil Clown + Monster ID #$47: Mace Master
.byte $D8,$93	 ; $04:$93D8
.byte $1D	 ; count
.byte $3B,$88	 ; $01:$883B; Monster ID #$12: Zombie + Monster ID #$2D: Hork + Monster ID #$37: Ghoul
.byte $DF,$93	 ; $04:$93DF
.byte $22	 ; count
.byte $9A,$9E	 ; $01:$9E9A; Monster ID #$38: Vampirus + Monster ID #$40: Magic Vampirus
.byte $E6,$93	 ; $04:$93E6
.byte $18	 ; count
.byte $DA,$94	 ; $01:$94DA; Monster ID #$25: Undead + Monster ID #$39: Mega Knight + Monster ID #$43: Hargon’s Knight
.byte $ED,$93	 ; $04:$93ED
.byte $19	 ; count
.byte $E0,$91	 ; $01:$91E0; Monster ID #$22: Saber Tiger + Monster ID #$3A: Saber Lion
.byte $F1,$93	 ; $04:$93F1
.byte $1C	 ; count
.byte $76,$A0	 ; $01:$A076; Monster ID #$3B: Metal Hunter + Monster ID #$45: Attackbot
.byte $F8,$93	 ; $04:$93F8
.byte $0D	 ; count
.byte $AF,$8F	 ; $01:$8FAF; Monster ID #$1E: Gremlin + Monster ID #$3C: Ozwarg
.byte $FF,$93	 ; $04:$93FF
.byte $13	 ; count
.byte $36,$9C	 ; $01:$9C36; Monster ID #$32: Evil Eye + Monster ID #$3D: Dark Eye
.byte $06,$94	 ; $04:$9406
.byte $17	 ; count
.byte $B2,$98	 ; $01:$98B2; Monster ID #$2E: Hawk Man + Monster ID #$3E: Gargoyle
.byte $0A,$94	 ; $04:$940A
.byte $22	 ; count
.byte $CA,$96	 ; $01:$96CA; Monster ID #$28: Orc + Monster ID #$35: Gold Orc + Monster ID #$3F: Orc King
.byte $11,$94	 ; $04:$9411
.byte $22	 ; count
.byte $9A,$9E	 ; $01:$9E9A; Monster ID #$38: Vampirus + Monster ID #$40: Magic Vampirus
.byte $18,$94	 ; $04:$9418
.byte $27	 ; count
.byte $09,$9A	 ; $01:$9A09; Monster ID #$31: Hunter + Monster ID #$41: Berserker
.byte $1F,$94	 ; $04:$941F
.byte $06	 ; count
.byte $04,$84	 ; $01:$8404; Monster ID #$08: Babble + Monster ID #$42: Metal Babble
.byte $26,$94	 ; $04:$9426
.byte $18	 ; count
.byte $DA,$94	 ; $01:$94DA; Monster ID #$25: Undead + Monster ID #$39: Mega Knight + Monster ID #$43: Hargon’s Knight
.byte $2A,$94	 ; $04:$942A
.byte $37	 ; count
.byte $73,$A2	 ; $01:$A273; Monster ID #$44: Cyclops + Monster ID #$4B: Giant + Monster ID #$4E: Atlas
.byte $2E,$94	 ; $04:$942E
.byte $26	 ; count
.byte $76,$A0	 ; $01:$A076; Monster ID #$3B: Metal Hunter + Monster ID #$45: Attackbot
.byte $38,$94	 ; $04:$9438
.byte $17	 ; count
.byte $19,$A6	 ; $01:$A619; Monster ID #$46: Green Dragon
.byte $3F,$94	 ; $04:$943F
.byte $13	 ; count
.byte $50,$9D	 ; $01:$9D50; Monster ID #$36: Evil Clown + Monster ID #$47: Mace Master
.byte $46,$94	 ; $04:$9446
.byte $1E	 ; count
.byte $6A,$A7	 ; $01:$A76A; Monster ID #$48: Flame + Monster ID #$4A: Blizzard
.byte $4D,$94	 ; $04:$944D
.byte $1D	 ; count
.byte $FC,$A8	 ; $01:$A8FC; Monster ID #$49: Silver Batboon + Monster ID #$4C: Gold Batboon + Monster ID #$4F: Bazuzu
.byte $51,$94	 ; $04:$9451
.byte $1E	 ; count
.byte $6A,$A7	 ; $01:$A76A; Monster ID #$48: Flame + Monster ID #$4A: Blizzard
.byte $58,$94	 ; $04:$9458
.byte $40	 ; count
.byte $73,$A2	 ; $01:$A273; Monster ID #$44: Cyclops + Monster ID #$4B: Giant + Monster ID #$4E: Atlas
.byte $5C,$94	 ; $04:$945C
.byte $1D	 ; count
.byte $FC,$A8	 ; $01:$A8FC; Monster ID #$49: Silver Batboon + Monster ID #$4C: Gold Batboon + Monster ID #$4F: Bazuzu
.byte $66,$94	 ; $04:$9466
.byte $47	 ; count
.byte $AF,$AA	 ; $01:$AAAF; Monster ID #$4D: Bullwong + Monster ID #$50: Zarlox
.byte $6D,$94	 ; $04:$946D
.byte $40	 ; count
.byte $73,$A2	 ; $01:$A273; Monster ID #$44: Cyclops + Monster ID #$4B: Giant + Monster ID #$4E: Atlas
.byte $7A,$94	 ; $04:$947A
.byte $1D	 ; count
.byte $FC,$A8	 ; $01:$A8FC; Monster ID #$49: Silver Batboon + Monster ID #$4C: Gold Batboon + Monster ID #$4F: Bazuzu
.byte $84,$94	 ; $04:$9484
.byte $4C	 ; count
.byte $AF,$AA	 ; $01:$AAAF; Monster ID #$4D: Bullwong + Monster ID #$50: Zarlox
.byte $8B,$94	 ; $04:$948B
.byte $35	 ; count
.byte $98,$AE	 ; $01:$AE98; Monster ID #$51: Hargon
.byte $98,$94	 ; $04:$9498
.byte $4D	 ; count
.byte $78,$B1	 ; $01:$B178; Monster ID #$52: Malroth
.byte $9F,$94	 ; $04:$949F
; monster palettes
; format is 1 byte X/Y dimensions, 3*(sum of dimension nybbles) palette data
; indirect data load target (via $9104)
.byte $10,$30,$15,$1C	 ; Monster ID #$01: Slime
; indirect data load target (via $9109)
.byte $11,$19,$0F,$0F,$30,$37,$16	 ; Monster ID #$02: Big Slug
; indirect data load target (via $910E)
.byte $11,$30,$15,$0F,$21,$27,$17	 ; Monster ID #$03: Iron Ant
; indirect data load target (via $9113)
.byte $10,$30,$15,$01	 ; Monster ID #$04: Drakee
; indirect data load target (via $9118)
.byte $10,$00,$24,$1C	 ; Monster ID #$05: Wild Mouse
; indirect data load target (via $911D)
.byte $10,$11,$27,$30	 ; Monster ID #$06: Healer
; indirect data load target (via $9122)
.byte $11,$30,$11,$19,$11,$21,$17	 ; Monster ID #$07: Ghost Mouse
; indirect data load target (via $9127)
.byte $10,$19,$29,$30	 ; Monster ID #$08: Babble
; indirect data load target (via $912C)
.byte $11,$30,$17,$0F,$2A,$2C,$1C	 ; Monster ID #$09: Army Ant
; indirect data load target (via $9131)
.byte $11,$36,$0F,$0F,$30,$1B,$06	 ; Monster ID #$0A: Magician
; indirect data load target (via $9136)
.byte $10,$1C,$10,$26	 ; Monster ID #$0B: Big Rat
; indirect data load target (via $913B)
.byte $11,$30,$10,$0F,$00,$15,$27	 ; Monster ID #$0C: Big Cobra
; indirect data load target (via $9140)
.byte $11,$30,$11,$0F,$25,$26,$16	 ; Monster ID #$0D: Magic Ant
; indirect data load target (via $9145)
.byte $10,$35,$02,$19	 ; Monster ID #$0E: Magidrakee
; indirect data load target (via $914A)
.byte $11,$30,$0F,$0F,$16,$21,$37	 ; Monster ID #$0F: Centipod
; indirect data load target (via $914F)
.byte $10,$30,$2C,$10	 ; Monster ID #$10: Man O’ War
; indirect data load target (via $9154)
.byte $11,$35,$0F,$0F,$19,$29,$30	 ; Monster ID #$11: Lizard Fly
; indirect data load target (via $9159)
.byte $11,$22,$28,$0F,$18,$1A,$36	 ; Monster ID #$12: Zombie
; indirect data load target (via $915E)
.byte $10,$00,$26,$10	 ; Monster ID #$13: Smoke
; indirect data load target (via $9163)
.byte $10,$06,$2C,$10	 ; Monster ID #$14: Ghost Rat
; indirect data load target (via $9168)
.byte $11,$30,$0F,$0F,$17,$1C,$26	 ; Monster ID #$15: Baboon
; indirect data load target (via $916D)
.byte $11,$30,$0F,$0F,$15,$2A,$22	 ; Monster ID #$16: Carnivog
; indirect data load target (via $9172)
.byte $11,$13,$0F,$0F,$1C,$26,$3A	 ; Monster ID #$17: Megapede
; indirect data load target (via $9177)
.byte $11,$26,$0F,$0F,$21,$23,$1C	 ; Monster ID #$18: Sea Slug
; indirect data load target (via $917C)
.byte $11,$30,$0F,$0F,$16,$15,$21	 ; Monster ID #$19: Medusa Ball
; indirect data load target (via $9181)
.byte $11,$2C,$16,$36,$30,$13,$1C	 ; Monster ID #$1A: Enchanter
; indirect data load target (via $9186)
.byte $10,$17,$27,$00	 ; Monster ID #$1B: Mud Man
; indirect data load target (via $918B)
.byte $11,$36,$0F,$0F,$1A,$13,$16	 ; Monster ID #$1C: Magic Baboon
; indirect data load target (via $9190)
.byte $11,$30,$11,$19,$16,$26,$14	 ; Monster ID #$1D: Demighost
; indirect data load target (via $9195)
.byte $11,$30,$15,$0F,$10,$23,$1C	 ; Monster ID #$1E: Gremlin
; indirect data load target (via $919A)
.byte $11,$30,$0F,$0F,$21,$24,$17	 ; Monster ID #$1F: Poison Lily
; indirect data load target (via $919F)
.byte $11,$0F,$15,$27,$30,$10,$1C	 ; Monster ID #$20: Mummy Man
; indirect data load target (via $91A4)
.byte $11,$37,$0F,$0F,$1C,$26,$29	 ; Monster ID #$21: Gorgon
; indirect data load target (via $91A9)
.byte $11,$11,$0F,$0F,$30,$17,$27	 ; Monster ID #$22: Saber Tiger
; indirect data load target (via $91AE)
.byte $11,$3A,$0F,$0F,$15,$25,$3C	 ; Monster ID #$23: Dragon Fly
; indirect data load target (via $91B3)
.byte $11,$30,$15,$0F,$17,$1A,$0A	 ; Monster ID #$24: Titan Tree
; indirect data load target (via $91B8)
.byte $10,$30,$21,$26	 ; Monster ID #$25: Undead
; indirect data load target (via $91BD)
.byte $11,$3C,$1C,$0F,$21,$13,$25	 ; Monster ID #$26: Basilisk
; indirect data load target (via $91C2)
.byte $10,$30,$27,$10	 ; Monster ID #$27: Goopi
; indirect data load target (via $91C7)
.byte $11,$30,$24,$0F,$17,$29,$10	 ; Monster ID #$28: Orc
; indirect data load target (via $91CC)
.byte $10,$1C,$2C,$11	 ; Monster ID #$29: Puppet Man
; indirect data load target (via $91D1)
.byte $11,$0F,$0F,$36,$31,$21,$14	 ; Monster ID #$2A: Mummy
; indirect data load target (via $91D6)
.byte $11,$30,$27,$0F,$1C,$15,$05	 ; Monster ID #$2B: Evil Tree
; indirect data load target (via $91DB)
.byte $10,$14,$06,$34	 ; Monster ID #$2C: Gas
; indirect data load target (via $91E0)
.byte $11,$0C,$00,$0F,$1C,$10,$17	 ; Monster ID #$2D: Hork
; indirect data load target (via $91E5)
.byte $11,$30,$28,$00,$21,$1C,$24	 ; Monster ID #$2E: Hawk Man
; indirect data load target (via $91EA)
.byte $11,$23,$00,$10,$32,$15,$1C	 ; Monster ID #$2F: Sorcerer
; indirect data load target (via $91EF)
.byte $10,$30,$0F,$00	 ; Monster ID #$30: Metal Slime
; indirect data load target (via $91F4)
.byte $11,$30,$25,$00,$1C,$29,$17	 ; Monster ID #$31: Hunter
; indirect data load target (via $91F9)
.byte $10,$30,$15,$27	 ; Monster ID #$32: Evil Eye
; indirect data load target (via $91FE)
.byte $11,$30,$0F,$0F,$23,$16,$1C	 ; Monster ID #$33: Hibabango
; indirect data load target (via $9203)
.byte $10,$35,$06,$15	 ; Monster ID #$34: Graboopi
; indirect data load target (via $9208)
.byte $11,$30,$24,$30,$37,$13,$10	 ; Monster ID #$35: Gold Orc
; indirect data load target (via $920D)
.byte $11,$2A,$10,$00,$30,$15,$1C	 ; Monster ID #$36: Evil Clown
; indirect data load target (via $9212)
.byte $11,$06,$34,$0F,$30,$15,$1C	 ; Monster ID #$37: Ghoul
; indirect data load target (via $9217)
.byte $11,$30,$15,$0F,$1C,$27,$00	 ; Monster ID #$38: Vampirus
; indirect data load target (via $921C)
.byte $10,$37,$06,$25	 ; Monster ID #$39: Mega Knight
; indirect data load target (via $9221)
.byte $11,$17,$0F,$0F,$31,$15,$25	 ; Monster ID #$3A: Saber Lion
; indirect data load target (via $9226)
.byte $11,$30,$2A,$19,$10,$1C,$23	 ; Monster ID #$3B: Metal Hunter
; indirect data load target (via $922B)
.byte $11,$30,$15,$0F,$1C,$16,$07	 ; Monster ID #$3C: Ozwarg
; indirect data load target (via $9230)
.byte $10,$35,$1C,$23	 ; Monster ID #$3D: Dark Eye
; indirect data load target (via $9235)
.byte $11,$30,$1C,$00,$14,$18,$10	 ; Monster ID #$3E: Gargoyle
; indirect data load target (via $923A)
.byte $11,$37,$00,$31,$22,$17,$1B	 ; Monster ID #$3F: Orc King
; indirect data load target (via $923F)
.byte $11,$30,$12,$0F,$17,$10,$04	 ; Monster ID #$40: Magic Vampirus
; indirect data load target (via $9244)
.byte $11,$30,$28,$00,$19,$26,$15	 ; Monster ID #$41: Berserker
; indirect data load target (via $9249)
.byte $10,$00,$10,$30	 ; Monster ID #$42: Metal Babble
; indirect data load target (via $924E)
.byte $10,$2C,$13,$24	 ; Monster ID #$43: Hargon’s Knight
; indirect data load target (via $9253)
.byte $12,$30,$15,$25,$0F,$0F,$0F,$21,$11,$18	 ; Monster ID #$44: Cyclops
; indirect data load target (via $9258)
.byte $11,$30,$27,$16,$21,$13,$15	 ; Monster ID #$45: Attack Bot
; indirect data load target (via $925D)
.byte $11,$30,$15,$01,$10,$19,$27	 ; Monster ID #$46: Green Dragon
; indirect data load target (via $9262)
.byte $11,$21,$15,$05,$3B,$11,$14	 ; Monster ID #$47: Mace Master
; indirect data load target (via $9267)
.byte $10,$11,$26,$0F	 ; Monster ID #$48: Flame
; indirect data load target (via $926C)
.byte $11,$15,$21,$0F,$30,$00,$11	 ; Monster ID #$49: Silver Batboon
; indirect data load target (via $9271)
.byte $10,$30,$21,$0F	 ; Monster ID #$4A: Blizzard
; indirect data load target (via $9276)
.byte $12,$30,$16,$36,$0F,$16,$26,$2A,$1A,$1C	 ; Monster ID #$4B: Giant
; indirect data load target (via $927B)
.byte $11,$30,$15,$0F,$36,$1C,$06	 ; Monster ID #$4C: Gold Batboon
; indirect data load target (via $9280)
.byte $13,$30,$28,$14,$1C,$1A,$14,$23,$0F,$0F,$23,$10,$15	 ; Monster ID #$4D: Bullwong
; indirect data load target (via $9285)
.byte $12,$30,$21,$31,$0F,$00,$10,$26,$16,$12	 ; Monster ID #$4E: Atlas
; indirect data load target (via $928A)
.byte $11,$30,$25,$0F,$13,$06,$1C	 ; Monster ID #$4F: Bazuzu
; indirect data load target (via $928F)
.byte $13,$30,$23,$26,$00,$15,$26,$37,$0F,$0F,$37,$21,$11	 ; Monster ID #$50: Zarlox
; indirect data load target (via $9294)
.byte $11,$21,$13,$17,$30,$15,$25	 ; Monster ID #$51: Hargon
; indirect data load target (via $9299)
.byte $34,$30,$24,$2C,$1A,$26,$24,$1A,$24,$1C,$15,$24,$1C,$1A,$26,$1C,$1A,$24,$1C,$1A,$26,$24	 ; Monster ID #$52: Malroth

; data -> code
; control flow target (from $8329)
    ldx #$08
    stx $14 ; coords?

    dex
    stx $15 ; coords?

    jsr $9A16 ; set number of NMIs to wait for to current battle message delay if current battle message delay is not SLOW

    ldx #$24 ; start with Moonbrooke

; control flow target (from $94CE)
B04_94C1:
    lda $062D,X ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    and #$A4 ; clear all battle-only statuses (keep Alive, Poison, and In Party)

    sta $062D,X ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    txa
    sec
    sbc #$12 ; hero data is #$12 bytes wide

    tax
    bpl B04_94C1 ; if more hero data to update, update it

    lda #$FF
    sta $8E ; flag for in battle or not (#$FF)?

    lda #$0F
    sta $B3
    jsr $B5F7
    lda #$00
    sta $98 ; outcome of last fight?

    jsr $9AAC
    jsr $9AB4
    ldx #$00
    stx $60D8
; control flow target (from $94FA)
B04_94EA:
    txa
    jsr $9EEE ; given an index (in A) into the array of structures at $0663, set $B5-$B6 to the address of the corresponding item inside that structure

    ldy #$09
    lda ($B5),Y
    beq B04_94F7
    inc $60D8
; control flow target (from $94F2)
B04_94F7:
    inx
    cpx #$04
    bcc B04_94EA
    lda #$00
    sta $A8
    sta $A7
; control flow target (from $9538)
B04_9502:
    jsr $9EEE ; given an index (in A) into the array of structures at $0663, set $B5-$B6 to the address of the corresponding item inside that structure

    ldy #$09
    lda ($B5),Y
    sta $8F
    beq B04_9532
    inc $A8
    ldy #$00
    lda ($B5),Y
    sta $0161 ; current monster ID

    ldx #$00
    jsr $9CD6 ; write monster name in A (+ monster number within its group in X, if > 0) to $6119

    dec $60D8
    bne B04_952D
    ldx $A8
    dex
    bne B04_9529
    lda #$54 ; String ID #$0054: [cardinal #] [monster(s)][line]appeared.[end-FC]

    bne B04_952F
; control flow target (from $9523)
B04_9529:
    lda #$53 ; String ID #$0053: And [cardinal #] [monster(s)][line]appeared.[end-FC]

    bne B04_952F
; control flow target (from $951E)
B04_952D:
    lda #$01 ; String ID #$0001: [cardinal #] [monster(s)],[end-FC]

; control flow target (from $9527, $952B)
B04_952F:
    jsr $9CCA ; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0

; control flow target (from $950B)
B04_9532:
    inc $A7
    lda $A7
    cmp #$04
    bcc B04_9502
    lda $A8
    bne B04_954A
    lda #$02 ; String ID #$0002: But it wasn't real.[end-FC]

    jsr $9CCA ; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0

    lda #$FD
    sta $98 ; outcome of last fight?

    jmp $9685

; control flow target (from $953C)
B04_954A:
    jsr $87AE
    jsr $9A3C ; set number of NMIs to wait for to current battle message delay * 1.5 if current battle message delay is < #$80, #$64 otherwise

    jsr $9961
    lda #$20
    jsr $A020 ; generate a random number between $03 and A in A and $99

    sta $06DD
    cmp #$01
    bcc B04_957D
    bne B04_9585
    lda #$03 ; String ID #$0003: [name] attacked![end-FC]

    jsr $9CCA ; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0

    jsr $997F
    lda #$04 ; String ID #$0004: Before [name] was set for battle.[end-FC]

    jsr $9CCA ; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0

    jsr $9AA0
    jsr $B6DC
    jsr $9A3C ; set number of NMIs to wait for to current battle message delay * 1.5 if current battle message delay is < #$80, #$64 otherwise

    jsr $9AD6
    jmp $95E3

; control flow target (from $955D)
B04_957D:
    lda #$05 ; String ID #$0005: But the [name] did not see thee.[end-FC]

    jsr $9CCA ; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0

    jsr $9A3C ; set number of NMIs to wait for to current battle message delay * 1.5 if current battle message delay is < #$80, #$64 otherwise

; control flow target (from $955F, $9682)
B04_9585:
    jsr $B6DC
    jsr $B312
    lda $062F ; Midenhall Battle Command

    cmp #$32
    beq B04_9595
    jmp $95E3

; control flow target (from $9590)
B04_9595:
    jsr $997F
    lda #$83 ; Music ID #$83: flee SFX

; call to code in a different bank ($0F:$C561)
    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    lda #$0F ; String ID #$000F: [name] broke away and ran.[end-FC]

    jsr $9CCA ; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0

    lda $0161 ; current monster ID

    cmp #$4E ; bosses start at #$4E

    bcs B04_95D2 ; can't run away from bosses

    lda $31 ; current map ID

    cmp #$33 ; Map ID #$33: Sea Cave B5

    bne B04_95BF
    lda $16 ; current map X-pos (1)

    cmp #$10
    bne B04_95BF
    lda $17 ; current map Y-pos (1)

    cmp #$0C
    beq B04_95D2 ; can't run away from this fixed combat either

    cmp #$0D
    beq B04_95D2
; control flow target (from $95AD, $95B3)
B04_95BF:
    lda $06DD
    beq B04_95CB
    lda #$03
    jsr $A020 ; generate a random number between $03 and A in A and $99

    beq B04_95D2
; control flow target (from $95C2)
B04_95CB:
    lda #$FC
    sta $98 ; outcome of last fight?

    jmp $9685

; control flow target (from $95A7, $95B9, $95BD, $95C9)
B04_95D2:
    jsr $9A3C ; set number of NMIs to wait for to current battle message delay * 1.5 if current battle message delay is < #$80, #$64 otherwise

    jsr $9AA0
    lda #$10 ; String ID #$0010: But there was no escape.[end-FC]

    jsr $9CCA ; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0

    jsr $9A3C ; set number of NMIs to wait for to current battle message delay * 1.5 if current battle message delay is < #$80, #$64 otherwise

    jsr $9AD6
; control flow target (from $957A, $9592)
    ldx #$05
    lda #$FF
; control flow target (from $95EB)
B04_95E7:
    sta $06D5,X
    dex
    bpl B04_95E7
    lda #$00
    sta $06DB
    lda #$07
    sta $A7
; control flow target (from $95FD)
B04_95F6:
    jsr $B052
    dec $A7
    lda $A7
    bpl B04_95F6
    jsr $9A16 ; set number of NMIs to wait for to current battle message delay if current battle message delay is not SLOW

    lda #$00
    sta $06E0
; control flow target (from $9655)
B04_9607:
    tax
    lda #$4F
    sta $AD
    lda #$00
    sta $0176
    lda $06C7,X
    cmp #$18
    bcs B04_963C
    cmp #$03
    bcc B04_962E
    and #$07
    ldy $06DD
    cpy #$00
    beq B04_963C
    jsr $A85B
    lda $98 ; outcome of last fight?

    beq B04_963C
    bne B04_9685
; control flow target (from $961A)
B04_962E:
    ldy $06DD
    cpy #$01
    beq B04_963C
    jsr $A0FD
    lda $98 ; outcome of last fight?

    bne B04_9685
; control flow target (from $9616, $9623, $962A, $9633)
B04_963C:
    lda $0176
    bne B04_964A
    lda $AD
    cmp #$4F
    beq B04_964A
    jsr $9CDC
; control flow target (from $963F, $9645)
B04_964A:
    jsr $A0F1
    inc $06E0
    lda $06E0
    cmp #$0B
    bcc B04_9607
    lda #$00
    sta $A7
; control flow target (from $967B)
B04_965B:
    jsr $9EEE ; given an index (in A) into the array of structures at $0663, set $B5-$B6 to the address of the corresponding item inside that structure

    ldy #$0A
    lda ($B5),Y
    cmp #$03
    bcs B04_9675
    jsr $9EE4 ; given an index (in A) into the array of hero data structures at $062D, set $B9-$BA to the address of the corresponding item inside that structure

    ldy #$00
    lda ($B9),Y
    bmi B04_9675
    lda #$FF
    ldy #$0A
    sta ($B5),Y
; control flow target (from $9664, $966D)
B04_9675:
    inc $A7
    lda $A7
    cmp #$04
    bcc B04_965B
    lda #$FF
    sta $06DD
    jmp $9585

; control flow target (from $9547, $95CF, $962C, $963A)
B04_9685:
    lda #$01
    sta $8E ; flag for in battle or not (#$FF)?

    lda $98 ; outcome of last fight?

    cmp #$FE
    bcs B04_9692
; call to code in a different bank ($0F:$C5A3)
    jmp $C5A3

; control flow target (from $968D)
B04_9692:
    cmp #$FF
    bne B04_96BB
    jsr $9A3C ; set number of NMIs to wait for to current battle message delay * 1.5 if current battle message delay is < #$80, #$64 otherwise

    jsr $9ABF
    lda #$12 ; Music ID #$12: party defeat BGM

; call to code in a different bank ($0F:$C561)
    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    ldx #$1B ; String ID #$001B: Alas, brave [name] hast died.[end-FC]

    lda $063F ; Cannock status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    and #$04
    beq B04_96AE
    lda #$80
    ldx #$B1 ; String ID #$0151: [name] is utterly destroyed.[end-FC]

; control flow target (from $96A8)
B04_96AE:
    stx $C7
    jsr $9CD0 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    lda $C7
    jsr $9CCA ; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0

    jmp $9A58

; control flow target (from $9694)
B04_96BB:
    jsr $9991
    lda #$00 ; Midenhall

    sta $A7 ; hero ID

; control flow target (from $971A)
B04_96C2:
    jsr $9EE4 ; given an index (in A) into the array of hero data structures at $062D, set $B9-$BA to the address of the corresponding item inside that structure

    ldy #$00
    lda ($B9),Y ; Status

    bpl B04_9714 ; branch if dead

    ldy #$06
    lda ($B9),Y ; hero's current EXP, byte 0

    clc
    adc $0626 ; EXP earned this battle or current hero's current EXP, byte 0

    sta $99 ; new EXP, byte 0

    iny
    lda ($B9),Y ; hero's current EXP, byte 1

    adc $0627 ; EXP earned this battle or current hero's current EXP, byte 1

    sta $9A ; new EXP, byte 1

    iny
    lda ($B9),Y ; hero's current EXP, byte 2

    adc #$00
    sta $9B ; new EXP, byte 2

    cmp #$0F ; start checking for 1,000,000 EXP cap

    bcc B04_9704
    bne B04_96F8 ; cap EXP at 1,000,000

    lda $9A
    cmp #$42
    bcc B04_9704
    bne B04_96F8 ; cap EXP at 1,000,000

    lda $99
    cmp #$41
    bcc B04_9704
; cap EXP at 1,000,000
; control flow target (from $96E8, $96F0)
B04_96F8:
    lda #$40
    sta $99
    lda #$42
    sta $9A
    lda #$0F
    sta $9B
; control flow target (from $96E6, $96EE, $96F6)
B04_9704:
    ldy #$06
    lda $99 ; new EXP, byte 0

    sta ($B9),Y ; hero's current EXP, byte 0

    iny
    lda $9A ; new EXP, byte 1

    sta ($B9),Y ; hero's current EXP, byte 1

    iny
    lda $9B ; new EXP, byte 2

    sta ($B9),Y ; hero's current EXP, byte 2

; control flow target (from $96C9)
B04_9714:
    inc $A7 ; hero ID

    lda $A7 ; hero ID

    cmp #$03 ; max of 3 heroes

    bcc B04_96C2 ; if more heroes to update, update them

    lda $0626 ; EXP earned this battle or current hero's current EXP, byte 0

    sta $8F
    lda $0627 ; EXP earned this battle or current hero's current EXP, byte 1

    sta $90
    ora $8F
    bne B04_9737
    lda $0161 ; current monster ID

    cmp #$51
    bcs B04_9737
; call to code in a different bank ($0F:$C5A3)
    jsr $C5A3
    jmp $9A3C ; set number of NMIs to wait for to current battle message delay * 1.5 if current battle message delay is < #$80, #$64 otherwise


; control flow target (from $9728, $972F)
B04_9737:
    jsr $99EA
    jsr $9ABF
    lda #$09 ; Music ID #$09: battle win BGM

; call to code in a different bank ($0F:$C561)
    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    lda $0160 ; ID of only monster (/monster group) or #$53 for "Enemies" if there are multiple groups

    ldx #$00
    jsr $9CD6 ; write monster name in A (+ monster number within its group in X, if > 0) to $6119

    lda #$19 ; String ID #$0019: Thou hast defeated the [name].[end-FC]

    jsr $9CCA ; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0

    lda $0161 ; current monster ID

    cmp #$52
    bne B04_975B
    lda #$00
    sta $05F7 ; probably BGM for current area

; control flow target (from $9754)
; call to code in a different bank ($0F:$C595)
B04_975B:
    jsr $C595
    lda $0161 ; current monster ID

    cmp #$51 ; monster #$51 = Hargon

    bcc B04_9768 ; if you beat anything less than Hargon or Malroth, go see if you got an item drop

    jmp $9A3C ; set number of NMIs to wait for to current battle message delay * 1.5 if current battle message delay is < #$80, #$64 otherwise; otherwise, no item drop for you!


; control flow target (from $9763)
B04_9768:
    lda #$49 ; String ID #$0049: [FD]Of Experience points thou has gained [number][end-FF]

    jsr $9CCA ; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0

    lda #$00 ; start by assuming no item drop (since it's probably true anyway :p)

    sta $61B0 ; flag for whether you get an item drop or not

    jsr $9946 ; determine max possible inventory offset based on current party

    ldx #$00 ; start scanning inventory from the beginning

; control flow target (from $977F)
B04_9777:
    lda $0600,X ; Midenhall inventory item 1 (| #$40 if equipped)

    beq B04_9784 ; if you have an empty slot, maybe you'll get an item drop

    inx ; otherwise get ready to check the next slot

    cpx $A3 ; max possible inventory offset based on current party

    bcc B04_9777 ; if there are more slots to check, check them

    jmp $986A ; if you get here, you have a full inventory; no item drop for you!


; control flow target (from $977A)
B04_9784:
    stx $A7
    txa
    lsr ; inventory slot / 8 == whose inventory that slot belongs to

    lsr
    lsr
    sta $A9
    ldx #$00 ; start by assuming Midenhall's alive

    lda $062D ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    bmi B04_979C ; branch if Midenhall really is alive

    ldx #$01 ; otherwise assume Cannock's alive

    lda $063F ; Cannock status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    bmi B04_979C ; branch if Cannock really is alive

    ldx #$02 ; otherwise Moonbrooke has to be alive, right?

; control flow target (from $9791, $9798)
B04_979C:
    stx $A8
    lda $31 ; current map ID

    cmp #$04 ; guaranteed drop; #$04 = both Item ID #$04: Staff of Thunder and Map ID #$04: Midenhall B1

    beq B04_97D9
    ldx $0161 ; current monster ID

    dex ; monster IDs start at 1, drop list starts at 0

    lda $BF0E,X ; monster drop rates/items

    bne B04_97B0 ; if monster has a drop, see if you get it

    jmp $986A ; otherwise, on with the show...


; control flow target (from $97AB)
B04_97B0:
    sta $A4 ; drop rate/item

    and #$C0 ; pick out the drop rate bits

    beq B04_97C0 ; 0b00xxxxxx

    cmp #$80
    beq B04_97C4 ; 0b10xxxxxx

    bcs B04_97C8 ; 0b11xxxxxx

    lda #$0F ; 0b01xxxxxx; need to match 4 bits => 1/16 chance

    bne B04_97CA
; control flow target (from $97B4)
B04_97C0:
    lda #$07 ; need to match 3 bits => 1/8 chance

    bne B04_97CA
; control flow target (from $97B8)
B04_97C4:
    lda #$1F ; need to match 5 bits => 1/32 chance

    bne B04_97CA
; control flow target (from $97BA)
B04_97C8:
    lda #$7F ; need to match 7 bits => 1/128 chance

; control flow target (from $97BE, $97C2, $97C6)
B04_97CA:
    sta $99 ; drop rate

; call to code in a different bank ($0F:$C3AB)
    jsr $C3AB ; generate a random number and store it in $32-$33 (two passes)

    lda $32 ; RNG byte 0

    and $99 ; drop rate

    bne B04_9847 ; if random number is not 0 in all the required bits, no item drop for you!

    lda $A4 ; drop rate/item

    and #$3F ; this time pick out the dropped item

; control flow target (from $97A2)
B04_97D9:
    sta $A4 ; dropped item

    ldx #$00 ; start scanning through party inventory from the beginning

; control flow target (from $97E9)
B04_97DD:
    lda $0600,X ; Midenhall inventory item 1 (| #$40 if equipped)

    and #$3F ; pick out the base item, don't care whether it's equipped or not

    cmp $A4 ; do you already have one of these items?

    beq B04_984A ; if yes, go see if it's one you're allowed to get another copy of anyway

    inx ; otherwise set X for the next inventory slot

    cpx $A3 ; max possible inventory offset based on current party

    bcc B04_97DD ; if there are more inventory slots to check, check them

; control flow target (from $984C, $9850, $9854, $9858, $985C)
B04_97EB:
    ldx $A7 ; offset of first empty inventory slot

    lda $A4 ; dropped item

    sta $0600,X ; Midenhall inventory item 1 (| #$40 if equipped)

; control flow target (from $9862)
B04_97F2:
    lda #$8A ; String ID #$008A: .[end-FC]

; call to code in a different bank ($0F:$FA4A)
    jsr $FA4A ; display string ID specified by A

    lda #$01 ; flag item gain for later logic

    sta $61B0 ; flag for whether you get an item drop or not

    lda $0160 ; ID of only monster (/monster group) or #$53 for "Enemies" if there are multiple groups

    ldx #$00
    jsr $9CD6 ; write monster name in A (+ monster number within its group in X, if > 0) to $6119

    lda #$AA ; String ID #$014A: [wait][name] had the Treasure Chest.[wait][end-FC]

    jsr $9CCA ; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0

    lda #$92 ; Music ID #$92: open chest SFX

; call to code in a different bank ($0F:$C561)
    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    lda $A9
    jsr $9EE4 ; given an index (in A) into the array of hero data structures at $062D, set $B9-$BA to the address of the corresponding item inside that structure

    ldy #$00
    lda ($B9),Y ; status byte

    bmi B04_981E ; if the hero with the first empty inventory slot is also alive, they get to open the chest, otherwise the first living hero opens it

    lda $A8
    jmp $9820

; control flow target (from $9817)
B04_981E:
    lda $A9
; control flow target (from $981B)
    jsr $9CD0 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    lda #$65 ; String ID #$0105: Seeing a treasure chest, [name] opened it.[wait][end-FC]

    jsr $9CCA ; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0

    lda $A4 ; dropped item

    beq B04_9864 ; branch if no dropped item

    sta $95 ; ID for [item] and [spell] control codes; dropped item

    lda #$64 ; String ID #$0104: And there [name] discovered the [item]![end-FC]

    jsr $9CCA ; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0

    ldy #$00
    lda ($B9),Y ; status byte

    bmi B04_986A ; if hero with the first empty inventory slot is alive, then we're done with items, otherwise give it to their ghost

    lda $A9
    jsr $9CD0 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    lda $A4 ; dropped item

    sta $95 ; ID for [item] and [spell] control codes; yup, still the dropped item...

    lda #$77 ; String ID #$0117: gave the [item] to the ghost of [name].[end-FC]

    jsr $9CCA ; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0

; control flow target (from $97D3)
B04_9847:
    jmp $986A ; done with items, now it's time to deal with gold


; list of item drops you're allowed to have multiples of
; control flow target (from $97E4)
B04_984A:
    cmp #$33 ; Item ID #$33: Lottery Ticket

    beq B04_97EB ; allowed to keep duplicates

    cmp #$34 ; Item ID #$34: Fairy Water

    beq B04_97EB ; allowed to keep duplicates

    cmp #$35 ; Item ID #$35: Wing of the Wyvern

    beq B04_97EB ; allowed to keep duplicates

    cmp #$3B ; Item ID #$3B: Antidote Herb

    beq B04_97EB ; allowed to keep duplicates

    cmp #$3C ; Item ID #$3C: Medical Herb

    beq B04_97EB ; allowed to keep duplicates

    lda #$00 ; otherwise, not allowed to keep the dropped item :(

    sta $A4
    beq B04_97F2
; control flow target (from $982A)
B04_9864:
    asl $06E6
    rol $06EC
; control flow target (from $9781, $97AD, $9837, $9847)
B04_986A:
    lda $06E6
    sta $99
    lda $06EC
    sta $9A
    ora $99
    beq B04_98CE
    lsr $9A
    ror $99
    lsr $9A
    ror $99
; call to code in a different bank ($0F:$C3AB)
    jsr $C3AB ; generate a random number and store it in $32-$33 (two passes)

    lda $32 ; RNG byte 0

    sta $9B
    jsr $A05B ; 16-bit multiplication: ($99-$9A) = ($99-$9A) * ($9B), overflow in $9E, copy of ($99-$9A) in ($A1-$9D)

    lda $06E6
    sec
    sbc $9D
    sta $99
    lda $06EC
    sbc $9E
    sta $9A
    lda $99
    clc
    adc $0624 ; party gold, low byte

    sta $0624 ; party gold, low byte

    lda $9A
    adc $0625 ; party gold, high byte

    bcc B04_98AE ; if adding gold did not overflow the 16-bit storage, then just save the new high byte

    lda #$FF ; otherwise set both bytes to #$FF i.e. 65535 G

    sta $0624 ; party gold, low byte

; control flow target (from $98A7)
B04_98AE:
    sta $0625 ; party gold, high byte

    lda $99 ; store received gold to $8F-$90 so we can print it later

    sta $8F
    lda $9A
    sta $90
    lda $61B0 ; flag for whether you get an item drop or not

    bne B04_98C9 ; if you get an item drop, go deal with that

    lda #$8B ; String ID #$008B: [no voice]and earned [number] piece[(s)] of gold.[end-FC]

    jsr $9CEA ; set return bank $94 to #$04

; call to code in a different bank ($0F:$FA4A)
    jsr $FA4A ; display string ID specified by A

    jmp $98CE

; control flow target (from $98BC)
B04_98C9:
    lda #$48 ; String ID #$0048: And earned [number] piece[(s)] of gold.[end-FC]

    jsr $9CCA ; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0

; control flow target (from $9876, $98C6)
B04_98CE:
    lda #$00
    sta $C7
; control flow target (from $993B)
B04_98D2:
    jsr $9EE4 ; given an index (in A) into the array of hero data structures at $062D, set $B9-$BA to the address of the corresponding item inside that structure

    ldy #$06
; control flow target (from $98DF)
B04_98D7:
    lda ($B9),Y
    sta $0620,Y ; monster group 3 monster ID

    iny
    cpy #$09
    bcc B04_98D7
; control flow target (from $9932)
    ldx $C7
    jsr $9D43 ; given hero ID in X and hero's current EXP in $0626-$0628, set $8F-$90 to EXP required to reach next level; return current level in A

    sta $C8
    ldy #$11
    lda ($B9),Y
    cmp $C8
    bcs B04_9935
    ldx $C7
    tay
    iny
    tya
    jsr $9DC8 ; calculate hero X stats for level A

    lda #$08 ; Music ID #$08: level up BGM

; call to code in a different bank ($0F:$C561)
    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    lda $C7
    jsr $9CD0 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

; call to code in a different bank ($0F:$C595)
    jsr $C595
    lda #$47 ; String ID #$0047: [wait]Wit and courage have served thee well, for [name] has been promoted to the next level.[end-FC]

    jsr $9CCA ; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0

    jsr $9AAC
    ldy #$4A
    sty $C5
; control flow target (from $9927)
B04_9911:
    lda $0059,Y ; menu ID

    beq B04_9921
    sta $8F
    lda #$00
    sta $90
    lda $C5 ; String IDs #$004A-#$004D: "[wait]Power increases by [number].[end-FC]", "[wait]Reaction Speed increases by [number].[end-FC]", "[wait]Maximum HP increases by [number].[end-FC]", "[wait]Maximum MP increases by [number].[end-FC]"

    jsr $9CCA ; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0

; control flow target (from $9914)
B04_9921:
    inc $C5
    ldy $C5
    cpy #$4E
    bcc B04_9911
    lda $B3
    beq B04_9932
    lda #$4E ; String ID #$004E: [wait]And [name] learned one new spell.[end-FC]

    jsr $9CCA ; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0

; control flow target (from $992B)
B04_9932:
    jmp $98E1

; control flow target (from $98EE)
B04_9935:
    inc $C7
    lda $C7
    cmp #$03
    bcc B04_98D2
    jsr $9CEA ; set return bank $94 to #$04

; call to code in a different bank ($0F:$F642)
    jsr $F642 ; display appropriate battle EXP + Gold menu

    jmp $9A58

; determine max possible inventory offset based on current party
; control flow target (from $9772)
    lda $063F ; Cannock status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    and #$04 ; pick out Cannock's In Party bit

    beq B04_995C ; branch if Cannock not in party yet

    lda $0651 ; Moonbrooke status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    and #$04 ; pick out Moonbrooke's In Party bit

    beq B04_9958 ; branch if Moonbrooke not in party yet

    ldx #$18 ; otherwise the gang's all together and you have a full 24 inventory slots

    bne B04_995E
; control flow target (from $9952)
B04_9958:
    ldx #$10 ; if it's just the boys, you have 16 inventory slots

    bne B04_995E
; control flow target (from $994B)
B04_995C:
    ldx #$08 ; if Midenhall's alone, you only have 8 slots

; control flow target (from $9956, $995A)
B04_995E:
    stx $A3 ; max possible inventory offset based on current party

    rts

; control flow target (from $9550)
    jsr $9AD6
    jsr $9A84
    cmp #$01
    bne B04_997B
    tya
    jsr $9EEE ; given an index (in A) into the array of structures at $0663, set $B5-$B6 to the address of the corresponding item inside that structure

    ldy #$00
    lda ($B5),Y
; control flow target (from $997D)
B04_9973:
    ldx #$00
    sta $0160 ; ID of only monster (/monster group) or #$53 for "Enemies" if there are multiple groups

    jmp $9CD6 ; write monster name in A (+ monster number within its group in X, if > 0) to $6119


; control flow target (from $9969)
B04_997B:
    lda #$53
    bne B04_9973
; control flow target (from $9566, $9595)
    lda #$01
    jsr $9EE4 ; given an index (in A) into the array of hero data structures at $062D, set $B9-$BA to the address of the corresponding item inside that structure

    ldy #$00
    lda ($B9),Y
    and #$04
    beq B04_998E
    lda #$80
; control flow target (from $998A)
B04_998E:
    jmp $9CD0 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA


; control flow target (from $96BB)
    lda $05FE ; number of monsters in current group killed by last attack?

    beq B04_99CB
    sta $9B
    lda $0626 ; EXP earned this battle or current hero's current EXP, byte 0

    sta $99
    lda $0627 ; EXP earned this battle or current hero's current EXP, byte 1

    sta $9A
    ora $99
    beq B04_99E5
    jsr $A05B ; 16-bit multiplication: ($99-$9A) = ($99-$9A) * ($9B), overflow in $9E, copy of ($99-$9A) in ($A1-$9D)

    lda #$0A
    sta $9B
    lda #$00
    sta $9C
    jsr $A0A2
    inc $99
    bne B04_99BA
    inc $9A
; control flow target (from $99B6)
B04_99BA:
    lda $0626 ; EXP earned this battle or current hero's current EXP, byte 0

    clc
    adc $99
    sta $0626 ; EXP earned this battle or current hero's current EXP, byte 0

    lda $0627 ; EXP earned this battle or current hero's current EXP, byte 1

    adc $9A
    sta $0627 ; EXP earned this battle or current hero's current EXP, byte 1

; control flow target (from $9994)
B04_99CB:
    lda $0627 ; EXP earned this battle or current hero's current EXP, byte 1

    cmp #$27
    bcc B04_99E5
    bne B04_99DB
    lda $0626 ; EXP earned this battle or current hero's current EXP, byte 0

    cmp #$10
    bcc B04_99E5
; control flow target (from $99D2)
B04_99DB:
    lda #$0F
    sta $0626 ; EXP earned this battle or current hero's current EXP, byte 0

    lda #$27
    sta $0627 ; EXP earned this battle or current hero's current EXP, byte 1

; control flow target (from $99A4, $99D0, $99D9)
B04_99E5:
    rts

; control flow target (from $8012, $9B3F, $9B81, $9BA8, $A179)
    lda $8E ; flag for in battle or not (#$FF)?

    bpl B04_9A1F
; control flow target (from $9737)
    lda $062C ; current battle message delay

    cmp #$FF ; is it SLOW?

    bne B04_9A13
; control flow target (from $99FF, $9A09)
B04_99F1:
    jsr $9A4D ; read joypad 1 data into $2F; if no button pressed, set $015D to #$00

    lda $015D
    beq B04_9A03 ; branch if no button pressed

; call to code in a different bank ($0F:$C1DC)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    dec $015D
    bne B04_99F1
    beq B04_9A06
; control flow target (from $99F7)
B04_9A03:
    jsr $9A20 ; write either [space] or [down triangle] to PPU $2358 based on the current value of $03

; control flow target (from $9A01)
B04_9A06:
    lda $2F ; joypad 1 data

    ror ; set C to "A" button status

    bcc B04_99F1
    lda #$32
    sta $015D
    jmp $9A2A ; write [space] to PPU $2358


; control flow target (from $99EF, $9A4B)
; call to code in a different bank ($0F:$C1F5)
B04_9A13:
    jsr $C1F5 ; wait for battle message delay to expire

; set number of NMIs to wait for to current battle message delay if current battle message delay is not SLOW
; control flow target (from $94BC, $95FF, $9AE7)
    lda $062C ; current battle message delay

    cmp #$FF ; is it SLOW?

    beq B04_9A1F ; if yes, leave number of NMIs to wait for alone, otherwise set number of NMIs to wait for to battle message delay

    sta $93 ; NMI counter, decremented once per NMI until it reaches 0

; control flow target (from $99E8, $9A1B)
B04_9A1F:
    rts

; write either [space] or [down triangle] to PPU $2358 based on the current value of $03
; control flow target (from $9A03)
    lda $03 ; game clock?

    and #$18
    beq B04_9A2A ; write [space] to PPU $2358

    lda #$73 ; Tile ID #$73: [down triangle]

    bne B04_9A2C
; write [space] to PPU $2358
; control flow target (from $9A10, $9A24)
B04_9A2A:
    lda #$5F ; Tile ID #$5F: [space]

; control flow target (from $9A28)
B04_9A2C:
    sta $09 ; tile ID to write to PPU

    lda #$58
    sta $07 ; current PPU write address, low byte; PPU address, low byte

    lda #$23
    sta $08 ; current PPU write address, high byte; PPU address, high byte

; call to code in a different bank ($0F:$C1FA)
    jsr $C1FA ; wait for $02 to not be #$C0, write PPU address in $07-$08 and data in $09 to PPU write buffer at $0300,$02, $01 += 1, $02 += 3, and set $0183 to #$00

; call to code in a different bank ($0F:$C1DC)
    jmp $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF


; set number of NMIs to wait for to current battle message delay * 1.5 if current battle message delay is < #$80, #$64 otherwise
; control flow target (from $954D, $9574, $9582, $95D2, $95DD, $9696, $9734, $9765, $B3C2, $B49B)
    lda $062C ; current battle message delay

    bpl B04_9A45 ; only SLOW sets bit 7

    lda #$64 ; for SLOW, use #$64

    bne B04_9A49
; control flow target (from $9A3F)
B04_9A45:
    lsr ; otherwise use current # of frames * 1.5 (i.e. #$3C [60] or #$69 [105])

    adc $062C ; current battle message delay

; control flow target (from $9A43)
B04_9A49:
    sta $93 ; NMI counter, decremented once per NMI until it reaches 0

    bne B04_9A13 ; branch always taken

; read joypad 1 data into $2F; if no button pressed, set $015D to #$00

; control flow target (from $99F1, $9A5D)
; call to code in a different bank ($0F:$C476)
    jsr $C476 ; read joypad 1 data into $2F

    lda $2F ; joypad 1 data

    bne B04_9A57
    sta $015D ; #$00

; control flow target (from $9A52)
B04_9A57:
    rts

; control flow target (from $96B8, $9943)
    lda #$01
    sta $015D
; control flow target (from $9A67, $9A6B)
B04_9A5D:
    jsr $9A4D ; read joypad 1 data into $2F; if no button pressed, set $015D to #$00

    and #$F0
    bne B04_9A6D
    lda $015D
    bne B04_9A5D
    lda $2F ; joypad 1 data

    beq B04_9A5D
; control flow target (from $9A62)
B04_9A6D:
    lda $4017 ; Joypad #2/SOFTCLK (READ: #$80: Vertical Clock Signal (External), #$40: Vertical Clock Signal (Internal), #$10: Zapper Trigger Not Pulled, #$08: Zapper Sprite Detection, #$01: Joypad Data; WRITE: #$01: set Expansion Port Method to Read)

    ror
    bcc B04_9A83
    lda $16 ; current map X-pos (1)

    cmp #$EB
    bne B04_9A83
    clc
    adc $31 ; current map ID

    adc $17 ; current map Y-pos (1)

    bne B04_9A83
    inc $062C ; current battle message delay

; control flow target (from $9A71, $9A77, $9A7E)
B04_9A83:
    rts

; control flow target (from $9964, $A73E, $AA64)
    ldx #$00
    stx $C7
; control flow target (from $9A99)
B04_9A88:
    txa
    jsr $9ED2 ; given an index (in A) into the array of structures at $0663, set $BF-$C0 to the address of the corresponding item inside that structure

    ldy #$09
    lda ($BF),Y
    beq B04_9A96
    inc $C7
    stx $C8
; control flow target (from $9A90)
B04_9A96:
    inx
    cpx #$04
    bcc B04_9A88
    ldy $C8
    lda $C7
    rts

; control flow target (from $956E, $95D5, $B38F)
    lda #$32
    sta $062F ; Midenhall Battle Command

    sta $0641 ; Cannock Battle Command

    sta $0653 ; Moonbrooke Battle Command

    rts

; control flow target (from $94DF, $990A, $9BA1, $A1D2)
    jsr $9CEA ; set return bank $94 to #$04

    lda #$01 ; Menu ID #$01: Mini status window, top

; call to code in a different bank ($0F:$EB89)
    jmp $EB89 ; open menu specified by A


; control flow target (from $94E2, $B392, $B3BA, $B3ED, $B48D, $B4F7)
    jsr $9AC7
    lda $B3
    and #$80
    ora #$0F
    sta $B3
; control flow target (from $9699, $973A)
    jsr $9CEA ; set return bank $94 to #$04

    lda #$04 ; Menu ID #$04: Dialogue window

; call to code in a different bank ($0F:$EB89)
    jmp $EB89 ; open menu specified by A


; control flow target (from $9AB4, $B32C)
    jsr $9CEA ; set return bank $94 to #$04

    lda #$04
; control flow target (from $9AD4)
; call to code in a different bank ($0F:$F78C)
B04_9ACC:
    jmp $F78C ; wipe selected menu region


    jsr $9CEA ; set return bank $94 to #$04

    lda #$06
    bne B04_9ACC
; control flow target (from $9577, $95E0, $9961, $9AF8, $A168)
    jsr $9CEA ; set return bank $94 to #$04

    lda #$0F
; call to code in a different bank ($0F:$FBFF)
    jmp $FBFF

; STA $B4, $B3 |= #$20
; control flow target (from $A61E, $A69A, $AA22, $AEF6)
    sta $B4
    lda $B3
    ora #$20
    sta $B3
    rts

; control flow target (from $9CE2, $9CE7, $A24B, $A3A6, $A683, $A747, $AF7E)
    jsr $9A16 ; set number of NMIs to wait for to current battle message delay if current battle message delay is not SLOW

    lda #$FF
    sta $0176
    jsr $9CEA ; set return bank $94 to #$04

    lda $B3
    and #$10
    bne B04_9B42
    jsr $9AD6
    lda $AB
    sta $99
    lda $AC
    sta $9A
    lda $AD
    cmp #$E0
    bcc B04_9B0F
    and #$1F
    sta $95 ; ID for [item] and [spell] control codes

    lda #$1A ; String ID #$001A: [name] chanted the spell of [spell].[end-FC]

; control flow target (from $9B07)
B04_9B0F:
    sta $9B
    jsr $9BB8
    ldx $9C
    dex
    bne B04_9B1B
    lda #$1F
; control flow target (from $9B17)
B04_9B1B:
    dex
    bne B04_9B20
    lda #$1E
; control flow target (from $9B1C)
B04_9B20:
    dex
    bne B04_9B25
    lda #$1C
; control flow target (from $9B21)
B04_9B25:
    dex
    bne B04_9B2A
    lda #$18
; control flow target (from $9B26)
B04_9B2A:
    sta $99
    lda $B3
    and #$F0
    ora $99
    sta $B3
    and #$40
    beq B04_9B3F
    lda $B3
    and #$BF
    jmp $9B9F

; control flow target (from $9B36)
B04_9B3F:
    jsr $99E6
; control flow target (from $9AF6)
B04_9B42:
    lda $B3
    and #$0F
; call to code in a different bank ($0F:$FBFF)
    jsr $FBFF
    lda $B3
    and #$20
    beq B04_9B84
    lda $B4
    cmp #$0D
    beq B04_9B5F
    cmp #$0E
    beq B04_9B5F
    cmp #$07
    beq B04_9B67
    bne B04_9B7C
; control flow target (from $9B53, $9B57)
B04_9B5F:
    lda #$88 ; Music ID #$88: critical hit SFX

; call to code in a different bank ($0F:$C561)
    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    jmp $9B7C

; control flow target (from $9B5B)
B04_9B67:
    lda $AB
    bmi B04_9B6F
    lda #$8D ; Music ID #$8D: miss 2 SFX

    bne B04_9B71
; control flow target (from $9B69)
B04_9B6F:
    lda #$8C ; Music ID #$8C: miss 1 SFX

; control flow target (from $9B6D)
; call to code in a different bank ($0F:$C561)
B04_9B71:
    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    lda $B4
    jsr $9CCA ; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0

    jmp $9B84

; control flow target (from $9B5D, $9B64)
B04_9B7C:
    lda $B4
    jsr $9CCA ; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0

    jsr $99E6
; control flow target (from $9B4D, $9B79)
B04_9B84:
    lda $B0
    sta $8F
    lda $B1
    sta $90
    lda $AE
    sta $99
    lda $AF
    sta $9A
    lda $B2
    sta $9B
    jsr $9BB8
    lda $B3
    and #$DF
; control flow target (from $9B3C)
    sta $B3
    jsr $9AAC
    lda $98 ; outcome of last fight?

    bne B04_9BAB
    jsr $99E6
; control flow target (from $9BA6)
B04_9BAB:
    rts

; control flow target (from $9BF9)
    ldy #$03
; control flow target (from $9BB4)
B04_9BAE:
    cmp $0172,Y
    beq B04_9BB7
    dey
    bpl B04_9BAE
    clc
; control flow target (from $9BB1)
B04_9BB7:
    rts

; control flow target (from $9B11, $9B98)
    lda $99
    cmp #$F0
    bcc B04_9BC6
    eor #$FF
    jsr $9CD0 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    jmp $9C4D ; if $9B < #$60, display string ID specified by $9B, otherwise display string ID specified by $9B + #$A0; play extra SFX


; control flow target (from $9BBC)
B04_9BC6:
    lda $9A
    ldx #$00
    and #$30
    beq B04_9BDE
    cmp #$20
    bcc B04_9BDC
    beq B04_9BD8
    ldx #$21
    bne B04_9BDE
; control flow target (from $9BD2)
B04_9BD8:
    ldx #$16
    bne B04_9BDE
; control flow target (from $9BD0)
B04_9BDC:
    ldx #$0B
; control flow target (from $9BCC, $9BD6, $9BDA)
B04_9BDE:
    lda $9A
    and #$0F
    beq B04_9BF6
    sta $9F
    txa
    clc
    adc $9F
    tax
    lda $0663,X ; monster ID, group 1

    and #$07
    sta $9F
    tax
    lda $016A,X
; control flow target (from $9BE2)
B04_9BF6:
    tax
    lda $99
    jsr $9BAC
    bcc B04_9C08
    ldy $9B
    cpy #$19
    beq B04_9C08
    cpy #$24
    bne B04_9C0A
; control flow target (from $9BFC, $9C02)
B04_9C08:
    ldx #$00
; control flow target (from $9C06)
B04_9C0A:
    jsr $9CD6 ; write monster name in A (+ monster number within its group in X, if > 0) to $6119

    jsr $9CBC ; if $9B < #$60, display string ID specified by $9B, otherwise display string ID specified by $9B + #$A0

    lda $9A
    and #$30
    lsr
    lsr
    lsr
    lsr
    tax
    lda $9A
    and #$0F
    tay
    lda $9B
    cmp #$06
    beq B04_9C82
    cmp #$0B
    beq B04_9C87
    cmp #$0F
    beq B04_9C8A
    cmp #$19
    beq B04_9C8F
    cmp #$24
    beq B04_9C8F
    cmp #$26
    beq B04_9C8F
    cmp #$15
    beq B04_9CA3
    cmp #$2C
    beq B04_9CA3
    cmp #$1A
    beq B04_9C9B
    cmp #$33
    beq B04_9C7A
    cmp #$0A
    beq B04_9C76
    rts

; if $9B < #$60, display string ID specified by $9B, otherwise display string ID specified by $9B + #$A0; play extra SFX
; control flow target (from $9BC3)
    jsr $9CBC ; if $9B < #$60, display string ID specified by $9B, otherwise display string ID specified by $9B + #$A0

    lda $9B
    cmp #$06
    beq B04_9C7E
    cmp #$0C
    beq B04_9CA6
    cmp #$2F
    beq B04_9CA6
    cmp #$30
    beq B04_9CA6
    cmp #$1A
    beq B04_9C9B
    cmp #$0A
    beq B04_9C72
    cmp #$17
    beq B04_9C6F
    rts

; control flow target (from $9C6C)
B04_9C6F:
    jmp $A0F1

; control flow target (from $9C68)
B04_9C72:
    lda #$8D ; Music ID #$8D: miss 2 SFX

    bne B04_9C84
; control flow target (from $9C4A)
B04_9C76:
    lda #$8C ; Music ID #$8C: miss 1 SFX

    bne B04_9C84
; control flow target (from $9C46)
B04_9C7A:
    lda #$94 ; Music ID #$94: burning SFX

    bne B04_9C84
; control flow target (from $9C54)
B04_9C7E:
    lda #$89 ; Music ID #$89: attack 1 SFX

    bne B04_9C84
; control flow target (from $9C22)
B04_9C82:
    lda #$8B ; Music ID #$8B: attack 2 SFX

; control flow target (from $9C74, $9C78, $9C7C, $9C80)
; call to code in a different bank ($0F:$C561)
B04_9C84:
    jmp $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])


; control flow target (from $9C26)
B04_9C87:
    jmp $8AB0

; control flow target (from $9C2A)
B04_9C8A:
    lda #$83 ; Music ID #$83: flee SFX

    jsr $9CAC ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM]); preserves X/Y

; control flow target (from $9C2E, $9C32, $9C36)
B04_9C8F:
    jsr $8AF1
    lda $9F
    tax
    lda #$FF
    sta $0162,X
    rts

; control flow target (from $9C42, $9C64)
B04_9C9B:
    lda #$90 ; Music ID #$90: casting SFX

; call to code in a different bank ($0F:$C561)
    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

; call to code in a different bank ($0F:$C515)
    jmp $C515 ; flash screen 10 times


; control flow target (from $9C3A, $9C3E)
B04_9CA3:
    jmp $8A9E

; control flow target (from $9C58, $9C5C, $9C60)
B04_9CA6:
    jsr $A0F1
    jmp $8FE2

; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM]); preserves X/Y
; control flow target (from $9C8C)
    sta $9D
    txa
    pha
    tya
    pha
    lda $9D
; call to code in a different bank ($0F:$C561)
    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    pla
    tay
    pla
    tax
    rts

; if $9B < #$60, display string ID specified by $9B, otherwise display string ID specified by $9B + #$A0
; control flow target (from $9C0D, $9C4D)
    lda $9B
; if A < #$60, display string ID specified by A, otherwise display string ID specified by A + #$A0
; control flow target (from $9CCD)
    cmp #$60
    bcc B04_9CC7 ; display string ID specified by A

    sbc #$60
; call to code in a different bank ($0F:$FA4E)
    jmp $FA4E ; display string ID specified by A + #$0100


; display string ID specified by A
; control flow target (from $9CC0)
; call to code in a different bank ($0F:$FA4A)
B04_9CC7:
    jmp $FA4A ; display string ID specified by A


; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0
; control flow target (from $952F, $9540, $9563, $956B, $957F, $959F, $95DA, $96B5, $974C, $976A, $9806, $9825, $9830, $9844, $98CB, $9907, $991E, $992F, $9B76, $9B7E, $B3BF, $B498)
    jsr $9CEA ; set return bank $94 to #$04

    jmp $9CBE ; if A < #$60, display string ID specified by A, otherwise display string ID specified by A + #$A0


; print name of hero given by low 2 bits of A to $6119, terminated by #$FA
; control flow target (from $96B0, $9820, $983B, $98FF, $998E, $9BC0, $B493)
    jsr $9CEA ; set return bank $94 to #$04

; call to code in a different bank ($0F:$FC50)
    jmp $FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA


; write monster name in A (+ monster number within its group in X, if > 0) to $6119
; control flow target (from $9518, $9747, $9801, $9978, $9C0A)
    jsr $9CEA ; set return bank $94 to #$04

; call to code in a different bank ($0F:$FC89)
    jmp $FC89 ; write monster name in A (+ monster number within its group in X, if > 0) to $6119


; control flow target (from $9647, $A12B, $A149, $A4D7, $A8CB, $AA4E, $AA6D)
    lda $B3
    ora #$40
    sta $B3
    jmp $9AE7

; control flow target (from $A160, $A1DE, $A261, $A342, $A36C, $A44D, $A564, $A673, $A9FC, $AB64, $AC49, $ACB5, $ACF1, $AD1A, $AD2A, $AD5B, $ADCB, $AE12, $AE6A, $AE86, $AEFB)
    sta $B2
    jmp $9AE7

; set return bank $94 to #$04
; control flow target (from $98C0, $993D, $9AAC, $9ABF, $9AC7, $9ACF, $9AD6, $9AEF, $9CCA, $9CD0, $9CD6)
    pha
    lda #$04
    sta $94 ; return bank for various function calls, doubles as index of selected option for multiple-choice menus

    pla
    rts

; set $8F-$90 to EXP required to reach next level
; control flow target (from $800C)
    sta $A7
    jsr $9EE4 ; given an index (in A) into the array of hero data structures at $062D, set $B9-$BA to the address of the corresponding item inside that structure

    ldy #$06 ; offset into hero data for current EXP byte 0

    lda ($B9),Y
    sta $0626 ; EXP earned this battle or current hero's current EXP, byte 0

    iny
    lda ($B9),Y
    sta $0627 ; EXP earned this battle or current hero's current EXP, byte 1

    iny
    lda ($B9),Y
    sta $0628 ; EXP earned this battle or current hero's current EXP, byte 2

    ldx $A7
    jmp $9D43 ; given hero ID in X and hero's current EXP in $0626-$0628, set $8F-$90 to EXP required to reach next level; return current level in A


; update each hero's stats based on their current EXP
; control flow target (from $8009)
    lda #$00 ; Midenhall

    sta $06DF ; hero ID

; control flow target (from $9D3D)
B04_9D13:
    jsr $9EE4 ; given an index (in A) into the array of hero data structures at $062D, set $B9-$BA to the address of the corresponding item inside that structure

    ldy #$06 ; offset into hero data for current EXP byte 0

    lda ($B9),Y
    sta $0626 ; EXP earned this battle or current hero's current EXP, byte 0

    iny
    lda ($B9),Y
    sta $0627 ; EXP earned this battle or current hero's current EXP, byte 1

    iny
    lda ($B9),Y
    sta $0628 ; EXP earned this battle or current hero's current EXP, byte 2

    ldx $06DF ; hero ID

    jsr $9D43 ; given hero ID in X and hero's current EXP in $0626-$0628, set $8F-$90 to EXP required to reach next level; return current level in A

    ldx $06DF ; hero ID

    jsr $9DC8 ; calculate hero X stats for level A

    inc $06DF ; hero ID

    lda $06DF
; 3 heroes total
    cmp #$03
    bcc B04_9D13
    rts


; code -> data
; per-hero offsets into required EXP lists
; indexed data load target (from $9D43)

.byte $00,$62
.byte $BA
; data -> code
; given hero ID in X and hero's current EXP in $0626-$0628, set $8F-$90 to EXP required to reach next level; return current level in A
; control flow target (from $98E3, $9D0B, $9D2C)
    lda $9D40,X ; per-hero offsets into required EXP lists

    tax
    lda #$00
    sta $0629 ; current hero's required EXP, byte 0

    sta $062A ; current hero's required EXP, byte 1

    sta $062B ; current hero's required EXP, byte 2

    lda #$01
    sta $A7 ; start at level 1

; control flow target (from $9DAB)
    ldy #$00 ; normally byte 2 of the required EXP is #$00...

    cpx #$F2 ; i.e. $BDB5, a.k.a. start of Moonbrooke's level 30 EXP

    bcc B04_9D5E
    ldy #$01 ; ... but Moonbrooke's level 30+ each take an extra 65536 EXP that isn't contained in the (2 byte per level) required EXP table

; control flow target (from $9D5A)
B04_9D5E:
    lda $BCC3,X ; EXP per level, low byte

    cmp $BCC4,X ; EXP per level, high byte

    beq B04_9DC2 ; hero at max level; write 0 EXP remaining until next level to $8F-$90; but low byte is never equal to high byte, so this is pointless; would make sense if e.g. list was terminated with #$00 #$00

    clc
    adc $0629 ; current hero's required EXP, byte 0

    sta $0629 ; current hero's required EXP, byte 0

    lda $BCC4,X ; EXP per level, high byte

    adc $062A ; current hero's required EXP, byte 1

    sta $062A ; current hero's required EXP, byte 1

    tya
    adc $062B ; current hero's required EXP, byte 2

    sta $062B ; current hero's required EXP, byte 2

    lda $062B ; current hero's required EXP, byte 2

    cmp $0628 ; EXP earned this battle or current hero's current EXP, byte 2

    bcc B04_9D9B ; required EXP < current EXP; increment level, check for end of list, loop to next level

    bne B04_9DAE ; required EXP > current EXP; write EXP remaining until next level to $8F-$90 (but what about Moonbrooke's extra 65536 EXP?)

    lda $062A ; current hero's required EXP, byte 1

    cmp $0627 ; EXP earned this battle or current hero's current EXP, byte 1

    bcc B04_9D9B ; required EXP < current EXP; increment level, check for end of list, loop to next level

    bne B04_9DAE ; required EXP > current EXP; write EXP remaining until next level to $8F-$90 (but what about Moonbrooke's extra 65536 EXP?)

    lda $0629 ; current hero's required EXP, byte 0

    cmp $0626 ; EXP earned this battle or current hero's current EXP, byte 0

    bcc B04_9D9B ; required EXP < current EXP; increment level, check for end of list, loop to next level

    bne B04_9DAE ; required EXP > current EXP; write EXP remaining until next level to $8F-$90 (but what about Moonbrooke's extra 65536 EXP?)

; required EXP < current EXP; increment level, check for end of list, loop to next level
; control flow target (from $9D83, $9D8D, $9D97)
B04_9D9B:
    inc $A7 ; move to next level

    inx ; 2 bytes of data per level

    inx
    cpx #$62 ; end of Midenhall's data

    beq B04_9DC2 ; hero at max level; write 0 EXP remaining until next level to $8F-$90

    cpx #$BA ; end of Cannock's data

    beq B04_9DC2 ; hero at max level; write 0 EXP remaining until next level to $8F-$90

    cpx #$FE ; end of Moonbrooke's data

    beq B04_9DC2 ; hero at max level; write 0 EXP remaining until next level to $8F-$90

    jmp $9D56 ; loop to calculate next level


; required EXP > current EXP; write EXP remaining until next level to $8F-$90 (but what about Moonbrooke's extra 65536 EXP?)
; control flow target (from $9D85, $9D8F, $9D99)
B04_9DAE:
    lda $0629 ; current hero's required EXP, byte 0

    sec
    sbc $0626 ; EXP earned this battle or current hero's current EXP, byte 0

    sta $8F
    lda $062A ; current hero's required EXP, byte 1

    sbc $0627 ; EXP earned this battle or current hero's current EXP, byte 1

; control flow target (from $9DC6)
B04_9DBD:
    sta $90
    lda $A7
    rts

; hero at max level; write 0 EXP remaining until next level to $8F-$90
; control flow target (from $9D64, $9DA1, $9DA5, $9DA9)
B04_9DC2:
    lda #$00
    sta $8F
    beq B04_9DBD
; calculate hero X stats for level A
; control flow target (from $98F5, $9D32)
    sta $A7 ; level

    stx $A8 ; hero

    txa
    jsr $9EC8 ; given an index (in A) into the array of hero data structures at $062D, set $C3-$C4 to the address of the corresponding item inside that structure

    lda $A8 ; hero

    asl
    tax ; 4 level up stats are pack into 2 bytes

    asl
    tay ; starting stats are 1 per byte (since they can't fit into a nybble)

    lda #$01
    sta $A9 ; start calculating from level 1

    lda #$00
    sta $B3 ; # of spells learned this level (maybe just flag)

    lda $BDC1,Y ; starting STR

    sta $99
    lda $BDC2,Y ; starting AGI

    sta $9A
    lda $BDC3,Y ; starting Max HP

    sta $9B
    lda $BDC4,Y ; starting Max MP

    sta $9C
; control flow target (from $9E1E)
    lda $A9 ; current level

    cmp $A7 ; desired level

    bcs B04_9E21 ; if we've finished calculating up to the desired level, we're done with this loop

    ldy #$00 ; start with stat #$00 (STR)

    jsr $9E97 ; process high nybble of level up data

    lda $BDCD,X ; level up stat nybbles (STR/AGI, HP/MP)

    jsr $9E9E ; process low nybble of level up data

    inx ; move to next byte of level up data (Max HP/MP)

    jsr $9E97 ; process high nybble of level up data

    lda $BDCD,X ; level up stat nybbles (STR/AGI, HP/MP)

    jsr $9E9E ; process low nybble of level up data

    inc $A9 ; current level++

    lda $A9
    cmp #$2E ; only Midenhall has level up data for levels > 45, so in that case the next byte of level up data is his too

    bcs B04_9E1D
    cmp #$24 ; only Midenhall and Cannock have level up data for levels > 35, so in those cases we need to skip an extra 2 bytes for the other hero's data

    bcs B04_9E1B
    inx ; otherwise all 3 heroes have level up data, so skip over the data for the 2 other heroes

    inx
; control flow target (from $9E17)
B04_9E1B:
    inx
    inx
; control flow target (from $9E13)
B04_9E1D:
    inx
    jmp $9DF2 ; loop to calculate next level


; update hero stats and spell lists
; control flow target (from $9DF6)
B04_9E21:
    ldy #$11 ; offset into hero data for level

    lda $A7 ; current level

    sta ($C3),Y ; update hero's current level

    ldy #$09 ; offset for STR

    lda $99 ; current STR

    sta ($C3),Y ; update hero's current STR

    iny
    lda $9A ; current AGI

    sta ($C3),Y ; update hero's current AGI

    ldy #$03 ; offset for Max HP

    lda $9B ; Max HP

    sta ($C3),Y ; update hero's Max HP

    iny
    lda #$00
    sta ($C3),Y ; set high byte of Max HP to #$00

    iny
    lda $9C ; Max MP

    sta ($C3),Y ; update hero's Max MP

    lsr $9A ; AGI / 2 = hero's base DEF

    lda $A8 ; hero

    asl ; 8 inventory items per hero

    asl
    asl
    tax
    stx $A7
; loop through inventory items to update ATK/DEF
; control flow target (from $9E70)
B04_9E4C:
    lda $0600,X ; Midenhall inventory item 1 (| #$40 if equipped)

    ldy #$00 ; start index with ATK

    cmp #$41 ; equipped items have bit 6 set

    bcc B04_9E69 ; if not equipped, it doesn't count

    cmp #$51 ; there are #$10 weapons

    bcc B04_9E5E ; if it's an equipped weapon, go update stat

    iny ; update index to DEF

    cmp #$64 ; the last armour/shield/helmet ID is #$23

    bcs B04_9E69 ; if it's equipped but not a weapon/armour/shield/helmet, it doesn't count

; control flow target (from $9E57)
B04_9E5E:
    tax
    lda $BEAA,X ; base offset for equipment power list at $BEEB

    clc ; not needed since we only get here via taking BCC or not taking BCS, so C is known to be clear

    adc $0099,Y ; add current stat and equipment's power

    sta $0099,Y ; update current stat

; control flow target (from $9E53, $9E5C)
B04_9E69:
    inc $A7 ; update inventory index

    ldx $A7
    txa
    and #$07
    bne B04_9E4C ; if there's more inventory to check, loop to keep checking

    ldy #$0B ; offset into hero data for ATK

    lda $99 ; current ATK

    sta ($C3),Y ; update hero's current ATK

    ldy #$0C ; offset for DEF

    lda $9A ; current DEF

    sta ($C3),Y ; update hero's current DEF

    lda $A8 ; hero

    beq B04_9E96 ; if Midenhall, then done

    cmp #$02
    ldx #$00 ; Cannock's spell learning list offset

    bcc B04_9E8A ; if not Cannock, then Moonbrooke

    ldx #$10 ; Moonbrooke's spell learning list offset

; control flow target (from $9E86)
B04_9E8A:
    jsr $9EAC ; update learned spell list

    sta $0618,Y ; Cannock's learned battle spell list

    jsr $9EAC ; update learned spell list

    sta $061A,Y ; Cannock's learned field spell list

; control flow target (from $9E80)
B04_9E96:
    rts

; process high nybble of level up data
; control flow target (from $9DFA, $9E04)
    lda $BDCD,X ; level up stat nybbles (STR/AGI, HP/MP)

    ror ; shift high nybble down to low nybble

    ror
    ror
    ror
; process low nybble of level up data
; control flow target (from $9E00, $9E0A)
    and #$0F
    sta $00A3,Y ; stat gain for this level

    clc
    adc $0099,Y
    sta $0099,Y ; total stat amount

    iny ; set for next stat

    rts

; update learned spell list
; control flow target (from $9E8A, $9E90)
    lda $A9 ; current level

    ldy #$08 ; 8 spells per battle/field list

; control flow target (from $9EBB)
B04_9EB0:
    cmp $BECB,X ; levels for learning spells

    bne B04_9EB7
    dec $B3 ; update number of spells learned

; control flow target (from $9EB3)
B04_9EB7:
    rol $99 ; $99 morphs into learned spell list, 1 bit per spell

    inx ; increment spell list index

    dey ; decrement number of spells left to check

    bne B04_9EB0 ; if more spells to check, keep checking

    ldy $A8 ; hero

    dey ; Midenhall has no spell data

    lda $99 ; learned spell list

    rts

; given an index (in A) into the array of battle spell/item structures at $A7C0, set $C5-$C6 to the address of the corresponding item inside that structure
; control flow target (from $A192, $A92F)
    pha
    lda #$10
    bne B04_9EF1 ; given an index for the structure list at $9F21/$9F33 in A and an index (on the stack) into the corresponding structure, set the corresponding index of $B5,X to the address of the thing you want

; given an index (in A) into the array of hero data structures at $062D, set $C3-$C4 to the address of the corresponding item inside that structure
; control flow target (from $9DCD, $A3B3, $A3D5, $A402, $B3E2, $B448, $B455, $B5EB)
    pha
    lda #$0E
    bne B04_9EF1 ; given an index for the structure list at $9F21/$9F33 in A and an index (on the stack) into the corresponding structure, set the corresponding index of $B5,X to the address of the thing you want

; given an index (in A) into the array of structures at $068F, set $C1-$C2 to the address of the corresponding item inside that structure
; control flow target (from $A2EA, $AB73, $B27A)
    pha
    lda #$0C
    bne B04_9EF1 ; given an index for the structure list at $9F21/$9F33 in A and an index (on the stack) into the corresponding structure, set the corresponding index of $B5,X to the address of the thing you want

; given an index (in A) into the array of structures at $0663, set $BF-$C0 to the address of the corresponding item inside that structure
; control flow target (from $9A89, $AB83, $B273, $B57F, $B5BB)
    pha
    lda #$0A
    bne B04_9EF1 ; given an index for the structure list at $9F21/$9F33 in A and an index (on the stack) into the corresponding structure, set the corresponding index of $B5,X to the address of the thing you want

; given an index (in A) into the array of enemy special % structures at $B2F6, set $BD-$BE to the address of the corresponding item inside that structure
; control flow target (from $B07D)
    pha
    lda #$08
    bne B04_9EF1 ; given an index for the structure list at $9F21/$9F33 in A and an index (on the stack) into the corresponding structure, set the corresponding index of $B5,X to the address of the thing you want

; given an index + 1 (in A) into the array of enemy stat structures at $B7F5, set $BB-$BC to the address of the corresponding item inside that structure
; control flow target (from $A51A, $A6E7, $AB2C, $AB8A, $AC0A, $B163, $B1F3, $B618, $B70C)
    sec
    sbc #$01
    pha
    lda #$06
    bne B04_9EF1 ; given an index for the structure list at $9F21/$9F33 in A and an index (on the stack) into the corresponding structure, set the corresponding index of $B5,X to the address of the thing you want

; given an index (in A) into the array of hero data structures at $062D, set $B9-$BA to the address of the corresponding item inside that structure
; control flow target (from $9666, $96C2, $9810, $98D2, $9981, $9CF3, $9D13, $A0FF, $A49E, $A9C9, $AC8D, $AE6D, $AEAD, $B011, $B22F, $B316, $B686, $B6E2)
    pha
    lda #$04
    bne B04_9EF1 ; given an index for the structure list at $9F21/$9F33 in A and an index (on the stack) into the corresponding structure, set the corresponding index of $B5,X to the address of the thing you want

; given an index (in A) into the array of structures at $068F, set $B7-$B8 to the address of the corresponding item inside that structure
; control flow target (from $A511, $A6CE, $A964, $AB1C, $ABF6, $ADD3, $B170, $B1DE, $B630, $B671)
    pha
    lda #$02
    bne B04_9EF1 ; given an index for the structure list at $9F21/$9F33 in A and an index (on the stack) into the corresponding structure, set the corresponding index of $B5,X to the address of the thing you want

; given an index (in A) into the array of structures at $0663, set $B5-$B6 to the address of the corresponding item inside that structure
; control flow target (from $94EB, $9502, $965B, $996C, $A27D, $A4FB, $A8FD, $AB23, $ABDE, $AC01, $B15C, $B1EC, $B60E, $B705)
    pha
    lda #$00
; given an index for the structure list at $9F21/$9F33 in A and an index (on the stack) into the corresponding structure, set the corresponding index of $B5,X to the address of the thing you want
; control flow target (from $9EC6, $9ECB, $9ED0, $9ED5, $9EDA, $9EE2, $9EE7, $9EEC)
B04_9EF1:
    sta $99 ; index for $9F21/$9F33

    pla ; desired index into desired array

    pha ; desired index into desired array; save A

    sta $9B ; desired index into desired array

    txa ; save X

    pha
    ldx $99 ; index for $9F21/$9F33

    lda $9F33,X ; array record size low byte

    sta $99
    lda $9F34,X ; array record size high byte

    sta $9A
    jsr $A05B ; 16-bit multiplication: ($99-$9A) = ($99-$9A) * ($9B), overflow in $9E, copy of ($99-$9A) in ($A1-$9D)

; at this point, $99-$9A = record size * desired index into desired array = desired record's offset into the desired array
; next we'll add the desired array's base address
    lda $9F21,X ; base array address low byte

    sta $9B
    lda $9F22,X ; base array address high byte

    sta $9C
    jsr $A0CF ; 16-bit addition: ($99-$9A) = ($99-$9A) + ($9B-$9C)

; at this point, $99-$9A is the address of the thing we want to interact with, so save it to $B5,X-$B6-X for later use
    lda $99
    sta $B5,X
    lda $9A
    sta $B6,X
    pla ; restore X

    tax
    pla ; restore A

    rts


; code -> data
; base array address low byte
; indexed data load target (from $9F08)
; base array address high byte
.byte $63
; indexed data load target (from $9F0D)
; array record size low byte
.byte $06,$8F,$06,$2D,$06,$F5,$B7,$F6,$B2
.byte $63,$06,$8F,$06
.byte $2D,$06
.byte $C0
.byte $A7
; indexed data load target (from $9EFB)
; array record size high byte
.byte $0B
; indexed data load target (from $9F00)

.byte $00,$07,$00,$12,$00,$0F,$00,$07,$00
.byte $0B,$00,$07,$00
.byte $12,$00
.byte $05
.byte $00
; data -> code
; control flow target (from $A636)
    lsr $9C
    ror $9B
    jsr $A0E3 ; 16-bit subtraction: ($99-$9A) = ($99-$9A) - ($9B-$9C)

    bcc B04_9F67 ; generate a random number between $03 and #$02 in A and $99

    lda $99
    cmp #$02
    bcs B04_9F58
    lda $9A
    beq B04_9F67 ; generate a random number between $03 and #$02 in A and $99

; control flow target (from $9F52)
B04_9F58:
    jsr $9FFB ; set $9B to a random number tightly distributed around #$80 and $9C to #$00

    jsr $A05B ; 16-bit multiplication: ($99-$9A) = ($99-$9A) * ($9B), overflow in $9E, copy of ($99-$9A) in ($A1-$9D)

; control flow target (from $9FCF)
    lda $9D
    sta $99
    lda $9E
    sta $9A
    rts

; generate a random number between $03 and #$02 in A and $99
; control flow target (from $9F4C, $9F56, $9FEE)
B04_9F67:
    lda #$02
    jmp $A020 ; generate a random number between $03 and A in A and $99


; control flow target (from $B02E)
    lda $99
    sta $C7
    lda $9A
    sta $C8
    lsr $9C
    ror $9B
    lsr $C8
    ror $C7
    lsr $C8
    ror $C7
    lda $C7
    sta $BD
    lda $C8
    sta $BE
    jsr $A0E3 ; 16-bit subtraction: ($99-$9A) = ($99-$9A) - ($9B-$9C)

    bcc B04_9FAD
    lda $C8
    cmp $9A
    bcc B04_9FC9
    bne B04_9F9B
    lda $C7
    cmp $99
    bcc B04_9FC9
; control flow target (from $9F93)
B04_9F9B:
    lsr $C8
    ror $C7
    lda $C8
    cmp $9A
    bcc B04_9FBD
    bne B04_9FAD
    lda $C7
    cmp $99
    bcc B04_9FBD
; control flow target (from $9F8B, $9FA5)
B04_9FAD:
    lda #$02
; control flow target (from $9FBF)
B04_9FAF:
    jsr $A020 ; generate a random number between $03 and A in A and $99

    lda $99
    bne B04_9FC1
    lda #$00
    sta $99
    sta $9A
    rts

; control flow target (from $9FA3, $9FAB)
B04_9FBD:
    lda #$04
    bne B04_9FAF
; control flow target (from $9FB4)
B04_9FC1:
    lda $BD
    sta $99
    lda $BE
    sta $9A
; control flow target (from $9F91, $9F99)
B04_9FC9:
    jsr $9FFB ; set $9B to a random number tightly distributed around #$80 and $9C to #$00

    jsr $A05B ; 16-bit multiplication: ($99-$9A) = ($99-$9A) * ($9B), overflow in $9E, copy of ($99-$9A) in ($A1-$9D)

    jsr $9F5E
    lsr $9E
    ror $9D
    lsr $9E
    ror $9D
    lda $99
    sec
    sbc $9D
    sta $99
    lda $9A
    sbc $9E
    sta $9A
    lda $9A
    ora $99
    beq B04_9FEE
    rts

; control flow target (from $9FEB)
B04_9FEE:
    jmp $9F67 ; generate a random number between $03 and #$02 in A and $99


; set $9B to a random number tightly distributed around #$80 and $9C to #$00
    lda #$1F
    sta $9F
    lda #$08
    sta $9B
    bne B04_A003
; set $9B to a random number tightly distributed around #$80 and $9C to #$00
; control flow target (from $9F58, $9FC9, $AE92)
    lda #$0F ; sum up random 4-bit numbers

    sta $9F
; WARNING! $9FFF was also seen as data
    lda #$88
    sta $9B
; control flow target (from $9FF9)
B04_A003:
    ldx #$10 ; 16 loops of summing random N-bit number

; control flow target (from $A012)
; call to code in a different bank ($0F:$C3AB)
B04_A005:
    jsr $C3AB ; generate a random number and store it in $32-$33 (two passes)

    lda $32 ; RNG byte 0

    and $9F
    clc
    adc $9B
    sta $9B
    dex
    bne B04_A005
    lda $9B
    sec
    sbc #$80
    sta $9B
    lda #$00
    sta $9C
    rts

; generate a random number between $03 and A in A and $99
; control flow target (from $9555, $95C6, $9F69, $9FAF, $A118, $A287, $A292, $A4C3, $A602, $A609, $A64B, $A668, $A760, $A8B5, $A8D8, $A8EF, $A9D9, $AA2A, $ADBC, $AE24, $AFF7, $B001, $B009, $B2E0, $B42F, $B436, $B443)
    sta $99
    cmp #$00
    beq B04_A05A
    txa
    pha
    tya
    pha
    lda #$00
    sta $9A
    sta $9F
    lda $03 ; game clock?

    sta $A0
    lda $99
    ldy #$09
; control flow target (from $A03C)
B04_A038:
    dey
    beq B04_A044
    asl
    bcc B04_A038
; control flow target (from $A042)
B04_A03E:
    sec
    rol $9F
    dey
    bne B04_A03E
; control flow target (from $A039, $A050)
; call to code in a different bank ($0F:$C3AB)
B04_A044:
    jsr $C3AB ; generate a random number and store it in $32-$33 (two passes)

    lda $32 ; RNG byte 0

    clc
    adc $A0
    and $9F
    cmp $99
    bcs B04_A044
    sta $99
    pla
    tay
    pla
    tax
    lda $99
; control flow target (from $A024)
B04_A05A:
    rts

; 16-bit multiplication: ($99-$9A) = ($99-$9A) * ($9B), overflow in $9E, copy of ($99-$9A) in ($A1-$9D)
; control flow target (from $9887, $99A6, $9F05, $9F5B, $9FCC, $B6C8)
    lda #$00
    sta $9C
; 16-bit multiplication: ($99-$9A) = ($99-$9A) * ($9B-$9C), overflow in $9E, copy of ($99-$9A) in ($A1-$9D)
; control flow target (from $AE95, $B03E)
    lda #$00 ; initialize vars to #$00

    sta $9D ; result byte 1

    sta $9E ; result byte 2

    sta $A1 ; result byte 0

    sta $A2 ; multiplicand byte 2

    lda $9B ; original multiplicant byte 0

    sta $9F ; current multiplicand byte 0

    lda $9C ; original multiplicand byte 1

    sta $A0 ; current multiplicand byte 1

; control flow target (from $A096)
    lda $99 ; multiplier low byte

    ora $9A ; multiplier high byte

    beq B04_A099 ; if multiplier == 0, copy results to $99-$9A and RTS

    lsr $9A ; LSR 16-bit multiplier

    ror $99
    bcc B04_A090 ; check low bit of multiplier

    lda $9F ; current multiplicand byte 0

    clc
    adc $A1
    sta $A1 ; result byte 0 += current multiplicand byte 0

    lda $A0
    adc $9D
    sta $9D ; result byte 1 += current multiplicand byte 1 + carry from byte 0

    lda $A2
    adc $9E
    sta $9E ; result byte 2 += current multiplicand byte 2 + carry from byte 1

; control flow target (from $A07B)
B04_A090:
    asl $9F ; ASL 24-bit multiplicand

    rol $A0
    rol $A2
    jmp $A071 ; loop to process next bit


; control flow target (from $A075)
B04_A099:
    lda $A1 ; result byte 0

    sta $99
    lda $9D ; result byte 1

    sta $9A
    rts ; overflow is still sitting in $9E if anybody wants it


; control flow target (from $99B1, $AB9F)
    ldy #$10
    lda #$00
    sta $9D
    sta $9E
; control flow target (from $A0CC)
B04_A0AA:
    asl $99
    rol $9A
    rol $9D
    rol $9E
    inc $99
    lda $9D
    sec
    sbc $9B
    pha
    lda $9E
    sbc $9C
    bcs B04_A0C6
    pla
    dec $99
    jmp $A0CB

; control flow target (from $A0BE)
B04_A0C6:
    sta $9E
    pla
    sta $9D
; control flow target (from $A0C3)
    dey
    bne B04_A0AA
    rts

; 16-bit addition: ($99-$9A) = ($99-$9A) + ($9B-$9C)
; control flow target (from $9F12)
    lda $99
    clc
    adc $9B
    sta $99
    lda $9A
    adc $9C
    sta $9A
    rts

    sta $9B
    lda #$00
    sta $9C
; 16-bit subtraction: ($99-$9A) = ($99-$9A) - ($9B-$9C)
; control flow target (from $9F49, $9F88, $AF45)
    lda $99
    sec
    sbc $9B
    sta $99
    lda $9A
    sbc $9C
    sta $9A
    rts

; control flow target (from $964A, $9C6F, $9CA6, $AF5D)
    tya
    pha
    txa
    pha
; call to code in a different bank ($0F:$C22C)
    jsr $C22C
    pla
    tax
    pla
    tay
    rts

; control flow target (from $9635)
    sta $A7
    jsr $9EE4 ; given an index (in A) into the array of hero data structures at $062D, set $B9-$BA to the address of the corresponding item inside that structure

    jsr $A7B9
    lda $A7
    eor #$FF
    sta $AB
    ldy #$00
    lda ($B9),Y
    asl
    bcs B04_A113
    rts

; control flow target (from $A110)
B04_A113:
    asl
    bcc B04_A132
    lda #$08
    jsr $A020 ; generate a random number between $03 and A in A and $99

    cmp #$04
    bcs B04_A12E
    ldy #$00
    lda ($B9),Y
    and #$BF
    sta ($B9),Y
    lda #$20
; control flow target (from $A130, $A1FE)
B04_A129:
    sta $AD
    jmp $9CDC

; control flow target (from $A11D)
B04_A12E:
    lda #$1F
    bne B04_A129
; control flow target (from $A114)
B04_A132:
    ldy #$02
    lda ($B9),Y
    sta $A8
    cmp #$20
    bcc B04_A192
    cmp #$3C
    beq B04_A145
    cmp #$80
    bcs B04_A14C
    rts

; control flow target (from $A13E)
B04_A145:
    lda #$00
    sta $AD
    jmp $9CDC

; control flow target (from $A142)
B04_A14C:
    and #$7F
    sta $95 ; ID for [item] and [spell] control codes

    ldx #$07
; control flow target (from $A158)
B04_A152:
    cmp $A17C,X
    beq B04_A163
    dex
    bpl B04_A152
    lda #$7E
    sta $AD
    lda #$FE
    jmp $9CE5

; control flow target (from $A155)
B04_A163:
    lda #$FF
    sta $0176
    jsr $9AD6
    lda $A7
    sta $97 ; subject hero ID $97

    tax
    lda $06D2,X
    tax
    lda $95 ; ID for [item] and [spell] control codes

; call to code in a different bank ($0F:$F746)
    jsr $F746
    jmp $99E6


; code -> data
; indexed data load target (from $A152)

.byte $24,$26,$27,$36
.byte $32,$2F
.byte $30
.byte $2E
; data -> code
; control flow target (from $A1A1)
B04_A184:
    lda #$3C
    bne B04_A18A
; control flow target (from $A1A5)
B04_A188:
    lda #$3B
; control flow target (from $A186)
B04_A18A:
    sta $95 ; ID for [item] and [spell] control codes

    jsr $A4F0
    jmp $A1E1

; control flow target (from $A13A)
B04_A192:
    jsr $9EC3 ; given an index (in A) into the array of battle spell/item structures at $A7C0, set $C5-$C6 to the address of the corresponding item inside that structure

    ldy #$02 ; cast string ID

    lda ($C5),Y
    sta $AD
    lda $A8
    beq B04_A1E1
    cmp #$1C
    beq B04_A184
    cmp #$1D
    beq B04_A188
    cmp #$17
    bcs B04_A1E1
    cmp #$0F
    bcc B04_A1B1
    lda #$0F
; control flow target (from $A1AD)
B04_A1B1:
    tax
    lda #$61 ; Item ID #$61: Mysterious Hat (equipped)

    jsr $A4E7 ; given a hero ID in $A7 and an item ID in A, SEC if hero has that item, CLC otherwise

    bcc B04_A1BE
    txa
    clc
    adc #$0F
    tax
; control flow target (from $A1B7)
B04_A1BE:
    lda $B4F9,X
    sta $A6
    ldy #$10
    lda ($B9),Y
    sec
    sbc $A6
    bcs B04_A1D0
    lda #$11
    bne B04_A1DE
; control flow target (from $A1CA)
B04_A1D0:
    sta ($B9),Y
    jsr $9AAC
    ldy #$00
    lda ($B9),Y
    lsr
    bcc B04_A1E1
    lda #$12
; control flow target (from $A1CE)
B04_A1DE:
    jmp $9CE5

; control flow target (from $A18F, $A19D, $A1A9, $A1DA)
B04_A1E1:
    ldy #$00
    lda ($C5),Y
    and #$07
    tax
    inx
    dex
    bne B04_A1EF
    jmp $A3D1

; control flow target (from $A1EA)
B04_A1EF:
    dex
    bne B04_A253
    lda $A8
    cmp #$15
    bne B04_A208
    lda #$FD
    sta $AE
    lda #$EF
    jsr $A129
    jsr $A7B9
    lda #$2D
    sta $AD
; control flow target (from $A1F6)
B04_A208:
    lda #$00
; control flow target (from $A218)
B04_A20A:
    ldy #$01
    sta ($B9),Y
    pha
    jsr $A3D1
    pla
    tax
    inx
    txa
    cmp #$03
    bcc B04_A20A
    lda $A8
    cmp #$15
    bne B04_A252
    ldx #$00
    stx $99
; control flow target (from $A23B)
B04_A224:
    ldy #$01
    sty $9A
; control flow target (from $A233)
B04_A228:
    ldx $99
    jsr $8AF1
    inc $9A
    ldy $9A
    cpy #$09
    bcc B04_A228
    inc $99
    ldx $99
    cpx #$04
    bcc B04_A224
    lda #$0F
    sta $B2
    lda #$53
    sta $AE
    lda #$00
    sta $AF
    sta $9F
    jsr $9AE7
    lda #$FD
    sta $98 ; outcome of last fight?

; control flow target (from $A21E)
B04_A252:
    rts

; control flow target (from $A1F0)
B04_A253:
    dex
    beq B04_A259
    jmp $A32F

; control flow target (from $A254)
B04_A259:
    lda $A8
    cmp #$17
    bne B04_A264
    lda #$39
    jsr $9CE5
; control flow target (from $A25D)
B04_A264:
    lda #$49 ; Item ID #$49: Falcon Sword (equipped)

    jsr $A4E7 ; given a hero ID in $A7 and an item ID in A, SEC if hero has that item, CLC otherwise

    bcc B04_A26F
    lda $A8
    beq B04_A273
; control flow target (from $A269, $A2BF)
B04_A26F:
    lda #$00
    beq B04_A275
; control flow target (from $A26D)
B04_A273:
    lda #$FF
; control flow target (from $A271)
B04_A275:
    sta $A3
    ldy #$01
    lda ($B9),Y
    sta $AA
    jsr $9EEE ; given an index (in A) into the array of structures at $0663, set $B5-$B6 to the address of the corresponding item inside that structure

    ldy #$09
    lda ($B5),Y
    bne B04_A287
    rts

; control flow target (from $A284)
B04_A287:
    jsr $A020 ; generate a random number between $03 and A in A and $99

    ldx $99
    inx
    stx $06DC
    lda #$04
    jsr $A020 ; generate a random number between $03 and A in A and $99

    beq B04_A2A2
    jsr $A2C2
    cmp #$08
    bcs B04_A2A2
    sta $A9
    bcc B04_A2B3
; control flow target (from $A295, $A29C)
B04_A2A2:
    ldx $06DC
    ldy #$00
; control flow target (from $A2AC, $A2AF)
B04_A2A7:
    iny
    lda ($B5),Y
    cmp #$08
    bcs B04_A2A7
    dex
    bne B04_A2A7
    sty $A9
; control flow target (from $A2A0)
B04_A2B3:
    jsr $A4F9
    lda $98 ; outcome of last fight?

    bne B04_A2C1
    jsr $A7B9
    lda $A3
    bne B04_A26F
; control flow target (from $A2B8)
B04_A2C1:
    rts

; control flow target (from $A297)
    lda #$FF
    sta $A4
    sta $A5
    sta $A6
    lda $AA
    asl
    asl
    asl
    sec
    rol
    sta $A9
    and #$0F
; control flow target (from $A318)
B04_A2D5:
    tay
    ldx #$00
; control flow target (from $A2E2)
B04_A2D8:
    lda $06D5,X
    cmp $A9
    beq B04_A310
    inx
    cpx #$06
    bcc B04_A2D8
    lda ($B5),Y
    cmp #$08
    bcs B04_A310
    jsr $9ECD ; given an index (in A) into the array of structures at $068F, set $C1-$C2 to the address of the corresponding item inside that structure

    ldy #$04
    lda ($C1),Y
    sta $0C
    iny
    lda ($C1),Y
    sta $0D
    cmp $A6
    bcc B04_A304
    bne B04_A310
    lda $0C
    cmp $A5
    bcs B04_A310
; control flow target (from $A2FA)
B04_A304:
    lda $0C
    sta $A5
    lda $0D
    sta $A6
    lda $A9
    sta $A4
; control flow target (from $A2DD, $A2E8, $A2FC, $A302)
B04_A310:
    inc $A9
    lda $A9
    and #$0F
    cmp #$09
    bcc B04_A2D5
    ldx $06DB
    lda $A4
    sta $06D5,X
    inx
    cpx #$06
    bcc B04_A329
    ldx #$00
; control flow target (from $A325)
B04_A329:
    stx $06DB
    and #$0F
    rts

; control flow target (from $A256)
    dex
    bne B04_A361
    lda $A8
    cmp #$18
    bne B04_A33C
    lda #$3B
    bne B04_A342
; control flow target (from $A336)
B04_A33C:
    cmp #$19
    bne B04_A345
    lda #$3D
; control flow target (from $A33A)
B04_A342:
    jsr $9CE5
; control flow target (from $A33E)
B04_A345:
    ldy #$01
    lda ($B9),Y
    sta $AA
; control flow target (from $A373)
    lda #$01
    sta $A9
; control flow target (from $A35E)
B04_A34F:
    jsr $A4F9
    lda $98 ; outcome of last fight?

    bne B04_A360
    inc $A9
    lda $A9
    and #$0F
    cmp #$09
    bcc B04_A34F
; control flow target (from $A354, $A386)
B04_A360:
    rts

; control flow target (from $A330)
B04_A361:
    dex
    bne B04_A399
    lda $A8
    cmp #$1A
    bne B04_A36F
    lda #$3F
    jsr $9CE5
; control flow target (from $A368)
B04_A36F:
    lda #$00
    sta $AA
; control flow target (from $A380)
B04_A373:
    jsr $A34B
    lda $98 ; outcome of last fight?

    bne B04_A382
    inc $AA
    lda $AA
    cmp #$04
    bcc B04_A373
; control flow target (from $A378)
B04_A382:
    lda $A8
    cmp #$0C
    bne B04_A360
    lda $AB
    sta $AE
    lda $98 ; outcome of last fight?

    beq B04_A394
    lda #$FD
    sta $98 ; outcome of last fight?

; control flow target (from $A38E)
B04_A394:
    lda #$27
    jmp $AF55

; control flow target (from $A362)
B04_A399:
    dex
    bne B04_A3A9
    lda $B3
    ora #$80
    sta $B3
    lda #$16
    sta $B2
    jmp $9AE7

; control flow target (from $A39A)
B04_A3A9:
    ldy #$01
    lda ($B9),Y
    eor #$FF
    sta $AE
    eor #$FF
    jsr $9EC8 ; given an index (in A) into the array of hero data structures at $062D, set $C3-$C4 to the address of the corresponding item inside that structure

    ldy #$00
    lda #$84
    sta ($C3),Y
    jsr $A450 ; set hero current HP to max HP

    ldy #$05
    lda ($C3),Y
    ldy #$10
    sta ($C3),Y
    ldy #$0C
    lda ($C3),Y
    iny
    sta ($C3),Y
    jmp $A449

; control flow target (from $A1EC, $A20F)
    ldy #$01
    lda ($B9),Y
    jsr $9EC8 ; given an index (in A) into the array of hero data structures at $062D, set $C3-$C4 to the address of the corresponding item inside that structure

    ldy #$00
    lda ($C3),Y
    bmi B04_A3DF
    rts

; control flow target (from $A3DC)
B04_A3DF:
    ldy #$01
    lda ($B9),Y
    eor #$FF
    sta $AE
    jsr $A76A
    lda $A8
    cmp #$1D
    beq B04_A440
    cmp #$1E
    beq B04_A443
    cmp #$15
    beq B04_A449
    cmp #$0A
    beq B04_A461
    cmp #$14
    beq B04_A461
    bne B04_A446
; heal hero ID in A by random amount based on healing power in X
; control flow target (from $8006)
    jsr $9EC8 ; given an index (in A) into the array of hero data structures at $062D, set $C3-$C4 to the address of the corresponding item inside that structure

    txa
    cmp #$FF
    bne B04_A412
    lda #$F0 ; X == #$FF => heal 61,680 HP

    sta $B0
    sta $B1
    bne B04_A415
; control flow target (from $A408)
B04_A412:
    jsr $AE8C ; $B0 = random number tightly distributed around A / 2, $B1 = #$00

; control flow target (from $A410, $A446)
B04_A415:
    ldy #$0E ; hero current HP, low byte

    lda ($C3),Y
    clc
    adc $B0 ; HP to restore, low byte

    sta ($C3),Y
    sta $99 ; new current HP, low byte

    ldy #$0F ; hero current HP, high byte

    lda ($C3),Y
    adc $B1 ; HP to restore, high byte

    sta ($C3),Y
    sta $9A ; new current HP, high byte

    ldy #$04 ; hero max HP, high byte

    lda ($C3),Y
    cmp $9A ; new current HP, high byte

    bcc B04_A43C
    bne B04_A43F ; if high bytes are the same, compare low bytes, otherwise done

    ldy #$03 ; hero max HP, low byte

    lda ($C3),Y
    cmp $99 ; new current HP, low byte

    bcs B04_A43F ; if max >= current, then done

; control flow target (from $A430)
B04_A43C:
    jsr $A450 ; set hero current HP to max HP

; control flow target (from $A432, $A43A)
B04_A43F:
    rts

; control flow target (from $A3EE)
B04_A440:
    jmp $A493

; control flow target (from $A3F2)
B04_A443:
    jmp $A4C6

; control flow target (from $A400)
B04_A446:
    jsr $A415
; control flow target (from $A3CE, $A3F6, $A490, $A49B, $A6A2)
B04_A449:
    ldy #$03
; control flow target (from $A4D0, $A69F)
    lda ($C5),Y
    jmp $9CE5

; set hero current HP to max HP
; control flow target (from $A3BC, $A43C)
    ldy #$03 ; hero max HP, low byte

    lda ($C3),Y
    ldy #$0E ; hero current HP, low byte

    sta ($C3),Y
    ldy #$04 ; hero max HP, high byte

    lda ($C3),Y
    ldy #$0F ; hero current HP, high byte

    sta ($C3),Y
    rts

; control flow target (from $A3FA, $A3FE)
B04_A461:
    ldy #$0D
    lda ($C3),Y
    sta $9D
    clc
    adc $B0
    bcc B04_A46E
    lda #$FF
; control flow target (from $A46A)
B04_A46E:
    sta $9A
    ldy #$0C
    lda ($C3),Y
    sta $99
    jsr $A4DA
    lda $99
    cmp $9A
    bcs B04_A481
    sta $9A
; control flow target (from $A47D)
B04_A481:
    lda $9A
    ldy #$0D
    sta ($C3),Y
    sec
    sbc $9D
    sta $B0
    lda #$00
    sta $B1
    jmp $A449

; control flow target (from $A440)
    ldy #$00
    lda ($C3),Y
    and #$DF
    sta ($C3),Y
    jmp $A449

; restore the hero ID in A's MP by a random amount based on the Wizard's Ring's power; returns a random number between $03 and #$0A in A and $99
; control flow target (from $8003)
    jsr $9EE4 ; given an index (in A) into the array of hero data structures at $062D, set $B9-$BA to the address of the corresponding item inside that structure

    lda #$2C ; power for Item ID #$3D: Wizard's Ring

    jsr $AE8C ; $B0 = random number tightly distributed around A / 2, $B1 = #$00

; restore the current hero's MP by the amount in $B0; returns a random number between $03 and #$0A in A and $99
; control flow target (from $A4C6)
    ldy #$10
    lda ($B9),Y ; Current MP

    clc
    adc $B0 ; MP gain from Wizard's Ring

    bcc B04_A4B1 ; cap new current MP at #$FF

    lda #$FF
; control flow target (from $A4AD)
B04_A4B1:
    sta ($B9),Y ; Current MP

    sta $99 ; Current MP

    ldy #$05
    lda ($B9),Y ; Max MP

    cmp $99 ; Current MP

    bcs B04_A4C1 ; cap new current MP at Max MP

    ldy #$10
    sta ($B9),Y ; Current MP

; control flow target (from $A4BB)
B04_A4C1:
    lda #$0A
    jmp $A020 ; generate a random number between $03 and A in A and $99


; control flow target (from $A443)
    jsr $A4A6 ; restore the current hero's MP by the amount in $B0; returns a random number between $03 and #$0A in A and $99

    bne B04_A4D3
    jsr $A4F0
    ldy #$04
    jmp $A44B

; control flow target (from $A4C9)
B04_A4D3:
    lda #$A1
    sta $AD
    jmp $9CDC

; control flow target (from $A476, $AC2A)
    lda $99
    lsr
    clc
    adc $99
    bcc B04_A4E4
    lda #$FF
; control flow target (from $A4E0)
B04_A4E4:
    sta $99
    rts

; given a hero ID in $A7 and an item ID in A, SEC if hero has that item, CLC otherwise
; control flow target (from $A1B4, $A266, $A5E9, $A5F4, $A5FB)
    pha
    lda $A7
    sta $9C
    pla
; call to code in a different bank ($0F:$C4B0)
    jmp $C4B0 ; given a hero ID in $9C and an item ID in A, SEC if hero has that item, CLC otherwise


; control flow target (from $A18C, $A4CB)
    lda $A7
    tay
    ldx $06D2,Y
; call to code in a different bank ($0F:$C4D4)
    jmp $C4D4 ; given hero ID in A and hero inventory offset in X, remove that item from hero's inventory and move all lower items up 1 slot


; control flow target (from $A2B3, $A34F)
    lda $AA
    jsr $9EEE ; given an index (in A) into the array of structures at $0663, set $B5-$B6 to the address of the corresponding item inside that structure

    lda $AA
    asl
    asl
    asl
    asl
    ldy $A9
    ora $A9
    sta $AF
    lda ($B5),Y
    cmp #$08
    bcc B04_A511
    rts

; control flow target (from $A50E)
B04_A511:
    jsr $9EE9 ; given an index (in A) into the array of structures at $068F, set $B7-$B8 to the address of the corresponding item inside that structure

    ldy #$00
    lda ($B5),Y
    sta $AE
    jsr $9EDC ; given an index + 1 (in A) into the array of enemy stat structures at $B7F5, set $BB-$BC to the address of the corresponding item inside that structure

    jsr $A78F
    lda $A8
    cmp #$00
    beq B04_A567
    cmp #$04
    beq B04_A572
    cmp #$11
    beq B04_A572
    cmp #$02
    beq B04_A580
    cmp #$12
    beq B04_A580
    cmp #$06
    beq B04_A588
    cmp #$07
    beq B04_A590
    cmp #$1A
    beq B04_A590
    cmp #$08
    beq B04_A5AE
    cmp #$13
    beq B04_A5AE
    cmp #$0C
    beq B04_A56A
    lda #$00
    jsr $A74A
    bcc B04_A560
    lda $B0
    bne B04_A55D
    lda #$01
    sta $B0
; control flow target (from $A557)
B04_A55D:
    jmp $A692

; control flow target (from $A553, $A56E, $A577, $A5A1, $A5B3)
B04_A560:
    ldy #$04
; control flow target (from $A5AB)
B04_A562:
    lda ($C5),Y
    jmp $9CE5

; control flow target (from $A524)
B04_A567:
    jmp $A5E3

; control flow target (from $A54C)
B04_A56A:
    lda $AE
    cmp #$4E
    bcs B04_A560
    bcc B04_A579
; control flow target (from $A528, $A52C)
B04_A572:
    lda #$03
    jsr $A74A
    bcc B04_A560
; control flow target (from $A570)
B04_A579:
    ldy #$03
    lda ($C5),Y
    jmp $A6C2

; control flow target (from $A530, $A534)
B04_A580:
    lda #$80
    sta $A1
    lda #$01
    bne B04_A596
; control flow target (from $A538)
B04_A588:
    lda #$40
    sta $A1
    lda #$02
    bne B04_A596
; control flow target (from $A53C, $A540)
B04_A590:
    lda #$01
    sta $A1
    lda #$04
; control flow target (from $A586, $A58E)
B04_A596:
    jsr $A74A
    ldy #$00
    lda ($B7),Y
    and $A1
    bne B04_A5AD
    bcc B04_A560
    lda ($B7),Y
    ora $A1
    sta ($B7),Y
; control flow target (from $A5E0)
    ldy #$03
    bne B04_A562
; control flow target (from $A59F)
B04_A5AD:
    rts

; control flow target (from $A544, $A548)
B04_A5AE:
    lda #$05
    jsr $A74A
    bcc B04_A560
    ldy #$06
    lda ($B7),Y
    sta $9A
    sec
    sbc $B0
    bcs B04_A5C2
    lda #$00
; control flow target (from $A5BE)
B04_A5C2:
    sta $99
    ldy #$06
    lda ($BB),Y
    lsr
    cmp $99
    bcs B04_A5CF
    lda $99
; control flow target (from $A5CB)
B04_A5CF:
    ldy #$06
    sta ($B7),Y
    sta $99
    lda $9A
    sec
    sbc $99
    sta $B0
    lda #$00
    sta $B1
    jmp $A5A9

; control flow target (from $A567)
    lda #$08
    sta $A6
    lda #$4C ; Item ID #$4C: Sword of Destruction (equipped)

    jsr $A4E7 ; given a hero ID in $A7 and an item ID in A, SEC if hero has that item, CLC otherwise

    bcs B04_A600
    lda #$40
    sta $A6
    lda #$57 ; Item ID #$57: Gremlin’s Armor (equipped)

    jsr $A4E7 ; given a hero ID in $A7 and an item ID in A, SEC if hero has that item, CLC otherwise

    bcs B04_A600
    lda #$5F ; Item ID #$5F: Evil Shield (equipped)

    jsr $A4E7 ; given a hero ID in $A7 and an item ID in A, SEC if hero has that item, CLC otherwise

    bcc B04_A607
; control flow target (from $A5EC, $A5F7)
B04_A600:
    lda #$04
    jsr $A020 ; generate a random number between $03 and A in A and $99

    beq B04_A679
; control flow target (from $A5FE)
B04_A607:
    lda $A6
    jsr $A020 ; generate a random number between $03 and A in A and $99

    bne B04_A624
    lda $0161 ; current monster ID

    cmp #$52
    beq B04_A624
    ldy #$0B
    lda ($B9),Y
    jsr $A7A1
    lda #$0D ; String ID #$000D: A tremendous blow![end-FC]

    jsr $9ADE ; STA $B4, $B3 |= #$20

    jmp $A686

; control flow target (from $A60C, $A613)
B04_A624:
    ldy #$0B
    lda ($B9),Y
    sta $99
    ldy #$06
    lda ($B7),Y
    sta $9B
    lda #$00
    sta $9A
    sta $9C
    jsr $9F45
    lda $99
    sta $B0
    lda $9A
    sta $B1
    ldy #$00
    lda ($B9),Y
    and #$02
    beq B04_A656
    lda #$04
    jsr $A020 ; generate a random number between $03 and A in A and $99

    bne B04_A656
    lda #$00
    sta $B0
    sta $B1
; control flow target (from $A647, $A64E)
B04_A656:
    ldy #$00
    lda ($B7),Y
    bmi B04_A676
    ldy #$01
    lda ($BB),Y
    lsr
    lsr
    lsr
    lsr
    sta $A6
    lda #$40
    jsr $A020 ; generate a random number between $03 and A in A and $99

    lda $99
    cmp $A6
    bcs B04_A676
    lda #$0A ; String ID #$000A: [name] dodged the blow.[end-FC]

    jmp $9CE5

; control flow target (from $A65A, $A66F)
B04_A676:
    jmp $A686

; control flow target (from $A605)
B04_A679:
    lda #$42 ; String ID #$0042: No movement was possible, for the curse had frozen [name]'s body.[end-FC]

    sta $B2
    lda $A7
    eor #$FF
    sta $AE
    jmp $9AE7

; control flow target (from $A621, $A676, $A932)
    ldy #$01
    lda ($B7),Y
    cmp #$04
    bne B04_A692
    lsr $B1
    ror $B0
; control flow target (from $A55D, $A68C)
B04_A692:
    lda $B0
    ora $B1
    bne B04_A6A2
    lda #$07 ; String ID #$0007: But missed![end-FC]

    jsr $9ADE ; STA $B4, $B3 |= #$20

    ldy #$04
    jmp $A44B

; control flow target (from $A696)
B04_A6A2:
    jsr $A449
    ldy #$04
    lda ($B7),Y
    sec
    sbc $B0
    sta ($B7),Y
    sta $99
    iny
    lda ($B7),Y
    sbc $B1
    sta ($B7),Y
    bcc B04_A6C0
    bne B04_A6BF
    lda $99
    beq B04_A6C0
; control flow target (from $A6B9)
B04_A6BF:
    rts

; control flow target (from $A6B7, $A6BD)
B04_A6C0:
    lda #$19
; control flow target (from $A57D)
    sta $B2
    ldy $A9
    lda ($B5),Y
    ora #$08
    sta ($B5),Y
    and #$07
    jsr $9EE9 ; given an index (in A) into the array of structures at $068F, set $B7-$B8 to the address of the corresponding item inside that structure

    lda #$FF
    ldy #$03
    sta ($B7),Y
    ldy #$09
    lda ($B5),Y
    tax
    dex
    txa
    sta ($B5),Y
    ldy #$00
    lda ($B5),Y
    sta $0161 ; current monster ID

    jsr $9EDC ; given an index + 1 (in A) into the array of enemy stat structures at $B7F5, set $BB-$BC to the address of the corresponding item inside that structure

    ldx $A7
    cpx #$77
    beq B04_A73E
    ldy #$09
    lda ($BB),Y
    rol
    rol
    rol
    and #$03
    sta $99
    dey
    lda ($BB),Y
    rol
    rol $99
    rol
    rol $99
    ldy #$03
    lda ($BB),Y
    clc
    adc $0626 ; EXP earned this battle or current hero's current EXP, byte 0

    sta $0626 ; EXP earned this battle or current hero's current EXP, byte 0

    lda $99
    adc $0627 ; EXP earned this battle or current hero's current EXP, byte 1

    sta $0627 ; EXP earned this battle or current hero's current EXP, byte 1

    bcc B04_A721
    lda #$FF
    sta $0626 ; EXP earned this battle or current hero's current EXP, byte 0

    sta $0627 ; EXP earned this battle or current hero's current EXP, byte 1

; control flow target (from $A717)
B04_A721:
    ldy #$02
    lda ($BB),Y
    clc
    adc $06E6
    sta $06E6
    lda #$00
    adc $06EC
    sta $06EC
    bcc B04_A73E
    lda #$FF
    sta $06E6
    sta $06EC
; control flow target (from $A6EE, $A734)
B04_A73E:
    jsr $9A84
    bne B04_A747
    lda #$FE
    sta $98 ; outcome of last fight?

; control flow target (from $A741)
B04_A747:
    jmp $9AE7

; control flow target (from $A550, $A574, $A596, $A5B0)
    stx $A5
    lsr
    php
    clc
    adc #$07
    tay
    lda ($BB),Y
    plp
    bcc B04_A75A
    lsr
    lsr
    lsr
; control flow target (from $A755)
B04_A75A:
    and #$07
    sta $9B
    lda #$07
    jsr $A020 ; generate a random number between $03 and A in A and $99

    lda $99
    cmp $9B
    ldx $A5
    rts

; control flow target (from $A3E7)
    ldy #$01
    lda ($C5),Y
    cmp #$01
    beq B04_A774
    bcs B04_A784
; control flow target (from $A770)
B04_A774:
    php
    ldy #$0C
    lda ($C3),Y
; control flow target (from $A79E)
    lsr
    plp
    bcs B04_A77E
    lsr ; Increase and Decrease effect

; control flow target (from $A77B)
B04_A77E:
    clc
    adc #$01
; control flow target (from $A786)
B04_A781:
    jmp $AE8C ; $B0 = random number tightly distributed around A / 2, $B1 = #$00


; control flow target (from $A772, $A797)
B04_A784:
    cmp #$FF
    bne B04_A781
    sta $B0
    lda #$F0
    sta $B1
    rts

; control flow target (from $A51D)
    ldy #$01
    lda ($C5),Y
    cmp #$01
    beq B04_A799
    bcs B04_A784
; control flow target (from $A795)
B04_A799:
    php
    ldy #$06
    lda ($BB),Y
    jmp $A779

; control flow target (from $A619, $AA1D)
    sta $99
    lsr
    sta $A6
    lda $99
    jsr $AE8C ; $B0 = random number tightly distributed around A / 2, $B1 = #$00

    lda $A6
    clc
    adc $B0
    sta $B0
    lda $B1
    adc #$00
    sta $B1
    rts

; control flow target (from $A102, $A201, $A2BA, $A87E, $AE18)
    lda $B3
    and #$8F
    sta $B3
    rts


; code -> data
; Battle Structs for Spells and Usable Items (target, power, cast string ID, hit string ID, miss string ID)
; "Spell" ID #$00: Fight
; Spells
; indirect data load target (via $9F31)
; Spell ID #$01: Firebal
.byte $02,$02,$06
.byte $0B
.byte $08
; Spell ID #$02: Sleep
.byte $02,$28,$E1
.byte $0B
.byte $18
; Spell ID #$03: Firebane
.byte $03,$02,$E2
.byte $1C
.byte $1D
; Spell ID #$04: Defeat
.byte $04,$32,$E3
.byte $0B
.byte $18
; Spell ID #$05: Infernos
.byte $03,$02,$E4
.byte $24
.byte $18
; Spell ID #$06: Stopspell
.byte $03,$32,$E5
.byte $0B
.byte $18
; Spell ID #$07: Surround
.byte $03,$02,$E6
.byte $29
.byte $18
; Spell ID #$08: Defence
.byte $03,$02,$E7
.byte $2B
.byte $18
; Spell ID #$09: Heal
.byte $04,$00,$E8
.byte $21
.byte $18
; Spell ID #$0A: Increase
.byte $00,$40,$E9
.byte $17
.byte $00
; Spell ID #$0B: Healmore
.byte $01,$00,$EA
.byte $23
.byte $00
; Spell ID #$0C: Sacrifice
.byte $00,$80,$EB
.byte $17
.byte $00
; Spell ID #$0D: Healall
.byte $04,$02,$EC
.byte $26
.byte $18
; Spell ID #$0E: Explodet
.byte $00,$FF,$ED
.byte $17
.byte $00

.byte $04,$82,$EE
.byte $0B
.byte $18
; Chance spell effects
; Spell ID #$0F: Chance; Effect #$01: Confuse
; Spell ID #$0F: Chance; Effect #$02: Heal
.byte $05,$00,$EF
.byte $16
.byte $00
; Spell ID #$0F: Chance; Effect #$03: Defeat
.byte $01,$40,$EF
.byte $17
.byte $00
; Spell ID #$0F: Chance; Effect #$04: Sleep
.byte $04,$02,$EF
.byte $24
.byte $18
; Spell ID #$0F: Chance; Effect #$05: Defense
.byte $04,$02,$EF
.byte $1C
.byte $1D
; Spell ID #$0F: Chance; Effect #$06: Increase
.byte $04,$01,$EF
.byte $21
.byte $18
; Spell ID #$0F: Chance; Effect #$07: Sorceror
.byte $01,$01,$EF
.byte $23
.byte $00
; Spell ID #$0F: Chance; Effect #$08: Revive Max
.byte $01,$02,$EF
.byte $2E
.byte $00

.byte $06,$02,$EF
.byte $2C
.byte $00
; Item ID #$03: Wizard’s Wand
; Usable Items
; Item ID #$04: Staff of Thunder
.byte $02,$18,$38
.byte $0B
.byte $40
; Item ID #$10: Thunder Sword
.byte $03,$32,$3A
.byte $0B
.byte $40
; Item ID #$0E: Light Sword
.byte $03,$37,$3C
.byte $0B
.byte $40
; Item ID #$1D: Shield of Strength
.byte $04,$02,$3E
.byte $2B
.byte $40
; Item ID #$3C: Medical Herb
.byte $00,$80,$41
.byte $17
.byte $00
; Item ID #$3B: Antidote Herb
.byte $00,$64,$7E
.byte $17
.byte $00
; Item ID #$3D: Wizard’s Ring
.byte $00,$02,$7E
.byte $43
.byte $00

.byte $00,$2C,$A1
.byte $00
.byte $A2
; data -> code
; control flow target (from $9625)
    sta $A7
    sta $AE
    jsr $B1DC
    lda $AF
    cmp #$04
    bcc B04_A869
    rts

; control flow target (from $A866)
B04_A869:
    ldy #$07
    lda ($BB),Y
    rol
    rol
    rol
    and #$03
    sta $06EB
    cmp #$03
    bne B04_A87E
    lda $A7
    jsr $B052
; control flow target (from $A877)
B04_A87E:
    jsr $A7B9
    ldy #$03
; control flow target (from $A889)
B04_A883:
    lda ($B7),Y
    sta $06E0,Y
    dey
    bne B04_A883
    ldy #$00
    lda ($B7),Y
    sta $06E7
    lda $06E3
    ldy #$00
    lda ($B5),Y
    sta $AB
    lda $06E3
    asl
    asl
    asl
    asl
    ora $06E2
    sta $AC
    ldy #$05
    lda ($BB),Y
    sta $06EA
    lda $06E7
    bpl B04_A8D2
    lda #$08
    jsr $A020 ; generate a random number between $03 and A in A and $99

    lda $06EB
    cmp $99
    bcc B04_A8CE
    ldy #$00
    lda ($B7),Y
    and #$7F
    sta ($B7),Y
    lda #$20
; control flow target (from $A8D0)
B04_A8C9:
    sta $AD
    jmp $9CDC

; control flow target (from $A8BD)
B04_A8CE:
    lda #$1F
    bne B04_A8C9
; control flow target (from $A8B1)
B04_A8D2:
    lda $B3
    bpl B04_A935
    lda #$03
    jsr $A020 ; generate a random number between $03 and A in A and $99

    bne B04_A935
    lda #$09
    sta $0D
    jsr $A95C
    lda $0D
    cmp #$09
    beq B04_A935
    lda #$09
    sec
    sbc $0D
    jsr $A020 ; generate a random number between $03 and A in A and $99

    sta $0D
    inc $0D
    jsr $A95C
    ldy #$03
    lda ($B7),Y
    jsr $9EEE ; given an index (in A) into the array of structures at $0663, set $B5-$B6 to the address of the corresponding item inside that structure

    ldy #$00
    lda ($B5),Y
    sta $AE
    ldy #$03
    lda ($B7),Y
    asl
    asl
    asl
    asl
    ldy #$02 ; Sleep?

    ora ($B7),Y
    sta $AF
    and #$0F
    sta $A9
    ldy #$06 ; Stopspell?

    lda ($B7),Y
    sta $9B
    jsr $B023
    lda #$06
    sta $AD
    lda #$0B
    sta $B2
    lda #$77
    sta $A7
    lda #$00
    jsr $9EC3 ; given an index (in A) into the array of battle spell/item structures at $A7C0, set $C5-$C6 to the address of the corresponding item inside that structure

    jmp $A686

; control flow target (from $A8D4, $A8DB, $A8E8)
B04_A935:
    jsr $B222
    sta $A8
    ldy #$0A
    lda ($B5),Y
    cmp #$03
    bcs B04_A944
    sta $A8
; control flow target (from $A940)
B04_A944:
    lda $06E1
    cmp #$20
    bcc B04_A94D
    lda #$00
; control flow target (from $A949)
B04_A94D:
    asl
    tax
    lda $A97C,X ; pointers to monster attack handlers

    sta $C7
    lda $A97D,X
    sta $C8
    jmp ($00C7)

; control flow target (from $A8E1, $A8F6)
    lda #$00
    sta $0C
; control flow target (from $A979)
B04_A960:
    cmp $A7
    beq B04_A973
    jsr $9EE9 ; given an index (in A) into the array of structures at $068F, set $B7-$B8 to the address of the corresponding item inside that structure

    ldy #$03
    lda ($B7),Y
    cmp #$04
    bcs B04_A973
    dec $0D
    beq B04_A97B
; control flow target (from $A962, $A96D)
B04_A973:
    inc $0C
    lda $0C
    cmp #$08
    bcc B04_A960
; control flow target (from $A971)
B04_A97B:
    rts


; code -> data
; pointers to monster attack handlers
; indexed data load target (from $A94F)
; indexed data load target (from $A954)
.byte $BC

.byte $A9,$11,$AA,$28,$AA,$3A,$AA,$4A,$AA,$51,$AA,$78,$AA,$87,$AA,$91
.byte $AA,$B5,$AA,$C0,$AA,$D3,$AA,$E3,$AA,$ED,$AA,$03,$AB,$C7,$AB,$E5
.byte $AB,$EA,$AB,$57,$AC,$5C,$AC,$61,$AC,$66,$AC,$6B,$AC,$70,$AC,$70
.byte $AC,$70,$AC,$75,$AC,$7A,$AC,$AE
.byte $AD,$15,$AE,$BC
.byte $A9,$1E
.byte $AE
; data -> code
; handler for Attack IDs #$00/#$1E: Attack / Concentrated Attack
; control flow target (from $AA14, $AA2D, $AE15, $AE1B)
; indirect control flow target (via $A97C, $A9B8)
B04_A9BC:
    lda #$FF
    sta $C5
; control flow target (from $AA37, $AA47)
    jsr $B00F
; control flow target (from $AA25)
    lda #$06 ; String ID #$0006: [name] attacked![end-FC]

    sta $AD
    lda $A8
    jsr $9EE4 ; given an index (in A) into the array of hero data structures at $062D, set $B9-$BA to the address of the corresponding item inside that structure

    ldy #$00
    lda ($B9),Y
    bmi B04_A9D3
    rts

; control flow target (from $A9D0)
B04_A9D3:
    and #$40
    bne B04_A9FF
    lda #$40
    jsr $A020 ; generate a random number between $03 and A in A and $99

    beq B04_A9EE
    lda $A8
    sta $9C
    lda #$52 ; Item ID #$52: Clothes Hiding (equipped)

; call to code in a different bank ($0F:$C4B0)
    jsr $C4B0 ; given a hero ID in $9C and an item ID in A, SEC if hero has that item, CLC otherwise

    bcc B04_A9FF
    jsr $B007
    bcs B04_A9FF
; control flow target (from $A9DC)
B04_A9EE:
    lda $B3
    and #$DF
    sta $B3
    lda $A8
    eor #$FF
    sta $AE
    lda #$0A ; String ID #$000A: [name] dodged the blow.[end-FC]

    jmp $9CE5

; control flow target (from $A9D5, $A9E7, $A9EC)
B04_A9FF:
    ldy #$00
    lda ($B9),Y
    and $C5
    bne B04_AA0E
    lda $C6
    sta $B2
    jmp $AEA5

; control flow target (from $AA05)
B04_AA0E:
    jmp $AEA1

; handler for Attack ID #$01: Heroic Attack
; indirect control flow target (via $A97E)
    jsr $B007
; control flow target (from $AA3D)
B04_AA14:
    bcs B04_A9BC ; handler for Attack IDs #$00/#$1E: Attack / Concentrated Attack

    lda #$FF
    sta $C5
    lda $06EA
    jsr $A7A1
    lda #$0E ; String ID #$000E: A heroic attack![end-FC]

    jsr $9ADE ; STA $B4, $B3 |= #$20

    jmp $A9C3

; handler for Attack ID #$02: Poison Attack
; indirect control flow target (via $A980)
    lda #$04 ; 1/4 Chance of Poison Attack Succeeding

    jsr $A020 ; generate a random number between $03 and A in A and $99

    bne B04_A9BC ; handler for Attack IDs #$00/#$1E: Attack / Concentrated Attack

    lda #$20
    sta $C5
    lda #$2F ; String ID #$002F: Alas, [name] was poisoned and lost [number] HP.[end-FC]

    sta $C6
    jmp $A9C0

; handler for Attack ID #$03: Faint Attack
; indirect control flow target (via $A982)
    jsr $AFFF
    bcs B04_AA14
    lda #$40
    sta $C5
    lda #$30 ; String ID #$0030: [name] fainted after losing [number] HP.[end-FC]

    sta $C6
    jmp $A9C0

; handler for Attack ID #$04: Parry
; indirect control flow target (via $A984)
    lda #$00
    sta $AD
    jmp $9CDC

; handler for Attack ID #$05: Run Away
; indirect control flow target (via $A986)
    lda #$0F ; String ID #$000F: [name] broke away and ran.[end-FC]

    sta $AD
    ldy #$09
    lda ($B5),Y
    tax
    dex
    txa
    sta ($B5),Y
    ldy #$03
    lda #$FF
    sta ($B7),Y
    jsr $9A84
    bne B04_AA6D
    lda #$FE
    sta $98 ; outcome of last fight?

; control flow target (from $AA67)
B04_AA6D:
    jsr $9CDC
    ldy $06E2
    lda #$FF
    sta ($B5),Y
    rts

; handler for Attack ID #$06: Firebal
; indirect control flow target (via $A988)
    lda #$E1
    sta $AD
    jsr $AE7D
    lda #$18 ; Power

    jsr $AE8C ; $B0 = random number tightly distributed around A / 2, $B1 = #$00

    jmp $AEA1

; handler for Attack ID #$07: Firebane
; indirect control flow target (via $A98A)
    lda #$E3
    sta $AD
    lda #$32 ; Power

    sta $AA
    bne B04_AA99
; handler for Attack ID #$08: Explodet
; indirect control flow target (via $A98C)
    lda #$EE
    sta $AD
    lda #$82 ; Power

    sta $AA
; control flow target (from $AA8F)
B04_AA99:
    jsr $AE7D
    lda #$00
    sta $A8
; control flow target (from $AAB2)
B04_AAA0:
    lda $AA
    jsr $AE8C ; $B0 = random number tightly distributed around A / 2, $B1 = #$00

    jsr $AEA1
    lda $98 ; outcome of last fight?

    bne B04_AAB4
    inc $A8
    lda $A8
    cmp #$03
    bcc B04_AAA0
; control flow target (from $AAAA)
B04_AAB4:
    rts

; handler for Attack ID #$09: Heal-1
; indirect control flow target (via $A98E)
    lda #$E9
    sta $AD
    lda #$40 ; Power

    sta $AA
    jmp $AAC8

; handler for Attack ID #$0A: Healmore-1
; indirect control flow target (via $A990)
    lda #$EB
    sta $AD
    lda #$80 ; Power

    sta $AA
; control flow target (from $AABD)
    jsr $AE7D
    lda $AA
    jsr $AE8C ; $B0 = random number tightly distributed around A / 2, $B1 = #$00

    jmp $AB14

; handler for Attack ID #$0B: Healall-1
; indirect control flow target (via $A992)
    lda #$ED
    sta $AD
    jsr $AE7D
    lda #$D0 ; Power

    sta $B0
    sta $B1
    jmp $AB14

; handler for Attack ID #$0C: Heal-2
; indirect control flow target (via $A994)
    lda #$E9
    sta $AD
    lda #$40 ; Power

    sta $AA
    bne B04_AAF5
; handler for Attack ID #$0D: Healmore-2
; indirect control flow target (via $A996)
    lda #$EB
    sta $AD
    lda #$80 ; Power

    sta $AA
; control flow target (from $AAEB)
B04_AAF5:
    jsr $AE7D
    lda $AA
    jsr $AE8C ; $B0 = random number tightly distributed around A / 2, $B1 = #$00

    jsr $AB67
    jmp $AB16

; handler for Attack ID #$0E: Healall-2
; indirect control flow target (via $A998)
    lda #$ED
    sta $AD
    jsr $AE7D
    lda #$D0 ; Power

    sta $B1
    jsr $AB67
    jmp $AB16

; control flow target (from $AAD0, $AAE0)
    lda $A7
; control flow target (from $AB00, $AB11)
    cmp #$08
    bcc B04_AB1C
    lda $A7
; control flow target (from $AB18)
B04_AB1C:
    jsr $9EE9 ; given an index (in A) into the array of structures at $068F, set $B7-$B8 to the address of the corresponding item inside that structure

    ldy #$03
    lda ($B7),Y
    jsr $9EEE ; given an index (in A) into the array of structures at $0663, set $B5-$B6 to the address of the corresponding item inside that structure

    ldy #$00
    lda ($B5),Y
    sta $AE
    jsr $9EDC ; given an index + 1 (in A) into the array of enemy stat structures at $B7F5, set $BB-$BC to the address of the corresponding item inside that structure

    ldy #$03
    lda ($B7),Y
    asl
    asl
    asl
    asl
    ldy #$02
    ora ($B7),Y
    sta $AF
    jsr $B1F6
    lda $99
    clc
    adc $B0
    sta $99
    lda $9A
    adc $B1
    sta $9A
    ldx #$02
    jsr $B217
    bcs B04_AB56
    ldx #$00
; control flow target (from $AB52)
B04_AB56:
    lda $99,X
    ldy #$04
    sta ($B7),Y
    lda $9A,X
    ldy #$05
    sta ($B7),Y
    lda #$17 ; String ID #$0017: [name]'s wounds were healed.[end-FC]

    jmp $9CE5

; control flow target (from $AAFD, $AB0E)
    lda #$FF
    sta $A6
    lda #$00
    sta $A3
    sta $A4
    sta $A5
; control flow target (from $ABC2)
B04_AB73:
    jsr $9ECD ; given an index (in A) into the array of structures at $068F, set $C1-$C2 to the address of the corresponding item inside that structure

    ldy #$03
    lda ($C1),Y
    cmp #$04
    bcs B04_ABBC
    cmp $06E3
    beq B04_ABBC
    jsr $9ED2 ; given an index (in A) into the array of structures at $0663, set $BF-$C0 to the address of the corresponding item inside that structure

    ldy #$00
    lda ($BF),Y
    jsr $9EDC ; given an index + 1 (in A) into the array of enemy stat structures at $B7F5, set $BB-$BC to the address of the corresponding item inside that structure

    ldy #$04
    lda ($C1),Y
    sta $9B
    ldy #$00
    lda ($BB),Y
    sta $9A
    lda #$00
    sta $99
    sta $9C
    jsr $A0A2
    lda $9A
    cmp $A4
    bcc B04_ABBC
    bne B04_ABB0
    lda $99
    cmp $A3
    bcc B04_ABBC
; control flow target (from $ABA8)
B04_ABB0:
    lda $99
    sta $A3
    lda $9A
    sta $A4
    lda $A5
    sta $A6
; control flow target (from $AB7C, $AB81, $ABA6, $ABAE)
B04_ABBC:
    inc $A5
    lda $A5
    cmp #$08
    bcc B04_AB73
    lda $A6
    rts

; handler for Attack ID #$0F: Revive
; indirect control flow target (via $A99A)
    lda #$F7
    sta $AD
    jsr $AE7D
    lda #$2C ; String ID #$002C: Then [name] was brought back to life![end-FC]

    sta $06E4
    jsr $B2AE
    bcc B04_ABDB
    lda #$07
    rts

; control flow target (from $ABD6)
B04_ABDB:
    sta $06E3
    jsr $9EEE ; given an index (in A) into the array of structures at $0663, set $B5-$B6 to the address of the corresponding item inside that structure

    txa
    jmp $ADCE

; handler for Attack ID #$10: Defence
; indirect control flow target (via $A99C)
    lda #$E8
    jmp $AC84

; handler for Attack ID #$11: Increase
; indirect control flow target (via $A99E)
    lda #$EA
    sta $AD
    jsr $AE7D
    lda #$00
    sta $06E8
; control flow target (from $AC54)
B04_ABF6:
    jsr $9EE9 ; given an index (in A) into the array of structures at $068F, set $B7-$B8 to the address of the corresponding item inside that structure

    ldy #$03
    lda ($B7),Y
    cmp #$04
    bcs B04_AC4C
    jsr $9EEE ; given an index (in A) into the array of structures at $0663, set $B5-$B6 to the address of the corresponding item inside that structure

    ldy #$00
    lda ($B5),Y
    sta $AE
    jsr $9EDC ; given an index + 1 (in A) into the array of enemy stat structures at $B7F5, set $BB-$BC to the address of the corresponding item inside that structure

    ldy #$03
    lda ($B7),Y
    asl
    asl
    asl
    asl
    ldy #$02
    ora ($B7),Y
    sta $AF
    ldy #$06
    lda ($BB),Y
    sta $A5
    lsr
    lsr
    jsr $AE8C ; $B0 = random number tightly distributed around A / 2, $B1 = #$00

    lda $A5
    sta $99
    jsr $A4DA
    ldy #$06
    lda ($B7),Y
    sta $A6
    clc
    adc $B0
    bcc B04_AC3A
    lda #$FF
; control flow target (from $AC36)
B04_AC3A:
    cmp $99
    bcc B04_AC40
    lda $99
; control flow target (from $AC3C)
B04_AC40:
    sta ($B7),Y
    sec
    sbc $A6
    sta $B0
    lda #$23 ; String ID #$0023: [name]'s Defense Power increased by [number].[end-FC]

    jsr $9CE5
; control flow target (from $ABFF)
B04_AC4C:
    inc $06E8
    lda $06E8
    cmp #$08
    bcc B04_ABF6
    rts

; handler for Attack ID #$12: Sleep
; indirect control flow target (via $A9A0)
    lda #$E2
    jmp $AC84

; handler for Attack ID #$13: Stopspell
; indirect control flow target (via $A9A2)
    lda #$E6
    jmp $AC84

; handler for Attack ID #$14: Surround
; indirect control flow target (via $A9A4)
    lda #$E7
    jmp $AC84

; handler for Attack ID #$15: Defeat
; indirect control flow target (via $A9A6)
    lda #$E4
    jmp $AC84

; handler for Attack ID #$16: Sacrifice
; indirect control flow target (via $A9A8)
    lda #$EC
    jmp $AC84

; handler for Attack IDs #$17-#$19: Weak, Strong, Deadly Flames
; indirect control flow target (via $A9AA, $A9AC, $A9AE)
    lda #$33 ; String ID #$0033: [name] blew scorching flames![end-FC]

    jmp $AC7F

; handler for Attack ID #$1A: Poison Breath
; indirect control flow target (via $A9B0)
    lda #$34 ; String ID #$0034: [name] exhaled a blast of poisonous breath.[end-FC]

    jmp $AC7F

; handler for Attack ID #$1B: Sweet Breath
; indirect control flow target (via $A9B2)
    lda #$37 ; String ID #$0037: [name] blew its sweet scented breath.[end-FC]

    jmp $AC7F

; control flow target (from $AC72, $AC77, $AC7C)
    sta $AD
    jmp $AC89

; control flow target (from $ABE7, $AC59, $AC5E, $AC63, $AC68, $AC6D)
    sta $AD
    jsr $AE7D
; control flow target (from $AC81)
    lda #$00
    sta $A8
; control flow target (from $ACA2)
B04_AC8D:
    jsr $9EE4 ; given an index (in A) into the array of hero data structures at $062D, set $B9-$BA to the address of the corresponding item inside that structure

    ldy #$00
    lda ($B9),Y
    bmi B04_ACB9
; control flow target (from $ACF4, $AD1D, $AD2D, $AD5E, $AD66, $AD7D)
    lda $98 ; outcome of last fight?

    beq B04_AC9C
    bne B04_ACA4
; control flow target (from $AC98)
B04_AC9C:
    inc $A8
    lda $A8
    cmp #$03
    bcc B04_AC8D
; control flow target (from $AC9A)
B04_ACA4:
    lda $06E1
    cmp #$16
    bne B04_ACB8
    lda $AB
    sta $AE
    lda $AC
    sta $AF
    lda #$27
    jsr $9CE5
; control flow target (from $ACA9)
B04_ACB8:
    rts

; control flow target (from $AC94)
B04_ACB9:
    lda $A8
    eor #$FF
    sta $AE
    lda $06E1
    cmp #$10
    bne B04_ACF7
    ldy #$0C
    lda ($B9),Y
    lsr
    sta $A5
    lsr
    jsr $AE8C ; $B0 = random number tightly distributed around A / 2, $B1 = #$00

    ldy #$0D
    lda ($B9),Y
    sta $A6
    sec
    sbc $B0
    bcs B04_ACDE
    lda #$00
; control flow target (from $ACDA)
B04_ACDE:
    cmp $A5
    bcs B04_ACE4
    lda $A5
; control flow target (from $ACE0)
B04_ACE4:
    sta ($B9),Y
    sta $99
    lda $A6
    sec
    sbc $99
    sta $B0
    lda #$22 ; String ID #$0022: [name]'s Defense Power decreased by [number].[end-FC]

    jsr $9CE5
    jmp $AC96

; control flow target (from $ACC4)
B04_ACF7:
    cmp #$12
    bne B04_AD30
    lda #$1E ; String ID #$001E: [name] fell asleep.[end-FC]

    sta $A5
    lda #$40
    sta $A6
    lda #$1D ; String ID #$001D: [name] did not fall asleep.[end-FC]

    bne B04_AD09
; control flow target (from $AD40, $AD4E)
B04_AD07:
    lda #$18 ; String ID #$0018: But the spell had no effect on [name].[end-FC]

; control flow target (from $AD05, $AD9E, $ADAB)
B04_AD09:
    sta $A4
    ldy #$00
    lda ($B9),Y
    and $A6
    bne B04_AD2D
    jsr $AFD2
    bcc B04_AD20
    lda $A4
    jsr $9CE5
; control flow target (from $AD36)
B04_AD1D:
    jmp $AC96

; control flow target (from $AD16)
B04_AD20:
    ldy #$00
    lda ($B9),Y
    ora $A6
    sta ($B9),Y
    lda $A5
    jsr $9CE5
; control flow target (from $AD11)
B04_AD2D:
    jmp $AC96

; control flow target (from $ACF9)
B04_AD30:
    cmp #$13
    bne B04_AD42
    lda $A8
    beq B04_AD1D
    lda #$2A
    sta $A5
    lda #$01
    sta $A6
    bne B04_AD07
; control flow target (from $AD32)
B04_AD42:
    cmp #$14
    bne B04_AD50
    lda #$2B ; String ID #$002B: And [name] was surrounded by the Phantom Force.[end-FC]

    sta $A5
    lda #$02
    sta $A6
    bne B04_AD07
; control flow target (from $AD44)
B04_AD50:
    cmp #$15 ; Monster Attack ID #$15: Defeat

    bne B04_AD69
    jsr $B007
    bcc B04_AD61
    lda #$40
    jsr $9CE5
    jmp $AC96

; control flow target (from $AD57)
B04_AD61:
    lda #$1B
; control flow target (from $AD6F)
B04_AD63:
    jsr $AF55
    jmp $AC96

; control flow target (from $AD52)
B04_AD69:
    cmp #$16 ; Attack ID #$16: Sacrifice

    bne B04_AD71
    lda #$26 ; String ID #$0026: [name] was utterly defeated.[end-FC]

    bne B04_AD63
; control flow target (from $AD6B)
B04_AD71:
    cmp #$17 ; Attack ID #$17: Weak Flames

    bne B04_AD80
    lda #$18 ; Breath 1 power

; control flow target (from $AD86, $AD8E)
B04_AD77:
    jsr $AE8C ; $B0 = random number tightly distributed around A / 2, $B1 = #$00

    jsr $AEFF ; extra resist for armors

    jmp $AC96

; control flow target (from $AD73)
B04_AD80:
    cmp #$18 ; Attack ID #$18: Strong Flames

    bne B04_AD88
    lda #$32 ; Breath 2 power

    bne B04_AD77
; control flow target (from $AD82)
B04_AD88:
    cmp #$19 ; Attack ID #$19: Deadly Flames

    bne B04_AD90
    lda #$8C ; Breath 3 power

    bne B04_AD77
; control flow target (from $AD8A)
B04_AD90:
    cmp #$1A ; Attack ID #$1A: Poison Breath

    bne B04_ADA1
    lda #$35 ; String ID #$0035: [name] was poisoned.[end-FC]

    sta $A5
    lda #$20
    sta $A6
    lda #$36 ; String ID #$0036: [name] repelled the poison.[end-FC]

    jmp $AD09

; control flow target (from $AD92)
B04_ADA1:
    lda #$1E ; String ID #$001E: [name] fell asleep.[end-FC]

    sta $A5
    lda #$40
    sta $A6
    lda #$1D ; String ID #$001D: [name] did not fall asleep.[end-FC]

    jmp $AD09

; handler for Attack ID #$1C: Call For Help
; indirect control flow target (via $A9B4)
    lda #$13 ; String ID #$0013: [name] called for help.[end-FC]

    sta $AD
    jsr $AE7D
    lda #$15 ; String ID #$0015: [name] came to help.[end-FC]

    sta $06E4
    lda #$02 ; 1/2 Chance of Call For Help Succeeding

    jsr $A020 ; generate a random number between $03 and A in A and $99

    bne B04_ADC9
    lda $06E3
    jsr $B26D
    bcc B04_ADCE
; control flow target (from $ADBF)
B04_ADC9:
    lda #$14 ; String ID #$0014: But no help came.[end-FC]

    jmp $9CE5

; control flow target (from $ABE2, $ADC7)
B04_ADCE:
    sta ($B5),Y
    sta $015E
    jsr $9EE9 ; given an index (in A) into the array of structures at $068F, set $B7-$B8 to the address of the corresponding item inside that structure

    tya
    ldy #$02
    sta ($B7),Y
    sta $AF
    ldy #$03
    lda $06E3
    sta ($B7),Y
    asl
    asl
    asl
    asl
    ora $AF
    sta $AF
    ldy #$00
    lda #$00
    sta ($B7),Y
    iny
    lda #$04
    sta ($B7),Y
    ldy #$09
    lda ($B5),Y
    tax
    inx
    txa
    sta ($B5),Y
    ldy #$00
    lda ($B5),Y
    sta $015F
    sta $AE
    jsr $B7A4
    jsr $B6AB
    lda $06E4
    jmp $9CE5

; handler for Attack ID #$1D: Two Attacks
; indirect control flow target (via $A9B6)
    jsr $A9BC ; handler for Attack IDs #$00/#$1E: Attack / Concentrated Attack

    jsr $A7B9
    jmp $A9BC ; handler for Attack IDs #$00/#$1E: Attack / Concentrated Attack


; handler for Attack ID #$1F: Strange Jig
; indirect control flow target (via $A9BA)
    lda #$31 ; String ID #$0031: Then [name] danced a strange jig.[end-FC]

    sta $AD
    lda #$02 ; 2 heroes with MP

    jsr $A020 ; generate a random number between $03 and A in A and $99

    sta $A3
    inc $A3 ; convert to 1-2 for Cannock-Moonbrooke

    lda $A3
    jsr $AE6D ; given hero ID in A, return that hero's current MP in A or #$00 if hero is dead

    bne B04_AE42
    lda $A3
    and #$01
    sta $A3
    inc $A3 ; if at first you don't succeed, try the other hero

    lda $A3
    jsr $AE6D ; given hero ID in A, return that hero's current MP in A or #$00 if hero is dead

    bne B04_AE42
    rts

; control flow target (from $AE30, $AE3F)
B04_AE42:
    lda $A3
    eor #$FF
    sta $AE
    ldy #$05 ; Hero Max MP

    lda ($B9),Y
    lsr ; Power = 1/2 Max MP

    jsr $AE8C ; $B0 = random number tightly distributed around A / 2, $B1 = #$00

    ldy #$10 ; offset for current MP

    lda ($B9),Y
    sta $9A ; original current MP

    sec
    sbc $B0 ; randomized MP damage amount

    bcs B04_AE5D
    lda #$00 ; if negative, use 0 instead

; control flow target (from $AE59)
B04_AE5D:
    sta ($B9),Y ; update current MP

    sta $99 ; new current MP

    lda $9A ; original current MP

    sec
    sbc $99 ; new current MP

    sta $B0 ; actual MP damage

    lda #$32 ; String ID #$0032: And [name] lost [number] MP.[end-FC]

    jmp $9CE5

; given hero ID in A, return that hero's current MP in A or #$00 if hero is dead
; control flow target (from $AE2D, $AE3C)
    jsr $9EE4 ; given an index (in A) into the array of hero data structures at $062D, set $B9-$BA to the address of the corresponding item inside that structure

    ldy #$00 ; status offset

    lda ($B9),Y
    and #$80 ; Alive

    beq B04_AE7C
    ldy #$10 ; offset for current MP

    lda ($B9),Y
; control flow target (from $AE76)
B04_AE7C:
    rts

; control flow target (from $AA7C, $AA99, $AAC8, $AAD7, $AAF5, $AB07, $ABCB, $ABEE, $AC86, $ADB2)
    lda $06E7 ; Fireball, Firebane, and Explodet

    and #$40
    beq B04_AE8B
    lda #$12
    jsr $9CE5
    pla
    pla
; control flow target (from $AE82)
B04_AE8B:
    rts

; $B0 = random number tightly distributed around A / 2, $B1 = #$00
; control flow target (from $A412, $A4A3, $A781, $A7A8, $AA81, $AAA2, $AACD, $AAFA, $AC23, $ACCE, $AD77, $AE4D)
    sta $99
    lda #$00
    sta $9A
    jsr $9FFB ; set $9B to a random number tightly distributed around #$80 and $9C to #$00

    jsr $A05F ; 16-bit multiplication: ($99-$9A) = ($99-$9A) * ($9B-$9C), overflow in $9E, copy of ($99-$9A) in ($A1-$9D)

    lda $9D
    sta $B0
    lda $9E ; product of 2 8-bit number can never exceed 16 bits, so this is guaranteed to be #$00

    sta $B1
    rts

; control flow target (from $AA0E, $AA84, $AAA5)
    lda #$0C ; Firebal

    sta $B2
; control flow target (from $AA0B)
    lda $A8
    eor #$FF
    sta $AE
    lda $A8
    jsr $9EE4 ; given an index (in A) into the array of hero data structures at $062D, set $B9-$BA to the address of the corresponding item inside that structure

    ldy #$00
    lda ($B9),Y
    bmi B04_AEB7
    rts

; control flow target (from $AEB4)
B04_AEB7:
    ldy #$02
    lda ($B9),Y
    cmp #$3C
    bne B04_AEC3
    lsr $B1
    ror $B0
; control flow target (from $AEBD)
B04_AEC3:
    lda $06E1
    cmp #$06 ; Firebal

    bcc B04_AED9
    cmp #$09
    bcs B04_AED9
    lda $B0
    ora $B1
    bne B04_AF03
    inc $B0
    jmp $AF03

; control flow target (from $AEC8, $AECC)
B04_AED9:
    lda $06E7
    ror
    bcc B04_AEEE
; call to code in a different bank ($0F:$C3AB)
    jsr $C3AB ; generate a random number and store it in $32-$33 (two passes)

    lda $32 ; RNG byte 0

    and #$03
    bne B04_AEEE
    lda #$00
    sta $B0
    sta $B1
; control flow target (from $AEDD, $AEE6)
B04_AEEE:
    lda $B0
    ora $B1
    bne B04_AF03
    lda #$07 ; String ID #$0007: But missed![end-FC]

    jsr $9ADE ; STA $B4, $B3 |= #$20

    lda #$09
    jsr $9CE5
    rts

; control flow target (from $AD7A)
    lda #$0C ; String ID #$000C: [name]'s HP is reduced by [number].[end-FC]

    sta $B2
; control flow target (from $AED2, $AED6, $AEF2)
B04_AF03:
    lda $B2
    cmp #$2F ; Item ID #$2F: Gremlin’s Tail

    beq B04_AF0D
    cmp #$30 ; Item ID #$30: Dragon’s Bane

    bne B04_AF15
; control flow target (from $AF07)
B04_AF0D:
    ldy #$00
    lda ($B9),Y
    ora $C5
    sta ($B9),Y
; control flow target (from $AF0B)
B04_AF15:
    lda $A8
    sta $9C
    lda #$53 ; Item ID #$53: Water Flying Cloth (equipped)

    jsr $AFCC
    bcs B04_AF81
    lda #$58 ; Item ID #$58: Magic Armor (equipped)

    jsr $AFCC
    bcs B04_AF81
    lda #$5B ; Item ID #$5B: Armor of Erdrick (equipped)

    jsr $AFCC
    bcs B04_AF81
    jmp $AFC2

; control flow target (from $AF9B)
    lda $B0
    sta $9B
    lda $B1
    sta $9C
    ldy #$0E
    lda ($B9),Y
    sta $99
    ldy #$0F
    lda ($B9),Y
    sta $9A
    jsr $A0E3 ; 16-bit subtraction: ($99-$9A) = ($99-$9A) - ($9B-$9C)

    bcc B04_AF50
    lda $99
    ora $9A
    bne B04_AF73
; control flow target (from $AF48)
B04_AF50:
    jsr $AF6D
    lda #$1B
; control flow target (from $A396, $AD63)
    sta $B2
    ldy #$00
    lda #$04
    sta ($B9),Y
    jsr $A0F1
    ldx #$00
    jsr $B243
    lda $A3
    bne B04_AF6D
    lda #$FF
    sta $98 ; outcome of last fight?

; control flow target (from $AF50, $AF67)
B04_AF6D:
    lda #$00
    sta $99
    sta $9A
; control flow target (from $AF4E)
B04_AF73:
    ldy #$0E
    lda $99
    sta ($B9),Y
    iny
    lda $9A
    sta ($B9),Y
    jmp $9AE7

; control flow target (from $AF1E, $AF25, $AF2C)
B04_AF81:
    lda $06E1 ; All 3 armors BCS to here

    cmp #$06 ; Firebal

    bcc B04_AF9B
    cmp #$09
    bcc B04_AF9E
    cmp #$17 ; Breath

    bcc B04_AF9B
    cmp #$1A
    bcs B04_AF9B
    lda $06E5
    cmp #$58 ; Item ID #$58: Magic Armor (equipped)

    bne B04_AF9E
; control flow target (from $AF86, $AF8E, $AF92, $AFC6, $AFCA)
B04_AF9B:
    jmp $AF31

; control flow target (from $AF8A, $AF99)
B04_AF9E:
    lsr $B1
    ror $B0
    lda $B1
    sta $9A
    lda $B0
    sta $99
    lsr $9A
    ror $99
    lda $06E5
    cmp #$53 ; Item ID #$53: Water Flying Cloth (equipped)

    beq B04_AFC2
    clc
    lda $99
    adc $B0
    sta $B0
    lda $9A
    adc $B1
    sta $B1
; control flow target (from $AF2E, $AFB3)
B04_AFC2:
    lda $B0
    ora $B1
    bne B04_AF9B
    inc $B0
    bne B04_AF9B
; control flow target (from $AF1B, $AF22, $AF29)
    sta $06E5
; call to code in a different bank ($0F:$C4B0)
    jmp $C4B0 ; given a hero ID in $9C and an item ID in A, SEC if hero has that item, CLC otherwise


; control flow target (from $AD13)
    lda $06E1
    cmp #$13
    beq B04_AFDD
    cmp #$12
    bne B04_AFFF
; control flow target (from $AFD7)
B04_AFDD:
    lda $A8
    sta $9C
    lda #$6F ; Item ID #$6F: Gremlin’s Tail (equipped)

; call to code in a different bank ($0F:$C4B0)
    jsr $C4B0 ; given a hero ID in $9C and an item ID in A, SEC if hero has that item, CLC otherwise

    ldx #$18 ; 24/32 Sleep, Stopspell - Gremlin's Tail

    bcs B04_AFF5
    lda #$70 ; Item ID #$70: Dragon’s Bane (equipped)

; call to code in a different bank ($0F:$C4B0)
    jsr $C4B0 ; given a hero ID in $9C and an item ID in A, SEC if hero has that item, CLC otherwise

    ldx #$03 ; 3/32 Sleep, Stopspell - Dragon's Bane

    bcs B04_AFF5
    ldx #$0C ; 12/32 Sleep, Stopspell

; control flow target (from $AFE8, $AFF1)
B04_AFF5:
    lda #$20
    jsr $A020 ; generate a random number between $03 and A in A and $99

    stx $9A
    cmp $9A
    rts

; control flow target (from $AA3A, $AFDB)
B04_AFFF:
    lda #$08
    jsr $A020 ; generate a random number between $03 and A in A and $99

    cmp #$03 ; 3/8 Faint Attack, Surround, Poison Breath, Sweet Breath

    rts

; control flow target (from $A9E9, $AA11, $AD54)
    lda #$08
    jsr $A020 ; generate a random number between $03 and A in A and $99

    cmp #$01 ; 1/8 Heroic Attack, Defeat

    rts

; control flow target (from $A9C0)
    lda $A8
    jsr $9EE4 ; given an index (in A) into the array of hero data structures at $062D, set $B9-$BA to the address of the corresponding item inside that structure

    ldy #$0D
    lda ($B9),Y
    sta $9B
    ldy #$00
    lda ($B9),Y
    and #$40
    sta $06E9
; control flow target (from $A91E)
    lda $06EA
    sta $99
    lda #$00
    sta $9A
    sta $9C
    jsr $9F6C
    lda $06E9
    beq B04_B049
    lda #$05
    sta $9B
    lda #$00 ; this is a waste of bytes; should skip these 2 ops and call $A05B instead of $A05F

    sta $9C
    jsr $A05F ; 16-bit multiplication: ($99-$9A) = ($99-$9A) * ($9B-$9C), overflow in $9E, copy of ($99-$9A) in ($A1-$9D)

    lsr $9A
    ror $99
    lsr $9A
    ror $99
; control flow target (from $B034)
B04_B049:
    lda $99
    sta $B0
    lda $9A
    sta $B1
    rts

; control flow target (from $95F6, $A87B)
    sta $AE
    jsr $B1DC
    lda $AF
    cmp #$04
    bcc B04_B05E
    rts

; control flow target (from $B05B)
B04_B05E:
    ldy #$07
    lda ($BB),Y
    rol
    rol
    rol
    and #$03
    sta $B0
    lda #$64
    sta $06E8
; control flow target (from $B0CB, $B0E5, $B12E, $B18E, $B1AC, $B1D5)
B04_B06E:
    dec $06E8
    bne B04_B078
    lda #$00
    jmp $B1D8

; control flow target (from $B071)
; call to code in a different bank ($0F:$C3AB)
B04_B078:
    jsr $C3AB ; generate a random number and store it in $32-$33 (two passes)

    lda $B0
    jsr $9ED7 ; given an index (in A) into the array of enemy special % structures at $B2F6, set $BD-$BE to the address of the corresponding item inside that structure

    ldy #$00
; control flow target (from $B08B)
B04_B082:
    lda ($BD),Y
    cmp $32 ; RNG byte 0

    bcs B04_B08D
    iny
    cpy #$07
    bcc B04_B082
; control flow target (from $B086)
B04_B08D:
    tya
    tax
    lsr
    php
    sta $9B
    lda #$0A
    clc
    adc $9B
    tay
    lda ($BB),Y
    plp
    bcc B04_B0A2
    asl
    asl
    asl
    asl
; control flow target (from $B09C)
B04_B0A2:
    and #$F0
    sta $9C
    ldy #$0E
    lda ($BB),Y
    inx
; control flow target (from $B0AF)
B04_B0AB:
    dex
    beq B04_B0B1
    lsr
    bpl B04_B0AB
; control flow target (from $B0AC)
B04_B0B1:
    lsr
    ror $9C
    lda $9C
    lsr
    lsr
    lsr
    sta $AD
    cmp #$16
    bne B04_B0CD
    jsr $B20F
    lsr $9C
    ror $9B
    jsr $B217
    bcc B04_B0CD
    bcs B04_B06E
; control flow target (from $B0BD, $B0C9)
B04_B0CD:
    lda $B0
    cmp #$02
    bcc B04_B12B
    ldy #$00
    lda ($B7),Y
    and #$40
    beq B04_B0E8
    lda $AD
    cmp #$06
    bcc B04_B0E8
    cmp #$17
    bcs B04_B0E8
    jmp $B06E

; control flow target (from $B0D9, $B0DF, $B0E3)
B04_B0E8:
    ldx #$00
    jsr $B243
    lda $AD
    cmp #$12
    bne B04_B0FF
    ldx #$01
    jsr $B243
    lda $A3
    cmp $A4
    jmp $B11C

; control flow target (from $B0F1)
B04_B0FF:
    cmp #$13
    bne B04_B10F
    ldx #$03
    jsr $B243
    lda $A3
    cmp $A6
    jmp $B11C

; control flow target (from $B101)
B04_B10F:
    cmp #$14
    bne B04_B120
    ldx #$02
    jsr $B243
    lda $A3
    cmp $A5
; control flow target (from $B0FC, $B10C)
    bne B04_B12B
    beq B04_B12E
; control flow target (from $B111)
B04_B120:
    cmp #$1C
    bne B04_B131
    lda $AF
    jsr $B26D
; control flow target (from $B138, $B149)
    bcs B04_B12E
; control flow target (from $B0D1, $B11C)
B04_B12B:
    jmp $B194

; control flow target (from $B11E, $B129)
B04_B12E:
    jmp $B06E

; control flow target (from $B122)
B04_B131:
    cmp #$0F
    bne B04_B13B
    jsr $B2AE
    jmp $B129

; control flow target (from $B133)
B04_B13B:
    cmp #$09
    bcc B04_B14C
    cmp #$0C
    bcs B04_B14C
    jsr $B20F
    jsr $B217
    jmp $B129

; control flow target (from $B13D, $B141)
B04_B14C:
    cmp #$0C
    bcc B04_B194
    cmp #$0F
    bcs B04_B194
    lda #$00
    sta $A3
; control flow target (from $B189)
B04_B158:
    cmp $AF
    beq B04_B183
    jsr $9EEE ; given an index (in A) into the array of structures at $0663, set $B5-$B6 to the address of the corresponding item inside that structure

    ldy #$00
    lda ($B5),Y
    jsr $9EDC ; given an index + 1 (in A) into the array of enemy stat structures at $B7F5, set $BB-$BC to the address of the corresponding item inside that structure

    ldy #$01
    sty $A4
; control flow target (from $B181)
B04_B16A:
    lda ($B5),Y
    cmp #$08
    bcs B04_B17B
    jsr $9EE9 ; given an index (in A) into the array of structures at $068F, set $B7-$B8 to the address of the corresponding item inside that structure

    jsr $B20F
    jsr $B217
    bcc B04_B191
; control flow target (from $B16E)
B04_B17B:
    inc $A4
    ldy $A4
    cpy #$09
    bcc B04_B16A
; control flow target (from $B15A)
B04_B183:
    inc $A3
    lda $A3
    cmp #$04
    bcc B04_B158
    jsr $B1DC
    jmp $B06E

; control flow target (from $B179)
B04_B191:
    jsr $B1DC
; control flow target (from $B12B, $B14E, $B152)
B04_B194:
    lda $AD
    cmp #$05
    bne B04_B1AF
    lda $B0
    beq B04_B1AF
    ldy #$05
    lda ($BB),Y
    sta $A3
    lda $0636 ; Midenhall Strength

    lsr
    cmp $A3
    bcs B04_B1AF
    jmp $B06E

; control flow target (from $B198, $B19C, $B1AA)
B04_B1AF:
    ldy #$0D
    lda ($BB),Y
    and #$0F
    cmp #$0E
    bne B04_B1CF
    ldy #$0E
    lda ($BB),Y
    rol
    bcc B04_B1CF
    ldy #$0A
    lda ($B5),Y
    cmp #$FF
    bne B04_B1CF
    jsr $B222
    ldy #$0A
    sta ($B5),Y
; control flow target (from $B1B7, $B1BE, $B1C6)
B04_B1CF:
    lda $AD
    cmp #$1E
    bne B04_B1D8
    jmp $B06E

; control flow target (from $B075, $B1D3)
B04_B1D8:
    ldy #$01 ; Character magic

    sta ($B7),Y
; control flow target (from $A85F, $B054, $B18B, $B191)
    lda $AE
    jsr $9EE9 ; given an index (in A) into the array of structures at $068F, set $B7-$B8 to the address of the corresponding item inside that structure

    ldy #$03
    lda ($B7),Y
    sta $AF
    cmp #$04
    bcc B04_B1EC
    rts

; control flow target (from $B1E9)
B04_B1EC:
    jsr $9EEE ; given an index (in A) into the array of structures at $0663, set $B5-$B6 to the address of the corresponding item inside that structure

    ldy #$00
    lda ($B5),Y
    jmp $9EDC ; given an index + 1 (in A) into the array of enemy stat structures at $B7F5, set $BB-$BC to the address of the corresponding item inside that structure


; control flow target (from $AB3D, $B20F)
    ldy #$04
    lda ($B7),Y
    sta $99
    iny
    lda ($B7),Y
    sta $9A
    ldy #$00
    lda ($BB),Y
    sta $9B
    iny
    lda ($BB),Y
    and #$0F
    sta $9C
    rts

; control flow target (from $B0BF, $B143, $B173)
    jsr $B1F6
    lsr $9C
    ror $9B
    rts

; control flow target (from $AB4F, $B0C6, $B146, $B176)
    lda $9A
    cmp $9C
    bne B04_B221
    lda $99
    cmp $9B
; control flow target (from $B21B)
B04_B221:
    rts

; control flow target (from $A935, $B1C8)
    jsr $B2D4
    ldx #$00
    stx $C5
; control flow target (from $B23E)
B04_B229:
    lda $A3,X
    cmp #$03
    beq B04_B238
    jsr $9EE4 ; given an index (in A) into the array of hero data structures at $062D, set $B9-$BA to the address of the corresponding item inside that structure

    ldy #$00
    lda ($B9),Y
    bmi B04_B240
; control flow target (from $B22D)
B04_B238:
    inc $C5
    ldx $C5
    cpx #$04
    bcc B04_B229
; control flow target (from $B236)
B04_B240:
    lda $A3,X
    rts

; control flow target (from $AF62, $B0EA, $B0F5, $B105, $B115)
    lda #$00
    sta $A3,X
; control flow target (from $B26A)
B04_B247:
    tay
    lda $062D,Y ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    cpx #$02
    bcc B04_B258
    cpx #$03
    beq B04_B254
    lsr
; control flow target (from $B251)
B04_B254:
    lsr
    jmp $B25E

; control flow target (from $B24D)
B04_B258:
    cpx #$00
    beq B04_B25D
    asl
; control flow target (from $B25A)
B04_B25D:
    asl
; control flow target (from $B255)
    lda #$00
    adc $A3,X
    sta $A3,X
    tya
    clc
    adc #$12
    cmp #$25
    bcc B04_B247
    rts

; control flow target (from $ADC4, $B126)
    ldy #$FE
    sty $95 ; ID for [item] and [spell] control codes

; control flow target (from $B2BB)
    sta $C8
    jsr $9ED2 ; given an index (in A) into the array of structures at $0663, set $BF-$C0 to the address of the corresponding item inside that structure

    lda #$00
    sta $C7
; control flow target (from $B28B)
B04_B27A:
    jsr $9ECD ; given an index (in A) into the array of structures at $068F, set $C1-$C2 to the address of the corresponding item inside that structure

    ldy #$03
    lda ($C1),Y
    cmp #$FF
    beq B04_B28E
    inc $C7
    lda $C7
    cmp #$08
    bcc B04_B27A
    rts

; control flow target (from $B283)
B04_B28E:
    ldy #$01
; control flow target (from $B2AB)
B04_B290:
    lda ($BF),Y
    cmp #$08
    bcc B04_B2A8
    cmp $95 ; ID for [item] and [spell] control codes

    beq B04_B2A8
    sty $C5
    ldx $C8
    jsr $8B09
    php
    ldy $C5
    lda $C7
    plp
    rts

; control flow target (from $B294, $B298)
B04_B2A8:
    iny
    cpy #$09
    bcc B04_B290
    rts

; control flow target (from $ABD3, $B135)
    jsr $B2D4
    ldy #$FF
    sta $95 ; ID for [item] and [spell] control codes

    ldx #$00
    stx $C6
; control flow target (from $B2D1)
B04_B2B9:
    lda $A3,X
    jsr $B271
    sta $06E9
    bcs B04_B2CB
    ldx $C6
    lda $A3,X
    ldx $06E9
    rts

; control flow target (from $B2C1)
B04_B2CB:
    inc $C6
    ldx $C6
    cpx #$04
    bcc B04_B2B9
    rts

; control flow target (from $B222, $B2AE)
    lda #$FF
    ldx #$03
; control flow target (from $B2DB)
B04_B2D8:
    sta $A3,X
    dex
    bpl B04_B2D8
    ldy #$04
; control flow target (from $B2F3)
B04_B2DF:
    tya
    jsr $A020 ; generate a random number between $03 and A in A and $99

    inc $99
    ldx #$FF
; control flow target (from $B2EA, $B2EE)
B04_B2E7:
    inx
    lda $A3,X
    bpl B04_B2E7
    dec $99
    bne B04_B2E7
    dey
    sty $A3,X
    bne B04_B2DF
    rts


; code -> data
; Attack % for Enemy Specials
; indirect data load target (via $9F29)

.byte $1F,$3F,$5F,$7F,$9F,$BF,$DF,$25,$4C,$6D,$8F,$AD,$CB,$E5
.byte $2D,$57,$7D,$9F,$BD,$D7,$ED
.byte $63,$95,$B1,$C9
.byte $DC,$EB
.byte $F7
; data -> code
; control flow target (from $9588)
    lda #$00
    sta $A8
; control flow target (from $B36D, $B382, $B4F4)
B04_B316:
    jsr $9EE4 ; given an index (in A) into the array of hero data structures at $062D, set $B9-$BA to the address of the corresponding item inside that structure

    ldy #$00
    lda ($B9),Y
    and #$C0
    cmp #$80
    beq B04_B32C
    ldy #$02
    lda #$46
    sta ($B9),Y
    jmp $B4EC

; control flow target (from $B321, $B39E, $B3C5, $B486, $B49E)
B04_B32C:
    jsr $9AC7
    lda #$FF
    jsr $B578
    lda $A8
    sta $AA
    beq B04_B354
    lda #$00
    jsr $B5EB
    beq B04_B34E
    lda $A8
    cmp #$01
    beq B04_B352
    lda #$01
    jsr $B5EB
    bne B04_B352
; control flow target (from $B33F)
B04_B34E:
    lda #$01
    bne B04_B354
; control flow target (from $B345, $B34C)
B04_B352:
    lda #$02
; control flow target (from $B338, $B350)
B04_B354:
    jsr $B537
    cmp #$02
    beq B04_B395
    cmp #$03
    beq B04_B38F
    cmp #$04
    beq B04_B3AA
    cmp #$05
    beq B04_B385
    cmp #$06
    beq B04_B388
    lda $A8
    beq B04_B316
    cmp #$02
    beq B04_B375
    bne B04_B37E
; control flow target (from $B371)
B04_B375:
    lda #$01
    jsr $B5EB
    beq B04_B37E
    dec $A8
; control flow target (from $B373, $B37A)
B04_B37E:
    dec $A8
    lda $A8
    jmp $B316

; control flow target (from $B365)
B04_B385:
    jmp $B472

; control flow target (from $B369)
B04_B388:
    lda #$3C
    sta $A9
    jmp $B4E0

; control flow target (from $B35D)
B04_B38F:
    jsr $9AA0
    jmp $9AB4

; control flow target (from $B359)
B04_B395:
    lda #$00
    jsr $B578
    cmp #$04
    bcc B04_B3A1
; control flow target (from $B3B4)
B04_B39E:
    jmp $B32C

; control flow target (from $B39C)
B04_B3A1:
    sta $AA
    lda #$00
    sta $A9
    jmp $B4E0

; control flow target (from $B361, $B414, $B425)
B04_B3AA:
    lda $A8
    tay
    dey
    tya
    jsr $B5D2
    cmp #$FF
    beq B04_B39E
    cmp #$FE
    bne B04_B3C8
    jsr $9AB4
    lda #$45 ; String ID #$0045: cannot use the spell yet.[end-FC]

; control flow target (from $B3F2)
B04_B3BF:
    jsr $9CCA ; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0

    jsr $9A3C ; set number of NMIs to wait for to current battle message delay * 1.5 if current battle message delay is < #$80, #$64 otherwise

    jmp $B32C

; control flow target (from $B3B8)
B04_B3C8:
    tax
    stx $C8
    lda $A8
    sta $9C
    lda #$61
; call to code in a different bank ($0F:$C4B0)
    jsr $C4B0 ; given a hero ID in $9C and an item ID in A, SEC if hero has that item, CLC otherwise

    bcc B04_B3DB
    txa
    clc
    adc #$0F
    tax
; control flow target (from $B3D4)
B04_B3DB:
    lda $B4F9,X
    sta $C7
    lda $A8
    jsr $9EC8 ; given an index (in A) into the array of hero data structures at $062D, set $C3-$C4 to the address of the corresponding item inside that structure

    ldy #$10
    lda ($C3),Y
    cmp $C7
    bcs B04_B3F4
    jsr $9AB4
    lda #$11 ; String ID #$0011: Thy MP is low.[end-FC]

    bne B04_B3BF
; control flow target (from $B3EB)
B04_B3F4:
    ldx $C8
    lda $B517,X
    beq B04_B404
    cmp #$02
    bcc B04_B409
    beq B04_B41C
    jmp $B42D

; control flow target (from $B3F9)
B04_B404:
    stx $A9
    jmp $B4E0

; control flow target (from $B3FD)
B04_B409:
    stx $A9
    lda #$00
    jsr $B578
    cmp #$FF
    bne B04_B417
    jmp $B3AA

; control flow target (from $B412)
B04_B417:
    sta $AA
    jmp $B4E0

; control flow target (from $B3FF)
B04_B41C:
    stx $A9
    jsr $B5E4
    cmp #$FF
    bne B04_B428
    jmp $B3AA

; control flow target (from $B423)
B04_B428:
    sta $AA
    jmp $B4E0

; control flow target (from $B401)
    lda #$32
    jsr $A020 ; generate a random number between $03 and A in A and $99

    beq B04_B441
; control flow target (from $B45E)
B04_B434:
    lda #$07
    jsr $A020 ; generate a random number between $03 and A in A and $99

    clc
    adc #$0F
    sta $A9
    jmp $B4E0

; control flow target (from $B432)
B04_B441:
    lda #$02
    jsr $A020 ; generate a random number between $03 and A in A and $99

    sta $A9
    jsr $9EC8 ; given an index (in A) into the array of hero data structures at $062D, set $C3-$C4 to the address of the corresponding item inside that structure

    ldy #$00
    lda ($C3),Y
    bpl B04_B460
    lda $A9
    eor #$01
    jsr $9EC8 ; given an index (in A) into the array of hero data structures at $062D, set $C3-$C4 to the address of the corresponding item inside that structure

    ldy #$00
    lda ($C3),Y
    bpl B04_B46B
    bmi B04_B434
; control flow target (from $B44F)
B04_B460:
    lda $A9
; control flow target (from $B46F)
    sta $AA
    lda #$16
    sta $A9
    jmp $B4E0

; control flow target (from $B45C)
B04_B46B:
    lda $A9
    eor #$01
    jmp $B462

; control flow target (from $B385, $B4CE, $B4DC)
B04_B472:
    lda $A8
    sta $614C
    jsr $B5DB
    pha
    ldy $A8
    txa
    sta $06D2,Y
    pla
    cmp #$FF
    bne B04_B489
    jmp $B32C

; control flow target (from $B484)
B04_B489:
    cmp #$FE
    bne B04_B4A1
    jsr $9AB4
    lda $614C
    jsr $9CD0 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    lda #$46 ; String ID #$0046: [name] doesn't have any tools.[end-FC]

    jsr $9CCA ; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0

    jsr $9A3C ; set number of NMIs to wait for to current battle message delay * 1.5 if current battle message delay is < #$80, #$64 otherwise

    jmp $B32C

; control flow target (from $B48B)
B04_B4A1:
    sta $A9
    ldx #$00
; control flow target (from $B4AF)
B04_B4A5:
    lda $B527,X ; Items usable in battle

    cmp $A9
    beq B04_B4BA
    inx
    cpx #$08
    bcc B04_B4A5
    lda $A9
    ora #$80
    sta $A9
    jmp $B4E0

; control flow target (from $B4AA)
B04_B4BA:
    txa
    clc
    adc #$17
    sta $A9
    lda $B52F,X ; Base Target for Battle Items - (00: Open Cast)  (01: Select Enemy)  (02: Select Ally)

    beq B04_B4E0
    cmp #$02
    bcc B04_B4D5
    jsr $B5E4
    cmp #$FF
    beq B04_B472
    sta $AA
    jmp $B4E0

; control flow target (from $B4C7)
B04_B4D5:
    lda #$00
    jsr $B578
    cmp #$FF
    beq B04_B472
    sta $AA
; control flow target (from $B38C, $B3A7, $B406, $B419, $B42A, $B43E, $B468, $B4B7, $B4C3, $B4D2)
B04_B4E0:
    ldy #$02
    lda $A9
    sta ($B9),Y
    ldy #$01
    lda $AA
    sta ($B9),Y
; control flow target (from $B329)
    inc $A8
    lda $A8
    cmp #$03
    bcs B04_B4F7
    jmp $B316

; control flow target (from $B4F2)
B04_B4F7:
; indexed data load target (from $A1BE, $B3DB)
    jmp $9AB4


; code -> data
; MP Cost in Battle (normal)
; MP Cost in Battle (with Mysterious Hat)
.byte $02,$02,$04,$04,$04,$03,$02,$02
.byte $03,$02,$05,$01
.byte $08,$08
.byte $0F
; indexed data load target (from $B3F6)
.byte $01,$01,$03,$03,$03,$02,$01
.byte $01,$02,$01,$04
.byte $01,$06
.byte $06
; Base Target for Spells - (00: Open Cast)  (01: Select Enemy)  (02: Select Ally)
.byte $0C
; Items usable in battle
.byte $01,$01,$00,$01,$01,$01,$01,$00
.byte $02,$00,$02,$00
.byte $02,$00
.byte $03
; indexed data load target (from $B4A5)
; Base Target for Battle Items - (00: Open Cast)  (01: Select Enemy)  (02: Select Ally)
.byte $03,$04,$10,$0E
.byte $1D,$3C
.byte $3B
.byte $3D
; indexed data load target (from $B4C0)

.byte $01,$01,$01,$00
.byte $00,$02
.byte $02
.byte $00
; data -> code
; control flow target (from $B354)
    sta $99
    ldx #$00
    lda #$01
    sta $5A,X ; Crest/direction name write buffer start

    inx
    lda #$02
    sta $5A,X ; Crest/direction name write buffer start

    inx
    lda $99
    cmp #$01
    lda #$03
    bcc B04_B54F
    lda #$04
; control flow target (from $B54B)
B04_B54F:
    sta $5A,X ; Crest/direction name write buffer start

    inx
    lda $99
    cmp #$02
    lda #$06
    bcc B04_B55C
    lda #$03
; control flow target (from $B558)
B04_B55C:
    sta $5A,X ; Crest/direction name write buffer start

    inx
    lda #$05
    sta $5A,X ; Crest/direction name write buffer start

    inx
    lda #$FF
    sta $5A,X ; Crest/direction name write buffer start

    lda #$04
    sta $94 ; return bank for various function calls, doubles as index of selected option for multiple-choice menus

    lda $A8
; call to code in a different bank ($0F:$F4EF)
    jsr $F4EF ; open battle command menu for hero A

    tax
    inx
    beq B04_B577
    lda $5A,X ; Crest/direction name write buffer start

; control flow target (from $B573)
B04_B577:
    rts

; control flow target (from $B331, $B397, $B40D, $B4D7)
    sta $4B ; flag for whether to display the selectable or non-selectable monster list

    ldx #$00
    txa
    sta $A7
; control flow target (from $B59A)
B04_B57F:
    jsr $9ED2 ; given an index (in A) into the array of structures at $0663, set $BF-$C0 to the address of the corresponding item inside that structure

    ldy #$09
    lda ($BF),Y
    beq B04_B594
    sta $061D,X ; monster group 1 monster count

    ldy #$00
    lda ($BF),Y
    sta $061C,X ; monster group 1 monster ID

    inx
    inx
; control flow target (from $B586)
B04_B594:
    inc $A7
    lda $A7
    cmp #$04
    bcc B04_B57F
    cpx #$08
    bcs B04_B5A5
    lda #$00
    sta $061C,X ; monster group 1 monster ID

; control flow target (from $B59E)
B04_B5A5:
    lda #$04
    sta $94 ; return bank for various function calls, doubles as index of selected option for multiple-choice menus

; call to code in a different bank ($0F:$F51B)
    jsr $F51B ; display appropriate battle menu monster list

    ldy $4B ; flag for whether to display the selectable or non-selectable monster list

    beq B04_B5B1
    rts

; control flow target (from $B5AE)
B04_B5B1:
    cmp #$FF
    beq B04_B5D1
    tax
    inx
    lda #$00
    sta $A7
; control flow target (from $B5CD)
B04_B5BB:
    jsr $9ED2 ; given an index (in A) into the array of structures at $0663, set $BF-$C0 to the address of the corresponding item inside that structure

    ldy #$09
    lda ($BF),Y
    beq B04_B5C7
    dex
    beq B04_B5CF
; control flow target (from $B5C2)
B04_B5C7:
    inc $A7
    lda $A7
    cmp #$04
    bcc B04_B5BB
; control flow target (from $B5C5)
B04_B5CF:
    lda $A7
; control flow target (from $B5B3)
B04_B5D1:
    rts

; control flow target (from $B3AF)
    pha
    lda #$04
    sta $94 ; return bank for various function calls, doubles as index of selected option for multiple-choice menus

    pla
; call to code in a different bank ($0F:$F49E)
    jmp $F49E

; control flow target (from $B477)
    pha
    lda #$04
    sta $94 ; return bank for various function calls, doubles as index of selected option for multiple-choice menus

    pla
; call to code in a different bank ($0F:$F4B0)
    jmp $F4B0 ; given hero ID in A, display that hero's battle item list window and return the selected item ID in A


; control flow target (from $B41E, $B4C9)
    lda #$04
    sta $94 ; return bank for various function calls, doubles as index of selected option for multiple-choice menus

; call to code in a different bank ($0F:$F529)
    jmp $F529 ; display appropriate battle menu item/spell target


; control flow target (from $B33C, $B349, $B377)
    jsr $9EC8 ; given an index (in A) into the array of hero data structures at $062D, set $C3-$C4 to the address of the corresponding item inside that structure

    ldy #$00
    lda ($C3),Y
    and #$C0
    cmp #$80
    rts

; control flow target (from $94D8)
    ldx #$00
    lda #$FF
    sta $05FE ; number of monsters in current group killed by last attack?

; control flow target (from $B604)
B04_B5FE:
    sta $0162,X
    inx
    cpx #$14
    bcc B04_B5FE
    lda #$00
    sta $A7
    sta $A9
; control flow target (from $B669)
B04_B60C:
    lda $A9
    jsr $9EEE ; given an index (in A) into the array of structures at $0663, set $B5-$B6 to the address of the corresponding item inside that structure

    ldy #$00
    lda ($B5),Y
    sta $015F
    jsr $9EDC ; given an index + 1 (in A) into the array of enemy stat structures at $B7F5, set $BB-$BC to the address of the corresponding item inside that structure

    lda #$FF
    ldy #$0A
    sta ($B5),Y
    lda #$01
    sta $A8
; control flow target (from $B661)
B04_B625:
    ldy $A8
    lda ($B5),Y
    bne B04_B65B
    inc $05FE ; number of monsters in current group killed by last attack?

    lda $A7
    jsr $9EE9 ; given an index (in A) into the array of structures at $068F, set $B7-$B8 to the address of the corresponding item inside that structure

    lda $A7
    ldy $A8
    sta ($B5),Y
    sta $015E
    tya
    ldy #$02
    sta ($B7),Y
    lda $A9
    ldy #$03
    sta ($B7),Y
    lda #$00
    ldy #$00
    sta ($B7),Y
    jsr $B7A4
    jsr $B6AB
    inc $A7
    lda $A7
    cmp #$08
    bcs B04_B683
; control flow target (from $B629)
B04_B65B:
    inc $A8
    lda $A8
    cmp #$09
    bcc B04_B625
    inc $A9
    lda $A9
    cmp #$04
    bcc B04_B60C
; control flow target (from $B680)
    lda $A7
    cmp #$08
    bcs B04_B683
    jsr $9EE9 ; given an index (in A) into the array of structures at $068F, set $B7-$B8 to the address of the corresponding item inside that structure

    lda #$FF
    ldy #$03
    sta ($B7),Y
    ldy #$02
    sta ($B7),Y
    inc $A7
    jmp $B66B

; control flow target (from $B659, $B66F)
B04_B683:
    lda #$00
; control flow target (from $B697)
B04_B685:
    pha
    jsr $9EE4 ; given an index (in A) into the array of hero data structures at $062D, set $B9-$BA to the address of the corresponding item inside that structure

    ldy #$0C
    lda ($B9),Y
    ldy #$0D
    sta ($B9),Y
    pla
    tax
    inx
    txa
    cmp #$03
    bcc B04_B685
    lda #$00
    tax
; control flow target (from $B6A2)
B04_B69C:
    sta $0626,X ; EXP earned this battle or current hero's current EXP, byte 0

    inx
    cpx #$06
    bcc B04_B69C
    sta $06E6
    sta $06EC
    rts

; control flow target (from $AE0C, $B650)
    ldy #$06
    lda ($BB),Y
    ldy #$06
    sta ($B7),Y
    ldy #$00
    lda ($BB),Y
    sta $99
    lsr $99
    lsr $99
    lda #$00
    sta $9A
; call to code in a different bank ($0F:$C3AB)
    jsr $C3AB ; generate a random number and store it in $32-$33 (two passes)

    lda $32 ; RNG byte 0

    sta $9B
    jsr $A05B ; 16-bit multiplication: ($99-$9A) = ($99-$9A) * ($9B), overflow in $9E, copy of ($99-$9A) in ($A1-$9D)

    ldy #$00
    lda ($BB),Y
    sec
    sbc $9D
    ldy #$04
    sta ($B7),Y
    iny
    lda #$00
    sta ($B7),Y
    rts

; control flow target (from $9571, $9585)
    lda #$00
    sta $A7
    sta $A5
; control flow target (from $B6FF)
B04_B6E2:
    jsr $9EE4 ; given an index (in A) into the array of hero data structures at $062D, set $B9-$BA to the address of the corresponding item inside that structure

    ldy #$00
    lda ($B9),Y
    bpl B04_B6F9
    lda $A5
    ldx $A7
    sta $06C7,X
    ldy #$0A
    lda ($B9),Y
    jsr $B790
; control flow target (from $B6E9)
B04_B6F9:
    inc $A5
    lda $A5
    cmp #$03
    bcc B04_B6E2
    lda #$00
    sta $A5
; control flow target (from $B736)
B04_B705:
    jsr $9EEE ; given an index (in A) into the array of structures at $0663, set $B5-$B6 to the address of the corresponding item inside that structure

    ldy #$00
    lda ($B5),Y
    jsr $9EDC ; given an index + 1 (in A) into the array of enemy stat structures at $B7F5, set $BB-$BC to the address of the corresponding item inside that structure

    lda #$01
    sta $A6
; control flow target (from $B72E)
B04_B713:
    tay
    lda ($B5),Y
    cmp #$08
    bcs B04_B728
    adc #$10
    ldx $A7
    sta $06C7,X
    ldy #$04
    lda ($BB),Y
    jsr $B790
; control flow target (from $B718)
B04_B728:
    inc $A6
    lda $A6
    cmp #$09
    bcc B04_B713
    inc $A5
    lda $A5
    cmp #$04
    bcc B04_B705
    lda #$FF
    ldx $A7
; control flow target (from $B744)
    cpx #$0B
    bcs B04_B747
    sta $06C7,X
    inx
    jmp $B73C

; control flow target (from $B73E)
B04_B747:
    lda $A7
    cmp #$02
    bcs B04_B74E
    rts

; control flow target (from $B74B)
B04_B74E:
    ldx #$00
; control flow target (from $B78C)
    lda $06D2,X
    sta $A8
    stx $A9
    txa
    tay
    iny
; control flow target (from $B76B)
B04_B75A:
    lda $A8
    cmp $06D2,Y
    bcs B04_B768
    lda $06D2,Y
    sta $A8
    sty $A9
; control flow target (from $B75F)
B04_B768:
    iny
    cpy $A7
    bcc B04_B75A
    ldy $A9
    lda $06C7,Y
    sta $A8
    lda $06D2,X
    sta $06D2,Y
    lda $06C7,X
    sta $06C7,Y
    lda $A8
    sta $06C7,X
    inx
    inx
    cpx $A7
    bcs B04_B78F
    dex
    jmp $B750

; control flow target (from $B789)
B04_B78F:
    rts

; control flow target (from $B6F6, $B725)
    lsr
    sta $99
; call to code in a different bank ($0F:$C3AB)
    jsr $C3AB ; generate a random number and store it in $32-$33 (two passes)

    lda $32 ; RNG byte 0

    adc $99
    bcc B04_B79E
    lda #$FF
; control flow target (from $B79A)
B04_B79E:
    sta $06D2,X
    inc $A7
    rts

; control flow target (from $AE09, $B64D)
    ldy #$01
; control flow target (from $B7C6)
B04_B7A6:
    ldx #$00
    stx $99
; control flow target (from $B7BD)
B04_B7AA:
    lda $0162,X
    cmp $015F
    bne B04_B7BA
    tya
    cmp $016A,X
    bne B04_B7BA
    inc $99
; control flow target (from $B7B0, $B7B6)
B04_B7BA:
    inx
    cpx #$08
    bcc B04_B7AA
    lda $99
    beq B04_B7CA
    iny
    cpy #$09
    bcc B04_B7A6
    ldy #$00
; control flow target (from $B7C1)
B04_B7CA:
    ldx $015E
    lda $015F
    sta $0162,X
    tya
    sta $016A,X
    cmp #$02
    bcs B04_B7DC
    rts

; control flow target (from $B7D9)
B04_B7DC:
    ldx #$03
; control flow target (from $B7EB)
B04_B7DE:
    lda $0172,X
    cmp #$FF
    beq B04_B7EE
    cmp $015F
    beq B04_B7F4
    dex
    bpl B04_B7DE
    rts

; control flow target (from $B7E3)
B04_B7EE:
    lda $015F
    sta $0172,X
; control flow target (from $B7E8)
B04_B7F4:
    rts


; code -> data
; Enemy Stats (Max HP, [4-bit evade chance / 64, 4-bit unused], Max Gold dropped, EXP low byte, AGI, Attack Power, Defense Power, [2-bit attack probability list, 3-bit Sleep res., 3-bit spell damage res.], [2-bit EXP * 256, 3-bit Defeat res., 3-bit Stopspell res.], [2-bit EXP * 1024, 3-bit Defense res., 3-bit Surround res.], [4-bit Attack command 1, 4-bit Attack command 2], [4-bit Attack command 3, 4-bit Attack command 4], [4-bit Attack command 5, 4-bit Attack command 6], [4-bit Attack command 7, 4-bit Attack command 8], 8*1-bit use alternate attack command)
; indirect data load target (via $9F27)
; EXP per level, low byte
.byte $05,$10,$02,$01,$03,$07,$05,$40,$07,$00,$50,$50,$00,$00,$00,$08
.byte $00,$03,$02,$03,$09,$06,$00,$07,$00,$00,$00,$00,$00,$00,$05,$10
.byte $04,$02,$04,$0B,$0D,$00,$07,$00,$00,$00,$00,$00,$00,$09,$00,$03
.byte $03,$05,$0C,$08,$40,$07,$01,$05,$00,$00,$00,$00,$0A,$10,$05,$05
.byte $08,$0E,$0B,$80,$07,$02,$50,$00,$00,$55,$00,$19,$00,$05,$0F,$14
.byte $0F,$0A,$5B,$0F,$00,$CC,$CC,$0C,$CC,$00,$0C,$20,$06,$06,$08,$12
.byte $0A,$00,$07,$00,$00,$00,$00,$00,$00,$0D,$10,$04,$08,$09,$10,$0D
.byte $08,$07,$00,$00,$00,$20,$2E,$80,$0C,$00,$02,$04,$08,$13,$0D,$50
.byte $0F,$01,$00,$C0,$00,$CC,$C4,$0F,$00,$0A,$0A,$0B,$11,$0B,$40,$08
.byte $01,$56,$06,$06,$05,$00,$10,$20,$05,$07,$0F,$13,$0B,$80,$0F,$02
.byte $50,$00,$00,$5E,$80,$0E,$10,$09,$09,$0B,$16,$0A,$48,$0F,$02,$22
.byte $22,$00,$00,$00,$0E,$10,$08,$12,$14,$12,$0D,$50,$00,$02,$22,$20
.byte $00,$0E,$87,$0C,$10,$0A,$0C,$0E,$0E,$0A,$50,$03,$02,$00,$00,$00
.byte $00,$1F,$15,$00,$1E,$0E,$0D,$19,$28,$08,$0F,$00,$00,$02,$00,$00
.byte $00,$14,$00,$32,$19,$0C,$1C,$10,$08,$07,$01,$33,$30,$30,$00,$00
.byte $0F,$20,$0C,$1B,$10,$14,$0A,$50,$0B,$01,$66,$06,$00,$60,$00,$3C
.byte $00,$19,$28,$0C,$1F,$07,$78,$3F,$01,$00,$40,$04,$4E,$84,$0F,$40
.byte $28,$10,$0F,$0E,$28,$91,$0A,$11,$33,$30,$00,$00,$07,$19,$20,$0F
.byte $17,$29,$29,$0C,$C8,$07,$03,$50,$C0,$C0,$05,$14,$28,$20,$2D,$14
.byte $14,$30,$0C,$90,$07,$02,$05,$00,$00,$05,$00,$20,$00,$10,$1D,$0C
.byte $20,$0B,$50,$07,$07,$B0,$B0,$B0,$00,$15,$14,$10,$19,$21,$0D,$27
.byte $6E,$48,$07,$0A,$00,$02,$05,$15,$00,$20,$00,$50,$22,$10,$26,$0B
.byte $6A,$1F,$0A,$B0,$23,$C5,$15,$11,$2A,$20,$1D,$24,$16,$23,$0D,$00
.byte $08,$00,$2D,$D2,$00,$00,$0F,$28,$10,$1E,$25,$19,$24,$0E,$A1,$0A
.byte $09,$36,$66,$50,$21,$C1,$1C,$20,$23,$20,$16,$1E,$09,$79,$17,$13
.byte $00,$00,$0F,$F0,$60,$2D,$10,$2D,$28,$12,$2D,$0C,$50,$0F,$08,$50
.byte $00,$C0,$0C,$90,$30,$10,$32,$2C,$1F,$33,$10,$8A,$1F,$0A,$00,$D0
.byte $01,$10,$04,$3C,$10,$17,$34,$1E,$39,$14,$9A,$1C,$12,$20,$90,$70
.byte $95,$11,$2E,$00,$19,$1F,$17,$2D,$12,$52,$1F,$0B,$A2,$A2,$02,$A2
.byte $45,$2E,$00,$28,$2C,$01,$3A,$02,$78,$2F,$12,$00,$00,$00,$00,$00
.byte $1A,$20,$1E,$32,$1E,$1E,$78,$8E,$1C,$04,$40,$14,$10,$42,$FD,$19
.byte $50,$37,$28,$30,$46,$14,$90,$17,$13,$00,$00,$00,$D1,$40,$28,$10
.byte $2B,$3B,$23,$33,$15,$78,$1F,$08,$77,$77,$70,$05,$1F,$33,$00,$50
.byte $32,$1E,$3A,$13,$50,$27,$1B,$05,$F0,$00,$05,$04,$41,$10,$28,$2D
.byte $21,$3F,$11,$10,$3F,$13,$00,$00,$00,$0E,$80,$26,$20,$3A,$29,$29
.byte $4B,$19,$90,$1F,$12,$22,$22,$22,$25,$00,$32,$00,$1C,$19,$27,$37
.byte $10,$38,$27,$07,$CC,$0C,$0C,$0C,$AB,$3C,$10,$32,$3D,$24,$4B,$17
.byte $51,$27,$09,$50,$00,$00,$05,$00,$3C,$00,$64,$34,$5A,$40,$18,$33
.byte $3F,$36,$11,$1F,$FF,$F1,$FF,$4B,$10,$3C,$3E,$2A,$46,$1A,$BC,$27
.byte $1C,$53,$03,$00,$0E,$80,$3F,$10,$2D,$43,$2D,$48,$1B,$9A,$27,$24
.byte $03,$0F,$30,$F5,$5A,$32,$10,$1E,$27,$2D,$3C,$50,$B9,$1F,$0B,$23
.byte $04,$32,$04,$BB,$5F,$00,$33,$3D,$22,$3B,$0A,$2A,$3F,$0A,$20,$B0
.byte $2B,$2E,$A4,$3C,$10,$2D,$40,$33,$4B,$1B,$91,$11,$09,$50,$30,$00
.byte $95,$04,$37,$10,$28,$48,$2B,$3D,$1C,$91,$12,$12,$73,$70,$07,$15
.byte $42,$06,$10,$5A,$87,$64,$0A,$B4,$7F,$3F,$3F,$56,$66,$25,$55,$10
.byte $41,$10,$2D,$43,$46,$52,$19,$59,$17,$09,$00,$00,$00,$05,$00,$32
.byte $00,$19,$5C,$37,$4D,$1E,$51,$1F,$10,$B0,$B0,$FF,$00,$35,$3C,$20
.byte $53,$51,$34,$4A,$1D,$90,$19,$14,$00,$40,$00,$01,$54,$3C,$00,$1E
.byte $26,$31,$48,$18,$A1,$17,$3F,$CC,$00,$05,$5E,$83,$64,$10,$FF,$3F
.byte $39,$50,$38,$92,$2A,$0C,$50,$00,$00,$05,$00,$43,$10,$30,$54,$4B
.byte $49,$1C,$93,$1E,$0B,$E7,$E7,$10,$05,$50,$50,$30,$64,$3D,$29,$78
.byte $13,$9A,$18,$09,$66,$66,$66,$60,$00,$39,$10,$31,$55,$30,$4B,$19
.byte $52,$17,$09,$DD,$0D,$00,$C0,$4B,$48,$10,$50,$59,$35,$5D,$1C,$9A
.byte $23,$0B,$00,$00,$00,$00,$84,$50,$10,$37,$51,$47,$5F,$4C,$3C,$17
.byte $02,$00,$00,$00,$0E,$80,$46,$10,$96,$52,$3D,$37,$50,$DC,$2F,$01
.byte $DD,$D1,$10,$00,$07,$45,$20,$69,$8B,$39,$50,$1F,$9B,$23,$1B,$A0
.byte $70,$73,$2C,$F0,$43,$00,$51,$5D,$37,$4A,$16,$BC,$17,$25,$B4,$40
.byte $B0,$FF,$D7,$3C,$10,$5F,$47,$40,$55,$1F,$88,$1A,$13,$30,$00,$30
.byte $30,$51,$6E,$10,$87,$9A,$3C,$63,$23,$D2,$23,$12,$0D,$DD,$AA,$00
.byte $00,$41,$10,$67,$B6,$4F,$4D,$15,$AA,$1F,$12,$02,$70,$27,$02,$FF
.byte $58,$20,$7B,$75,$41,$77,$17,$A0,$27,$12,$00,$00,$00,$0E,$80,$23
.byte $00,$FF,$1A,$C8,$4B,$FF,$3F,$3F,$7F,$77,$74,$55,$55,$08,$50,$80
.byte $87,$C9,$47,$7D,$24,$B9,$2B,$13,$AD,$00,$00,$10,$2A,$73,$40,$63
.byte $47,$3F,$79,$20,$58,$57,$19,$00,$00,$00,$15,$00,$78,$00,$78,$D3
.byte $5A,$73,$E6,$FF,$BF,$02,$DD,$DD,$11,$D1,$4F,$5F,$50,$93,$5E,$45
.byte $82,$38,$FB,$77,$1B,$88,$00,$88,$07,$B3,$9E,$50,$64,$69,$8C,$5C
.byte $26,$BB,$BF,$0C,$FF,$8F,$08,$15,$D0,$37,$00,$65,$F5,$4E,$63,$20
.byte $97,$17,$15,$88,$8C,$C8,$C8,$FF,$59,$50,$60,$0F,$5A,$5C,$23,$B9
.byte $67,$14,$B7,$7B,$7B,$BB,$A8,$5A,$40,$71,$C5,$55,$6F,$21,$32,$5F
.byte $1A,$50,$05,$05,$05,$FF,$9B,$10,$5F,$03,$64,$91,$29,$3A,$B7,$12
.byte $00,$00,$10,$01,$00,$70,$60,$64,$8C,$6E,$6C,$27,$B3,$72,$12,$60
.byte $77,$8B,$0B,$B1,$D2,$70,$6E,$68,$96,$8C,$50,$64,$F7,$12,$88,$8D
.byte $88,$8D,$CC,$FA,$70,$FA,$4C,$3F,$C3,$C8,$3F,$3F,$52,$DD,$DD,$DD
.byte $DE,$FF,$FA,$70,$F0,$FA,$4B,$7F,$A0,$9C,$7F,$66,$68,$57,$25,$DB
.byte $75,$FA,$00,$FF,$98,$78,$C8,$DC,$AD,$37,$80,$BB,$88,$88,$D1,$F0
.byte $E6,$00,$00,$00,$96,$B4,$BB,$FB,$3C,$3F,$BB,$B8,$82,$BD,$E0
.byte $FA,$70,$00,$00,$6E,$FF,$FF,$3F
.byte $3F,$14,$9B,$93
.byte $B3,$99
.byte $C5
; Exp needed for Midenhall
; indexed data load target (from $9D5E)
; EXP per level, high byte
.byte $0C
; indexed data load target (from $9D61, $9D6D)

.byte $00,$14,$00,$28,$00,$44,$00,$8C,$00,$18,$01,$B8,$01,$20,$03,$E8
.byte $03,$4C,$04,$78,$05,$FC,$08,$60,$09,$B8,$0B,$A0,$0F,$A0,$0F,$88
.byte $13,$70,$17,$40,$1F,$10,$27,$E0,$2E,$C8,$32,$98,$3A,$68,$42,$20
.byte $4E,$D8,$59,$A8,$61,$A8,$61,$30,$75,$30,$75,$30,$75,$30,$75,$30
.byte $75,$30,$75,$30,$75,$30,$75,$30,$75,$30,$75,$30,$75,$40,$9C,$50
.byte $C3,$50,$C3,$50,$C3,$50,$C3,$50,$C3
.byte $50,$C3,$50,$C3
.byte $50,$C3
.byte $30
.byte $75
; Exp needed for Cannock

.byte $18,$00,$24,$00,$32,$00,$5A,$00,$B4,$00,$40,$01,$58,$02,$4C,$04
.byte $40,$06,$D0,$07,$98,$08,$F0,$0A,$A0,$0F,$A0,$0F,$88,$13,$70,$17
.byte $58,$1B,$28,$23,$F8,$2A,$C8,$32,$98,$3A,$98,$3A,$80,$3E,$50,$46
.byte $F0,$55,$90,$65,$60,$6D,$30,$75,$40,$9C,$30,$75,$30,$75,$40,$9C
.byte $50,$C3,$50,$C3,$40,$9C,$60,$EA,$60,$EA,$60,$EA
.byte $60,$EA,$60,$EA,$20,$4E
.byte $60,$EA,$60
.byte $EA,$40
.byte $9C
; Exp needed for Moonbrooke
; starting STR
.byte $64,$00,$C8,$00,$2C,$01,$58,$02,$B0,$04,$08,$07,$98,$08,$28,$0A
.byte $B8,$0B,$A0,$0F,$A0,$0F,$88,$13,$70,$17,$40,$1F,$F8,$2A,$98,$3A
.byte $50,$46,$20,$4E,$F0,$55,$A8,$61,$30,$75,$40,$9C,$50,$C3,$30,$75
.byte $30,$75,$30,$75,$40,$9C,$50,$C3,$90,$5F
.byte $90,$5F,$A0,$86,$90
.byte $5F,$90,$5F
.byte $90
.byte $5F
; Midenhall
; indexed data load target (from $9DDE)
; starting AGI
.byte $05
; indexed data load target (from $9DE3)
; starting Max HP
.byte $04
; indexed data load target (from $9DE8)
; starting Max MP
.byte $1C
; indexed data load target (from $9DED)
; Cannock
.byte $00
; Moonbrooke
.byte $04,$04
.byte $1F
.byte $06
; level up stat nybbles (STR/AGI, HP/MP)
.byte $02,$16
.byte $20
.byte $1C
; indexed data load target (from $9DFD, $9E07, $9E97)
; base offset for equipment power list at $BEEB
.byte $21,$90,$03,$36,$04,$00,$52,$30,$22,$14,$00,$57,$50,$80,$12,$32
.byte $12,$09,$15,$40,$04,$22,$05,$14,$26,$30,$14,$22,$17,$10,$93,$10
.byte $12,$05,$12,$12,$13,$20,$60,$25,$15,$52,$30,$00,$07,$12,$13,$56
.byte $34,$20,$14,$24,$15,$65,$52,$20,$14,$32,$01,$26,$33,$10,$20,$23
.byte $12,$12,$54,$10,$87,$22,$15,$34,$40,$10,$35,$53,$16,$65,$24,$30
.byte $40,$42,$13,$76,$36,$20,$57,$24,$36,$5C,$32,$50,$02,$48,$23,$9C
.byte $50,$30,$13,$33,$14,$89,$33,$40,$16,$73,$22,$89,$64,$D0,$23,$40
.byte $09,$77,$63,$60,$24,$48,$34,$C3,$66,$90,$24,$41,$2A,$92,$41,$90
.byte $12,$86,$47,$7B,$34,$60,$23,$74,$40,$57,$50,$90,$10,$74,$23,$15
.byte $43,$80,$23,$C0,$13,$49,$46,$B0,$18,$D3,$05,$17,$53,$A0,$40,$55
.byte $14,$15,$44,$70,$76,$96,$33,$71,$52,$30,$31,$13,$25,$15,$62,$50
.byte $22,$64,$62,$61,$31,$20,$03,$13,$43,$21,$10,$80,$A2,$13,$46,$27
.byte $22,$20,$51,$22,$43,$16,$12,$20,$72,$25,$A6,$95,$21,$50,$83
.byte $30,$22,$30,$90,$33,$32,$10
.byte $64,$52,$12,$40
.byte $03,$47
.byte $13
; indexed data load target (from $9E5F)
; levels for learning spells
.byte $10,$50,$23,$22,$40,$25,$82,$12,$10,$86,$03,$31,$40,$12,$44,$12
.byte $00,$45,$26,$03,$50,$52,$45,$15,$10
.byte $13,$10,$37,$70
.byte $12,$60
.byte $48
.byte $50
; Cannock level for learning battle spells
; indexed data load target (from $9EB0)
; Cannock level for learning field spells
.byte $03,$08,$12,$17
.byte $01,$0E
.byte $14
.byte $1C
; Moonbrooke level for learning battle spells
.byte $01,$06,$0A,$0C
.byte $0E,$11
.byte $19
.byte $FF
; Moonbrooke level for learning field spells
.byte $02,$04,$06,$13
.byte $01,$0A
.byte $0F
.byte $19
; equipment power list
.byte $01,$08,$0C,$0F
.byte $11,$15
.byte $17
.byte $FF
; referenced as $BEAA

.byte $02,$0C,$08,$0F,$08,$0A,$0F,$14
.byte $05,$1E,$23,$5D
.byte $32,$41
.byte $28
.byte $50

.byte $02,$14,$23,$1E,$06,$0C
.byte $32,$19,$19
.byte $23
.byte $28

.byte $04,$12,$0A
.byte $1E
.byte $14
; monster drop rates/items
.byte $04,$06
.byte $14
; indexed data load target (from $97A8)

.byte $FC,$BC,$3C,$85,$3C,$B3,$51,$46,$7C,$01,$75,$3B,$33,$45,$55,$B5
.byte $33,$55,$51,$3C,$45,$73,$1C,$86,$7B,$70,$74,$7C,$47,$75,$7B,$11
.byte $74,$46,$70,$83,$73,$74,$FD,$48,$FD,$91,$34,$92,$FD,$AF,$52,$62
.byte $48,$99,$16,$06,$B0,$43,$07,$75,$DF,$48,$4A,$6F,$9F,$22,$33,$E1
.byte $4B,$31,$D0,$B0,$5E,$8C,$84,$98,$4D
.byte $43,$0C,$97,$BD,$CC
.byte $E1,$44
.byte $E1
.byte $00
; data -> free
.res $76
; ... skipping $76 FF bytes
.byte $FF

.byte $FF
; free -> unknown

.byte $78,$EE,$DF,$BF,$4C,$86,$FF,$80
.literal "DRAGON WARRIORS2"
.byte $FF,$FF,$00,$00,$48,$04,$01,$0F
.byte $07,$9D,$D8,$BF,$D8,$BF,$D8,$BF

