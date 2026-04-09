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

; possible external indexed data load target (from $0F:$F3ED, $0F:$FF28)
; possible external indexed data load target (from $0F:$F3F2, $0F:$FF2D)
B04_8000:
    jmp B04_8022
B04_8003:
; restore the hero ID in A's MP by a random amount based on the Wizard's Ring's power; returns a random number between $03 and #$0A in A and $99
    jmp B04_A49E
B04_8006:
; heal hero ID in A by random amount based on healing power in X
    jmp B04_A402
B04_8009:
; update each hero's stats based on their current EXP
    jmp B04_9D0E
B04_800C:
; set $8F-$90 to EXP required to reach next level
    jmp B04_9CF1
B04_800F:
; trigger fixed battle A
    jmp B04_82B9
B04_8012:
    jmp B04_99E6
B04_8015:
    jmp B04_8FE7
B04_8018:
    jmp B04_801D

    .addr 0

B04_801D:
    lda #$01 ; Terrain ID #$01: Transitions, Chamber of Horks
    jmp B04_8024

B04_8022:
    lda #$02 ; Terrain ID #$02: Dungeon, Lava, Tower, Castle
B04_8024:
    pha
    lda #$00
    sta $98 ; outcome of last fight?
    lda #$08 ; maximum # of attempts at starting a battle
    sta $D9
B04_802D:
    jsr B0F_C3AB ; generate a random number and store it in $32-$33 (two passes)

    lda $32 ; RNG byte 0
    beq B04_802D ; keep cycling through random numbers until $32 is not #$00; we'll maybe use $32 later on
    pla
    tax

    lda map_id
    cmp #$01 ; Map ID #$01: World Map
    beq B04_806E ; determine world map battle formation
    cmp #$09 ; Map ID #$09: Moonbrooke
    beq @B04_8066 ; override terrain ID to Terrain ID #$02: Dungeon, Lava, Tower, Castle and use battle formation #$11: Zombie, Big Cobra, ---, Smoke, Centipod, Metal Slime
    sec
    sbc #$2B ; aside from the world map and Moonbrooke, map IDs < #$2B do not have random encounters
    bcc B04_806D ; no encounter
    tay
    lda Dungeon_Formations, y ; Dungeon Encounter Formations
    cpx #$01 ; Terrain ID #$01: Transitions, Chamber of Horks
    beq B04_80A4 ; use the current battle formation ID
    cpy #$0C ; Map ID #$37: Cave to Rhone B1
    beq @B04_805C ; override terrain ID to Terrain ID #$01: Transitions, Chamber of Horks
    cpy #$12 ; Map ID #$3D: Cave to Rhone 4F
    beq @B04_8061 ; override terrain ID to Terrain ID #$07: Cave to Rhone floors 5-7
    cpy #$13 ; Map ID #$3E: Cave to Rhone 5F
    beq @B04_8061 ; override terrain ID to Terrain ID #$07: Cave to Rhone floors 5-7
    jmp B04_80A4

; override terrain ID to Terrain ID #$01: Transitions, Chamber of Horks
    @B04_805C:
    ldx #$01 ; Terrain ID #$01: Transitions, Chamber of Horks
    jmp B04_80A4

; override terrain ID to Terrain ID #$07: Cave to Rhone floors 5-7
    @B04_8061:
    ldx #$07 ; Terrain ID #$07: Cave to Rhone floors 5-7
    jmp B04_80A4

; override terrain ID to Terrain ID #$02: Dungeon, Lava, Tower, Castle and use battle formation #$11: Zombie, Big Cobra, ---, Smoke, Centipod, Metal Slime
    @B04_8066:
    ldx #$02 ; Terrain ID #$02: Dungeon, Lava, Tower, Castle
    lda #$11
    jmp B04_80A4

; no encounter
B04_806D:
    rts

; determine world map battle formation
B04_806E:
    lda map_xpos

    ; world map encounters are based on which 16x16 block you're in
    lsr
    lsr
    lsr
    lsr
    sta $D5
    lda map_ypos

    and #$F0
    ora $D5 ; $D5 = high nybble of Y-pos | (high nybble of X-pos >> 4)

    tax
    lda WorldMap_Encounters, x ; World Map Encounters

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
    ; ocean battle formations come after terrestrial battle formations; why not just ADC #$40 directly?
    adc Battle_Formations_sizeof

    jmp B04_80A6

    B04_809E:
    ; no encounter; terrains #$01 and #$02 are invalid on the world map
    bcc B04_806D
    ; Terrain ID #$07: Cave to Rhone floors 5-7
    cpx #$07
    ; no encounter; terrains >= #$07 are invalid on the world map
    bcs B04_806D

B04_80A4:
    and #$3F
B04_80A6:
    sta $D8 ; battle formation index
    lda B04_832C, x ; per-terrain encounter rates
    cmp $32 ; RNG byte 0; compare to previously generated non-zero number
    bcc B04_806D ; no encounter; encounter rate < RNG => no encounter

B04_80AF:
    dec $D9 ; maximum # of attempts at starting a battle

    beq B04_80B9
    lda $D8 ; battle formation index

    cmp #$3F ; #$3F => no encounters

    bne B04_80BA
    B04_80B9:
    rts

B04_80BA:
    ldx #$00 ; pointer high byte offset
    asl
    bcc B04_80C1 ; high bit of battle formation is never set, but if it were, this would add 3 to the high byte of the battle formation pointer

    ldx #$03
B04_80C1:
    sta $D5 ; $D5 = battle formation * 2

    asl
    bcc B04_80C7 ; if second highest bit of battle formation is set, add 1 to the high byte of the battle formation pointer

    inx
B04_80C7:
    clc
    adc $D5
    bcc B04_80CD ; if (battle formation * 6) overflows, add 1 to the high byte of the battle formation pointer

    inx
B04_80CD:
    clc
    adc B04_8334 ; -> $04:$8509: Battle Formations

    sta $D5 ; $D5 = low byte of pointer to desired battle formation

    txa
    adc B04_8334+1
    sta $D6 ; battle formation; $D6 = high byte of pointer to desired battle formation

    jsr B04_837e ; initialize enemy group data at $0663-$068F to #$FF

    jsr B0F_C3AB ; generate a random number and store it in $32-$33 (two passes)

    lda $32 ; RNG byte 0

    and #$07
    bne B04_813B ; 1/8 chance for a special formation

    ldy #$00
    sty $D7 ; high bits of IDs in selected battle formation

B04_80E9:
    lda ($D5), y ; copy the high bits of the regular formation's 6 enemies into $D7

    asl
    rol $D7 ; high bits of IDs in selected battle formation

    iny
    cpy #$06 ; battle formation data is 6 bytes each

    bne B04_80E9
    lda $D7 ; high bits of IDs in selected battle formation

    cmp #$3F
    bne B04_80FC ; if all 6 enemies had their high bit set, try again with a different random number

    jmp B04_80AF ; otherwise loop to try again


B04_80FC:
    asl ; special formations are 4 bytes each

    asl
    tax
    ldy #$00
B04_8101:
    lda Special_Formations, x ; Special Formations

    and #$7F
    cmp #$7F
    beq B04_810D ; #$FF and #$7F => no enemy

    sta $0663, y ; monster ID, group 1; store monster ID

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
    jmp B04_81F5

B04_813B:
    cmp #$07 ; low 3 bits of RNG byte 0 are not all 0; check if they're all 1

    bne B04_8154
    ldy #$05
    lda ($D5), y
    and #$7F
    cmp #$7F
    bne B04_814C
    jmp B04_80AF

B04_814C:
    ldx #$02
    jsr B04_83A3
    jmp B04_81F5

B04_8154:
    cmp #$06
    bne B04_817A
    ldy #$04
    lda ($D5), y
    and #$7F
    cmp #$7F
    bne B04_8165
    jmp B04_80AF

B04_8165:
    ldx #$02
    jsr B04_83B7 ; given a monster group index in X, write the monster ID in A to the appropriate monster group data at $0663

    lda $32 ; RNG byte 0

    lsr
    lsr
    lsr
    and #$03
    clc
    adc #$03
    sta $066C, y
    jmp B04_81F5

B04_817A:
    cmp #$05
    bne B04_81B2
    ldy #$03
    lda ($D5), y
    and #$7F
    cmp #$7F
    bne B04_818B
    jmp B04_80AF

B04_818B:
    ldx #$02
    jsr B04_83A3
    ldx #$00
    jsr B04_8389 ; take current RNG value $33, figure out which $8398 bucket it fits into, and store that index in Y

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
B04_81A6:
    dey
    jsr B04_83AC ; given a weird value <= #$03 in Y, get the monster ID from ($D5), y and if it's not #$FF/#$7F, get the monster group index corresponding to Y from B04_83BE and write the monster ID to the appropriate monster group data at $0663

    pla
    tay
B04_81AC:
    jsr B04_83AC ; given a weird value <= #$03 in Y, get the monster ID from ($D5), y and if it's not #$FF/#$7F, get the monster group index corresponding to Y from B04_83BE and write the monster ID to the appropriate monster group data at $0663

    jmp B04_81F5

B04_81B2:
    tay
    cpy #$02
    bcc B04_81B8
    dey
B04_81B8:
    dey
    sty $D7 ; high bits of IDs in selected battle formation

    lda ($D5), y
    and #$7F
    cmp #$7F
    bne B04_81C6
    jmp B04_80AF

B04_81C6:
    jsr B04_83B4 ; given a weird value <= #$03 in Y, get the corresponding monster group index from B04_83BE and write the monster ID in A to the appropriate monster group data at $0663

    ldx #$07
    jsr B04_8389 ; take current RNG value $33, figure out which $8398 bucket it fits into, and store that index in Y

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
B04_81DF:
    tay
    jsr B04_83AC ; given a weird value <= #$03 in Y, get the monster ID from ($D5), y and if it's not #$FF/#$7F, get the monster group index corresponding to Y from B04_83BE and write the monster ID to the appropriate monster group data at $0663

B04_81E3:
    jmp B04_81F5

B04_81E6:
    lda #$00
B04_81E8:
    pha
    tay
    jsr B04_83AC ; given a weird value <= #$03 in Y, get the monster ID from ($D5), y and if it's not #$FF/#$7F, get the monster group index corresponding to Y from B04_83BE and write the monster ID to the appropriate monster group data at $0663

    pla
    clc
    adc #$01
    cmp #$03
    bne B04_81E8

B04_81F5:
    lda a:$46 ; Repel (#$FE) / Fairy Water (#$FF) flag

    beq B04_824F
    lda map_id

    cmp #$01 ; Map ID #$01: World Map

    bne B04_824F
    lda #$00
    sta $D5
B04_8204:
    tax
    ldy $0663, x ; monster ID, group 1

    cpy #$FF
    beq B04_823A
    lda #$00
    sta $D7 ; high bits of IDs in selected battle formation

    dey
    sty $D6 ; battle formation

    tya
    ldy #$04
B04_8216:
    asl
    rol $D7 ; high bits of IDs in selected battle formation

    dey
    bne B04_8216
    sec
    sbc $D6 ; battle formation

    bcs B04_8223
    dec $D7 ; high bits of IDs in selected battle formation

B04_8223:
    clc
    adc B04_824d
    sta $D6 ; battle formation

    lda $D7 ; high bits of IDs in selected battle formation

    adc B04_824d+1
    sta $D7 ; high bits of IDs in selected battle formation

    ldy #$05
    lda ($D6), y ; battle formation

    cmp $D5
    bcc B04_823A
    sta $D5
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
B04_824d:
.addr $B7F5

B04_824F:
    jsr B0F_C3AB ; generate a random number and store it in $32-$33 (two passes)

    ldx #$00
    stx $D5
B04_8256:
    lda #$FF
    cmp $0663, x ; monster ID, group 1

    beq B04_827D
    cmp $066C, x
    bne B04_8275
    ldy #$04
B04_8264:
    asl $32 ; RNG byte 0; pull 4 bits from RNG, updating RNG in the process

    rol $33 ; RNG byte 1

    rol
    dey
    bne B04_8264
    and #$0F
    tay ; use random 4-bit index

    lda B04_8336, y
    sta $066C, x
B04_8275:
    lda $D5
    clc
    adc $066C, x
    sta $D5
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
B04_8293:
    stx $D6 ; battle formation

B04_8295:
    lda $D5
    cmp $D6 ; battle formation

    bcc B04_82DE
B04_829B:
    iny
    cpy #$04
    bcc B04_82A2
    ldy #$00
B04_82A2:
    ldx B04_837A, y ; pre-computed multiples of #$0B

    lda $0663, x ; monster ID, group 1

    cmp #$FF
    beq B04_829B
    lda $066C, x
    beq B04_829B
    dec $066C, x
    dec $D5
    jmp B04_8295

; trigger fixed battle A
B04_82B9:
    pha
    lda #$00
    sta $98 ; outcome of last fight?

    jsr B04_837e ; initialize enemy group data at $0663-$068F to #$FF

    pla
    asl
    asl
    tax
    ldy #$00
B04_82C7:
    lda B04_8346, x ; Fixed Encounters (group 1 Monster ID, group 1 count, group 2 Monster ID, group 2 count)

    inx
    sta $0663, y ; monster ID, group 1

    lda B04_8346, x ; Fixed Encounters (group 1 Monster ID, group 1 count, group 2 Monster ID, group 2 count)

    inx
    sta $066C, y
    tya
    clc
    adc #$0B
    tay
    cmp #$16
    bne B04_82C7
B04_82DE:
    jsr B04_86ED
    ldx #$00
B04_82E3:
    stx $D6 ; battle formation

    ldy B04_837A, x ; pre-computed multiples of #$0B

    lda #$00
    sta $D5
    lda $066C, y
    beq B04_831A
    lda $0663, y ; monster ID, group 1

    cmp #$FF
    beq B04_831A
B04_82F8:
    ldy $D5
    iny
    ldx $D6 ; battle formation

    jsr B04_8A9E
    ldx $D6 ; battle formation

    ldy B04_837A, x ; pre-computed multiples of #$0B

    bcs B04_831A
    tya
    clc
    adc $D5
    tax
    lda #$00
    sta $0664, x
    inc $D5
    lda $D5
    cmp $066C, y
    bne B04_82F8
B04_831A:
    lda $D5
    sta $066C, y
    ldx $D6 ; battle formation

    inx
    cpx #$04
    bne B04_82E3
    jsr B04_871E
    jmp B04_94B5


; per-terrain encounter rates
B04_832C:
.byte $0A	 ; Terrain ID #$00: Grass
.byte $54	 ; Terrain ID #$01: Transitions, Chamber of Horks
.byte $08	 ; Terrain ID #$02: Dungeon, Lava, Tower, Castle
.byte $04	 ; Terrain ID #$03: Sea
.byte $10	 ; Terrain ID #$04: Forest, Desert
.byte $19	 ; Terrain ID #$05: Mountain
.byte $10	 ; Terrain ID #$06: Swamp
.byte $10	 ; Terrain ID #$07: Cave to Rhone floors 5-7

; -> $04:$8509: Battle Formations
; data load target (from $80CE)
; data load target (from $80D4)
B04_8334:
.addr $8509	 ; $04:$8509; Battle Formations

B04_8336:
.byte $01	 ; # of monsters per group
.byte $02
.byte $01
.byte $02
.byte $03
.byte $01
.byte $02
.byte $01
.byte $02
.byte $03
.byte $01
.byte $02
.byte $01
.byte $02
.byte $03
.byte $05

; Fixed Encounters (group 1 Monster ID, group 1 count, group 2 Monster ID, group 2 count)
B04_8346:
.byte $FF,$00,$1E,$02	 ; 2 Gremlins (Lianport)
.byte $FF,$00,$36,$01	 ; 1 Evil Clown (Midenhall)
.byte $FF,$00,$3A,$01	 ; 1 Saber Lion (Osterfair)
.byte $FF,$00,$3C,$02	 ; 2 Ozwargs (Hamlin)
.byte $FF,$00,$4C,$02	 ; 2 Gold Batboons (Hargon's Castle)
.byte $FF,$00,$1E,$04	 ; 4 Gremlins (Lighthouse)
.byte $FF,$00,$36,$02	 ; 2 Evil Clown (Sea Cave)
.byte $36,$01,$37,$02	 ; 1 Evil Clown, 2 Ghouls (???)
.byte $FF,$00,$4E,$01	 ; 1 Atlas (Hargon's Castle)
.byte $FF,$00,$4F,$01	 ; 1 Bazuzu (Hargon's Castle)
.byte $FF,$00,$50,$01	 ; 1 Zarlox (Hargon's Castle)
.byte $FF,$00,$51,$01	 ; 1 Hargon (Hargon's Castle)
.byte $FF,$00,$52,$01	 ; Malroth (Hargon's Castle)
; pre-computed multiples of #$0B
; indexed data load target (from $82A2, $82E5, $8302)
B04_837A:
.byte 0,11,22,33

B04_837e:
; initialize enemy group data at $0663-$068F to #$FF
    lda #$FF
    ldx #$2C
B04_8382:
    sta $0662, x ; Moonbrooke Level

    dex
    bne B04_8382
    rts

; take current RNG value $33, figure out which $8398 bucket it fits into, and store that index in Y
B04_8389:
    ldy #$00
    lda $33 ; RNG byte 1

B04_838D:
    cmp B04_8398, x
    bcs B04_8397
    iny
    inx
    jmp B04_838D

B04_8397:
    rts


B04_8398:
.byte $D6,$AC,$82,$68,$4E,$34
.byte $00,$82,$5B,$34,$00

B04_83A3:
    jsr B04_83B7 ; given a monster group index in X, write the monster ID in A to the appropriate monster group data at $0663

    lda #$01
    sta $066C, y
    rts

; given a weird value <= #$03 in Y, get the monster ID from ($D5), y and if it's not #$FF/#$7F, get the monster group index corresponding to Y from B04_83BE and write the monster ID to the appropriate monster group data at $0663
B04_83AC:
    lda ($D5), y
    and #$7F
    cmp #$7F
    beq B04_83BD
; given a weird value <= #$03 in Y, get the corresponding monster group index from B04_83BE and write the monster ID in A to the appropriate monster group data at $0663
B04_83B4:
    ldx B04_83BE, y
; given a monster group index in X, write the monster ID in A to the appropriate monster group data at $0663
B04_83B7:
    ldy B04_83C2, x ; pre-computed multiples of #$0B (what was wrong with the identical data at $04:$837A?)

    sta $0663, y ; monster ID, group 1

B04_83BD:
    rts


; code -> data
B04_83BE:
.byte $01,$00,$03,$02

; pre-computed multiples of #$0B (what was wrong with the identical data at $04:$837A?)
B04_83C2:
.byte 0,11,22,33

; World Map Encounters
; indexed data load target (from $807D)
WorldMap_Encounters:
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
.byte $4D,$0E,$21,$21,$5B,$65,$DB,$5B,$5B,$5B,$22,$62,$62,$E2,$C1,$E3

; Dungeon Encounter Formations
; indexed data load target (from $8046)
Dungeon_Formations:
.byte $0C	 ; Map ID #$2B: Cave to Hamlin
.byte $0A	 ; Map ID #$2C: Lake Cave B1
.byte $0B	 ; Map ID #$2D: Lake Cave B2
.byte $2A	 ; Map ID #$2E: Sea Cave B1
.byte $2B	 ; Map ID #$2F: Sea Cave B2
.byte $2C	 ; Map ID #$30: Sea Cave B3-1
.byte $2C	 ; Map ID #$31: Sea Cave B3-2
.byte $36	 ; Map ID #$32: Sea Cave B4
.byte $37	 ; Map ID #$33: Sea Cave B5
.byte $1C	 ; Map ID #$34: Charlock Castle B1/B2
.byte $1C	 ; Map ID #$35: Charlock Castle B3/B4-1/B5-1
.byte $1C	 ; Map ID #$36: Charlock Castle B4-2/B5-2/B6
.byte $38	 ; Map ID #$37: Cave to Rhone B1
.byte $2D	 ; Map ID #$38: Cave to Rhone 1F
.byte $2E	 ; Map ID #$39: Cave to Rhone 2F-1
.byte $2E	 ; Map ID #$3A: Cave to Rhone 2F-2
.byte $2E	 ; Map ID #$3B: Cave to Rhone 2F-3
.byte $2F	 ; Map ID #$3C: Cave to Rhone 3F
.byte $30	 ; Map ID #$3D: Cave to Rhone 4F
.byte $31	 ; Map ID #$3E: Cave to Rhone 5F
.byte $31	 ; Map ID #$3F: Cave to Rhone 6F
.byte $09	 ; Map ID #$40: Spring of Bravery
.byte $3F	 ; Map ID #$41: unused?
.byte $3F	 ; Map ID #$42: unused?
.byte $3F	 ; Map ID #$43: Cave to Rimuldar
.byte $35	 ; Map ID #$44: Hargon's Castle 2F
.byte $34	 ; Map ID #$45: Hargon's Castle 3F
.byte $3F	 ; Map ID #$46: Hargon's Castle 4F
.byte $3F	 ; Map ID #$47: Hargon's Castle 5F
.byte $3F	 ; Map ID #$48: Hargon's Castle 6F
.byte $26	 ; Map ID #$49: Moon Tower 1F
.byte $27	 ; Map ID #$4A: Moon Tower 2F
.byte $27	 ; Map ID #$4B: Moon Tower 3F
.byte $28	 ; Map ID #$4C: Moon Tower 4F
.byte $28	 ; Map ID #$4D: Moon Tower 5F
.byte $29	 ; Map ID #$4E: Moon Tower 6F
.byte $29	 ; Map ID #$4F: Moon Tower 7F
.byte $1D	 ; Map ID #$50: Lighthouse 1F
.byte $1E	 ; Map ID #$51: Lighthouse 2F
.byte $1E	 ; Map ID #$52: Lighthouse 3F
.byte $1F	 ; Map ID #$53: Lighthouse 4F
.byte $1F	 ; Map ID #$54: Lighthouse 5F
.byte $1F	 ; Map ID #$55: Lighthouse 6F
.byte $1F	 ; Map ID #$56: Lighthouse 7F
.byte $3F	 ; Map ID #$57: Lighthouse 8F
.byte $12	 ; Map ID #$58: Wind Tower 1F
.byte $12	 ; Map ID #$59: Wind Tower 2F
.byte $13	 ; Map ID #$5A: Wind Tower 3F
.byte $13	 ; Map ID #$5B: Wind Tower 4F
.byte $14	 ; Map ID #$5C: Wind Tower 5F
.byte $14	 ; Map ID #$5D: Wind Tower 6F
.byte $14	 ; Map ID #$5E: Wind Tower 7F
.byte $3F	 ; Map ID #$5F: Wind Tower 8F
.byte $39	 ; Map ID #$60: Dragon Horn South 1F
.byte $39	 ; Map ID #$61: Dragon Horn South 2F
.byte $39	 ; Map ID #$62: Dragon Horn South 3F
.byte $3A	 ; Map ID #$63: Dragon Horn South 4F
.byte $3A	 ; Map ID #$64: Dragon Horn South 5F
.byte $3A	 ; Map ID #$65: Dragon Horn South 6F
.byte $39	 ; Map ID #$66: Dragon Horn North 1F
.byte $39	 ; Map ID #$67: Dragon Horn North 2F
.byte $39	 ; Map ID #$68: Dragon Horn North 3F
.byte $3A	 ; Map ID #$69: Dragon Horn North 4F
.byte $3A	 ; Map ID #$6A: Dragon Horn North 5F
.byte $3A	 ; Map ID #$6B: Dragon Horn North 6F
.byte $3F	 ; Map ID #$6C: Dragon Horn North 7F


; data load target (from $8098)
Battle_Formations_sizeof:
.byte $40

; Battle Formations
Battle_Formations:
.byte $81,$FF,$FF,$FF,$81,$82	 ; Battle Formation #$00: Slime, ---, ---, ---, Slime, Big Slug
.byte $81,$82,$81,$82,$FF,$FF	 ; Battle Formation #$01: Slime, Big Slug, Slime, Big Slug, ---, ---
.byte $82,$81,$81,$83,$82,$FF	 ; Battle Formation #$02: Big Slug, Slime, Slime, Iron Ant, Big Slug, ---
.byte $83,$84,$82,$84,$83,$87	 ; Battle Formation #$03: Iron Ant, Drakee, Big Slug, Drakee, Iron Ant, Ghost Mouse
.byte $84,$85,$82,$83,$84,$87	 ; Battle Formation #$04: Drakee, Wild Mouse, Big Slug, Iron Ant, Drakee, Ghost Mouse
.byte $85,$84,$88,$82,$85,$86	 ; Battle Formation #$05: Wild Mouse, Drakee, Babble, Big Slug, Wild Mouse, Healer
.byte $88,$84,$85,$88,$88,$8A	 ; Battle Formation #$06: Babble, Drakee, Wild Mouse, Babble, Babble, Magician
.byte $8C,$88,$8B,$82,$89,$86	 ; Battle Formation #$07: Big Cobra, Babble, Big Rat, Big Slug, Army Ant, Healer
.byte $0C,$0B,$07,$0A,$09,$7F	 ; Battle Formation #$08: Big Cobra, Big Rat, Ghost Mouse, Army Ant, ---
.byte $85,$82,$83,$84,$85,$8C	 ; Battle Formation #$09: Wild Mouse, Big Slug, Iron Ant, Drakee, Wild Mouse, Big Cobra
.byte $0B,$07,$0C,$06,$0C,$8D	 ; Battle Formation #$0A: Big Rat, Ghost Mouse, Big Cobra, Healer, Big Cobra, Magic Ant
.byte $8C,$8B,$8A,$8A,$89,$8F	 ; Battle Formation #$0B: Big Cobra, Big Rat, Magician, Magician, Army Ant, Centipod
.byte $87,$8B,$8A,$FF,$8C,$8F	 ; Battle Formation #$0C: Ghost Mouse, Big Rat, Magician, ---, Big Cobra, Centipod
.byte $0F,$8A,$0C,$0E,$0B,$92	 ; Battle Formation #$0D: Magician, Big Rat, Big Cobra, Magidrakee, Centipod
.byte $95,$91,$8F,$8A,$89,$93	 ; Battle Formation #$0E: Baboon, Lizard Fly, Centipod, Magician, Army Ant, Smoke
.byte $0F,$8E,$11,$0D,$8B,$12	 ; Battle Formation #$0F: Centipod, Magidrakee, Lizard Fly, Magic Ant, Big Rat, Zombie
.byte $08,$13,$0D,$92,$0D,$17	 ; Battle Formation #$10: Babble, Smoke, Magic Ant, Zombie, Magic Ant, Megapede
.byte $12,$0C,$FF,$93,$8F,$30	 ; Battle Formation #$11: Zombie, Big Cobra, ---, Smoke, Centipod, Metal Slime
.byte $12,$0A,$8B,$92,$8C,$17	 ; Battle Formation #$12: Zombie, Magician, Big Rat, Zombie, Big Cobra, Megapede
.byte $93,$92,$92,$87,$94,$97	 ; Battle Formation #$13: Smoke, Zombie, Zombie, Ghost Mouse, Ghost Rat, Megapede
.byte $14,$12,$0E,$8D,$14,$FF	 ; Battle Formation #$14: Ghost Rat, Zombie, Magidrakee, Magic Ant, Ghost Rat, ---
.byte $15,$14,$16,$B0,$15,$A0	 ; Battle Formation #$15: Baboon, Ghost Rat, Carnivog, Metal Slime, Baboon, Mummy Man
.byte $96,$95,$94,$8E,$97,$92	 ; Battle Formation #$16: Carnivog, Baboon, Ghost Rat, Magidrakee, Megapede, Zombie
.byte $1B,$16,$12,$1A,$9C,$1D	 ; Battle Formation #$17: Mud Man, Carnivog, Zombie, Enchanter, Magic Baboon, Demighost
.byte $1C,$1B,$1A,$9D,$92,$30	 ; Battle Formation #$18: Magic Baboon, Mud Man, Enchanter, Demighost, Zombie, Metal Slime
.byte $1B,$1D,$1B,$1A,$9E,$01	 ; Battle Formation #$19: Mud Man, Demighost, Mud Man, Enchanter, Gremlin, Slime
.byte $1E,$1C,$1D,$81,$9F,$04	 ; Battle Formation #$1A: Gremlin, Magic Baboon, Demighost, Slime, Poison Lily, Drakee
.byte $1F,$13,$8E,$22,$A2,$28	 ; Battle Formation #$1B: Poison Lily, Smoke, Gremlin, Saber Tiger, Saber Tiger, Orc
.byte $20,$21,$A2,$9E,$FF,$A6	 ; Battle Formation #$1C: Mummy Man, Gorgon, Saber Tiger, Gremlin, ---, Basilisk
.byte $A1,$A0,$A2,$9A,$9D,$FF	 ; Battle Formation #$1D: Gorgon, Mummy Man, Saber Tiger, Enchanter, Demighost, ---
.byte $A2,$A0,$A1,$A5,$A3,$FF	 ; Battle Formation #$1E: Saber Tiger, Mummy Man, Gorgon, Undead, Dragon Fly, ---
.byte $A5,$A1,$8D,$9E,$A3,$B5	 ; Battle Formation #$1F: Undead, Gorgon, Magic Ant, Gremlin, Dragon Fly, Gold Orc
.byte $24,$23,$A6,$26,$27,$A8	 ; Battle Formation #$20: Titan Tree, Dragon Fly, Basilisk, Basilisk, Goopi, Orc
.byte $28,$26,$A4,$28,$26,$FF	 ; Battle Formation #$21: Orc, Basilisk, Titan Tree, Orc, Basilisk, ---
.byte $2B,$2C,$27,$8D,$FF,$AF	 ; Battle Formation #$22: Evil Tree, Gas, Goopi, Magic Ant, ---, Sorcerer
.byte $2E,$7F,$AC,$2F,$AB,$2D	 ; Battle Formation #$23: Hawk Man, ---, Gas, Sorcerer, Evil Tree, Hork
.byte $31,$29,$33,$AF,$AD,$C2	 ; Battle Formation #$24: Hunter, Puppet Man, Hibabango, Sorcerer, Hork, Metal Babble
.byte $33,$31,$B4,$35,$2F,$35	 ; Battle Formation #$25: Hibabango, Hunter, Graboopi, Gold Orc, Sorcerer, Gold Orc
.byte $2A,$32,$B4,$7F,$37,$36	 ; Battle Formation #$26: Mummy, Evil Eye, Graboopi, ---, Ghoul, Evil Clown
.byte $35,$38,$A9,$35,$B7,$FF	 ; Battle Formation #$27: Gold Orc, Vampirus, Puppet Man, Gold Orc, Ghoul, ---
.byte $38,$7F,$B7,$7F,$B6,$C2	 ; Battle Formation #$28: Vampirus, ---, Ghoul, ---, Evil Clown, Metal Babble
.byte $BE,$BE,$B5,$B6,$FF,$C2	 ; Battle Formation #$29: Gargoyle, Gargoyle, Gold Orc, Evil Clown, ---, Metal Babble
.byte $B2,$B4,$AC,$B6,$FF,$FF	 ; Battle Formation #$2A: Evil Eye, Graboopi, Gas, Evil Clown, ---, ---
.byte $B5,$B4,$AB,$B5,$A9,$C2	 ; Battle Formation #$2B: Gold Orc, Graboopi, Evil Tree, Gold Orc, Puppet Man, Metal Babble
.byte $BA,$B5,$AA,$B5,$BA,$BA	 ; Battle Formation #$2C: Saber Lion, Gold Orc, Mummy, Gold Orc, Saber Lion, Saber Lion
.byte $B9,$BA,$BB,$B6,$BD,$C2	 ; Battle Formation #$2D: Mega Knight, Saber Lion, Metal Hunter, Evil Clown, Dark Eye, Metal Babble
.byte $3C,$39,$BD,$3C,$B7,$7F	 ; Battle Formation #$2E: Ozwarg, Mega Knight, Dark Eye, Ozwarg, Ghoul, ---
.byte $BF,$BE,$C1,$AD,$FF,$C2	 ; Battle Formation #$2F: Orc King, Gargoyle, Magic Vampirus, Hork, ---, Metal Babble
.byte $C8,$C1,$C3,$C3,$C1,$C5	 ; Battle Formation #$30: Flame, Berserker, Hargon’s Knight, Hargon’s Knight, Berserker, Attack Bot
.byte $41,$40,$C6,$C5,$46,$C9	 ; Battle Formation #$31: Berserker, Magic Vampirus, Green Dragon, Attack Bot, Green Dragon, Silver Batboon
.byte $C4,$C9,$C5,$CA,$C4,$FF	 ; Battle Formation #$32: Cyclops, Silver Batboon, Attack Bot, Blizzard, Cyclops, ---
.byte $CB,$CA,$CC,$CD,$CC,$CD	 ; Battle Formation #$33: Giant, Blizzard, Gold Batboon, Bullwong, Gold Batboon, Bullwong
.byte $7F,$42,$CB,$C7,$47,$7F	 ; Battle Formation #$34: ---, Metal Babble, Giant, Mace Master, Mace Master, ---
.byte $C6,$C8,$C9,$C5,$C6,$CD	 ; Battle Formation #$35: Green Dragon, Flame, Silver Batboon, Attack Bot, Green Dragon, Bullwong
.byte $B9,$BA,$A9,$B5,$B9,$C2	 ; Battle Formation #$36: Mega Knight, Saber Lion, Puppet Man, Gold Orc, Mega Knight, Metal Babble
.byte $BB,$B9,$A3,$B6,$BB,$BB	 ; Battle Formation #$37: Metal Hunter, Mega Knight, Dragon Fly, Evil Clown, Metal Hunter, Metal Hunter
.byte $AD,$AD,$AD,$AD,$AD,$FF	 ; Battle Formation #$38: Hork, Hork, Hork, Hork, Hork, ---
.byte $14,$15,$16,$17,$92,$B0	 ; Battle Formation #$39: Ghost Rat, Baboon, Carnivog, Megapede, Zombie, Metal Slime
.byte $19,$15,$16,$1A,$99,$9D	 ; Battle Formation #$3A: Medusa Ball, Baboon, Carnivog, Enchanter, Medusa Ball, Demighost
.byte $8C,$9F,$A4,$85,$B1,$A9	 ; Battle Formation #$3B: Big Cobra, Poison Lily, Titan Tree, Wild Mouse, Hunter, Puppet Man
.byte $FF,$FF,$FF,$FF,$FF,$FF	 ; Battle Formation #$3C: ---, ---, ---, ---, ---, ---
.byte $FF,$FF,$FF,$FF,$FF,$FF	 ; Battle Formation #$3D: ---, ---, ---, ---, ---, ---
.byte $FF,$FF,$FF,$FF,$FF,$FF	 ; Battle Formation #$3E: ---, ---, ---, ---, ---, ---
.byte $FF,$FF,$FF,$FF,$FF,$FF	 ; Battle Formation #$3F:  ---, ---, ---, ---, ---, --- (no World Map encounters if you use this one)

; Ocean Formations (high 2 bits of encounter group)
Ocean_Formations:
.byte $90,$98,$99,$FF,$87,$FF	 ; Battle Formation #$40: Man O’ War, Sea Slug, Medusa Ball, ---, Ghost Mouse, ---
.byte $98,$8E,$90,$AE,$FF,$BE	 ; Battle Formation #$41: Sea Slug, Magidrakee, Man O’ War, Hawk Man, ---, Gargoyle
.byte $31,$AE,$2D,$2C,$7F,$7F	 ; Battle Formation #$42: Hunter, Hawk Man, Hork, Gas, ---, ---
.byte $B8,$93,$91,$BE,$FF,$FF	 ; Battle Formation #$43: Vampirus, Smoke, Lizard Fly, Gargoyle, ---, ---

; Special Formations
; indexed data load target (from $8101)
Special_Formations:
.byte $FF,$FF,$09,$FF	 ; Special Formation #$00: Army Ant
.byte $FF,$FF,$0D,$FF	 ; Special Formation #$01: Magic Ant
.byte $FF,$1C,$FF,$0E	 ; Special Formation #$02: Magic Baboon, Magidrakee
.byte $FF,$15,$FF,$06	 ; Special Formation #$03: Baboon, Healer
.byte $FF,$FF,$FF,$09	 ; Special Formation #$04: Army Ant
.byte $FF,$17,$FF,$13	 ; Special Formation #$05: Megapede, Smoke
.byte $FF,$1D,$FF,$0D	 ; Special Formation #$06: Demighost, Magic Ant
.byte $FF,$28,$FF,$06	 ; Special Formation #$07: Orc, Healer
.byte $FF,$FF,$31,$0E	 ; Special Formation #$08: Hunter, Magidrakee
.byte $35,$FF,$FF,$13	 ; Special Formation #$09: Gold Orc, Smoke
.byte $FF,$FF,$FF,$30	 ; Special Formation #$0A: Metal Slime
.byte $36,$FF,$FF,$2D	 ; Special Formation #$0B: Evil Clown, Hork
.byte $47,$FF,$FF,$41	 ; Special Formation #$0C: Mace Master, Berserker
.byte $FF,$42,$FF,$06	 ; Special Formation #$0D: Metal Babble, Healer
.byte $FF,$FF,$FF,$11	 ; Special Formation #$0E: Lizard Fly
.byte $FF,$FF,$23,$FF	 ; Special Formation #$0F: Dragon Fly
.byte $38,$31,$FF,$FF	 ; Special Formation #$10: Vampirus, Hunter
.byte $FF,$FF,$FF,$0A	 ; Special Formation #$11: Magician
.byte $12,$FF,$06,$FF	 ; Special Formation #$12: Zombie, Healer


B04_86ED:
    jsr B0F_C515 ; flash screen 10 times

    lda #$17 ; Music ID #$17: normal battle BGM

    ldx $066E
    cpx #$52
    bne B04_86FB
    lda #$18 ; Music ID #$18: Malroth battle BGM

B04_86FB:
    jsr B0F_C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    jsr B0F_C465 ; wait for interrupt and then set every 4th byte of $0200 - $02FC to #$F0

    jsr B04_902C
    lda #$00
    sta $04
    sta $05
    sta $06
    jsr B0F_C446 ; turn screen off, write $800 [space] tiles to PPU $2000, turn screen on

    jsr B0F_C42A
    jsr B04_8F26
    jsr B0F_C3E8 ; wait for interrupt, set $6007 to #$FF, turn screen off

    ldx #$00
    stx $0400 ; menu-based palette overrides start

    rts

B04_871E:
    lda #$F0
    ldx #$00
B04_8722:
    sta $0200, x ; sprite buffer start

    inx
    inx
    inx
    inx
    bne B04_8722
    lda #$00
    sta $0405
    jsr B0F_C41C ; wait for interrupt, turn screen sprites and backround on

    lda #$01
    sta $0400 ; menu-based palette overrides start

    jsr B0F_C22C
    ldx #$40
    lda #$00
B04_873F:
    sta $0449, x
    dex
    bne B04_873F
    ldx #$00
    stx $DA
B04_8749:
    lda $042A, x
    bpl B04_8777
    sta $DB
    and #$7F
    sta $042A, x
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
    lda $042C, x
    sec
    adc $DA
    cmp #$1E
    bcs B04_8777
    sta $DA
    txa
    ora #$80
    sta $044A, y
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
B04_878B:
    lda $DA
    lda $044A, y
    bpl B04_87A8
    and #$1F
    tax
    lda $042A, x
    ora #$80
    sta $042A, x
    lda $DA
    sta $042B, x
    sec
    adc $042C, x
    sta $DA
B04_87A8:
    iny
    cpy #$20
    bne B04_878B
    rts

B04_87AE:
    ldx #$00
B04_87B0:
    stx $DA
    lda $042A, x
    bpl B04_87BC
    jsr B04_8C80
    ldx $DA
B04_87BC:
    inx
    inx
    inx
    inx
    cpx #$20
    bne B04_87B0
    clc
    rts

B04_87C6:
    lda $0400 ; menu-based palette overrides start

    beq B04_87CD
    sec
    rts

B04_87CD:
    ldx $DB
    lda $0406, x
    beq B04_87D6
    sec
    rts

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
    lda $0663, y ; monster ID, group 1

    cmp #$53
    bcc B04_8800
    sec
    rts

B04_8800:
    asl
    rol $E0
    asl
    rol $E0
    clc
    adc $0663, y ; monster ID, group 1

    bcc B04_880E
    inc $E0
B04_880E:
    clc
    adc B04_88BE ; -> $04:$90FC: count? + pointer to enemy graphics? + pointer to enemy palette

    sta $DF
    lda B04_88BE+1
    adc $E0
    sta $E0
    ldx $DB
    jsr B04_8FA2 ; read ($DF), INC 16-bit $DF-$E0

    sta $040E, x
    jsr B04_8FA2 ; read ($DF), INC 16-bit $DF-$E0

    sta $040C, x
    jsr B04_8FA2 ; read ($DF), INC 16-bit $DF-$E0

    sta $040D, x
    jsr B04_8FA2 ; read ($DF), INC 16-bit $DF-$E0

    pha
    jsr B04_8FA2 ; read ($DF), INC 16-bit $DF-$E0

    sta $E0
    pla
    sta $DF
    jsr B04_8FA2 ; read ($DF), INC 16-bit $DF-$E0

    sta $DC
    and #$0F
    beq B04_886B
    sta $DE
    lda #$00
    sta $DD
    jsr B04_88C0
    bcc B04_8851
    sec
    rts

B04_8851:
    ldx $DB
    lda $E4
    sta $040A, x
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
    jsr B04_88C0
    bcc B04_8882
    sec
    rts

B04_8882:
    ldx $DB
    lda $E4
    sta $040B, x
B04_8889:
    jsr B04_8971
    bcc B04_8890
    sec
    rts

B04_8890:
    ldx $DB
    lda $E6
    sta $0403
    lda $E7
    sta $0404
    lda $E5
    sta $0406, x
    lda $0401
    sta $0408, x
    lda $0402
    sta $0407, x
    lda $E4
    sta $0409, x
    lda $E8
    sta $0401
    lda $E9
    sta $0402
    clc
    rts


; -> $04:$90FC: count? + pointer to enemy graphics? + pointer to enemy palette
B04_88BE:
.addr $90FC

B04_88C0:
    lda #$00
    sta $E1
    sta $E4
    lda $DD
    and #$01
    tax
    lda $E6, x
    sta $E2
    beq B04_892A
B04_88D1:
    ldx $DD
    beq B04_88F4
    ldy #$03
B04_88D7:
    lda $050D, y
    cmp #$30
    bne B04_88F4
    dey
    bne B04_88D7
    lda $E1
    asl
    clc
    adc $E1
    tay
    lda ($DF), y
    cmp #$30
    bne B04_88F4
    lda #$00
    pha
    jmp B04_893C

B04_88F4:
    lda #$00
    sta $E3
    ldx $DD
B04_88FA:
    lda $E1
    asl
    clc
    adc $E1
    tay
    lda #$03
    sta $E5
B04_8905:
    lda $0501, x
    cmp ($DF), y
    bne B04_8917
    inx
    iny
    dec $E5
    bne B04_8905
    lda $E3
    jmp B04_894C

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
B04_893C:
    lda #$03
    sta $E5
B04_8940:
    lda ($DF), y
    sta $0501, x
    inx
    iny
    dec $E5
    bne B04_8940
    pla
B04_894C:
    ldx $E1
    inx
    stx $E1
B04_8951:
    dex
    beq B04_8959
    asl
    asl
    jmp B04_8951

B04_8959:
    ora $E4
    sta $E4
    lda $E1
    cmp $DE
    beq B04_8966
    jmp B04_88D1

B04_8966:
    lda $DD
    and #$01
    tax
    lda $E2
    sta $E6, x
    clc
    rts

B04_8971:
    ldx $DB
    lda $040C, x
    sta $DF
    lda $040D, x
    sta $E0
    lda $040E, x
    sta $E1
    lda #$00
    sta $E4
    sta $E5
B04_8988:
    lda $DF
    pha
    lda $E0
    pha
    lda #$00
    sta $DC
    lda #$FF
    sta $DD
    sta $DE
B04_8998:
    jsr B04_8F9D ; return 1 byte from bank 1's ($DF) in A, INC 16-bit $DF-$E0

    tax
    and #$40
    bne B04_89A3
    jsr B04_8FA6 ; INC 16-bit $DF-$E0

B04_89A3:
    jsr B04_8FA6 ; INC 16-bit $DF-$E0

    txa
    bpl B04_8998
    lsr
    and #$04
    beq B04_89BF
    bcc B04_89B5
    jsr B04_8F9D ; return 1 byte from bank 1's ($DF) in A, INC 16-bit $DF-$E0

    sta $DC
B04_89B5:
    jsr B04_8F9D ; return 1 byte from bank 1's ($DF) in A, INC 16-bit $DF-$E0

    sta $DD
    jsr B04_8F9D ; return 1 byte from bank 1's ($DF) in A, INC 16-bit $DF-$E0

    sta $DE
B04_89BF:
    ldx #$00
B04_89C1:
    lda $DC
    asl $DD
    rol $DE
    bcc B04_89CC
    jsr B04_8F9D ; return 1 byte from bank 1's ($DF) in A, INC 16-bit $DF-$E0

B04_89CC:
    sta $044A, x
    ldy #$08
B04_89D1:
    asl
    ror $045A, x
    dey
    bne B04_89D1
    inx
    cpx #$10
    bne B04_89C1
    ldx #$00
B04_89DF:
    txa
    ora #$07
    tay
B04_89E3:
    lda $044A, x
    sta $046A, y
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
B04_89FE:
    jsr B04_8F9D ; return 1 byte from bank 1's ($DF) in A, INC 16-bit $DF-$E0

    sta $E3
    lsr
    and #$03
    tax
    inx
    lda $E3
    and #$40
    bne B04_8A1B
    inc $E4
    jsr B04_8FA6 ; INC 16-bit $DF-$E0

    jsr B04_8FA6 ; INC 16-bit $DF-$E0

    ldx #$00
    jmp B04_8A26

B04_8A1B:
    jsr B04_8F9D ; return 1 byte from bank 1's ($DF) in A, INC 16-bit $DF-$E0

    and #$0F
    cmp $E5
    bcc B04_8A26
    sta $E5
B04_8A26:
    txa
    tay
    iny
    lda #$20
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
B04_8A41:
    sty $11
    dex
    txa
    asl
    asl
    asl
    asl
    clc
    adc B04_8A9C
    sta $0C
    lda #$00
    adc B04_8A9C+1
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
    lda $E8, x
    inc $E8, x
    bne B04_8A78
    sec
    rts

B04_8A78:
    ldy #$04
B04_8A7A:
    lsr
    ror $10
    dey
    bne B04_8A7A
    ora $11
    sta $11
    jsr B0F_C3F6 ; copy ($0C) inclusive - ($0E) exclusive to PPU at ($10)

B04_8A87:
    lda $E3
    bmi B04_8A8E
    jmp B04_89FE

B04_8A8E:
    jsr B04_8FAD
    dec $E1
    beq B04_8A98
    jmp B04_8988

B04_8A98:
    inc $E5
    clc
    rts

B04_8A9C:
.addr $044A

B04_8A9E:
    jsr B04_8B09
    bcs B04_8AAF
    lda $042A, x
    ora #$80
    sta $042A, x
    jsr B04_8C80
    clc
B04_8AAF:
    rts

B04_8AB0:
    jsr B04_8F58
    bcc B04_8AB7
    sec
    rts

B04_8AB7:
    stx $DA
    lda $042A, x
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
    lda $0663, y ; monster ID, group 1

    cmp #$4E
    bcs B04_8AE8
    lda #$87 ; Music ID #$87: hit 2 SFX

    jsr B0F_C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    ldx #$04 ; Number of flashes when Enemies take a hit

B04_8ADA:
    txa
    pha
    jsr B04_8E09
    jsr B04_8C80
    pla
    tax
    dex
    bne B04_8ADA
    rts

B04_8AE8:
    lda #$81 ; Music ID #$81: hit 1 SFX

    jsr B0F_C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    jsr B04_90BB
    rts

B04_8AF1:
    jsr B04_8F58
    bcc B04_8AF8
    sec
    rts

B04_8AF8:
    stx $DA
    jsr B04_8E09
    ldx $DA
    lda $042A, x
    and #$7F
    sta $042A, x
    clc
    rts

B04_8B09:
    jsr B04_8B23
    bcs B04_8B22
    ldx $DA
    ldy $DB
    lda $0406, y
    sta $042C, x
    jsr B04_8BDD
    bcs B04_8B22
    ldx $DA
    sta $042B, x
B04_8B22:
    rts

B04_8B23:
    jsr B04_8F58
    bcs B04_8B2A
    sec
    rts

B04_8B2A:
    tya
    bne B04_8B2F
    sec
    rts

B04_8B2F:
    lda $DA
    sta $042A, x
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
    lda $0406, y
    bne B04_8B52
    jsr B04_87C6
    ldy $DB
    ldx $DA
    bcc B04_8B52
    rts

B04_8B52:
    sta $042C, x
    lda $0409, y
    clc
    bne B04_8B5C
    rts

B04_8B5C:
    adc $0405
    cmp #$41
    bcc B04_8B65
    sec
    rts

B04_8B65:
    lda $040E, y
    sta $DE
    lda $040C, y
    sta $DF
    lda $040D, y
    sta $E0
    ldx #$00
B04_8B76:
    jsr B04_8F9D ; return 1 byte from bank 1's ($DF) in A, INC 16-bit $DF-$E0

    pha
    jsr B04_8FA6 ; INC 16-bit $DF-$E0

    and #$40
    bne B04_8B8B
    jsr B04_8F9D ; return 1 byte from bank 1's ($DF) in A, INC 16-bit $DF-$E0

    clc
    adc #$17
    sta $044A, x
    inx
B04_8B8B:
    pla
    bpl B04_8B76
    jsr B04_8FAD
    dec $DE
    bne B04_8B76
    stx $DD
    lda #$10
    sta $DE
B04_8B9B:
    ldx #$00
    lda $0405
    beq B04_8BBB
    sta $DF
    ldx #$00
    ldy #$00
B04_8BA8:
    lda $0200, y ; sprite buffer start

    sec
    sbc $DE
    cmp #$08
    bcs B04_8BB3
    inx
B04_8BB3:
    iny
    iny
    iny
    iny
    dec $DF
    bne B04_8BA8
B04_8BBB:
    ldy #$00
B04_8BBD:
    lda $044A, y
    sec
    sbc $DE
    cmp #$08
    bcs B04_8BC8
    inx
B04_8BC8:
    iny
    cpy $DD
    bne B04_8BBD
    cpx #$09
    bcc B04_8BD3
    sec
    rts

B04_8BD3:
    inc $DE
    lda $DE
    cmp #$90
    bne B04_8B9B
    clc
    rts

B04_8BDD:
    ldx $DB
    lda $0406, x
    bne B04_8BE6
    sec
    rts

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
B04_8C04:
    lda #$00
B04_8C06:
    sta $E0
    tax
    lda $042A, x
    bpl B04_8C41
    lda $042B, x
    clc
    adc $042C, x
    cmp $DE
    bcc B04_8C41
    lda $042B, x
    clc
    sbc $DC
    cmp #$20
    bcs B04_8C27
    cmp $DE
    bcs B04_8C41
B04_8C27:
    inc $DF
    lda $DF
    cmp $DD
    bne B04_8C31
    sec
    rts

B04_8C31:
    eor #$01
    lsr
    lda $DF
    bcc B04_8C3A
    eor #$FF
B04_8C3A:
    adc $DE
    sta $DE
    jmp B04_8C04

B04_8C41:
    lda $E0
    clc
    adc #$04
    cmp #$20
    bne B04_8C06
    lda $DE
    clc
    rts

B04_8C4E:
    lda #$02
    sta $DE
    ldx #$00
B04_8C54:
    lda $042A, x
    bpl B04_8C66
    lda $042B, x
    sec
    adc $042C, x
    cmp $DE
    bcc B04_8C66
    sta $DE
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
    adc $042C, x
    cmp #$1F
    bcc B04_8C7C
    sec
    rts

B04_8C7C:
    lda $DE
    clc
    rts

B04_8C80:
    ldy $DA
    lda $042A, y
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
    lda $040C, x
    sta $DF
    lda $040D, x
    sta $E0
    lda $040E, x
    sta $E1
    lda $0400 ; menu-based palette overrides start; xx HP reduced

    bne B04_8CD6
B04_8CAB:
    jsr B04_8F9D ; return 1 byte from bank 1's ($DF) in A, INC 16-bit $DF-$E0

    pha
    jsr B04_8FA6 ; INC 16-bit $DF-$E0

    and #$40
    bne B04_8CC6
    lda $DC
    asl
    asl
    tax
    jsr B04_8F9D ; return 1 byte from bank 1's ($DF) in A, INC 16-bit $DF-$E0

    clc
    adc #$17
    sta $0200, x ; sprite buffer start

    inc $DC
B04_8CC6:
    pla
    bpl B04_8CAB
    jsr B04_8FAD
    dec $E1
    bne B04_8CAB
    lda $DC
    sta $0405
    rts

B04_8CD6:
    lda $042B, y
    sta $E2
    lda $0407, x
    sta $DE
    dec $DE
    lda $0408, x
    sta $DD
    dec $DD
    jsr B0F_C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

B04_8CEC:
    lda #$00
    sta $E3
B04_8CF0:
    jsr B04_8F9D ; return 1 byte from bank 1's ($DF) in A, INC 16-bit $DF-$E0

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
B04_8D0C:
    lda $DD
    sta $0201, x
    lda $E4
    ror
    ror
    ror
    ror
    pha
    and #$03
    sta $E5
    ldy $DB
    lda $040A, y
    ldy $E5
    iny
B04_8D24:
    dey
    beq B04_8D2C
    lsr
    lsr
    jmp B04_8D24

B04_8D2C:
    and #$03
    sta $E5
    pla
    and #$C0
    ora $E5
    sta $0202, x
    lda $E2
    asl
    asl
    asl
    sta $E5
    jsr B04_8F9D ; return 1 byte from bank 1's ($DF) in A, INC 16-bit $DF-$E0

    clc
    adc $E5
    sta $0203, x
    jsr B04_8F9D ; return 1 byte from bank 1's ($DF) in A, INC 16-bit $DF-$E0

    clc
    adc #$17
    sta $0200, x ; sprite buffer start

    inc $DC
    jmp B04_8DE4

B04_8D56:
    lda $E4
    lsr
    lsr
    lsr
    lsr
    and #$03
    tay
    ldx $DB
    lda $040B, x
    iny
B04_8D65:
    dey
    beq B04_8D6D
    lsr
    lsr
    jmp B04_8D65

B04_8D6D:
    and #$03
    sta $09
    jsr B04_8F9D ; return 1 byte from bank 1's ($DF) in A, INC 16-bit $DF-$E0

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
    jsr B0F_DE6E
    lda $08 ; current PPU write address, high byte

    clc
    adc #$20
    sta $08 ; current PPU write address, high byte

    jsr B0F_C1FA ; wait for $02 to not be #$C0, write PPU address in $07-$08 and data in $09 to PPU write buffer at $0300,$02, $01 += 1, $02 += 3, and set $0183 to #$00

    lda $02
    cmp #$A5
    bcc B04_8D9E
    jsr B0F_C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

B04_8D9E:
    lda $E4
    lsr
    and #$03
    tax
    tay
    iny
    lda #$10
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
    sta $E6, x
B04_8DBE:
    lda $E6, x
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

    jsr B0F_C1FA ; wait for $02 to not be #$C0, write PPU address in $07-$08 and data in $09 to PPU write buffer at $0300,$02, $01 += 1, $02 += 3, and set $0183 to #$00

    lda $02
    cmp #$A5
    bcc B04_8DE4
    jsr B0F_C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

B04_8DE4:
    lda $E4
    bmi B04_8DEB
    jmp B04_8CF0

B04_8DEB:
    jsr B04_8FAD
    dec $E1
    beq B04_8DF5
    jmp B04_8CEC

B04_8DF5:
    ldx $DA
    lda $0405
    sta $042D, x
    lda $DC
    sta $0405
    jsr B0F_C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF
    jsr B0F_C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF
    rts

B04_8E09:
    lda $0400 ; menu-based palette overrides start

    bne B04_8E10
    sec
    rts

B04_8E10:
    ldy $DA
    lda $042A, y
    bmi B04_8E19
    sec
    rts

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
    lda $042B, y
    sta $E2
    lda $042D, y
    sta $E3
    lda $040C, x
    sta $DF
    lda $040D, x
    sta $E0
    lda $040E, x
    sta $E1
    jsr B0F_C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

B04_8E42:
    jsr B04_8F9D ; return 1 byte from bank 1's ($DF) in A, INC 16-bit $DF-$E0

    sta $E4
    and #$40
    bne B04_8E60
    lda $E3
    asl
    asl
    tax
    lda #$F8
    sta $0200, x ; sprite buffer start

    inc $E3
    jsr B04_8FA6 ; INC 16-bit $DF-$E0

    jsr B04_8FA6 ; INC 16-bit $DF-$E0

    jmp B04_8E9D

B04_8E60:
    jsr B04_8F9D ; return 1 byte from bank 1's ($DF) in A, INC 16-bit $DF-$E0

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

    jsr B0F_C1FA ; wait for $02 to not be #$C0, write PPU address in $07-$08 and data in $09 to PPU write buffer at $0300,$02, $01 += 1, $02 += 3, and set $0183 to #$00

    lda $02
    cmp #$A5
    bcc B04_8E9D
    jsr B0F_C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

B04_8E9D:
    lda $E4
    bmi B04_8EA4
    jmp B04_8E42

B04_8EA4:
    jsr B04_8FAD
    dec $E1
    beq B04_8EAE
    jmp B04_8E42

B04_8EAE:
    jsr B0F_C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF
    jsr B0F_C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    ldy $DA
    ldx $DB
    lda $0409, x
    bne B04_8EBF
    clc
    rts

B04_8EBF:
    sta $DD
    lda $042D, y
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
B04_8EE5:
    lda $0200, y ; sprite buffer start

    sta $0200, x ; sprite buffer start

    inx
    iny
    dec $DE
    bne B04_8EE5
B04_8EF1:
    lda $DD
    sta $DE
    lda $0405
    asl
    asl
    tax
    lda #$F8
B04_8EFD:
    sta $0200, x ; sprite buffer start

    inx
    inx
    inx
    inx
    dec $DE
    bne B04_8EFD
    ldx #$00
B04_8F0A:
    lda $042A, x
    bpl B04_8F1C
    lda $042D, x
    cmp $DC
    bcc B04_8F1C
    sec
    sbc $DD
    sta $042D, x
B04_8F1C:
    inx
    inx
    inx
    inx
    cpx #$20
    bne B04_8F0A
    clc
    rts

B04_8F26:
    lda #$00
    sta $0405
    ldx #$44
B04_8F2D:
    sta $0405, x
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
B04_8F51:
    sta $050D, x
    dex
    bne B04_8F51
    rts

B04_8F58:
    dey
    cpy #$08
    bcs B04_8F61
    cpx #$04
    bcc B04_8F65
B04_8F61:
    ldy #$00
    sec
    rts

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
B04_8F77:
    lda $042A, x
    bpl B04_8F82
    and #$1F
    cmp $DA
    beq B04_8F9B
B04_8F82:
    inx
    inx
    inx
    inx
    dey
    bne B04_8F77
    ldx #$00
    ldy #$08
B04_8F8D:
    lda $042A, x
    bpl B04_8F99
    inx
    inx
    inx
    inx
    dey
    bne B04_8F8D
B04_8F99:
    sec
    rts

B04_8F9B:
    clc
    rts

; return 1 byte from bank 1's ($DF) in A, INC 16-bit $DF-$E0
B04_8F9D:
    ldy #$DF
    jmp B0F_C4E6 ; return 1 byte from bank 1's ($00, y) in A, INC 16-bit $00, y-$01, y


; read ($DF), INC 16-bit $DF-$E0
B04_8FA2:
    ldy #$00
    lda ($DF), y
; INC 16-bit $DF-$E0
B04_8FA6:
    inc $DF
    bne B04_8FAC
    inc $E0
B04_8FAC:
    rts

B04_8FAD:
    lsr
    and #$04
    bne B04_8FBE
    lda #$10
    clc
    adc $DF
    sta $DF
    bcc B04_8FBD
    inc $E0
B04_8FBD:
    rts

B04_8FBE:
    bcc B04_8FC3
    jsr B04_8FA6 ; INC 16-bit $DF-$E0

B04_8FC3:
    jsr B04_8F9D ; return 1 byte from bank 1's ($DF) in A, INC 16-bit $DF-$E0

    pha
    jsr B04_8F9D ; return 1 byte from bank 1's ($DF) in A, INC 16-bit $DF-$E0

    tay
    pla
B04_8FCC:
    asl
    bcc B04_8FD4
    pha
    jsr B04_8FA6 ; INC 16-bit $DF-$E0

    pla
B04_8FD4:
    bne B04_8FCC
    tya
B04_8FD7:
    asl
    bcc B04_8FDF
    pha
    jsr B04_8FA6 ; INC 16-bit $DF-$E0

    pla
B04_8FDF:
    bne B04_8FD7
    rts

B04_8FE2:
    lda #$8A ; Music ID #$8A: hit 3 SFX

    jsr B0F_C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

B04_8FE7:
    jsr B0F_C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    lda #$02
    sta $DB
    ldx #$00
B04_8FF0:
    stx $DA
    txa
    ldx #$01
    and #$02
    beq B04_8FFD
    lda #$03
    ldx #$00
B04_8FFD:
    tay
    lda $05, x
    clc
    adc $DB
    sta $05, x
    ldx #$40
B04_9007:
    lda $0200, y ; sprite buffer start

    sec
    sbc $DB
    sta $0200, y ; sprite buffer start

    iny
    iny
    iny
    iny
    dex
    bne B04_9007
    ldx #$02
    jsr B0F_C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

    lda $DB
    eor #$FF
    sta $DB
    inc $DB
    ldx $DA
    inx
    cpx #$0C ; Amount of shaking when Characters take a hit

    bne B04_8FF0
    rts

B04_902C:
    jsr B0F_C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    lda #$3C
    sta $DB
    lda #$10
    sta $DC
    lda #$0F
    sta $DD
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
B04_904E:
    and #$1F
    sta $DE
    stx $DF
B04_9054:
    lda $06
    lsr
    lsr
    lsr
    clc
    adc $DD
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
B04_907C:
    and #$1F
    sta $07 ; current PPU write address, low byte

    sty $08 ; current PPU write address, high byte

    lda #$00
    ldx #$03
    sec
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
    jsr B0F_C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

B04_909E:
    jsr B0F_C1FA ; wait for $02 to not be #$C0, write PPU address in $07-$08 and data in $09 to PPU write buffer at $0300,$02, $01 += 1, $02 += 3, and set $0183 to #$00

    lda $DB
    eor #$01
    and #$01
    tax
    lda $DC, x
    clc
    adc $DF
    sta $DC, x
    cmp $DE
    bne B04_9054
    lda $DB
    bne B04_903B
    jsr B0F_C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    rts

B04_90BB:
    ldx #$08
B04_90BD:
    txa
    pha
    jsr B04_90E0
    ldx #$00
    lda #$30
B04_90C6:
    sta $050E, x
    sta $0501, x
    inx
    cpx #$0D
    bne B04_90C6
    jsr B0F_C22C
    jsr B04_90EE
    jsr B0F_C22C
    pla
    tax
    dex
    bne B04_90BD
    rts

B04_90E0:
    ldx #$00
B04_90E2:
    lda $0500, x
    sta $044A, x
    inx
    cpx #$1A
    bne B04_90E2
    rts

B04_90EE:
    ldx #$00
B04_90F0:
    lda $044A, x
    sta $0500, x
    inx
    cpx #$1A
    bne B04_90F0
    rts


; code -> data
; count? + pointer to enemy graphics? + pointer to enemy palette
.byte $01 ;count
.addr $8000 ; null
.addr $8000 ; null
.byte $04        ; count
.addr $8002      ; $01:$8002; Monster ID #$01: Slime + Monster ID #$30: Metal Slime
.addr $929B      ; $04:$929B; monster palettes
.byte $0B        ; count
.addr $803D      ; $01:$803D; Monster ID #$02: Big Slug + Monster ID #$18: Sea Slug
.addr $929F      ; $04:$929F
.byte $0D        ; count
.addr $80CE      ; $01:$80CE; Monster ID #$03: Iron Ant + Monster ID #$09: Army Ant + Monster ID #$0D: Magic Ant
.addr $92A6      ; $04:$92A6
.byte $06        ; count
.addr $8175      ; $01:$8175; Monster ID #$04: Drakee + Monster ID #$0E: Magidrakee
.addr $92AD      ; $04:$92AD
.byte $10        ; count
.addr $81CA      ; $01:$81CA; Monster ID #$05: Wild Mouse + Monster ID #$0B: Big Rat + Monster ID #$14: Ghost Rat
.addr $92B1      ; $04:$92B1
.byte $06        ; count
.addr $828E      ; $01:$828E; Monster ID #$06: Healer + Monster ID #$10: Man O’ War
.addr $92B5      ; $04:$92B5
.byte $0F        ; count
.addr $82DB      ; $01:$82DB; Monster ID #$07: Ghost Mouse + Monster ID #$1D: Demighost
.addr $92B9      ; $04:$92B9
.byte $06        ; count
.addr $8404      ; $01:$8404; Monster ID #$08: Babble + Monster ID #$42: Metal Babble
.addr $92C0      ; $04:$92C0
.byte $0D        ; count
.addr $80CE      ; $01:$80CE; Monster ID #$03: Iron Ant + Monster ID #$09: Army Ant + Monster ID #$0D: Magic Ant
.addr $92C4      ; $04:$92C4
.byte $19        ; count
.addr $844F      ; $01:$844F; Monster ID #$0A: Magician + Monster ID #$1A: Enchanter + Monster ID #$2F: Sorcerer
.addr $92CB      ; $04:$92CB
.byte $10        ; count
.addr $81CA      ; $01:$81CA; Monster ID #$05: Wild Mouse + Monster ID #$0B: Big Rat + Monster ID #$14: Ghost Rat
.addr $92D2      ; $04:$92D2
.byte $10        ; count
.addr $85E0      ; $01:$85E0; Monster ID #$0C: Big Cobra + Monster ID #$26: Basilisk
.addr $92D6      ; $04:$92D6
.byte $0D        ; count
.addr $80CE      ; $01:$80CE; Monster ID #$03: Iron Ant + Monster ID #$09: Army Ant + Monster ID #$0D: Magic Ant
.addr $92DD      ; $04:$92DD
.byte $06        ; count
.addr $8175      ; $01:$8175; Monster ID #$04: Drakee + Monster ID #$0E: Magidrakee
.addr $92E4      ; $04:$92E4
.byte $10        ; count
.addr $86CF      ; $01:$86CF; Monster ID #$0F: Centipod + Monster ID #$17: Megapede
.addr $92E8      ; $04:$92E8
.byte $06        ; count
.addr $828E      ; $01:$828E; Monster ID #$06: Healer + Monster ID #$10: Man O’ War
.addr $92EF      ; $04:$92EF
.byte $09        ; count
.addr $87A5      ; $01:$87A5; Monster ID #$11: Lizard Fly + Monster ID #$23: Dragon Fly
.addr $92F3      ; $04:$92F3
.byte $1D        ; count
.addr $883B      ; $01:$883B; Monster ID #$12: Zombie + Monster ID #$2D: Hork + Monster ID #$37: Ghoul
.addr $92FA      ; $04:$92FA
.byte $10        ; count
.addr $89B1      ; $01:$89B1; Monster ID #$13: Smoke + Monster ID #$2C: Gas
.addr $9301      ; $04:$9301
.byte $10        ; count
.addr $81CA      ; $01:$81CA; Monster ID #$05: Wild Mouse + Monster ID #$0B: Big Rat + Monster ID #$14: Ghost Rat
.addr $9305      ; $04:$9305
.byte $10        ; count
.addr $8ABB      ; $01:$8ABB; Monster ID #$15: Baboon + Monster ID #$1C: Magic Baboon + Monster ID #$33: Hibabango
.addr $9309      ; $04:$9309
.byte $17        ; count
.addr $8B9F      ; $01:$8B9F; Monster ID #$16: Carnivog + Monster ID #$1F: Poison Lily
.addr $9310      ; $04:$9310
.byte $10        ; count
.addr $86CF      ; $01:$86CF; Monster ID #$0F: Centipod + Monster ID #$17: Megapede
.addr $9317      ; $04:$9317
.byte $0B        ; count
.addr $803D      ; $01:$803D; Monster ID #$02: Big Slug + Monster ID #$18: Sea Slug
.addr $931E      ; $04:$931E
.byte $1B        ; count
.addr $8CD0      ; $01:$8CD0; Monster ID #$19: Medusa Ball + Monster ID #$21: Gorgon
.addr $9325      ; $04:$9325
.byte $1D        ; count
.addr $844F      ; $01:$844F; Monster ID #$0A: Magician + Monster ID #$1A: Enchanter + Monster ID #$2F: Sorcerer
.addr $932C      ; $04:$932C
.byte $12        ; count
.addr $8E84      ; $01:$8E84; Monster ID #$1B: Mud Man + Monster ID #$29: Puppet Man
.addr $9333      ; $04:$9333
.byte $10        ; count
.addr $8ABB      ; $01:$8ABB; Monster ID #$15: Baboon + Monster ID #$1C: Magic Baboon + Monster ID #$33: Hibabango
.addr $9337      ; $04:$9337
.byte $14        ; count
.addr $82DB      ; $01:$82DB; Monster ID #$07: Ghost Mouse + Monster ID #$1D: Demighost
.addr $933E      ; $04:$933E
.byte $0D        ; count
.addr $8FAF      ; $01:$8FAF; Monster ID #$1E: Gremlin + Monster ID #$3C: Ozwarg
.addr $9345      ; $04:$9345
.byte $17        ; count
.addr $8B9F      ; $01:$8B9F; Monster ID #$16: Carnivog + Monster ID #$1F: Poison Lily
.addr $934C      ; $04:$934C
.byte $1A        ; count
.addr $9066      ; $01:$9066; Monster ID #$20: Mummy Man + Monster ID #$2A: Mummy
.addr $9353      ; $04:$9353
.byte $1B        ; count
.addr $8CD0      ; $01:$8CD0; Monster ID #$19: Medusa Ball + Monster ID #$21: Gorgon
.addr $935A      ; $04:$935A
.byte $19        ; count
.addr $91E0      ; $01:$91E0; Monster ID #$22: Saber Tiger + Monster ID #$3A: Saber Lion
.addr $9361      ; $04:$9361
.byte $09        ; count
.addr $87A5      ; $01:$87A5; Monster ID #$11: Lizard Fly + Monster ID #$23: Dragon Fly
.addr $9368      ; $04:$9368
.byte $20        ; count
.addr $9341      ; $01:$9341; Monster ID #$24: Titan Tree + Monster ID #$2B: Evil Tree
.addr $936F      ; $04:$936F
.byte $18        ; count
.addr $94DA      ; $01:$94DA; Monster ID #$25: Undead + Monster ID #$39: Mega Knight + Monster ID #$43: Hargon’s Knight
.addr $9376      ; $04:$9376
.byte $10        ; count
.addr $85E0      ; $01:$85E0; Monster ID #$0C: Big Cobra + Monster ID #$26: Basilisk
.addr $937A      ; $04:$937A
.byte $0C        ; count
.addr $9627      ; $01:$9627; Monster ID #$27: Goopi + Monster ID #$34: Graboopi
.addr $9381      ; $04:$9381
.byte $20        ; count
.addr $96CA      ; $01:$96CA; Monster ID #$28: Orc + Monster ID #$35: Gold Orc + Monster ID #$3F: Orc King
.addr $9385      ; $04:$9385
.byte $12        ; count
.addr $8E84      ; $01:$8E84; Monster ID #$1B: Mud Man + Monster ID #$29: Puppet Man
.addr $938C      ; $04:$938C
.byte $1A        ; count
.addr $9066      ; $01:$9066; Monster ID #$20: Mummy Man + Monster ID #$2A: Mummy
.addr $9390      ; $04:$9390
.byte $20        ; count
.addr $9341      ; $01:$9341; Monster ID #$24: Titan Tree + Monster ID #$2B: Evil Tree
.addr $9397      ; $04:$9397
.byte $10        ; count
.addr $89B1      ; $01:$89B1; Monster ID #$13: Smoke + Monster ID #$2C: Gas
.addr $939E      ; $04:$939E
.byte $1D        ; count
.addr $883B      ; $01:$883B; Monster ID #$12: Zombie + Monster ID #$2D: Hork + Monster ID #$37: Ghoul
.addr $93A2      ; $04:$93A2
.byte $14        ; count
.addr $98B2      ; $01:$98B2; Monster ID #$2E: Hawk Man + Monster ID #$3E: Gargoyle
.addr $93A9      ; $04:$93A9
.byte $1D        ; count
.addr $844F      ; $01:$844F; Monster ID #$0A: Magician + Monster ID #$1A: Enchanter + Monster ID #$2F: Sorcerer
.addr $93B0      ; $04:$93B0
.byte $04        ; count
.addr $8002      ; $01:$8002; Monster ID #$01: Slime + Monster ID #$30: Metal Slime
.addr $93B7      ; $04:$93B7
.byte $20        ; count
.addr $9A09      ; $01:$9A09; Monster ID #$31: Hunter + Monster ID #$41: Berserker
.addr $93BB      ; $04:$93BB
.byte $13        ; count
.addr $9C36      ; $01:$9C36; Monster ID #$32: Evil Eye + Monster ID #$3D: Dark Eye
.addr $93C2      ; $04:$93C2
.byte $10        ; count
.addr $8ABB      ; $01:$8ABB; Monster ID #$15: Baboon + Monster ID #$1C: Magic Baboon + Monster ID #$33: Hibabango
.addr $93C6      ; $04:$93C6
.byte $0C        ; count
.addr $9627      ; $01:$9627; Monster ID #$27: Goopi + Monster ID #$34: Graboopi
.addr $93CD      ; $04:$93CD
.byte $22        ; count
.addr $96CA      ; $01:$96CA; Monster ID #$28: Orc + Monster ID #$35: Gold Orc + Monster ID #$3F: Orc King
.addr $93D1      ; $04:$93D1
.byte $13        ; count
.addr $9D50      ; $01:$9D50; Monster ID #$36: Evil Clown + Monster ID #$47: Mace Master
.addr $93D8      ; $04:$93D8
.byte $1D        ; count
.addr $883B      ; $01:$883B; Monster ID #$12: Zombie + Monster ID #$2D: Hork + Monster ID #$37: Ghoul
.addr $93DF      ; $04:$93DF
.byte $22        ; count
.addr $9E9A      ; $01:$9E9A; Monster ID #$38: Vampirus + Monster ID #$40: Magic Vampirus
.addr $93E6      ; $04:$93E6
.byte $18        ; count
.addr $94DA      ; $01:$94DA; Monster ID #$25: Undead + Monster ID #$39: Mega Knight + Monster ID #$43: Hargon’s Knight
.addr $93ED      ; $04:$93ED
.byte $19        ; count
.addr $91E0      ; $01:$91E0; Monster ID #$22: Saber Tiger + Monster ID #$3A: Saber Lion
.addr $93F1      ; $04:$93F1
.byte $1C        ; count
.addr $A076      ; $01:$A076; Monster ID #$3B: Metal Hunter + Monster ID #$45: Attackbot
.addr $93F8      ; $04:$93F8
.byte $0D        ; count
.addr $8FAF      ; $01:$8FAF; Monster ID #$1E: Gremlin + Monster ID #$3C: Ozwarg
.addr $93FF      ; $04:$93FF
.byte $13        ; count
.addr $9C36      ; $01:$9C36; Monster ID #$32: Evil Eye + Monster ID #$3D: Dark Eye
.addr $9406      ; $04:$9406
.byte $17        ; count
.addr $98B2      ; $01:$98B2; Monster ID #$2E: Hawk Man + Monster ID #$3E: Gargoyle
.addr $940A      ; $04:$940A
.byte $22        ; count
.addr $96CA      ; $01:$96CA; Monster ID #$28: Orc + Monster ID #$35: Gold Orc + Monster ID #$3F: Orc King
.addr $9411      ; $04:$9411
.byte $22        ; count
.addr $9E9A      ; $01:$9E9A; Monster ID #$38: Vampirus + Monster ID #$40: Magic Vampirus
.addr $9418      ; $04:$9418
.byte $27        ; count
.addr $9A09      ; $01:$9A09; Monster ID #$31: Hunter + Monster ID #$41: Berserker
.addr $941F      ; $04:$941F
.byte $06        ; count
.addr $8404      ; $01:$8404; Monster ID #$08: Babble + Monster ID #$42: Metal Babble
.addr $9426      ; $04:$9426
.byte $18        ; count
.addr $94DA      ; $01:$94DA; Monster ID #$25: Undead + Monster ID #$39: Mega Knight + Monster ID #$43: Hargon’s Knight
.addr $942A      ; $04:$942A
.byte $37        ; count
.addr $A273      ; $01:$A273; Monster ID #$44: Cyclops + Monster ID #$4B: Giant + Monster ID #$4E: Atlas
.addr $942E      ; $04:$942E
.byte $26        ; count
.addr $A076      ; $01:$A076; Monster ID #$3B: Metal Hunter + Monster ID #$45: Attackbot
.addr $9438      ; $04:$9438
.byte $17        ; count
.addr $A619      ; $01:$A619; Monster ID #$46: Green Dragon
.addr $943F      ; $04:$943F
.byte $13        ; count
.addr $9D50      ; $01:$9D50; Monster ID #$36: Evil Clown + Monster ID #$47: Mace Master
.addr $9446      ; $04:$9446
.byte $1E        ; count
.addr $A76A      ; $01:$A76A; Monster ID #$48: Flame + Monster ID #$4A: Blizzard
.addr $944D      ; $04:$944D
.byte $1D        ; count
.addr $A8FC      ; $01:$A8FC; Monster ID #$49: Silver Batboon + Monster ID #$4C: Gold Batboon + Monster ID #$4F: Bazuzu
.addr $9451      ; $04:$9451
.byte $1E        ; count
.addr $A76A      ; $01:$A76A; Monster ID #$48: Flame + Monster ID #$4A: Blizzard
.addr $9458      ; $04:$9458
.byte $40        ; count
.addr $A273      ; $01:$A273; Monster ID #$44: Cyclops + Monster ID #$4B: Giant + Monster ID #$4E: Atlas
.addr $945C      ; $04:$945C
.byte $1D        ; count
.addr $A8FC      ; $01:$A8FC; Monster ID #$49: Silver Batboon + Monster ID #$4C: Gold Batboon + Monster ID #$4F: Bazuzu
.addr $9466      ; $04:$9466
.byte $47        ; count
.addr $AAAF      ; $01:$AAAF; Monster ID #$4D: Bullwong + Monster ID #$50: Zarlox
.addr $946D      ; $04:$946D
.byte $40        ; count
.addr $A273      ; $01:$A273; Monster ID #$44: Cyclops + Monster ID #$4B: Giant + Monster ID #$4E: Atlas
.addr $947A      ; $04:$947A
.byte $1D        ; count
.addr $A8FC      ; $01:$A8FC; Monster ID #$49: Silver Batboon + Monster ID #$4C: Gold Batboon + Monster ID #$4F: Bazuzu
.addr $9484      ; $04:$9484
.byte $4C        ; count
.addr $AAAF      ; $01:$AAAF; Monster ID #$4D: Bullwong + Monster ID #$50: Zarlox
.addr $948B      ; $04:$948B
.byte $35        ; count
.addr $AE98      ; $01:$AE98; Monster ID #$51: Hargon
.addr $9498      ; $04:$9498
.byte $4D        ; count
.addr $B178      ; $01:$B178; Monster ID #$52: Malroth
.addr $949F      ; $04:$949F
; monster palettes
; format is 1 byte X/Y dimensions, 3*(sum of dimension nybbles) palette data
.byte $10,$30,$15,$1C	 ; Monster ID #$01: Slime
.byte $11,$19,$0F,$0F,$30,$37,$16	 ; Monster ID #$02: Big Slug
.byte $11,$30,$15,$0F,$21,$27,$17	 ; Monster ID #$03: Iron Ant
.byte $10,$30,$15,$01	 ; Monster ID #$04: Drakee
.byte $10,$00,$24,$1C	 ; Monster ID #$05: Wild Mouse
.byte $10,$11,$27,$30	 ; Monster ID #$06: Healer
.byte $11,$30,$11,$19,$11,$21,$17	 ; Monster ID #$07: Ghost Mouse
.byte $10,$19,$29,$30	 ; Monster ID #$08: Babble
.byte $11,$30,$17,$0F,$2A,$2C,$1C	 ; Monster ID #$09: Army Ant
.byte $11,$36,$0F,$0F,$30,$1B,$06	 ; Monster ID #$0A: Magician
.byte $10,$1C,$10,$26	 ; Monster ID #$0B: Big Rat
.byte $11,$30,$10,$0F,$00,$15,$27	 ; Monster ID #$0C: Big Cobra
.byte $11,$30,$11,$0F,$25,$26,$16	 ; Monster ID #$0D: Magic Ant
.byte $10,$35,$02,$19	 ; Monster ID #$0E: Magidrakee
.byte $11,$30,$0F,$0F,$16,$21,$37	 ; Monster ID #$0F: Centipod
.byte $10,$30,$2C,$10	 ; Monster ID #$10: Man O’ War
.byte $11,$35,$0F,$0F,$19,$29,$30	 ; Monster ID #$11: Lizard Fly
.byte $11,$22,$28,$0F,$18,$1A,$36	 ; Monster ID #$12: Zombie
.byte $10,$00,$26,$10	 ; Monster ID #$13: Smoke
.byte $10,$06,$2C,$10	 ; Monster ID #$14: Ghost Rat
.byte $11,$30,$0F,$0F,$17,$1C,$26	 ; Monster ID #$15: Baboon
.byte $11,$30,$0F,$0F,$15,$2A,$22	 ; Monster ID #$16: Carnivog
.byte $11,$13,$0F,$0F,$1C,$26,$3A	 ; Monster ID #$17: Megapede
.byte $11,$26,$0F,$0F,$21,$23,$1C	 ; Monster ID #$18: Sea Slug
.byte $11,$30,$0F,$0F,$16,$15,$21	 ; Monster ID #$19: Medusa Ball
.byte $11,$2C,$16,$36,$30,$13,$1C	 ; Monster ID #$1A: Enchanter
.byte $10,$17,$27,$00	 ; Monster ID #$1B: Mud Man
.byte $11,$36,$0F,$0F,$1A,$13,$16	 ; Monster ID #$1C: Magic Baboon
.byte $11,$30,$11,$19,$16,$26,$14	 ; Monster ID #$1D: Demighost
.byte $11,$30,$15,$0F,$10,$23,$1C	 ; Monster ID #$1E: Gremlin
.byte $11,$30,$0F,$0F,$21,$24,$17	 ; Monster ID #$1F: Poison Lily
.byte $11,$0F,$15,$27,$30,$10,$1C	 ; Monster ID #$20: Mummy Man
.byte $11,$37,$0F,$0F,$1C,$26,$29	 ; Monster ID #$21: Gorgon
.byte $11,$11,$0F,$0F,$30,$17,$27	 ; Monster ID #$22: Saber Tiger
.byte $11,$3A,$0F,$0F,$15,$25,$3C	 ; Monster ID #$23: Dragon Fly
.byte $11,$30,$15,$0F,$17,$1A,$0A	 ; Monster ID #$24: Titan Tree
.byte $10,$30,$21,$26	 ; Monster ID #$25: Undead
.byte $11,$3C,$1C,$0F,$21,$13,$25	 ; Monster ID #$26: Basilisk
.byte $10,$30,$27,$10	 ; Monster ID #$27: Goopi
.byte $11,$30,$24,$0F,$17,$29,$10	 ; Monster ID #$28: Orc
.byte $10,$1C,$2C,$11	 ; Monster ID #$29: Puppet Man
.byte $11,$0F,$0F,$36,$31,$21,$14	 ; Monster ID #$2A: Mummy
.byte $11,$30,$27,$0F,$1C,$15,$05	 ; Monster ID #$2B: Evil Tree
.byte $10,$14,$06,$34	 ; Monster ID #$2C: Gas
.byte $11,$0C,$00,$0F,$1C,$10,$17	 ; Monster ID #$2D: Hork
.byte $11,$30,$28,$00,$21,$1C,$24	 ; Monster ID #$2E: Hawk Man
.byte $11,$23,$00,$10,$32,$15,$1C	 ; Monster ID #$2F: Sorcerer
.byte $10,$30,$0F,$00	 ; Monster ID #$30: Metal Slime
.byte $11,$30,$25,$00,$1C,$29,$17	 ; Monster ID #$31: Hunter
.byte $10,$30,$15,$27	 ; Monster ID #$32: Evil Eye
.byte $11,$30,$0F,$0F,$23,$16,$1C	 ; Monster ID #$33: Hibabango
.byte $10,$35,$06,$15	 ; Monster ID #$34: Graboopi
.byte $11,$30,$24,$30,$37,$13,$10	 ; Monster ID #$35: Gold Orc
.byte $11,$2A,$10,$00,$30,$15,$1C	 ; Monster ID #$36: Evil Clown
.byte $11,$06,$34,$0F,$30,$15,$1C	 ; Monster ID #$37: Ghoul
.byte $11,$30,$15,$0F,$1C,$27,$00	 ; Monster ID #$38: Vampirus
.byte $10,$37,$06,$25	 ; Monster ID #$39: Mega Knight
.byte $11,$17,$0F,$0F,$31,$15,$25	 ; Monster ID #$3A: Saber Lion
.byte $11,$30,$2A,$19,$10,$1C,$23	 ; Monster ID #$3B: Metal Hunter
.byte $11,$30,$15,$0F,$1C,$16,$07	 ; Monster ID #$3C: Ozwarg
.byte $10,$35,$1C,$23	 ; Monster ID #$3D: Dark Eye
.byte $11,$30,$1C,$00,$14,$18,$10	 ; Monster ID #$3E: Gargoyle
.byte $11,$37,$00,$31,$22,$17,$1B	 ; Monster ID #$3F: Orc King
.byte $11,$30,$12,$0F,$17,$10,$04	 ; Monster ID #$40: Magic Vampirus
.byte $11,$30,$28,$00,$19,$26,$15	 ; Monster ID #$41: Berserker
.byte $10,$00,$10,$30	 ; Monster ID #$42: Metal Babble
.byte $10,$2C,$13,$24	 ; Monster ID #$43: Hargon’s Knight
.byte $12,$30,$15,$25,$0F,$0F,$0F,$21,$11,$18	 ; Monster ID #$44: Cyclops
.byte $11,$30,$27,$16,$21,$13,$15	 ; Monster ID #$45: Attack Bot
.byte $11,$30,$15,$01,$10,$19,$27	 ; Monster ID #$46: Green Dragon
.byte $11,$21,$15,$05,$3B,$11,$14	 ; Monster ID #$47: Mace Master
.byte $10,$11,$26,$0F	 ; Monster ID #$48: Flame
.byte $11,$15,$21,$0F,$30,$00,$11	 ; Monster ID #$49: Silver Batboon
.byte $10,$30,$21,$0F	 ; Monster ID #$4A: Blizzard
.byte $12,$30,$16,$36,$0F,$16,$26,$2A,$1A,$1C	 ; Monster ID #$4B: Giant
.byte $11,$30,$15,$0F,$36,$1C,$06	 ; Monster ID #$4C: Gold Batboon
.byte $13,$30,$28,$14,$1C,$1A,$14,$23,$0F,$0F,$23,$10,$15	 ; Monster ID #$4D: Bullwong
.byte $12,$30,$21,$31,$0F,$00,$10,$26,$16,$12	 ; Monster ID #$4E: Atlas
.byte $11,$30,$25,$0F,$13,$06,$1C	 ; Monster ID #$4F: Bazuzu
.byte $13,$30,$23,$26,$00,$15,$26,$37,$0F,$0F,$37,$21,$11	 ; Monster ID #$50: Zarlox
.byte $11,$21,$13,$17,$30,$15,$25	 ; Monster ID #$51: Hargon
.byte $34,$30,$24,$2C,$1A,$26,$24,$1A,$24,$1C,$15,$24,$1C,$1A,$26,$1C,$1A,$24,$1C,$1A,$26,$24	 ; Monster ID #$52: Malroth

B04_94B5:
    ldx #$08
    stx $14 ; coords?

    dex
    stx $15 ; coords?

    jsr B04_9A16 ; set number of NMIs to wait for to current battle message delay if current battle message delay is not SLOW

    ldx #$24 ; start with Moonbrooke

B04_94C1:
    lda $062D, x ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    and #$A4 ; clear all battle-only statuses (keep Alive, Poison, and In Party)

    sta $062D, x ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    txa
    sec
    sbc #$12 ; hero data is #$12 bytes wide

    tax
    bpl B04_94C1 ; if more hero data to update, update it

    lda #$FF
    sta $8E ; flag for in battle or not (#$FF)?

    lda #$0F
    sta $B3
    jsr B04_B5F7
    lda #$00
    sta $98 ; outcome of last fight?

    jsr B04_9AAC
    jsr B04_9AB4
    ldx #$00
    stx $60D8
B04_94EA:
    txa
    jsr B04_9EEE ; given an index (in A) into the array of structures at $0663, set $B5-$B6 to the address of the corresponding item inside that structure

    ldy #$09
    lda ($B5), y
    beq B04_94F7
    inc $60D8
B04_94F7:
    inx
    cpx #$04
    bcc B04_94EA
    lda #$00
    sta $A8
    sta $A7
B04_9502:
    jsr B04_9EEE ; given an index (in A) into the array of structures at $0663, set $B5-$B6 to the address of the corresponding item inside that structure

    ldy #$09
    lda ($B5), y
    sta $8F
    beq B04_9532
    inc $A8
    ldy #$00
    lda ($B5), y
    sta $0161 ; current monster ID

    ldx #$00
    jsr B04_9CD6 ; write monster name in A (+ monster number within its group in X, if > 0) to $6119

    dec $60D8
    bne B04_952D
    ldx $A8
    dex
    bne B04_9529
    lda #$54 ; String ID #$0054: [cardinal #] [monster(s)][line]appeared.[end-FC]

    bne B04_952F
B04_9529:
    lda #$53 ; String ID #$0053: And [cardinal #] [monster(s)][line]appeared.[end-FC]

    bne B04_952F
B04_952D:
    lda #$01 ; String ID #$0001: [cardinal #] [monster(s)],[end-FC]

B04_952F:
    jsr B04_9CCA ; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0

B04_9532:
    inc $A7
    lda $A7
    cmp #$04
    bcc B04_9502
    lda $A8
    bne B04_954A
    lda #$02 ; String ID #$0002: But it wasn't real.[end-FC]

    jsr B04_9CCA ; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0

    lda #$FD
    sta $98 ; outcome of last fight?

    jmp B04_9685

B04_954A:
    jsr B04_87AE
    jsr B04_9A3C ; set number of NMIs to wait for to current battle message delay * 1.5 if current battle message delay is < #$80, #$64 otherwise

    jsr B04_9961
    lda #$20
    jsr B04_A020 ; generate a random number between $03 and A in A and $99

    sta $06DD
    cmp #$01
    bcc B04_957D
    bne B04_9585
    lda #$03 ; String ID #$0003: [name] attacked![end-FC]

    jsr B04_9CCA ; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0

    jsr B04_997F
    lda #$04 ; String ID #$0004: Before [name] was set for battle.[end-FC]

    jsr B04_9CCA ; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0

    jsr B04_9AA0
    jsr B04_B6DC
    jsr B04_9A3C ; set number of NMIs to wait for to current battle message delay * 1.5 if current battle message delay is < #$80, #$64 otherwise

    jsr B04_9AD6
    jmp B04_95E3

B04_957D:
    lda #$05 ; String ID #$0005: But the [name] did not see thee.[end-FC]

    jsr B04_9CCA ; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0

    jsr B04_9A3C ; set number of NMIs to wait for to current battle message delay * 1.5 if current battle message delay is < #$80, #$64 otherwise

B04_9585:
    jsr B04_B6DC
    jsr B04_B312
    lda $062F ; Midenhall Battle Command

    cmp #$32
    beq B04_9595
    jmp B04_95E3

B04_9595:
    jsr B04_997F
    lda #$83 ; Music ID #$83: flee SFX

    jsr B0F_C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    lda #$0F ; String ID #$000F: [name] broke away and ran.[end-FC]

    jsr B04_9CCA ; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0

    lda $0161 ; current monster ID

    cmp #$4E ; bosses start at #$4E

    bcs B04_95D2 ; can't run away from bosses

    lda map_id

    cmp #$33 ; Map ID #$33: Sea Cave B5

    bne B04_95BF
    lda map_xpos

    cmp #$10
    bne B04_95BF
    lda map_ypos

    cmp #$0C
    beq B04_95D2 ; can't run away from this fixed combat either

    cmp #$0D
    beq B04_95D2
B04_95BF:
    lda $06DD
    beq B04_95CB
    lda #$03
    jsr B04_A020 ; generate a random number between $03 and A in A and $99

    beq B04_95D2
B04_95CB:
    lda #$FC
    sta $98 ; outcome of last fight?

    jmp B04_9685

B04_95D2:
    jsr B04_9A3C ; set number of NMIs to wait for to current battle message delay * 1.5 if current battle message delay is < #$80, #$64 otherwise

    jsr B04_9AA0
    lda #$10 ; String ID #$0010: But there was no escape.[end-FC]

    jsr B04_9CCA ; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0

    jsr B04_9A3C ; set number of NMIs to wait for to current battle message delay * 1.5 if current battle message delay is < #$80, #$64 otherwise

    jsr B04_9AD6
B04_95E3:
    ldx #$05
    lda #$FF
B04_95E7:
    sta $06D5, x
    dex
    bpl B04_95E7
    lda #$00
    sta $06DB
    lda #$07
    sta $A7
B04_95F6:
    jsr B04_B052
    dec $A7
    lda $A7
    bpl B04_95F6
    jsr B04_9A16 ; set number of NMIs to wait for to current battle message delay if current battle message delay is not SLOW

    lda #$00
    sta $06E0
B04_9607:
    tax
    lda #$4F
    sta $AD
    lda #$00
    sta $0176
    lda $06C7, x
    cmp #$18
    bcs B04_963C
    cmp #$03
    bcc B04_962E
    and #$07
    ldy $06DD
    cpy #$00
    beq B04_963C
    jsr B04_A85B
    lda $98 ; outcome of last fight?

    beq B04_963C
    bne B04_9685
B04_962E:
    ldy $06DD
    cpy #$01
    beq B04_963C
    jsr B04_A0FD
    lda $98 ; outcome of last fight?

    bne B04_9685
B04_963C:
    lda $0176
    bne B04_964A
    lda $AD
    cmp #$4F
    beq B04_964A
    jsr B04_9CDC
B04_964A:
    jsr B04_A0F1
    inc $06E0
    lda $06E0
    cmp #$0B
    bcc B04_9607
    lda #$00
    sta $A7
B04_965B:
    jsr B04_9EEE ; given an index (in A) into the array of structures at $0663, set $B5-$B6 to the address of the corresponding item inside that structure

    ldy #$0A
    lda ($B5), y
    cmp #$03
    bcs B04_9675
    jsr B04_9EE4 ; given an index (in A) into the array of hero data structures at $062D, set $B9-$BA to the address of the corresponding item inside that structure

    ldy #$00
    lda ($B9), y
    bmi B04_9675
    lda #$FF
    ldy #$0A
    sta ($B5), y
B04_9675:
    inc $A7
    lda $A7
    cmp #$04
    bcc B04_965B
    lda #$FF
    sta $06DD
    jmp B04_9585

B04_9685:
    lda #$01
    sta $8E ; flag for in battle or not (#$FF)?

    lda $98 ; outcome of last fight?

    cmp #$FE
    bcs B04_9692
    jmp B0F_C5A3

B04_9692:
    cmp #$FF
    bne B04_96BB
    jsr B04_9A3C ; set number of NMIs to wait for to current battle message delay * 1.5 if current battle message delay is < #$80, #$64 otherwise

    jsr B04_9ABF
    lda #$12 ; Music ID #$12: party defeat BGM

    jsr B0F_C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    ldx #$1B ; String ID #$001B: Alas, brave [name] hast died.[end-FC]

    lda $063F ; Cannock status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    and #$04
    beq B04_96AE
    lda #$80
    ldx #$B1 ; String ID #$0151: [name] is utterly destroyed.[end-FC]

B04_96AE:
    stx $C7
    jsr B04_9CD0 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    lda $C7
    jsr B04_9CCA ; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0

    jmp B04_9A58

B04_96BB:
    jsr B04_9991
    lda #$00 ; Midenhall

    sta $A7 ; hero ID

B04_96C2:
    jsr B04_9EE4 ; given an index (in A) into the array of hero data structures at $062D, set $B9-$BA to the address of the corresponding item inside that structure

    ldy #$00
    lda ($B9), y ; Status

    bpl B04_9714 ; branch if dead

    ldy #$06
    lda ($B9), y ; hero's current EXP, byte 0

    clc
    adc $0626 ; EXP earned this battle or current hero's current EXP, byte 0

    sta $99 ; new EXP, byte 0

    iny
    lda ($B9), y ; hero's current EXP, byte 1

    adc $0627 ; EXP earned this battle or current hero's current EXP, byte 1

    sta $9A ; new EXP, byte 1

    iny
    lda ($B9), y ; hero's current EXP, byte 2

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
B04_96F8:
    lda #$40
    sta $99
    lda #$42
    sta $9A
    lda #$0F
    sta $9B
B04_9704:
    ldy #$06
    lda $99 ; new EXP, byte 0

    sta ($B9), y ; hero's current EXP, byte 0

    iny
    lda $9A ; new EXP, byte 1

    sta ($B9), y ; hero's current EXP, byte 1

    iny
    lda $9B ; new EXP, byte 2

    sta ($B9), y ; hero's current EXP, byte 2

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
    jsr B0F_C5A3
    jmp B04_9A3C ; set number of NMIs to wait for to current battle message delay * 1.5 if current battle message delay is < #$80, #$64 otherwise


B04_9737:
    jsr B04_99EA
    jsr B04_9ABF
    lda #$09 ; Music ID #$09: battle win BGM

    jsr B0F_C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    lda $0160 ; ID of only monster (/monster group) or #$53 for "Enemies" if there are multiple groups

    ldx #$00
    jsr B04_9CD6 ; write monster name in A (+ monster number within its group in X, if > 0) to $6119

    lda #$19 ; String ID #$0019: Thou hast defeated the [name].[end-FC]

    jsr B04_9CCA ; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0

    lda $0161 ; current monster ID

    cmp #$52
    bne B04_975B
    lda #$00
    sta $05F7 ; probably BGM for current area

B04_975B:
    jsr B0F_C595
    lda $0161 ; current monster ID

    cmp #$51 ; monster #$51 = Hargon

    bcc B04_9768 ; if you beat anything less than Hargon or Malroth, go see if you got an item drop

    jmp B04_9A3C ; set number of NMIs to wait for to current battle message delay * 1.5 if current battle message delay is < #$80, #$64 otherwise; otherwise, no item drop for you!


B04_9768:
    lda #$49 ; String ID #$0049: [FD]Of Experience points thou has gained [number][end-FF]

    jsr B04_9CCA ; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0

    lda #$00 ; start by assuming no item drop (since it's probably true anyway :p)

    sta $61B0 ; flag for whether you get an item drop or not

    jsr B04_9946 ; determine max possible inventory offset based on current party

    ldx #$00 ; start scanning inventory from the beginning

B04_9777:
    lda $0600, x ; Midenhall inventory item 1 (| #$40 if equipped)

    beq B04_9784 ; if you have an empty slot, maybe you'll get an item drop

    inx ; otherwise get ready to check the next slot

    cpx $A3 ; max possible inventory offset based on current party

    bcc B04_9777 ; if there are more slots to check, check them

    jmp B04_986A ; if you get here, you have a full inventory; no item drop for you!


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

B04_979C:
    stx $A8
    lda map_id

    cmp #$04 ; guaranteed drop; #$04 = both Item ID #$04: Staff of Thunder and Map ID #$04: Midenhall B1

    beq B04_97D9
    ldx $0161 ; current monster ID

    dex ; monster IDs start at 1, drop list starts at 0

    lda DropRates, x ; monster drop rates/items

    bne B04_97B0 ; if monster has a drop, see if you get it

    jmp B04_986A ; otherwise, on with the show...


B04_97B0:
    sta $A4 ; drop rate/item

    and #$C0 ; pick out the drop rate bits

    beq B04_97C0 ; 0b00xxxxxx

    cmp #$80
    beq B04_97C4 ; 0b10xxxxxx

    bcs B04_97C8 ; 0b11xxxxxx

    lda #$0F ; 0b01xxxxxx; need to match 4 bits => 1/16 chance

    bne B04_97CA
B04_97C0:
    lda #$07 ; need to match 3 bits => 1/8 chance

    bne B04_97CA
B04_97C4:
    lda #$1F ; need to match 5 bits => 1/32 chance

    bne B04_97CA
B04_97C8:
    lda #$7F ; need to match 7 bits => 1/128 chance

B04_97CA:
    sta $99 ; drop rate

    jsr B0F_C3AB ; generate a random number and store it in $32-$33 (two passes)

    lda $32 ; RNG byte 0

    and $99 ; drop rate

    bne B04_9847 ; if random number is not 0 in all the required bits, no item drop for you!

    lda $A4 ; drop rate/item

    and #$3F ; this time pick out the dropped item

B04_97D9:
    sta $A4 ; dropped item

    ldx #$00 ; start scanning through party inventory from the beginning

B04_97DD:
    lda $0600, x ; Midenhall inventory item 1 (| #$40 if equipped)

    and #$3F ; pick out the base item, don't care whether it's equipped or not

    cmp $A4 ; do you already have one of these items?

    beq B04_984A ; if yes, go see if it's one you're allowed to get another copy of anyway

    inx ; otherwise set X for the next inventory slot

    cpx $A3 ; max possible inventory offset based on current party

    bcc B04_97DD ; if there are more inventory slots to check, check them

B04_97EB:
    ldx $A7 ; offset of first empty inventory slot

    lda $A4 ; dropped item

    sta $0600, x ; Midenhall inventory item 1 (| #$40 if equipped)

B04_97F2:
    lda #$8A ; String ID #$008A: .[end-FC]

    jsr B0F_FA4A ; display string ID specified by A

    lda #$01 ; flag item gain for later logic

    sta $61B0 ; flag for whether you get an item drop or not

    lda $0160 ; ID of only monster (/monster group) or #$53 for "Enemies" if there are multiple groups

    ldx #$00
    jsr B04_9CD6 ; write monster name in A (+ monster number within its group in X, if > 0) to $6119

    lda #$AA ; String ID #$014A: [wait][name] had the Treasure Chest.[wait][end-FC]

    jsr B04_9CCA ; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0

    lda #$92 ; Music ID #$92: open chest SFX

    jsr B0F_C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    lda $A9
    jsr B04_9EE4 ; given an index (in A) into the array of hero data structures at $062D, set $B9-$BA to the address of the corresponding item inside that structure

    ldy #$00
    lda ($B9), y ; status byte

    bmi B04_981E ; if the hero with the first empty inventory slot is also alive, they get to open the chest, otherwise the first living hero opens it

    lda $A8
    jmp B04_9820

B04_981E:
    lda $A9
B04_9820:
    jsr B04_9CD0 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    lda #$65 ; String ID #$0105: Seeing a treasure chest, [name] opened it.[wait][end-FC]

    jsr B04_9CCA ; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0

    lda $A4 ; dropped item

    beq B04_9864 ; branch if no dropped item

    sta $95 ; ID for [item] and [spell] control codes; dropped item

    lda #$64 ; String ID #$0104: And there [name] discovered the [item]![end-FC]

    jsr B04_9CCA ; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0

    ldy #$00
    lda ($B9), y ; status byte

    bmi B04_986A ; if hero with the first empty inventory slot is alive, then we're done with items, otherwise give it to their ghost

    lda $A9
    jsr B04_9CD0 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    lda $A4 ; dropped item

    sta $95 ; ID for [item] and [spell] control codes; yup, still the dropped item...

    lda #$77 ; String ID #$0117: gave the [item] to the ghost of [name].[end-FC]

    jsr B04_9CCA ; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0

B04_9847:
    jmp B04_986A ; done with items, now it's time to deal with gold


; list of item drops you're allowed to have multiples of
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
B04_9864:
    asl $06E6
    rol $06EC
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
    jsr B0F_C3AB ; generate a random number and store it in $32-$33 (two passes)

    lda $32 ; RNG byte 0

    sta $9B
    jsr B04_A05B ; 16-bit multiplication: ($99-$9A) = ($99-$9A) * ($9B), overflow in $9E, copy of ($99-$9A) in ($A1-$9D)

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

B04_98AE:
    sta $0625 ; party gold, high byte

    lda $99 ; store received gold to $8F-$90 so we can print it later

    sta $8F
    lda $9A
    sta $90
    lda $61B0 ; flag for whether you get an item drop or not

    bne B04_98C9 ; if you get an item drop, go deal with that

    lda #$8B ; String ID #$008B: [no voice]and earned [number] piece[(s)] of gold.[end-FC]

    jsr B04_9CEA ; set return bank $94 to #$04

    jsr B0F_FA4A ; display string ID specified by A

    jmp B04_98CE

B04_98C9:
    lda #$48 ; String ID #$0048: And earned [number] piece[(s)] of gold.[end-FC]

    jsr B04_9CCA ; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0

B04_98CE:
    lda #$00
    sta $C7
B04_98D2:
    jsr B04_9EE4 ; given an index (in A) into the array of hero data structures at $062D, set $B9-$BA to the address of the corresponding item inside that structure

    ldy #$06
B04_98D7:
    lda ($B9), y
    sta $0620, y ; monster group 3 monster ID

    iny
    cpy #$09
    bcc B04_98D7
B04_98E1:
    ldx $C7
    jsr B04_9D43 ; given hero ID in X and hero's current EXP in $0626-$0628, set $8F-$90 to EXP required to reach next level; return current level in A

    sta $C8
    ldy #$11
    lda ($B9), y
    cmp $C8
    bcs B04_9935
    ldx $C7
    tay
    iny
    tya
    jsr B04_9DC8 ; calculate hero X stats for level A

    lda #$08 ; Music ID #$08: level up BGM

    jsr B0F_C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    lda $C7
    jsr B04_9CD0 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    jsr B0F_C595
    lda #$47 ; String ID #$0047: [wait]Wit and courage have served thee well, for [name] has been promoted to the next level.[end-FC]

    jsr B04_9CCA ; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0

    jsr B04_9AAC
    ldy #$4A
    sty $C5
B04_9911:
    lda $0059, y ; menu ID

    beq B04_9921
    sta $8F
    lda #$00
    sta $90
    lda $C5 ; String IDs #$004A-#$004D: "[wait]Power increases by [number].[end-FC]", "[wait]Reaction Speed increases by [number].[end-FC]", "[wait]Maximum HP increases by [number].[end-FC]", "[wait]Maximum MP increases by [number].[end-FC]"

    jsr B04_9CCA ; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0

B04_9921:
    inc $C5
    ldy $C5
    cpy #$4E
    bcc B04_9911
    lda $B3
    beq B04_9932
    lda #$4E ; String ID #$004E: [wait]And [name] learned one new spell.[end-FC]

    jsr B04_9CCA ; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0

B04_9932:
    jmp B04_98E1

B04_9935:
    inc $C7
    lda $C7
    cmp #$03
    bcc B04_98D2
    jsr B04_9CEA ; set return bank $94 to #$04

    jsr B0F_F642 ; display appropriate battle EXP + Gold menu

    jmp B04_9A58

; determine max possible inventory offset based on current party
B04_9946:
    lda $063F ; Cannock status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    and #$04 ; pick out Cannock's In Party bit

    beq B04_995C ; branch if Cannock not in party yet

    lda $0651 ; Moonbrooke status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    and #$04 ; pick out Moonbrooke's In Party bit

    beq B04_9958 ; branch if Moonbrooke not in party yet

    ldx #$18 ; otherwise the gang's all together and you have a full 24 inventory slots

    bne B04_995E
B04_9958:
    ldx #$10 ; if it's just the boys, you have 16 inventory slots

    bne B04_995E
B04_995C:
    ldx #$08 ; if Midenhall's alone, you only have 8 slots

B04_995E:
    stx $A3 ; max possible inventory offset based on current party

    rts

B04_9961:
    jsr B04_9AD6
    jsr B04_9A84
    cmp #$01
    bne B04_997B
    tya
    jsr B04_9EEE ; given an index (in A) into the array of structures at $0663, set $B5-$B6 to the address of the corresponding item inside that structure

    ldy #$00
    lda ($B5), y
B04_9973:
    ldx #$00
    sta $0160 ; ID of only monster (/monster group) or #$53 for "Enemies" if there are multiple groups

    jmp B04_9CD6 ; write monster name in A (+ monster number within its group in X, if > 0) to $6119


B04_997B:
    lda #$53
    bne B04_9973
B04_997F:
    lda #$01
    jsr B04_9EE4 ; given an index (in A) into the array of hero data structures at $062D, set $B9-$BA to the address of the corresponding item inside that structure

    ldy #$00
    lda ($B9), y
    and #$04
    beq B04_998E
    lda #$80
B04_998E:
    jmp B04_9CD0 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA


B04_9991:
    lda $05FE ; number of monsters in current group killed by last attack?

    beq B04_99CB
    sta $9B
    lda $0626 ; EXP earned this battle or current hero's current EXP, byte 0

    sta $99
    lda $0627 ; EXP earned this battle or current hero's current EXP, byte 1

    sta $9A
    ora $99
    beq B04_99E5
    jsr B04_A05B ; 16-bit multiplication: ($99-$9A) = ($99-$9A) * ($9B), overflow in $9E, copy of ($99-$9A) in ($A1-$9D)

    lda #$0A
    sta $9B
    lda #$00
    sta $9C
    jsr B04_A0A2
    inc $99
    bne B04_99BA
    inc $9A
B04_99BA:
    lda $0626 ; EXP earned this battle or current hero's current EXP, byte 0

    clc
    adc $99
    sta $0626 ; EXP earned this battle or current hero's current EXP, byte 0

    lda $0627 ; EXP earned this battle or current hero's current EXP, byte 1

    adc $9A
    sta $0627 ; EXP earned this battle or current hero's current EXP, byte 1

B04_99CB:
    lda $0627 ; EXP earned this battle or current hero's current EXP, byte 1

    cmp #$27
    bcc B04_99E5
    bne B04_99DB
    lda $0626 ; EXP earned this battle or current hero's current EXP, byte 0

    cmp #$10
    bcc B04_99E5
B04_99DB:
    lda #$0F
    sta $0626 ; EXP earned this battle or current hero's current EXP, byte 0

    lda #$27
    sta $0627 ; EXP earned this battle or current hero's current EXP, byte 1

B04_99E5:
    rts

B04_99E6:
    lda $8E ; flag for in battle or not (#$FF)?
    bpl B04_9A1F
B04_99EA:
    lda $062C ; current battle message delay
    cmp #$FF ; is it SLOW?
    bne B04_9A13
B04_99F1:
    jsr B04_9A4D ; read joypad 1 data into $2F; if no button pressed, set $015D to #$00

    lda $015D
    beq B04_9A03 ; branch if no button pressed

    jsr B0F_C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    dec $015D
    bne B04_99F1
    beq B04_9A06
B04_9A03:
    jsr B04_9A20 ; write either [space] or [down triangle] to PPU $2358 based on the current value of $03

B04_9A06:
    lda $2F ; joypad 1 data

    ror ; set C to "A" button status

    bcc B04_99F1
    lda #$32
    sta $015D
    jmp B04_9A2A ; write [space] to PPU $2358


B04_9A13:
    jsr B0F_C1F5 ; wait for battle message delay to expire

; set number of NMIs to wait for to current battle message delay if current battle message delay is not SLOW
B04_9A16:
    lda $062C ; current battle message delay

    cmp #$FF ; is it SLOW?

    beq B04_9A1F ; if yes, leave number of NMIs to wait for alone, otherwise set number of NMIs to wait for to battle message delay

    sta $93 ; NMI counter, decremented once per NMI until it reaches 0

B04_9A1F:
    rts

; write either [space] or [down triangle] to PPU $2358 based on the current value of $03
B04_9A20:
    lda $03 ; game clock?

    and #$18
    beq B04_9A2A ; write [space] to PPU $2358

    lda #$73 ; Tile ID #$73: [down triangle]

    bne B04_9A2C
; write [space] to PPU $2358
B04_9A2A:
    lda #$5F ; Tile ID #$5F: [space]

B04_9A2C:
    sta $09 ; tile ID to write to PPU

    lda #$58
    sta $07 ; current PPU write address, low byte; PPU address, low byte

    lda #$23
    sta $08 ; current PPU write address, high byte; PPU address, high byte

    jsr B0F_C1FA ; wait for $02 to not be #$C0, write PPU address in $07-$08 and data in $09 to PPU write buffer at $0300,$02, $01 += 1, $02 += 3, and set $0183 to #$00
    jmp B0F_C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF


; set number of NMIs to wait for to current battle message delay * 1.5 if current battle message delay is < #$80, #$64 otherwise
B04_9A3C:
    lda $062C ; current battle message delay

    bpl B04_9A45 ; only SLOW sets bit 7

    lda #$64 ; for SLOW, use #$64

    bne B04_9A49
B04_9A45:
    lsr ; otherwise use current # of frames * 1.5 (i.e. #$3C [60] or #$69 [105])

    adc $062C ; current battle message delay

B04_9A49:
    sta $93 ; NMI counter, decremented once per NMI until it reaches 0

    bne B04_9A13 ; branch always taken

; read joypad 1 data into $2F; if no button pressed, set $015D to #$00

B04_9A4D:
    jsr B0F_C476 ; read joypad 1 data into $2F

    lda $2F ; joypad 1 data

    bne B04_9A57
    sta $015D ; #$00

B04_9A57:
    rts

B04_9A58:
    lda #$01
    sta $015D
B04_9A5D:
    jsr B04_9A4D ; read joypad 1 data into $2F; if no button pressed, set $015D to #$00

    and #$F0
    bne B04_9A6D
    lda $015D
    bne B04_9A5D
    lda $2F ; joypad 1 data

    beq B04_9A5D
B04_9A6D:
    lda $4017 ; Joypad #2/SOFTCLK (READ: #$80: Vertical Clock Signal (External), #$40: Vertical Clock Signal (Internal), #$10: Zapper Trigger Not Pulled, #$08: Zapper Sprite Detection, #$01: Joypad Data; WRITE: #$01: set Expansion Port Method to Read)

    ror
    bcc B04_9A83
    lda map_xpos

    cmp #$EB
    bne B04_9A83
    clc
    adc map_id

    adc map_ypos

    bne B04_9A83
    inc $062C ; current battle message delay

B04_9A83:
    rts

B04_9A84:
    ldx #$00
    stx $C7
B04_9A88:
    txa
    jsr B04_9ED2 ; given an index (in A) into the array of structures at $0663, set $BF-$C0 to the address of the corresponding item inside that structure

    ldy #$09
    lda ($BF), y
    beq B04_9A96
    inc $C7
    stx $C8
B04_9A96:
    inx
    cpx #$04
    bcc B04_9A88
    ldy $C8
    lda $C7
    rts

B04_9AA0:
    lda #$32
    sta $062F ; Midenhall Battle Command

    sta $0641 ; Cannock Battle Command

    sta $0653 ; Moonbrooke Battle Command

    rts

B04_9AAC:
    jsr B04_9CEA ; set return bank $94 to #$04

    lda #$01 ; Menu ID #$01: Mini status window, top

    jmp B0F_EB89 ; open menu specified by A


B04_9AB4:
    jsr B04_9AC7
    lda $B3
    and #$80
    ora #$0F
    sta $B3
B04_9ABF:
    jsr B04_9CEA ; set return bank $94 to #$04

    lda #$04 ; Menu ID #$04: Dialogue window

    jmp B0F_EB89 ; open menu specified by A


B04_9AC7:
    jsr B04_9CEA ; set return bank $94 to #$04

    lda #$04
B04_9ACC:
    jmp B0F_F78C ; wipe selected menu region


    jsr B04_9CEA ; set return bank $94 to #$04

    lda #$06
    bne B04_9ACC
B04_9AD6:
    jsr B04_9CEA ; set return bank $94 to #$04

    lda #$0F
    jmp B0F_FBFF

; STA $B4, $B3 |= #$20
B04_9ADE:
    sta $B4
    lda $B3
    ora #$20
    sta $B3
    rts

B04_9AE7:
    jsr B04_9A16 ; set number of NMIs to wait for to current battle message delay if current battle message delay is not SLOW

    lda #$FF
    sta $0176
    jsr B04_9CEA ; set return bank $94 to #$04

    lda $B3
    and #$10
    bne B04_9B42
    jsr B04_9AD6
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

B04_9B0F:
    sta $9B
    jsr B04_9BB8
    ldx $9C
    dex
    bne B04_9B1B
    lda #$1F
B04_9B1B:
    dex
    bne B04_9B20
    lda #$1E
B04_9B20:
    dex
    bne B04_9B25
    lda #$1C
B04_9B25:
    dex
    bne B04_9B2A
    lda #$18
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
    jmp B04_9B9F

B04_9B3F:
    jsr B04_99E6
B04_9B42:
    lda $B3
    and #$0F
    jsr B0F_FBFF
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
B04_9B5F:
    lda #$88 ; Music ID #$88: critical hit SFX

    jsr B0F_C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    jmp B04_9B7C

B04_9B67:
    lda $AB
    bmi B04_9B6F
    lda #$8D ; Music ID #$8D: miss 2 SFX

    bne B04_9B71
B04_9B6F:
    lda #$8C ; Music ID #$8C: miss 1 SFX

B04_9B71:
    jsr B0F_C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    lda $B4
    jsr B04_9CCA ; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0

    jmp B04_9B84

B04_9B7C:
    lda $B4
    jsr B04_9CCA ; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0

    jsr B04_99E6
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
    jsr B04_9BB8
    lda $B3
    and #$DF
B04_9B9F:
    sta $B3
    jsr B04_9AAC
    lda $98 ; outcome of last fight?

    bne B04_9BAB
    jsr B04_99E6
B04_9BAB:
    rts

B04_9BAC:
    ldy #$03
B04_9BAE:
    cmp $0172, y
    beq B04_9BB7
    dey
    bpl B04_9BAE
    clc
B04_9BB7:
    rts

B04_9BB8:
    lda $99
    cmp #$F0
    bcc B04_9BC6
    eor #$FF
    jsr B04_9CD0 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    jmp B04_9C4D ; if $9B < #$60, display string ID specified by $9B, otherwise display string ID specified by $9B + #$A0; play extra SFX


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
B04_9BD8:
    ldx #$16
    bne B04_9BDE
B04_9BDC:
    ldx #$0B
B04_9BDE:
    lda $9A
    and #$0F
    beq B04_9BF6
    sta $9F
    txa
    clc
    adc $9F
    tax
    lda $0663, x ; monster ID, group 1

    and #$07
    sta $9F
    tax
    lda $016A, x
B04_9BF6:
    tax
    lda $99
    jsr B04_9BAC
    bcc B04_9C08
    ldy $9B
    cpy #$19
    beq B04_9C08
    cpy #$24
    bne B04_9C0A
B04_9C08:
    ldx #$00
B04_9C0A:
    jsr B04_9CD6 ; write monster name in A (+ monster number within its group in X, if > 0) to $6119

    jsr B04_9CBC ; if $9B < #$60, display string ID specified by $9B, otherwise display string ID specified by $9B + #$A0

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
B04_9C4D:
    jsr B04_9CBC ; if $9B < #$60, display string ID specified by $9B, otherwise display string ID specified by $9B + #$A0

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

B04_9C6F:
    jmp B04_A0F1

B04_9C72:
    lda #$8D ; Music ID #$8D: miss 2 SFX

    bne B04_9C84
B04_9C76:
    lda #$8C ; Music ID #$8C: miss 1 SFX

    bne B04_9C84
B04_9C7A:
    lda #$94 ; Music ID #$94: burning SFX

    bne B04_9C84
B04_9C7E:
    lda #$89 ; Music ID #$89: attack 1 SFX

    bne B04_9C84
B04_9C82:
    lda #$8B ; Music ID #$8B: attack 2 SFX

B04_9C84:
    jmp B0F_C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])


B04_9C87:
    jmp B04_8AB0

B04_9C8A:
    lda #$83 ; Music ID #$83: flee SFX

    jsr B04_9CAC ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM]); preserves X/Y

B04_9C8F:
    jsr B04_8AF1
    lda $9F
    tax
    lda #$FF
    sta $0162, x
    rts

B04_9C9B:
    lda #$90 ; Music ID #$90: casting SFX

    jsr B0F_C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    jmp B0F_C515 ; flash screen 10 times


B04_9CA3:
    jmp B04_8A9E

B04_9CA6:
    jsr B04_A0F1
    jmp B04_8FE2

; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM]); preserves X/Y
B04_9CAC:
    sta $9D
    txa
    pha
    tya
    pha
    lda $9D
    jsr B0F_C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    pla
    tay
    pla
    tax
    rts

; if $9B < #$60, display string ID specified by $9B, otherwise display string ID specified by $9B + #$A0
B04_9CBC:
    lda $9B
; if A < #$60, display string ID specified by A, otherwise display string ID specified by A + #$A0
B04_9CBE:
    cmp #$60
    bcc B04_9CC7 ; display string ID specified by A

    sbc #$60
    jmp B0F_FA4E ; display string ID specified by A + #$0100


; display string ID specified by A
B04_9CC7:
    jmp B0F_FA4A ; display string ID specified by A


; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0
B04_9CCA:
    jsr B04_9CEA ; set return bank $94 to #$04

    jmp B04_9CBE ; if A < #$60, display string ID specified by A, otherwise display string ID specified by A + #$A0


; print name of hero given by low 2 bits of A to $6119, terminated by #$FA
B04_9CD0:
    jsr B04_9CEA ; set return bank $94 to #$04

    jmp B0F_FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA


; write monster name in A (+ monster number within its group in X, if > 0) to $6119
B04_9CD6:
    jsr B04_9CEA ; set return bank $94 to #$04
    jmp B0F_FC89 ; write monster name in A (+ monster number within its group in X, if > 0) to $6119

B04_9CDC:
    lda $B3
    ora #$40
    sta $B3
    jmp B04_9AE7

B04_9CE5:
    sta $B2
    jmp B04_9AE7

; set return bank $94 to #$04
B04_9CEA:
    pha
    lda #$04
    sta $94 ; return bank for various function calls, doubles as index of selected option for multiple-choice menus

    pla
    rts

; set $8F-$90 to EXP required to reach next level
B04_9CF1:
    sta $A7
    jsr B04_9EE4 ; given an index (in A) into the array of hero data structures at $062D, set $B9-$BA to the address of the corresponding item inside that structure

    ldy #$06 ; offset into hero data for current EXP byte 0

    lda ($B9), y
    sta $0626 ; EXP earned this battle or current hero's current EXP, byte 0

    iny
    lda ($B9), y
    sta $0627 ; EXP earned this battle or current hero's current EXP, byte 1

    iny
    lda ($B9), y
    sta $0628 ; EXP earned this battle or current hero's current EXP, byte 2

    ldx $A7
    jmp B04_9D43 ; given hero ID in X and hero's current EXP in $0626-$0628, set $8F-$90 to EXP required to reach next level; return current level in A


; update each hero's stats based on their current EXP
B04_9D0E:
    lda #$00 ; Midenhall
    sta $06DF ; hero ID
B04_9D13:
    jsr B04_9EE4 ; given an index (in A) into the array of hero data structures at $062D, set $B9-$BA to the address of the corresponding item inside that structure

    ldy #$06 ; offset into hero data for current EXP byte 0

    lda ($B9), y
    sta $0626 ; EXP earned this battle or current hero's current EXP, byte 0

    iny
    lda ($B9), y
    sta $0627 ; EXP earned this battle or current hero's current EXP, byte 1

    iny
    lda ($B9), y
    sta $0628 ; EXP earned this battle or current hero's current EXP, byte 2

    ldx $06DF ; hero ID

    jsr B04_9D43 ; given hero ID in X and hero's current EXP in $0626-$0628, set $8F-$90 to EXP required to reach next level; return current level in A

    ldx $06DF ; hero ID

    jsr B04_9DC8 ; calculate hero X stats for level A

    inc $06DF ; hero ID

    lda $06DF
; 3 heroes total
    cmp #$03
    bcc B04_9D13
    rts


; per-hero offsets into required EXP lists
B04_9D40:
.byte $00,$62,$BA

; given hero ID in X and hero's current EXP in $0626-$0628, set $8F-$90 to EXP required to reach next level; return current level in A
B04_9D43:
    lda B04_9D40, x ; per-hero offsets into required EXP lists

    tax
    lda #$00
    sta $0629 ; current hero's required EXP, byte 0

    sta $062A ; current hero's required EXP, byte 1

    sta $062B ; current hero's required EXP, byte 2

    lda #$01
    sta $A7 ; start at level 1

B04_9D56:
    ldy #$00 ; normally byte 2 of the required EXP is #$00...

    cpx #$F2 ; i.e. $BDB5, a.k.a. start of Moonbrooke's level 30 EXP

    bcc B04_9D5E
    ldy #$01 ; ... but Moonbrooke's level 30+ each take an extra 65536 EXP that isn't contained in the (2 byte per level) required EXP table

B04_9D5E:
    lda ExpNeeded, x ; EXP per level, low byte

    cmp ExpNeeded+1, x ; EXP per level, high byte

    beq B04_9DC2 ; hero at max level; write 0 EXP remaining until next level to $8F-$90; but low byte is never equal to high byte, so this is pointless; would make sense if e.g. list was terminated with #$00 #$00

    clc
    adc $0629 ; current hero's required EXP, byte 0

    sta $0629 ; current hero's required EXP, byte 0

    lda ExpNeeded+1, x ; EXP per level, high byte

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
    jmp B04_9D56 ; loop to calculate next level

; required EXP > current EXP; write EXP remaining until next level to $8F-$90 (but what about Moonbrooke's extra 65536 EXP?)
B04_9DAE:
    lda $0629 ; current hero's required EXP, byte 0
    sec
    sbc $0626 ; EXP earned this battle or current hero's current EXP, byte 0
    sta $8F
    lda $062A ; current hero's required EXP, byte 1
    sbc $0627 ; EXP earned this battle or current hero's current EXP, byte 1

B04_9DBD:
    sta $90
    lda $A7
    rts

; hero at max level; write 0 EXP remaining until next level to $8F-$90
B04_9DC2:
    lda #$00
    sta $8F
    beq B04_9DBD
; calculate hero X stats for level A
B04_9DC8:
    sta $A7 ; level

    stx $A8 ; hero

    txa
    jsr B04_9EC8 ; given an index (in A) into the array of hero data structures at $062D, set $C3-$C4 to the address of the corresponding item inside that structure

    lda $A8 ; hero

    asl
    tax ; 4 level up stats are pack into 2 bytes

    asl
    tay ; starting stats are 1 per byte (since they can't fit into a nybble)

    lda #$01
    sta $A9 ; start calculating from level 1

    lda #$00
    sta $B3 ; # of spells learned this level (maybe just flag)

    lda Starting_Stats, y ; starting STR

    sta $99
    lda Starting_Stats+1, y ; starting AGI

    sta $9A
    lda Starting_Stats+2, y ; starting Max HP

    sta $9B
    lda Starting_Stats+3, y ; starting Max MP

    sta $9C
B04_9DF2:
    lda $A9 ; current level

    cmp $A7 ; desired level

    bcs B04_9E21 ; if we've finished calculating up to the desired level, we're done with this loop

    ldy #$00 ; start with stat #$00 (STR)

    jsr B04_9E97 ; process high nybble of level up data

    lda LevelStatUps, x ; level up stat nybbles (STR/AGI, HP/MP)

    jsr B04_9E9E ; process low nybble of level up data

    inx ; move to next byte of level up data (Max HP/MP)

    jsr B04_9E97 ; process high nybble of level up data

    lda LevelStatUps, x ; level up stat nybbles (STR/AGI, HP/MP)

    jsr B04_9E9E ; process low nybble of level up data

    inc $A9 ; current level++

    lda $A9
    cmp #$2E ; only Midenhall has level up data for levels > 45, so in that case the next byte of level up data is his too

    bcs B04_9E1D
    cmp #$24 ; only Midenhall and Cannock have level up data for levels > 35, so in those cases we need to skip an extra 2 bytes for the other hero's data

    bcs B04_9E1B
    inx ; otherwise all 3 heroes have level up data, so skip over the data for the 2 other heroes

    inx
B04_9E1B:
    inx
    inx
B04_9E1D:
    inx
    jmp B04_9DF2 ; loop to calculate next level


; update hero stats and spell lists
B04_9E21:
    ldy #$11 ; offset into hero data for level

    lda $A7 ; current level

    sta ($C3), y ; update hero's current level

    ldy #$09 ; offset for STR

    lda $99 ; current STR

    sta ($C3), y ; update hero's current STR

    iny
    lda $9A ; current AGI

    sta ($C3), y ; update hero's current AGI

    ldy #$03 ; offset for Max HP

    lda $9B ; Max HP

    sta ($C3), y ; update hero's Max HP

    iny
    lda #$00
    sta ($C3), y ; set high byte of Max HP to #$00

    iny
    lda $9C ; Max MP

    sta ($C3), y ; update hero's Max MP

    lsr $9A ; AGI / 2 = hero's base DEF

    lda $A8 ; hero

    asl ; 8 inventory items per hero

    asl
    asl
    tax
    stx $A7
; loop through inventory items to update ATK/DEF
B04_9E4C:
    lda $0600, x ; Midenhall inventory item 1 (| #$40 if equipped)

    ldy #$00 ; start index with ATK

    cmp #$41 ; equipped items have bit 6 set

    bcc B04_9E69 ; if not equipped, it doesn't count

    cmp #$51 ; there are #$10 weapons

    bcc B04_9E5E ; if it's an equipped weapon, go update stat

    iny ; update index to DEF

    cmp #$64 ; the last armour/shield/helmet ID is #$23

    bcs B04_9E69 ; if it's equipped but not a weapon/armour/shield/helmet, it doesn't count

B04_9E5E:
    tax
    lda EquipmentStats-$41, x ; base offset for equipment power list at $BEEB

    clc ; not needed since we only get here via taking BCC or not taking BCS, so C is known to be clear

    adc $0099, y ; add current stat and equipment's power

    sta $0099, y ; update current stat

B04_9E69:
    inc $A7 ; update inventory index

    ldx $A7
    txa
    and #$07
    bne B04_9E4C ; if there's more inventory to check, loop to keep checking

    ldy #$0B ; offset into hero data for ATK

    lda $99 ; current ATK

    sta ($C3), y ; update hero's current ATK

    ldy #$0C ; offset for DEF

    lda $9A ; current DEF

    sta ($C3), y ; update hero's current DEF

    lda $A8 ; hero

    beq B04_9E96 ; if Midenhall, then done

    cmp #$02
    ldx #$00 ; Cannock's spell learning list offset

    bcc B04_9E8A ; if not Cannock, then Moonbrooke

    ldx #$10 ; Moonbrooke's spell learning list offset

B04_9E8A:
    jsr B04_9EAC ; update learned spell list

    sta $0618, y ; Cannock's learned battle spell list

    jsr B04_9EAC ; update learned spell list

    sta $061A, y ; Cannock's learned field spell list

B04_9E96:
    rts

; process high nybble of level up data
B04_9E97:
    lda LevelStatUps, x ; level up stat nybbles (STR/AGI, HP/MP)

    ror ; shift high nybble down to low nybble

    ror
    ror
    ror
; process low nybble of level up data
B04_9E9E:
    and #$0F
    sta $00A3, y ; stat gain for this level

    clc
    adc $0099, y
    sta $0099, y ; total stat amount

    iny ; set for next stat

    rts

; update learned spell list
B04_9EAC:
    lda $A9 ; current level

    ldy #$08 ; 8 spells per battle/field list

B04_9EB0:
    cmp SpellLevels, x ; levels for learning spells

    bne B04_9EB7
    dec $B3 ; update number of spells learned

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
B04_9EC3:
    pha
    lda #$10
    bne B04_9EF1 ; given an index for the structure list at $9F21/$9F33 in A and an index (on the stack) into the corresponding structure, set the corresponding index of $B5, x to the address of the thing you want

; given an index (in A) into the array of hero data structures at $062D, set $C3-$C4 to the address of the corresponding item inside that structure
B04_9EC8:
    pha
    lda #$0E
    bne B04_9EF1 ; given an index for the structure list at $9F21/$9F33 in A and an index (on the stack) into the corresponding structure, set the corresponding index of $B5, x to the address of the thing you want

; given an index (in A) into the array of structures at $068F, set $C1-$C2 to the address of the corresponding item inside that structure
B04_9ECD:
    pha
    lda #$0C
    bne B04_9EF1 ; given an index for the structure list at $9F21/$9F33 in A and an index (on the stack) into the corresponding structure, set the corresponding index of $B5, x to the address of the thing you want

; given an index (in A) into the array of structures at $0663, set $BF-$C0 to the address of the corresponding item inside that structure
B04_9ED2:
    pha
    lda #$0A
    bne B04_9EF1 ; given an index for the structure list at $9F21/$9F33 in A and an index (on the stack) into the corresponding structure, set the corresponding index of $B5, x to the address of the thing you want

; given an index (in A) into the array of enemy special % structures at $B2F6, set $BD-$BE to the address of the corresponding item inside that structure
B04_9ED7:
    pha
    lda #$08
    bne B04_9EF1 ; given an index for the structure list at $9F21/$9F33 in A and an index (on the stack) into the corresponding structure, set the corresponding index of $B5, x to the address of the thing you want

; given an index + 1 (in A) into the array of enemy stat structures at $B7F5, set $BB-$BC to the address of the corresponding item inside that structure
B04_9EDC:
    sec
    sbc #$01
    pha
    lda #$06
    bne B04_9EF1 ; given an index for the structure list at $9F21/$9F33 in A and an index (on the stack) into the corresponding structure, set the corresponding index of $B5, x to the address of the thing you want

; given an index (in A) into the array of hero data structures at $062D, set $B9-$BA to the address of the corresponding item inside that structure
B04_9EE4:
    pha
    lda #$04
    bne B04_9EF1 ; given an index for the structure list at $9F21/$9F33 in A and an index (on the stack) into the corresponding structure, set the corresponding index of $B5, x to the address of the thing you want

; given an index (in A) into the array of structures at $068F, set $B7-$B8 to the address of the corresponding item inside that structure
B04_9EE9:
    pha
    lda #$02
    bne B04_9EF1 ; given an index for the structure list at $9F21/$9F33 in A and an index (on the stack) into the corresponding structure, set the corresponding index of $B5, x to the address of the thing you want

; given an index (in A) into the array of structures at $0663, set $B5-$B6 to the address of the corresponding item inside that structure
B04_9EEE:
    pha
    lda #$00
; given an index for the structure list at $9F21/$9F33 in A and an index (on the stack) into the corresponding structure, set the corresponding index of $B5, x to the address of the thing you want
B04_9EF1:
    sta $99 ; index for $9F21/$9F33

    pla ; desired index into desired array

    pha ; desired index into desired array; save A

    sta $9B ; desired index into desired array

    txa ; save X

    pha
    ldx $99 ; index for $9F21/$9F33

    lda B04_9F33, x ; array record size low byte

    sta $99
    lda B04_9F33+1, x ; array record size high byte

    sta $9A
    jsr B04_A05B ; 16-bit multiplication: ($99-$9A) = ($99-$9A) * ($9B), overflow in $9E, copy of ($99-$9A) in ($A1-$9D)

; at this point, $99-$9A = record size * desired index into desired array = desired record's offset into the desired array
; next we'll add the desired array's base address
    lda B04_9F21, x ; base array address low byte

    sta $9B
    lda B04_9F21+1, x ; base array address high byte

    sta $9C
    jsr B04_A0CF ; 16-bit addition: ($99-$9A) = ($99-$9A) + ($9B-$9C)

; at this point, $99-$9A is the address of the thing we want to interact with, so save it to $B5, x-$B6-X for later use
    lda $99
    sta $B5, x
    lda $9A
    sta $B6, x
    pla ; restore X

    tax
    pla ; restore A

    rts


; base array address
B04_9F21:
.word $0663	 ; $0663; monster ID, group 1
.word $068F	 ; $068F
.word $062D	 ; $062D; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)
.word $B7F5	 ; $04:$B7F5; Enemy Stats (Max HP, [4-bit evade chance / 64, 4-bit unused], Max Gold dropped, EXP low byte, AGI, Attack Power, Defense Power, [2-bit attack probability list, 3-bit Sleep res., 3-bit spell damage res.], [2-bit EXP * 256, 3-bit Defeat res., 3-bit Stopspell res.], [2-bit EXP * 1024, 3-bit Defense res., 3-bit Surround res.], [4-bit Attack command 1, 4-bit Attack command 2], [4-bit Attack command 3, 4-bit Attack command 4], [4-bit Attack command 5, 4-bit Attack command 6], [4-bit Attack command 7, 4-bit Attack command 8], 8*1-bit use alternate attack command)
.word $B2F6	 ; $04:$B2F6; Attack % for Enemy Specials
.word $0663	 ; $0663; monster ID, group 1
.word $068F	 ; $068F
.word $062D	 ; $062D; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)
.word $A7C0	 ; $04:$A7C0; Battle Structs for Spells and Usable Items (target, power, cast string ID, hit string ID, miss string ID)
; array record size
B04_9F33:
.word $000B	 ; $0663 struct records are #$0B bytes long
.word $0007	 ; $068F struct records are #$07 bytes long
.word $0012	 ; $062D struct records are #$12 bytes long
.word $000F	 ; $B7F5 struct records are #$0F bytes long
.word $0007	 ; $B2F6 struct records are #$07 bytes long
.word $000B	 ; $0663 struct records are #$0B bytes long
.word $0007	 ; $068F struct records are #$07 bytes long
.word $0012	 ; $062D struct records are #$12 bytes long
.word $0005	 ; $A7C0 struct records are #$05 bytes long


B04_9F45:
    lsr $9C
    ror $9B
    jsr B04_A0E3 ; 16-bit subtraction: ($99-$9A) = ($99-$9A) - ($9B-$9C)

    bcc B04_9F67 ; generate a random number between $03 and #$02 in A and $99

    lda $99
    cmp #$02
    bcs B04_9F58
    lda $9A
    beq B04_9F67 ; generate a random number between $03 and #$02 in A and $99

B04_9F58:
    jsr B04_9FFB ; set $9B to a random number tightly distributed around #$80 and $9C to #$00

    jsr B04_A05B ; 16-bit multiplication: ($99-$9A) = ($99-$9A) * ($9B), overflow in $9E, copy of ($99-$9A) in ($A1-$9D)

B04_9F5E:
    lda $9D
    sta $99
    lda $9E
    sta $9A
    rts

; generate a random number between $03 and #$02 in A and $99
B04_9F67:
    lda #$02
    jmp B04_A020 ; generate a random number between $03 and A in A and $99

B04_9F6C:
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
    jsr B04_A0E3 ; 16-bit subtraction: ($99-$9A) = ($99-$9A) - ($9B-$9C)

    bcc B04_9FAD
    lda $C8
    cmp $9A
    bcc B04_9FC9
    bne B04_9F9B
    lda $C7
    cmp $99
    bcc B04_9FC9
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
B04_9FAD:
    lda #$02
B04_9FAF:
    jsr B04_A020 ; generate a random number between $03 and A in A and $99

    lda $99
    bne B04_9FC1
    lda #$00
    sta $99
    sta $9A
    rts

B04_9FBD:
    lda #$04
    bne B04_9FAF
B04_9FC1:
    lda $BD
    sta $99
    lda $BE
    sta $9A
B04_9FC9:
    jsr B04_9FFB ; set $9B to a random number tightly distributed around #$80 and $9C to #$00

    jsr B04_A05B ; 16-bit multiplication: ($99-$9A) = ($99-$9A) * ($9B), overflow in $9E, copy of ($99-$9A) in ($A1-$9D)

    jsr B04_9F5E
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

B04_9FEE:
    jmp B04_9F67 ; generate a random number between $03 and #$02 in A and $99
; set $9B to a random number tightly distributed around #$80 and $9C to #$00
    lda #$1F
    sta $9F
    lda #$08
    sta $9B
    bne B04_A003
; set $9B to a random number tightly distributed around #$80 and $9C to #$00
B04_9FFB:
    lda #$0F ; sum up random 4-bit numbers

    sta $9F
; WARNING! $9FFF was also seen as data
    lda #$88
    sta $9B
B04_A003:
    ldx #$10 ; 16 loops of summing random N-bit number

B04_A005:
    jsr B0F_C3AB ; generate a random number and store it in $32-$33 (two passes)

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
B04_A020:
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
B04_A038:
    dey
    beq B04_A044
    asl
    bcc B04_A038
B04_A03E:
    sec
    rol $9F
    dey
    bne B04_A03E
B04_A044:
    jsr B0F_C3AB ; generate a random number and store it in $32-$33 (two passes)

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
B04_A05A:
    rts

; 16-bit multiplication: ($99-$9A) = ($99-$9A) * ($9B), overflow in $9E, copy of ($99-$9A) in ($A1-$9D)
B04_A05B:
    lda #$00
    sta $9C
; 16-bit multiplication: ($99-$9A) = ($99-$9A) * ($9B-$9C), overflow in $9E, copy of ($99-$9A) in ($A1-$9D)
B04_A05F:
    lda #$00 ; initialize vars to #$00

    sta $9D ; result byte 1

    sta $9E ; result byte 2

    sta $A1 ; result byte 0

    sta $A2 ; multiplicand byte 2

    lda $9B ; original multiplicant byte 0

    sta $9F ; current multiplicand byte 0

    lda $9C ; original multiplicand byte 1

    sta $A0 ; current multiplicand byte 1

B04_A071:
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

B04_A090:
    asl $9F ; ASL 24-bit multiplicand

    rol $A0
    rol $A2
    jmp B04_A071 ; loop to process next bit


B04_A099:
    lda $A1 ; result byte 0

    sta $99
    lda $9D ; result byte 1

    sta $9A
    rts ; overflow is still sitting in $9E if anybody wants it


B04_A0A2:
    ldy #$10
    lda #$00
    sta $9D
    sta $9E
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
    jmp B04_A0CB

B04_A0C6:
    sta $9E
    pla
    sta $9D
B04_A0CB:
    dey
    bne B04_A0AA
    rts

; 16-bit addition: ($99-$9A) = ($99-$9A) + ($9B-$9C)
B04_A0CF:
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
B04_A0E3:
    lda $99
    sec
    sbc $9B
    sta $99
    lda $9A
    sbc $9C
    sta $9A
    rts

B04_A0F1:
    tya
    pha
    txa
    pha
    jsr B0F_C22C
    pla
    tax
    pla
    tay
    rts

B04_A0FD:
    sta $A7
    jsr B04_9EE4 ; given an index (in A) into the array of hero data structures at $062D, set $B9-$BA to the address of the corresponding item inside that structure

    jsr B04_A7B9
    lda $A7
    eor #$FF
    sta $AB
    ldy #$00
    lda ($B9), y
    asl
    bcs B04_A113
    rts

B04_A113:
    asl
    bcc B04_A132
    lda #$08
    jsr B04_A020 ; generate a random number between $03 and A in A and $99

    cmp #$04
    bcs B04_A12E
    ldy #$00
    lda ($B9), y
    and #$BF
    sta ($B9), y
    lda #$20
B04_A129:
    sta $AD
    jmp B04_9CDC

B04_A12E:
    lda #$1F
    bne B04_A129
B04_A132:
    ldy #$02
    lda ($B9), y
    sta $A8
    cmp #$20
    bcc B04_A192
    cmp #$3C
    beq B04_A145
    cmp #$80
    bcs B04_A14C
    rts

B04_A145:
    lda #$00
    sta $AD
    jmp B04_9CDC

B04_A14C:
    and #$7F
    sta $95 ; ID for [item] and [spell] control codes

    ldx #$07
B04_A152:
    cmp B04_A17C, x
    beq B04_A163
    dex
    bpl B04_A152
    lda #$7E
    sta $AD
    lda #$FE
    jmp B04_9CE5

B04_A163:
    lda #$FF
    sta $0176
    jsr B04_9AD6
    lda $A7
    sta $97 ; subject hero ID $97

    tax
    lda $06D2, x
    tax
    lda $95 ; ID for [item] and [spell] control codes

    jsr B0F_F746
    jmp B04_99E6


; code -> data
; indexed data load target (from $A152)
B04_A17C:
.byte $24,$26,$27,$36,$32,$2F,$30,$2E

B04_A184:
    lda #$3C
    bne B04_A18A
B04_A188:
    lda #$3B
B04_A18A:
    sta $95 ; ID for [item] and [spell] control codes

    jsr B04_A4F0
    jmp B04_A1E1

B04_A192:
    jsr B04_9EC3 ; given an index (in A) into the array of battle spell/item structures at $A7C0, set $C5-$C6 to the address of the corresponding item inside that structure

    ldy #$02 ; cast string ID

    lda ($C5), y
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
B04_A1B1:
    tax
    lda #$61 ; Item ID #$61: Mysterious Hat (equipped)

    jsr B04_A4E7 ; given a hero ID in $A7 and an item ID in A, SEC if hero has that item, CLC otherwise

    bcc B04_A1BE
    txa
    clc
    adc #$0F
    tax
B04_A1BE:
    lda B04_B4FA-1, x
    sta $A6
    ldy #$10
    lda ($B9), y
    sec
    sbc $A6
    bcs B04_A1D0
    lda #$11
    bne B04_A1DE
B04_A1D0:
    sta ($B9), y
    jsr B04_9AAC
    ldy #$00
    lda ($B9), y
    lsr
    bcc B04_A1E1
    lda #$12
B04_A1DE:
    jmp B04_9CE5

B04_A1E1:
    ldy #$00
    lda ($C5), y
    and #$07
    tax
    inx
    dex
    bne B04_A1EF
    jmp B04_A3D1

B04_A1EF:
    dex
    bne B04_A253
    lda $A8
    cmp #$15
    bne B04_A208
    lda #$FD
    sta $AE
    lda #$EF
    jsr B04_A129
    jsr B04_A7B9
    lda #$2D
    sta $AD
B04_A208:
    lda #$00
B04_A20A:
    ldy #$01
    sta ($B9), y
    pha
    jsr B04_A3D1
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
B04_A224:
    ldy #$01
    sty $9A
B04_A228:
    ldx $99
    jsr B04_8AF1
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
    jsr B04_9AE7
    lda #$FD
    sta $98 ; outcome of last fight?

B04_A252:
    rts

B04_A253:
    dex
    beq B04_A259
    jmp B04_A32F

B04_A259:
    lda $A8
    cmp #$17
    bne B04_A264
    lda #$39
    jsr B04_9CE5
B04_A264:
    lda #$49 ; Item ID #$49: Falcon Sword (equipped)

    jsr B04_A4E7 ; given a hero ID in $A7 and an item ID in A, SEC if hero has that item, CLC otherwise

    bcc B04_A26F
    lda $A8
    beq B04_A273
B04_A26F:
    lda #$00
    beq B04_A275
B04_A273:
    lda #$FF
B04_A275:
    sta $A3
    ldy #$01
    lda ($B9), y
    sta $AA
    jsr B04_9EEE ; given an index (in A) into the array of structures at $0663, set $B5-$B6 to the address of the corresponding item inside that structure

    ldy #$09
    lda ($B5), y
    bne B04_A287
    rts

B04_A287:
    jsr B04_A020 ; generate a random number between $03 and A in A and $99

    ldx $99
    inx
    stx $06DC
    lda #$04
    jsr B04_A020 ; generate a random number between $03 and A in A and $99

    beq B04_A2A2
    jsr B04_A2C2
    cmp #$08
    bcs B04_A2A2
    sta $A9
    bcc B04_A2B3
B04_A2A2:
    ldx $06DC
    ldy #$00
B04_A2A7:
    iny
    lda ($B5), y
    cmp #$08
    bcs B04_A2A7
    dex
    bne B04_A2A7
    sty $A9
B04_A2B3:
    jsr B04_A4F9
    lda $98 ; outcome of last fight?

    bne B04_A2C1
    jsr B04_A7B9
    lda $A3
    bne B04_A26F
B04_A2C1:
    rts

B04_A2C2:
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
B04_A2D5:
    tay
    ldx #$00
B04_A2D8:
    lda $06D5, x
    cmp $A9
    beq B04_A310
    inx
    cpx #$06
    bcc B04_A2D8
    lda ($B5), y
    cmp #$08
    bcs B04_A310
    jsr B04_9ECD ; given an index (in A) into the array of structures at $068F, set $C1-$C2 to the address of the corresponding item inside that structure

    ldy #$04
    lda ($C1), y
    sta $0C
    iny
    lda ($C1), y
    sta $0D
    cmp $A6
    bcc B04_A304
    bne B04_A310
    lda $0C
    cmp $A5
    bcs B04_A310
B04_A304:
    lda $0C
    sta $A5
    lda $0D
    sta $A6
    lda $A9
    sta $A4
B04_A310:
    inc $A9
    lda $A9
    and #$0F
    cmp #$09
    bcc B04_A2D5
    ldx $06DB
    lda $A4
    sta $06D5, x
    inx
    cpx #$06
    bcc B04_A329
    ldx #$00
B04_A329:
    stx $06DB
    and #$0F
    rts

B04_A32F:
    dex
    bne B04_A361
    lda $A8
    cmp #$18
    bne B04_A33C
    lda #$3B
    bne B04_A342
B04_A33C:
    cmp #$19
    bne B04_A345
    lda #$3D
B04_A342:
    jsr B04_9CE5
B04_A345:
    ldy #$01
    lda ($B9), y
    sta $AA
B04_A34B:
    lda #$01
    sta $A9
B04_A34F:
    jsr B04_A4F9
    lda $98 ; outcome of last fight?

    bne B04_A360
    inc $A9
    lda $A9
    and #$0F
    cmp #$09
    bcc B04_A34F
B04_A360:
    rts

B04_A361:
    dex
    bne B04_A399
    lda $A8
    cmp #$1A
    bne B04_A36F
    lda #$3F
    jsr B04_9CE5
B04_A36F:
    lda #$00
    sta $AA
B04_A373:
    jsr B04_A34B
    lda $98 ; outcome of last fight?

    bne B04_A382
    inc $AA
    lda $AA
    cmp #$04
    bcc B04_A373
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

B04_A394:
    lda #$27
    jmp B04_AF55

B04_A399:
    dex
    bne B04_A3A9
    lda $B3
    ora #$80
    sta $B3
    lda #$16
    sta $B2
    jmp B04_9AE7

B04_A3A9:
    ldy #$01
    lda ($B9), y
    eor #$FF
    sta $AE
    eor #$FF
    jsr B04_9EC8 ; given an index (in A) into the array of hero data structures at $062D, set $C3-$C4 to the address of the corresponding item inside that structure

    ldy #$00
    lda #$84
    sta ($C3), y
    jsr B04_A450 ; set hero current HP to max HP

    ldy #$05
    lda ($C3), y
    ldy #$10
    sta ($C3), y
    ldy #$0C
    lda ($C3), y
    iny
    sta ($C3), y
    jmp B04_A449

B04_A3D1:
    ldy #$01
    lda ($B9), y
    jsr B04_9EC8 ; given an index (in A) into the array of hero data structures at $062D, set $C3-$C4 to the address of the corresponding item inside that structure

    ldy #$00
    lda ($C3), y
    bmi B04_A3DF
    rts

B04_A3DF:
    ldy #$01
    lda ($B9), y
    eor #$FF
    sta $AE
    jsr B04_A76A
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
B04_A402:
    jsr B04_9EC8 ; given an index (in A) into the array of hero data structures at $062D, set $C3-$C4 to the address of the corresponding item inside that structure

    txa
    cmp #$FF
    bne B04_A412
    lda #$F0 ; X == #$FF => heal 61,680 HP

    sta $B0
    sta $B1
    bne B04_A415
B04_A412:
    jsr B04_AE8C ; $B0 = random number tightly distributed around A / 2, $B1 = #$00

B04_A415:
    ldy #$0E ; hero current HP, low byte

    lda ($C3), y
    clc
    adc $B0 ; HP to restore, low byte

    sta ($C3), y
    sta $99 ; new current HP, low byte

    ldy #$0F ; hero current HP, high byte

    lda ($C3), y
    adc $B1 ; HP to restore, high byte

    sta ($C3), y
    sta $9A ; new current HP, high byte

    ldy #$04 ; hero max HP, high byte

    lda ($C3), y
    cmp $9A ; new current HP, high byte

    bcc B04_A43C
    bne B04_A43F ; if high bytes are the same, compare low bytes, otherwise done

    ldy #$03 ; hero max HP, low byte

    lda ($C3), y
    cmp $99 ; new current HP, low byte

    bcs B04_A43F ; if max >= current, then done

B04_A43C:
    jsr B04_A450 ; set hero current HP to max HP

B04_A43F:
    rts

B04_A440:
    jmp B04_A493

B04_A443:
    jmp B04_A4C6

B04_A446:
    jsr B04_A415
B04_A449:
    ldy #$03
B04_A44B:
    lda ($C5), y
    jmp B04_9CE5

; set hero current HP to max HP
B04_A450:
    ldy #$03 ; hero max HP, low byte

    lda ($C3), y
    ldy #$0E ; hero current HP, low byte

    sta ($C3), y
    ldy #$04 ; hero max HP, high byte

    lda ($C3), y
    ldy #$0F ; hero current HP, high byte

    sta ($C3), y
    rts

B04_A461:
    ldy #$0D
    lda ($C3), y
    sta $9D
    clc
    adc $B0
    bcc B04_A46E
    lda #$FF
B04_A46E:
    sta $9A
    ldy #$0C
    lda ($C3), y
    sta $99
    jsr B04_A4DA
    lda $99
    cmp $9A
    bcs B04_A481
    sta $9A
B04_A481:
    lda $9A
    ldy #$0D
    sta ($C3), y
    sec
    sbc $9D
    sta $B0
    lda #$00
    sta $B1
    jmp B04_A449

B04_A493:
    ldy #$00
    lda ($C3), y
    and #$DF
    sta ($C3), y
    jmp B04_A449

; restore the hero ID in A's MP by a random amount based on the Wizard's Ring's power; returns a random number between $03 and #$0A in A and $99
B04_A49E:
    jsr B04_9EE4 ; given an index (in A) into the array of hero data structures at $062D, set $B9-$BA to the address of the corresponding item inside that structure
    lda #$2C ; power for Item ID #$3D: Wizard's Ring
    jsr B04_AE8C ; $B0 = random number tightly distributed around A / 2, $B1 = #$00

; restore the current hero's MP by the amount in $B0; returns a random number between $03 and #$0A in A and $99
B04_A4A6:
    ldy #$10
    lda ($B9), y ; Current MP
    clc
    adc $B0 ; MP gain from Wizard's Ring
    bcc B04_A4B1 ; cap new current MP at #$FF
    lda #$FF
B04_A4B1:
    sta ($B9), y ; Current MP
    sta $99 ; Current MP
    ldy #$05
    lda ($B9), y ; Max MP
    cmp $99 ; Current MP
    bcs B04_A4C1 ; cap new current MP at Max MP
    ldy #$10
    sta ($B9), y ; Current MP

B04_A4C1:
    lda #$0A
    jmp B04_A020 ; generate a random number between $03 and A in A and $99


B04_A4C6:
    jsr B04_A4A6 ; restore the current hero's MP by the amount in $B0; returns a random number between $03 and #$0A in A and $99

    bne B04_A4D3
    jsr B04_A4F0
    ldy #$04
    jmp B04_A44B

B04_A4D3:
    lda #$A1
    sta $AD
    jmp B04_9CDC

B04_A4DA:
    lda $99
    lsr
    clc
    adc $99
    bcc B04_A4E4
    lda #$FF
B04_A4E4:
    sta $99
    rts

; given a hero ID in $A7 and an item ID in A, SEC if hero has that item, CLC otherwise
B04_A4E7:
    pha
    lda $A7
    sta $9C
    pla
    jmp B0F_C4B0 ; given a hero ID in $9C and an item ID in A, SEC if hero has that item, CLC otherwise

B04_A4F0:
    lda $A7
    tay
    ldx $06D2, y
    jmp B0F_C4D4 ; given hero ID in A and hero inventory offset in X, remove that item from hero's inventory and move all lower items up 1 slot

B04_A4F9:
    lda $AA
    jsr B04_9EEE ; given an index (in A) into the array of structures at $0663, set $B5-$B6 to the address of the corresponding item inside that structure

    lda $AA
    asl
    asl
    asl
    asl
    ldy $A9
    ora $A9
    sta $AF
    lda ($B5), y
    cmp #$08
    bcc B04_A511
    rts

B04_A511:
    jsr B04_9EE9 ; given an index (in A) into the array of structures at $068F, set $B7-$B8 to the address of the corresponding item inside that structure

    ldy #$00
    lda ($B5), y
    sta $AE
    jsr B04_9EDC ; given an index + 1 (in A) into the array of enemy stat structures at $B7F5, set $BB-$BC to the address of the corresponding item inside that structure

    jsr B04_A78F
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
    jsr B04_A74A
    bcc B04_A560
    lda $B0
    bne B04_A55D
    lda #$01
    sta $B0
B04_A55D:
    jmp B04_A692

B04_A560:
    ldy #$04
B04_A562:
    lda ($C5), y
    jmp B04_9CE5

B04_A567:
    jmp B04_A5E3

B04_A56A:
    lda $AE
    cmp #$4E
    bcs B04_A560
    bcc B04_A579
B04_A572:
    lda #$03
    jsr B04_A74A
    bcc B04_A560
B04_A579:
    ldy #$03
    lda ($C5), y
    jmp B04_A6C2

B04_A580:
    lda #$80
    sta $A1
    lda #$01
    bne B04_A596
B04_A588:
    lda #$40
    sta $A1
    lda #$02
    bne B04_A596
B04_A590:
    lda #$01
    sta $A1
    lda #$04
B04_A596:
    jsr B04_A74A
    ldy #$00
    lda ($B7), y
    and $A1
    bne B04_A5AD
    bcc B04_A560
    lda ($B7), y
    ora $A1
    sta ($B7), y
B04_A5A9:
    ldy #$03
    bne B04_A562
B04_A5AD:
    rts

B04_A5AE:
    lda #$05
    jsr B04_A74A
    bcc B04_A560
    ldy #$06
    lda ($B7), y
    sta $9A
    sec
    sbc $B0
    bcs B04_A5C2
    lda #$00
B04_A5C2:
    sta $99
    ldy #$06
    lda ($BB), y
    lsr
    cmp $99
    bcs B04_A5CF
    lda $99
B04_A5CF:
    ldy #$06
    sta ($B7), y
    sta $99
    lda $9A
    sec
    sbc $99
    sta $B0
    lda #$00
    sta $B1
    jmp B04_A5A9

B04_A5E3:
    lda #$08
    sta $A6
    lda #$4C ; Item ID #$4C: Sword of Destruction (equipped)

    jsr B04_A4E7 ; given a hero ID in $A7 and an item ID in A, SEC if hero has that item, CLC otherwise

    bcs B04_A600
    lda #$40
    sta $A6
    lda #$57 ; Item ID #$57: Gremlin’s Armor (equipped)

    jsr B04_A4E7 ; given a hero ID in $A7 and an item ID in A, SEC if hero has that item, CLC otherwise

    bcs B04_A600
    lda #$5F ; Item ID #$5F: Evil Shield (equipped)

    jsr B04_A4E7 ; given a hero ID in $A7 and an item ID in A, SEC if hero has that item, CLC otherwise

    bcc B04_A607
B04_A600:
    lda #$04
    jsr B04_A020 ; generate a random number between $03 and A in A and $99

    beq B04_A679
B04_A607:
    lda $A6
    jsr B04_A020 ; generate a random number between $03 and A in A and $99

    bne B04_A624
    lda $0161 ; current monster ID

    cmp #$52
    beq B04_A624
    ldy #$0B
    lda ($B9), y
    jsr B04_A7A1
    lda #$0D ; String ID #$000D: A tremendous blow![end-FC]

    jsr B04_9ADE ; STA $B4, $B3 |= #$20

    jmp B04_A686

B04_A624:
    ldy #$0B
    lda ($B9), y
    sta $99
    ldy #$06
    lda ($B7), y
    sta $9B
    lda #$00
    sta $9A
    sta $9C
    jsr B04_9F45
    lda $99
    sta $B0
    lda $9A
    sta $B1
    ldy #$00
    lda ($B9), y
    and #$02
    beq B04_A656
    lda #$04
    jsr B04_A020 ; generate a random number between $03 and A in A and $99

    bne B04_A656
    lda #$00
    sta $B0
    sta $B1
B04_A656:
    ldy #$00
    lda ($B7), y
    bmi B04_A676
    ldy #$01
    lda ($BB), y
    lsr
    lsr
    lsr
    lsr
    sta $A6
    lda #$40
    jsr B04_A020 ; generate a random number between $03 and A in A and $99

    lda $99
    cmp $A6
    bcs B04_A676
    lda #$0A ; String ID #$000A: [name] dodged the blow.[end-FC]

    jmp B04_9CE5

B04_A676:
    jmp B04_A686

B04_A679:
    lda #$42 ; String ID #$0042: No movement was possible, for the curse had frozen [name]'s body.[end-FC]

    sta $B2
    lda $A7
    eor #$FF
    sta $AE
    jmp B04_9AE7

B04_A686:
    ldy #$01
    lda ($B7), y
    cmp #$04
    bne B04_A692
    lsr $B1
    ror $B0
B04_A692:
    lda $B0
    ora $B1
    bne B04_A6A2
    lda #$07 ; String ID #$0007: But missed![end-FC]

    jsr B04_9ADE ; STA $B4, $B3 |= #$20

    ldy #$04
    jmp B04_A44B

B04_A6A2:
    jsr B04_A449
    ldy #$04
    lda ($B7), y
    sec
    sbc $B0
    sta ($B7), y
    sta $99
    iny
    lda ($B7), y
    sbc $B1
    sta ($B7), y
    bcc B04_A6C0
    bne B04_A6BF
    lda $99
    beq B04_A6C0
B04_A6BF:
    rts

B04_A6C0:
    lda #$19
B04_A6C2:
    sta $B2
    ldy $A9
    lda ($B5), y
    ora #$08
    sta ($B5), y
    and #$07
    jsr B04_9EE9 ; given an index (in A) into the array of structures at $068F, set $B7-$B8 to the address of the corresponding item inside that structure

    lda #$FF
    ldy #$03
    sta ($B7), y
    ldy #$09
    lda ($B5), y
    tax
    dex
    txa
    sta ($B5), y
    ldy #$00
    lda ($B5), y
    sta $0161 ; current monster ID

    jsr B04_9EDC ; given an index + 1 (in A) into the array of enemy stat structures at $B7F5, set $BB-$BC to the address of the corresponding item inside that structure

    ldx $A7
    cpx #$77
    beq B04_A73E
    ldy #$09
    lda ($BB), y
    rol
    rol
    rol
    and #$03
    sta $99
    dey
    lda ($BB), y
    rol
    rol $99
    rol
    rol $99
    ldy #$03
    lda ($BB), y
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

B04_A721:
    ldy #$02
    lda ($BB), y
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
B04_A73E:
    jsr B04_9A84
    bne B04_A747
    lda #$FE
    sta $98 ; outcome of last fight?

B04_A747:
    jmp B04_9AE7

B04_A74A:
    stx $A5
    lsr
    php
    clc
    adc #$07
    tay
    lda ($BB), y
    plp
    bcc B04_A75A
    lsr
    lsr
    lsr
B04_A75A:
    and #$07
    sta $9B
    lda #$07
    jsr B04_A020 ; generate a random number between $03 and A in A and $99

    lda $99
    cmp $9B
    ldx $A5
    rts

B04_A76A:
    ldy #$01
    lda ($C5), y
    cmp #$01
    beq B04_A774
    bcs B04_A784
B04_A774:
    php
    ldy #$0C
    lda ($C3), y
B04_A779:
    lsr
    plp
    bcs B04_A77E
    lsr ; Increase and Decrease effect

B04_A77E:
    clc
    adc #$01
B04_A781:
    jmp B04_AE8C ; $B0 = random number tightly distributed around A / 2, $B1 = #$00


B04_A784:
    cmp #$FF
    bne B04_A781
    sta $B0
    lda #$F0
    sta $B1
    rts

B04_A78F:
    ldy #$01
    lda ($C5), y
    cmp #$01
    beq B04_A799
    bcs B04_A784
B04_A799:
    php
    ldy #$06
    lda ($BB), y
    jmp B04_A779

B04_A7A1:
    sta $99
    lsr
    sta $A6
    lda $99
    jsr B04_AE8C ; $B0 = random number tightly distributed around A / 2, $B1 = #$00

    lda $A6
    clc
    adc $B0
    sta $B0
    lda $B1
    adc #$00
    sta $B1
    rts

B04_A7B9:
    lda $B3
    and #$8F
    sta $B3
    rts


; Battle Structs for Spells and Usable Items (target, power, cast string ID, hit string ID, miss string ID)
; "Spell" ID #$00: Fight
; Spells
.byte $02,$02
.byte         $06	 ; String ID #$0006: [name] attacked![end-FC]
.byte             $0B	 ; String ID #$000B: [name]'s HP is reduced by [number].[end-FC]
.byte                 $08	 ; String ID #$0008: [name] was wounded.[end-FC]
; Spell ID #$01: Firebal
.byte $02,$28
.byte         $E1	 ; String ID #$001A: [name] chanted the spell of [spell].[end-FC]
.byte             $0B	 ; String ID #$000B: [name]'s HP is reduced by [number].[end-FC]
.byte                 $18	 ; String ID #$0018: But the spell had no effect on [name].[end-FC]
; Spell ID #$02: Sleep
.byte $03,$02
.byte         $E2	 ; String ID #$001A: [name] chanted the spell of [spell].[end-FC]
.byte             $1C	 ; String ID #$001C: [name] fell asleep.[end-FC]
.byte                 $1D	 ; String ID #$001D: [name] did not fall asleep.[end-FC]
; Spell ID #$03: Firebane
.byte $04,$32
.byte         $E3	 ; String ID #$001A: [name] chanted the spell of [spell].[end-FC]
.byte             $0B	 ; String ID #$000B: [name]'s HP is reduced by [number].[end-FC]
.byte                 $18	 ; String ID #$0018: But the spell had no effect on [name].[end-FC]
; Spell ID #$04: Defeat
.byte $03,$02
.byte         $E4	 ; String ID #$001A: [name] chanted the spell of [spell].[end-FC]
.byte             $24	 ; String ID #$0024: Thou hast defeated [name].[end-FC]
.byte                 $18	 ; String ID #$0018: But the spell had no effect on [name].[end-FC]
; Spell ID #$05: Infernos
.byte $03,$32
.byte         $E5	 ; String ID #$001A: [name] chanted the spell of [spell].[end-FC]
.byte             $0B	 ; String ID #$000B: [name]'s HP is reduced by [number].[end-FC]
.byte                 $18	 ; String ID #$0018: But the spell had no effect on [name].[end-FC]
; Spell ID #$06: Stopspell
.byte $03,$02
.byte         $E6	 ; String ID #$001A: [name] chanted the spell of [spell].[end-FC]
.byte             $29	 ; String ID #$0029: And [name]'s spell was blocked.[end-FC]
.byte                 $18	 ; String ID #$0018: But the spell had no effect on [name].[end-FC]
; Spell ID #$07: Surround
.byte $03,$02
.byte         $E7	 ; String ID #$001A: [name] chanted the spell of [spell].[end-FC]
.byte             $2B	 ; String ID #$002B: And [name] was surrounded by the Phantom Force.[end-FC]
.byte                 $18	 ; String ID #$0018: But the spell had no effect on [name].[end-FC]
; Spell ID #$08: Defence
.byte $04,$00
.byte         $E8	 ; String ID #$001A: [name] chanted the spell of [spell].[end-FC]
.byte             $21	 ; String ID #$0021: [name]'s Defense Power decreased by [number].[end-FC]
.byte                 $18	 ; String ID #$0018: But the spell had no effect on [name].[end-FC]
; Spell ID #$09: Heal
.byte $00,$40
.byte         $E9	 ; String ID #$001A: [name] chanted the spell of [spell].[end-FC]
.byte             $17	 ; String ID #$0017: [name]'s wounds were healed.[end-FC]
.byte                 $00	 ; (impossible outcome; no string for this)
; Spell ID #$0A: Increase
.byte $01,$00
.byte         $EA	 ; String ID #$001A: [name] chanted the spell of [spell].[end-FC]
.byte             $23	 ; String ID #$0023: [name]'s Defense Power increased by [number].[end-FC]
.byte                 $00	 ; (impossible outcome; no string for this)
; Spell ID #$0B: Healmore
.byte $00,$80
.byte         $EB	 ; String ID #$001A: [name] chanted the spell of [spell].[end-FC]
.byte             $17	 ; String ID #$0017: [name]'s wounds were healed.[end-FC]
.byte                 $00	 ; (impossible outcome; no string for this)
; Spell ID #$0C: Sacrifice
.byte $04,$02
.byte         $EC	 ; String ID #$001A: [name] chanted the spell of [spell].[end-FC]
.byte             $26	 ; String ID #$0026: [name] was utterly defeated.[end-FC]
.byte                 $18	 ; String ID #$0018: But the spell had no effect on [name].[end-FC]
; Spell ID #$0D: Healall
.byte $00,$FF
.byte         $ED	 ; String ID #$001A: [name] chanted the spell of [spell].[end-FC]
.byte             $17	 ; String ID #$0017: [name]'s wounds were healed.[end-FC]
.byte                 $00	 ; (impossible outcome; no string for this)
; Spell ID #$0E: Explodet
.byte $04,$82
.byte         $EE	 ; String ID #$001A: [name] chanted the spell of [spell].[end-FC]
.byte             $0B	 ; String ID #$000B: [name]'s HP is reduced by [number].[end-FC]
.byte                 $18	 ; String ID #$0018: But the spell had no effect on [name].[end-FC]

; Chance spell effects
; Spell ID #$0F: Chance; Effect #$01: Confuse
.byte $05,$00
.byte         $EF	 ; String ID #$001A: [name] chanted the spell of [spell].[end-FC]
.byte             $16	 ; String ID #$0016: The enemies was confused.[end-FC]
.byte                 $00	 ; (impossible outcome; no string for this)
; Spell ID #$0F: Chance; Effect #$02: Heal
.byte $01,$40
.byte         $EF	 ; String ID #$001A: [name] chanted the spell of [spell].[end-FC]
.byte             $17	 ; String ID #$0017: [name]'s wounds were healed.[end-FC]
.byte                 $00	 ; (impossible outcome; no string for this)
; Spell ID #$0F: Chance; Effect #$03: Defeat
.byte $04,$02
.byte         $EF	 ; String ID #$001A: [name] chanted the spell of [spell].[end-FC]
.byte             $24	 ; String ID #$0024: Thou hast defeated [name].[end-FC]
.byte                 $18	 ; String ID #$0018: But the spell had no effect on [name].[end-FC]
; Spell ID #$0F: Chance; Effect #$04: Sleep
.byte $04,$02
.byte         $EF	 ; String ID #$001A: [name] chanted the spell of [spell].[end-FC]
.byte             $1C	 ; String ID #$001C: [name] fell asleep.[end-FC]
.byte                 $1D	 ; String ID #$001D: [name] did not fall asleep.[end-FC]
; Spell ID #$0F: Chance; Effect #$05: Defense
.byte $04,$01
.byte         $EF	 ; String ID #$001A: [name] chanted the spell of [spell].[end-FC]
.byte             $21	 ; String ID #$0021: [name]'s Defense Power decreased by [number].[end-FC]
.byte                 $18	 ; String ID #$0018: But the spell had no effect on [name].[end-FC]
; Spell ID #$0F: Chance; Effect #$06: Increase
.byte $01,$01
.byte         $EF	 ; String ID #$001A: [name] chanted the spell of [spell].[end-FC]
.byte             $23	 ; String ID #$0023: [name]'s Defense Power increased by [number].[end-FC]
.byte                 $00	 ; (impossible outcome; no string for this)
; Spell ID #$0F: Chance; Effect #$07: Sorceror
.byte $01,$02
.byte         $EF	 ; String ID #$001A: [name] chanted the spell of [spell].[end-FC]
.byte             $2E	 ; String ID #$002E: [name] fainted when the Sorcerer appeared.[end-FC]
.byte                 $00	 ; (impossible outcome; no string for this)
; Spell ID #$0F: Chance; Effect #$08: Revive Max
.byte $06,$02
.byte         $EF	 ; String ID #$001A: [name] chanted the spell of [spell].[end-FC]
.byte             $2C	 ; String ID #$002C: Then [name] was brought back to life![end-FC]
.byte                 $00	 ; (impossible outcome; no string for this)

; Item ID #$03: Wizard’s Wand
; Usable Items
.byte $02,$18
.byte         $38	 ; String ID #$0038: [name] raised the Wizard's Wand overhead.[end-FC]
.byte             $0B	 ; String ID #$000B: [name]'s HP is reduced by [number].[end-FC]
.byte                 $40	 ; String ID #$0040: It did not work against [name].[end-FC]
; Item ID #$04: Staff of Thunder
.byte $03,$32
.byte         $3A	 ; String ID #$003A: [name] raised the Staff of Thunder overhead.[end-FC]
.byte             $0B	 ; String ID #$000B: [name]'s HP is reduced by [number].[end-FC]
.byte                 $40	 ; String ID #$0040: It did not work against [name].[end-FC]
; Item ID #$10: Thunder Sword
.byte $03,$37
.byte         $3C	 ; String ID #$003C: [name] raised the Thunder Sword overhead.[end-FC]
.byte             $0B	 ; String ID #$000B: [name]'s HP is reduced by [number].[end-FC]
.byte                 $40	 ; String ID #$0040: It did not work against [name].[end-FC]
; Item ID #$0E: Light Sword
.byte $04,$02
.byte         $3E	 ; String ID #$003E: [name] raised the Light Sword overhead.[end-FC]
.byte             $2B	 ; String ID #$002B: And [name] was surrounded by the Phantom Force.[end-FC]
.byte                 $40	 ; String ID #$0040: It did not work against [name].[end-FC]
; Item ID #$1D: Shield of Strength
.byte $00,$80
.byte         $41	 ; String ID #$0041: [name] raised the Shield of Strength toward the heavens.[end-FC]
.byte             $17	 ; String ID #$0017: [name]'s wounds were healed.[end-FC]
.byte                 $00	 ; (impossible outcome; no string for this)
; Item ID #$3C: Medical Herb
.byte $00,$64
.byte         $7E	 ; String ID #$011E: [name] used the [item].[end-FC]
.byte             $17	 ; String ID #$0017: [name]'s wounds were healed.[end-FC]
.byte                 $00	 ; (impossible outcome; no string for this)
; Item ID #$3B: Antidote Herb
.byte $00,$02
.byte         $7E	 ; String ID #$011E: [name] used the [item].[end-FC]
.byte             $43	 ; String ID #$0043: The poison was drawn out of [name]'s wound.[end-FC]
.byte                 $00	 ; (impossible outcome; no string for this)
; Item ID #$3D: Wizard’s Ring
.byte $00,$2C
.byte         $A1	 ; String ID #$0141: [name] slipped on the Wizard's Ring and spoke a word of magic.[end-FC]
.byte             $00	 ; (impossible outcome; no string for this)
.byte                 $A2	 ; String ID #$0142: [wait]The ring crumbled like clay into dust, losing all its power.[end-FC]

B04_A85B:
    sta $A7
    sta $AE
    jsr B04_B1DC
    lda $AF
    cmp #$04
    bcc B04_A869
    rts

B04_A869:
    ldy #$07
    lda ($BB), y
    rol
    rol
    rol
    and #$03
    sta $06EB
    cmp #$03
    bne B04_A87E
    lda $A7
    jsr B04_B052
B04_A87E:
    jsr B04_A7B9
    ldy #$03
B04_A883:
    lda ($B7), y
    sta $06E0, y
    dey
    bne B04_A883
    ldy #$00
    lda ($B7), y
    sta $06E7
    lda $06E3
    ldy #$00
    lda ($B5), y
    sta $AB
    lda $06E3
    asl
    asl
    asl
    asl
    ora $06E2
    sta $AC
    ldy #$05
    lda ($BB), y
    sta $06EA
    lda $06E7
    bpl B04_A8D2
    lda #$08
    jsr B04_A020 ; generate a random number between $03 and A in A and $99

    lda $06EB
    cmp $99
    bcc B04_A8CE
    ldy #$00
    lda ($B7), y
    and #$7F
    sta ($B7), y
    lda #$20
B04_A8C9:
    sta $AD
    jmp B04_9CDC

B04_A8CE:
    lda #$1F
    bne B04_A8C9
B04_A8D2:
    lda $B3
    bpl B04_A935
    lda #$03
    jsr B04_A020 ; generate a random number between $03 and A in A and $99

    bne B04_A935
    lda #$09
    sta $0D
    jsr B04_A95C
    lda $0D
    cmp #$09
    beq B04_A935
    lda #$09
    sec
    sbc $0D
    jsr B04_A020 ; generate a random number between $03 and A in A and $99

    sta $0D
    inc $0D
    jsr B04_A95C
    ldy #$03
    lda ($B7), y
    jsr B04_9EEE ; given an index (in A) into the array of structures at $0663, set $B5-$B6 to the address of the corresponding item inside that structure

    ldy #$00
    lda ($B5), y
    sta $AE
    ldy #$03
    lda ($B7), y
    asl
    asl
    asl
    asl
    ldy #$02 ; Sleep?

    ora ($B7), y
    sta $AF
    and #$0F
    sta $A9
    ldy #$06 ; Stopspell?

    lda ($B7), y
    sta $9B
    jsr B04_B023
    lda #$06
    sta $AD
    lda #$0B
    sta $B2
    lda #$77
    sta $A7
    lda #$00
    jsr B04_9EC3 ; given an index (in A) into the array of battle spell/item structures at $A7C0, set $C5-$C6 to the address of the corresponding item inside that structure

    jmp B04_A686

B04_A935:
    jsr B04_B222
    sta $A8
    ldy #$0A
    lda ($B5), y
    cmp #$03
    bcs B04_A944
    sta $A8
B04_A944:
    lda $06E1
    cmp #$20
    bcc B04_A94D
    lda #$00
B04_A94D:
    asl
    tax
    lda AttackHandlers, x ; pointers to monster attack handlers

    sta $C7
    lda AttackHandlers+1, x
    sta $C8
    jmp ($00C7)

B04_A95C:
    lda #$00
    sta $0C
B04_A960:
    cmp $A7
    beq B04_A973
    jsr B04_9EE9 ; given an index (in A) into the array of structures at $068F, set $B7-$B8 to the address of the corresponding item inside that structure

    ldy #$03
    lda ($B7), y
    cmp #$04
    bcs B04_A973
    dec $0D
    beq B04_A97B
B04_A973:
    inc $0C
    lda $0C
    cmp #$08
    bcc B04_A960
B04_A97B:
    rts


; pointers to monster attack handlers
AttackHandlers:
.addr B04_A9BC      ; $04:$A9BC; handler for Attack IDs #$00/#$1E: Attack / Concentrated Attack
.addr B04_AA11      ; $04:$AA11; handler for Attack ID #$01: Heroic Attack
.addr B04_AA28      ; $04:$AA28; handler for Attack ID #$02: Poison Attack
.addr B04_AA3A      ; $04:$AA3A; handler for Attack ID #$03: Faint Attack
.addr B04_AA4A      ; $04:$AA4A; handler for Attack ID #$04: Parry
.addr B04_AA51      ; $04:$AA51; handler for Attack ID #$05: Run Away
.addr B04_AA78      ; $04:$AA78; handler for Attack ID #$06: Firebal
.addr B04_AA87      ; $04:$AA87; handler for Attack ID #$07: Firebane
.addr B04_AA91      ; $04:$AA91; handler for Attack ID #$08: Explodet
.addr B04_AAB5      ; $04:$AAB5; handler for Attack ID #$09: Heal-1
.addr B04_AAC0      ; $04:$AAC0; handler for Attack ID #$0A: Healmore-1
.addr B04_AAD3      ; $04:$AAD3; handler for Attack ID #$0B: Healall-1
.addr B04_AAE3      ; $04:$AAE3; handler for Attack ID #$0C: Heal-2
.addr B04_AAED      ; $04:$AAED; handler for Attack ID #$0D: Healmore-2
.addr B04_AB03      ; $04:$AB03; handler for Attack ID #$0E: Healall-2
.addr B04_ABC7      ; $04:$ABC7; handler for Attack ID #$0F: Revive
.addr B04_ABE5      ; $04:$ABE5; handler for Attack ID #$10: Defence
.addr B04_ABEA      ; $04:$ABEA; handler for Attack ID #$11: Increase
.addr B04_AC57      ; $04:$AC57; handler for Attack ID #$12: Sleep
.addr B04_AC5C      ; $04:$AC5C; handler for Attack ID #$13: Stopspell
.addr B04_AC61      ; $04:$AC61; handler for Attack ID #$14: Surround
.addr B04_AC66      ; $04:$AC66; handler for Attack ID #$15: Defeat
.addr B04_AC6B      ; $04:$AC6B; handler for Attack ID #$16: Sacrifice
.addr B04_AC70      ; $04:$AC70; handler for Attack IDs #$17-#$19: Weak, Strong, Deadly Flames
.addr B04_AC70      ; $04:$AC70; handler for Attack IDs #$17-#$19: Weak, Strong, Deadly Flames
.addr B04_AC70      ; $04:$AC70; handler for Attack IDs #$17-#$19: Weak, Strong, Deadly Flames
.addr B04_AC75      ; $04:$AC75; handler for Attack ID #$1A: Poison Breath
.addr B04_AC7A      ; $04:$AC7A; handler for Attack ID #$1B: Sweet Breath
.addr B04_ADAE      ; $04:$ADAE; handler for Attack ID #$1C: Call For Help
.addr B04_AE15      ; $04:$AE15; handler for Attack ID #$1D: Two Attacks
.addr B04_A9BC      ; $04:$A9BC; handler for Attack IDs #$00/#$1E: Attack / Concentrated Attack
.addr B04_AE1E      ; $04:$AE1E; handler for Attack ID #$1F: Strange Jig

; handler for Attack IDs #$00/#$1E: Attack / Concentrated Attack
B04_A9BC:
    lda #$FF
    sta $C5
B04_A9C0:
    jsr B04_B00F
B04_A9C3:
    lda #$06 ; String ID #$0006: [name] attacked![end-FC]

    sta $AD
    lda $A8
    jsr B04_9EE4 ; given an index (in A) into the array of hero data structures at $062D, set $B9-$BA to the address of the corresponding item inside that structure

    ldy #$00
    lda ($B9), y
    bmi B04_A9D3
    rts

B04_A9D3:
    and #$40
    bne B04_A9FF
    lda #$40
    jsr B04_A020 ; generate a random number between $03 and A in A and $99

    beq B04_A9EE
    lda $A8
    sta $9C
    lda #$52 ; Item ID #$52: Clothes Hiding (equipped)

    jsr B0F_C4B0 ; given a hero ID in $9C and an item ID in A, SEC if hero has that item, CLC otherwise

    bcc B04_A9FF
    jsr B04_B007
    bcs B04_A9FF
B04_A9EE:
    lda $B3
    and #$DF
    sta $B3
    lda $A8
    eor #$FF
    sta $AE
    lda #$0A ; String ID #$000A: [name] dodged the blow.[end-FC]

    jmp B04_9CE5

B04_A9FF:
    ldy #$00
    lda ($B9), y
    and $C5
    bne B04_AA0E
    lda $C6
    sta $B2
    jmp B04_AEA5

B04_AA0E:
    jmp B04_AEA1

; handler for Attack ID #$01: Heroic Attack
B04_AA11:
    jsr B04_B007
B04_AA14:
    bcs B04_A9BC ; handler for Attack IDs #$00/#$1E: Attack / Concentrated Attack

    lda #$FF
    sta $C5
    lda $06EA
    jsr B04_A7A1
    lda #$0E ; String ID #$000E: A heroic attack![end-FC]

    jsr B04_9ADE ; STA $B4, $B3 |= #$20

    jmp B04_A9C3

; handler for Attack ID #$02: Poison Attack
B04_AA28:
    lda #$04 ; 1/4 Chance of Poison Attack Succeeding

    jsr B04_A020 ; generate a random number between $03 and A in A and $99

    bne B04_A9BC ; handler for Attack IDs #$00/#$1E: Attack / Concentrated Attack

    lda #$20
    sta $C5
    lda #$2F ; String ID #$002F: Alas, [name] was poisoned and lost [number] HP.[end-FC]

    sta $C6
    jmp B04_A9C0

; handler for Attack ID #$03: Faint Attack
B04_AA3A:
    jsr B04_AFFF
    bcs B04_AA14
    lda #$40
    sta $C5
    lda #$30 ; String ID #$0030: [name] fainted after losing [number] HP.[end-FC]

    sta $C6
    jmp B04_A9C0

; handler for Attack ID #$04: Parry
B04_AA4A:
    lda #$00
    sta $AD
    jmp B04_9CDC

; handler for Attack ID #$05: Run Away
B04_AA51:
    lda #$0F ; String ID #$000F: [name] broke away and ran.[end-FC]

    sta $AD
    ldy #$09
    lda ($B5), y
    tax
    dex
    txa
    sta ($B5), y
    ldy #$03
    lda #$FF
    sta ($B7), y
    jsr B04_9A84
    bne B04_AA6D
    lda #$FE
    sta $98 ; outcome of last fight?

B04_AA6D:
    jsr B04_9CDC
    ldy $06E2
    lda #$FF
    sta ($B5), y
    rts

; handler for Attack ID #$06: Firebal
B04_AA78:
    lda #$E1
    sta $AD
    jsr B04_AE7D
    lda #$18 ; Power

    jsr B04_AE8C ; $B0 = random number tightly distributed around A / 2, $B1 = #$00

    jmp B04_AEA1

; handler for Attack ID #$07: Firebane
B04_AA87:
    lda #$E3
    sta $AD
    lda #$32 ; Power

    sta $AA
    bne B04_AA99
; handler for Attack ID #$08: Explodet
B04_AA91:
    lda #$EE
    sta $AD
    lda #$82 ; Power

    sta $AA
B04_AA99:
    jsr B04_AE7D
    lda #$00
    sta $A8
B04_AAA0:
    lda $AA
    jsr B04_AE8C ; $B0 = random number tightly distributed around A / 2, $B1 = #$00

    jsr B04_AEA1
    lda $98 ; outcome of last fight?

    bne B04_AAB4
    inc $A8
    lda $A8
    cmp #$03
    bcc B04_AAA0
B04_AAB4:
    rts

; handler for Attack ID #$09: Heal-1
B04_AAB5:
    lda #$E9
    sta $AD
    lda #$40 ; Power

    sta $AA
    jmp B04_AAC8

; handler for Attack ID #$0A: Healmore-1
B04_AAC0:
    lda #$EB
    sta $AD
    lda #$80 ; Power

    sta $AA
B04_AAC8:
    jsr B04_AE7D
    lda $AA
    jsr B04_AE8C ; $B0 = random number tightly distributed around A / 2, $B1 = #$00

    jmp B04_AB14

; handler for Attack ID #$0B: Healall-1
B04_AAD3:
    lda #$ED
    sta $AD
    jsr B04_AE7D
    lda #$D0 ; Power

    sta $B0
    sta $B1
    jmp B04_AB14

; handler for Attack ID #$0C: Heal-2
B04_AAE3:
    lda #$E9
    sta $AD
    lda #$40 ; Power

    sta $AA
    bne B04_AAF5
; handler for Attack ID #$0D: Healmore-2
B04_AAED:
    lda #$EB
    sta $AD
    lda #$80 ; Power

    sta $AA
B04_AAF5:
    jsr B04_AE7D
    lda $AA
    jsr B04_AE8C ; $B0 = random number tightly distributed around A / 2, $B1 = #$00

    jsr B04_AB67
    jmp B04_AB16

; handler for Attack ID #$0E: Healall-2
B04_AB03:
    lda #$ED
    sta $AD
    jsr B04_AE7D
    lda #$D0 ; Power

    sta $B1
    jsr B04_AB67
    jmp B04_AB16

B04_AB14:
    lda $A7
B04_AB16:
    cmp #$08
    bcc B04_AB1C
    lda $A7
B04_AB1C:
    jsr B04_9EE9 ; given an index (in A) into the array of structures at $068F, set $B7-$B8 to the address of the corresponding item inside that structure

    ldy #$03
    lda ($B7), y
    jsr B04_9EEE ; given an index (in A) into the array of structures at $0663, set $B5-$B6 to the address of the corresponding item inside that structure

    ldy #$00
    lda ($B5), y
    sta $AE
    jsr B04_9EDC ; given an index + 1 (in A) into the array of enemy stat structures at $B7F5, set $BB-$BC to the address of the corresponding item inside that structure

    ldy #$03
    lda ($B7), y
    asl
    asl
    asl
    asl
    ldy #$02
    ora ($B7), y
    sta $AF
    jsr B04_B1F6
    lda $99
    clc
    adc $B0
    sta $99
    lda $9A
    adc $B1
    sta $9A
    ldx #$02
    jsr B04_B217
    bcs B04_AB56
    ldx #$00
B04_AB56:
    lda $99, x
    ldy #$04
    sta ($B7), y
    lda $9A, x
    ldy #$05
    sta ($B7), y
    lda #$17 ; String ID #$0017: [name]'s wounds were healed.[end-FC]

    jmp B04_9CE5

B04_AB67:
    lda #$FF
    sta $A6
    lda #$00
    sta $A3
    sta $A4
    sta $A5
B04_AB73:
    jsr B04_9ECD ; given an index (in A) into the array of structures at $068F, set $C1-$C2 to the address of the corresponding item inside that structure

    ldy #$03
    lda ($C1), y
    cmp #$04
    bcs B04_ABBC
    cmp $06E3
    beq B04_ABBC
    jsr B04_9ED2 ; given an index (in A) into the array of structures at $0663, set $BF-$C0 to the address of the corresponding item inside that structure

    ldy #$00
    lda ($BF), y
    jsr B04_9EDC ; given an index + 1 (in A) into the array of enemy stat structures at $B7F5, set $BB-$BC to the address of the corresponding item inside that structure

    ldy #$04
    lda ($C1), y
    sta $9B
    ldy #$00
    lda ($BB), y
    sta $9A
    lda #$00
    sta $99
    sta $9C
    jsr B04_A0A2
    lda $9A
    cmp $A4
    bcc B04_ABBC
    bne B04_ABB0
    lda $99
    cmp $A3
    bcc B04_ABBC
B04_ABB0:
    lda $99
    sta $A3
    lda $9A
    sta $A4
    lda $A5
    sta $A6
B04_ABBC:
    inc $A5
    lda $A5
    cmp #$08
    bcc B04_AB73
    lda $A6
    rts

; handler for Attack ID #$0F: Revive
B04_ABC7:
    lda #$F7
    sta $AD
    jsr B04_AE7D
    lda #$2C ; String ID #$002C: Then [name] was brought back to life![end-FC]

    sta $06E4
    jsr B04_B2AE
    bcc B04_ABDB
    lda #$07
    rts

B04_ABDB:
    sta $06E3
    jsr B04_9EEE ; given an index (in A) into the array of structures at $0663, set $B5-$B6 to the address of the corresponding item inside that structure

    txa
    jmp B04_ADCE

; handler for Attack ID #$10: Defence
B04_ABE5:
    lda #$E8
    jmp B04_AC84

; handler for Attack ID #$11: Increase
B04_ABEA:
    lda #$EA
    sta $AD
    jsr B04_AE7D
    lda #$00
    sta $06E8
B04_ABF6:
    jsr B04_9EE9 ; given an index (in A) into the array of structures at $068F, set $B7-$B8 to the address of the corresponding item inside that structure

    ldy #$03
    lda ($B7), y
    cmp #$04
    bcs B04_AC4C
    jsr B04_9EEE ; given an index (in A) into the array of structures at $0663, set $B5-$B6 to the address of the corresponding item inside that structure

    ldy #$00
    lda ($B5), y
    sta $AE
    jsr B04_9EDC ; given an index + 1 (in A) into the array of enemy stat structures at $B7F5, set $BB-$BC to the address of the corresponding item inside that structure

    ldy #$03
    lda ($B7), y
    asl
    asl
    asl
    asl
    ldy #$02
    ora ($B7), y
    sta $AF
    ldy #$06
    lda ($BB), y
    sta $A5
    lsr
    lsr
    jsr B04_AE8C ; $B0 = random number tightly distributed around A / 2, $B1 = #$00

    lda $A5
    sta $99
    jsr B04_A4DA
    ldy #$06
    lda ($B7), y
    sta $A6
    clc
    adc $B0
    bcc B04_AC3A
    lda #$FF
B04_AC3A:
    cmp $99
    bcc B04_AC40
    lda $99
B04_AC40:
    sta ($B7), y
    sec
    sbc $A6
    sta $B0
    lda #$23 ; String ID #$0023: [name]'s Defense Power increased by [number].[end-FC]

    jsr B04_9CE5
B04_AC4C:
    inc $06E8
    lda $06E8
    cmp #$08
    bcc B04_ABF6
    rts

; handler for Attack ID #$12: Sleep
B04_AC57:
    lda #$E2
    jmp B04_AC84

; handler for Attack ID #$13: Stopspell
B04_AC5C:
    lda #$E6
    jmp B04_AC84

; handler for Attack ID #$14: Surround
B04_AC61:
    lda #$E7
    jmp B04_AC84

; handler for Attack ID #$15: Defeat
B04_AC66:
    lda #$E4
    jmp B04_AC84

; handler for Attack ID #$16: Sacrifice
B04_AC6B:
    lda #$EC
    jmp B04_AC84

; handler for Attack IDs #$17-#$19: Weak, Strong, Deadly Flames
B04_AC70:
    lda #$33 ; String ID #$0033: [name] blew scorching flames![end-FC]
    jmp B04_AC7F

; handler for Attack ID #$1A: Poison Breath
B04_AC75:
    lda #$34 ; String ID #$0034: [name] exhaled a blast of poisonous breath.[end-FC]
    jmp B04_AC7F

; handler for Attack ID #$1B: Sweet Breath
B04_AC7A:
    lda #$37 ; String ID #$0037: [name] blew its sweet scented breath.[end-FC]
    jmp B04_AC7F

B04_AC7F:
    sta $AD
    jmp B04_AC89

B04_AC84:
    sta $AD
    jsr B04_AE7D
B04_AC89:
    lda #$00
    sta $A8
B04_AC8D:
    jsr B04_9EE4 ; given an index (in A) into the array of hero data structures at $062D, set $B9-$BA to the address of the corresponding item inside that structure

    ldy #$00
    lda ($B9), y
    bmi B04_ACB9
B04_AC96:
    lda $98 ; outcome of last fight?

    beq B04_AC9C
    bne B04_ACA4
B04_AC9C:
    inc $A8
    lda $A8
    cmp #$03
    bcc B04_AC8D
B04_ACA4:
    lda $06E1
    cmp #$16
    bne B04_ACB8
    lda $AB
    sta $AE
    lda $AC
    sta $AF
    lda #$27
    jsr B04_9CE5
B04_ACB8:
    rts

B04_ACB9:
    lda $A8
    eor #$FF
    sta $AE
    lda $06E1
    cmp #$10
    bne B04_ACF7
    ldy #$0C
    lda ($B9), y
    lsr
    sta $A5
    lsr
    jsr B04_AE8C ; $B0 = random number tightly distributed around A / 2, $B1 = #$00

    ldy #$0D
    lda ($B9), y
    sta $A6
    sec
    sbc $B0
    bcs B04_ACDE
    lda #$00
B04_ACDE:
    cmp $A5
    bcs B04_ACE4
    lda $A5
B04_ACE4:
    sta ($B9), y
    sta $99
    lda $A6
    sec
    sbc $99
    sta $B0
    lda #$22 ; String ID #$0022: [name]'s Defense Power decreased by [number].[end-FC]

    jsr B04_9CE5
    jmp B04_AC96

B04_ACF7:
    cmp #$12
    bne B04_AD30
    lda #$1E ; String ID #$001E: [name] fell asleep.[end-FC]

    sta $A5
    lda #$40
    sta $A6
    lda #$1D ; String ID #$001D: [name] did not fall asleep.[end-FC]

    bne B04_AD09
B04_AD07:
    lda #$18 ; String ID #$0018: But the spell had no effect on [name].[end-FC]

B04_AD09:
    sta $A4
    ldy #$00
    lda ($B9), y
    and $A6
    bne B04_AD2D
    jsr B04_AFD2
    bcc B04_AD20
    lda $A4
    jsr B04_9CE5
B04_AD1D:
    jmp B04_AC96

B04_AD20:
    ldy #$00
    lda ($B9), y
    ora $A6
    sta ($B9), y
    lda $A5
    jsr B04_9CE5
B04_AD2D:
    jmp B04_AC96

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
B04_AD42:
    cmp #$14
    bne B04_AD50
    lda #$2B ; String ID #$002B: And [name] was surrounded by the Phantom Force.[end-FC]

    sta $A5
    lda #$02
    sta $A6
    bne B04_AD07
B04_AD50:
    cmp #$15 ; Monster Attack ID #$15: Defeat

    bne B04_AD69
    jsr B04_B007
    bcc B04_AD61
    lda #$40
    jsr B04_9CE5
    jmp B04_AC96

B04_AD61:
    lda #$1B
B04_AD63:
    jsr B04_AF55
    jmp B04_AC96

B04_AD69:
    cmp #$16 ; Attack ID #$16: Sacrifice

    bne B04_AD71
    lda #$26 ; String ID #$0026: [name] was utterly defeated.[end-FC]

    bne B04_AD63
B04_AD71:
    cmp #$17 ; Attack ID #$17: Weak Flames

    bne B04_AD80
    lda #$18 ; Breath 1 power

B04_AD77:
    jsr B04_AE8C ; $B0 = random number tightly distributed around A / 2, $B1 = #$00

    jsr B04_AEFF ; extra resist for armors

    jmp B04_AC96

B04_AD80:
    cmp #$18 ; Attack ID #$18: Strong Flames

    bne B04_AD88
    lda #$32 ; Breath 2 power

    bne B04_AD77
B04_AD88:
    cmp #$19 ; Attack ID #$19: Deadly Flames

    bne B04_AD90
    lda #$8C ; Breath 3 power

    bne B04_AD77
B04_AD90:
    cmp #$1A ; Attack ID #$1A: Poison Breath

    bne B04_ADA1
    lda #$35 ; String ID #$0035: [name] was poisoned.[end-FC]

    sta $A5
    lda #$20
    sta $A6
    lda #$36 ; String ID #$0036: [name] repelled the poison.[end-FC]

    jmp B04_AD09

B04_ADA1:
    lda #$1E ; String ID #$001E: [name] fell asleep.[end-FC]

    sta $A5
    lda #$40
    sta $A6
    lda #$1D ; String ID #$001D: [name] did not fall asleep.[end-FC]

    jmp B04_AD09

; handler for Attack ID #$1C: Call For Help
B04_ADAE:
    lda #$13 ; String ID #$0013: [name] called for help.[end-FC]

    sta $AD
    jsr B04_AE7D
    lda #$15 ; String ID #$0015: [name] came to help.[end-FC]

    sta $06E4
    lda #$02 ; 1/2 Chance of Call For Help Succeeding

    jsr B04_A020 ; generate a random number between $03 and A in A and $99

    bne B04_ADC9
    lda $06E3
    jsr B04_B26D
    bcc B04_ADCE
B04_ADC9:
    lda #$14 ; String ID #$0014: But no help came.[end-FC]

    jmp B04_9CE5

B04_ADCE:
    sta ($B5), y
    sta $015E
    jsr B04_9EE9 ; given an index (in A) into the array of structures at $068F, set $B7-$B8 to the address of the corresponding item inside that structure

    tya
    ldy #$02
    sta ($B7), y
    sta $AF
    ldy #$03
    lda $06E3
    sta ($B7), y
    asl
    asl
    asl
    asl
    ora $AF
    sta $AF
    ldy #$00
    lda #$00
    sta ($B7), y
    iny
    lda #$04
    sta ($B7), y
    ldy #$09
    lda ($B5), y
    tax
    inx
    txa
    sta ($B5), y
    ldy #$00
    lda ($B5), y
    sta $015F
    sta $AE
    jsr B04_B7A4
    jsr B04_B6AB
    lda $06E4
    jmp B04_9CE5

; handler for Attack ID #$1D: Two Attacks
B04_AE15:
    jsr B04_A9BC ; handler for Attack IDs #$00/#$1E: Attack / Concentrated Attack

    jsr B04_A7B9
    jmp B04_A9BC ; handler for Attack IDs #$00/#$1E: Attack / Concentrated Attack


; handler for Attack ID #$1F: Strange Jig
B04_AE1E:
    lda #$31 ; String ID #$0031: Then [name] danced a strange jig.[end-FC]

    sta $AD
    lda #$02 ; 2 heroes with MP

    jsr B04_A020 ; generate a random number between $03 and A in A and $99

    sta $A3
    inc $A3 ; convert to 1-2 for Cannock-Moonbrooke

    lda $A3
    jsr B04_AE6D ; given hero ID in A, return that hero's current MP in A or #$00 if hero is dead

    bne B04_AE42
    lda $A3
    and #$01
    sta $A3
    inc $A3 ; if at first you don't succeed, try the other hero

    lda $A3
    jsr B04_AE6D ; given hero ID in A, return that hero's current MP in A or #$00 if hero is dead

    bne B04_AE42
    rts

B04_AE42:
    lda $A3
    eor #$FF
    sta $AE
    ldy #$05 ; Hero Max MP

    lda ($B9), y
    lsr ; Power = 1/2 Max MP

    jsr B04_AE8C ; $B0 = random number tightly distributed around A / 2, $B1 = #$00

    ldy #$10 ; offset for current MP

    lda ($B9), y
    sta $9A ; original current MP

    sec
    sbc $B0 ; randomized MP damage amount

    bcs B04_AE5D
    lda #$00 ; if negative, use 0 instead

B04_AE5D:
    sta ($B9), y ; update current MP

    sta $99 ; new current MP

    lda $9A ; original current MP

    sec
    sbc $99 ; new current MP

    sta $B0 ; actual MP damage

    lda #$32 ; String ID #$0032: And [name] lost [number] MP.[end-FC]

    jmp B04_9CE5

; given hero ID in A, return that hero's current MP in A or #$00 if hero is dead
B04_AE6D:
    jsr B04_9EE4 ; given an index (in A) into the array of hero data structures at $062D, set $B9-$BA to the address of the corresponding item inside that structure

    ldy #$00 ; status offset

    lda ($B9), y
    and #$80 ; Alive

    beq B04_AE7C
    ldy #$10 ; offset for current MP

    lda ($B9), y
B04_AE7C:
    rts

B04_AE7D:
    lda $06E7 ; Fireball, Firebane, and Explodet

    and #$40
    beq B04_AE8B
    lda #$12
    jsr B04_9CE5
    pla
    pla
B04_AE8B:
    rts

; $B0 = random number tightly distributed around A / 2, $B1 = #$00
B04_AE8C:
    sta $99
    lda #$00
    sta $9A
    jsr B04_9FFB ; set $9B to a random number tightly distributed around #$80 and $9C to #$00

    jsr B04_A05F ; 16-bit multiplication: ($99-$9A) = ($99-$9A) * ($9B-$9C), overflow in $9E, copy of ($99-$9A) in ($A1-$9D)

    lda $9D
    sta $B0
    lda $9E ; product of 2 8-bit number can never exceed 16 bits, so this is guaranteed to be #$00

    sta $B1
    rts

B04_AEA1:
    lda #$0C ; Firebal

    sta $B2
B04_AEA5:
    lda $A8
    eor #$FF
    sta $AE
    lda $A8
    jsr B04_9EE4 ; given an index (in A) into the array of hero data structures at $062D, set $B9-$BA to the address of the corresponding item inside that structure

    ldy #$00
    lda ($B9), y
    bmi B04_AEB7
    rts

B04_AEB7:
    ldy #$02
    lda ($B9), y
    cmp #$3C
    bne B04_AEC3
    lsr $B1
    ror $B0
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
    jmp B04_AF03

B04_AED9:
    lda $06E7
    ror
    bcc B04_AEEE
    jsr B0F_C3AB ; generate a random number and store it in $32-$33 (two passes)

    lda $32 ; RNG byte 0

    and #$03
    bne B04_AEEE
    lda #$00
    sta $B0
    sta $B1
B04_AEEE:
    lda $B0
    ora $B1
    bne B04_AF03
    lda #$07 ; String ID #$0007: But missed![end-FC]

    jsr B04_9ADE ; STA $B4, $B3 |= #$20

    lda #$09
    jsr B04_9CE5
    rts

B04_AEFF:
    lda #$0C ; String ID #$000C: [name]'s HP is reduced by [number].[end-FC]

    sta $B2
B04_AF03:
    lda $B2
    cmp #$2F ; Item ID #$2F: Gremlin’s Tail

    beq B04_AF0D
    cmp #$30 ; Item ID #$30: Dragon’s Bane

    bne B04_AF15
B04_AF0D:
    ldy #$00
    lda ($B9), y
    ora $C5
    sta ($B9), y
B04_AF15:
    lda $A8
    sta $9C
    lda #$53 ; Item ID #$53: Water Flying Cloth (equipped)

    jsr B04_AFCC
    bcs B04_AF81
    lda #$58 ; Item ID #$58: Magic Armor (equipped)

    jsr B04_AFCC
    bcs B04_AF81
    lda #$5B ; Item ID #$5B: Armor of Erdrick (equipped)

    jsr B04_AFCC
    bcs B04_AF81
    jmp B04_AFC2

B04_AF31:
    lda $B0
    sta $9B
    lda $B1
    sta $9C
    ldy #$0E
    lda ($B9), y
    sta $99
    ldy #$0F
    lda ($B9), y
    sta $9A
    jsr B04_A0E3 ; 16-bit subtraction: ($99-$9A) = ($99-$9A) - ($9B-$9C)

    bcc B04_AF50
    lda $99
    ora $9A
    bne B04_AF73
B04_AF50:
    jsr B04_AF6D
    lda #$1B
B04_AF55:
    sta $B2
    ldy #$00
    lda #$04
    sta ($B9), y
    jsr B04_A0F1
    ldx #$00
    jsr B04_B243
    lda $A3
    bne B04_AF6D
    lda #$FF
    sta $98 ; outcome of last fight?

B04_AF6D:
    lda #$00
    sta $99
    sta $9A
B04_AF73:
    ldy #$0E
    lda $99
    sta ($B9), y
    iny
    lda $9A
    sta ($B9), y
    jmp B04_9AE7

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
B04_AF9B:
    jmp B04_AF31

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
B04_AFC2:
    lda $B0
    ora $B1
    bne B04_AF9B
    inc $B0
    bne B04_AF9B
B04_AFCC:
    sta $06E5
    jmp B0F_C4B0 ; given a hero ID in $9C and an item ID in A, SEC if hero has that item, CLC otherwise

B04_AFD2:
    lda $06E1
    cmp #$13
    beq B04_AFDD
    cmp #$12
    bne B04_AFFF
B04_AFDD:
    lda $A8
    sta $9C
    lda #$6F ; Item ID #$6F: Gremlin’s Tail (equipped)

    jsr B0F_C4B0 ; given a hero ID in $9C and an item ID in A, SEC if hero has that item, CLC otherwise

    ldx #$18 ; 24/32 Sleep, Stopspell - Gremlin's Tail

    bcs B04_AFF5
    lda #$70 ; Item ID #$70: Dragon’s Bane (equipped)

    jsr B0F_C4B0 ; given a hero ID in $9C and an item ID in A, SEC if hero has that item, CLC otherwise

    ldx #$03 ; 3/32 Sleep, Stopspell - Dragon's Bane

    bcs B04_AFF5
    ldx #$0C ; 12/32 Sleep, Stopspell

B04_AFF5:
    lda #$20
    jsr B04_A020 ; generate a random number between $03 and A in A and $99

    stx $9A
    cmp $9A
    rts

B04_AFFF:
    lda #$08
    jsr B04_A020 ; generate a random number between $03 and A in A and $99

    cmp #$03 ; 3/8 Faint Attack, Surround, Poison Breath, Sweet Breath

    rts

B04_B007:
    lda #$08
    jsr B04_A020 ; generate a random number between $03 and A in A and $99

    cmp #$01 ; 1/8 Heroic Attack, Defeat

    rts

B04_B00F:
    lda $A8
    jsr B04_9EE4 ; given an index (in A) into the array of hero data structures at $062D, set $B9-$BA to the address of the corresponding item inside that structure

    ldy #$0D
    lda ($B9), y
    sta $9B
    ldy #$00
    lda ($B9), y
    and #$40
    sta $06E9
B04_B023:
    lda $06EA
    sta $99
    lda #$00
    sta $9A
    sta $9C
    jsr B04_9F6C
    lda $06E9
    beq B04_B049
    lda #$05
    sta $9B
    lda #$00 ; this is a waste of bytes; should skip these 2 ops and call B04_A05B instead of B04_A05F

    sta $9C
    jsr B04_A05F ; 16-bit multiplication: ($99-$9A) = ($99-$9A) * ($9B-$9C), overflow in $9E, copy of ($99-$9A) in ($A1-$9D)

    lsr $9A
    ror $99
    lsr $9A
    ror $99
B04_B049:
    lda $99
    sta $B0
    lda $9A
    sta $B1
    rts

B04_B052:
    sta $AE
    jsr B04_B1DC
    lda $AF
    cmp #$04
    bcc B04_B05E
    rts

B04_B05E:
    ldy #$07
    lda ($BB), y
    rol
    rol
    rol
    and #$03
    sta $B0
    lda #$64
    sta $06E8
B04_B06E:
    dec $06E8
    bne B04_B078
    lda #$00
    jmp B04_B1D8

B04_B078:
    jsr B0F_C3AB ; generate a random number and store it in $32-$33 (two passes)

    lda $B0
    jsr B04_9ED7 ; given an index (in A) into the array of enemy special % structures at $B2F6, set $BD-$BE to the address of the corresponding item inside that structure

    ldy #$00
B04_B082:
    lda ($BD), y
    cmp $32 ; RNG byte 0

    bcs B04_B08D
    iny
    cpy #$07
    bcc B04_B082
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
    lda ($BB), y
    plp
    bcc B04_B0A2
    asl
    asl
    asl
    asl
B04_B0A2:
    and #$F0
    sta $9C
    ldy #$0E
    lda ($BB), y
    inx
B04_B0AB:
    dex
    beq B04_B0B1
    lsr
    bpl B04_B0AB
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
    jsr B04_B20F
    lsr $9C
    ror $9B
    jsr B04_B217
    bcc B04_B0CD
    bcs B04_B06E
B04_B0CD:
    lda $B0
    cmp #$02
    bcc B04_B12B
    ldy #$00
    lda ($B7), y
    and #$40
    beq B04_B0E8
    lda $AD
    cmp #$06
    bcc B04_B0E8
    cmp #$17
    bcs B04_B0E8
    jmp B04_B06E

B04_B0E8:
    ldx #$00
    jsr B04_B243
    lda $AD
    cmp #$12
    bne B04_B0FF
    ldx #$01
    jsr B04_B243
    lda $A3
    cmp $A4
    jmp B04_B11C

B04_B0FF:
    cmp #$13
    bne B04_B10F
    ldx #$03
    jsr B04_B243
    lda $A3
    cmp $A6
    jmp B04_B11C

B04_B10F:
    cmp #$14
    bne B04_B120
    ldx #$02
    jsr B04_B243
    lda $A3
    cmp $A5
B04_B11C:
    bne B04_B12B
    beq B04_B12E
B04_B120:
    cmp #$1C
    bne B04_B131
    lda $AF
    jsr B04_B26D
B04_B129:
    bcs B04_B12E
B04_B12B:
    jmp B04_B194

B04_B12E:
    jmp B04_B06E

B04_B131:
    cmp #$0F
    bne B04_B13B
    jsr B04_B2AE
    jmp B04_B129

B04_B13B:
    cmp #$09
    bcc B04_B14C
    cmp #$0C
    bcs B04_B14C
    jsr B04_B20F
    jsr B04_B217
    jmp B04_B129

B04_B14C:
    cmp #$0C
    bcc B04_B194
    cmp #$0F
    bcs B04_B194
    lda #$00
    sta $A3
B04_B158:
    cmp $AF
    beq B04_B183
    jsr B04_9EEE ; given an index (in A) into the array of structures at $0663, set $B5-$B6 to the address of the corresponding item inside that structure

    ldy #$00
    lda ($B5), y
    jsr B04_9EDC ; given an index + 1 (in A) into the array of enemy stat structures at $B7F5, set $BB-$BC to the address of the corresponding item inside that structure

    ldy #$01
    sty $A4
B04_B16A:
    lda ($B5), y
    cmp #$08
    bcs B04_B17B
    jsr B04_9EE9 ; given an index (in A) into the array of structures at $068F, set $B7-$B8 to the address of the corresponding item inside that structure

    jsr B04_B20F
    jsr B04_B217
    bcc B04_B191
B04_B17B:
    inc $A4
    ldy $A4
    cpy #$09
    bcc B04_B16A
B04_B183:
    inc $A3
    lda $A3
    cmp #$04
    bcc B04_B158
    jsr B04_B1DC
    jmp B04_B06E

B04_B191:
    jsr B04_B1DC
B04_B194:
    lda $AD
    cmp #$05
    bne B04_B1AF
    lda $B0
    beq B04_B1AF
    ldy #$05
    lda ($BB), y
    sta $A3
    lda $0636 ; Midenhall Strength

    lsr
    cmp $A3
    bcs B04_B1AF
    jmp B04_B06E

B04_B1AF:
    ldy #$0D
    lda ($BB), y
    and #$0F
    cmp #$0E
    bne B04_B1CF
    ldy #$0E
    lda ($BB), y
    rol
    bcc B04_B1CF
    ldy #$0A
    lda ($B5), y
    cmp #$FF
    bne B04_B1CF
    jsr B04_B222
    ldy #$0A
    sta ($B5), y
B04_B1CF:
    lda $AD
    cmp #$1E
    bne B04_B1D8
    jmp B04_B06E

B04_B1D8:
    ldy #$01 ; Character magic

    sta ($B7), y
B04_B1DC:
    lda $AE
    jsr B04_9EE9 ; given an index (in A) into the array of structures at $068F, set $B7-$B8 to the address of the corresponding item inside that structure

    ldy #$03
    lda ($B7), y
    sta $AF
    cmp #$04
    bcc B04_B1EC
    rts

B04_B1EC:
    jsr B04_9EEE ; given an index (in A) into the array of structures at $0663, set $B5-$B6 to the address of the corresponding item inside that structure

    ldy #$00
    lda ($B5), y
    jmp B04_9EDC ; given an index + 1 (in A) into the array of enemy stat structures at $B7F5, set $BB-$BC to the address of the corresponding item inside that structure

B04_B1F6:
    ldy #$04
    lda ($B7), y
    sta $99
    iny
    lda ($B7), y
    sta $9A
    ldy #$00
    lda ($BB), y
    sta $9B
    iny
    lda ($BB), y
    and #$0F
    sta $9C
    rts

B04_B20F:
    jsr B04_B1F6
    lsr $9C
    ror $9B
    rts

B04_B217:
    lda $9A
    cmp $9C
    bne B04_B221
    lda $99
    cmp $9B
B04_B221:
    rts

B04_B222:
    jsr B04_B2D4
    ldx #$00
    stx $C5
B04_B229:
    lda $A3, x
    cmp #$03
    beq B04_B238
    jsr B04_9EE4 ; given an index (in A) into the array of hero data structures at $062D, set $B9-$BA to the address of the corresponding item inside that structure

    ldy #$00
    lda ($B9), y
    bmi B04_B240
B04_B238:
    inc $C5
    ldx $C5
    cpx #$04
    bcc B04_B229
B04_B240:
    lda $A3, x
    rts

B04_B243:
    lda #$00
    sta $A3, x
B04_B247:
    tay
    lda $062D, y ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    cpx #$02
    bcc B04_B258
    cpx #$03
    beq B04_B254
    lsr
B04_B254:
    lsr
    jmp B04_B25E

B04_B258:
    cpx #$00
    beq B04_B25D
    asl
B04_B25D:
    asl
B04_B25E:
    lda #$00
    adc $A3, x
    sta $A3, x
    tya
    clc
    adc #$12
    cmp #$25
    bcc B04_B247
    rts

B04_B26D:
    ldy #$FE
    sty $95 ; ID for [item] and [spell] control codes

B04_B271:
    sta $C8
    jsr B04_9ED2 ; given an index (in A) into the array of structures at $0663, set $BF-$C0 to the address of the corresponding item inside that structure

    lda #$00
    sta $C7
B04_B27A:
    jsr B04_9ECD ; given an index (in A) into the array of structures at $068F, set $C1-$C2 to the address of the corresponding item inside that structure

    ldy #$03
    lda ($C1), y
    cmp #$FF
    beq B04_B28E
    inc $C7
    lda $C7
    cmp #$08
    bcc B04_B27A
    rts

B04_B28E:
    ldy #$01
B04_B290:
    lda ($BF), y
    cmp #$08
    bcc B04_B2A8
    cmp $95 ; ID for [item] and [spell] control codes

    beq B04_B2A8
    sty $C5
    ldx $C8
    jsr B04_8B09
    php
    ldy $C5
    lda $C7
    plp
    rts

B04_B2A8:
    iny
    cpy #$09
    bcc B04_B290
    rts

B04_B2AE:
    jsr B04_B2D4
    ldy #$FF
    sta $95 ; ID for [item] and [spell] control codes

    ldx #$00
    stx $C6
B04_B2B9:
    lda $A3, x
    jsr B04_B271
    sta $06E9
    bcs B04_B2CB
    ldx $C6
    lda $A3, x
    ldx $06E9
    rts

B04_B2CB:
    inc $C6
    ldx $C6
    cpx #$04
    bcc B04_B2B9
    rts

B04_B2D4:
    lda #$FF
    ldx #$03
B04_B2D8:
    sta $A3, x
    dex
    bpl B04_B2D8
    ldy #$04
B04_B2DF:
    tya
    jsr B04_A020 ; generate a random number between $03 and A in A and $99

    inc $99
    ldx #$FF
B04_B2E7:
    inx
    lda $A3, x
    bpl B04_B2E7
    dec $99
    bne B04_B2E7
    dey
    sty $A3, x
    bne B04_B2DF
    rts


; code -> data
; Attack % for Enemy Specials
.byte $1F,$3F,$5F,$7F,$9F,$BF,$DF,$25,$4C,$6D,$8F,$AD,$CB,$E5
.byte $2D,$57,$7D,$9F,$BD,$D7,$ED
.byte $63,$95,$B1,$C9
.byte $DC,$EB
.byte $F7

B04_B312:
    lda #$00
    sta $A8
B04_B316:
    jsr B04_9EE4 ; given an index (in A) into the array of hero data structures at $062D, set $B9-$BA to the address of the corresponding item inside that structure

    ldy #$00
    lda ($B9), y
    and #$C0
    cmp #$80
    beq B04_B32C
    ldy #$02
    lda #$46
    sta ($B9), y
    jmp B04_B4EC

B04_B32C:
    jsr B04_9AC7
    lda #$FF
    jsr B04_B578
    lda $A8
    sta $AA
    beq B04_B354
    lda #$00
    jsr B04_B5EB
    beq B04_B34E
    lda $A8
    cmp #$01
    beq B04_B352
    lda #$01
    jsr B04_B5EB
    bne B04_B352
B04_B34E:
    lda #$01
    bne B04_B354
B04_B352:
    lda #$02
B04_B354:
    jsr B04_B537
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
B04_B375:
    lda #$01
    jsr B04_B5EB
    beq B04_B37E
    dec $A8
B04_B37E:
    dec $A8
    lda $A8
    jmp B04_B316

B04_B385:
    jmp B04_B472

B04_B388:
    lda #$3C
    sta $A9
    jmp B04_B4E0

B04_B38F:
    jsr B04_9AA0
    jmp B04_9AB4

B04_B395:
    lda #$00
    jsr B04_B578
    cmp #$04
    bcc B04_B3A1
B04_B39E:
    jmp B04_B32C

B04_B3A1:
    sta $AA
    lda #$00
    sta $A9
    jmp B04_B4E0

B04_B3AA:
    lda $A8
    tay
    dey
    tya
    jsr B04_B5D2
    cmp #$FF
    beq B04_B39E
    cmp #$FE
    bne B04_B3C8
    jsr B04_9AB4
    lda #$45 ; String ID #$0045: cannot use the spell yet.[end-FC]

B04_B3BF:
    jsr B04_9CCA ; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0

    jsr B04_9A3C ; set number of NMIs to wait for to current battle message delay * 1.5 if current battle message delay is < #$80, #$64 otherwise

    jmp B04_B32C

B04_B3C8:
    tax
    stx $C8
    lda $A8
    sta $9C
    lda #$61
    jsr B0F_C4B0 ; given a hero ID in $9C and an item ID in A, SEC if hero has that item, CLC otherwise

    bcc B04_B3DB
    txa
    clc
    adc #$0F
    tax
B04_B3DB:
    lda B04_B4FA-1, x
    sta $C7
    lda $A8
    jsr B04_9EC8 ; given an index (in A) into the array of hero data structures at $062D, set $C3-$C4 to the address of the corresponding item inside that structure

    ldy #$10
    lda ($C3), y
    cmp $C7
    bcs B04_B3F4
    jsr B04_9AB4
    lda #$11 ; String ID #$0011: Thy MP is low.[end-FC]

    bne B04_B3BF
B04_B3F4:
    ldx $C8
    lda B04_B518-1, x
    beq B04_B404
    cmp #$02
    bcc B04_B409
    beq B04_B41C
    jmp B04_B42D

B04_B404:
    stx $A9
    jmp B04_B4E0

B04_B409:
    stx $A9
    lda #$00
    jsr B04_B578
    cmp #$FF
    bne B04_B417
    jmp B04_B3AA

B04_B417:
    sta $AA
    jmp B04_B4E0

B04_B41C:
    stx $A9
    jsr B04_B5E4
    cmp #$FF
    bne B04_B428
    jmp B04_B3AA

B04_B428:
    sta $AA
    jmp B04_B4E0

B04_B42D:
    lda #$32
    jsr B04_A020 ; generate a random number between $03 and A in A and $99

    beq B04_B441
B04_B434:
    lda #$07
    jsr B04_A020 ; generate a random number between $03 and A in A and $99

    clc
    adc #$0F
    sta $A9
    jmp B04_B4E0

B04_B441:
    lda #$02
    jsr B04_A020 ; generate a random number between $03 and A in A and $99

    sta $A9
    jsr B04_9EC8 ; given an index (in A) into the array of hero data structures at $062D, set $C3-$C4 to the address of the corresponding item inside that structure

    ldy #$00
    lda ($C3), y
    bpl B04_B460
    lda $A9
    eor #$01
    jsr B04_9EC8 ; given an index (in A) into the array of hero data structures at $062D, set $C3-$C4 to the address of the corresponding item inside that structure

    ldy #$00
    lda ($C3), y
    bpl B04_B46B
    bmi B04_B434
B04_B460:
    lda $A9
B04_B462:
    sta $AA
    lda #$16
    sta $A9
    jmp B04_B4E0

B04_B46B:
    lda $A9
    eor #$01
    jmp B04_B462

B04_B472:
    lda $A8
    sta $614C
    jsr B04_B5DB
    pha
    ldy $A8
    txa
    sta $06D2, y
    pla
    cmp #$FF
    bne B04_B489
    jmp B04_B32C

B04_B489:
    cmp #$FE
    bne B04_B4A1
    jsr B04_9AB4
    lda $614C
    jsr B04_9CD0 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    lda #$46 ; String ID #$0046: [name] doesn't have any tools.[end-FC]

    jsr B04_9CCA ; for A < #$60, display string ID specified by A; for A >= #$60, display string ID specified by A + #$A0

    jsr B04_9A3C ; set number of NMIs to wait for to current battle message delay * 1.5 if current battle message delay is < #$80, #$64 otherwise

    jmp B04_B32C

B04_B4A1:
    sta $A9
    ldx #$00
B04_B4A5:
    lda B04_B527, x ; Items usable in battle

    cmp $A9
    beq B04_B4BA
    inx
    cpx #$08
    bcc B04_B4A5
    lda $A9
    ora #$80
    sta $A9
    jmp B04_B4E0

B04_B4BA:
    txa
    clc
    adc #$17
    sta $A9
    lda B04_B52F, x ; Base Target for Battle Items - (00: Open Cast)  (01: Select Enemy)  (02: Select Ally)

    beq B04_B4E0
    cmp #$02
    bcc B04_B4D5
    jsr B04_B5E4
    cmp #$FF
    beq B04_B472
    sta $AA
    jmp B04_B4E0

B04_B4D5:
    lda #$00
    jsr B04_B578
    cmp #$FF
    beq B04_B472
    sta $AA
B04_B4E0:
    ldy #$02
    lda $A9
    sta ($B9), y
    ldy #$01
    lda $AA
    sta ($B9), y
B04_B4EC:
    inc $A8
    lda $A8
    cmp #$03
    bcs B04_B4F7
    jmp B04_B316

B04_B4F7:
    jmp B04_9AB4


B04_B4FA:
; code -> data
; MP Cost in Battle (normal)
.byte $02	 ; Spell ID #$01: Firebal
.byte $02	 ; Spell ID #$02: Sleep
.byte $04	 ; Spell ID #$03: Firebane
.byte $04	 ; Spell ID #$04: Defeat
.byte $04	 ; Spell ID #$05: Infernos
.byte $03	 ; Spell ID #$06: Stopspell
.byte $02	 ; Spell ID #$07: Surround
.byte $02	 ; Spell ID #$08: Defence
.byte $03	 ; Spell ID #$09: Heal
.byte $02	 ; Spell ID #$0A: Increase
.byte $05	 ; Spell ID #$0B: Healmore
.byte $01	 ; Spell ID #$0C: Sacrifice
.byte $08	 ; Spell ID #$0D: Healall
.byte $08	 ; Spell ID #$0E: Explodet
.byte $0F	 ; Spell ID #$0F: Chance
; MP Cost in Battle (with Mysterious Hat)
.byte $01	 ; Spell ID #$01: Firebal
.byte $01	 ; Spell ID #$02: Sleep
.byte $03	 ; Spell ID #$03: Firebane
.byte $03	 ; Spell ID #$04: Defeat
.byte $03	 ; Spell ID #$05: Infernos
.byte $02	 ; Spell ID #$06: Stopspell
.byte $01	 ; Spell ID #$07: Surround
.byte $01	 ; Spell ID #$08: Defence
.byte $02	 ; Spell ID #$09: Heal
.byte $01	 ; Spell ID #$0A: Increase
.byte $04	 ; Spell ID #$0B: Healmore
.byte $01	 ; Spell ID #$0C: Sacrifice
.byte $06	 ; Spell ID #$0D: Healall
.byte $06	 ; Spell ID #$0E: Explodet
.byte $0C	 ; Spell ID #$0F: Chance

; Base Target for Spells - (00: Open Cast)  (01: Select Enemy)  (02: Select Ally)
B04_B518:
.byte $01	 ; Spell ID #$01: Firebal
.byte $01	 ; Spell ID #$02: Sleep
.byte $00	 ; Spell ID #$03: Firebane
.byte $01	 ; Spell ID #$04: Defeat
.byte $01	 ; Spell ID #$05: Infernos
.byte $01	 ; Spell ID #$06: Stopspell
.byte $01	 ; Spell ID #$07: Surround
.byte $00	 ; Spell ID #$08: Defence
.byte $02	 ; Spell ID #$09: Heal
.byte $00	 ; Spell ID #$0A: Increase
.byte $02	 ; Spell ID #$0B: Healmore
.byte $00	 ; Spell ID #$0C: Sacrifice
.byte $02	 ; Spell ID #$0D: Healall
.byte $00	 ; Spell ID #$0E: Explodet
.byte $03	 ; Spell ID #$0F: Chance

; Items usable in battle
B04_B527:
.byte $03	 ; Item ID #$03: Wizard’s Wand
.byte $04	 ; Item ID #$04: Staff of Thunder
.byte $10	 ; Item ID #$10: Thunder Sword
.byte $0E	 ; Item ID #$0E: Light Sword
.byte $1D	 ; Item ID #$1D: Shield of Strength
.byte $3C	 ; Item ID #$3C: Medical Herb
.byte $3B	 ; Item ID #$3B: Antidote Herb
.byte $3D	 ; Item ID #$3D: Wizard’s Ring

; Base Target for Battle Items - (00: Open Cast)  (01: Select Enemy)  (02: Select Ally)
B04_B52F:
.byte $01	 ; Item ID #$03: Wizard’s Wand
.byte $01	 ; Item ID #$04: Staff of Thunder
.byte $01	 ; Item ID #$10: Thunder Sword
.byte $00	 ; Item ID #$0E: Light Sword
.byte $00	 ; Item ID #$1D: Shield of Strength
.byte $02	 ; Item ID #$3C: Medical Herb
.byte $02	 ; Item ID #$3B: Antidote Herb
.byte $00	 ; Item ID #$3D: Wizard’s Ring

B04_B537:
    sta $99
    ldx #$00
    lda #$01
    sta $5A, x ; Crest/direction name write buffer start

    inx
    lda #$02
    sta $5A, x ; Crest/direction name write buffer start

    inx
    lda $99
    cmp #$01
    lda #$03
    bcc B04_B54F
    lda #$04
B04_B54F:
    sta $5A, x ; Crest/direction name write buffer start

    inx
    lda $99
    cmp #$02
    lda #$06
    bcc B04_B55C
    lda #$03
B04_B55C:
    sta $5A, x ; Crest/direction name write buffer start

    inx
    lda #$05
    sta $5A, x ; Crest/direction name write buffer start

    inx
    lda #$FF
    sta $5A, x ; Crest/direction name write buffer start

    lda #$04
    sta $94 ; return bank for various function calls, doubles as index of selected option for multiple-choice menus

    lda $A8
    jsr B0F_F4EF ; open battle command menu for hero A

    tax
    inx
    beq B04_B577
    lda $5A, x ; Crest/direction name write buffer start

B04_B577:
    rts

B04_B578:
    sta $4B ; flag for whether to display the selectable or non-selectable monster list

    ldx #$00
    txa
    sta $A7
B04_B57F:
    jsr B04_9ED2 ; given an index (in A) into the array of structures at $0663, set $BF-$C0 to the address of the corresponding item inside that structure

    ldy #$09
    lda ($BF), y
    beq B04_B594
    sta $061D, x ; monster group 1 monster count

    ldy #$00
    lda ($BF), y
    sta $061C, x ; monster group 1 monster ID

    inx
    inx
B04_B594:
    inc $A7
    lda $A7
    cmp #$04
    bcc B04_B57F
    cpx #$08
    bcs B04_B5A5
    lda #$00
    sta $061C, x ; monster group 1 monster ID

B04_B5A5:
    lda #$04
    sta $94 ; return bank for various function calls, doubles as index of selected option for multiple-choice menus

    jsr B0F_F51B ; display appropriate battle menu monster list

    ldy $4B ; flag for whether to display the selectable or non-selectable monster list

    beq B04_B5B1
    rts

B04_B5B1:
    cmp #$FF
    beq B04_B5D1
    tax
    inx
    lda #$00
    sta $A7
B04_B5BB:
    jsr B04_9ED2 ; given an index (in A) into the array of structures at $0663, set $BF-$C0 to the address of the corresponding item inside that structure

    ldy #$09
    lda ($BF), y
    beq B04_B5C7
    dex
    beq B04_B5CF
B04_B5C7:
    inc $A7
    lda $A7
    cmp #$04
    bcc B04_B5BB
B04_B5CF:
    lda $A7
B04_B5D1:
    rts

B04_B5D2:
    pha
    lda #$04
    sta $94 ; return bank for various function calls, doubles as index of selected option for multiple-choice menus

    pla
    jmp B0F_F49E

B04_B5DB:
    pha
    lda #$04
    sta $94 ; return bank for various function calls, doubles as index of selected option for multiple-choice menus

    pla
    jmp B0F_F4B0 ; given hero ID in A, display that hero's battle item list window and return the selected item ID in A

B04_B5E4:
    lda #$04
    sta $94 ; return bank for various function calls, doubles as index of selected option for multiple-choice menus

    jmp B0F_F529 ; display appropriate battle menu item/spell target

B04_B5EB:
    jsr B04_9EC8 ; given an index (in A) into the array of hero data structures at $062D, set $C3-$C4 to the address of the corresponding item inside that structure

    ldy #$00
    lda ($C3), y
    and #$C0
    cmp #$80
    rts

B04_B5F7:
    ldx #$00
    lda #$FF
    sta $05FE ; number of monsters in current group killed by last attack?

B04_B5FE:
    sta $0162, x
    inx
    cpx #$14
    bcc B04_B5FE
    lda #$00
    sta $A7
    sta $A9
B04_B60C:
    lda $A9
    jsr B04_9EEE ; given an index (in A) into the array of structures at $0663, set $B5-$B6 to the address of the corresponding item inside that structure

    ldy #$00
    lda ($B5), y
    sta $015F
    jsr B04_9EDC ; given an index + 1 (in A) into the array of enemy stat structures at $B7F5, set $BB-$BC to the address of the corresponding item inside that structure

    lda #$FF
    ldy #$0A
    sta ($B5), y
    lda #$01
    sta $A8
B04_B625:
    ldy $A8
    lda ($B5), y
    bne B04_B65B
    inc $05FE ; number of monsters in current group killed by last attack?

    lda $A7
    jsr B04_9EE9 ; given an index (in A) into the array of structures at $068F, set $B7-$B8 to the address of the corresponding item inside that structure

    lda $A7
    ldy $A8
    sta ($B5), y
    sta $015E
    tya
    ldy #$02
    sta ($B7), y
    lda $A9
    ldy #$03
    sta ($B7), y
    lda #$00
    ldy #$00
    sta ($B7), y
    jsr B04_B7A4
    jsr B04_B6AB
    inc $A7
    lda $A7
    cmp #$08
    bcs B04_B683
B04_B65B:
    inc $A8
    lda $A8
    cmp #$09
    bcc B04_B625
    inc $A9
    lda $A9
    cmp #$04
    bcc B04_B60C
B04_B66b:
    lda $A7
    cmp #$08
    bcs B04_B683
    jsr B04_9EE9 ; given an index (in A) into the array of structures at $068F, set $B7-$B8 to the address of the corresponding item inside that structure

    lda #$FF
    ldy #$03
    sta ($B7), y
    ldy #$02
    sta ($B7), y
    inc $A7
    jmp B04_B66b

B04_B683:
    lda #$00
B04_B685:
    pha
    jsr B04_9EE4 ; given an index (in A) into the array of hero data structures at $062D, set $B9-$BA to the address of the corresponding item inside that structure

    ldy #$0C
    lda ($B9), y
    ldy #$0D
    sta ($B9), y
    pla
    tax
    inx
    txa
    cmp #$03
    bcc B04_B685
    lda #$00
    tax
B04_B69C:
    sta $0626, x ; EXP earned this battle or current hero's current EXP, byte 0

    inx
    cpx #$06
    bcc B04_B69C
    sta $06E6
    sta $06EC
    rts

B04_B6AB:
    ldy #$06
    lda ($BB), y
    ldy #$06
    sta ($B7), y
    ldy #$00
    lda ($BB), y
    sta $99
    lsr $99
    lsr $99
    lda #$00
    sta $9A
    jsr B0F_C3AB ; generate a random number and store it in $32-$33 (two passes)

    lda $32 ; RNG byte 0

    sta $9B
    jsr B04_A05B ; 16-bit multiplication: ($99-$9A) = ($99-$9A) * ($9B), overflow in $9E, copy of ($99-$9A) in ($A1-$9D)

    ldy #$00
    lda ($BB), y
    sec
    sbc $9D
    ldy #$04
    sta ($B7), y
    iny
    lda #$00
    sta ($B7), y
    rts

B04_B6DC:
    lda #$00
    sta $A7
    sta $A5
B04_B6E2:
    jsr B04_9EE4 ; given an index (in A) into the array of hero data structures at $062D, set $B9-$BA to the address of the corresponding item inside that structure

    ldy #$00
    lda ($B9), y
    bpl B04_B6F9
    lda $A5
    ldx $A7
    sta $06C7, x
    ldy #$0A
    lda ($B9), y
    jsr B04_B790
B04_B6F9:
    inc $A5
    lda $A5
    cmp #$03
    bcc B04_B6E2
    lda #$00
    sta $A5
B04_B705:
    jsr B04_9EEE ; given an index (in A) into the array of structures at $0663, set $B5-$B6 to the address of the corresponding item inside that structure

    ldy #$00
    lda ($B5), y
    jsr B04_9EDC ; given an index + 1 (in A) into the array of enemy stat structures at $B7F5, set $BB-$BC to the address of the corresponding item inside that structure

    lda #$01
    sta $A6
B04_B713:
    tay
    lda ($B5), y
    cmp #$08
    bcs B04_B728
    adc #$10
    ldx $A7
    sta $06C7, x
    ldy #$04
    lda ($BB), y
    jsr B04_B790
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
B04_B73C:
    cpx #$0B
    bcs B04_B747
    sta $06C7, x
    inx
    jmp B04_B73C

B04_B747:
    lda $A7
    cmp #$02
    bcs B04_B74E
    rts

B04_B74E:
    ldx #$00
B04_B750:
    lda $06D2, x
    sta $A8
    stx $A9
    txa
    tay
    iny
B04_B75A:
    lda $A8
    cmp $06D2, y
    bcs B04_B768
    lda $06D2, y
    sta $A8
    sty $A9
B04_B768:
    iny
    cpy $A7
    bcc B04_B75A
    ldy $A9
    lda $06C7, y
    sta $A8
    lda $06D2, x
    sta $06D2, y
    lda $06C7, x
    sta $06C7, y
    lda $A8
    sta $06C7, x
    inx
    inx
    cpx $A7
    bcs B04_B78F
    dex
    jmp B04_B750

B04_B78F:
    rts

B04_B790:
    lsr
    sta $99
    jsr B0F_C3AB ; generate a random number and store it in $32-$33 (two passes)

    lda $32 ; RNG byte 0

    adc $99
    bcc B04_B79E
    lda #$FF
B04_B79E:
    sta $06D2, x
    inc $A7
    rts

B04_B7A4:
    ldy #$01
B04_B7A6:
    ldx #$00
    stx $99
B04_B7AA:
    lda $0162, x
    cmp $015F
    bne B04_B7BA
    tya
    cmp $016A, x
    bne B04_B7BA
    inc $99
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
B04_B7CA:
    ldx $015E
    lda $015F
    sta $0162, x
    tya
    sta $016A, x
    cmp #$02
    bcs B04_B7DC
    rts

B04_B7DC:
    ldx #$03
B04_B7DE:
    lda $0172, x
    cmp #$FF
    beq B04_B7EE
    cmp $015F
    beq B04_B7F4
    dex
    bpl B04_B7DE
    rts

B04_B7EE:
    lda $015F
    sta $0172, x
B04_B7F4:
    rts


; code -> data
; Enemy Stats (Max HP, [4-bit evade chance / 64, 4-bit unused], Max Gold dropped, EXP low byte, AGI, Attack Power, Defense Power, [2-bit attack probability list, 3-bit Sleep res., 3-bit spell damage res.], [2-bit EXP * 256, 3-bit Defeat res., 3-bit Stopspell res.], [2-bit EXP * 1024, 3-bit Defense res., 3-bit Surround res.], [4-bit Attack command 1, 4-bit Attack command 2], [4-bit Attack command 3, 4-bit Attack command 4], [4-bit Attack command 5, 4-bit Attack command 6], [4-bit Attack command 7, 4-bit Attack command 8], 8*1-bit use alternate attack command)
.byte $05,$10,$02,$01,$03,$07,$05,$40,$07,$00,$50,$50,$00,$00,$00	 ; Monster ID #$01: Slime
.byte $08,$00,$03,$02,$03,$09,$06,$00,$07,$00,$00,$00,$00,$00,$00	 ; Monster ID #$02: Big Slug
.byte $05,$10,$04,$02,$04,$0B,$0D,$00,$07,$00,$00,$00,$00,$00,$00	 ; Monster ID #$03: Iron Ant
.byte $09,$00,$03,$03,$05,$0C,$08,$40,$07,$01,$05,$00,$00,$00,$00	 ; Monster ID #$04: Drakee
.byte $0A,$10,$05,$05,$08,$0E,$0B,$80,$07,$02,$50,$00,$00,$55,$00	 ; Monster ID #$05: Wild Mouse
.byte $19,$00,$05,$0F,$14,$0F,$0A,$5B,$0F,$00,$CC,$CC,$0C,$CC,$00	 ; Monster ID #$06: Healer
.byte $0C,$20,$06,$06,$08,$12,$0A,$00,$07,$00,$00,$00,$00,$00,$00	 ; Monster ID #$07: Ghost Mouse
.byte $0D,$10,$04,$08,$09,$10,$0D,$08,$07,$00,$00,$00,$20,$2E,$80	 ; Monster ID #$08: Babble
.byte $0C,$00,$02,$04,$08,$13,$0D,$50,$0F,$01,$00,$C0,$00,$CC,$C4	 ; Monster ID #$09: Army Ant
.byte $0F,$00,$0A,$0A,$0B,$11,$0B,$40,$08,$01,$56,$06,$06,$05,$00	 ; Monster ID #$0A: Magician
.byte $10,$20,$05,$07,$0F,$13,$0B,$80,$0F,$02,$50,$00,$00,$5E,$80	 ; Monster ID #$0B: Big Rat
.byte $0E,$10,$09,$09,$0B,$16,$0A,$48,$0F,$02,$22,$22,$00,$00,$00	 ; Monster ID #$0C: Big Cobra
.byte $0E,$10,$08,$12,$14,$12,$0D,$50,$00,$02,$22,$20,$00,$0E,$87	 ; Monster ID #$0D: Magic Ant
.byte $0C,$10,$0A,$0C,$0E,$0E,$0A,$50,$03,$02,$00,$00,$00,$00,$1F	 ; Monster ID #$0E: Magidrakee
.byte $15,$00,$1E,$0E,$0D,$19,$28,$08,$0F,$00,$00,$02,$00,$00,$00	 ; Monster ID #$0F: Centipod
.byte $14,$00,$32,$19,$0C,$1C,$10,$08,$07,$01,$33,$30,$30,$00,$00	 ; Monster ID #$10: Man O’ War
.byte $0F,$20,$0C,$1B,$10,$14,$0A,$50,$0B,$01,$66,$06,$00,$60,$00	 ; Monster ID #$11: Lizard Fly
.byte $3C,$00,$19,$28,$0C,$1F,$07,$78,$3F,$01,$00,$40,$04,$4E,$84	 ; Monster ID #$12: Zombie
.byte $0F,$40,$28,$10,$0F,$0E,$28,$91,$0A,$11,$33,$30,$00,$00,$07	 ; Monster ID #$13: Smoke
.byte $19,$20,$0F,$17,$29,$29,$0C,$C8,$07,$03,$50,$C0,$C0,$05,$14	 ; Monster ID #$14: Ghost Rat
.byte $28,$20,$2D,$14,$14,$30,$0C,$90,$07,$02,$05,$00,$00,$05,$00	 ; Monster ID #$15: Baboon
.byte $20,$00,$10,$1D,$0C,$20,$0B,$50,$07,$07,$B0,$B0,$B0,$00,$15	 ; Monster ID #$16: Carnivog
.byte $14,$10,$19,$21,$0D,$27,$6E,$48,$07,$0A,$00,$02,$05,$15,$00	 ; Monster ID #$17: Megapede
.byte $20,$00,$50,$22,$10,$26,$0B,$6A,$1F,$0A,$B0,$23,$C5,$15,$11	 ; Monster ID #$18: Sea Slug
.byte $2A,$20,$1D,$24,$16,$23,$0D,$00,$08,$00,$2D,$D2,$00,$00,$0F	 ; Monster ID #$19: Medusa Ball
.byte $28,$10,$1E,$25,$19,$24,$0E,$A1,$0A,$09,$36,$66,$50,$21,$C1	 ; Monster ID #$1A: Enchanter
.byte $1C,$20,$23,$20,$16,$1E,$09,$79,$17,$13,$00,$00,$0F,$F0,$60	 ; Monster ID #$1B: Mud Man
.byte $2D,$10,$2D,$28,$12,$2D,$0C,$50,$0F,$08,$50,$00,$C0,$0C,$90	 ; Monster ID #$1C: Magic Baboon
.byte $30,$10,$32,$2C,$1F,$33,$10,$8A,$1F,$0A,$00,$D0,$01,$10,$04	 ; Monster ID #$1D: Demighost
.byte $3C,$10,$17,$34,$1E,$39,$14,$9A,$1C,$12,$20,$90,$70,$95,$11	 ; Monster ID #$1E: Gremlin
.byte $2E,$00,$19,$1F,$17,$2D,$12,$52,$1F,$0B,$A2,$A2,$02,$A2,$45	 ; Monster ID #$1F: Poison Lily
.byte $2E,$00,$28,$2C,$01,$3A,$02,$78,$2F,$12,$00,$00,$00,$00,$00	 ; Monster ID #$20: Mummy Man
.byte $1A,$20,$1E,$32,$1E,$1E,$78,$8E,$1C,$04,$40,$14,$10,$42,$FD	 ; Monster ID #$21: Gorgon
.byte $19,$50,$37,$28,$30,$46,$14,$90,$17,$13,$00,$00,$00,$D1,$40	 ; Monster ID #$22: Saber Tiger
.byte $28,$10,$2B,$3B,$23,$33,$15,$78,$1F,$08,$77,$77,$70,$05,$1F	 ; Monster ID #$23: Dragon Fly
.byte $33,$00,$50,$32,$1E,$3A,$13,$50,$27,$1B,$05,$F0,$00,$05,$04	 ; Monster ID #$24: Titan Tree
.byte $41,$10,$28,$2D,$21,$3F,$11,$10,$3F,$13,$00,$00,$00,$0E,$80	 ; Monster ID #$25: Undead
.byte $26,$20,$3A,$29,$29,$4B,$19,$90,$1F,$12,$22,$22,$22,$25,$00	 ; Monster ID #$26: Basilisk
.byte $32,$00,$1C,$19,$27,$37,$10,$38,$27,$07,$CC,$0C,$0C,$0C,$AB	 ; Monster ID #$27: Goopi
.byte $3C,$10,$32,$3D,$24,$4B,$17,$51,$27,$09,$50,$00,$00,$05,$00	 ; Monster ID #$28: Orc
.byte $3C,$00,$64,$34,$5A,$40,$18,$33,$3F,$36,$11,$1F,$FF,$F1,$FF	 ; Monster ID #$29: Puppet Man
.byte $4B,$10,$3C,$3E,$2A,$46,$1A,$BC,$27,$1C,$53,$03,$00,$0E,$80	 ; Monster ID #$2A: Mummy
.byte $3F,$10,$2D,$43,$2D,$48,$1B,$9A,$27,$24,$03,$0F,$30,$F5,$5A	 ; Monster ID #$2B: Evil Tree
.byte $32,$10,$1E,$27,$2D,$3C,$50,$B9,$1F,$0B,$23,$04,$32,$04,$BB	 ; Monster ID #$2C: Gas
.byte $5F,$00,$33,$3D,$22,$3B,$0A,$2A,$3F,$0A,$20,$B0,$2B,$2E,$A4	 ; Monster ID #$2D: Hork
.byte $3C,$10,$2D,$40,$33,$4B,$1B,$91,$11,$09,$50,$30,$00,$95,$04	 ; Monster ID #$2E: Hawk Man
.byte $37,$10,$28,$48,$2B,$3D,$1C,$91,$12,$12,$73,$70,$07,$15,$42	 ; Monster ID #$2F: Sorcerer
.byte $06,$10,$5A,$87,$64,$0A,$B4,$7F,$3F,$3F,$56,$66,$25,$55,$10	 ; Monster ID #$30: Metal Slime
.byte $41,$10,$2D,$43,$46,$52,$19,$59,$17,$09,$00,$00,$00,$05,$00	 ; Monster ID #$31: Hunter
.byte $32,$00,$19,$5C,$37,$4D,$1E,$51,$1F,$10,$B0,$B0,$FF,$00,$35	 ; Monster ID #$32: Evil Eye
.byte $3C,$20,$53,$51,$34,$4A,$1D,$90,$19,$14,$00,$40,$00,$01,$54	 ; Monster ID #$33: Hibabango
.byte $3C,$00,$1E,$26,$31,$48,$18,$A1,$17,$3F,$CC,$00,$05,$5E,$83	 ; Monster ID #$34: Graboopi
.byte $64,$10,$FF,$3F,$39,$50,$38,$92,$2A,$0C,$50,$00,$00,$05,$00	 ; Monster ID #$35: Gold Orc
.byte $43,$10,$30,$54,$4B,$49,$1C,$93,$1E,$0B,$E7,$E7,$10,$05,$50	 ; Monster ID #$36: Evil Clown
.byte $50,$30,$64,$3D,$29,$78,$13,$9A,$18,$09,$66,$66,$66,$60,$00	 ; Monster ID #$37: Ghoul
.byte $39,$10,$31,$55,$30,$4B,$19,$52,$17,$09,$DD,$0D,$00,$C0,$4B	 ; Monster ID #$38: Vampirus
.byte $48,$10,$50,$59,$35,$5D,$1C,$9A,$23,$0B,$00,$00,$00,$00,$84	 ; Monster ID #$39: Mega Knight
.byte $50,$10,$37,$51,$47,$5F,$4C,$3C,$17,$02,$00,$00,$00,$0E,$80	 ; Monster ID #$3A: Saber Lion
.byte $46,$10,$96,$52,$3D,$37,$50,$DC,$2F,$01,$DD,$D1,$10,$00,$07	 ; Monster ID #$3B: Metal Hunter
.byte $45,$20,$69,$8B,$39,$50,$1F,$9B,$23,$1B,$A0,$70,$73,$2C,$F0	 ; Monster ID #$3C: Ozwarg
.byte $43,$00,$51,$5D,$37,$4A,$16,$BC,$17,$25,$B4,$40,$B0,$FF,$D7	 ; Monster ID #$3D: Dark Eye
.byte $3C,$10,$5F,$47,$40,$55,$1F,$88,$1A,$13,$30,$00,$30,$30,$51	 ; Monster ID #$3E: Gargoyle
.byte $6E,$10,$87,$9A,$3C,$63,$23,$D2,$23,$12,$0D,$DD,$AA,$00,$00	 ; Monster ID #$3F: Orc King
.byte $41,$10,$67,$B6,$4F,$4D,$15,$AA,$1F,$12,$02,$70,$27,$02,$FF	 ; Monster ID #$40: Magic Vampirus
.byte $58,$20,$7B,$75,$41,$77,$17,$A0,$27,$12,$00,$00,$00,$0E,$80	 ; Monster ID #$41: Berserker
.byte $23,$00,$FF,$1A,$C8,$4B,$FF,$3F,$3F,$7F,$77,$74,$55,$55,$08	 ; Monster ID #$42: Metal Babble
.byte $50,$80,$87,$C9,$47,$7D,$24,$B9,$2B,$13,$AD,$00,$00,$10,$2A	 ; Monster ID #$43: Hargon’s Knight
.byte $73,$40,$63,$47,$3F,$79,$20,$58,$57,$19,$00,$00,$00,$15,$00	 ; Monster ID #$44: Cyclops
.byte $78,$00,$78,$D3,$5A,$73,$E6,$FF,$BF,$02,$DD,$DD,$11,$D1,$4F	 ; Monster ID #$45: Attackbot
.byte $5F,$50,$93,$5E,$45,$82,$38,$FB,$77,$1B,$88,$00,$88,$07,$B3	 ; Monster ID #$46: Green Dragon
.byte $9E,$50,$64,$69,$8C,$5C,$26,$BB,$BF,$0C,$FF,$8F,$08,$15,$D0	 ; Monster ID #$47: Mace Master
.byte $37,$00,$65,$F5,$4E,$63,$20,$97,$17,$15,$88,$8C,$C8,$C8,$FF	 ; Monster ID #$48: Flame
.byte $59,$50,$60,$0F,$5A,$5C,$23,$B9,$67,$14,$B7,$7B,$7B,$BB,$A8	 ; Monster ID #$49: Silver Batboon
.byte $5A,$40,$71,$C5,$55,$6F,$21,$32,$5F,$1A,$50,$05,$05,$05,$FF	 ; Monster ID #$4A: Blizzard
.byte $9B,$10,$5F,$03,$64,$91,$29,$3A,$B7,$12,$00,$00,$10,$01,$00	 ; Monster ID #$4B: Giant
.byte $70,$60,$64,$8C,$6E,$6C,$27,$B3,$72,$12,$60,$77,$8B,$0B,$B1	 ; Monster ID #$4C: Gold Batboon
.byte $D2,$70,$6E,$68,$96,$8C,$50,$64,$F7,$12,$88,$8D,$88,$8D,$CC	 ; Monster ID #$4D: Bullwong
.byte $FA,$70,$FA,$4C,$3F,$C3,$C8,$3F,$3F,$52,$DD,$DD,$DD,$DE,$FF	 ; Monster ID #$4E: Atlas
.byte $FA,$70,$F0,$FA,$4B,$7F,$A0,$9C,$7F,$66,$68,$57,$25,$DB,$75	 ; Monster ID #$4F: Bazuzu
.byte $FA,$00,$FF,$98,$78,$C8,$DC,$AD,$37,$80,$BB,$88,$88,$D1,$F0	 ; Monster ID #$50: Zarlox
.byte $E6,$00,$00,$00,$96,$B4,$BB,$FB,$3C,$3F,$BB,$B8,$82,$BD,$E0	 ; Monster ID #$51: Hargon
.byte $FA,$70,$00,$00,$6E,$FF,$FF,$3F,$3F,$14,$9B,$93,$B3,$99,$C5	 ; Monster ID #$52: Malroth

; EXP per level
; Exp needed for Midenhall
ExpNeeded:
; indexed data load target (from $9D61, $9D6D)
.word 12         ; Lv  2: (12 total)
.word 20         ; Lv  3: (32 total)
.word 40         ; Lv  4: (72 total)
.word 68         ; Lv  5: (140 total)
.word 140        ; Lv  6: (280 total)
.word 280        ; Lv  7: (560 total)
.word 440        ; Lv  8: (1000 total)
.word 800        ; Lv  9: (1800 total)
.word 1000       ; Lv 10: (2800 total)
.word 1100       ; Lv 11: (3900 total)
.word 1400       ; Lv 12: (5300 total)
.word 2300       ; Lv 13: (7600 total)
.word 2400       ; Lv 14: (10000 total)
.word 3000       ; Lv 15: (13000 total)
.word 4000       ; Lv 16: (17000 total)
.word 4000       ; Lv 17: (21000 total)
.word 5000       ; Lv 18: (26000 total)
.word 6000       ; Lv 19: (32000 total)
.word 8000       ; Lv 20: (40000 total)
.word 10000      ; Lv 21: (50000 total)
.word 12000      ; Lv 22: (62000 total)
.word 13000      ; Lv 23: (75000 total)
.word 15000      ; Lv 24: (90000 total)
.word 17000      ; Lv 25: (107000 total)
.word 20000      ; Lv 26: (127000 total)
.word 23000      ; Lv 27: (150000 total)
.word 25000      ; Lv 28: (175000 total)
.word 25000      ; Lv 29: (200000 total)
.word 30000      ; Lv 30: (230000 total)
.word 30000      ; Lv 31: (260000 total)
.word 30000      ; Lv 32: (290000 total)
.word 30000      ; Lv 33: (320000 total)
.word 30000      ; Lv 34: (350000 total)
.word 30000      ; Lv 35: (380000 total)
.word 30000      ; Lv 36: (410000 total)
.word 30000      ; Lv 37: (440000 total)
.word 30000      ; Lv 38: (470000 total)
.word 30000      ; Lv 39: (500000 total)
.word 30000      ; Lv 40: (530000 total)
.word 40000      ; Lv 41: (570000 total)
.word 50000      ; Lv 42: (620000 total)
.word 50000      ; Lv 43: (670000 total)
.word 50000      ; Lv 44: (720000 total)
.word 50000      ; Lv 45: (770000 total)
.word 50000      ; Lv 46: (820000 total)
.word 50000      ; Lv 47: (870000 total)
.word 50000      ; Lv 48: (920000 total)
.word 50000      ; Lv 49: (970000 total)
.word 30000      ; Lv 50: (1000000 total)

; Exp needed for Cannock
.word 24         ; Lv  2: (24 total)
.word 36         ; Lv  3: (60 total)
.word 50         ; Lv  4: (110 total)
.word 90         ; Lv  5: (200 total)
.word 180        ; Lv  6: (380 total)
.word 320        ; Lv  7: (700 total)
.word 600        ; Lv  8: (1300 total)
.word 1100       ; Lv  9: (2400 total)
.word 1600       ; Lv 10: (4000 total)
.word 2000       ; Lv 11: (6000 total)
.word 2200       ; Lv 12: (8200 total)
.word 2800       ; Lv 13: (11000 total)
.word 4000       ; Lv 14: (15000 total)
.word 4000       ; Lv 15: (19000 total)
.word 5000       ; Lv 16: (24000 total)
.word 6000       ; Lv 17: (30000 total)
.word 7000       ; Lv 18: (37000 total)
.word 9000       ; Lv 19: (46000 total)
.word 11000      ; Lv 20: (57000 total)
.word 13000      ; Lv 21: (70000 total)
.word 15000      ; Lv 22: (85000 total)
.word 15000      ; Lv 23: (100000 total)
.word 16000      ; Lv 24: (116000 total)
.word 18000      ; Lv 25: (134000 total)
.word 22000      ; Lv 26: (156000 total)
.word 26000      ; Lv 27: (182000 total)
.word 28000      ; Lv 28: (210000 total)
.word 30000      ; Lv 29: (240000 total)
.word 40000      ; Lv 30: (280000 total)
.word 30000      ; Lv 31: (310000 total)
.word 30000      ; Lv 32: (340000 total)
.word 40000      ; Lv 33: (380000 total)
.word 50000      ; Lv 34: (430000 total)
.word 50000      ; Lv 35: (480000 total)
.word 40000      ; Lv 36: (520000 total)
.word 60000      ; Lv 37: (580000 total)
.word 60000      ; Lv 38: (640000 total)
.word 60000      ; Lv 39: (700000 total)
.word 60000      ; Lv 40: (760000 total)
.word 60000      ; Lv 41: (820000 total)
.word 20000      ; Lv 42: (840000 total)
.word 60000      ; Lv 43: (900000 total)
.word 60000      ; Lv 44: (960000 total)
.word 40000      ; Lv 45: (1000000 total)

; Exp needed for Moonbrooke
.word 100        ; Lv  2: (100 total)
.word 200        ; Lv  3: (300 total)
.word 300        ; Lv  4: (600 total)
.word 600        ; Lv  5: (1200 total)
.word 1200       ; Lv  6: (2400 total)
.word 1800       ; Lv  7: (4200 total)
.word 2200       ; Lv  8: (6400 total)
.word 2600       ; Lv  9: (9000 total)
.word 3000       ; Lv 10: (12000 total)
.word 4000       ; Lv 11: (16000 total)
.word 4000       ; Lv 12: (20000 total)
.word 5000       ; Lv 13: (25000 total)
.word 6000       ; Lv 14: (31000 total)
.word 8000       ; Lv 15: (39000 total)
.word 11000      ; Lv 16: (50000 total)
.word 15000      ; Lv 17: (65000 total)
.word 18000      ; Lv 18: (83000 total)
.word 20000      ; Lv 19: (103000 total)
.word 22000      ; Lv 20: (125000 total)
.word 25000      ; Lv 21: (150000 total)
.word 30000      ; Lv 22: (180000 total)
.word 40000      ; Lv 23: (220000 total)
.word 50000      ; Lv 24: (270000 total)
.word 30000      ; Lv 25: (300000 total)
.word 30000      ; Lv 26: (330000 total)
.word 30000      ; Lv 27: (360000 total)
.word 40000      ; Lv 28: (400000 total)
.word 50000      ; Lv 29: (450000 total)
.word 24464      ; Lv 30: (540000 total, 65536 EXP pre-added)
.word 24464      ; Lv 31: (630000 total, 65536 EXP pre-added)
.word 34464      ; Lv 32: (730000 total, 65536 EXP pre-added)
.word 24464      ; Lv 33: (820000 total, 65536 EXP pre-added)
.word 24464      ; Lv 34: (910000 total, 65536 EXP pre-added)
.word 24464      ; Lv 35: (1000000 total, 65536 EXP pre-added)

Starting_Stats:
;STR, AGI, Max Hp, Max Mp
.byte 5, 4,28,$00 ; Midenhall
.byte 4, 4,31,$06 ; Cannock
.byte 2,22,32,$1C ; Moonbrooke

; level up stat nybbles (STR/AGI, HP/MP)
.define levelnybble(xstr, xagi, xhp, xmp) .byte (xstr << 4) | xagi, (xhp << 4) | xmp
LevelStatUps:
levelnybble  2, 1, 9, 0	 ; Midenhall Lv  2
levelnybble  0, 3, 3, 6	 ; Cannock Lv 2
levelnybble  0, 4, 0, 0	 ; Moonbrooke Lv 2
levelnybble  5, 2, 3, 0	 ; Midenhall Lv  3
levelnybble  2, 2, 1, 4	 ; Cannock Lv 3
levelnybble  0, 0, 5, 7	 ; Moonbrooke Lv 3
levelnybble  5, 0, 8, 0	 ; Midenhall Lv  4
levelnybble  1, 2, 3, 2	 ; Cannock Lv 4
levelnybble  1, 2, 0, 9	 ; Moonbrooke Lv 4
levelnybble  1, 5, 4, 0	 ; Midenhall Lv  5
levelnybble  0, 4, 2, 2	 ; Cannock Lv 5
levelnybble  0, 5, 1, 4	 ; Moonbrooke Lv 5
levelnybble  2, 6, 3, 0	 ; Midenhall Lv  6
levelnybble  1, 4, 2, 2	 ; Cannock Lv 6
levelnybble  1, 7, 1, 0	 ; Moonbrooke Lv 6
levelnybble  9, 3, 1, 0	 ; Midenhall Lv  7
levelnybble  1, 2, 0, 5	 ; Cannock Lv 7
levelnybble  1, 2, 1, 2	 ; Moonbrooke Lv 7
levelnybble  1, 3, 2, 0	 ; Midenhall Lv  8
levelnybble  6, 0, 2, 5	 ; Cannock Lv 8
levelnybble  1, 5, 5, 2	 ; Moonbrooke Lv 8
levelnybble  3, 0, 0, 0	 ; Midenhall Lv  9
levelnybble  0, 7, 1, 2	 ; Cannock Lv 9
levelnybble  1, 3, 5, 6	 ; Moonbrooke Lv 9
levelnybble  3, 4, 2, 0	 ; Midenhall Lv 10
levelnybble  1, 4, 2, 4	 ; Cannock Lv 10
levelnybble  1, 5, 6, 5	 ; Moonbrooke Lv 10
levelnybble  5, 2, 2, 0	 ; Midenhall Lv 11
levelnybble  1, 4, 3, 2	 ; Cannock Lv 11
levelnybble  0, 1, 2, 6	 ; Moonbrooke Lv 111
levelnybble  3, 3, 1, 0	 ; Midenhall Lv 12
levelnybble  2, 0, 2, 3	 ; Cannock Lv 12
levelnybble  1, 2, 1, 2	 ; Moonbrooke Lv 12
levelnybble  5, 4, 1, 0	 ; Midenhall Lv 13
levelnybble  8, 7, 2, 2	 ; Cannock Lv 13
levelnybble  1, 5, 3, 4	 ; Moonbrooke Lv 13
levelnybble  4, 0, 1, 0	 ; Midenhall Lv 14
levelnybble  3, 5, 5, 3	 ; Cannock Lv 14
levelnybble  1, 6, 6, 5	 ; Moonbrooke Lv 14
levelnybble  2, 4, 3, 0	 ; Midenhall Lv 15
levelnybble  4, 0, 4, 2	 ; Cannock Lv 15
levelnybble  1, 3, 7, 6	 ; Moonbrooke Lv 15
levelnybble  3, 6, 2, 0	 ; Midenhall Lv 16
levelnybble  5, 7, 2, 4	 ; Cannock Lv 16
levelnybble  3, 6, 5,12	 ; Moonbrooke Lv 16
levelnybble  3, 2, 5, 0	 ; Midenhall Lv 17
levelnybble  0, 2, 4, 8	 ; Cannock Lv 17
levelnybble  2, 3, 9,12	 ; Moonbrooke Lv 17
levelnybble  5, 0, 3, 0	 ; Midenhall Lv 18
levelnybble  1, 3, 3, 3	 ; Cannock Lv 18
levelnybble  1, 4, 8, 9	 ; Moonbrooke Lv 18
levelnybble  3, 3, 4, 0	 ; Midenhall Lv 19
levelnybble  1, 6, 7, 3	 ; Cannock Lv 19
levelnybble  2, 2, 8, 9	 ; Moonbrooke Lv 19
levelnybble  6, 4,13, 0	 ; Midenhall Lv 20
levelnybble  2, 3, 4, 0	 ; Cannock Lv 20
levelnybble  0, 9, 7, 7	 ; Moonbrooke Lv 20
levelnybble  6, 3, 6, 0	 ; Midenhall Lv 21
levelnybble  2, 4, 4, 8	 ; Cannock Lv 21
levelnybble  3, 4,12, 3	 ; Moonbrooke Lv 21
levelnybble  6, 6, 9, 0	 ; Midenhall Lv 22
levelnybble  2, 4, 4, 1	 ; Cannock Lv 22
levelnybble  2,10, 9, 2	 ; Moonbrooke Lv 22
levelnybble  4, 1, 9, 0	 ; Midenhall Lv 23
levelnybble  1, 2, 8, 6	 ; Cannock Lv 23
levelnybble  4, 7, 7,11	 ; Moonbrooke Lv 23
levelnybble  3, 4, 6, 0	 ; Midenhall Lv 24
levelnybble  2, 3, 7, 4	 ; Cannock Lv 24
levelnybble  4, 0, 5, 7	 ; Moonbrooke Lv 24
levelnybble  5, 0, 9, 0	 ; Midenhall Lv 25
levelnybble  1, 0, 7, 4	 ; Cannock Lv 25
levelnybble  2, 3, 1, 5	 ; Moonbrooke Lv 25
levelnybble  4, 3, 8, 0	 ; Midenhall Lv 26
levelnybble  2, 3,12, 0	 ; Cannock Lv 26
levelnybble  1, 3, 4, 9	 ; Moonbrooke Lv 26
levelnybble  4, 6,11, 0	 ; Midenhall Lv 27
levelnybble  1, 8,13, 3	 ; Cannock Lv 27
levelnybble  0, 5, 1, 7	 ; Moonbrooke Lv 27
levelnybble  5, 3,10, 0	 ; Midenhall Lv 28
levelnybble  4, 0, 5, 5	 ; Cannock Lv 28
levelnybble  1, 4, 1, 5	 ; Moonbrooke Lv 28
levelnybble  4, 4, 7, 0	 ; Midenhall Lv 29
levelnybble  7, 6, 9, 6	 ; Cannock Lv 29
levelnybble  3, 3, 7, 1	 ; Moonbrooke Lv 29
levelnybble  5, 2, 3, 0	 ; Midenhall Lv 30
levelnybble  3, 1, 1, 3	 ; Cannock Lv 30
levelnybble  2, 5, 1, 5	 ; Moonbrooke Lv 30
levelnybble  6, 2, 5, 0	 ; Midenhall Lv 31
levelnybble  2, 2, 6, 4	 ; Cannock Lv 31
levelnybble  6, 2, 6, 1	 ; Moonbrooke Lv 31
levelnybble  3, 1, 2, 0	 ; Midenhall Lv 32
levelnybble  0, 3, 1, 3	 ; Cannock Lv 32
levelnybble  4, 3, 2, 1	 ; Moonbrooke Lv 32
levelnybble  1, 0, 8, 0	 ; Midenhall Lv 33
levelnybble 10, 2, 1, 3	 ; Cannock Lv 33
levelnybble  4, 6, 2, 7	 ; Moonbrooke Lv 33
levelnybble  2, 2, 2, 0	 ; Midenhall Lv 34
levelnybble  5, 1, 2, 2	 ; Cannock Lv 34
levelnybble  4, 3, 1, 6	 ; Moonbrooke Lv 34
levelnybble  1, 2, 2, 0	 ; Midenhall Lv 35
levelnybble  7, 2, 2, 5	 ; Cannock Lv 35
levelnybble 10, 6, 9, 5	 ; Moonbrooke Lv 35
levelnybble  2, 1, 5, 0	 ; Midenhall Lv 36
levelnybble  8, 3, 3, 0	 ; Cannock Lv 36
levelnybble  2, 2, 3, 0	 ; Midenhall Lv 37
levelnybble  9, 0, 3, 3	 ; Cannock Lv 37
levelnybble  3, 2, 1, 0	 ; Midenhall Lv 38
levelnybble  6, 4, 5, 2	 ; Cannock Lv 38
levelnybble  1, 2, 4, 0	 ; Midenhall Lv 39
levelnybble  0, 3, 4, 7	 ; Cannock Lv 39
levelnybble  1, 3, 1, 0	 ; Midenhall Lv 40
levelnybble  5, 0, 2, 3	 ; Cannock Lv 40
levelnybble  2, 2, 4, 0	 ; Midenhall Lv 41
levelnybble  2, 5, 8, 2	 ; Cannock Lv 41
levelnybble  1, 2, 1, 0	 ; Midenhall Lv 42
levelnybble  8, 6, 0, 3	 ; Cannock Lv 42
levelnybble  3, 1, 4, 0	 ; Midenhall Lv 43
levelnybble  1, 2, 4, 4	 ; Cannock Lv 43
levelnybble  1, 2, 0, 0	 ; Midenhall Lv 44
levelnybble  4, 5, 2, 6	 ; Cannock Lv 44
levelnybble  0, 3, 5, 0	 ; Midenhall Lv 45
levelnybble  5, 2, 4, 5	 ; Cannock Lv 45
levelnybble  1, 5, 1, 0	 ; Midenhall Lv 46
levelnybble  1, 3, 1, 0	 ; Midenhall Lv 47
levelnybble  3, 7, 7, 0	 ; Midenhall Lv 48
levelnybble  1, 2, 6, 0	 ; Midenhall Lv 49
levelnybble  4, 8, 5, 0	 ; Midenhall Lv 50

; levels for learning spells
SpellLevels:
; Cannock level for learning battle spells
.byte 3	 ; Spell ID #$01: Firebal
.byte 8	 ; Spell ID #$06: Stopspell
.byte 18	 ; Spell ID #$03: Firebane
.byte 23	 ; Spell ID #$04: Defeat
.byte 1	 ; Spell ID #$09: Heal
.byte 14	 ; Spell ID #$0B: Healmore
.byte 20	 ; Spell ID #$0A: Increase
.byte 28	 ; Spell ID #$0C: Sacrifice
; Cannock level for learning field spells
.byte 1	 ; Spell ID #$09: Heal
.byte 6	 ; Spell ID #$10: Antidote
.byte 10	 ; Spell ID #$14: Return
.byte 12	 ; Spell ID #$12: Outside
.byte 14	 ; Spell ID #$0B: Healmore
.byte 17	 ; Spell ID #$16: Stepguard
.byte 25	 ; Spell ID #$17: Revive
.byte $FF	 ; no spell
; Moonbrooke level for learning battle spells
.byte 2	 ; Spell ID #$02: Sleep
.byte 4	 ; Spell ID #$05: Infernos
.byte 6	 ; Spell ID #$07: Surround
.byte 19	 ; Spell ID #$0E: Explodet
.byte 1	 ; Spell ID #$0B: Healmore
.byte 10	 ; Spell ID #$08: Defense
.byte 15	 ; Spell ID #$0D: Healall
.byte 25	 ; Spell ID #$0F: Chance
; Moonbrooke level for learning field spells
.byte 1	 ; Spell ID #$0B: Healmore
.byte 8	 ; Spell ID #$13: Repel
.byte 12	 ; Spell ID #$10: Antidote
.byte 15	 ; Spell ID #$0D: Healall
.byte 17	 ; Spell ID #$12: Outside
.byte 21	 ; Spell ID #$16: Stepguard
.byte 23	 ; Spell ID #$15: Open
.byte $FF	 ; no spell

; equipment power list
EquipmentStats:
.byte 2	 ; Item ID #$01: Bamboo Stick
.byte 12	 ; Item ID #$02: Magic Knife
.byte 8	 ; Item ID #$03: Wizard’s Wand
.byte 15	 ; Item ID #$04: Staff of Thunder
.byte 8	 ; Item ID #$05: Club
.byte 10	 ; Item ID #$06: Copper Sword
.byte 15	 ; Item ID #$07: Chain Sickle
.byte 20	 ; Item ID #$08: Iron Spear
.byte 5	 ; Item ID #$09: Falcon Sword
.byte 30	 ; Item ID #$0A: Broad Sword
.byte 35	 ; Item ID #$0B: Giant Hammer
.byte 93	 ; Item ID #$0C: Sword of Destruction
.byte 50	 ; Item ID #$0D: Dragon Killer
.byte 65	 ; Item ID #$0E: Light Sword
.byte 40	 ; Item ID #$0F: Sword of Erdrick
.byte 80	 ; Item ID #$10: Thunder Sword

.byte 2   	 ; Item ID #$11: Clothes
.byte 20	 ; Item ID #$12: Clothes Hiding
.byte 35	 ; Item ID #$13: Water Flying Cloth
.byte 30	 ; Item ID #$14: Mink Coat
.byte 6      ; Item ID #$15: Leather Armor
.byte 12	 ; Item ID #$16: Chain Mail
.byte 50	 ; Item ID #$17: Gremlin’s Armor
.byte 25	 ; Item ID #$18: Magic Armor
.byte 25	 ; Item ID #$19: Full Plate Armor
.byte 35	 ; Item ID #$1A: Armor of Gaia
.byte 40	 ; Item ID #$1B: Armor of Erdrick

.byte  4	 ; Item ID #$1C: Leather Shield
.byte 18	 ; Item ID #$1D: Shield of Strength
.byte 10	 ; Item ID #$1E: Steel Shield
.byte 30	 ; Item ID #$1F: Evil Shield
.byte 20	 ; Item ID #$20: Shield of Erdrick

.byte  4	 ; Item ID #$21: Mysterious Hat
.byte  6	 ; Item ID #$22: Iron Helmet
.byte 20	 ; Item ID #$23: Helmet of Erdrick

; monster drop rates/items
; indexed data load target (from $97A8)
DropRates:
.byte $FC	 ; Monster ID #$01: Slime; 1/128 chance for #$3C: Medical Herb
.byte $BC	 ; Monster ID #$02: Big Slug; 1/32 chance for #$3C: Medical Herb
.byte $3C	 ; Monster ID #$03: Iron Ant; 1/8 chance for #$3C: Medical Herb
.byte $85	 ; Monster ID #$04: Drakee; 1/32 chance for #$05: Club
.byte $3C	 ; Monster ID #$05: Wild Mouse; 1/8 chance for #$3C: Medical Herb
.byte $B3	 ; Monster ID #$06: Healer; 1/32 chance for #$33: Lottery Ticket
.byte $51	 ; Monster ID #$07: Ghost Mouse; 1/16 chance for #$11: Clothes
.byte $46	 ; Monster ID #$08: Babble; 1/16 chance for #$06: Copper Sword
.byte $7C	 ; Monster ID #$09: Army Ant; 1/16 chance for #$3C: Medical Herb
.byte $01	 ; Monster ID #$0A: Magician; 1/8 chance for #$01: Bamboo Stick
.byte $75	 ; Monster ID #$0B: Big Rat; 1/16 chance for #$35: Wing of the Wyvern
.byte $3B	 ; Monster ID #$0C: Big Cobra; 1/8 chance for #$3B: Antidote Herb
.byte $33	 ; Monster ID #$0D: Magic Ant; 1/8 chance for #$33: Lottery Ticket
.byte $45	 ; Monster ID #$0E: Magidrakee; 1/16 chance for #$05: Club
.byte $55	 ; Monster ID #$0F: Centipod; 1/16 chance for #$15: Leather Armor
.byte $B5	 ; Monster ID #$10: Man O’ War; 1/32 chance for #$35: Wing of the Wyvern
.byte $33	 ; Monster ID #$11: Lizard Fly; 1/8 chance for #$33: Lottery Ticket
.byte $55	 ; Monster ID #$12: Zombie; 1/16 chance for #$15: Leather Armor
.byte $51	 ; Monster ID #$13: Smoke; 1/16 chance for #$11: Clothes
.byte $3C	 ; Monster ID #$14: Ghost Rat; 1/8 chance for #$3C: Medical Herb
.byte $45	 ; Monster ID #$15: Baboon; 1/16 chance for #$05: Club
.byte $73	 ; Monster ID #$16: Carnivog; 1/16 chance for #$33: Lottery Ticket
.byte $1C	 ; Monster ID #$17: Megapede; 1/8 chance for #$1C: Leather Shield
.byte $86	 ; Monster ID #$18: Sea Slug; 1/32 chance for #$06: Copper Sword
.byte $7B	 ; Monster ID #$19: Medusa Ball; 1/16 chance for #$3B: Antidote Herb
.byte $70	 ; Monster ID #$1A: Enchanter; 1/16 chance for #$30: Dragon’s Bane
.byte $74	 ; Monster ID #$1B: Mud Man; 1/16 chance for #$34: Fairy Water
.byte $7C	 ; Monster ID #$1C: Magic Baboon; 1/16 chance for #$3C: Medical Herb
.byte $47	 ; Monster ID #$1D: Demighost; 1/16 chance for #$07: Chain Sickle
.byte $75	 ; Monster ID #$1E: Gremlin; 1/16 chance for #$35: Wing of the Wyvern
.byte $7B	 ; Monster ID #$1F: Poison Lily; 1/16 chance for #$3B: Antidote Herb
.byte $11	 ; Monster ID #$20: Mummy Man; 1/8 chance for #$11: Clothes
.byte $74	 ; Monster ID #$21: Gorgon; 1/16 chance for #$34: Fairy Water
.byte $46	 ; Monster ID #$22: Saber Tiger; 1/16 chance for #$06: Copper Sword
.byte $70	 ; Monster ID #$23: Dragon Fly; 1/16 chance for #$30: Dragon’s Bane
.byte $83	 ; Monster ID #$24: Titan Tree; 1/32 chance for #$03: Wizard’s Wand
.byte $73	 ; Monster ID #$25: Undead; 1/16 chance for #$33: Lottery Ticket
.byte $74	 ; Monster ID #$26: Basilisk; 1/16 chance for #$34: Fairy Water
.byte $FD	 ; Monster ID #$27: Goopi; 1/128 chance for #$3D: Wizard’s Ring
.byte $48	 ; Monster ID #$28: Orc; 1/16 chance for #$08: Iron Spear
.byte $FD	 ; Monster ID #$29: Puppet Man; 1/128 chance for #$3D: Wizard’s Ring
.byte $91	 ; Monster ID #$2A: Mummy; 1/32 chance for #$11: Clothes
.byte $34	 ; Monster ID #$2B: Evil Tree; 1/8 chance for #$34: Fairy Water
.byte $92	 ; Monster ID #$2C: Gas; 1/32 chance for #$12: Clothes Hiding
.byte $FD	 ; Monster ID #$2D: Hork; 1/128 chance for #$3D: Wizard’s Ring
.byte $AF	 ; Monster ID #$2E: Hawk Man; 1/32 chance for #$2F: Gremlin’s Tail
.byte $52	 ; Monster ID #$2F: Sorcerer; 1/16 chance for #$12: Clothes Hiding
.byte $62	 ; Monster ID #$30: Metal Slime; 1/16 chance for #$22: Iron Helmet
.byte $48	 ; Monster ID #$31: Hunter; 1/16 chance for #$08: Iron Spear
.byte $99	 ; Monster ID #$32: Evil Eye; 1/32 chance for #$19: Full Plate Armor
.byte $16	 ; Monster ID #$33: Hibabango; 1/8 chance for #$16: Chain Mail
.byte $06	 ; Monster ID #$34: Graboopi; 1/8 chance for #$06: Copper Sword
.byte $B0	 ; Monster ID #$35: Gold Orc; 1/32 chance for #$30: Dragon’s Bane
.byte $43	 ; Monster ID #$36: Evil Clown; 1/16 chance for #$03: Wizard’s Wand
.byte $07	 ; Monster ID #$37: Ghoul; 1/8 chance for #$07: Chain Sickle
.byte $75	 ; Monster ID #$38: Vampirus; 1/16 chance for #$35: Wing of the Wyvern
.byte $DF	 ; Monster ID #$39: Mega Knight; 1/128 chance for #$1F: Evil Shield
.byte $48	 ; Monster ID #$3A: Saber Lion; 1/16 chance for #$08: Iron Spear
.byte $4A	 ; Monster ID #$3B: Metal Hunter; 1/16 chance for #$0A: Broad Sword
.byte $6F	 ; Monster ID #$3C: Ozwarg; 1/16 chance for #$2F: Gremlin’s Tail
.byte $9F	 ; Monster ID #$3D: Dark Eye; 1/32 chance for #$1F: Evil Shield
.byte $22	 ; Monster ID #$3E: Gargoyle; 1/8 chance for #$22: Iron Helmet
.byte $33	 ; Monster ID #$3F: Orc King; 1/8 chance for #$33: Lottery Ticket
.byte $E1	 ; Monster ID #$40: Magic Vampirus; 1/128 chance for #$21: Mysterious Hat
.byte $4B	 ; Monster ID #$41: Berserker; 1/16 chance for #$0B: Giant Hammer
.byte $31	 ; Monster ID #$42: Metal Babble; 1/8 chance for #$31: Dragon’s Potion
.byte $D0	 ; Monster ID #$43: Hargon’s Knight; 1/128 chance for #$10: Thunder Sword
.byte $B0	 ; Monster ID #$44: Cyclops; 1/32 chance for #$30: Dragon’s Bane
.byte $5E	 ; Monster ID #$45: Attackbot; 1/16 chance for #$1E: Steel Shield
.byte $8C	 ; Monster ID #$46: Green Dragon; 1/32 chance for #$0C: Sword of Destruction
.byte $84	 ; Monster ID #$47: Mace Master; 1/32 chance for #$04: Staff of Thunder
.byte $98	 ; Monster ID #$48: Flame; 1/32 chance for #$18: Magic Armor
.byte $4D	 ; Monster ID #$49: Silver Batboon; 1/16 chance for #$0D: Dragon Killer
.byte $43	 ; Monster ID #$4A: Blizzard; 1/16 chance for #$03: Wizard’s Wand
.byte $0C	 ; Monster ID #$4B: Giant; 1/8 chance for #$0C: Sword of Destruction
.byte $97	 ; Monster ID #$4C: Gold Batboon; 1/32 chance for #$17: Gremlin’s Armor
.byte $BD	 ; Monster ID #$4D: Bullwong; 1/32 chance for #$3D: Wizard’s Ring
.byte $CC	 ; Monster ID #$4E: Atlas; 1/128 chance for #$0C: Sword of Destruction
.byte $E1	 ; Monster ID #$4F: Bazuzu; 1/128 chance for #$21: Mysterious Hat
.byte $44	 ; Monster ID #$50: Zarlox; 1/16 chance for #$04: Staff of Thunder
.byte $E1	 ; Monster ID #$51: Hargon; 1/128 chance for #$21: Mysterious Hat (too bad earlier code says Hargon and Malroth get no drops)
.byte $00	 ; Monster ID #$52: Malroth; No Drop

.res $78

.byte $78,$EE,$DF,$BF,$4C,$86,$FF,$80
.literal "DRAGON WARRIORS2"
.byte $FF,$FF,$00,$00,$48,$04,$01,$0F
.byte $07,$9D,$D8,$BF,$D8,$BF,$D8,$BF

