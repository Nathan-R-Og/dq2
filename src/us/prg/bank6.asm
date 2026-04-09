.segment        "PRG6":absolute
; code bytes:	$2F06 (73.47% of bytes in this ROM bank)
; data bytes:	$10B1 (26.08% of bytes in this ROM bank)
; pcm bytes:	$0000 (0.00% of bytes in this ROM bank)
; chr bytes:	$0000 (0.00% of bytes in this ROM bank)
; free bytes:	$0021 (0.20% of bytes in this ROM bank)
; unknown bytes:	$0028 (0.24% of bytes in this ROM bank)
; $3FB7 bytes last seen in RAM bank $8000 - $BFFF (100.00% of bytes seen in this ROM bank, 99.55% of bytes in this ROM bank):
;	$2F06 code bytes (73.80% of bytes seen in this RAM bank, 73.47% of bytes in this ROM bank)
;	$10B1 data bytes (26.20% of bytes seen in this RAM bank, 26.08% of bytes in this ROM bank)

; PRG Bank 0x06: handlers for main COMMAND menu options (TALK, SPELL, STATUS, ITEM, SEARCH, and EQUIP) including pretty much anything that is required input to or happens as a result of those commands; also includes code and data for gluing together irregularly shaped dungeon maps, starting and saving a game, text for items/spells/monster names, and the ending sequence

; [bank start] -> data
; possible external indexed data load target (from $0F:$F3ED, $0F:$FF28)
; external indirect data load target (via $08:$80CC, $0A:$80F5, $0A:$813E, $0F:$F052, $0F:$F83D)
; possible external indexed data load target (from $0F:$F3F2, $0F:$FF2D)
.addr B06_A612
; external indirect data load target (via $02:$B74E, $0F:$FD25, $0F:$FD98)
.addr B06_A809
; external indirect data load target (via $0F:$C6C7)
.addr B06_A843
; external indirect data load target (via $0F:$C6F9)
; external indirect data load target (via $0F:$D15F, $0F:$D171)
.addr B06_ABC7
.addr B06_A85F
; external indirect data load target (via $0F:$EF5B)
.addr B06_A896
; external indirect data load target (via $0F:$EE09)
.addr B06_A8AA
.addr B06_A8B7
; external indirect data load target (via $0F:$F4E6, $0F:$F5E4, $0F:$F614)
.addr B06_ADFC
; external indirect data load target (via $0F:$F5FA)
.addr B06_AE30
; external indirect data load target (via $0F:$F4AC)
; external indirect data load target (via $0F:$F0BF)
.addr B06_AE3D
.addr B06_AE86
.addr B06_AF7F
.addr B06_AF8E
; external indirect data load target (via $0F:$EE7E)
.addr B06_A88F
; external indirect data load target (via $0F:$C6DA)
.addr B06_A885
; external indirect data load target (via $02:$BEA4)
.addr B06_AE4A
; external indirect data load target (via $0F:$F316)
.addr ItemNames1_1
; external indirect data load target (via $0F:$F317)
.addr ItemNames1_2
; data load target (from $F3AB)
.addr SpellNames
; external indirect data load target (via $0F:$F3DE)
.addr MonsterNames1_1
; external indirect data load target (via $0F:$F3DF)
.addr MonsterNames1_2
.addr CommandTileRedraw
.addr CommandTileRedraw2
; external indirect data load target (via $0F:$F318)
.addr ItemNames2_1
; external indirect data load target (via $0F:$F319)
.addr ItemNames2_2
; external indirect data load target (via $0F:$F3E0)
.addr MonsterNames2_1
; external indirect data load target (via $0F:$F3E1)
; external indirect data load target (via $0F:$C897)
.addr MonsterNames2_2
; external indirect data load target (via $0F:$C889)
.addr B06_BB3D
; external indirect data load target (via $0F:$D359)
.addr B06_BAA3
.addr B06_A61A
; external indirect data load target (via $0F:$CC9E)
.addr B06_BC3D
; external indirect data load target (via $0F:$D2FA)
.addr B06_BC8D
.addr B06_A3E1
.addr B06_BD96
; external indirect data load target (via $0F:$D2EA)
.addr B06_BEED

B06_8048:
    jsr B0F_C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    lda $03 ; game clock?

    and #$0F
    cmp #$01
    beq B06_8059
    jsr B0F_CF64
    jmp B06_8048

B06_8059:
    lda #$FF
    sta $35 ; flag indicating whether any menu is currently open

    lda #$06
    sta $94 ; return bank for various function calls, doubles as index of selected option for multiple-choice menus

    jsr B0F_EB76 ; open menu specified by next byte
    .byte $00

    jsr B0F_EB76 ; open menu specified by next byte
    .byte $06
    cmp #$FF
    bne B06_8077 ; given a main COMMAND menu selection index in A, execute the handler for that menu function

; exit COMMAND menu
B06_806D:
    lda #$01
    jsr B0F_CF6A ; wipe selected menu region

    lda #$00
    sta $35 ; flag indicating whether any menu is currently open

    rts

; given a main COMMAND menu selection index in A, execute the handler for that menu function
B06_8077:
    asl
    tay
    lda B06_8086, y ; COMMAND menu command handler pointers
    sta $0C
    lda B06_8086+1, y
    sta $0C+1
    jmp ($000C)


; COMMAND menu command handler pointers
B06_8086:
.addr B06_80A8 ; COMMAND menu TALK command handler
.addr B06_8B36 ; COMMAND menu SPELL command handler
.addr B06_89CA ; COMMAND menu STATUS command handler
.addr B06_955B ; COMMAND menu ITEM command handler
.addr B06_9B17 ; COMMAND menu SEARCH handler
.addr B06_8A02 ; COMMAND menu EQUIP handler

; wait until all joypad buttons are released and then some button pressed then wipe menus and exit COMMAND menu
B06_8092:
    jsr B06_809D ; wait until all joypad buttons are released and then some button pressed
; wipe menus and exit COMMAND menu
B06_8095:
    lda #$00
    jsr B0F_CF6A ; wipe selected menu region
    jmp B06_806D ; exit COMMAND menu


; wait until all joypad buttons are released and then some button pressed
B06_809D:
    jsr B0F_D13D ; wait for interrupt, read joypad data into $2F and A
    bne B06_809D ; wait until all joypad buttons are released and then some button pressed; loop until no buttons pressed
B06_80A2:
    jsr B0F_D13D ; wait for interrupt, read joypad data into $2F and A
    beq B06_80A2 ; loop until some button pressed
    rts

; COMMAND menu TALK command handler
B06_80A8:
    lda $0540 ; NPC #$00 ? + direction nybble

    and #$03
    jsr B0F_CF70 ; -> $02:$B141

    lda $D0 ; Malroth status flag (#$FF = defeated, #$00 = alive, others = countdown to battle)

    bpl B06_80BF ; pre-Malroth dialogue

    lda $05F3 ; target NPC sprite ID; post-Malroth, most dialogue becomes based on NPC sprite ID

    beq B06_80C3 ; no sprite ID => nobody to talk to

    jsr B0F_D334 ; post-Malroth dialogue

    jmp B06_8092 ; wait until all joypad buttons are released and then some button pressed then wipe menus and exit COMMAND menu


; pre-Malroth dialogue
B06_80BF:
    lda $0C ; dialogue ID

    bne B06_80CA ; #$00 => nobody to talk to

B06_80C3:
    jsr B0F_F6F0 ; open main dialogue window and display string ID specified by byte following JSR + #$0100
    .byte $00
    jmp B06_8092 ; wait until all joypad buttons are released and then some button pressed then wipe menus and exit COMMAND menu


B06_80CA:
    cmp #$D7
    bne B06_80DD
    jsr B06_9ACB ; open dialogue window

    lda #$00 ; Midenhall; useless since string doesn't use [name] control code

    jsr B0F_FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    jsr B0F_FA2A ; display string ID specified by next byte
    .byte $76
    jmp B06_8092 ; wait until all joypad buttons are released and then some button pressed then wipe menus and exit COMMAND menu


B06_80DD:
    cmp #$D9
    bne B06_80EB
    jsr B0F_F6F6 ; open main dialogue window and display string ID specified by byte following JSR + #$0200
    .byte $9A
    jsr B0F_D1E5 ; trigger Fixed Battle #$01: 1 Evil Clown (Map ID #$04: Midenhall B1)

    jmp B06_8095 ; wipe menus and exit COMMAND menu


B06_80EB:
    cmp #$D8
    bne B06_80F6
    jsr B0F_F6EA ; open main dialogue window and display string ID specified by byte following JSR
    .byte $67
    jmp B06_8092 ; wait until all joypad buttons are released and then some button pressed then wipe menus and exit COMMAND menu


B06_80F6:
    cmp #$01
    bne B06_815C
    jsr B06_9ACB ; open dialogue window

    lda #$01 ; Cannock; useless since string doesn't use [name] control code

    jsr B0F_FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $55
    lda #$00
    jsr B0F_FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $56
    lda #$07 ; Music ID #$07: add party member BGM

    jsr B0F_C58D ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM]), wait for it to finish, then play previous BGM

    lda $05C0 ; NPC #$10 motion nybble + direction nybble

    and #$03
    asl
    asl
    asl
    tax
    ldy #$00
B06_811F:
    lda B06_813C, x
    sta $0542, y ; NPC #$00 ?

    iny
    inx
    cpy #$08
    bne B06_811F
    lda #$84 ; add Cannock to party

    sta $063F ; Cannock status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    lda #$FF
    sta $05C1 ; NPC #$10 sprite ID

    lda #$03
    sta $CA ; Cannock runaround quest status (0 = start of game, 0 -> 1 = talked to King Cannock, 1 -> 2 = said YES to seeking Cannock in Spring of Bravery, 2 -> 3 = talked to King Midenhall; adding Cannock sets this to 3; some code checks for 4)

    jmp B06_8092 ; wait until all joypad buttons are released and then some button pressed then wipe menus and exit COMMAND menu

;scripted motion?
B06_813C:
.byte $80,$7F,$00,$01,$00,$00,$00,$01
.byte $70,$6F,$FF,$00,$00,$00,$01,$01
.byte $80,$5F,$00,$FF,$00,$00,$02,$01
.byte $90,$6F,$01,$00,$00,$00,$03,$01

B06_815C:
    cmp #$02
    bne B06_81A2
    jsr B06_9ACB ; open dialogue window

    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $A8
    jsr B06_8172
    lda #$09 ; Sprite ID $#09: Dog

    sta $0551 ; NPC #$02 sprite ID

    jmp B06_8092 ; wait until all joypad buttons are released and then some button pressed then wipe menus and exit COMMAND menu

B06_8172:
    lda $0558 ; NPC #$03 motion nybble + direction nybble

    and #$03
    asl
    asl
    asl
    tax
    ldy #$00
B06_817D:
    lda B06_813C, x
    sta $054A, y ; NPC #$01 scripted motion low byte

    iny
    inx
    cpy #$08
    bne B06_817D
    lda #$FF
    sta $0559 ; NPC #$03 sprite ID

    ldy #$08
    jmp B06_8193 ; useless op

B06_8193:
    jsr B06_8197
    iny
B06_8197:
    lda $0544, y ; NPC #$01 ?
    sec
    sbc $053C, y ; NPC #$00 ?
    sta $0544, y ; NPC #$01 ?
    rts

B06_81A2:
    cmp #$03
    bne B06_81B2
    jsr B0F_F6F6 ; open main dialogue window and display string ID specified by byte following JSR + #$0200
    .byte $4D
    lda #$0C ; Music ID #$0C: game menu / Wellgarth singer BGM

    jsr B0F_C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    jmp B06_8092 ; wait until all joypad buttons are released and then some button pressed then wipe menus and exit COMMAND menu


B06_81B2:
    cmp #$04
    bne B06_81B9
    jmp B06_9734 ; unused since no NPC has dialogue ID #$04


B06_81B9:
    cmp #$05
    bne B06_81C5
    jsr B06_9ACB ; open dialogue window

    lda #$06 ; Save Point ID #$06: Hamlin

    jmp B06_93E3 ; update save point $48 to A, run through the whole save point sequence


B06_81C5:
    cmp #$0A ; useless op

    bcs B06_81C9 ; useless op

B06_81C9:
    cmp #$14
    bcs B06_81D0
    jmp B06_8219 ; handler for dialogue IDs #$0A-#$13 (Innkeepers)


B06_81D0:
    cmp #$1C
    bcs B06_81D7
    jmp DoWeaponShop ; handler for dialogue IDs #$14-#$1B (Weapon Shops)


B06_81D7:
    cmp #$27
    bcs B06_81DE
    jmp B06_839A ; handler for dialogue IDs #$1C-#$26 (Item Shops)


B06_81DE:
    cmp #$28
    bcs B06_81E5
    jmp B06_854E ; handler for dialogue ID #$27 (House of Healing)


B06_81E5:
    cmp #$29
    bcs B06_81EC
    jmp B06_86C0 ; handler for dialogue ID #$28 (Lottery)


B06_81EC:
    cmp #$95
    bcs B06_81F3
    jmp B06_8E06 ; handler for dialogue IDs #$29-#$94 (open dialogue window and display string specified by A + #$1D7, i.e. String IDs #$0200-#$026B)


B06_81F3:
    cmp #$9D
    bcs B06_81FA
    jmp B06_8E44 ; handler for dialogue IDs #$95-#$9C (open dialogue window, display string specified by A + #$1D9, display YES/NO menu, and display string corresponding to selected option)


B06_81FA:
    cmp #$C3
    bcs B06_8201
    jmp B06_8E6A ; handler for dialogue IDs #$9D-#$C2 (town NPCs with complex logic)


B06_8201:
    cmp #$CD
    bcs B06_8208
    jmp B06_94B0 ; handler for dialogue IDs #$C3-#$CC (open dialogue window and display string specified by A - #$73)


B06_8208:
    cmp #$D0
    bcs B06_820F
    jmp B06_94BE ; handler for dialogue IDs #$CD-#$CF (open dialogue window, display string specified by A - #$73, display YES/NO menu, and display string corresponding to selected option)


B06_820F:
    cmp #$D9
    bcs B06_8216
    jmp B06_94E4 ; handler for dialogue IDs #$D0-#$D8 (dungeon NPCs with complex logic)


B06_8216:
    jmp B06_80C3 ; unused since #$D9 was handled earlier and no NPC has dialogue ID > #$D9


; handler for dialogue IDs #$0A-#$13 (Innkeepers)
B06_8219:
    sec
    sbc #$0A ; convert to zero-based
    sta $49 ; object hero/target/item/string ID $49
    tay
    lda InnPrices, y ; Inn prices per party member
    pha ; Inn price per party member
    jsr B0F_F6CE ; return number of party members - 1 in A/X
    sta $0C ; number of party members - 1
    inc $0C ; number of party members
    pla ; Inn price per party member
    jsr B06_86AC ; multiply A by $0C, store results in ($10-$11) and ($8F-$90); consumes $0C
    jsr B0F_F6F0 ; open main dialogue window and display string ID specified by byte following JSR + #$0100
    .byte $7B
    jsr B0F_EB76 ; open menu specified by next byte
    .byte $1B
    jsr B06_9AD0 ; open YES/NO menu, return selected option in A

    cmp #$00 ; YES

    bne B06_829C
    jsr B06_8D31 ; given gold amount in $8F-$90, decrease party gold by that amount and SEC if possible, CLC otherwise

    bcc B06_8298
    jsr B0F_EB76 ; open menu specified by next byte
    .byte $1B
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $7E
    ldx #$14
    jsr B0F_C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

    lda #$FF
    sta $0D
    jsr B0F_C2EB
    lda #$01 ; Music ID #$01: Inn BGM

    jsr B0F_C58D ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM]), wait for it to finish, then play previous BGM

    jsr B06_8DCC ; restore full HP to all living party members

    jsr B06_8DEC ; restore full MP to all living party members

    ldy $49 ; object hero/target/item/string ID $49

    lda B06_82a3, y ; party direction after sleeping at inn (bits 0-1 = Cannock and Moonbrooke direction, 2-3 = Midenhall direction)

    and #$03
    clc
    adc #$05
    sta $45
    jsr B0F_CF76
    ldy $49 ; object hero/target/item/string ID $49

    lda B06_82a3, y ; party direction after sleeping at inn (bits 0-1 = Cannock and Moonbrooke direction, 2-3 = Midenhall direction)

    lsr
    lsr
    sta $0540 ; NPC #$00 ? + direction nybble

    jsr B0F_CF64
    ldy #$00
B06_827F:
    lda B0F_C2E7-1, y
    sta $000D, y
    iny
    cpy #$05
    bne B06_827F
    jsr B0F_C2DE
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $7F
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $80
    jmp B06_8092 ; wait until all joypad buttons are released and then some button pressed then wipe menus and exit COMMAND menu


B06_8298:
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $7D
B06_829C:
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $7C
    jmp B06_8092 ; wait until all joypad buttons are released and then some button pressed then wipe menus and exit COMMAND menu


; party direction after sleeping at inn (bits 0-1 = Cannock and Moonbrooke direction, 2-3 = Midenhall direction)
B06_82a3:
.byte $04	 ; Inn ID #$00, Map IDs #$00/#$03: Fake Midenhall/Midenhall 1F
.byte $04	 ; Inn ID #$01, Map ID #$05: Leftwyne
.byte $0E	 ; Inn ID #$02, Map ID #$06: Cannock
.byte $0C	 ; Inn ID #$03, Map ID #$07: Hamlin
.byte $04	 ; Inn ID #$04, Map ID #$0B: Lianport
.byte $0C	 ; Inn ID #$05, Map ID #$0C: Tantegel
.byte $0C	 ; Inn ID #$06, Map ID #$0F: Osterfair
.byte $0C	 ; Inn ID #$07, Map ID #$10: Zahan
.byte $0F	 ; Inn ID #$08, Map ID #$11: Tuhn / Map ID #$14: Wellgarth Underground
.byte $0C	 ; Inn ID #$09, Map ID #$15: Beran


DoWeaponShop:
; handler for dialogue IDs #$14-#$1B (Weapon Shops)
    sta $49 ; object hero/target/item/string ID $49
    cmp #$18 ; Weapon Shop ID #04, Map ID #$0F: Osterfair
    bne B06_82C3
    lda $05C0 ; NPC #$10 motion nybble + direction nybble
    and #$03
    cmp #$01 ; Right
    beq B06_82C3 ; talking to the shopkeeper from behind the counter, use a different string

    jsr B0F_F6F6 ; open main dialogue window and display string ID specified by byte following JSR + #$0200
    .byte $CE
    jmp B06_8092 ; wait until all joypad buttons are released and then some button pressed then wipe menus and exit COMMAND menu


B06_82C3:
    jsr B0F_F6F0 ; open main dialogue window and display string ID specified by byte following JSR + #$0100
    .byte $5B
    jsr B06_9AD0 ; open YES/NO menu, return selected option in A

    cmp #$00 ; YES

    beq B06_82D5
; finish weapon transaction
B06_82CE:
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $5D
    jmp B06_8092 ; wait until all joypad buttons are released and then some button pressed then wipe menus and exit COMMAND menu


B06_82D5:
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $5C
    lda $49 ; object hero/target/item/string ID $49

    sec
    sbc #$14 ; convert to Shop ID

    jsr B0F_F61B ; display shop menu item list for shop ID given in A, returning selected item (with Jailor's Key replaced by blank) in A

    cmp #$FF
    beq B06_82CE ; finish weapon transaction

    jsr B06_8D4D ; given item ID in A, save it to $96 and set $8F-$90 to purchase price of item, accounting for possible Golden Card discount; decrease party gold by that amount and SEC if possible, CLC otherwise

    bcs B06_82F1 ; branch if price of item was deducted from party gold

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $5E
    jmp B06_835C

B06_82F1:
    jsr B0F_F6CE ; return number of party members - 1 in A/X

    cmp #$00
    bne B06_8306 ; if Midenhall is alone, no need to ask who to give it to

    jsr B06_836D ; given hero ID in A and item ID in $96, try to add item to first empty slot in hero's inventory; if unable to add, refund purchase, pop JSR return address and JMP B06_8092 instead

    lda $96 ; temp storage for item/spell/type/etc. IDs

    sta $95 ; ID for [item] and [spell] control codes

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $5F
    jmp B06_834C

B06_8306:
    lda $96 ; temp storage for item/spell/type/etc. IDs

    sta $95 ; ID for [item] and [spell] control codes

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $62
    jsr B0F_F595 ; display appropriate shop BUY/SELL hero select menu

    cmp #$FF
    bne B06_831B
B06_8315:
    jsr B06_8388 ; add the number at $8F-$90 to party gold; no check for overflow, so this is only safe to use when reverting a sale

    jmp B06_82CE ; finish weapon transaction


B06_831B:
    sta $97 ; subject hero ID $97

    jsr B06_A3A3 ; given item ID in $96 and hero ID in $97, set A to #$80 if hero can equip item, #$00 otherwise

    cmp #$00
    bne B06_8332
    jsr B06_8D25 ; print name of hero given by low 2 bits of $97 to [name] buffer $6119, terminated by #$FA

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $91
    jsr B06_9AD0 ; open YES/NO menu, return selected option in A

    cmp #$00
    bne B06_8315
B06_8332:
    lda $97 ; subject hero ID $97

    jsr B06_836D ; given hero ID in A and item ID in $96, try to add item to first empty slot in hero's inventory; if unable to add, refund purchase, pop JSR return address and JMP B06_8092 instead

    lda #$80 ; Alive

    jsr B06_8D9A ; given hero ID in $97, and status in A, SEC if hero has that status, CLC otherwise

    bcc B06_8348
    jsr B06_8D25 ; print name of hero given by low 2 bits of $97 to [name] buffer $6119, terminated by #$FA

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $63
    jmp B06_834C

B06_8348:
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $64
B06_834C:
    lda #$32 ; Item ID #$32: Golden Card

    jsr B06_A369 ; check for item A in party inventory, returning inventory index of item in A/X if found, #$FF if not

    cmp #$FF
    beq B06_835C
    jsr B06_8D11 ; given item ID in $96 and discount amount in $8F-$90, set $8F-$90 to discounted item price

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $60
B06_835C:
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $61
    jsr B06_9AD0 ; open YES/NO menu, return selected option in A

    cmp #$00 ; YES

    beq B06_836A
    jmp B06_82CE ; finish weapon transaction


B06_836A:
    jmp B06_82D5

; given hero ID in A and item ID in $96, try to add item to first empty slot in hero's inventory; if unable to add, refund purchase, pop JSR return address and JMP B06_8092 instead
B06_836D:
    sta $97 ; subject hero ID $97

    jsr B06_8D7E ; given hero ID in $97 and item ID in $96, try to add item to first empty slot in hero's inventory; SEC if added, CLC if no empty slots

    bcc B06_8379
    jsr B0F_EB76 ; open menu specified by next byte
    .byte $1B
    rts

B06_8379:
    jsr B06_8D25 ; print name of hero given by low 2 bits of $97 to [name] buffer $6119, terminated by #$FA

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $65
    jsr B06_8388 ; add the number at $8F-$90 to party gold; no check for overflow, so this is only safe to use when reverting a sale

    pla
    pla
    jmp B06_8092 ; wait until all joypad buttons are released and then some button pressed then wipe menus and exit COMMAND menu


; add the number at $8F-$90 to party gold; no check for overflow, so this is only safe to use when reverting a sale
B06_8388:
    lda $8F
    clc
    adc $0624 ; party gold, low byte

    sta $0624 ; party gold, low byte

    lda $90
    adc $0625 ; party gold, high byte

    sta $0625 ; party gold, high byte

    rts

; handler for dialogue IDs #$1C-#$26 (Item Shops)
B06_839A:
    sec
    sbc #$14 ; convert to Shop ID

    sta $49 ; object hero/target/item/string ID $49

    jsr B0F_F6F0 ; open main dialogue window and display string ID specified by byte following JSR + #$0100
    .byte $66
    jsr B0F_EB76 ; open menu specified by next byte
    .byte $18
    cmp #$FF
    beq B06_83B2 ; finish item transaction

    cmp #$00 ; BUY

    beq B06_83C4 ; BUY handler

    jmp B06_8485 ; SELL handler


; finish item transaction
B06_83B2:
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $70
    jmp B06_8092 ; wait until all joypad buttons are released and then some button pressed then wipe menus and exit COMMAND menu


B06_83B9:
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $6F
    jsr B06_9AD0 ; open YES/NO menu, return selected option in A

    cmp #$00 ; YES

    bne B06_83B2 ; finish item transaction

; BUY handler
B06_83C4:
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $67
    lda $49 ; object hero/target/item/string ID $49
    ; display shop menu item list for shop ID given in A, returning selected item (with Jailor's Key replaced by blank) in A
    jsr B0F_F61B
    cmp #$FF
    beq B06_83B2 ; finish item transaction
    cmp #$00 ; Jailor's Key converted to #$00
    bne B06_83E2
    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $DA
    jsr B06_9AD0 ; open YES/NO menu, return selected option in A
    cmp #$00 ; YES
    bne B06_83B2 ; finish item transaction
    lda #$39 ; Item ID #$39: Jailor’s Key
B06_83E2:
    jsr B06_8D4D ; given item ID in A, save it to $96 and set $8F-$90 to purchase price of item, accounting for possible Golden Card discount; decrease party gold by that amount and SEC if possible, CLC otherwise
    bcs B06_83EE
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $68
    jmp B06_83B9

B06_83EE:
    jsr B0F_F6CE ; return number of party members - 1 in A/X

    cmp #$00
    bne B06_8414 ; if Midenhall is alone, no need to ask who to give it to

    sta $97 ; subject hero ID $97

    jsr B06_8D7E ; given hero ID in $97 and item ID in $96, try to add item to first empty slot in hero's inventory; SEC if added, CLC if no empty slots

    bcs B06_8409
    jsr B06_8D25 ; print name of hero given by low 2 bits of $97 to [name] buffer $6119, terminated by #$FA

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $6C
; revert sale, finish item transaction
B06_8403:
    jsr B06_8388 ; add the number at $8F-$90 to party gold; no check for overflow, so this is only safe to use when reverting a sale

    jmp B06_83B2 ; finish item transaction


B06_8409:
    lda $96 ; temp storage for item/spell/type/etc. IDs

    sta $95 ; ID for [item] and [spell] control codes

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $69
    jmp B06_8455

B06_8414:
    lda $96 ; temp storage for item/spell/type/etc. IDs

    cmp #$39 ; Item ID #$39: Jailor’s Key

    bne B06_8421
    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $DB
    jmp B06_844a

B06_8421:
    sta $95 ; ID for [item] and [spell] control codes

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $6A
B06_8427:
    jsr B0F_F595 ; display appropriate shop BUY/SELL hero select menu

    cmp #$FF
    bne B06_8431
    jmp B06_8403 ; revert sale, finish item transaction


B06_8431:
    sta $97 ; subject hero ID $97

    jsr B06_8D7E ; given hero ID in $97 and item ID in $96, try to add item to first empty slot in hero's inventory; SEC if added, CLC if no empty slots

    bcs B06_8451
    jsr B06_8D25 ; print name of hero given by low 2 bits of $97 to [name] buffer $6119, terminated by #$FA

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $6C
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $6D
    jsr B06_9AD0 ; open YES/NO menu, return selected option in A

    cmp #$00 ; YES

    bne B06_8403 ; revert sale, finish item transaction

B06_844a:
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $6E
    jmp B06_8427

B06_8451:
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $6B
B06_8455:
    jsr B0F_EB76 ; open menu specified by next byte
    .byte $1B
    lda #$32 ; Item ID #$32: Golden Card

    jsr B06_A369 ; check for item A in party inventory, returning inventory index of item in A/X if found, #$FF if not

    cmp #$FF
    beq B06_846C
    jsr B06_8D11 ; given item ID in $96 and discount amount in $8F-$90, set $8F-$90 to discounted item price

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $71
B06_8469:
    jmp B06_83B9

B06_846C:
    jsr B0F_C3AB ; generate a random number and store it in $32-$33 (two passes)

    lda $32 ; RNG byte 0

    cmp #$2B ; odds of getting a Lottery Ticket = 43/256

    bcs B06_8469
    lda #$33 ; Item ID #$33: Lottery Ticket

    sta $96 ; temp storage for item/spell/type/etc. IDs

    jsr B06_8D7E ; given hero ID in $97 and item ID in $96, try to add item to first empty slot in hero's inventory; SEC if added, CLC if no empty slots

    bcc B06_8469
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $9D
    jmp B06_83B9

; SELL handler
B06_8485:
    jsr B0F_F6CE ; return number of party members - 1 in A/X

    cmp #$00
    beq B06_849A ; if Midenhall is alone, no need to ask who's selling

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $72
    jsr B0F_F595 ; display appropriate shop BUY/SELL hero select menu

    cmp #$FF
    bne B06_849A
    jmp B06_83B2 ; finish item transaction


B06_849A:
    sta $97 ; subject hero ID $97

B06_849C:
    lda $97 ; subject hero ID $97

    asl ; 8 inventory items per hero

    asl
    asl
    tay ; hero inventory read index

    ldx #$08 ; 8 inventory items per hero; loop counter

B06_84A4:
    lda $0600, y ; Midenhall inventory item 1 (| #$40 if equipped)

    bne B06_84B7
    iny ; hero inventory read index

    dex ; loop counter

    bne B06_84A4
    jsr B06_8D25 ; print name of hero given by low 2 bits of $97 to [name] buffer $6119, terminated by #$FA

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $73
; finish item transaction
B06_84B4:
    jmp B06_83B2 ; finish item transaction


B06_84B7:
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $74
    jsr B0F_EB76 ; open menu specified by next byte
    .byte $1B
    lda $97 ; subject hero ID $97

    jsr B0F_F5FE ; given a hero ID in A, open hero's item list and return selected item ID (or #$FE if they have no items)

    stx $49 ; object hero/target/item/string ID $49

    pha ; item ID

    lda #$03
    jsr B0F_CF6A ; wipe selected menu region

    pla ; item ID

    cmp #$FF
    beq B06_84B4 ; finish item transaction

    sta $96 ; temp storage for item/spell/type/etc. IDs; item ID

    and #$3F ; strip off the equipped bit

    asl
    tay
    lda ItemPrices, y ; Item Prices, low byte
    sta $8F
    lda ItemPrices+1, y ; Item Prices, high byte
    sta $90
    lsr $90 ; LSR 16-bit $8F-$90
    ror $8F
    lsr $90 ; LSR 16-bit $8F-$90
    ror $8F
    lda ItemPrices, y ; Item Prices, low byte
    sec
    sbc $8F
    sta $8F
    lda ItemPrices+1, y ; Item Prices, high byte
    sbc $90
    sta $90 ; at this point item sell price is 75% of base price

    lda $8F ; check if sell price is zero

    ora $90
    bne B06_8510 ; sell price of zero => key item

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $75
B06_8502:
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $79
    jsr B06_9AD0 ; open YES/NO menu, return selected option in A

    cmp #$00 ; YES

    bne B06_84B4 ; finish item transaction

    jmp B06_849C

B06_8510:
    lda $96 ; temp storage for item/spell/type/etc. IDs

    sta $95 ; ID for [item] and [spell] control codes

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $76
    jsr B06_9AD0 ; open YES/NO menu, return selected option in A

    cmp #$00 ; YES

    beq B06_8526
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $77
    jmp B06_8502

B06_8526:
    ldx $49 ; object hero/target/item/string ID $49

    jsr B06_8B0F ; given hero ID in $97 and hero inventory index in X, return corresponding item ID in A and party inventory index in X

    txa ; don't care about the item ID, just want the party inventory ID

    tay
    jsr B06_8B23 ; given party inventory index in Y, CLC and return equipped item ID in A if corresponding item is equipped and cursed, SEC and return unequipped item ID in A otherwise

    bcc B06_8547
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $78
    jsr B06_8CF5 ; add $8F-$90 to party gold, capped at $FFFF

    lda $97 ; subject hero ID $97

    ldx $49 ; object hero/target/item/string ID $49

    jsr B0F_C4D4 ; given hero ID in A and hero inventory offset in X, remove that item from hero's inventory and move all lower items up 1 slot

    jsr B0F_EB76 ; open menu specified by next byte
    .byte $1B
    jmp B06_8502

B06_8547:
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $7A
    jmp B06_8502

; handler for dialogue ID #$27 (House of Healing)
B06_854E:
    sec
    sbc #$27 ; LDA #$00 would have been shorter and faster

    sta $49 ; object hero/target/item/string ID $49

    jsr B0F_F6F0 ; open main dialogue window and display string ID specified by byte following JSR + #$0100
    .byte $81
B06_8557:
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $82
    jsr B0F_EB76 ; open menu specified by next byte
    .byte $1A
    cmp #$FF
    bne B06_8577
; finish conversation
B06_8563:
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $88
    jmp B06_8092 ; wait until all joypad buttons are released and then some button pressed then wipe menus and exit COMMAND menu


; repeat service loop
B06_856A:
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $87
    jsr B06_9AD0 ; open YES/NO menu, return selected option in A

    cmp #$00 ; YES

    beq B06_8557
    bne B06_8563 ; finish conversation

B06_8577:
    cmp #$00 ; DETOXICATE

    beq B06_857E ; DETOXICATE handler

    jmp B06_85C0

; DETOXICATE handler
B06_857E:
    jsr B0F_F6CE ; return number of party members - 1 in A/X

    cmp #$00
    beq B06_8590 ; if Midenhall is alone, no need to ask for target hero

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $83
    jsr B0F_F595 ; display appropriate shop BUY/SELL hero select menu

    cmp #$FF
    beq B06_8563 ; finish conversation

B06_8590:
    sta $97 ; subject hero ID $97

    lda #$20 ; Poison

    jsr B06_8D9A ; given hero ID in $97, and status in A, SEC if hero has that status, CLC otherwise

    bcs B06_85A3
    jsr B06_8D25 ; print name of hero given by low 2 bits of $97 to [name] buffer $6119, terminated by #$FA

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $84
    jmp B06_856A ; repeat service loop


B06_85A3:
    lda #$02 ; DETOXICATE fee is hero level * 2

    jsr B06_86a4 ; given hero ID in $97, multiply A by that hero's level, store results in ($10-$11) and ($8F-$90); consumes $0C

    jsr B06_8679 ; try to collect payment for House of Healing service; refusal or insufficient gold pops JSP return address and jumps to repeat service loop at $06:B06_856A

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $86
    jsr B0F_C515 ; flash screen 10 times

    jsr B06_8DAA ; given hero ID in $97, set Y to start of hero's data in $062D, y, i.e. Y = $97 * #$12

    lda $062D, y ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    and #$DF ; clear Poison

    sta $062D, y ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    jmp B06_856A ; repeat service loop


B06_85C0:
    cmp #$01 ; UNCURSE
    beq B06_85C7 ; UNCURSE handler
    jmp B06_8620 ; REVIVAL handler


; UNCURSE handler
B06_85C7:
    jsr B0F_F6CE ; return number of party members - 1 in A/X

    cmp #$00
    beq B06_85DC ; if Midenhall is alone, no need to ask for target hero

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $8B
    jsr B0F_F595 ; display appropriate shop BUY/SELL hero select menu

    cmp #$FF
    bne B06_85DC
    jmp B06_8563 ; finish conversation


B06_85DC:
    sta $97 ; subject hero ID $97

    lda #$04 ; there are 4 cursed items in the game

    sta $0C
B06_85E2:
    ldy $0C
    lda B06_861C-1, y ; list of cursed items (equipped), built in offset from $861C

    jsr B06_8DBA ; given a hero ID in $97 and an item ID in A, SEC if hero has that item, CLC otherwise

    bcs B06_85FA
    dec $0C
    bne B06_85E2 ; loop to check next cursed item

    jsr B06_8D25 ; print name of hero given by low 2 bits of $97 to [name] buffer $6119, terminated by #$FA

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $8C
    jmp B06_856A ; repeat service loop


B06_85FA:
    lda #$64 ; UNCURSE fee is hero level * 100

    jsr B06_86a4 ; given hero ID in $97, multiply A by that hero's level, store results in ($10-$11) and ($8F-$90); consumes $0C

    jsr B06_8679 ; try to collect payment for House of Healing service; refusal or insufficient gold pops JSP return address and jumps to repeat service loop at $06:B06_856A

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $8D
    jsr B0F_C515 ; flash screen 10 times

    lda #$04 ; there are 4 cursed items in the game

    sta $0C
B06_860D:
    ldy $0C
    lda B06_861C-1, y ; list of cursed items (equipped), built in offset from $861C

    jsr B06_8DC3 ; given a hero ID in $97 and an item ID in A, remove that item from hero's inventory if present and SEC, CLC otherwise

    dec $0C
    bne B06_860D ; loop to keep removing cursed items

; list of cursed items (equipped), built in offset from $861C
; indexed data load target (from $85E4, $860F, $8AC8)
    jmp B06_856A ; repeat service loop



; list of equipped cursed items
B06_861C:
.byte $6F	 ; Item ID #$6F: Gremlin’s Tail (equipped)
.byte $4C	 ; Item ID #$4C: Sword of Destruction (equipped)
.byte $57	 ; Item ID #$57: Gremlin’s Armor (equipped)
.byte $5F	 ; Item ID #$5F: Evil Shield (equipped)


; REVIVAL handler
B06_8620:
    jsr B0F_F6CE ; return number of party members - 1 in A/X

    cmp #$00 ; if Midenhall is alone, no need to ask for target hero

    beq B06_8635
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $8E
    jsr B0F_F595 ; display appropriate shop BUY/SELL hero select menu

    cmp #$FF
    bne B06_8635
    jmp B06_8563 ; finish conversation


B06_8635:
    sta $97 ; subject hero ID $97

    lda #$80 ; Alive

    jsr B06_8D9A ; given hero ID in $97, and status in A, SEC if hero has that status, CLC otherwise

    bcc B06_8648
    jsr B06_8D25 ; print name of hero given by low 2 bits of $97 to [name] buffer $6119, terminated by #$FA

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $8F
    jmp B06_856A ; repeat service loop


B06_8648:
    lda #$14 ; REVIVAL fee is hero level * 20

    jsr B06_86a4 ; given hero ID in $97, multiply A by that hero's level, store results in ($10-$11) and ($8F-$90); consumes $0C

    jsr B06_8679 ; try to collect payment for House of Healing service; refusal or insufficient gold pops JSP return address and jumps to repeat service loop at $06:B06_856A

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $90
    lda #$02 ; Music ID #$02: revive BGM

    jsr B0F_C58D ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM]), wait for it to finish, then play previous BGM

    jsr B06_8DAA ; given hero ID in $97, set Y to start of hero's data in $062D, y, i.e. Y = $97 * #$12

    lda $062D, y ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    ora #$80 ; Alive

    sta $062D, y ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    lda #$01 ; revived with 1 HP

    sta $063B, y ; Midenhall Current HP, low byte

    jsr B0F_D302
    jsr B0F_C22C
    jmp B06_856A ; repeat service loop


    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $91
    jmp B06_867D

; try to collect payment for House of Healing service; refusal or insufficient gold pops JSP return address and jumps to repeat service loop at $06:B06_856A
B06_8679:
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $85
B06_867D:
    jsr B0F_EB76 ; open menu specified by next byte
    .byte $1B
    jsr B06_9AD0 ; open YES/NO menu, return selected option in A

    cmp #$00 ; YES

    bne B06_8694
    jsr B06_8D31 ; given gold amount in $8F-$90, decrease party gold by that amount and SEC if possible, CLC otherwise

    bcc B06_869D
    jsr B0F_EB76 ; open menu specified by next byte
    .byte $1B
    jmp B06_8D25 ; print name of hero given by low 2 bits of $97 to [name] buffer $6119, terminated by #$FA


B06_8694:
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $89
B06_8698:
    pla
    pla
    jmp B06_856A ; repeat service loop


B06_869D:
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $8A
    jmp B06_8698

; given hero ID in $97, multiply A by that hero's level, store results in ($10-$11) and ($8F-$90); consumes $0C
B06_86a4:
    sta $0C
    jsr B06_8DAA ; given hero ID in $97, set Y to start of hero's data in $062D, y, i.e. Y = $97 * #$12

    lda $063E, y ; Midenhall Level

; multiply A by $0C, store results in ($10-$11) and ($8F-$90); consumes $0C
B06_86AC:
    sta $0E
    lda #$00
    sta $0D
    sta $0F
    jsr B0F_C339 ; 16-bit multiplication: ($10-$11) = ($0C-$0D) * ($0E-$0F); consumes $0C-$0F

    lda $10
    sta $8F
    lda $11
    sta $90
    rts

; handler for dialogue ID #$28 (Lottery)
B06_86C0:
    jsr B0F_F6F0 ; open main dialogue window and display string ID specified by byte following JSR + #$0100
    .byte $94
    jsr B06_9AD0 ; open YES/NO menu, return selected option in A

    cmp #$00 ; YES

    beq B06_86D5
; finish lottery conversation
B06_86CB:
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $95
    jsr B06_8905
    jmp B06_8092 ; wait until all joypad buttons are released and then some button pressed then wipe menus and exit COMMAND menu


B06_86D5:
    lda #$33 ; Item ID #$33: Lottery Ticket

    jsr B06_A369 ; check for item A in party inventory, returning inventory index of item in A/X if found, #$FF if not

    cmp #$FF
    bne B06_86E5
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $96
    jmp B06_86CB ; finish lottery conversation


B06_86E5:
    lsr ; convert party inventory index to hero ID

    lsr
    lsr
    sta $97 ; subject hero ID $97

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $97
    jsr B06_9AD0 ; open YES/NO menu, return selected option in A

    cmp #$00 ; YES

    bne B06_86F9
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $98
B06_86F9:
    jsr B06_8744
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $99
    jsr B06_8778
    cmp #$05
    bne B06_870E
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $9C
    jmp B06_86CB ; finish lottery conversation


B06_870E:
    sta $8F ; prize number

    lda #$00
    sta $90
    lda #$33 ; Item ID #$33: Lottery Ticket

    jsr B06_8DC3 ; given a hero ID in $97 and an item ID in A, remove that item from hero's inventory if present and SEC, CLC otherwise

    lda $8F
    cmp #$FF
    bne B06_8726
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $9B
    jmp B06_86CB ; finish lottery conversation


B06_8726:
    tay
    lda B06_873F, y ; Lottery prizes

    sta $96 ; temp storage for item/spell/type/etc. IDs

    sta $95 ; ID for [item] and [spell] control codes

    jsr B06_8D7E ; given hero ID in $97 and item ID in $96, try to add item to first empty slot in hero's inventory; SEC if added, CLC if no empty slots

    inc $8F
    lda #$06 ; Music ID #$06: lottery win BGM

    jsr B0F_C58D ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM]), wait for it to finish, then play previous BGM

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $9A
    jmp B06_86CB ; finish lottery conversation



; Lottery prizes
B06_873F:
.byte $32	 ; Item ID #$32: Golden Card
.byte $3D	 ; Item ID #$3D: Wizard’s Ring
.byte $03	 ; Item ID #$03: Wizard’s Wand
.byte $30	 ; Item ID #$30: Dragon’s Bane
.byte $3C	 ; Item ID #$3C: Medical Herb

B06_8744:
    jsr B0F_C3AB ; generate a random number and store it in $32-$33 (two passes)

    lda $32 ; RNG byte 0

    lsr
    and #$78
    sta $DD
    ldx #$00
    jsr B06_8878
    lda $32 ; RNG byte 0

    asl
    asl
    asl
    and #$78
    sta $DF
    ldx #$08
    jsr B06_8878
    lda $33 ; RNG byte 1

    and #$78
    sta $E1
    ldx #$10
    jsr B06_8878
    lda #$00
    sta $DE
    sta $E0
    sta $E2
    jsr B06_895B
    rts

B06_8778:
    lda #$00
    sta $DC
    lda $2F ; joypad 1 data

    and #$01
    sta $DA
B06_8782:
    lda $DC
    and #$07
    cmp #$07
    beq B06_87A7
B06_878A:
    jsr B06_891F
    eor $DC
    lsr
    bcc B06_8794
    inc $DC
B06_8794:
    lda $DC
    lsr
    and #$03
    beq B06_878A
    bcc B06_87A7
    asl
    tax
    dex
    dex
    lda $DE, x
    ora #$40
    sta $DE, x
B06_87A7:
    ldx #$00
B06_87A9:
    stx $D5
    txa
    asl
    asl
    sta $D6
    lda $DD, x
    sta $D7
    lda $DE, x
    sta $D8
    jsr B06_881A
    ldx $D5
    lda $D7
    sta $DD, x
    lda $D8
    sta $DE, x
    inx
    inx
    cpx #$06
    bne B06_87A9
    jsr B06_895B
    lda $DE
    and $E0
    and $E2
    asl
    bcc B06_8782
    ldx #$05
    lda #$00
B06_87DB:
    sta $0662, x ; Moonbrooke Level

    dex
    bne B06_87DB
    ldy #$00
B06_87E3:
    ldx $DD, y
    txa
    lsr
    lsr
    lsr
    and #$0F
    sta $D5
    tya
    asl
    asl
    asl
    ora $D5
    tax
    lda B06_88D5, x
    tax
    inc $0663, x ; monster ID, group 1

    iny
    iny
    cpy #$06
    bne B06_87E3
    ldx #$00
B06_8803:
    lda $0663, x ; monster ID, group 1

    cmp #$03
    beq B06_8815
    cmp #$02
    beq B06_8817
    inx
    cpx #$05
    bne B06_8803
    ldx #$FF
B06_8815:
    txa
    rts

B06_8817:
    lda #$05
    rts

B06_881A:
    lda $D8
    bmi B06_886F
    and #$07
    bne B06_886D
    inc $D7
    jsr B06_887C
    lda $D7
    and #$07
    bne B06_8859
    lda #$85 ; Music ID #$85: single beep SFX

    jsr B0F_C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    lda $D8
    and #$78
    cmp #$40
    bcc B06_8859
    cmp #$78
    bcs B06_8852
    clc
    adc #$08
    sta $D8
    and #$20
    beq B06_8859
    jsr B0F_C3AB ; generate a random number and store it in $32-$33 (two passes)

    lda $32 ; RNG byte 0

    eor $D8
    and #$18
    bne B06_8859
B06_8852:
    lda $D8
    ora #$80
    sta $D8
    rts

B06_8859:
    lda $D8
    and #$78
    sta $D8
    lsr
    lsr
    lsr
    and #$07
    tax
    lda B06_8870, x
    ora $D8
    sta $D8
    rts

B06_886D:
    dec $D8
B06_886F:
    rts


B06_8870:
.byte $00,$01,$01,$02,$02,$03,$04,$07

B06_8878:
    stx $D6
    sta $D7
B06_887C:
    lda $D6
    asl
    sta $D9
    lda $D7
    lsr
    lsr
    lsr
    and #$0F
    ora $D9
    tax
    lda $D7
    and #$07
    sta $D9
    lda B06_88D5, x
    asl
    asl
    asl
    clc
    adc $D9
    tax
    ldy $D6
B06_889D:
    lda B06_89A2, x
    sta $0663, y ; monster ID, group 1

    iny
    inx
    txa
    and #$07
    bne B06_889D
    lda $D9
    beq B06_88D4
    lda $D6
    asl
    sta $D9
    lda $D7
    lsr
    lsr
    lsr
    clc
    adc #$01
    and #$0F
    ora $D9
    tax
    lda B06_88D5, x
    asl
    asl
    asl
    tax
B06_88C7:
    lda B06_89A2, x
    sta $0663, y ; monster ID, group 1

    inx
    iny
    tya
    and #$07
    bne B06_88C7
B06_88D4:
    rts

B06_88D5:
.byte $04,$03,$02,$04,$00,$04,$01,$04,$02,$03,$04,$01,$03,$04,$02,$03
.byte $02,$04,$03,$01,$04,$00,$02,$04,$01,$03,$04,$03,$01,$04,$00,$04
.byte $04,$00,$04,$02,$01,$04,$03,$02,$04,$03,$01,$04,$02,$03,$04,$03

B06_8905:
    jsr B0F_C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    lda $02
    bne B06_8905
    lda #$05
    sta $08
    lda B06_891D
    sta $D7
    lda B06_891D+1
    sta $D8
    jmp B06_8973


B06_891D:
.addr B06_89A2

B06_891F:
    ldx #$20
    lda $DC
    and #$06
    bne B06_892E
    sta $DB
    jsr B0F_C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    ldx #$08
B06_892E:
    stx $DB
    jsr B0F_C476 ; read joypad 1 data into $2F

    lda $2F ; joypad 1 data

    eor $DA
    lsr
    bcc B06_8941
    lda $2F ; joypad 1 data

    and #$01
    sta $DA
    rts

B06_8941:
    lda $DC
    clc
    adc #$08
    sta $DC
    bcc B06_895A
    inc $DA
    inc $DA
    lda $DA
    cmp $DB
    bcc B06_895A
    eor #$01
    and #$01
    sta $DA
B06_895A:
    rts

B06_895B:
    lda $02
    beq B06_8965
    jsr B0F_C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    jmp B06_895B

B06_8965:
    lda #$05
    sta $08
    lda B06_898C
    sta $D7
    lda B06_898C+1
    sta $D8
B06_8973:
    lda #$A0
    ldy #$00
    jsr B06_898E
    lda #$B0
    ldy #$08
    jsr B06_898E
    lda #$C0
    ldy #$10
    jsr B06_898E
    jsr B0F_C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    rts


B06_898C:
.addr $0663

B06_898E:
    sta $07
B06_8990:
    sty $D5
    lda ($D7), y
    sta $09
    jsr B0F_C1FA ; wait for $02 to not be #$C0, write PPU address in $07-$08 and data in $09 to PPU write buffer at $0300,$02, $01 += 1, $02 += 3, and set $0183 to #$00

    ldy $D5
    iny
    tya
    and #$07
    bne B06_8990
    rts


B06_89A2:
.byte $10,$82,$38,$7C,$7C,$38,$82,$10
.byte $10,$10,$FE,$7C,$38,$7C,$6C,$82
.byte $70,$38,$1C,$1C,$1C,$1C,$38,$70
.byte $10,$10,$38,$7C,$FE,$FE,$FE,$7C
.byte $00,$6C,$FE,$FE,$7C,$7C,$38,$10

B06_89CA:
; COMMAND menu STATUS command handler
    jsr B0F_F537 ; display hero select STATUS menu if necessary

    cmp #$FF
    bne B06_89D4
    jmp B06_806D ; exit COMMAND menu


B06_89D4:
    sta $97 ; subject hero ID $97

    jsr B0F_F497 ; display Menu ID #$03: Main menu: selected hero's status

    jsr B06_809D ; wait until all joypad buttons are released and then some button pressed

    jsr B0F_F492 ; display Menu ID #$02: Main menu: gold/crests

    lda $97 ; subject hero ID $97

    jsr B0F_F63B ; display Menu ID #$1C: Main menu: status screen equipped items

    dec $97 ; subject hero ID $97

    bmi B06_89FF ; Midenhall has no magic, so no need to show spell lists

    ldx $97 ; subject hero ID $97

    lda $0618, x ; Cannock's learned battle spell list

    ora $061A, x ; Cannock's learned field spell list

    beq B06_89FF ; if casters haven't learned any spell yet (which is impossible), no need to show spell lists

    jsr B06_809D ; wait until all joypad buttons are released and then some button pressed

    lda #$85 ; Music ID #$85: single beep SFX

    jsr B0F_C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    lda $97 ; subject hero ID $97

    jsr B0F_F64E ; display spell lists

B06_89FF:
    jmp B06_8092 ; wait until all joypad buttons are released and then some button pressed then wipe menus and exit COMMAND menu

B06_8A02:
; COMMAND menu EQUIP handler
    jsr B0F_F56B ; display appropriate main EQUIP hero select menu

    cmp #$FF
    bne B06_8A0C
    jmp B06_806D ; exit COMMAND menu


B06_8A0C:
    sta $97 ; subject hero ID $97

    lda #$00
    sta $49 ; object hero/target/item/string ID $49; EQUIP sub-type

    sta $A5
    lda #$00
    jsr B0F_CF6A ; wipe selected menu region

B06_8A19:
    ldx $49 ; object hero/target/item/string ID $49

    lda $97 ; subject hero ID $97

    jsr B0F_F5A3 ; given a hero ID in A and an item type in X, display the EQUIP sub-menu for hero A and item type X, returning the selected item ID in A

    sta $96 ; temp storage for item/spell/type/etc. IDs; new item to equip

B06_8A22:
    cmp #$FF
    bne B06_8A3E
    dec $49 ; object hero/target/item/string ID $49

    bmi B06_8A3B
B06_8A2A:
    ldx $49 ; object hero/target/item/string ID $49

    lda $97 ; subject hero ID $97

    jsr B0F_F5A3 ; given a hero ID in A and an item type in X, display the EQUIP sub-menu for hero A and item type X, returning the selected item ID in A

    sta $96 ; temp storage for item/spell/type/etc. IDs; new item to equip

    cmp #$FE
    bne B06_8A22
    dec $49 ; object hero/target/item/string ID $49

    bpl B06_8A2A
B06_8A3B:
    jmp B06_8AFF ; wait #$14 interrupts, update each hero's stats based on their current EXP, wipe menu and exit COMMAND menu


B06_8A3E:
    cmp #$FE
    bne B06_8A62
    jmp B06_8AE3

B06_8A45:
    and #$3F ; strip off the equipped bit

    sta $95 ; ID for [item] and [spell] control codes

    jsr B0F_F6F0 ; open main dialogue window and display string ID specified by byte following JSR + #$0100
    .byte $12
B06_8A4D:
    lda #$0A ; Music ID #$0A: cursed BGM

    jsr B0F_C58D ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM]), wait for it to finish, then play previous BGM

    jmp B06_8A5A

B06_8A55:
    ldx #$50
    jsr B0F_C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

B06_8A5A:
    lda #$05
    jsr B0F_CF6A ; wipe selected menu region

    jmp B06_8AE3

B06_8A62:
    inc $A5
    stx $12
    ldx $49 ; object hero/target/item/string ID $49

    lda B0F_F757, x ; table of first item IDs for each item type

    sta $0E ; lowest item ID of current item type

    lda B0F_F757+1, x
    sta $0F ; lowest item ID of next item type

    jsr B06_8B1D ; set A to hero ID in $97 * 8

    tay
    lda #$08 ; 8 inventory slots per hero

    sta $0C ; number of invetory slots left to check

B06_8A7A:
    lda $0600, y ; Midenhall inventory item 1 (| #$40 if equipped)

    beq B06_8A91
    and #$3F ; strip off the equipped bit

    cmp $0E ; lowest item ID of current item type

    bcc B06_8A91
    cmp $0F ; lowest item ID of next item type

    bcs B06_8A91
    jsr B06_8B23 ; given party inventory index in Y, CLC and return equipped item ID in A if corresponding item is equipped and cursed, SEC and return unequipped item ID in A otherwise

    bcc B06_8A45
    sta $0600, y ; Midenhall inventory item 1 (| #$40 if equipped); note that this unequips the item!

B06_8A91:
    iny
    dec $0C ; number of invetory slots left to check

    bne B06_8A7A
    lda $96 ; temp storage for item/spell/type/etc. IDs

    beq B06_8AE3
    cmp #$FF
    beq B06_8AE3
    ldx $12
    jsr B06_8B0F ; given hero ID in $97 and hero inventory index in X, return corresponding item ID in A and party inventory index in X

    and #$3F ; strip off the equipped bit

    sta $96 ; temp storage for item/spell/type/etc. IDs

    sta $95 ; ID for [item] and [spell] control codes

    jsr B06_A3A3 ; given item ID in $96 and hero ID in $97, set A to #$80 if hero can equip item, #$00 otherwise

    cmp #$00
    bne B06_8ABF
    jsr B06_9ACB ; open dialogue window

    jsr B06_8D25 ; print name of hero given by low 2 bits of $97 to [name] buffer $6119, terminated by #$FA

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $92
    dec $49 ; object hero/target/item/string ID $49

    jmp B06_8A55

B06_8ABF:
    lda $96 ; temp storage for item/spell/type/etc. IDs

; equip item
    ora #$40
    sta $0600, x ; Midenhall inventory item 1 (| #$40 if equipped)

    ldy #$04 ; there are 4 cursed item in the game

B06_8AC8:
    cmp B06_861C-1, y ; list of cursed items (equipped), built in offset from $861C

    beq B06_8AD2
    dey
    bne B06_8AC8
    beq B06_8AE3
B06_8AD2:
    and #$3F ; strip off the equipped bit

    sta $95 ; ID for [item] and [spell] control codes

    jsr B06_9ACB ; open dialogue window

    jsr B06_8D25 ; print name of hero given by low 2 bits of $97 to [name] buffer $6119, terminated by #$FA

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $11
    jmp B06_8A4D

B06_8AE3:
    inc $49 ; object hero/target/item/string ID $49

    lda $49 ; object hero/target/item/string ID $49

    cmp #$04 ; there are 4 EQUIP item types

    beq B06_8AEE
    jmp B06_8A19

B06_8AEE:
    lda $A5
    bne B06_8AFF ; wait #$14 interrupts, update each hero's stats based on their current EXP, wipe menu and exit COMMAND menu

    jsr B06_9ACB ; open dialogue window

    jsr B06_8D25 ; print name of hero given by low 2 bits of $97 to [name] buffer $6119, terminated by #$FA

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $A0
    jmp B06_8092 ; wait until all joypad buttons are released and then some button pressed then wipe menus and exit COMMAND menu


; wait #$14 interrupts, update each hero's stats based on their current EXP, wipe menu and exit COMMAND menu
B06_8AFF:
    ldx #$14
    jsr B0F_C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

    jsr B0F_D0EC ; update each hero's stats based on their current EXP

    lda #$07
    jsr B0F_CF6A ; wipe selected menu region

    jmp B06_806D ; exit COMMAND menu


; given hero ID in $97 and hero inventory index in X, return corresponding item ID in A and party inventory index in X
B06_8B0F:
    jsr B06_8B1D ; set A to hero ID in $97 * 8

    sta $0C
    txa
    clc
    adc $0C
    tax
    lda $0600, x ; Midenhall inventory item 1 (| #$40 if equipped)

    rts

; set A to hero ID in $97 * 8
B06_8B1D:
    lda $97 ; subject hero ID $97

    asl
    asl
    asl
    rts

; given party inventory index in Y, CLC and return equipped item ID in A if corresponding item is equipped and cursed, SEC and return unequipped item ID in A otherwise
B06_8B23:
    lda $0600, y ; Midenhall inventory item 1 (| #$40 if equipped)

    ldx #$03 ; max index of list of cursed items in the game

B06_8B28:
    cmp $861C, x ; list of equipped cursed items

    beq B06_8B34
    dex
    bpl B06_8B28
    and #$3F
    sec
    rts

B06_8B34:
    clc
    rts

; COMMAND menu SPELL command handler
B06_8B36:
    jsr B0F_F545 ; depending on number of casters in party, maybe open caster select menu

    cmp #$FF
    bne B06_8B40 ; did not cancel menu

; exit COMMAND menu
B06_8B3D:
    jmp B06_806D ; exit COMMAND menu


; did not cancel menu
B06_8B40:
    sta $97 ; subject hero ID $97; caster hero ID

    cmp #$FE
    bne B06_8B55 ; hero is a caster

    jsr B06_9ACB ; open dialogue window

    lda #$00 ; Midenhall

    jsr B0F_FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $01
    jmp B06_8092 ; wait until all joypad buttons are released and then some button pressed then wipe menus and exit COMMAND menu


; hero is a caster
B06_8B55:
    lda #$80 ; Alive

    jsr B06_8D9A ; given hero ID in $97, and status in A, SEC if hero has that status, CLC otherwise

    bcs B06_8B69 ; caster is alive

    jsr B06_9ACB ; open dialogue window

    jsr B06_8D25 ; print name of hero given by low 2 bits of $97 to [name] buffer $6119, terminated by #$FA

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $02
    jmp B06_8092 ; wait until all joypad buttons are released and then some button pressed then wipe menus and exit COMMAND menu


; caster is alive
B06_8B69:
    lda $97 ; subject hero ID $97; caster hero ID

    sec
    sbc #$01 ; Midenhall can't use magic and $0F:B0F_F5EC wants hero ID - 1
    jsr B0F_F5EC ; given hero ID - 1 in A, open hero's spell list and return selected spell ID in A

    cmp #$FF
    beq B06_8B3D ; exit COMMAND menu

    sta $96 ; temp storage for item/spell/type/etc. IDs; selected spell ID

    tax
    jsr B06_8DAA ; given hero ID in $97, set Y to start of hero's data in $062D, y, i.e. Y = $97 * #$12

    lda $063D, y ; Midenhall Current MP

    cmp B06_8CE6-9, x ; MP costs (built in offset from real data at $8CE6)

    bcs B06_8B8A ; hero has enough MP to cast

    jsr B0F_F6EA ; open main dialogue window and display string ID specified by byte following JSR
    .byte $11
    jmp B06_8092 ; wait until all joypad buttons are released and then some button pressed then wipe menus and exit COMMAND menu


; hero has enough MP to cast
B06_8B8A:
    ldy #$04 ; there are 5 single-target spells on the field

    lda $96 ; temp storage for item/spell/type/etc. IDs; selected spell ID

; check if spell is a healing spell
B06_8B8E:
    cmp $8CE1, y ; single-target spell list, field

    beq B06_8B98 ; chose a healing spell

    dey
    bpl B06_8B8E ; check if spell is a healing spell

    bmi B06_8BA4 ; cast spell

; chose a healing spell
B06_8B98:
    jsr B0F_F579 ; display appropriate main SPELL target menu

    cmp #$FF
    bne B06_8BA2 ; update target hero ID

    jmp B06_806D ; exit COMMAND menu


; update target hero ID
B06_8BA2:
    sta $49 ; object hero/target/item/string ID $49; target hero ID for single-target spells

; cast spell
B06_8BA4:
    jsr B06_8DAA ; given hero ID in $97, set Y to start of hero's data in $062D, y, i.e. Y = $97 * #$12

    ldx $96 ; temp storage for item/spell/type/etc. IDs; selected spell ID

    lda $063D, y ; Midenhall Current MP

    sec
    sbc B06_8CE6-9, x ; MP costs (built in offset from real data at $8CE6)

    sta $063D, y ; Midenhall Current MP

    jsr B06_9ACB ; open dialogue window

    jsr B06_8D25 ; print name of hero given by low 2 bits of $97 to [name] buffer $6119, terminated by #$FA

    lda $96 ; temp storage for item/spell/type/etc. IDs; selected spell ID

    sta $95 ; ID for [item] and [spell] control codes

    jsr B0F_FA2A ; display string ID specified by next byte
    .byte $1A
    lda #$90 ; Music ID #$90: casting SFX

    jsr B0F_C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    jsr B0F_C515 ; flash screen 10 times

    lda $96 ; temp storage for item/spell/type/etc. IDs; selected spell ID

    cmp #$09 ; Spell ID #$09: Heal

    bne B06_8BD3 ; spell ID is not #$09

    ldx #$40 ; power on field for Heal

    bne B06_8BE1
; spell ID is not #$09
B06_8BD3:
    cmp #$0B ; Spell ID #$0B: Healmore

    bne B06_8BDB ; spell ID is not #$09 or #$0B

    ldx #$64 ; power on field for Healmore

    bne B06_8BE1
; spell ID is not #$09 or #$0B
B06_8BDB:
    cmp #$0D ; Spell ID #$0D: Healall

    bne B06_8C03 ; spell ID is not #$09, #$0B, or #$0D

    ldx #$FF ; power on field for Healall

B06_8BE1:
    lda $49 ; object hero/target/item/string ID $49; target hero ID for single-target spells

    jsr B06_8DAC ; given hero ID in A, set Y to start of hero's data in $062D, y, i.e. Y = A * #$12

    lda $062D, y ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    bpl B06_8C3C ; spell ineffective; can't heal dead people :(

    lda $49 ; object hero/target/item/string ID $49; target hero ID for single-target spells

    jsr B0F_D146 ; heal hero ID in A by random amount based on healing power in X

    jsr B0F_C22C
    lda $49 ; object hero/target/item/string ID $49; target hero ID for single-target spells

    jsr B0F_FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    jsr B0F_FA2A ; display string ID specified by next byte
    .byte $17
    jsr B0F_EB76 ; open menu specified by next byte
    .byte $01
    jmp B06_8092 ; wait until all joypad buttons are released and then some button pressed then wipe menus and exit COMMAND menu


; spell ID is not #$09, #$0B, or #$0D
B06_8C03:
    cmp #$10 ; Spell ID #$10: Antidote

    bne B06_8C30 ; spell ID is not #$09, #$0B, #$0D, or #$10

    lda $49 ; object hero/target/item/string ID $49; target hero ID for single-target spells

    jsr B06_8DAC ; given hero ID in A, set Y to start of hero's data in $062D, y, i.e. Y = A * #$12

    lda $062D, y ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    and #$20 ; pick out the poison bit from hero status byte

    beq B06_8C3C ; spell ineffective

    lda $49 ; object hero/target/item/string ID $49; target hero ID for single-target spells

    jsr B0F_FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    jsr B0F_FA2A ; display string ID specified by next byte
    .byte $43
    lda $49 ; object hero/target/item/string ID $49; target hero ID for single-target spells

    jsr B06_8DAC ; given hero ID in A, set Y to start of hero's data in $062D, y, i.e. Y = A * #$12

    lda $062D, y ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    and #$DF ; set poison bit to 0

    sta $062D, y ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    jsr B0F_EB76 ; open menu specified by next byte
    .byte $01
B06_8C2D:
    jmp B06_8092 ; wait until all joypad buttons are released and then some button pressed then wipe menus and exit COMMAND menu


; spell ID is not #$09, #$0B, #$0D, or #$10
B06_8C30:
    cmp #$12 ; Spell ID #$12: Outside

    bne B06_8C43 ; spell ID is not #$09, #$0B, #$0D, #$10, or #$12

    jsr B06_8CD4 ; handler for Outside spell effect

    lda #$00
    jmp B0F_D88F ; warp to warp point given by ($0C)


; spell ineffective
B06_8C3C:
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $9E
    jmp B06_9548 ; end TALK/ITEM routines


; spell ID is not #$09, #$0B, #$0D, #$10, or #$12
B06_8C43:
    cmp #$13 ; Spell ID #$13: Repel

    bne B06_8C4D ; spell ID is not #$09, #$0B, #$0D, #$10, or #$12-#$13

    lda #$FE
    sta $46 ; Repel (#$FE) / Fairy Water (#$FF) flag

    bne B06_8C2D
; spell ID is not #$09, #$0B, #$0D, #$10, or #$12-#$13
B06_8C4D:
    cmp #$14 ; Spell ID #$14: Return

    bne B06_8C62 ; spell ID is not #$09, #$0B, #$0D, #$10, or #$12-#$14

; handler for Return spell effect
B06_8C51:
    ldx #$02
    jsr B0F_D2E7 ; X = 1 => CLC and update $0C-$0D to warp point data to use if Outside allowed from current map, SEC otherwise, X = 2 => CLC and update $0C-$0D to warp point data to use if Return allowed from current map, SEC otherwise, X = 3 => disembark from ship and update ship position based on last save point ID $48

    bcs B06_8C3C ; spell ineffective

    lda #$95 ; Music ID #$95: Return SFX

    jsr B0F_C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    lda #$00
    jmp B0F_D88F ; warp to warp point given by ($0C)


; spell ID is not #$09, #$0B, #$0D, #$10, or #$12-#$14
B06_8C62:
    cmp #$15 ; Spell ID #$15: Open

    bne B06_8C94 ; spell ID is not #$09, #$0B, #$0D, #$10, or #$12-#$15

    lda #$00
    sta $C9
    jsr B0F_CF7C
    lda $49 ; object hero/target/item/string ID $49; target hero ID for single-target spells

    cmp #$FF
    beq B06_8C91
    lda #$01
    sta $C9
    jsr B0F_CF7C
    lda $49 ; object hero/target/item/string ID $49; target hero ID for single-target spells

    cmp #$FF
    beq B06_8C91
    lda #$02
    sta $C9
    jsr B0F_CF7C
    lda $49 ; object hero/target/item/string ID $49; target hero ID for single-target spells

    cmp #$FF
    beq B06_8C91
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $3B
B06_8C91:
    jmp B06_8092 ; wait until all joypad buttons are released and then some button pressed then wipe menus and exit COMMAND menu


; spell ID is not #$09, #$0B, #$0D, #$10, or #$12-#$15
B06_8C94:
    cmp #$16 ; Spell ID #$16: Stepguard

    bne B06_8C9F ; spell ID is not #$09, #$0B, #$0D, #$10, or #$12-#$16; ergo it's Spell ID #$17: Revive

    lda #$FF
    sta $47 ; Stepguard flag

    jmp B06_8092 ; wait until all joypad buttons are released and then some button pressed then wipe menus and exit COMMAND menu


; spell ID is not #$09, #$0B, #$0D, #$10, or #$12-#$16; ergo it's Spell ID #$17: Revive
B06_8C9F:
    lda $49 ; object hero/target/item/string ID $49; target hero ID for single-target spells

    jsr B06_8DAC ; given hero ID in A, set Y to start of hero's data in $062D, y, i.e. Y = A * #$12

    lda $062D, y ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    and #$80 ; Alive

    beq B06_8CAE
    jmp B06_8C3C ; spell ineffective


B06_8CAE:
    lda $49 ; object hero/target/item/string ID $49; target hero ID for single-target spells

    sta $97 ; subject hero ID $97

    jsr B06_8DAC ; given hero ID in A, set Y to start of hero's data in $062D, y, i.e. Y = A * #$12

    lda $062D, y ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    ora #$80 ; Alive

    sta $062D, y ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    lda #$01 ; revive with 1 HP

    sta $063B, y ; Midenhall Current HP, low byte

    jsr B0F_D302
    jsr B0F_C22C
    lda $49 ; object hero/target/item/string ID $49; target hero ID for single-target spells

    jsr B0F_FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    jsr B0F_FA2A ; display string ID specified by next byte
    .byte $44
    jmp B06_9548 ; end TALK/ITEM routines


; handler for Outside spell effect
B06_8CD4:
    ldx #$01
    jsr B0F_D2E7 ; X = 1 => CLC and update $0C-$0D to warp point data to use if Outside allowed from current map, SEC otherwise, X = 2 => CLC and update $0C-$0D to warp point data to use if Return allowed from current map, SEC otherwise, X = 3 => disembark from ship and update ship position based on last save point ID $48

    bcs B06_8CDC
    rts

B06_8CDC:
    pla
; MP costs (built in offset from real data at $8CE6)
; indexed data load target (from $8B7E, $8BAD)
    pla
    jmp B06_8C3C ; spell ineffective

; single-target spell list, field
B06_8CE1:
.byte $09	 ; Spell ID #$09: Heal
.byte $0B	 ; Spell ID #$0B: Healmore
.byte $0D	 ; Spell ID #$0D: Healall
.byte $10	 ; Spell ID #$10: Antidote
.byte $17	 ; Spell ID #$17: Revive

; MP Cost for Spells on Field (referenced as B06_8CE6-9, x)
B06_8CE6:
.byte $03	 ; Spell ID #$09: Heal
.byte $00	 ; Spell ID #$0A: Increase
.byte $05	 ; Spell ID #$0B: Healmore
.byte $00	 ; Spell ID #$0C: Sacrifice
.byte $08	 ; Spell ID #$0D: Healall
.byte $00	 ; Spell ID #$0E: Explodet
.byte $00	 ; Spell ID #$0F: Chance
.byte $03	 ; Spell ID #$10: Antidote
.byte $02	 ; Spell ID #$11: Heal (not used by heroes)
.byte $06	 ; Spell ID #$12: Outside
.byte $02	 ; Spell ID #$13: Repel
.byte $06	 ; Spell ID #$14: Return
.byte $02	 ; Spell ID #$15: Open
.byte $04	 ; Spell ID #$16: Stepguard
.byte $0F	 ; Spell ID #$17: Revive

B06_8CF5:
    lda $8F
    clc
    adc $0624 ; party gold, low byte

    sta $0624 ; party gold, low byte

    lda $90
    adc $0625 ; party gold, high byte

    sta $0625 ; party gold, high byte

    bcc B06_8D10 ; cap party gold at 65,535

    lda #$FF
    sta $0624 ; party gold, low byte

    sta $0625 ; party gold, high byte

B06_8D10:
    rts

; given item ID in $96 and discount amount in $8F-$90, set $8F-$90 to discounted item price
B06_8D11:
    lda $96 ; temp storage for item/spell/type/etc. IDs; item ID

    asl ; item prices are 2 bytes each

    tay
    lda ItemPrices, y ; Item Prices, low byte
    sec
    sbc $8F
    sta $8F
    lda ItemPrices+1, y ; Item Prices, high byte
    sbc $90
    sta $90
    rts

; print name of hero given by low 2 bits of $97 to [name] buffer $6119, terminated by #$FA
B06_8D25:
    lda $97 ; subject hero ID $97

    jmp B0F_FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA


; set $8F-$90 to A-#$00
B06_8D2A:
    sta $8F
    lda #$00
    sta $90
    rts

; given gold amount in $8F-$90, decrease party gold by that amount and SEC if possible, CLC otherwise
B06_8D31:
    lda $0624 ; party gold, low byte

    sec
    sbc $8F ; amount to subtract, low byte

    sta $0C
    lda $0625 ; party gold, high byte

    sbc $90 ; amount to subtract, high byte

    sta $0D
    bcc B06_8D4C ; C clear => not enough gold, so just RTS

    lda $0C ; otherwise, C is set; update party gold with new total

    sta $0624 ; party gold, low byte

    lda $0D
    sta $0625 ; party gold, high byte

B06_8D4C:
    rts

B06_8D4D:
    sta $96 ; temp storage for item/spell/type/etc. IDs; item ID
    asl ; price list is 2 bytes wide

    tay
    lda ItemPrices, y ; Item Prices, low byte

    sta $8F
    lda ItemPrices+1, y ; Item Prices, high byte

    sta $90
    lda #$32 ; Item ID #$32: Golden Card

    jsr B06_A369 ; check for item A in party inventory, returning inventory index of item in A/X if found, #$FF if not

    cmp #$FF
    beq B06_8D7B ; branch if no Golden Card, otherwise extra string and altered price

    lsr $90 ; 16-bit LSR

    ror $8F
    lsr $90 ; 16-bit LSR

    ror $8F
    lda ItemPrices, y ; Item Prices, low byte

    sec
    sbc $8F
    sta $8F
    lda ItemPrices+1, y ; Item Prices, high byte

    sbc $90
    sta $90 ; 25% discount

B06_8D7B:
    jmp B06_8D31 ; given gold amount in $8F-$90, decrease party gold by that amount and SEC if possible, CLC otherwise


; given hero ID in $97 and item ID in $96, try to add item to first empty slot in hero's inventory; SEC if added, CLC if no empty slots
B06_8D7E:
    lda $97 ; subject hero ID $97; hero ID

    asl ; 8 inventory slots per hero

    asl
    asl
    tay
    ldx #$00 ; loop counter

B06_8D86:
    lda $0600, y ; Midenhall inventory item 1 (| #$40 if equipped)

    beq B06_8D93 ; if empty slot, go add item

    iny ; else, increment inventory index and loop counter

    inx
    cpx #$08 ; 8 inventory slots per hero

    bne B06_8D86 ; if more inventory slots to check, loop to check them

    clc ; at this point, we know hero's inventory is already full, so flag failure for calling code

    rts

B06_8D93:
    lda $96 ; temp storage for item/spell/type/etc. IDs; item ID

    sta $0600, y ; Midenhall inventory item 1 (| #$40 if equipped); add to hero's inventory

    sec ; flag success for calling code

    rts

; given hero ID in $97, and status in A, SEC if hero has that status, CLC otherwise
B06_8D9A:
    sta $0C
    jsr B06_8DAA ; given hero ID in $97, set Y to start of hero's data in $062D, y, i.e. Y = $97 * #$12

    lda $062D, y ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    and $0C
    beq B06_8DA8
    sec
    rts

B06_8DA8:
    clc
    rts

; given hero ID in $97, set Y to start of hero's data in $062D, y, i.e. Y = $97 * #$12
B06_8DAA:
    lda $97 ; subject hero ID $97

; given hero ID in A, set Y to start of hero's data in $062D, y, i.e. Y = A * #$12
B06_8DAC:
    beq B06_8DB8 ; if it's Midenhall, use + #$00

    cmp #$01 ; is it Cannock?

    bne B06_8DB6 ; if no, keep checking

    lda #$12 ; if yes, use + #$12

    bne B06_8DB8 ; and skip over Moonbrooke

B06_8DB6:
    lda #$24 ; it's Moonbrooke, so use + #$24

B06_8DB8:
    tay
    rts

; given a hero ID in $97 and an item ID in A, SEC if hero has that item, CLC otherwise
B06_8DBA:
    pha
    lda $97 ; subject hero ID $97

    sta $9C
    pla
    jmp B0F_C4B0 ; given a hero ID in $9C and an item ID in A, SEC if hero has that item, CLC otherwise


; given a hero ID in $97 and an item ID in A, remove that item from hero's inventory if present and SEC, CLC otherwise
B06_8DC3:
    pha
    lda $97 ; subject hero ID $97

    sta $9C
    pla
    jmp B0F_C4B6 ; given a hero ID in $9C and an item ID in A, remove that item from hero's inventory if present and SEC, CLC otherwise


; restore full HP to all living party members
B06_8DCC:
    ldy #$00
B06_8DCE:
    lda $063B, y ; Midenhall Current HP, low byte

    ora $063C, y ; Midenhall Current HP, high byte

    beq B06_8DE2 ; branch if current HP is #$00

    lda $0630, y ; Midenhall Max HP low byte

    sta $063B, y ; Midenhall Current HP, low byte

    lda $0631, y ; Midenhall Max HP high byte

    sta $063C, y ; Midenhall Current HP, high byte

B06_8DE2:
    tya
    clc
    adc #$12 ; hero data is #$12 bytes each

    tay
    cmp #$36 ; and there are 3 heroes

    bne B06_8DCE ; if more heroes to heal, heal them

    rts

; restore full MP to all living party members
B06_8DEC:
    ldy #$00 ; start with Midenhall

B06_8DEE:
    lda $063B, y ; Midenhall Current HP, low byte

    ora $063C, y ; Midenhall Current HP, high byte

    beq B06_8DFC ; zero HP => dead, right?

    lda $0632, y ; Midenhall Max MP

    sta $063D, y ; Midenhall Current MP

B06_8DFC:
    tya
    clc
    adc #$12 ; hero data is #$12 bytes wide

    tay
    cmp #$36 ; max of 3 heroes at #$12 each => stop at #$36

    bne B06_8DEE ; if more heroes to check, check them

    rts

; handler for dialogue IDs #$29-#$94 (open dialogue window and display string specified by A + #$1D7, i.e. String IDs #$0200-#$026B)
B06_8E06:
    sec
    sbc #$29
    sta $49 ; object hero/target/item/string ID $49

    pha ; string ID

    jsr B06_9ACB ; open dialogue window

    lda #$00
    jsr B0F_FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    pla ; string ID

    cmp #$64 ; either this or the above call to B0F_FC50 are useless

    bcc B06_8E30
    pha ; string ID

    cmp #$6A
    bcs B06_8E22
    lda #$00 ; Midenhall

    beq B06_8E2C
B06_8E22:
    cmp #$6A ; string ID #026A uses Cannock's name

    bne B06_8E2A ; string IDs > #026A uses Moonbrooke's name

    lda #$01 ; Cannock

    bne B06_8E2C
B06_8E2A:
    lda #$02 ; Moonbrooke

B06_8E2C:
    jsr B0F_FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    pla ; String IDs #$0200-#$026B: "‘When in need, visit the Houses of Healing[.’][end-FC]" / "‘[name] is still inexperienced.[line]Return here in thy need[.’][end-FC]" / "‘One who sets foot upon the Travel Door is transported to a distant place[.’][end-FC]" / "‘The Dragon's Bane is a magic charm[.’][wait][line]‘It is said that it may keep one safe from the spell[.’][end-FC]" / "‘If thy path leads west of this castle thou shall reach the town of Leftwyne[.’][end-FC]" / "‘This is Midenhall Castle[.’][end-FC]" / "‘Remember to equip thyself with weapons and armor when thou obtains such items[.’][end-FC]" / "‘Woof, woof!’[end-FC]" / "‘[name], royalty should not venture into prisons such as this[.’][end-FC]" / "‘I have heard that the heir of our good King has ventured forth to do battle with the evil sorcerer, Hargon[.’][wait][line]‘What? Thou art the one? Luck be with thee[.’][end-FC]" / "‘If thou art poisoned, each step will weaken thee further[.’][end-FC]" / "‘Northward lies the castle of Cannock, my friend[.’][end-FC]" / "‘Welcome to Leftwyne[.’][end-FC]" / "‘Look for the monolith by the inland sea west of this place[.’][wait][line]‘It is by that route alone that thou shall reach Moonbrooke[.’][end-FC]" / "‘Oh, thou scared me! And my hiccups are cured! Thank thee, stranger[.’][end-FC]" / "‘Bow-wow!’[end-FC]" / "‘I have heard of a cave far to the east in which the Spring of Bravery rises[.’][end-FC]" / "‘Welcome to Cannock Castle[.’][end-FC]" / "‘Only if the descendants of Erdrick combine their skills can the forces of evil be overcome[.’][end-FC]" / "‘If thou would speak to the prisoners, do so through the barred doors[.’][end-FC]" / "‘Pssst.[line]I'll tell thee a secret[.’][wait][line]‘There is a silver key that opens doors of silver[.’][end-FC]" / "‘What does it matter if people steal things[.’][wait][line]‘The world is doomed no matter what happens[.’][end-FC]" / "‘I saw the sky burning red on the southern horizon[.’][wait][line]‘Perhaps it was Moonbrooke Castle in flames[.’][end-FC]" / "‘Listen closely[.’][wait][line]‘Our prince has studied the ways of magic, though with heavy armor or weapons he has no skill[.’][wait][line]‘Still, he seeks to fight evil[.’][end-FC]" / "‘There is a legend that tells of a great and good wizard who lives in a cave in the sea[.’][wait][line]‘If thou hast the five crests he will come to thee[.’][end-FC]" / "‘Here in Hamlin not all is as it seems[.’][wait][line]‘Talk to everyone, for appearances may not reflect the true person[.’][end-FC]" / "‘Southwest of this village lies the castle of Moonbrooke[.’][end-FC]" / "‘Some say that there is a tall tower, and in it a brave adventurer may find the Cloak of Wind[.’][wait][line]‘It can save thee if thou falls from a great height[.’][end-FC]" / "‘The Mirror of Ra was lost long ago in a swamp southeast of Hamlin in the place where four bridges can be seen[.’][end-FC]" / "‘Help! Help! Hargon is coming to destroy us all!’[end-FC]" / "‘Of keys and doors I know this[.’][wait][line]‘There are silver keys and golden keys, and doors to match them each[.’][wait][line]‘Seek thee first the silver key, for this is what I teach[.’][wait][line]‘That key is in the Cave of the Lake, west of Cannock's walls[.’][wait][line]‘But go only with a friend inside, or there thou shall surely fall[.’][end-FC]" / "‘Eastward, across an arm of the sea lies the kingdom of Alefgard[.’][wait][line]‘From there in ages past came a great warrior ‟a descendant of Erdrick” who slew dragons, and there came also a princess named Gwaelin[.’][end-FC]" / "‘Please, please, do not hurt me!’[wait][line]‘I can tell thee of a secret[.’][wait][line]‘In Hamlin Village there is a Water Crest. Seek it!’[end-FC]" / "‘It has been rumored that the king of Tantegel Castle has disappeared[.’][end-FC]" / "‘I am a soldier from Alefgard[.’][wait][line]‘Perhaps thou has seen ancient maps of my land, but it has changed much through the ages[.’][end-FC]" / "‘Thou art welcome in Lianport[.’][end-FC]" / "‘Yes, this is Tantegel[.’][end-FC]" / "‘The golden key opens the red door, too[.’][end-FC]" / "‘Pardon me, stranger, but I had a vision and in it descendants of the great hero Erdrick came to us in our need[.’][wait][line]‘Ah! So it was true.[line]Thou art truly welcome[.’][end-FC]" / "‘Thou hast come to Tantegel Castle[.’][end-FC]" / "‘Long ago Princess Gwaelin departed over the sea, but thy companion is her twin in appearance[.’][end-FC]" / "‘So thou has come even here to this simple room[.’][wait][line]‘I cannot help thee. My hope fled long ago[.’][end-FC]" / "‘The King keeps himself hidden, for he is afraid of Hargon's wrath[.’][end-FC]" / "‘The Echoing Flute blows a magical note[.’][wait][line]‘On an island, in a tower, in a chamber remote, play it and listen, a wise man once wrote[.’][wait][line]‘For when the sound echoes, there shall thou find, a crest of great power to aid thee in time[.’][end-FC]" / "‘So, thou art the great warriors of which we have heard[.’][end-FC]" / "‘Here in this coliseum many heroes have proven their strength[.’][end-FC]" / "‘Beyond lies the coliseum and the court of the King[.’][end-FC]" / "‘In the island town of Zahan in the southern ocean lives a man named Torval who owns the golden key[.’][end-FC]" / "‘As the story goes, it was a dark and stormy night when the pirate ship, Relentless, hit a reef and sank[.’][wait][line]‘They say that in its hold was the Echoing Flute[.’][end-FC]" / "‘I seek the Armor of Gaia[.’][wait][line]‘I was told that it was kept in a shop that sells armor[.’][end-FC]" / "Thou hast found the Stars Crest.[end-FC]" / "‘Do not overburden thyself. Cast away those items that thou doesn't need[.’][end-FC]" / "‘I have come seeking a thief by the name of Roge Fastfinger[.’][end-FC]" / "‘I warn thee to go back. This wizard's house may be thy ruin[.’][end-FC]" / "‘Thou hast come to Zahan at a poor time[.’][wait][line]‘All the men are away fishing at sea[.’][end-FC]" / "‘Many are the tales of a mountainous island in the sea and its great cavern[.’][wait][line]‘It is said that only one who bears the Moon Fragment may enter there[.’][end-FC]" / "‘One day I will be a great fisherman like Papa[.’][end-FC]" / "‘When the Moon Fragment is held upon high, the tide will rise and the seagulls cry[.’][end-FC]" / "‘Oh Formeo, Formeo, where for art thou my Formeo!’[end-FC]" / "‘Yes, I am Torval's wife. But just between us, he loves his dogs more than me[.’][end-FC]" / "‘That mutt yonder keeps pulling at my sleeve[.’][end-FC]" / "‘So thou hast heard of the sinking of the Relentless[.’][wait][line]‘Some say that the pirates simply left the plug out. Fools[.’][end-FC]" / "‘This is a town of lonely women, old men, dogs and children[.’][wait][line]‘What the men want of those stinking fish is beyond me[.’][end-FC]" / "‘Hello. This is the village of Tuhn[.’][end-FC]" / "‘Many years have passed since the Tower of the Moon could be reached by ship[.’][wait][line]‘It lies to the south[.’][end-FC]" / "‘Thou hast heard of Roge Fastfinger I see[.’][wait][line]‘Well, he stole the key to our watergate, the scoundrel.[line]We would dearly love to have it back[.’][end-FC]" / "‘If Jena sent thee, tell her I would not name our dog Ruffles for all the dragon's gold in Alefgard[.’][end-FC]" / "‘Ruff, ruff..[.’][end-FC]" / "‘It is said that the Tower of the Moon holds a piece of the moon[.’][end-FC]" / "‘I'm Jena. If thou meets my husband, tell him that my father's name was Ruffles[.’][end-FC]" / "‘Far and wide I have sought a master weaver who makes Water Flying Cloth, and they say such a man lives here[.’][end-FC]" / "‘If the watergate were to be raised, water would once more fill the dry riverbed[.’][end-FC]" / "‘Where has everyone gone?[line]Dost thou think it is my breath?’[end-FC]" / "‘Yip, yip, yip!’[end-FC]" / "‘Hargon dwells on the high plateau of Rhone[.’][wait][line]‘Only one who has the Eye of Malroth can find the road to that place[.’][end-FC]" / "‘It is true enough[.’][wait][line]‘I locked Roge Fastfinger in prison and threw away the key.[line]But he has escaped[.’][end-FC]" / "‘For the finest Water Flying Cloth I recommend Don Mahone who lives in Tuhn[.’][end-FC]" / "‘I bid thee welcome to Wellgarth Town[.’][wait][line]‘I shall sing for thee[.’][end-FC]" / "‘Let me tell thee, Hargon is a master of disguise, but if thou hast the Charm of Rubiss thou will see through the deception[.’][end-FC]" / "‘How dare thou enter a lady's room unbidden!’[end-FC]" / "‘It is said that the greatest shall fall by a spell of his own devising[.’][end-FC]" / "‘There is an isolated valley northwest of the town where once a road led to Rhone[.’][end-FC]" / "‘Some say that Hargon has cast a spell over his entire castle, that it looks fair and peaceful[.’][wait][line]‘Thou will not be deceived if thou hast the gift of Rubiss[.’][end-FC]" / "‘In the ocean far to the east lies an island and on it are trees from every corner of the world[.’][end-FC]" / "‘Having come this far, thou may as well try the door there to the left[.’][end-FC]" / "‘Roge Fastfinger? No, I have not heard the name[.’][end-FC]" / "‘We call this town Beran. Welcome[.’][end-FC]" / "‘Thou should see the King of Osterfair for the Moon Crest[.’][end-FC]" / "‘With the Magic Loom and Dew's Yarn thou can make the Water Flying Cloth[.’][end-FC]" / "‘The Leaf of the World Tree has the power to revive ghosts[.’][end-FC]" / "‘I seek the Thunder Sword, for one need not know magic to use its power[.’][end-FC]" / "‘Osterfair lies far south of Midenhall on a great island[.’][end-FC]" / "‘Welcome to Bragol's Tools. May I help thee?’[end-FC]" / "‘Greetings. I am the Keeper of this Inn[.’][end-FC]" / "‘Thou hast come to Midenhall[.’][end-FC]" / "‘[..][..][.’][end-FC]" / "‘[..][..][.’][end-FC]" / "‘Only the golden key can open this door[.’][end-FC]" / "‘This travel door takes one back to the underworld.[line]If that is thy wish, please enter[.’][end-FC]" / "‘The ancient road to Rhone was once west of this monolith[.’][end-FC]" / "‘In Cannock there is a young prince and Moonbrooke had a princess[.’][end-FC]" / "‘Although it makes me sad, thou must go forth and seek thy destiny[.’][end-FC]" / "‘Thief! Thief! What? Thou art [name], heir of Midenhall!’[wait][line]‘Please forgive me[.’][end-FC]" / "[end-FC]" / "‘Ghosts may wander this world under moon or sun and at times they may even be recalled[.’][end-FC]" / "‘If thy name is [name], I have a message for thee[.’][wait][line]‘Seek the Fire Monolith and thou shall find the Sun Crest[.’][end-FC]" / "‘That is the chamber of Prince [name]'s sister, Princess Halla[.’][end-FC]" / "‘After the sacking of Moonbrooke I escaped and made my way here, hoping others would follow[.’][end-FC]"

B06_8E30:
    jsr B0F_FA52 ; display string ID specified by A + #$0200

    lda $49 ; object hero/target/item/string ID $49

    cmp #$6B
    bne B06_8E41
    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $6C
    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $6D
B06_8E41:
    jmp B06_9548 ; end TALK/ITEM routines


; handler for dialogue IDs #$95-#$9C (open dialogue window, display string specified by A + #$1D9, display YES/NO menu, and display string corresponding to selected option)
B06_8E44:
    sec
    sbc #$95 ; why not just SBC #$27?

    clc
    adc #$6E ; String IDs #$026E-#$0275: "‘Dost thou think it was Hargon who attacked Moonbrooke and set it aflame?’[FD][FD][end-FC]" / "‘Dost thou have a lottery ticket?’[FD][FD][end-FC]" / "‘This is a sewing shop, true, but I do not have the Dew's Yarn[.’][line]Dost thou seek the Dew's Yarn, too?’[FD][FD][end-FC]" / "‘Hast thou heard of the sunken treasure?’[FD][FD][end-FC]" / "‘Tell me, did thou come to buy the Jailor's Key?’[FD][FD][end-FC]" / "‘Pardon me, good folk, but dost thou have the time?’[FD][FD][end-FC]" / "‘Hast thou found the Eye of Malroth?’[FD][FD][end-FC]" / "‘Hast thy travels taken thee to the monolith south of Midenhall?’[FD][FD][end-FC]"

    sta $49 ; object hero/target/item/string ID $49

    jsr B06_9ACB ; open dialogue window

    lda $49 ; object hero/target/item/string ID $49

    jsr B0F_FA52 ; display string ID specified by A + #$0200

    jsr B06_9AD0 ; open YES/NO menu, return selected option in A

    cmp #$00 ; YES

    bne B06_8E5F
    lda #$08 ; String IDs #$0276-#$027D: "‘Yes, I think so, too[.’][end-FC]" / "‘The Lottery is but a game; do not take it too seriously[.’][end-FC]" / "‘Alas, I have no more of the Dew's Yarn, but I know where thou may seek some,[wait][line]for it is a substance made of wind and water and it drifts aloft until it lands on the third floor[line]in the North Tower of the Dragon's Horn[.’][end-FC]" / "‘The pirate ship sank in the wide seas of the north[.’][end-FC]" / "‘I heard that it is sold here, but perhaps that is a lie[.’][end-FC]" / "‘I thank thee very much indeed[.’][end-FC]" / "‘The Eye of Malroth sees much that is not readily apparent[.’][wait][line]‘Use it in the swamp of the hidden valley and perhaps thou will see a way to Rhone[.’][end-FC]" / "‘Please say nothing of this[.’][end-FC]"

    bne B06_8E61
B06_8E5F:
    lda #$10 ; String IDs #$027E-#$0285: "‘But I cannot think of anyone else with such power[.’][end-FC]" / "‘Some merchants give out Lottery Tickets for free[.’][end-FC]" / "‘Stop again if thou art near[.’][end-FC]" / "‘Speak to the merchantman in Lianport[.’][end-FC]" / "‘Perhaps I should not say anything more[.’][end-FC]" / "‘Then may thy ears become cabbages and thy tongue a sausage[.’][wait][line]‘A little courtesy never killed anyone[.’][end-FC]" / "‘Once thou hast the Moon Fragment thou may enter the island cave where the Eye of Malroth is kept in darkness[.’][end-FC]" / "‘My brother must be there now. Will thou not go to him?’[end-FC]"

B06_8E61:
    clc
    adc $49 ; object hero/target/item/string ID $49

    jsr B0F_FA52 ; display string ID specified by A + #$0200

    jmp B06_9548 ; end TALK/ITEM routines


; handler for dialogue IDs #$9D-#$C2 (town NPCs with complex logic)
B06_8E6A:
    pha ; dialogue ID

    jsr B06_9ACB ; open dialogue window

    pla ; dialogue ID

    sec
    sbc #$9D ; convert to zero-based

    asl ; 2 bytes per pointer

    tax
    lda B06_8E81, x ; complex dialogue logic handlers

    sta $0C
    lda B06_8E81+1, x
    sta $0D
    jmp ($000C)

; complex dialogue logic handlers
B06_8E81:
.addr B06_8ECD      ; $06:B06_8ECD; handler for dialogue ID #$9D: King in Map ID #$02: Midenhall 2F
.addr B06_8F6A      ; $06:B06_8F6A; handler for dialogue ID #$9E: Guard in Map ID #$02: Midenhall 2F
.addr B06_8F85      ; $06:B06_8F85; handler for dialogue ID #$9F: Wizard in Map ID #$02: Midenhall 2F
.addr B06_8FAC      ; $06:B06_8FAC; handler for dialogue ID #$A0: Brute in Map ID #$04: Midenhall B1
.addr B06_8FCC      ; $06:B06_8FCC; handler for dialogue ID #$A1: King in Map ID #$06: Cannock
.addr B06_9019      ; $06:B06_9019; handler for dialogue ID #$A2: Princess Halla in Map ID #$06: Cannock
.addr B06_9055      ; $06:B06_9055; handler for dialogue ID #$A3: Wizard in Map ID #$06: Cannock
.addr B06_9065      ; $06:B06_9065; handler for dialogue ID #$A4-#$A5: Monsters in Map ID #$08: Hamlin Waterway
.addr B06_9065      ; $06:B06_9065; handler for dialogue ID #$A4-#$A5: Monsters in Map ID #$08: Hamlin Waterway
.addr B06_9077      ; $06:B06_9077; handler for dialogue ID #$A6: King Moonbrooke's Flame in Map ID #$09: Moonbrooke
.addr B06_9095      ; $06:B06_9095; handler for dialogue ID #$A7: Guard in Map ID #$0A: Moonbrooke B1
.addr B06_90A8      ; $06:B06_90A8; handler for dialogue ID #$A8: Wizard in Map ID #$0B: Lianport
.addr B06_90CC      ; $06:B06_90CC; handler for dialogue ID #$A9: Echoing Flute guy in NE in Map ID #$0B: Lianport
.addr B06_90EF      ; $06:B06_90EF; handler for dialogue ID #$AA: Woman in Map ID #$0B: Lianport
.addr B06_9102      ; $06:B06_9102; handler for dialogue ID #$AB: Brute in Map ID #$0B: Lianport
.addr B06_9112      ; $06:B06_9112; handler for dialogue ID #$AC: Woman in SW corner of Map ID #$0B: Lianport
.addr B06_914D      ; $06:B06_914D; handler for dialogue ID #$AD: Wizard in Map ID #$0C: Tantegel
.addr B06_916E      ; $06:B06_916E; handler for dialogue ID #$AE: Wizard in Map ID #$0C: Tantegel
.addr B06_917B      ; $06:B06_917B; handler for dialogue ID #$AF: Priest in Map ID #$0C: Tantegel
.addr B06_9197      ; $06:B06_9197; handler for dialogue ID #$B0: King in Map ID #$0F: Osterfair
.addr B06_9213      ; $06:B06_9213; handler for dialogue ID #$B1: crazy fortuneteller Wizard in NW Map ID #$0F: Osterfair
.addr B06_928B      ; $06:B06_928B; handler for dialogue IDs #$B2-#$B3: Dog in Map ID #$0F: Osterfair
.addr B06_928B      ; $06:B06_928B; handler for dialogue IDs #$B2-#$B3: Dog in Map ID #$0F: Osterfair
.addr B06_9292      ; $06:B06_9292; handler for dialogue ID #$B4: Dog in Map ID #$10: Zahan
.addr B06_9299      ; $06:B06_9299; handler for dialogue ID #$B5: Don Mahone in Map ID #$11: Tuhn
.addr B06_92FE      ; $06:B06_92FE; handler for dialogue ID #$B6: Roge Fastfinger in NE Map ID #$14: Wellgarth Underground
.addr B06_932C      ; $06:B06_932C; handler for dialogue IDs #$B7-#$B9: Priest in Map ID #$15: Beran
.addr B06_932C      ; $06:B06_932C; handler for dialogue IDs #$B7-#$B9: Priest in Map ID #$15: Beran
.addr B06_932C      ; $06:B06_932C; handler for dialogue IDs #$B7-#$B9: Priest in Map ID #$15: Beran
.addr B06_933E      ; $06:B06_933E; handler for dialogue ID #$BA: Monster in Map ID #$16: Hargon's Castle 1F
.addr B06_9348      ; $06:B06_9348; handler for dialogue ID #$BB: Hargon in Map ID #$17: Hargon's Castle 7F
.addr B06_937F      ; $06:B06_937F; handler for dialogue ID #$BC: Dragonlord's Grandson in Map ID #$18: Charlock Castle B8
.addr B06_939B      ; $06:B06_939B; handler for dialogue ID #$BD: Guard in Map ID #$1A: Shrine SW of Cannock
.addr B06_939F      ; $06:B06_939F; handler for dialogue ID #$BE: Guard in Map ID #$1A: Shrine SW of Cannock
.addr B06_93BE      ; $06:B06_93BE; handler for dialogue ID #$BF: Wizard in Map ID #$1C: Shrine SE of Rimuldar
.addr B06_93E1      ; $06:B06_93E1; handler for dialogue ID #$C0: Wizard in Map ID #$15: Beran
.addr B06_9400      ; $06:B06_9400; handler for dialogue ID #$C1: Priest in Map ID #$1F: Rhone Shrine
.addr B06_944D      ; $06:B06_944D; handler for dialogue ID #$C2: Priest in Map ID #$20: Shrine SW of Moonbrooke

B06_8ECD:
; handler for dialogue ID #$9D: King in Map ID #$02: Midenhall 2F
    jsr B06_9AD5 ; set A/$97 to ID of first living hero

    bne B06_8F0C ; different dialogue when talking to King Midenhall depending on whether Prince Midenhall is alive or not

    jsr B0F_FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $86
    jsr B06_9466 ; display EXP to next level messages for entire party

    lda #$00 ; Midenhall; pointless since none of these string use the [name] control code

    jsr B0F_FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    lda $CA ; Cannock runaround quest status (0 = start of game, 0 -> 1 = talked to King Cannock, 1 -> 2 = said YES to seeking Cannock in Spring of Bravery, 2 -> 3 = talked to King Midenhall; adding Cannock sets this to 3; some code checks for 4)

    cmp #$02
    beq B06_8EF4 ; update Cannock quest status to 3

    cmp #$03
    bne B06_8EFA
    lda $063F ; Cannock status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    and #$04 ; pick out the In Party bit

    beq B06_8EF6 ; message for when you're able to add Cannock, but haven't yet done so

    bne B06_8EFA
B06_8EF4:
    inc $CA ; Cannock runaround quest status (0 = start of game, 0 -> 1 = talked to King Cannock, 1 -> 2 = said YES to seeking Cannock in Spring of Bravery, 2 -> 3 = talked to King Midenhall; adding Cannock sets this to 3; some code checks for 4)

B06_8EF6:
    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $89
B06_8EFA:
    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $87
    lda #$00 ; Save Point ID #$00: Midenhall 2F

    sta $48 ; last save point ID

    jsr B06_A35D ; save game handler

    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $88
    jmp B06_9548 ; end TALK/ITEM routines


B06_8F0C:
    lda #$00 ; Midenhall

    jsr B0F_FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $8A
    jsr B06_9466 ; display EXP to next level messages for entire party

    lda #$00 ; Save Point ID #$00: Midenhall 2F

    sta $48 ; last save point ID

    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $87
    jsr B0F_D16B
    jsr B06_9AD5 ; set A/$97 to ID of first living hero

    jsr B06_8D25 ; print name of hero given by low 2 bits of $97 to [name] buffer $6119, terminated by #$FA

    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $8B
    lda #$00 ; Midenhall

    jsr B0F_FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $8C
    jmp B06_9548 ; end TALK/ITEM routines

B06_8F39:
    lsr $0625 ; party gold, high byte; full party death costs you half your gold

    ror $0624 ; party gold, low byte

    jsr B06_9ACB ; open dialogue window

    lda #$00 ; Midenhall

    jsr B0F_FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $8D
    jmp B06_8092 ; wait until all joypad buttons are released and then some button pressed then wipe menus and exit COMMAND menu

B06_8F4E:
    jsr B06_9ACB ; open dialogue window

    jsr B06_9AD5 ; set A/$97 to ID of first living hero

    pha
    jsr B0F_FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $8E
    jsr B06_9466 ; display EXP to next level messages for entire party

    pla
    jsr B0F_FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $90
    jmp B06_8092 ; wait until all joypad buttons are released and then some button pressed then wipe menus and exit COMMAND menu


; handler for dialogue ID #$9E: Guard in Map ID #$02: Midenhall 2F
B06_8F6A:
    lda #$00 ; Midenhall

    jsr B0F_FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    lda $44 ; non-saved event status (#$00 = event start, #$01 = Lianport Gremlins defeated, #$02 = met with Lianport grandfather/have no friends at Shrine SW of Cannock, #$03 = King Midenhall moved to stairs, #$04 = King Midenhall moved down stairs, #$05 = King Midenhall spoke on Midenhall 1F, #$0B = Lighthouse Wizard 7F, #$1B Lighthouse Wizard 2F spoke, #$64 = Hargon dead, #$FF = event end)

    cmp #$03
    beq B06_8F7D
    cmp #$04
    beq B06_8F7D
    lda #$92 ; String ID #$0292: ‘I would come with thee, [name],[wait][line]but my place is here beside the King[.’][end-FC]

    bne B06_8F7F
B06_8F7D:
    lda #$91 ; String ID #$0291: ‘By land and sea and air will thy path lead, and in places I cannot see[.’][end-FC]

B06_8F7F:
    jsr B0F_FA52 ; display string ID specified by A + #$0200

    jmp B06_9548 ; end TALK/ITEM routines


; handler for dialogue ID #$9F: Wizard in Map ID #$02: Midenhall 2F
B06_8F85:
    lda #$00 ; Midenhall

    jsr B0F_FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    lda $44 ; non-saved event status (#$00 = event start, #$01 = Lianport Gremlins defeated, #$02 = met with Lianport grandfather/have no friends at Shrine SW of Cannock, #$03 = King Midenhall moved to stairs, #$04 = King Midenhall moved down stairs, #$05 = King Midenhall spoke on Midenhall 1F, #$0B = Lighthouse Wizard 7F, #$1B Lighthouse Wizard 2F spoke, #$64 = Hargon dead, #$FF = event end)

    cmp #$03
    beq B06_8F94
    cmp #$04
    bne B06_8F9B
B06_8F94:
    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $93
    jmp B06_8FA9

B06_8F9B:
    jsr B06_9AD5 ; set A/$97 to ID of first living hero

    bne B06_8FA4 ; branch if Midenhall dead

    lda #$94 ; String ID #$0294: ‘Thou art now as strong as an ox and twice as good looking.[line]That is very good[.’][end-FC]

    bne B06_8FA6
B06_8FA4:
    lda #$95 ; String ID #$0295: ‘[name], it is such a pity[.’][end-FC]

B06_8FA6:
    jsr B0F_FA52 ; display string ID specified by A + #$0200

B06_8FA9:
    jmp B06_9548 ; end TALK/ITEM routines


; handler for dialogue ID #$A0: Brute in Map ID #$04: Midenhall B1
B06_8FAC:
    lda $05F2 ; probably whether door between you and NPC is open

    beq B06_8FC4
    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $96
    jsr B06_9AD0 ; open YES/NO menu, return selected option in A

    cmp #$00 ; YES

    bne B06_8FC0
    lda #$97 ; String ID #$0297: ‘Open this and I shall give thee some news[.’][end-FC]

    bne B06_8FC6
B06_8FC0:
    lda #$98 ; String ID #$0298: ‘Be gone with thee!’[end-FC]

    bne B06_8FC6
B06_8FC4:
    lda #$99 ; String ID #$0299: ‘As a reward for opening the door, let me tell thee of the Crest of Life[.’][wait][line]‘Find it on the dark road that leads to Rhone[.’][end-FC]

B06_8FC6:
    jsr B0F_FA52 ; display string ID specified by A + #$0200

    jmp B06_9548 ; end TALK/ITEM routines


; handler for dialogue ID #$A1: King in Map ID #$06: Cannock
B06_8FCC:
    jsr B06_9AD5 ; set A/$97 to ID of first living hero

    jsr B0F_FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    jsr B0F_F6CE ; return number of party members - 1 in A/X

    sta $49 ; object hero/target/item/string ID $49

    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $E2
    jsr B06_9466 ; display EXP to next level messages for entire party

    lda #$01 ; Cannock

    jsr B0F_FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    lda $CA ; Cannock runaround quest status (0 = start of game, 0 -> 1 = talked to King Cannock, 1 -> 2 = said YES to seeking Cannock in Spring of Bravery, 2 -> 3 = talked to King Midenhall; adding Cannock sets this to 3; some code checks for 4)

    beq B06_8FED
    cmp #$01
    beq B06_8FEF
    bne B06_8FF6
B06_8FED:
    inc $CA ; Cannock runaround quest status (0 = start of game, 0 -> 1 = talked to King Cannock, 1 -> 2 = said YES to seeking Cannock in Spring of Bravery, 2 -> 3 = talked to King Midenhall; adding Cannock sets this to 3; some code checks for 4)

B06_8FEF:
    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $9D
    jmp B06_9002

B06_8FF6:
    cmp #$03
    bne B06_9002
    lda $49 ; object hero/target/item/string ID $49

    bne B06_9002
    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $9E
B06_9002:
    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $87
    lda #$01 ; Save Point ID #$01: Cannock

    sta $48 ; last save point ID

    jsr B06_A35D ; save game handler

    lda #$01 ; Cannock

    jsr B0F_FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $9C
    jmp B06_9548 ; end TALK/ITEM routines


; handler for dialogue ID #$A2: Princess Halla in Map ID #$06: Cannock
B06_9019:
    lda $CA ; Cannock runaround quest status (0 = start of game, 0 -> 1 = talked to King Cannock, 1 -> 2 = said YES to seeking Cannock in Spring of Bravery, 2 -> 3 = talked to King Midenhall; adding Cannock sets this to 3; some code checks for 4)

    cmp #$04
    bne B06_9023
    lda #$A4 ; String ID #$02A4: [end-FC]

    bne B06_9039
B06_9023:
    jsr B0F_F6CE ; return number of party members - 1 in A/X

    bne B06_903F
    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $9F
    jsr B06_9AD0 ; open YES/NO menu, return selected option in A

    cmp #$00 ; YES

    bne B06_9037
    lda #$A0 ; String ID #$02A0: ‘Then I'll give thee some advice[.’][wait][line]‘My brother has gone searching for the Spring of Bravery, but he travels slowly[.’][end-FC]

    bne B06_9039
B06_9037:
    lda #$A1 ; String ID #$02A1: ‘Then I wish to be left alone[.’][end-FC]

B06_9039:
    jsr B0F_FA52 ; display string ID specified by A + #$0200

    jmp B06_9548 ; end TALK/ITEM routines


B06_903F:
    lda #$01 ; Cannock

    sta $97 ; subject hero ID $97

    lda #$80 ; Alive

    jsr B06_8D9A ; given hero ID in $97, and status in A, SEC if hero has that status, CLC otherwise

    bcc B06_9051
    jsr B06_8D25 ; print name of hero given by low 2 bits of $97 to [name] buffer $6119, terminated by #$FA

    lda #$A2 ; String ID #$02A2: ‘So, thou hast found my brother[.’][wait][line]‘Why dost thou tarry here when the world is in grave peril?’[end-FC]

    bne B06_9039
B06_9051:
    lda #$A3 ; String ID #$02A3: ‘Oh, no! He is as dead as a pork chop[.’][end-FC]

    bne B06_9039
; handler for dialogue ID #$A3: Wizard in Map ID #$06: Cannock
B06_9055:
    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $A5
    lda $051A ; something to do with whether you've opened the chest containing the Shield of Erdrick

    beq B06_9062
    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $A6
B06_9062:
    jmp B06_9548 ; end TALK/ITEM routines


; handler for dialogue ID #$A4-#$A5: Monsters in Map ID #$08: Hamlin Waterway
B06_9065:
    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $A9
    lda $05F2 ; probably whether door between you and NPC is open

    bne B06_9074
    jsr B0F_D1A1 ; handle Hamlin Waterway Gremlins fight

    jmp B06_8095 ; wipe menus and exit COMMAND menu


B06_9074:
    jmp B06_9548 ; end TALK/ITEM routines


; handler for dialogue ID #$A6: King Moonbrooke's Flame in Map ID #$09: Moonbrooke
B06_9077:
    lda #$02 ; Moonbrooke

    jsr B0F_FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $AA
    lda $0651 ; Moonbrooke status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    and #$84 ; pick out the Alive and In Party bits

    cmp #$84 ; is Moonbrooke alive and in your party?

    bne B06_9092 ; if yes, she gets extra text

    lda #$02 ; Moonbrooke

    jsr B0F_FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $AB
B06_9092:
    jmp B06_9548 ; end TALK/ITEM routines


; handler for dialogue ID #$A7: Guard in Map ID #$0A: Moonbrooke B1
B06_9095:
    jsr B06_9493 ; SEC if Moonbrooke in party, CLC otherwise

    bcc B06_90A1
    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $AD
    jmp B06_9548 ; end TALK/ITEM routines


B06_90A1:
    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $AC
    jmp B06_9548 ; end TALK/ITEM routines


; handler for dialogue ID #$A8: Wizard in Map ID #$0B: Lianport
B06_90A8:
    lda $059C ; NPC #$0C X-pos

    cmp #$0F
    bne B06_90B3
    lda #$B8 ; String ID #$02B8: ‘Farewell[.’][end-FC]

    bne B06_90B9
B06_90B3:
    lda $CF ; ship status (#$04 = on ship, #$02 = own ship, #$01 = beat Lianport Gremlins)

    bne B06_90BF
    lda #$AE ; String ID #$02AE: ‘We never lend boats to strangers, sorry[.’][end-FC]

B06_90B9:
    jsr B0F_FA52 ; display string ID specified by A + #$0200

    jmp B06_9548 ; end TALK/ITEM routines


B06_90BF:
    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $AF
    jsr B0F_D0F5 ; wait for a while and then wipe menu regions #$03, #$00, and #$01

    jsr B0F_CCA2
    jmp B06_8095 ; wipe menus and exit COMMAND menu


; handler for dialogue ID #$A9: Echoing Flute guy in NE in Map ID #$0B: Lianport
B06_90CC:
    lda #$25 ; Item ID #$25: Tresures

    jsr B06_A369 ; check for item A in party inventory, returning inventory index of item in A/X if found, #$FF if not

    bpl B06_90DE ; branch if found

    lda #$2A ; Item ID #$2A: Echoing Flute

    jsr B06_A369 ; check for item A in party inventory, returning inventory index of item in A/X if found, #$FF if not

    bpl B06_90E7 ; branch if found

    lda #$B0 ; String ID #$02B0: ‘The pirate ship Relentless sank in chill waters with a great treasure still aboard[.’][wait][line]‘Bring me this treasure and I shall pay a handsome fee[.’][end-FC]

    bne B06_90E9
B06_90DE:
    lda #$2A ; Item ID #$2A: Echoing Flute

    sta $0600, x ; Midenhall inventory item 1 (| #$40 if equipped); replace Tresures in party inventory with Echoing Flute

    lda #$B1 ; String ID #$02B1: ‘Thou hast done exceedingly well[.’][wait][line]‘As I promised I shall give thee the Echoing Flute as thy reward[.’][end-FC]

    bne B06_90E9
B06_90E7:
    lda #$B2 ; String ID #$02B2: ‘Thanks to thee I was greatly helped[.’][end-FC]

B06_90E9:
    jsr B0F_FA52 ; display string ID specified by A + #$0200

    jmp B06_9548 ; end TALK/ITEM routines


; handler for dialogue ID #$AA: Woman in Map ID #$0B: Lianport
B06_90EF:
    lda $0594 ; NPC #$0B X-pos

    cmp #$03
    bne B06_90FA
    lda #$B9 ; String ID #$02B9: ‘I am in thy debt.[line]Please see my grandfather[.’][wait][line]‘He is at the port where his ship is docked[.’][end-FC]

    bne B06_90FC
B06_90FA:
    lda #$B7 ; String ID #$02B7: ‘I wish thee speed and health[.’][end-FC]

B06_90FC:
    jsr B0F_FA52 ; display string ID specified by A + #$0200

    jmp B06_9548 ; end TALK/ITEM routines


; handler for dialogue ID #$AB: Brute in Map ID #$0B: Lianport
B06_9102:
    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $BA
    jsr B06_949D ; SEC if Moonbrooke alive, CLC otherwise

    bcc B06_910F
    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $BB
B06_910F:
    jmp B06_9548 ; end TALK/ITEM routines


; handler for dialogue ID #$AC: Woman in SW corner of Map ID #$0B: Lianport
B06_9112:
    jsr B06_949D ; SEC if Moonbrooke alive, CLC otherwise

    bcs B06_9145 ; if Moonbrooke's alive, display the boring string, otherwise...

    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $BC
    jsr B06_9AD0 ; open YES/NO menu, return selected option in A

    cmp #$00 ; #$00 = YES

    bne B06_9141 ; branch if you chose NO

    jsr B06_9AD5 ; set A/$97 to ID of first living hero

    jsr B06_8D25 ; print name of hero given by low 2 bits of $97 to [name] buffer $6119, terminated by #$FA

    lda #$64 ; 100 gold

    sta $8F
    lda #$00
    sta $90
    jsr B06_8D31 ; given gold amount in $8F-$90, decrease party gold by that amount and SEC if possible, CLC otherwise

    bcs B06_913D ; if you didn't have 100 G to start with, reduce party gold to 0 :(

    lda #$00
    sta $0624 ; party gold, low byte

    sta $0625 ; party gold, high byte

B06_913D:
    lda #$BD ; String ID #$02BD: ‘Perhaps the great Prince of Cannock thinks so too[.’][end-FC]

    bne B06_9147
B06_9141:
    lda #$BE ; String ID #$02BE: ‘What's wrong!’[end-FC]

    bne B06_9147
B06_9145:
    lda #$BF ; String ID #$02BF: ‘Be nice to one who lives here; she knows how to turn princes into tadpoles[.’][end-FC]

B06_9147:
    jsr B0F_FA52 ; display string ID specified by A + #$0200

    jmp B06_9548 ; end TALK/ITEM routines


; handler for dialogue ID #$AD: Wizard in Map ID #$0C: Tantegel
B06_914D:
    lda #$00
    sta $49 ; object hero/target/item/string ID $49

    sta $97 ; subject hero ID $97

B06_9153:
    jsr B06_9AFC ; given hero ID in $97 and hero inventory index in $49, set Z if item is equipped and cursed, clear if not

    beq B06_9162
    inc $49 ; object hero/target/item/string ID $49

    lda $49 ; object hero/target/item/string ID $49

    cmp #$18 ; party inventory size

    bne B06_9153
    beq B06_9166
B06_9162:
    lda #$C1 ; String ID #$02C1: ‘Unfortunately I have not the skill to cure this curse[.’][end-FC]

    bne B06_9168
B06_9166:
    lda #$C0 ; String ID #$02C0: ‘Come here when thou art afflicted by a curse[.’][end-FC]

B06_9168:
    jsr B0F_FA52 ; display string ID specified by A + #$0200

    jmp B06_9548 ; end TALK/ITEM routines


; handler for dialogue ID #$AE: Wizard in Map ID #$0C: Tantegel
B06_916E:
    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $C2
    jsr B0F_C515 ; flash screen 10 times

    jsr B06_8DEC ; restore full MP to all living party members

    jmp B06_9548 ; end TALK/ITEM routines


; handler for dialogue ID #$AF: Priest in Map ID #$0C: Tantegel
B06_917B:
    jsr B06_9AD5 ; set A/$97 to ID of first living hero

    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $C3
    jsr B06_9466 ; display EXP to next level messages for entire party

    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $A7
    lda #$02 ; Save Point ID #$02: Tantegel

    sta $48 ; last save point ID

    jsr B06_A35D ; save game handler

    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $C4
    jmp B06_9548 ; end TALK/ITEM routines


; handler for dialogue ID #$B0: King in Map ID #$0F: Osterfair
B06_9197:
    lda $98 ; outcome of last fight?

    beq B06_91A1
    cmp #$FC
    beq B06_91E3
    bne B06_91C6
B06_91A1:
    lda $0112 ; Crests found bit field (#$10 = Life, #$80 = Water, #$04 = Moon, #$02 = Stars, #$01 = Sun)

    and #$04 ; Moon Crest

    bne B06_91F4
    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $C5
    jsr B06_9AD0 ; open YES/NO menu, return selected option in A

    cmp #$00 ; YES

    bne B06_91ED
    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $C6
    jsr B0F_D0F5 ; wait for a while and then wipe menu regions #$03, #$00, and #$01

    lda #$00
    sta $98 ; outcome of last fight?

    sta $03 ; game clock?

    jsr B0F_CABA
    jmp B06_8095 ; wipe menus and exit COMMAND menu


B06_91C6:
    jsr B06_9ACB ; open dialogue window

    lda $0112 ; Crests found bit field (#$10 = Life, #$80 = Water, #$04 = Moon, #$02 = Stars, #$01 = Sun)

    and #$04 ; Moon Crest

    bne B06_91DC
    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $C7
    lda #$04 ; Moon Crest

    ora $0112 ; Crests found bit field (#$10 = Life, #$80 = Water, #$04 = Moon, #$02 = Stars, #$01 = Sun)

    sta $0112 ; Crests found bit field (#$10 = Life, #$80 = Water, #$04 = Moon, #$02 = Stars, #$01 = Sun)

B06_91DC:
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $15
    jmp B06_9548 ; end TALK/ITEM routines


B06_91E3:
    jsr B06_9ACB ; open dialogue window

    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $C9
    jmp B06_9548 ; end TALK/ITEM routines


B06_91ED:
    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $C8
    jmp B06_9548 ; end TALK/ITEM routines


B06_91F4:
    jsr B06_9AD5 ; set A/$97 to ID of first living hero

    jsr B0F_FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $EC
    jsr B06_9466 ; display EXP to next level messages for entire party

    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $87
    lda #$03 ; Save Point ID #$03: Osterfair

    sta $48 ; last save point ID

    jsr B06_A35D ; save game handler

    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $CA
    jmp B06_9548 ; end TALK/ITEM routines


; handler for dialogue ID #$B1: crazy fortuneteller Wizard in NW Map ID #$0F: Osterfair
B06_9213:
    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $CB
    jsr B06_9AD0 ; open YES/NO menu, return selected option in A

    cmp #$00 ; YES

    bne B06_9246
    jsr B0F_C3AB ; generate a random number and store it in $32-$33 (two passes)

    lda $32 ; RNG byte 0

    ora $33 ; RNG byte 1

    and #$03 ; 4 direction options to choose from

    tax
    inx
    lda B06_924E ; -> $06:$9250: Direction Names text

    sta $0C
    lda B06_924E+1
    sta $0D
    jsr B06_9266 ; given a pointer ($0C) and a number (one-based) in X, update $0C-$0D to the address of the start of the X'th string in ($0C)

    ldy #$00 ; copy direction name to $5A

B06_9238:
    lda ($0C), y
    sta $005A, y ; Crest/direction name write buffer start

    iny
; [end-FA]
    cmp #$FA
    bne B06_9238 ; if not end of string, loop to copy more data

    lda #$CC ; String ID #$02CC: ‘I'll tell thy fortune[.’][wait][line]‘That which thou seeks is [item-F9]!’[end-FC]

    bne B06_9248
B06_9246:
    lda #$CD ; String ID #$02CD: ‘So be it then.[line]I shall tell thee nothing[.’][end-FC]

B06_9248:
    jsr B0F_FA52 ; display string ID specified by A + #$0200

    jmp B06_9548 ; end TALK/ITEM routines

B06_924E:
.addr Directions

Directions:
.byte "East",$FA
.byte "West",$FA
.byte "South",$FA
.byte "North",$FA


; given a pointer ($0C) and a number (one-based) in X, update $0C-$0D to the address of the start of the X'th string in ($0C)
B06_9266:
    ldy #$00 ; start at the current position of ($0C)

B06_9268:
    lda ($0C), y
; [end-FA]
    cmp #$FA
    beq B06_927A ; found some end token

; [end-FC]
    cmp #$FC
    beq B06_927A ; found some end token

; [end-FF]
    cmp #$FF
    beq B06_927A ; found some end token

    iny
    jmp B06_9268

; found some end token
B06_927A:
    dex ; number of strings to skip ahead + 1

    beq B06_928A ; if no more strings to skip, then ($0C) is correct and we're done

    tya ; otherwise update $0C-$0D and loop to the next string

    sec
    adc $0C
    sta $0C
    bcc B06_9287
    inc $0D
B06_9287:
    jmp B06_9266 ; given a pointer ($0C) and a number (one-based) in X, update $0C-$0D to the address of the start of the X'th string in ($0C)


B06_928A:
    rts

; handler for dialogue IDs #$B2-#$B3: Dog in Map ID #$0F: Osterfair
B06_928B:
    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $CF
    jmp B06_9548 ; end TALK/ITEM routines


; handler for dialogue ID #$B4: Dog in Map ID #$10: Zahan
B06_9292:
    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $D0
    jmp B06_9548 ; end TALK/ITEM routines


; handler for dialogue ID #$B5: Don Mahone in Map ID #$11: Tuhn
B06_9299:
    lda $CD ; Don Mahone quest status (#$00 = not started, #$01 = ingredients delivered, #$03 = game loaded after ingredients delivered)

    beq B06_92BA
    cmp #$03
    bne B06_92AE
    lda #$02 ; Moonbrooke

    sta $97 ; subject hero ID $97

    lda #$13 ; Item ID #$13: Water Flying Cloth

    sta $96 ; temp storage for item/spell/type/etc. IDs

    jsr B06_8D7E ; given hero ID in $97 and item ID in $96, try to add item to first empty slot in hero's inventory; SEC if added, CLC if no empty slots

    bcs B06_92B2
B06_92AE:
    lda #$D5 ; String ID #$02D5: ‘Sorry.[line]I haven't finished it yet.[line]Please be patient[.’][end-FC]

    bne B06_92F8 ; display string, end TALK routine

B06_92B2:
    lda #$00
    sta $CD ; Don Mahone quest status (#$00 = not started, #$01 = ingredients delivered, #$03 = game loaded after ingredients delivered)

    lda #$D6 ; String ID #$02D6: ‘Hello.[line]I've just finished[.’][wait][line]‘See that the princess wears this[.’][end-FC]

    bne B06_92F8 ; display string, end TALK routine

B06_92BA:
    lda #$2C ; Item ID #$2C: Dew’s Yarn

    jsr B06_A369 ; check for item A in party inventory, returning inventory index of item in A/X if found, #$FF if not

    bmi B06_92E7
    lda #$2D ; Item ID #$2D: Magic Loom

    jsr B06_A369 ; check for item A in party inventory, returning inventory index of item in A/X if found, #$FF if not

    bmi B06_92E7
    jsr B06_94A7 ; X = A mod 8, A = A / 8

    sta $9C ; hero ID

    lda #$2D ; Item ID #$2D: Magic Loom

    jsr B0F_C4B6 ; given a hero ID in $9C and an item ID in A, remove that item from hero's inventory if present and SEC, CLC otherwise

    lda #$2C ; Item ID #$2C: Dew’s Yarn

    pha ; Item ID #$2C: Dew’s Yarn

    jsr B06_A369 ; check for item A in party inventory, returning inventory index of item in A/X if found, #$FF if not

    jsr B06_94A7 ; X = A mod 8, A = A / 8

    sta $9C ; hero ID

    pla ; Item ID #$2C: Dew’s Yarn

    jsr B0F_C4B6 ; given a hero ID in $9C and an item ID in A, remove that item from hero's inventory if present and SEC, CLC otherwise

    inc $CD ; Don Mahone quest status (#$00 = not started, #$01 = ingredients delivered, #$03 = game loaded after ingredients delivered)

    lda #$D4 ; String ID #$02D4: ‘Ah, so thou has found my loom, and the Dew's Yarn, too[.’][wait][line]‘I shall weave thee a Water Flying Cloth, but it will take time[.’][wait][line]‘Please come back in a day or so[.’][end-FC]

    bne B06_92F8 ; display string, end TALK routine

B06_92E7:
    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $D1
    jsr B06_9AD0 ; open YES/NO menu, return selected option in A

    cmp #$00 ; YES

    bne B06_92F6
    lda #$D2 ; String ID #$02D2: ‘Good, good.[line]All I can tell thee is that the loom was taken by someone who smelled like fish[.’][end-FC]

    bne B06_92F8 ; display string, end TALK routine

B06_92F6:
    lda #$D3 ; String ID #$02D3: ‘That's too bad.[line]We could help each other[.’][end-FC]

; display string, end TALK routine
B06_92F8:
    jsr B0F_FA52 ; display string ID specified by A + #$0200

    jmp B06_9548 ; end TALK/ITEM routines


; handler for dialogue ID #$B6: Roge Fastfinger in NE Map ID #$14: Wellgarth Underground
B06_92FE:
    lda $CE ; Tuhn Watergate open flag (#$00 = closed, #$01 = open)

    bne B06_9324
    lda #$3A ; Item ID #$3A: Watergate Key

    sta $96 ; temp storage for item/spell/type/etc. IDs

    jsr B06_A369 ; check for item A in party inventory, returning inventory index of item in A/X if found, #$FF if not

    bpl B06_9324
    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $D7
    lda #$00 ; Midenhall

B06_9311:
    sta $97 ; subject hero ID $97

    jsr B06_8D7E ; given hero ID in $97 and item ID in $96, try to add item to first empty slot in hero's inventory; SEC if added, CLC if no empty slots

    bcs B06_9329
    inc $97 ; subject hero ID $97

    lda $97 ; subject hero ID $97

    cmp #$03 ; max of 3 heroes

    bne B06_9311 ; if more heroes to check, check them

    lda #$D8 ; String ID #$02D8: [wait]‘But thou hast many things.[line]See me again later[.’][end-FC]

    bne B06_9326
B06_9324:
    lda #$D9 ; String ID #$02D9: ‘I'm sorry; I will not do that anymore[.’][end-FC]

B06_9326:
    jsr B0F_FA52 ; display string ID specified by A + #$0200

B06_9329:
    jmp B06_9548 ; end TALK/ITEM routines


; handler for dialogue IDs #$B7-#$B9: Priest in Map ID #$15: Beran
B06_932C:
    lda $CA ; Cannock runaround quest status (0 = start of game, 0 -> 1 = talked to King Cannock, 1 -> 2 = said YES to seeking Cannock in Spring of Bravery, 2 -> 3 = talked to King Midenhall; adding Cannock sets this to 3; some code checks for 4)

    cmp #$04
    bcs B06_9336
    lda #$E1 ; String ID #$02E1: ‘I see that thou hast faced many dangers and the greatest lie ahead[.’][end-FC]

    bne B06_9338
B06_9336:
    lda #$E2 ; String ID #$02E2: ‘Welcome, [name]!’[wait][end-FC]

B06_9338:
    jsr B0F_FA52 ; display string ID specified by A + #$0200

    jmp B06_9548 ; end TALK/ITEM routines


; handler for dialogue ID #$BA: Monster in Map ID #$16: Hargon's Castle 1F
B06_933E:
    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $E3
    jsr B0F_D1C6
    jmp B06_8095 ; wipe menus and exit COMMAND menu


; handler for dialogue ID #$BB: Hargon in Map ID #$17: Hargon's Castle 7F
B06_9348:
    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $E4
    jsr B06_9AD0 ; open YES/NO menu, return selected option in A

    cmp #$00 ; YES

    bne B06_9357
    lda #$E5 ; String ID #$02E5: ‘Such audacity is unforgivable!’[end-FC]

    bne B06_9359
B06_9357:
    lda #$E6 ; String ID #$02E6: ‘Then I shall teach the proper respect!’[end-FC]

B06_9359:
    jsr B0F_FA52 ; display string ID specified by A + #$0200

    jsr B0F_D0F5 ; wait for a while and then wipe menu regions #$03, #$00, and #$01

    jsr B0F_D1F8 ; trigger Fixed Battle #$0B: 1 Hargon (Map ID #$17: Hargon's Castle 7F)

    lda $98 ; outcome of last fight?

    cmp #$FC
    beq B06_937C
    jsr B0F_F6F6 ; open main dialogue window and display string ID specified by byte following JSR + #$0200
    .byte $E7
    lda #$FF
    sta $0561 ; NPC #$04 sprite ID

    jsr B0F_CF64
    jsr B0F_D0F5 ; wait for a while and then wipe menu regions #$03, #$00, and #$01

    lda #$64
    sta $44 ; non-saved event status (#$00 = event start, #$01 = Lianport Gremlins defeated, #$02 = met with Lianport grandfather/have no friends at Shrine SW of Cannock, #$03 = King Midenhall moved to stairs, #$04 = King Midenhall moved down stairs, #$05 = King Midenhall spoke on Midenhall 1F, #$0B = Lighthouse Wizard 7F, #$1B Lighthouse Wizard 2F spoke, #$64 = Hargon dead, #$FF = event end)

    rts

B06_937C:
    jmp B06_9548 ; end TALK/ITEM routines


; handler for dialogue ID #$BC: Dragonlord's Grandson in Map ID #$18: Charlock Castle B8
B06_937F:
    lda #$00 ; Midenhall

    jsr B0F_FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $EA
    jsr B06_9AD0 ; open YES/NO menu, return selected option in A

    cmp #$00 ; YES

    bne B06_9393
    lda #$F0 ; String ID #$02F0: ‘Once thou hast the five crests, seek out the good wizard, Rubiss,[wait][line]who dwells in the depths of the sea south of Midenhall[.’][end-FC]

    bne B06_9395
B06_9393:
    lda #$F1 ; String ID #$02F1: ‘Thou art surely missing thy brain.[line]But it is up to thee[.’][end-FC]

B06_9395:
    jsr B0F_FA52 ; display string ID specified by A + #$0200

    jmp B06_9548 ; end TALK/ITEM routines


; handler for dialogue ID #$BD: Guard in Map ID #$1A: Shrine SW of Cannock
B06_939B:
    lda #$BD ; dialogue ID

    bne B06_93A1
; handler for dialogue ID #$BE: Guard in Map ID #$1A: Shrine SW of Cannock
B06_939F:
    lda #$BE ; dialogue ID

B06_93A1:
    sta $49 ; object hero/target/item/string ID $49

    jsr B0F_F6CE ; return number of party members - 1 in A/X

    bne B06_93B6 ; if Midenhall is alone, he can't pass

    lda $49 ; object hero/target/item/string ID $49

    cmp #$BD
    bne B06_93B2
    lda #$F3 ; String ID #$02F3: ‘It is dangerous to tread some roads alone[.’][end-FC]

    bne B06_93B8
B06_93B2:
    lda #$F4 ; String ID #$02F4: ‘The King of Cannock has left orders that none shall pass alone[.’][end-FC]

    bne B06_93B8
B06_93B6:
    lda #$EB ; String ID #$02EB: ‘Please go through[.’][end-FC]

B06_93B8:
    jsr B0F_FA52 ; display string ID specified by A + #$0200

    jmp B06_9548 ; end TALK/ITEM routines


; handler for dialogue ID #$BF: Wizard in Map ID #$1C: Shrine SE of Rimuldar
B06_93BE:
    lda #$23 ; Item ID #$23: Helmet of Erdrick

    jsr B06_A369 ; check for item A in party inventory, returning inventory index of item in A/X if found, #$FF if not

    bmi B06_93C9
    lda #$F7 ; String ID #$02F7: ‘Thou hast no further business here. Go[.’][end-FC]

    bne B06_93DB
B06_93C9:
    lda #$24 ; Item ID #$24: Token of Erdrick

    jsr B06_A369 ; check for item A in party inventory, returning inventory index of item in A/X if found, #$FF if not

    bpl B06_93D4
    lda #$F5 ; String ID #$02F5: ‘The real descendant of Erdrick carries a token to prove his heritage[.’][wait][line]‘Now be off with thee, imposter[.’][end-FC]

    bne B06_93DB
B06_93D4:
    lda #$23 ; Item ID #$23: Helmet of Erdrick

    sta $0600, x ; Midenhall inventory item 1 (| #$40 if equipped)

    lda #$F6 ; String ID #$02F6: ‘I have been waiting for thee to come[.’][wait][line]‘I will trade the Helmet of Erdrick for the token thou carries[.’][end-FC]

B06_93DB:
    jsr B0F_FA52 ; display string ID specified by A + #$0200

    jmp B06_9548 ; end TALK/ITEM routines


; handler for dialogue ID #$C0: Wizard in Map ID #$15: Beran
B06_93E1:
    lda #$04 ; Save Point ID #$04: Beran

; update save point $48 to A, run through the whole save point sequence
B06_93E3:
    sta $48 ; last save point ID

    jsr B06_9AD5 ; set A/$97 to ID of first living hero

    jsr B0F_FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $F8
    jsr B06_9466 ; display EXP to next level messages for entire party

    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $87
    jsr B06_A35D ; save game handler

    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $F9
    jmp B06_9548 ; end TALK/ITEM routines


; handler for dialogue ID #$C1: Priest in Map ID #$1F: Rhone Shrine
B06_9400:
    jsr B06_9AD5 ; set A/$97 to ID of first living hero

    pha ; ID of first living hero at start of conversation

    jsr B0F_FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $FA
    jsr B0F_C515 ; flash screen 10 times

    lda #$84 ; everybody's alive and in your party!

    sta $062D ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    sta $063F ; Cannock status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    sta $0651 ; Moonbrooke status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    jsr B0F_C77B ; restore full HP/MP to all living party members

    lda #$00
    sta $97 ; subject hero ID $97

    jsr B0F_D302
    lda #$01
    sta $97 ; subject hero ID $97

    jsr B0F_D302
    lda #$02
    sta $97 ; subject hero ID $97

    jsr B0F_D302
    jsr B0F_C22C
    jsr B06_9466 ; display EXP to next level messages for entire party

    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $87
    lda #$05 ; Save Point ID #$05: Rhone Shrine

    sta $48 ; last save point ID

    jsr B06_A35D ; save game handler

    pla ; ID of first living hero at start of conversation

    jsr B0F_FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $FB
    jmp B06_9548 ; end TALK/ITEM routines


; handler for dialogue ID #$C2: Priest in Map ID #$20: Shrine SW of Moonbrooke
B06_944D:
    lda #$02 ; Moonbrooke

    sta $97 ; subject hero ID $97

    lda #$04 ; In Party

    jsr B06_8D9A ; given hero ID in $97, and status in A, SEC if hero has that status, CLC otherwise

    bcs B06_945F
    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $FC
    jmp B06_9548 ; end TALK/ITEM routines


B06_945F:
    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $00
    jmp B06_9548 ; end TALK/ITEM routines


; display EXP to next level messages for entire party
B06_9466:
    lda #$00 ; Midenhall

    sta $97 ; subject hero ID $97

B06_946A:
    lda #$04 ; In Party

    jsr B06_8D9A ; given hero ID in $97, and status in A, SEC if hero has that status, CLC otherwise

; skip if not in party
    bcc B06_948A
    lda $97 ; subject hero ID $97

    jsr B0F_F734 ; set $8F-$90 to EXP required to reach next level

    jsr B06_8D25 ; print name of hero given by low 2 bits of $97 to [name] buffer $6119, terminated by #$FA

    lda $8F
    ora $90
    bne B06_9486 ; different messages depending on whether you're at max EXP or not

    jsr B0F_FA2A ; display string ID specified by next byte
    .byte $52
    jmp B06_948A

B06_9486:
    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $8F
B06_948A:
    inc $97 ; subject hero ID $97

    lda $97 ; subject hero ID $97

    cmp #$03 ; max of 3 heroes

    bcc B06_946A ; if more heroes to handle, handle them

    rts

; SEC if Moonbrooke in party, CLC otherwise
B06_9493:
    lda #$02 ; Moonbrooke

    sta $97 ; subject hero ID $97

    lda #$04 ; In Party

    jsr B06_8D9A ; given hero ID in $97, and status in A, SEC if hero has that status, CLC otherwise

    rts

; SEC if Moonbrooke alive, CLC otherwise
B06_949D:
    lda #$02 ; Moonbrooke

    sta $97 ; subject hero ID $97

    lda #$80 ; Alive

    jsr B06_8D9A ; given hero ID in $97, and status in A, SEC if hero has that status, CLC otherwise

    rts

; X = A mod 8, A = A / 8
B06_94A7:
    pha
    and #$07
    tax
    pla
    lsr
    lsr
    lsr
    rts

; handler for dialogue IDs #$C3-#$CC (open dialogue window and display string specified by A - #$73)
B06_94B0:
    sec
    sbc #$73 ; convert to string ID

    pha
    jsr B06_9ACB ; open dialogue window

    pla ; String IDs #$50-#$59: "‘Take care that thou strays not over the tower's edge[.’][end-FC]" / "‘As the full moon waxes and wanes so too the tide rises and falls[.’][end-FC]" / "‘[name] is now strong enough[.’][wait][end-FC]" / "And [cardinal #] [monster(s)][line]appeared.[end-FC]" / "[cardinal #] [monster(s)][line]appeared.[end-FC]" / "[end-FC]" / "[end-FC]" / "‘In ancient times a volcano rose from the seabed, and inside was a deep cavern[.’][end-FC]" / "[end-FC]" / "[end-FC]"

    jsr B0F_FA4A ; display string ID specified by A

    jmp B06_9548 ; end TALK/ITEM routines


; handler for dialogue IDs #$CD-#$CF (open dialogue window, display string specified by A - #$73, display YES/NO menu, and display string corresponding to selected option)
B06_94BE:
    sec
    sbc #$CD ; why not just SBC #$73?

    clc
    adc #$5A ; String IDs #$5A-#$5C: "‘Hast thou purified thy body in the Spring of Bravery?’[end-FC]" / "‘Dost thou know what I know?’[FD][FD][end-FC]" / "‘Hast thou found the Wizard's Home?’[FD][FD][end-FC]"

    sta $49 ; object hero/target/item/string ID $49

    jsr B06_9ACB ; open dialogue window

    lda $49 ; object hero/target/item/string ID $49

    jsr B0F_FA4A ; display string ID specified by A

    jsr B06_9AD0 ; open YES/NO menu, return selected option in A

    cmp #$00 ; YES

    bne B06_94D9
    lda #$03 ; String IDs #$5D-#$5F: "‘Then all is well[.’][end-FC]" / "‘But I have not yet spoken[.’][end-FC]" / "‘Go then, for thou must defeat Hargon[.’][end-FC]"

    bne B06_94DB
B06_94D9:
    lda #$06 ; String IDs #$60-#$62: "‘That is not good[.’][wait][line]‘All who seek victory must first visit the Spring of Bravery[.’][end-FC]" / "‘These twin towers are known as the Dragon's Horn[.’][end-FC]" / "‘Thou art close to the island cave wherein lies an object of great power and greater peril!’[end-FC]"

B06_94DB:
    clc
    adc $49 ; object hero/target/item/string ID $49

    jsr B0F_FA4A ; display string ID specified by A

    jmp B06_9548 ; end TALK/ITEM routines


; handler for dialogue IDs #$D0-#$D8 (dungeon NPCs with complex logic)
B06_94E4:
    pha ; dialogue ID

    jsr B06_9ACB ; open dialogue window

    pla ; dialogue ID

    cmp #$D0 ; dialogue ID #$D0: Wizard in Map ID #$40: Spring of Bravery

    bne B06_9525
    jsr B0F_FA2A ; display string ID specified by next byte
    .byte $6A
    lda $CA ; Cannock runaround quest status (0 = start of game, 0 -> 1 = talked to King Cannock, 1 -> 2 = said YES to seeking Cannock in Spring of Bravery, 2 -> 3 = talked to King Midenhall; adding Cannock sets this to 3; some code checks for 4)

    cmp #$01
    beq B06_94FB
    cmp #$02
    bne B06_9515
B06_94FB:
    jsr B0F_FA2A ; display string ID specified by next byte
    .byte $64
    jsr B06_9AD0 ; open YES/NO menu, return selected option in A

    cmp #$00 ; YES

    bne B06_9515
    lda $CA ; Cannock runaround quest status (0 = start of game, 0 -> 1 = talked to King Cannock, 1 -> 2 = said YES to seeking Cannock in Spring of Bravery, 2 -> 3 = talked to King Midenhall; adding Cannock sets this to 3; some code checks for 4)

    cmp #$01
    bne B06_950E
    inc $CA ; Cannock runaround quest status (0 = start of game, 0 -> 1 = talked to King Cannock, 1 -> 2 = said YES to seeking Cannock in Spring of Bravery, 2 -> 3 = talked to King Midenhall; adding Cannock sets this to 3; some code checks for 4)

B06_950E:
    jsr B0F_FA2A ; display string ID specified by next byte
    .byte $65
    jmp B06_9548 ; end TALK/ITEM routines


B06_9515:
    jsr B0F_FA2A ; display string ID specified by next byte
    .byte $63
    jsr B0F_C515 ; flash screen 10 times

    jsr B06_8DCC ; restore full HP to all living party members

    jsr B0F_C22C
    jmp B06_9548 ; end TALK/ITEM routines


B06_9525:
    cmp #$D1 ; dialogue ID #$D1: Wizard in Map ID #$56: Lighthouse 7F

    bne B06_9530
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $52
    jmp B06_9548 ; end TALK/ITEM routines


B06_9530:
    cmp #$D6 ; dialogue ID #$D6: Guard in Map ID ; Map ID #$57: Lighthouse 8F

    bne B06_953F
    jsr B0F_FA2A ; display string ID specified by next byte
    .byte $70
    jsr B0F_FA2A ; display string ID specified by next byte
    .byte $71
    jmp B06_9548 ; end TALK/ITEM routines


B06_953F:
    jmp B06_9548 ; end TALK/ITEM routines


; exit COMMAND menu
B06_9542:
    jsr B0F_FA89 ; useless JSR to RTS?!

    jmp B06_806D ; exit COMMAND menu


; end TALK/ITEM routines
B06_9548:
    lda $8E ; flag for in battle or not (#$FF)?

    bpl B06_954D
    rts

B06_954D:
    jsr B06_809D ; wait until all joypad buttons are released and then some button pressed

    jsr B0F_FA89 ; useless JSR to RTS?!

    lda #$00
    jsr B0F_CF6A ; wipe selected menu region

    jmp B06_806D ; exit COMMAND menu


; COMMAND menu ITEM command handler
B06_955B:
    jsr B0F_F55D ; display appropriate main ITEM hero select menu

    cmp #$FF
    beq B06_9542 ; exit COMMAND menu

    sta $97 ; subject hero ID $97

    jsr B0F_F5FE ; given a hero ID in A, open hero's item list and return selected item ID (or #$FE if they have no items)

    cmp #$FF
    beq B06_9542 ; exit COMMAND menu

    cmp #$FE
    bne B06_957E ; hero has selected an item to use

    jsr B06_9ACB ; open dialogue window

    lda $97 ; subject hero ID $97

    jsr B0F_FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $13
    jmp B06_9548 ; end TALK/ITEM routines


; hero has selected an item to use
B06_957E:
    sta $96 ; temp storage for item/spell/type/etc. IDs; item ID

    sta $95 ; ID for [item] and [spell] control codes; item ID

    stx $49 ; object hero/target/item/string ID $49

    jsr B0F_EB76 ; open menu specified by next byte
    .byte $17
    cmp #$FF
    beq B06_9542 ; exit COMMAND menu

    cmp #$01 ; TRADE

    bcc B06_9593 ; USE handler

    jmp B06_99A8 ; TRADE/THROW handler


; USE handler
B06_9593:
    lda #$80 ; Alive

    jsr B06_8D9A ; given hero ID in $97, and status in A, SEC if hero has that status, CLC otherwise

    bcs B06_95A7 ; USE handler, hero alive

    jsr B06_9ACB ; open dialogue window

    jsr B06_8D25 ; print name of hero given by low 2 bits of $97 to [name] buffer $6119, terminated by #$FA

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $1F
    jmp B06_9548 ; end TALK/ITEM routines


; USE handler, hero alive
B06_95A7:
    lda $96 ; temp storage for item/spell/type/etc. IDs; item ID

    cmp #$3C ; Item ID #$3C: Medical Herb

    beq B06_95B1 ; USE Medical/Antidote Herb

    cmp #$3B ; Item ID #$3B: Antidote Herb

    bne B06_9625
; USE Medical/Antidote Herb
B06_95B1:
    jsr B0F_F587 ; display appropriate main ITEM target menu

    cmp #$FF
    bne B06_95BB
    jmp B06_9542 ; exit COMMAND menu


B06_95BB:
    sta $C9 ; target hero ID

    jsr B06_9ACB ; open dialogue window

    jsr B06_8D25 ; print name of hero given by low 2 bits of $97 to [name] buffer $6119, terminated by #$FA

    lda $97 ; subject hero ID $97

    cmp $C9 ; target hero ID

    beq B06_95D6 ; use different strings depending on whether hero uses item on themself or another hero

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $20
    lda $C9 ; target hero ID

    jsr B0F_FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    lda #$1D ; String ID #$011D: used the [item] on [name].[end-FC]

    bne B06_95D8
B06_95D6:
    lda #$1E ; String ID #$011E: [name] used the [item].[end-FC]

B06_95D8:
    jsr B0F_FA4E ; display string ID specified by A + #$0100

    lda $97 ; subject hero ID $97

    pha ; subject hero ID

    lda $C9 ; target hero ID

    sta $97 ; subject hero ID $97

    lda $96 ; temp storage for item/spell/type/etc. IDs; item ID

    cmp #$3C ; Item ID #$3C: Medical Herb

    bne B06_9606 ; USE Antidote Herb

    lda #$80 ; Alive

    jsr B06_8D9A ; given hero ID in $97, and status in A, SEC if hero has that status, CLC otherwise

    bcc B06_95F9 ; Medical Herbs can't heal dead people

    lda $C9 ; target hero ID

    ldx #$64 ; Healing Power on field for Medical Herb

    jsr B0F_F72B ; heal hero ID in A by random amount based on healing power in X

    jsr B0F_C22C
B06_95F9:
    pla ; subject hero ID

    ldx $49 ; object hero/target/item/string ID $49

    jsr B0F_C4D4 ; given hero ID in A and hero inventory offset in X, remove that item from hero's inventory and move all lower items up 1 slot

    jsr B0F_EB76 ; open menu specified by next byte
    .byte $01
    jmp B06_9548 ; end TALK/ITEM routines


; USE Antidote Herb
B06_9606:
    lda #$80 ; Alive

    jsr B06_8D9A ; given hero ID in $97, and status in A, SEC if hero has that status, CLC otherwise

    bcc B06_95F9 ; Antidote Herbs can't heal dead people

    lda $C9 ; target hero ID

    jsr B06_8DAC ; given hero ID in A, set Y to start of hero's data in $062D, y, i.e. Y = A * #$12

    lda #$DF ; clear Poison

    and $062D, y ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    sta $062D, y ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    jmp B06_95F9

; given hero ID in $97 and hero inventory offset in $49, remove that item from hero's inventory and move all lower items up 1 slot
B06_961D:
    lda $97 ; subject hero ID $97

    ldx $49 ; object hero/target/item/string ID $49

    jsr B0F_C4D4 ; given hero ID in A and hero inventory offset in X, remove that item from hero's inventory and move all lower items up 1 slot

    rts

B06_9625:
    cmp #$29 ; Item ID #$29: Leaf of The World Tree

    bne B06_964E
    jsr B0F_F587 ; display appropriate main ITEM target menu

    cmp #$FF
    bne B06_9633 ; USE Item ID #$29: Leaf of The World Tree on target hero

    jmp B06_9542 ; exit COMMAND menu


; USE Item ID #$29: Leaf of The World Tree on target hero
B06_9633:
    pha ; target hero ID

    jsr B06_961D ; given hero ID in $97 and hero inventory offset in $49, remove that item from hero's inventory and move all lower items up 1 slot

    jsr B06_9ACB ; open dialogue window

    jsr B06_8D25 ; print name of hero given by low 2 bits of $97 to [name] buffer $6119, terminated by #$FA

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $20
    pla ; target hero ID

    sta $49 ; object hero/target/item/string ID $49

    jsr B0F_FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $32
    jmp B06_8C9F ; spell ID is not #$09, #$0B, #$0D, #$10, or #$12-#$16; ergo it's Spell ID #$17: Revive


B06_964E:
    pha ; item ID

    jsr B06_9ACB ; open dialogue window

    jsr B06_8D25 ; print name of hero given by low 2 bits of $97 to [name] buffer $6119, terminated by #$FA

    pla ; item ID

    cmp #$35 ; Item ID #$35: Wing of the Wyvern

    bne B06_9664
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $21
    jsr B06_961D ; given hero ID in $97 and hero inventory offset in $49, remove that item from hero's inventory and move all lower items up 1 slot

    jmp B06_8C51 ; handler for Return spell effect


B06_9664:
    cmp #$25 ; Item ID #$25: Tresures

    bne B06_966F
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $29
    jmp B06_9548 ; end TALK/ITEM routines


B06_966F:
    cmp #$34 ; Item ID #$34: Fairy Water

    bne B06_9681
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $2A
    lda #$FF
    sta $46 ; Repel (#$FE) / Fairy Water (#$FF) flag

    jsr B06_961D ; given hero ID in $97 and hero inventory offset in $49, remove that item from hero's inventory and move all lower items up 1 slot

    jmp B06_9548 ; end TALK/ITEM routines


B06_9681:
    cmp #$28 ; Item ID #$28: Eye of Malroth

    bne B06_96D0
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $31
    lda $31 ; current map ID

    cmp #$01 ; Map ID #$01: World Map

    bne B06_96B3 ; if not World Map, go check Hagon's Castle 1F

    lda $05F9 ; flag for Cave to Rhone open

    bne B06_96C9 ; item useless here

    lda $16 ; current map X-pos (1)

    cmp #$71 ; X-pos range for successful use: #$71 - #$76 inclusive

    bcc B06_96C9 ; item useless here

    cmp #$77
    bcs B06_96C9 ; item useless here

    lda $17 ; current map Y-pos (1)

    cmp #$C6 ; Y-pos range for successful use: #$C6 - #$C8 inclusive

    bcc B06_96C9 ; item useless here

    cmp #$C9
    bcs B06_96C9 ; item useless here

    jsr B0F_D0F5 ; wait for a while and then wipe menu regions #$03, #$00, and #$01

    ldx #$3C
    jsr B0F_C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

    jmp B0F_D23E

B06_96B3:
    cmp #$16 ; Map ID #$16: Hargon's Castle 1F

    bne B06_96C9 ; item useless here

    jsr B0F_CD26 ; set Z if your current map position is the (X, Y) co-ordinates given by the next 2 bytes
    .byte $0D,$04
    bne B06_96C9 ; item useless here

    ldx #$78
    jsr B0F_C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

    jsr B0F_C515 ; flash screen 10 times

    jmp B0F_D7A6

; item useless here
B06_96C9:
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $27
    jmp B06_9548 ; end TALK/ITEM routines


B06_96D0:
    cmp #$2B ; Item ID #$2B: Mirror of Ra

    bne B06_9748
    jsr B06_8D25 ; print name of hero given by low 2 bits of $97 to [name] buffer $6119, terminated by #$FA

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $36
    lda #$00
    sta $96 ; temp storage for item/spell/type/etc. IDs

B06_96DF:
    lda $96 ; temp storage for item/spell/type/etc. IDs

    jsr B0F_CF70
    lda $0C
    cmp #$02 ; Moonbrooke

    beq B06_96F9
    inc $96 ; temp storage for item/spell/type/etc. IDs

    lda $96 ; temp storage for item/spell/type/etc. IDs

    cmp #$04
    bne B06_96DF
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $27
    jmp B06_9548 ; end TALK/ITEM routines


B06_96F9:
    lda #$02 ; Moonbrooke; useless op

    jsr B0F_FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $37
    lda $97 ; subject hero ID $97

    ldx $49 ; object hero/target/item/string ID $49

    jsr B0F_C4D4 ; given hero ID in A and hero inventory offset in X, remove that item from hero's inventory and move all lower items up 1 slot

    jsr B0F_D0F5 ; wait for a while and then wipe menu regions #$03, #$00, and #$01

    ldx #$28
    jsr B0F_C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

    lda #$00
    sta $054A ; NPC #$01 scripted motion low byte

    sta $054B ; NPC #$01 scripted motion high byte

    lda #$09
    ldy #$1F
    jsr B0F_CD45
    lda #$02
    ldy #$1F
    jsr B0F_CD4B
    jsr B06_8172
    lda #$84 ; add Moonbrooke to party

    sta $0651 ; Moonbrooke status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    lda #$02
    sta $0551 ; NPC #$02 sprite ID

B06_9734:
    jsr B06_9ACB ; open dialogue window

    lda #$02 ; Moonbrooke

    jsr B0F_FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $57
    lda #$07 ; Music ID #$07: add party member BGM

    jsr B0F_C58D ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM]), wait for it to finish, then play previous BGM

    jmp B06_9548 ; end TALK/ITEM routines


B06_9748:
    cmp #$2C ; Item ID #$2C: Dew’s Yarn

    beq B06_9750
    cmp #$2D ; Item ID #$2D: Magic Loom

    bne B06_9757
B06_9750:
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $38
    jmp B06_9548 ; end TALK/ITEM routines


B06_9757:
    cmp #$37 ; Item ID #$37: Golden Key

    bne B06_975F
    lda #$01
    bne B06_9773
B06_975F:
    cmp #$38 ; Item ID #$38: Silver Key

    bne B06_9767
    lda #$00
    beq B06_9773
B06_9767:
    cmp #$39 ; Item ID #$39: Jailor’s Key

    beq B06_9771
    cmp #$3A ; Item ID #$3A: Watergate Key

    beq B06_978D ; check Watergate

    bne B06_97E9
B06_9771:
    lda #$02
B06_9773:
    sta $C9
    jsr B0F_CF7C
    lda $49 ; object hero/target/item/string ID $49

    bne B06_9784
    lda $96 ; temp storage for item/spell/type/etc. IDs

    cmp #$39 ; Item ID #$39: Jailor’s Key

    beq B06_97D9
    bne B06_97D5
B06_9784:
    cmp #$01
    beq B06_97E1 ; wrong key for door

    lda #$58 ; String ID #$0158: The door opened.[end-FC]

    jmp B06_97E3

; check Watergate
B06_978D:
    lda $31 ; current map ID

    cmp #$12 ; Map ID #$12: Tuhn Watergate

    bne B06_97DD
    jsr B0F_CD26 ; set Z if your current map position is the (X, Y) co-ordinates given by the next 2 bytes
    .byte $02,$04
    bne B06_97DD
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $59
    jsr B0F_D0F5 ; wait for a while and then wipe menu regions #$03, #$00, and #$01

    lda $97 ; subject hero ID $97

    sta $9C
    lda #$3A ; Item ID #$3A: Watergate Key

    jsr B0F_C4B6 ; given a hero ID in $9C and an item ID in A, remove that item from hero's inventory if present and SEC, CLC otherwise

    lda #$04
    sta $20 ; map exterior border tile ID (#$00 = Road, #$01 = Grass, #$02 = Sand, #$03 = Tree, #$04 = Water, #$05 = Vertical Wall, #$06 = Shrub, #$07 = Horizontal Wall, #$08 = Swamp, ..., #$20 = Ceiling Alternating?, #$21 = Ceiling Down?, #$24 = Black?, #$28 = Blue?)

    lda #$01
    sta $CE ; Tuhn Watergate open flag (#$00 = closed, #$01 = open)

    lda #$00
    sta $18
    lda #$02
    sta $19
    jsr B0F_D256
    lda #$02
    sta $18
    jsr B0F_D256
    lda #$96 ; Music ID #$96: Watergate SFX

    jsr B0F_C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    ldx #$3C
    jsr B0F_C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

    lda #$32
    sta $41
    jmp B0F_E938

B06_97D5:
    lda #$3B ; String ID #$013B: There is no door here.[end-FC]

    bne B06_97E3
B06_97D9:
    lda #$3C ; String ID #$013C: There is no prison here.[end-FC]

    bne B06_97E3
B06_97DD:
    lda #$3D ; String ID #$013D: This is not the water gate.[end-FC]

    bne B06_97E3
; wrong key for door
B06_97E1:
    lda #$3E ; String ID #$013E: The key wouldn't turn in the lock.[end-FC]

B06_97E3:
    jsr B0F_FA4E ; display string ID specified by A + #$0100

    jmp B06_9548 ; end TALK/ITEM routines


B06_97E9:
    cmp #$33 ; Item ID #$33: Lottery Ticket

    bne B06_97F4
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $40
    jmp B06_9548 ; end TALK/ITEM routines


B06_97F4:
    cmp #$3D ; Item ID #$3D: Wizard’s Ring

    bne B06_980F
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $41
    lda $97 ; subject hero ID $97
    jsr B0F_F722 ; restore the hero ID in A's MP by a random amount based on the Wizard's Ring's power; returns a random number between $03 and #$0A in A and $99

    lda $99 ; chance for Wizard's Ring to break

    bne B06_980C
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $42
    jsr B06_961D ; given hero ID in $97 and hero inventory offset in $49, remove that item from hero's inventory and move all lower items up 1 slot

B06_980C:
    jmp B06_9548 ; end TALK/ITEM routines


B06_980F:
    cmp #$31 ; Item ID #$31: Dragon’s Potion

    bne B06_9825
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $43
    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $87
    jsr B06_A35D ; save game handler

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $47
    jmp B06_9548 ; end TALK/ITEM routines


B06_9825:
    cmp #$3E ; Item ID #$3E: Perilous

    bne B06_9834
B06_9829:
    stx $49 ; object hero/target/item/string ID $49

    sta $96 ; temp storage for item/spell/type/etc. IDs

    sta $95 ; ID for [item] and [spell] control codes

    pha
    jsr B06_8D25 ; print name of hero given by low 2 bits of $97 to [name] buffer $6119, terminated by #$FA

    pla
B06_9834:
    cmp #$30 ; Item ID #$30: Dragon’s Bane

    bne B06_983E
    jsr B06_9895 ; USE Dragon's Bane

    jmp B06_9548 ; end TALK/ITEM routines


B06_983E:
    cmp #$2F ; Item ID #$2F: Gremlin’s Tail

    bne B06_9848
    jsr B06_98B0 ; USE Gremlin's Tail

    jmp B06_9548 ; end TALK/ITEM routines


B06_9848:
    cmp #$26 ; Item ID #$26: Moon Fragment

    bne B06_9852
    jsr B06_98CB ; USE Moon Fragment

    jmp B06_9548 ; end TALK/ITEM routines


B06_9852:
    cmp #$24 ; Item ID #$24: Token of Erdrick

    bne B06_985C
    jsr B06_9908 ; USE Token of Erdrick

    jmp B06_9548 ; end TALK/ITEM routines


B06_985C:
    cmp #$2E ; Item ID #$2E: Cloak of Wind

    bne B06_9866
    jsr B06_9914 ; USE Cloak of Wind

    jmp B06_9548 ; end TALK/ITEM routines


B06_9866:
    cmp #$27 ; Item ID #$27: Charm of Rubiss

    bne B06_9870
    jsr B06_992F ; USE Charm of Rubiss

    jmp B06_9548 ; end TALK/ITEM routines


B06_9870:
    cmp #$2A ; Item ID #$2A: Echoing Flute

    bne B06_987A
    jsr B06_9963 ; USE Echoing Flute

    jmp B06_9548 ; end TALK/ITEM routines


B06_987A:
    cmp #$36 ; Item ID #$36: [blank]

    bne B06_9884
    jsr B06_999C ; USE Golden Card

    jmp B06_9548 ; end TALK/ITEM routines


B06_9884:
    cmp #$32 ; Item ID #$32: Golden Card

    bne B06_988E
    jsr B06_999C ; USE Golden Card

    jmp B06_9548 ; end TALK/ITEM routines


B06_988E:
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $9E
    jmp B06_9548 ; end TALK/ITEM routines


; USE Dragon's Bane
B06_9895:
    ora #$40 ; check for equipped version

    jsr B06_8DBA ; given a hero ID in $97 and an item ID in A, SEC if hero has that item, CLC otherwise

    bcs B06_98AA
    ldx $49 ; object hero/target/item/string ID $49

    jsr B06_8B0F ; given hero ID in $97 and hero inventory index in X, return corresponding item ID in A and party inventory index in X

    ora #$40 ; equip it

    sta $0600, x ; Midenhall inventory item 1 (| #$40 if equipped)

    lda #$22 ; String ID #$0122: [name] put on the Dragon's Bane.[end-FC]

    bne B06_98AC
B06_98AA:
    lda #$23 ; String ID #$0123: [name] has already put on the Dragon's Bane.[end-FC]

B06_98AC:
    jsr B0F_FA4E ; display string ID specified by A + #$0100

    rts

; USE Gremlin's Tail
B06_98B0:
    ora #$40 ; check for equipped version

    jsr B06_8DBA ; given a hero ID in $97 and an item ID in A, SEC if hero has that item, CLC otherwise

    bcs B06_98C5
    ldx $49 ; object hero/target/item/string ID $49

    jsr B06_8B0F ; given hero ID in $97 and hero inventory index in X, return corresponding item ID in A and party inventory index in X

    ora #$40 ; equip it

    sta $0600, x ; Midenhall inventory item 1 (| #$40 if equipped)

    lda #$24 ; String ID #$0124: [name] put on the Gremlin's Tail.[end-FC]

    bne B06_98C7
B06_98C5:
    lda #$25 ; String ID #$0125: [name] has already put on the Gremlin's Tail.[end-FC]

B06_98C7:
    jsr B0F_FA4E ; display string ID specified by A + #$0100

    rts

; USE Moon Fragment
B06_98CB:
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $26
    lda $8E ; flag for in battle or not (#$FF)?

    bmi B06_9900
    lda $1F ; some kind of map type (#$00: World Map, #$01: other non-dungeon maps, #$02: maps #$2B - #$43 inclusive, #$03: maps >= #$44, #$FF => game menu)

    bne B06_9900
    lda $05F8 ; Sea Cave shoal status (#$00 = shoals up, others = shoals down)

    bne B06_9900
    lda $16 ; current map X-pos (1)

    cmp #$B1 ; X-range for effective use is #$B1-#$B9 inclusive

    bcc B06_9900
    cmp #$BA
    bcs B06_9900
    lda $17 ; current map Y-pos (1)

    cmp #$A2 ; Y-range for effective use is #$A2-#$AC inclusive

    bcc B06_9900
    cmp #$AD
    bcs B06_9900
    jsr B0F_D0F5 ; wait for a while and then wipe menu regions #$03, #$00, and #$01

    ldx #$3C
    jsr B0F_C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

    lda #$01
    sta $05F8 ; Sea Cave shoal status (#$00 = shoals up, others = shoals down)

    jmp B0F_D218 ; open path to Sea Cave


B06_9900:
    jsr B0F_F73D ; calls $04:$99E6

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $27
    rts

; USE Token of Erdrick
B06_9908:
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $28
    jsr B0F_F73D ; calls $04:$99E6

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $53
    rts

; USE Cloak of Wind
B06_9914:
    ora #$40 ; check for equipped version

    jsr B06_8DBA ; given a hero ID in $97 and an item ID in A, SEC if hero has that item, CLC otherwise

    bcs B06_9929
    ldx $49 ; object hero/target/item/string ID $49

    jsr B06_8B0F ; given hero ID in $97 and hero inventory index in X, return corresponding item ID in A and party inventory index in X

    ora #$40 ; equip it

    sta $0600, x ; Midenhall inventory item 1 (| #$40 if equipped)

    lda #$2C ; String ID #$012C: [name] donned the Cloak of Wind.[end-FC]

    bne B06_992B
B06_9929:
    lda #$2D ; String ID #$012D: Remember, [name] has already put on the Cloak of Wind.[end-FC]

B06_992B:
    jsr B0F_FA4E ; display string ID specified by A + #$0100

    rts

; USE Charm of Rubiss
B06_992F:
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $2E
    lda $8E ; flag for in battle or not (#$FF)?

    bmi B06_995B
    lda $31 ; current map ID

; Map ID #$00: Fake Midenhall
    bne B06_995B
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $30
    ldx #$78
    jsr B0F_C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

    jsr B0F_C515 ; flash screen 10 times

    jsr B0F_C515 ; flash screen 10 times

    pla
    pla
    lda B06_9959
    sta $0C
    lda B06_9959+1
    sta $0D
    jmp B0F_D81C

B06_9959:
.addr $BD85

B06_995B:
    jsr B0F_F73D ; calls $04:$99E6

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $2F
    rts

; USE Echoing Flute
B06_9963:
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $35
    ldy #$00
    lda $31 ; current map ID

B06_996B:
    cmp B06_998D, y ; minimum map ID (inclusive)

    bcc B06_9981 ; wrong map

    cmp B06_998D+1, y ; maximum map ID (exclusive)

    bcs B06_9981 ; wrong map

    lda B06_998D+2, y ; Crest in this map

    and $0112 ; Crests found bit field (#$10 = Life, #$80 = Water, #$04 = Moon, #$02 = Stars, #$01 = Sun)

    bne B06_9988 ; flute does not echo

    lda #$03 ; Music ID #$03: Echoing Flute echoing BGM

    bne B06_998A ; flute echoes!

; wrong map
B06_9981:
    iny
    iny
    iny
    cpy #$0F ; 3 bytes per crest * 5 crests = #$0F

    bne B06_996B ; if more maps to check, check them

; flute does not echo
B06_9988:
    lda #$04 ; Music ID #$04: Echoing Flute not echoing BGM

B06_998A:
    jmp B0F_C58D ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM]), wait for it to finish, then play previous BGM

B06_998D:
; minimum map ID (inclusive), maximum map ID (exclusive), Crest in this map
.byte $08,$09,$08	 ; Map ID #$08: Hamlin Waterway
.byte $0F,$10,$04	 ; Map ID #$0F: Osterfair
.byte $1E,$1F,$01	 ; Map ID #$1E: Shrine NW of Zahan
.byte $50,$58,$02	 ; Map IDs #$50 - #$57: Lighthouse
.byte $37,$40,$10	 ; Map IDs #$37 - #$3F: Cave to Rhone

; USE Golden Card
B06_999C:
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $3F
    jsr B0F_F73D ; calls $04:$99E6

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $54
    rts

; TRADE/THROW handler
B06_99A8:
    cmp #$01 ; TRADE; useless op

    beq B06_99AF ; TRADE handler

    jmp B06_9A84 ; THROW command handler


; TRADE handler
B06_99AF:
    jsr B0F_F6CE ; return number of party members - 1 in A/X

    bne B06_99C1 ; determine target hero

    jsr B06_9ACB ; open dialogue window

    jsr B06_8D25 ; print name of hero given by low 2 bits of $97 to [name] buffer $6119, terminated by #$FA

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $19
    jmp B06_9548 ; end TALK/ITEM routines


; determine target hero
B06_99C1:
    jsr B0F_F587 ; display appropriate main ITEM target menu

    cmp #$FF
    bne B06_99CB
    jmp B06_9542 ; exit COMMAND menu


B06_99CB:
    sta $C9 ; target hero ID

    jsr B06_9ACB ; open dialogue window

    jsr B06_9AFC ; given hero ID in $97 and hero inventory index in $49, set Z if item is equipped and cursed, clear if not

    bne B06_99D8 ; item can be traded

    jmp B06_9AC4 ; item is equipped and cursed


; item can be traded
B06_99D8:
    lda $97 ; subject hero ID $97

    cmp $C9 ; target hero ID

    bne B06_9A00 ; give to different hero

    lda #$80 ; Alive

    jsr B06_8D9A ; given hero ID in $97, and status in A, SEC if hero has that status, CLC otherwise

    bcc B06_99EF ; ghost giving to itself

    jsr B06_8D25 ; print name of hero given by low 2 bits of $97 to [name] buffer $6119, terminated by #$FA

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $1C
    jmp B06_9548 ; end TALK/ITEM routines


; ghost giving to itself
B06_99EF:
    jsr B06_9AEB ; using name of first living hero, display String ID #$0120: [name] [end-FF]

    jsr B06_8D25 ; print name of hero given by low 2 bits of $97 to [name] buffer $6119, terminated by #$FA

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $A1
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $A3
    jmp B06_9548 ; end TALK/ITEM routines


; give to different hero
B06_9A00:
    lda $97 ; subject hero ID $97

    pha ; item owner hero ID

    lda $C9 ; target hero ID

    sta $97 ; subject hero ID $97

    jsr B06_8D7E ; given hero ID in $97 and item ID in $96, try to add item to first empty slot in hero's inventory; SEC if added, CLC if no empty slots

    bcs B06_9A17 ; item given to target hero

    pla ; item owner hero ID

    jsr B06_8D25 ; print name of hero given by low 2 bits of $97 to [name] buffer $6119, terminated by #$FA

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $1B
    jmp B06_9548 ; end TALK/ITEM routines


; item given to target hero
B06_9A17:
    pla ; item owner hero ID

    sta $97 ; subject hero ID $97

    ldx $49 ; object hero/target/item/string ID $49

    jsr B0F_C4D4 ; given hero ID in A and hero inventory offset in X, remove that item from hero's inventory and move all lower items up 1 slot

    lda #$80 ; Alive

    jsr B06_8D9A ; given hero ID in $97, and status in A, SEC if hero has that status, CLC otherwise

    bcc B06_9A47 ; owner is a ghost

    jsr B06_8D25 ; print name of hero given by low 2 bits of $97 to [name] buffer $6119, terminated by #$FA

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $20
    lda $C9 ; target hero ID

    sta $97 ; subject hero ID $97

    jsr B06_8D25 ; print name of hero given by low 2 bits of $97 to [name] buffer $6119, terminated by #$FA

    lda #$80 ; Alive

    jsr B06_8D9A ; given hero ID in $97, and status in A, SEC if hero has that status, CLC otherwise

    bcc B06_9A3F ; target is a ghost

    lda #$1A ; String ID #$011A: handed the [item] to [name].[end-FC]

    bne B06_9A41 ; target is alive

; target is a ghost
B06_9A3F:
    lda #$17 ; String ID #$0117: gave the [item] to the ghost of [name].[end-FC]

; target is alive
B06_9A41:
    jsr B0F_FA4E ; display string ID specified by A + #$0100

    jmp B06_9548 ; end TALK/ITEM routines


; owner is a ghost
B06_9A47:
    lda $97 ; subject hero ID $97

    pha ; item owner hero ID

    lda $C9 ; target hero ID

    sta $97 ; subject hero ID $97

    lda #$80 ; Alive

    jsr B06_8D9A ; given hero ID in $97, and status in A, SEC if hero has that status, CLC otherwise

    bcc B06_9A69 ; target is a ghost

    jsr B06_8D25 ; print name of hero given by low 2 bits of $97 to [name] buffer $6119, terminated by #$FA

    pla ; item owner hero ID

    sta $97 ; subject hero ID $97

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $20
    jsr B06_8D25 ; print name of hero given by low 2 bits of $97 to [name] buffer $6119, terminated by #$FA

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $18
    jmp B06_9548 ; end TALK/ITEM routines


; target is a ghost
B06_9A69:
    jsr B06_9AEB ; using name of first living hero, display String ID #$0120: [name] [end-FF]

    pla ; item owner hero ID

    sta $97 ; subject hero ID $97

    jsr B06_8D25 ; print name of hero given by low 2 bits of $97 to [name] buffer $6119, terminated by #$FA

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $A1
    lda $C9 ; target hero ID

    sta $97 ; subject hero ID $97

    jsr B06_8D25 ; print name of hero given by low 2 bits of $97 to [name] buffer $6119, terminated by #$FA

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $A2
    jmp B06_9548 ; end TALK/ITEM routines


; THROW command handler
B06_9A84:
    jsr B06_9ACB ; open dialogue window

    lda $96 ; temp storage for item/spell/type/etc. IDs

    asl ; item prices are 2 bytes each

    tay
    lda ItemPrices, y ; Item Prices, low byte

    ora ItemPrices+1, y ; Item Prices, high byte

    beq B06_9ABD ; 0 G items are key items

    jsr B06_9AFC ; given hero ID in $97 and hero inventory index in $49, set Z if item is equipped and cursed, clear if not

    beq B06_9AC4 ; item is equipped and cursed

    lda #$80 ; Alive

    jsr B06_8D9A ; given hero ID in $97, and status in A, SEC if hero has that status, CLC otherwise

    bcc B06_9AA9 ; owner is a ghost

    jsr B06_8D25 ; print name of hero given by low 2 bits of $97 to [name] buffer $6119, terminated by #$FA

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $14
    jmp B06_9AB3

; owner is a ghost
B06_9AA9:
    jsr B06_9AEB ; using name of first living hero, display String ID #$0120: [name] [end-FF]

    jsr B06_8D25 ; print name of hero given by low 2 bits of $97 to [name] buffer $6119, terminated by #$FA

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $16
B06_9AB3:
    lda $97 ; subject hero ID $97

    ldx $49 ; object hero/target/item/string ID $49

    jsr B0F_C4D4 ; given hero ID in A and hero inventory offset in X, remove that item from hero's inventory and move all lower items up 1 slot

    jmp B06_9548 ; end TALK/ITEM routines


; 0 G items are key items
B06_9ABD:
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $0E
    jmp B06_9548 ; end TALK/ITEM routines


; item is equipped and cursed
B06_9AC4:
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $12
    jmp B06_9548 ; end TALK/ITEM routines


; open dialogue window
B06_9ACB:
    jsr B0F_EB76 ; open menu specified by next byte
    .byte $04
    rts

; open YES/NO menu, return selected option in A
B06_9AD0:
    jsr B0F_EB76 ; open menu specified by next byte
    .byte $19
    rts

; set A/$97 to ID of first living hero
B06_9AD5:
    lda #$00 ; start with Midenhall

    sta $97 ; subject hero ID $97

B06_9AD9:
    lda #$80 ; Alive

    jsr B06_8D9A ; given hero ID in $97, and status in A, SEC if hero has that status, CLC otherwise

    bcs B06_9AE8 ; if hero alive, then we're done

    inc $97 ; subject hero ID $97

    lda $97 ; subject hero ID $97

    cmp #$03 ; only 3 heroes

    bne B06_9AD9 ; loop if more heroes to check

B06_9AE8:
    lda $97 ; subject hero ID $97

    rts

; using name of first living hero, display String ID #$0120: [name] [end-FF]
B06_9AEB:
    lda $97 ; subject hero ID $97; save $97 to stack since B06_9AD5 will overwrite it

    pha
    jsr B06_9AD5 ; set A/$97 to ID of first living hero

    jsr B06_8D25 ; print name of hero given by low 2 bits of $97 to [name] buffer $6119, terminated by #$FA

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $20
    pla ; restore $97 from stack

    sta $97 ; subject hero ID $97

    rts

; given hero ID in $97 and hero inventory index in $49, set Z if item is equipped and cursed, clear if not
B06_9AFC:
    lda $97 ; subject hero ID $97

    asl ; inventory is 8 items per hero

    asl
    asl
    clc
    adc $49 ; object hero/target/item/string ID $49

    tax
    lda $0600, x ; Midenhall inventory item 1 (| #$40 if equipped)

    cmp #$4C ; Item ID #$4C: Sword of Destruction (equipped)

    beq B06_9B16
    cmp #$57 ; Item ID #$57: Gremlin’s Armor (equipped)

    beq B06_9B16
    cmp #$5F ; Item ID #$5F: Evil Shield (equipped)

    beq B06_9B16
    cmp #$6F ; Item ID #$6F: Gremlin’s Tail (equipped)

B06_9B16:
    rts

; COMMAND menu SEARCH handler
B06_9B17:
    jsr B0F_EB76 ; open menu specified by next byte
    .byte $04
    jsr B06_9AD5 ; set A/$97 to ID of first living hero

    jsr B06_8D25 ; print name of hero given by low 2 bits of $97 to [name] buffer $6119, terminated by #$FA

    lda $CF ; ship status (#$04 = on ship, #$02 = own ship, #$01 = beat Lianport Gremlins)

    and #$04 ; pick out the "on ship" bit

    beq B06_9B2B ; branch if you're not on the ship

    lda #$07 ; String ID #$0107: [name] dove overboard into the sea.[wait][end-FC]

    bne B06_9B2D
B06_9B2B:
    lda #$03 ; String ID #$0103: [name] searched all about.[wait][end-FC]

B06_9B2D:
    jsr B0F_FA4E ; display string ID specified by A + #$0100

    jsr B0F_D095
    bcc B06_9B45
    lda B06_9E2A ; -> $06:$9E2E: Treasure List 1 (map ID, X-pos, Y-pos, item ID)
    sta $0C
    lda B06_9E2A+1
    sta $0D
    jsr CMD_Search ; scan treasure list at ($0C), returning in A/$95/$96 the item ID corresponding to party's current map ID/position or #$00 if there is no item or you're not allowed to get it

    jmp B06_9B84

B06_9B45:
    lda $31 ; current map ID

    cmp #$68 ; Map ID #$68: Dragon Horn North 3F

    bne B06_9B69
    lda #$2C ; Item ID #$2C: Dew’s Yarn

    sta $96 ; temp storage for item/spell/type/etc. IDs; item ID

    sta $95 ; ID for [item] and [spell] control codes; item ID

    jsr B06_A369 ; check for item A in party inventory, returning inventory index of item in A/X if found, #$FF if not

    bpl B06_9B7D ; search failed

    lda #$13 ; Item ID #$13: Water Flying Cloth

    jsr B06_A360 ; check for item A (possibly equipped) in party inventory, returning inventory index of item in A/X if found, #$FF if not

    bpl B06_9B7D ; search failed

    jsr B0F_C3AB ; generate a random number and store it in $32-$33 (two passes)

    lda $32 ; RNG byte 0

    and #$03 ; 1/4 chance to find item

    bne B06_9B7D ; search failed

    jmp B06_9C05

B06_9B69:
    lda B06_9E2C ; -> $06:$9F07: Treasure List 2 (map ID, X-pos, Y-pos, item ID)
    sta $0C
    lda B06_9E2C+1
    sta $0D
    jsr CMD_Search ; scan treasure list at ($0C), returning in A/$95/$96 the item ID corresponding to party's current map ID/position or #$00 if there is no item or you're not allowed to get it

    lda $96 ; temp storage for item/spell/type/etc. IDs; useless op; $96 is already in A

    beq B06_9B7D ; search failed

    jmp B06_9C05

; search failed
B06_9B7D:
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $06
    jmp B06_9548 ; end TALK/ITEM routines


B06_9B84:
    lda $96 ; temp storage for item/spell/type/etc. IDs; useless op; $96 is already in A

    cmp #$FF ; Item ID #$FF: Trap!

    beq B06_9BA6 ; if Midenhall is equipped with the Armour of Erdrick, chest is empty, otherwise it's a trap with 50/50 chance for the party leader losing half their current HP or getting poisoned

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $05
    lda $96 ; temp storage for item/spell/type/etc. IDs; item ID

    bne B06_9C05 ; Item ID #$00: (no item)

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $4B
    lda $31 ; current map ID

    cmp #$51 ; Map ID #$51: Lighthouse 2F

    bne B06_9BA3
    lda $D0 ; Malroth status flag (#$FF = defeated, #$00 = alive, others = countdown to battle)

    bmi B06_9BA3
    jmp B0F_CC0A ; trigger Stars Crest battle


B06_9BA3:
    jmp B06_9548 ; end TALK/ITEM routines


; if Midenhall is equipped with the Armour of Erdrick, chest is empty, otherwise it's a trap with 50/50 chance for the party leader losing half their current HP or getting poisoned
B06_9BA6:
    lda #$5B ; Item ID #$5B: Armor of Erdrick (equipped)

    jsr B06_A369 ; check for item A in party inventory, returning inventory index of item in A/X if found, #$FF if not

    cmp #$08 ; only Midenhall can equip the Armour of Erdrick, so inventory index >= #$08 means he does not have it equipped

    bcs B06_9BBA ; if you don't have it or it isn't equipped, the treasure chest is a trap :(

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $05
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $4B
    jmp B06_9548 ; end TALK/ITEM routines


B06_9BBA:
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $4C
    jsr B0F_C3AB ; generate a random number and store it in $32-$33 (two passes)

    lda $32 ; RNG byte 0

    bmi B06_9BF2 ; 50% chance to branch and get poisoned or not branch and lose half your current HP

    jsr B06_9D4F ; given hero ID in $97, set A to the offset of that hero's data in $062D

    clc
    adc #$0E ; offset for hero's current HP, low byte

    tax
    lda $062D, x ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    sta $8F ; hero's current HP, low byte

    lda $062E, x ; Midenhall Battle Command Target

    sta $90 ; hero's current HP, high byte

    lsr $90 ; divide 16-bit current HP by 2 (round down)

    ror $8F
    lda $062D, x ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    sec ; set 16-bit current HP to 1/2 current HP, rounded up

    sbc $8F
    sta $062D, x ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    lda $062E, x ; Midenhall Battle Command Target

    sbc $90
    sta $062E, x ; Midenhall Battle Command Target

    jsr B0F_FA2A ; display string ID specified by next byte
    .byte $0C
    jmp B06_9548 ; end TALK/ITEM routines


B06_9BF2:
    jsr B06_9D4F ; given hero ID in $97, set A to the offset of that hero's data in $062D

    tax
    lda #$20 ; Poison

    ora $062D, x ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    sta $062D, x ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $4D
    jmp B06_9548 ; end TALK/ITEM routines


B06_9C05:
    lda $96 ; temp storage for item/spell/type/etc. IDs; item ID

    cmp #$40 ; Crest ID #$40: Sun Crest

    bcc B06_9C62 ; find a regular item

    cmp #$45 ; Chest Gold ID #$45: 15 - 30 G

    bcs B06_9C37 ; generate randomized gold amount for treasure ID in A

    lda $96 ; temp storage for item/spell/type/etc. IDs; ... yup, still item ID

    cmp #$43 ; Crest ID #$43: Water Crest

    bne B06_9C19
    ldy #$0A ; offset from CrestNames for start of "Water Crest"

    bne B06_9C23
B06_9C19:
    cmp #$40 ; Crest ID #$40: Sun Crest

    bne B06_9C21 ; #$44 = Life Crest, #$41, #$42 = Life Crest too :p

    ldy #$00 ; offset from CrestNames for start of "Sun Crest"

    beq B06_9C23
B06_9C21:
    ldy #$16 ; offset from CrestNames for start of "Life Crest"

; copy crest name (terminated by #$FA) to $5A, x
B06_9C23:
    ldx #$00
B06_9C25:
    lda CrestNames, y ; Crest Names

    sta $5A, x ; Crest/direction name write buffer start

    iny
    inx
    cmp #$FA
    bne B06_9C25
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $4E
    jmp B06_9548 ; end TALK/ITEM routines


; generate randomized gold amount for treasure ID in A
B06_9C37:
    sec
    sbc #$45 ; subtract treasure offset to get index

    sta $8F ; A = A * 3 (treasure list is 3 bytes per item)

    asl
    clc
    adc $8F
    pha
    jsr B0F_C3AB ; generate a random number and store it in $32-$33 (two passes)

    pla
    tay
    lda RandomChestGold+2, y ; random treasure chest gold amount; fetch maximum bonus gold amount
    and $32 ; RNG byte 0; AND with random number to make a randomized bonus gold amount
    clc
    adc RandomChestGold, y ; base treasure chest gold amount, low byte; add random bonus amount to low byte of base gold amount
    sta $8F ; store to $8F for later use
    lda RandomChestGold+1, y ; base treasure chest gold amount, high byte; load high byte of base gold amount
    adc #$00 ; add carry from low byte
    sta $90 ; store to $90 for later use

; add $8F-$90 to party gold, capped at $FFFF, and display String ID #$0048: And earned [number] piece[(s)] of gold.[end-FC]
B06_9C58:
    jsr B06_8CF5 ; add $8F-$90 to party gold, capped at $FFFF

    jsr B0F_FA2A ; display string ID specified by next byte
    .byte $48
    jmp B06_9548 ; end TALK/ITEM routines


; find a regular item
B06_9C62:
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $04
    lda $96 ; temp storage for item/spell/type/etc. IDs; item ID

    cmp #$06 ; Item ID #$06: Copper Sword

    bne B06_9C7B
    lda #$00 ; Midenhall

    sta $97 ; subject hero ID $97

    jsr B06_8D7E ; given hero ID in $97 and item ID in $96, try to add item to first empty slot in hero's inventory; SEC if added, CLC if no empty slots

    lda #$32 ; at this point in the game, Midenhall is incapable of having a full inventory, so no need to check C; #$32 = 50 Gold

    jsr B06_8D2A ; set $8F-$90 to A-#$00

    jmp B06_9C58 ; add $8F-$90 to party gold, capped at $FFFF, and display String ID #$0048: And earned [number] piece[(s)] of gold.[end-FC]


B06_9C7B:
    lda $95 ; ID for [item] and [spell] control codes; item ID

    sta $614C ; found item ID

    jsr B0F_F6CE ; return number of party members - 1 in A/X

    sta $C9 ; number of party members - 1

    inc $C9 ; number of party members

    lda #$00
    sta $97 ; subject hero ID $97

; try to add item to party member's inventory
B06_9C8B:
    jsr B06_8D7E ; given hero ID in $97 and item ID in $96, try to add item to first empty slot in hero's inventory; SEC if added, CLC if no empty slots

    bcc B06_9C93 ; branch if party member has no room

    jmp B06_9548 ; end TALK/ITEM routines


B06_9C93:
    inc $97 ; subject hero ID $97

    lda $97 ; subject hero ID $97

    cmp $C9
; if more party members to try, try them
    bne B06_9C8B ; try to add item to party member's inventory

    lda #$00
    sta $97 ; subject hero ID $97

    dec $C9 ; number of party members

    lda $C9 ; number of party members - 1

    beq B06_9CA7 ; useless op; #$80 and #$00 are identical as far as B0F_FC50 is concerned

    lda #$80
B06_9CA7:
    jsr B0F_FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $08
    jsr B06_9AD0 ; open YES/NO menu, return selected option in A

    cmp #$00 ; YES

    beq B06_9CC1
; give up new item
B06_9CB5:
    lda $614C ; found item ID; useless op; $95 hasn't changed since we copied it to $614C

    sta $95 ; ID for [item] and [spell] control codes

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $09
    jmp B06_9548 ; end TALK/ITEM routines


B06_9CC1:
    lda $C9 ; number of party members - 1

    beq B06_9CD2 ; if Midenhall's alone, no need to pick a party member

B06_9CC5:
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $0A
    jsr B0F_F55D ; display appropriate main ITEM hero select menu

    cmp #$FF
    beq B06_9CB5 ; give up new item

    sta $97 ; subject hero ID $97

B06_9CD2:
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $0B
    lda $97 ; subject hero ID $97

    jsr B0F_F5FE ; given a hero ID in A, open hero's item list and return selected item ID (or #$FE if they have no items)

    pha ; item ID to drop

    txa
    pha ; save X

    lda #$03
    jsr B0F_CF6A ; wipe selected menu region

    pla ; restore X

    tax
    pla ; item ID to drop

    cmp #$FF
    bne B06_9CF0
    lda $C9 ; number of party members - 1

    beq B06_9CB5 ; give up new item

    bne B06_9CC5
B06_9CF0:
    stx $49 ; object hero/target/item/string ID $49

    sta $95 ; ID for [item] and [spell] control codes

    jsr B06_9AFC ; given hero ID in $97 and hero inventory index in $49, set Z if item is equipped and cursed, clear if not

    bne B06_9D00
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $12
    jmp B06_9CD2

B06_9D00:
    lda $95 ; ID for [item] and [spell] control codes; item ID to throw away

    and #$3F ; strip off the equipped bit

    asl
    tay
    lda ItemPrices, y ; Item Prices, low byte
    ora ItemPrices+1, y ; Item Prices, high byte
    bne B06_9D15 ; if price is 0 G, it's a quest item

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $0E
    jmp B06_9CD2

B06_9D15:
    lda $97 ; subject hero ID $97

    asl ; 8 items per hero

    asl
    asl
    clc
    adc $49 ; object hero/target/item/string ID $49

    tax
    lda $96 ; temp storage for item/spell/type/etc. IDs; item ID to gain

    sta $0600, x ; Midenhall inventory item 1 (| #$40 if equipped)

    lda #$80 ; Alive

    jsr B06_8D9A ; given hero ID in $97, and status in A, SEC if hero has that status, CLC otherwise

    bcs B06_9D3C
    jsr B06_9AEB ; using name of first living hero, display String ID #$0120: [name] [end-FF]

    jsr B06_8D25 ; print name of hero given by low 2 bits of $97 to [name] buffer $6119, terminated by #$FA

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $0F
    lda $96 ; temp storage for item/spell/type/etc. IDs

    sta $95 ; ID for [item] and [spell] control codes

    lda #$10 ; String ID #$0110: the [item] to ghost of [name].[end-FC]

    bne B06_9D49
B06_9D3C:
    jsr B06_8D25 ; print name of hero given by low 2 bits of $97 to [name] buffer $6119, terminated by #$FA

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $0C
    lda $96 ; temp storage for item/spell/type/etc. IDs

    sta $95 ; ID for [item] and [spell] control codes

    lda #$0D ; String ID #$010D: [name] obtained the [item].[end-FC]

B06_9D49:
    jsr B0F_FA4E ; display string ID specified by A + #$0100

    jmp B06_9548 ; end TALK/ITEM routines


; given hero ID in $97, set A to the offset of that hero's data in $062D
B06_9D4F:
    ldx $97 ; subject hero ID $97

    lda B06_9D55, x ; pre-computed offsets for the start of each hero's data at $062D

    rts

; pre-computed offsets for the start of each hero's data at $062D
B06_9D55:
.byte $00,$12,$24

; scan treasure list at ($0C), returning in A/$95/$96 the item ID corresponding to party's current map ID/position or #$00 if there is no item or you're not allowed to get it
CMD_Search:
    ldy #$00
    lda ($0C), y ; read map ID
    cmp #$FF ; #$FF => end of list
    bne @can_open
    jmp B06_9DFE ; end of treasure list or you aren't allowed to get the item again; set $95 = $96 = #$00 and RTS

    @can_open:
    cmp map_id ; current map ID
    ; map ID matches, start checking position
    beq @check_pos
    jmp B06_9DEE ; increment 16-bit $0C-$0D by 4 (move to next treasure record) and loop to check next treasure
    @check_pos:
    iny
    lda ($0C), y ; treasure X-pos
    cmp map_xpos ; current map X-pos (1)
    bne B06_9DEE ; increment 16-bit $0C-$0D by 4 (move to next treasure record) and loop to check next treasure
    iny
    lda ($0C), y ; treasure Y-pos
    cmp map_ypos ; current map Y-pos (1)
    bne B06_9DEE ; increment 16-bit $0C-$0D by 4 (move to next treasure record) and loop to check next treasure
    iny
    lda ($0C), y ; item ID
    bne @open ; map/position is valid and there is an item here
    jmp B06_9E00 ; store item ID in $95 and $96 and RTS

    ; map/position is valid and there is an item here
    @open:
    cmp #$45 ; randomized gold chests have IDs >= #$45
    bcs B06_9E00 ; store item ID in $95 and $96 and RTS

    sta $96 ; temp storage for item/spell/type/etc. IDs; item ID
    cmp #$25 ; Item ID #$25: Tresures
    bne B06_9D93
    lda #$2A ; Item ID #$2A: Echoing Flute
    jsr B06_A369 ; check for item A in party inventory, returning inventory index of item in A/X if found, #$FF if not
    bpl B06_9DFE ; end of treasure list or you aren't allowed to get the item again; set $95 = $96 = #$00 and RTS

    bmi B06_9DBA
B06_9D93:
    cmp #$2B ; Item ID #$2B: Mirror of Ra

    bne B06_9DA0
    lda $0651 ; Moonbrooke status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    and #$04 ; pick out the In Party bit

    bne B06_9DFE ; end of treasure list or you aren't allowed to get the item again; set $95 = $96 = #$00 and RTS

    beq B06_9DBA
B06_9DA0:
    cmp #$37 ; Item ID #$37: Golden Key

    bne B06_9DBA
; the Golden Key is available in 2 places in Zahan; a dog points you to the one at (#$16, #$08), and the other one is at (#$12, #$04)
; you can only pick it up from one place at a time, however, depending on the position of the dog
    lda $17 ; current map Y-pos (1)

    cmp #$04
    bne B06_9DB3
; the (#$12, #$04) Golden Key
    lda $057C ; NPC #$08 X-pos; dog's X-pos

    cmp #$12
    bne B06_9DEE ; increment 16-bit $0C-$0D by 4 (move to next treasure record) and loop to check next treasure

    beq B06_9DBA
; the (#$16, #$08) Golden Key
B06_9DB3:
    lda $057C ; NPC #$08 X-pos; dog's X-pos

    cmp #$12
    beq B06_9DEE ; increment 16-bit $0C-$0D by 4 (move to next treasure record) and loop to check next treasure

B06_9DBA:
    lda B06_9F24 ; -> $06:$9F26: unique items
    sta $0C
    lda B06_9F24+1
    sta $0D
    ldy #$00
    lda $96 ; temp storage for item/spell/type/etc. IDs; item ID

B06_9DC8:
    cmp ($0C), y ; compare against list of unique items

    beq B06_9DD4
    iny
    cpy #$12
    bne B06_9DC8 ; if more items to check, check them

    jmp B06_9E00 ; store item ID in $95 and $96 and RTS; happens if item is not unique


B06_9DD4:
    cmp #$40 ; we already handled IDs >= #$45, so this checks for Crests #$40 - #$44

    bcs B06_9E05 ; handle finding a Crest

    jsr B06_A360 ; check for item A (possibly equipped) in party inventory, returning inventory index of item in A/X if found, #$FF if not

    bpl B06_9DFE ; end of treasure list or you aren't allowed to get the item again; set $95 = $96 = #$00 and RTS

    lda $96 ; temp storage for item/spell/type/etc. IDs; item ID

    cmp #$24 ; Item ID #$24: Token of Erdrick

    bne B06_9E00 ; store item ID in $95 and $96 and RTS

    lda #$23 ; Item ID #$23: Helmet of Erdrick

    jsr B06_A360 ; check for item A (possibly equipped) in party inventory, returning inventory index of item in A/X if found, #$FF if not

    bpl B06_9DFE ; end of treasure list or you aren't allowed to get the item again; set $95 = $96 = #$00 and RTS

    lda #$24 ; Item ID #$24: Token of Erdrick

    bne B06_9E00 ; store item ID in $95 and $96 and RTS

; increment 16-bit $0C-$0D by 4 (move to next treasure record) and loop to check next treasure
B06_9DEE:
    lda $0C
    clc
    adc #$04
    sta $0C
    lda $0D
    adc #$00
    sta $0D
    jmp CMD_Search ; scan treasure list at ($0C), returning in A/$95/$96 the item ID corresponding to party's current map ID/position or #$00 if there is no item or you're not allowed to get it


; end of treasure list or you aren't allowed to get the item again; set $95 = $96 = #$00 and RTS
B06_9DFE:
    lda #$00
; store item ID in $95 and $96 and RTS
B06_9E00:
    sta $96 ; temp storage for item/spell/type/etc. IDs

    sta $95 ; ID for [item] and [spell] control codes

    rts

; handle finding a Crest
B06_9E05:
    cmp #$43 ; Crest ID #$43: Water Crest

    bne B06_9E0D
    lda #$08 ; Crest ID #$43: Water Crest sets bit #$08

    bne B06_9E17
B06_9E0D:
    cmp #$40
    bne B06_9E15
    lda #$01 ; Crest ID #$40: Sun Crest sets bit #$01

    bne B06_9E17
B06_9E15:
    lda #$10 ; by process of elimination, Crest ID #$44: Life Crest sets bit #$10

B06_9E17:
    sta $0C
    and $0112 ; Crests found bit field (#$10 = Life, #$80 = Water, #$04 = Moon, #$02 = Stars, #$01 = Sun)

    bne B06_9DFE ; end of treasure list or you aren't allowed to get the item again; set $95 = $96 = #$00 and RTS

    lda $0C
    ora $0112 ; Crests found bit field (#$10 = Life, #$80 = Water, #$04 = Moon, #$02 = Stars, #$01 = Sun)

    sta $0112 ; Crests found bit field (#$10 = Life, #$80 = Water, #$04 = Moon, #$02 = Stars, #$01 = Sun); mark Crest as found

    lda $96 ; temp storage for item/spell/type/etc. IDs; item ID

    bne B06_9E00 ; store item ID in $95 and $96 and RTS


B06_9E2A:
.addr TreasureList1
B06_9E2C:
.addr TreasureList2

; Treasure List 1 (map ID, X-pos, Y-pos, item ID)
TreasureList1:
.byte $03,$0E,$02,$06	 ; Item ID #$06: Copper Sword (Midenhall Castle)
.byte $03,$13,$0E,$35	 ; Item ID #$35: Wing of Wyvern (Midenhall Castle)
.byte $03,$14,$0E,$3C	 ; Item ID #$3C: Medical Herb (Midenhall Castle)
.byte $03,$13,$0F,$47	 ; Item ID #$47: 50 - 113 G (Midenhall Castle)
.byte $03,$14,$0F,$00	 ; Item ID #$00: Empty (Midenhall Castle)
.byte $03,$15,$0F,$24	 ; Item ID #$24: Token of Erdrick (Midenhall Castle)

.byte $06,$0A,$0A,$20	 ; Item ID #$20: Shield of Erdrick (Cannock Castle)

.byte $0F,$06,$14,$1A	 ; Item ID #$1A: Armor of Gaia (Osterfair)
.byte $0F,$06,$16,$02	 ; Item ID #$02: Magic Knife (Osterfair)

.byte $10,$02,$02,$2D	 ; Item ID #$2D: Magic Loom (Zahan)

.byte $18,$07,$06,$33	 ; Item ID #$33: Lottery Ticket (Charlock Castle)
.byte $18,$08,$06,$3C	 ; Item ID #$3C: Medical Herb (Charlock Castle)
.byte $18,$06,$07,$49	 ; Item ID #$49: 100 - 163 G (Charlock Castle)
.byte $18,$07,$07,$35	 ; Item ID #$35: Wing of Wyvern (Charlock Castle)

.byte $2C,$12,$0C,$3C	 ; Item ID #$3C: Medical Herb (Lake Cave B1)
.byte $2C,$0E,$1C,$45	 ; Item ID #$45: 15 - 30 G (Lake Cave B1)
.byte $2D,$0E,$0C,$3C	 ; Item ID #$3C: Medical Herb (Lake Cave B2)
.byte $2D,$14,$1A,$46	 ; Item ID #$46: 31 - 46 G (Lake Cave B2)
.byte $2D,$02,$14,$3B	 ; Item ID #$3B: Antidote Herb (Lake Cave B2)
.byte $2D,$14,$1C,$35	 ; Item ID #$35: Wing of Wyvern (Lake Cave B2)
.byte $2D,$14,$14,$38	 ; Item ID #$38: Silver Key (Lake Cave B2)

.byte $2E,$18,$02,$4B	 ; Item ID #$4B: 111 - 142 G (Sea Cave B1)
.byte $2E,$02,$0A,$3C	 ; Item ID #$3C: Medical Herb (Sea Cave B1)
.byte $2F,$20,$0E,$FF	 ; Item ID #$FF: Trap (Sea Cave B2)
.byte $2F,$0E,$18,$48	 ; Item ID #$48: 51 - 82 G (Sea Cave B2)
.byte $31,$02,$02,$49	 ; Item ID #$49: 100 - 163 G (Sea Cave B3(2))
.byte $31,$0A,$02,$FF	 ; Item ID #$FF: Trap (Sea Cave B3(2))
.byte $32,$10,$0E,$30	 ; Item ID #$30: Dragon's Bane (Sea Cave B4)
.byte $33,$16,$02,$28	 ; Item ID #$28: Eye of Malroth (Sea Cave B5)

.byte $34,$0E,$10,$0F	 ; Item ID #$0F: Sword of Erdrick (Charlock Castle)

.byte $37,$10,$10,$44	 ; Item ID #$44: Life Crest (Cave to Rhone B1)
.byte $3C,$0C,$1A,$4B	 ; Item ID #$4B: 111 - 142 G (Cave to Rhone 3F)
.byte $3C,$0E,$32,$10	 ; Item ID #$10: Thunder Sword (Cave to Rhone 3F)
.byte $3C,$1E,$2C,$33	 ; Item ID #$33: Lottery Ticket (Cave to Rhone 3F)
.byte $3E,$18,$0E,$1B	 ; Item ID #$1B: Armor of Erdrick (Cave to Rhone 5F)
.byte $3E,$1A,$18,$4D	 ; Item ID #$4D: 111 - 174 G (Cave to Rhone 5F)
.byte $3E,$12,$20,$FF	 ; Item ID #$FF: Trap (Cave to Rhone 5F)
.byte $3E,$12,$24,$4A	 ; Item ID #$4A: 561 - 624 G (Cave to Rhone 5F)

.byte $40,$02,$0E,$3C	 ; Item ID #$3C: Medical Herb (Spring Of Bravery)
.byte $40,$0E,$1A,$45	 ; Item ID #$45: 15 - 30 G (Spring Of Bravery)
.byte $40,$16,$1C,$3C	 ; Item ID #$3C: Medical Herb (Spring Of Bravery)

.byte $49,$12,$14,$3C	 ; Item ID #$3C: Medical Herb (Moon Tower 1F)
.byte $49,$10,$02,$26	 ; Item ID #$26: Moon Fragment (Moon Tower 1F)
.byte $4B,$02,$02,$50	 ; Item ID #$50: 101 - 132 G (Moon Tower 3F)
.byte $4C,$04,$0C,$01	 ; Item ID #$01: Bamboo Stick (Moon Tower 4F)
.byte $4C,$02,$0C,$4F	 ; Item ID #$4F: 251 - 282 G (Moon Tower 4F)

.byte $50,$14,$0A,$51	 ; Item ID #$51: 38 - 53 G (Lighthouse 1F)
.byte $51,$1E,$1C,$00	 ; Item ID #$00: Empty (triggers Star Crest battle) (Lighthouse 2F)
.byte $53,$0C,$16,$4E	 ; Item ID #$4E: 120 - 135 G (Lighthouse 4F)
.byte $54,$16,$02,$34	 ; Item ID #$34: Fairy Water (Lighthouse 5F)
.byte $54,$0E,$12,$07	 ; Item ID #$07: Chain Sickle (Lighthouse 5F)

.byte $58,$10,$14,$3C	 ; Item ID #$3C: Medical Herb (Wind Tower 1F)
.byte $59,$02,$04,$2E	 ; Item ID #$2E: Cloak of Wind (Wind Tower 2F)
.byte $5A,$06,$10,$4C	 ; Item ID #$4C: 41 - 56 G (Wind Tower 3F)
.byte $FF	 ; end of Treasure List 1

; Treasure List 2 (map ID, X-pos, Y-pos, item ID)
TreasureList2:
.byte $01,$92,$6D,$2B	 ; Item ID #$2B: Mirror of Ra (Swamp SE of Hamlin)
.byte $01,$1E,$FC,$25	 ; Item ID #$25: Tresures (Ocean NW of Tantegal)
.byte $01,$BB,$DD,$29	 ; Item ID #$29: Leaf of World Tree (Island E of Wellgarth)
.byte $08,$05,$01,$43	 ; Item ID #$43: Water Crest (Hamlin)
.byte $1E,$08,$00,$40	 ; Item ID #$40: Sun Crest (Monolith E of Wellgarth)
.byte $10,$12,$04,$37	 ; Item ID #$37: Golden Key location #1 (Zahan)
.byte $10,$16,$08,$37	 ; Item ID #$37: Golden Key location #2 (Zahan)
.byte $FF	 ; end of Treasure List 2

B06_9F24:
.addr UniqueItems

; unique items
UniqueItems:
.byte $38	 ; Item ID #$38: Silver Key
.byte $25	 ; Item ID #$25: Tresures
.byte $29	 ; Item ID #$29: Leaf of The World Tree
.byte $24	 ; Item ID #$24: Token of Erdrick
.byte $20	 ; Item ID #$20: Shield of Erdrick
.byte $43	 ; Crest ID #$43: Water Crest
.byte $1A	 ; Item ID #$1A: Armor of Gaia
.byte $10	 ; Item ID #$10: Thunder Sword
.byte $40	 ; Crest ID #$40: Sun Crest
.byte $28	 ; Item ID #$28: Eye of Malroth
.byte $0F	 ; Item ID #$0F: Sword of Erdrick
.byte $44	 ; Crest ID #$44: Life Crest
.byte $1B	 ; Item ID #$1B: Armor of Erdrick
.byte $26	 ; Item ID #$26: Moon Fragment
.byte $2E	 ; Item ID #$2E: Cloak of Wind
.byte $2B	 ; Item ID #$2B: Mirror of Ra
.byte $37	 ; Item ID #$37: Golden Key
.byte $2D	 ; Item ID #$2D: Magic Loom

; random treasure chest gold amount
; leftmost word is the base amount.
; rightmost byte is the amount to increase randomly.
RandomChestGold:
.byte $0F,$00,$0F	 ; Chest Gold ID #$45: 15 - 30 G
.byte $1F,$00,$0F	 ; Chest Gold ID #$46: 31 - 46 G
.byte $32,$00,$3F	 ; Chest Gold ID #$47: 50 - 113 G
.byte $33,$00,$1F	 ; Chest Gold ID #$48: 51 - 82 G
.byte $64,$00,$3F	 ; Chest Gold ID #$49: 100 - 163 G
.byte $31,$02,$3F	 ; Chest Gold ID #$4A: 561 - 624 G
.byte $6F,$00,$1F	 ; Chest Gold ID #$4B: 111 - 142 G
.byte $29,$00,$0F	 ; Chest Gold ID #$4C: 41 - 56 G
.byte $6F,$00,$3F	 ; Chest Gold ID #$4D: 111 - 174 G
.byte $78,$00,$0F	 ; Chest Gold ID #$4E: 120 - 135 G
.byte $FB,$00,$1F	 ; Chest Gold ID #$4F: 251 - 282 G
.byte $65,$00,$1F	 ; Chest Gold ID #$50: 101 - 132 G
.byte $26,$00,$0F	 ; Chest Gold ID #$51: 38 - 53 G

; Crest Names
CrestNames:
.byte "Sun Crest",$FA
.byte "Water Crest",$FA
.byte "Life Crest",$FA

; Inn prices per party member
InnPrices:
.byte  4	 ; Inn ID #$00, Map IDs #$00/#$03: Fake Midenhall/Midenhall 1F
.byte  6	 ; Inn ID #$01, Map ID #$05: Leftwyne
.byte  8	 ; Inn ID #$02, Map ID #$06: Cannock
.byte 12	 ; Inn ID #$03, Map ID #$07: Hamlin
.byte 20	 ; Inn ID #$04, Map ID #$0B: Lianport
.byte  2	 ; Inn ID #$05, Map ID #$0C: Tantegel
.byte 25	 ; Inn ID #$06, Map ID #$0F: Osterfair
.byte 30	 ; Inn ID #$07, Map ID #$10: Zahan
.byte 40	 ; Inn ID #$08, Map ID #$11: Tuhn / Map ID #$14: Wellgarth Underground
.byte 30     ; ?

; Weapon Shop inventories
ShopInventories:
.byte $05,$06,$02,$07,$16,$1C	 ; Shop ID #00, Weapons/Armor, Map ID #$05: Leftwyne
.byte $07,$08,$0A,$16,$19,$1E	 ; Shop ID #01, Weapons/Armor, Map ID #$07: Hamlin
.byte $02,$0A,$03,$19,$12,$1E	 ; Shop ID #02, Weapons/Armor, Map ID #$0B: Lianport
.byte $0A,$0B,$03,$12,$1E,$22	 ; Shop ID #03, Weapons/Armor, Map ID #$0C: Tantegel
.byte $0A,$0B,$0D,$12,$18,$22	 ; Shop ID #04, Weapons/Armor, Map ID #$0F: Osterfair
.byte $03,$09,$0D,$18,$1D,$22	 ; Shop ID #05, Weapons/Armor, Map ID #$11: Tuhn
.byte $0B,$0D,$0E,$14,$1D,$22	 ; Shop ID #06, Weapons/Armor, Map ID #$14: Wellgarth Underground
.byte $0B,$03,$0D,$1E,$1D,$22	 ; Shop ID #07, Weapons/Armor, Map ID #$15: Beran
; Tool Shop inventories
.byte $3C,$3B,$00,$00,$00,$00	 ; Shop ID #$00, Items, Map IDs #$00/#$03: Fake Midenhall/Midenhall 1F
.byte $3C,$3B,$35,$00,$00,$00	 ; Shop ID #$01, Items, Map ID #$05: Leftwyne
.byte $3C,$3B,$35,$34,$00,$00	 ; Shop ID #$02, Items, Map ID #$06: Cannock
.byte $3C,$3B,$35,$34,$00,$00	 ; Shop ID #$03, Items, Map ID #$07: Hamlin
.byte $3C,$3B,$35,$34,$30,$00	 ; Shop ID #$04, Items, Map ID #$0B: Lianport
.byte $3C,$3B,$35,$34,$30,$00	 ; Shop ID #$05, Items, Map ID #$0C: Tantegel
.byte $3C,$35,$34,$30,$00,$00	 ; Shop ID #$06, Items, Map ID #$10: Zahan
.byte $35,$34,$30,$00,$00,$00	 ; Shop ID #$07, Items, Map ID #$11: Tuhn
.byte $3C,$3B,$34,$30,$00,$00	 ; Shop ID #$08, Items, Map ID #$14: Wellgarth Underground, #1
.byte $3C,$3B,$39,$35,$00,$00	 ; Shop ID #$09, Items, Map ID #$14: Wellgarth Underground, #2
.byte $3C,$3B,$35,$34,$00,$00	 ; Shop ID #$0A, Items, Map ID #$15: Beran

; Item Prices
ItemPrices:
.word $00	 ; Item ID #$00: (no item)
.word $14	 ; Item ID #$01: Bamboo Stick
.word $C8	 ; Item ID #$02: Magic Knife
.word $09C4	 ; Item ID #$03: Wizard’s Wand
.word $6590	 ; Item ID #$04: Staff of Thunder
.word $3C	 ; Item ID #$05: Club
.word $64	 ; Item ID #$06: Copper Sword
.word $0186	 ; Item ID #$07: Chain Sickle
.word $0302	 ; Item ID #$08: Iron Spear
.word $61A8	 ; Item ID #$09: Falcon Sword
.word $05DC	 ; Item ID #$0A: Broad Sword
.word $0FA0	 ; Item ID #$0B: Giant Hammer
.word $3A98	 ; Item ID #$0C: Sword of Destruction
.word $1F40	 ; Item ID #$0D: Dragon Killer
.word $3E80	 ; Item ID #$0E: Light Sword
.word $02	 ; Item ID #$0F: Sword of Erdrick
.word $01F4	 ; Item ID #$10: Thunder Sword

.word $1E	 ; Item ID #$11: Clothes
.word $04E2	 ; Item ID #$12: Clothes Hiding
.word $46	 ; Item ID #$13: Water Flying Cloth
.word $FDE8	 ; Item ID #$14: Mink Coat
.word $96	 ; Item ID #$15: Leather Armor
.word $01E0	 ; Item ID #$16: Chain Mail
.word $1900	 ; Item ID #$17: Gremlin’s Armor
.word $10CC	 ; Item ID #$18: Magic Armor
.word $03E8	 ; Item ID #$19: Full Plate Armor
.word $32	 ; Item ID #$1A: Armor of Gaia
.word $04	 ; Item ID #$1B: Armor of Erdrick

.word $5A	 ; Item ID #$1C: Leather Shield
.word $53FC	 ; Item ID #$1D: Shield of Strength
.word $07D0	 ; Item ID #$1E: Steel Shield
.word $2260	 ; Item ID #$1F: Evil Shield
.word $14	 ; Item ID #$20: Shield of Erdrick

.word $4E20	 ; Item ID #$21: Mysterious Hat
.word $0C4E	 ; Item ID #$22: Iron Helmet
.word $46	 ; Item ID #$23: Helmet of Erdrick

.word $0A	 ; Item ID #$24: Token of Erdrick
.word $00	 ; Item ID #$25: Tresures
.word $012C	 ; Item ID #$26: Moon Fragment
.word $00	 ; Item ID #$27: Charm of Rubiss
.word $00	 ; Item ID #$28: Eye of Malroth
.word $06	 ; Item ID #$29: Leaf of The World Tree
.word $0190	 ; Item ID #$2A: Echoing Flute
.word $00	 ; Item ID #$2B: Mirror of Ra
.word $28	 ; Item ID #$2C: Dew’s Yarn
.word $1E	 ; Item ID #$2D: Magic Loom
.word $46	 ; Item ID #$2E: Cloak of Wind
.word $05DC	 ; Item ID #$2F: Gremlin’s Tail
.word $0280	 ; Item ID #$30: Dragon’s Bane
.word $2710	 ; Item ID #$31: Dragon’s Potion
.word $01F4	 ; Item ID #$32: Golden Card
.word $46	 ; Item ID #$33: Lottery Ticket
.word $28	 ; Item ID #$34: Fairy Water
.word $50	 ; Item ID #$35: Wing of the Wyvern
.word $02	 ; Item ID #$36: [blank]
.word $02	 ; Item ID #$37: Golden Key
.word $02	 ; Item ID #$38: Silver Key
.word $07D0	 ; Item ID #$39: Jailor’s Key
.word $00	 ; Item ID #$3A: Watergate Key
.word $08	 ; Item ID #$3B: Antidote Herb
.word $0F	 ; Item ID #$3C: Medical Herb
.word $0A28	 ; Item ID #$3D: Wizard’s Ring
.word $02	 ; Item ID #$3E: Perilous
.word $02	 ; Item ID #$3F: [blank]


B06_A07C:
    lda $47 ; Stepguard flag

    bpl B06_A088
    cpy #$04
    bne B06_A095
    lda #$07
    sta $47 ; Stepguard flag

B06_A088:
    tya
    and $47 ; Stepguard flag

    beq B06_A09A
    asl
    sec
    sbc #$01
    ora $47 ; Stepguard flag

    sta $47 ; Stepguard flag

B06_A095:
    pla
    pla
    jmp B06_A1A1

B06_A09A:
    rts


B06_A09B:
.byte 4, 2, 1

B06_A09E:
    lda $015A
    sta $015B
    lda $0159
    sta $015A
    lda $3B ; high nybble = terrain ID

    sta $0159
    lda #$00
    sta $0E
    lda #$06
    sta $94 ; return bank for various function calls, doubles as index of selected option for multiple-choice menus

    lda $46 ; Repel (#$FE) / Fairy Water (#$FF) flag

    beq B06_A0DE
    cmp #$01
    bne B06_A0C3
    lda #$2B ; String ID #$012B: The Fairy Water evaporated and lost its power.[end-FC]

    bne B06_A0C9
B06_A0C3:
    cmp #$02
    bne B06_A0DA
    lda #$BE ; String ID #$01BE: Repel has lost its effect.[end-FC]

B06_A0C9:
    pha
    jsr B0F_EB76 ; open menu specified by next byte
    .byte $04
    pla
    jsr B0F_FA4E ; display string ID specified by A + #$0100

    lda #$01
    sta $0E
    lda #$02
    sta $46 ; Repel (#$FE) / Fairy Water (#$FF) flag

B06_A0DA:
    dec $46 ; Repel (#$FE) / Fairy Water (#$FF) flag

    dec $46 ; Repel (#$FE) / Fairy Water (#$FF) flag

B06_A0DE:
    inc $05FB ; movement counter

    lda $05FB ; movement counter

    and #$03
    bne B06_A10E
    lda $1F ; some kind of map type (#$00: World Map, #$01: other non-dungeon maps, #$02: maps #$2B - #$43 inclusive, #$03: maps >= #$44, #$FF => game menu)

    cmp #$01
    beq B06_A10E
    ldy #$00
B06_A0F0:
    lda $062D, y ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    and #$A0
    cmp #$A0
    bne B06_A105
    tya
    pha
    jsr B06_A262
    pla
    tay
    lda #$01
    jsr B06_A1C7
B06_A105:
    tya
    clc
    adc #$12
    tay
    cpy #$36
    bcc B06_A0F0
B06_A10E:
    lda #$24
    sta $49 ; object hero/target/item/string ID $49

    lda #$00
    sta $96 ; temp storage for item/spell/type/etc. IDs

B06_A116:
    lda $49 ; object hero/target/item/string ID $49

    lsr
    lsr
    lsr
    lsr
    tax
    ldy B06_A09B, x
    lda $0159, x
    cmp #$70
    bne B06_A12B
    lda #$02
    bne B06_A161
B06_A12B:
    cmp #$A0
    bne B06_A13D
    lda $31 ; current map ID

    cmp #$2E ; Map ID #$2E: Sea Cave B1

    bcc B06_A153
    cmp #$34 ; Map ID #$34: Charlock Castle B1/B2

    bcs B06_A153
    lda #$01
    bne B06_A161
B06_A13D:
    cmp #$80
    bne B06_A148
    jsr B06_A07C
    lda #$0F
    bne B06_A161
B06_A148:
    cmp #$90
    bne B06_A153
    jsr B06_A07C
    lda #$1E
    bne B06_A161
B06_A153:
    lda $47 ; Stepguard flag

    bmi B06_A1A1
    tya
    eor #$FF
    and $47 ; Stepguard flag

    sta $47 ; Stepguard flag

    jmp B06_A1A1

B06_A161:
    sta $CC
    ldy $49 ; object hero/target/item/string ID $49

    lda $062D, y ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    bpl B06_A1A1
    lda #$5B
    jsr B06_A1B5
    bcs B06_A1A1
    lda $CC
    cmp #$0A
    bcs B06_A17E
    lda #$53
    jsr B06_A1B5
    bcs B06_A1A1
B06_A17E:
    lda $96 ; temp storage for item/spell/type/etc. IDs

    bne B06_A19A
    tya
    pha
    lda $CC
    cmp #$0A
    bcs B06_A195
    lda #$91 ; Music ID #$91: swamp SFX

    jsr B0F_C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    jsr B06_A262
    jmp B06_A198

B06_A195:
    jsr B06_A296
B06_A198:
    pla
    tay
B06_A19A:
    inc $96 ; temp storage for item/spell/type/etc. IDs

    lda $CC
    jsr B06_A1C7
B06_A1A1:
    lda $49 ; object hero/target/item/string ID $49

    sec
    sbc #$12
    sta $49 ; object hero/target/item/string ID $49

    bmi B06_A1AD
    jmp B06_A116

B06_A1AD:
    lda $0E
    beq B06_A1B4
    jsr B0F_D0F5 ; wait for a while and then wipe menu regions #$03, #$00, and #$01

B06_A1B4:
    rts

B06_A1B5:
    sta $0C
    tya
    pha
    lsr
    lsr
    lsr
    lsr
    sta $9C
    lda $0C
    jsr B0F_C4B0 ; given a hero ID in $9C and an item ID in A, SEC if hero has that item, CLC otherwise

    pla
    tay
    rts

B06_A1C7:
    sta $0C
    lda $063B, y ; Midenhall Current HP, low byte

    sec
    sbc $0C
    sta $063B, y ; Midenhall Current HP, low byte

    lda $063C, y ; Midenhall Current HP, high byte

    sbc #$00
    sta $063C, y ; Midenhall Current HP, high byte

    bcs B06_A1E4
    lda #$00
    sta $063B, y ; Midenhall Current HP, low byte

    sta $063C, y ; Midenhall Current HP, high byte

B06_A1E4:
    ora $063B, y ; Midenhall Current HP, low byte

    beq B06_A1F5
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

B06_A1F5:
    lda #$04
    sta $062D, y ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    lda #$FF
    sta $35 ; flag indicating whether any menu is currently open

    lda $0E
    bne B06_A20E
    tya
    pha
    jsr B0F_EB76 ; open menu specified by next byte
    .byte $04
    pla
    tay
    lda #$00
    sta $0E
B06_A20E:
    inc $0E
    lda $0E
    pha
    tya
    pha
    lsr
    lsr
    lsr
    lsr
    sta $97 ; subject hero ID $97

    jsr B0F_FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    lda $97 ; subject hero ID $97

    clc
    adc #$03
    sta $97 ; subject hero ID $97

    jsr B0F_D302
    jsr B0F_FA2A ; display string ID specified by next byte
    .byte $1B
    pla
    tay
    pla
    sta $0E
    ldx #$00
B06_A233:
    lda $062D, x ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    bmi B06_A25D
    txa
    clc
    adc #$12
    tax
    cmp #$36
    bcc B06_A233
    jsr B0F_F6CE ; return number of party members - 1 in A/X

    beq B06_A24F
    lda #$80
    jsr B0F_FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $51
B06_A24F:
    lda #$12 ; Music ID #$12: party defeat BGM

    sta $05F7 ; probably BGM for current area

    jsr B0F_C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    jsr B06_809D ; wait until all joypad buttons are released and then some button pressed

    jmp B0F_D271

B06_A25D:
    lda #$00
    sta $35 ; flag indicating whether any menu is currently open

    rts

B06_A262:
    jsr B0F_C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    lda B06_A287
    sta $0A
    lda B06_A287+1
    jsr B06_A27E
    jsr B0F_C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF
    jsr B0F_C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF
    lda $C2E9
    sta $0A
    lda $C2EA
B06_A27E:
    sta $0B
    lda #$00
    sta $0C
    jmp B0F_C228


B06_A287:
.addr B06_A289

B06_A289:
.byte $0F
.byte $16
.byte $16
.byte $16
.byte $16
.byte $16
.byte $16
.byte $16
.byte $16
.byte $16
.byte $16
.byte $16
.byte $16

B06_A296:
    lda #$81 ; Music ID #$81: hit 1 SFX

    jsr B0F_C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    lda #$04
    sta $13
B06_A29F:
    jsr B06_A262
    dec $13
    bne B06_A29F
    rts

B06_A2A7:
    lda $0112 ; Crests found bit field (#$10 = Life, #$80 = Water, #$04 = Moon, #$02 = Stars, #$01 = Sun)

    and #$1F
    cmp #$1F
    beq B06_A2B1
B06_A2B0:
    rts

B06_A2B1:
    lda #$27
    jsr B06_A369 ; check for item A in party inventory, returning inventory index of item in A/X if found, #$FF if not

    cmp #$FF
    bne B06_A2B0
    lda #$05 ; Music ID #$05: Rubiss BGM

    jsr B0F_C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    lda #$04
    sta $49 ; object hero/target/item/string ID $49

    jsr B06_A2FB
    jsr B0F_F6F6 ; open main dialogue window and display string ID specified by byte following JSR + #$0200
    .byte $FD
    lda #$27
    sta $96 ; temp storage for item/spell/type/etc. IDs

    lda #$00
    sta $97 ; subject hero ID $97

    jsr B06_8D7E ; given hero ID in $97 and item ID in $96, try to add item to first empty slot in hero's inventory; SEC if added, CLC if no empty slots

    bcs B06_A2E9
    inc $97 ; subject hero ID $97

    jsr B06_8D7E ; given hero ID in $97 and item ID in $96, try to add item to first empty slot in hero's inventory; SEC if added, CLC if no empty slots

    bcs B06_A2E9
    inc $97 ; subject hero ID $97

    jsr B06_8D7E ; given hero ID in $97 and item ID in $96, try to add item to first empty slot in hero's inventory; SEC if added, CLC if no empty slots

    bcs B06_A2E9
    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $D8
B06_A2E9:
    ldx #$3C
    jsr B0F_C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

    lda #$FF
    sta $49 ; object hero/target/item/string ID $49

    jsr B06_A2FB
    jsr B0F_C59D
    jmp B0F_D0F5 ; wait for a while and then wipe menu regions #$03, #$00, and #$01


B06_A2FB:
    ldy #$1F
    jsr B06_A30C
    ldy #$27
    jsr B06_A30C
    ldy #$2F
    jsr B06_A30C
    ldy #$37
B06_A30C:
    lda $49 ; object hero/target/item/string ID $49

    sta $053A, y
    jsr B0F_CF64
    ldx #$19
    jmp B0F_C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF


; if $05FC is #$00, copy battle stats at $015D, y to field stats at $0600, x, otherwise copy field stats at $0600, x to battle stats at $015D, y
B06_A319:
    ldx #$00
    ldy #$00
B06_A31D:
    stx $0C
    lda B06_A34D+1, x
    sta $0D
    lda B06_A34D, x ; stat ranges

    tax
B06_A328:
    jsr B06_A33A ; if $05FC is #$00, copy $015D, y to $0600, x, otherwise copy $0600, x to $015D, y

    inx
    iny
    cpx $0D
    bne B06_A328
    ldx $0C
    inx
    inx
    cpx #$10
    bne B06_A31D
    rts

; if $05FC is #$00, copy $015D, y to $0600, x, otherwise copy $0600, x to $015D, y
B06_A33A:
    lda $05FC
    beq B06_A346
    lda $0600, x ; Midenhall inventory item 1 (| #$40 if equipped)

    sta $015D, y
    rts

B06_A346:
    lda $015D, y
    sta $0600, x ; Midenhall inventory item 1 (| #$40 if equipped)

    rts


; stat ranges
B06_A34D:
.byte $00,$18
.byte $24,$26
.byte $2D,$2E
.byte $3B,$3E
.byte $3F,$40
.byte $4D,$50
.byte $51,$52
.byte $5F,$62

; save game handler
B06_A35D:
    jmp B0F_D159

; check for item A (possibly equipped) in party inventory, returning inventory index of item in A/X if found, #$FF if not
B06_A360:
    jsr B06_A369 ; check for item A in party inventory, returning inventory index of item in A/X if found, #$FF if not

    bpl B06_A39F ; if found, RTS

    lda $0C ; otherwise re-load the item ID

    ora #$40 ; and check for an equipped version

; check for item A in party inventory, returning inventory index of item in A/X if found, #$FF if not
B06_A369:
    sty $10 ; save Y in $10

    sta $0C ; save item ID in $0C

    ldx #$00 ; initialize both inventory index and hero ID to #$00

    stx $0D ; inventory index

B06_A371:
    ldy $0D ; hero ID

    lda B06_A3A0, y ; pre-computed offsets for the start of each hero's data (what's wrong with the same data at $06:$9D55?)

    tay
    lda $062D, y ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    and #$04 ; pick out the In Party bit

    bne B06_A385 ; if not in party, skip to the next hero (but heroes are gained sequentially and never leave, so BNE $A39A would be faster)

    txa ; inventory index

    clc
    adc #$08 ; move to start of next hero's inventory

    tax
    bne B06_A392 ; branch always taken; skip cheking current hero's inventory (since they're not in the party)

B06_A385:
    lda $0600, x ; Midenhall inventory item 1 (| #$40 if equipped)

    cmp $0C ; item ID

    beq B06_A39C ; if we have one, then done

    inx ; otherwise move to next inventory index

    txa ; calculate inventory index mod 8

    and #$07
    bne B06_A385 ; if this hero has more inventory to check, check it

B06_A392:
    inc $0D ; increment hero ID

    lda $0D
    cmp #$03 ; 3 heroes total

    bne B06_A371 ; if more heroes to check, check them

    ldx #$FF ; otherwise flag item not found

B06_A39C:
    ldy $10 ; restore Y from $10

    txa
B06_A39F:
    rts


; pre-computed offsets for the start of each hero's data (what's wrong with the same data at $06:$9D55?)
B06_A3A0:
.byte $00,$12,$24

; given item ID in $96 and hero ID in $97, set A to #$80 if hero can equip item, #$00 otherwise
B06_A3A3:
    stx $10 ; save X

    lda $96 ; temp storage for item/spell/type/etc. IDs; item ID

    and #$3F ; strip off equipped bit

    tax
    lda EquipFields, x ; Bit fields controlling who can equip each item

    sta $0D
    ldy $97 ; subject hero ID $97

    iny ; number of bits to shift

B06_A3B2:
    lda #$00 ; initialize return value

    lsr $0D ; shift hero's equipability bit into C

    ror ; and then into A

    dey ; number of bits to shift

    bne B06_A3B2 ; if it's the wrong hero's data, loop to next hero

    ldx $10 ; restore X

    rts


; Bit fields controlling who can equip each item
; #$01 = Midenhall, #$02 = Cannock, #$04 = Moonbrooke
.define equipbytes(miden,cann,moon) .byte (moon << 2) | (cann << 1) | miden

EquipFields:
equipbytes 0, 0, 0	 ; Item ID #$00: (no item)
equipbytes 1, 1, 1	 ; Item ID #$01: Bamboo Stick
equipbytes 1, 1, 1	 ; Item ID #$02: Magic Knife
equipbytes 1, 1, 1	 ; Item ID #$03: Wizard’s Wand
equipbytes 1, 1, 1	 ; Item ID #$04: Staff of Thunder
equipbytes 1, 1, 0	 ; Item ID #$05: Club
equipbytes 1, 1, 0	 ; Item ID #$06: Copper Sword
equipbytes 1, 1, 0	 ; Item ID #$07: Chain Sickle
equipbytes 1, 1, 0	 ; Item ID #$08: Iron Spear
equipbytes 1, 1, 0	 ; Item ID #$09: Falcon Sword
equipbytes 1, 0, 0	 ; Item ID #$0A: Broad Sword
equipbytes 1, 0, 0	 ; Item ID #$0B: Giant Hammer
equipbytes 1, 0, 0	 ; Item ID #$0C: Sword of Destruction
equipbytes 1, 0, 0	 ; Item ID #$0D: Dragon Killer
equipbytes 1, 0, 0	 ; Item ID #$0E: Light Sword
equipbytes 1, 0, 0	 ; Item ID #$0F: Sword of Erdrick
equipbytes 1, 0, 0	 ; Item ID #$10: Thunder Sword

equipbytes 1, 1, 1	 ; Item ID #$11: Clothes
equipbytes 1, 1, 1	 ; Item ID #$12: Clothes Hiding
equipbytes 1, 1, 1	 ; Item ID #$13: Water Flying Cloth
equipbytes 1, 1, 1	 ; Item ID #$14: Mink Coat
equipbytes 1, 1, 0	 ; Item ID #$15: Leather Armor
equipbytes 1, 1, 0	 ; Item ID #$16: Chain Mail
equipbytes 1, 1, 0	 ; Item ID #$17: Gremlin’s Armor
equipbytes 1, 1, 0	 ; Item ID #$18: Magic Armor
equipbytes 1, 0, 0	 ; Item ID #$19: Full Plate Armor
equipbytes 1, 0, 0	 ; Item ID #$1A: Armor of Gaia
equipbytes 1, 0, 0	 ; Item ID #$1B: Armor of Erdrick

equipbytes 1, 1, 0	 ; Item ID #$1C: Leather Shield
equipbytes 1, 1, 0	 ; Item ID #$1D: Shield of Strength
equipbytes 1, 0, 0	 ; Item ID #$1E: Steel Shield
equipbytes 1, 0, 0	 ; Item ID #$1F: Evil Shield
equipbytes 1, 0, 0	 ; Item ID #$20: Shield of Erdrick

equipbytes 1, 1, 1	 ; Item ID #$21: Mysterious Hat
equipbytes 1, 0, 0	 ; Item ID #$22: Iron Helmet
equipbytes 1, 0, 0	 ; Item ID #$23: Helmet of Erdrick

; pointers to warp spaces for irregularly-shaped maps
B06_A3E1:
.addr $0000      ; $06:$0000; Map ID #$2B: Cave to Hamlin
.addr B06_A41B      ; $06:$A41B; Map ID #$2C: Lake Cave B1
.addr B06_A430      ; $06:$A430; Map ID #$2D: Lake Cave B2
.addr B06_A445      ; $06:$A445; Map ID #$2E: Sea Cave B1
.addr B06_A450      ; $06:$A450; Map ID #$2F: Sea Cave B2
.addr $0000      ; $06:$0000; Map ID #$30: Sea Cave B3-1
.addr $0000      ; $06:$0000; Map ID #$31: Sea Cave B3-2
.addr $0000      ; $06:$0000; Map ID #$32: Sea Cave B4
.addr $0000      ; $06:$0000; Map ID #$33: Sea Cave B5
.addr $0000      ; $06:$0000; Map ID #$34: Charlock Castle B1/B2
.addr $0000      ; $06:$0000; Map ID #$35: Charlock Castle B3/B4-1/B5-1
.addr $0000      ; $06:$0000; Map ID #$36: Charlock Castle B4-2/B5-2/B6
.addr $0000      ; $06:$0000; Map ID #$37: Cave to Rhone B1
.addr $0000      ; $06:$0000; Map ID #$38: Cave to Rhone 1F
.addr B06_A45B      ; $06:$A45B; Map ID #$39: Cave to Rhone 2F-1
.addr B06_A498      ; $06:$A498; Map ID #$3A: Cave to Rhone 2F-2
.addr B06_A4D5      ; $06:$A4D5; Map ID #$3B: Cave to Rhone 2F-3
.addr B06_A4F4      ; $06:$A4F4; Map ID #$3C: Cave to Rhone 3F
.addr $0000      ; $06:$0000; Map ID #$3D: Cave to Rhone 4F
.addr $0000      ; $06:$0000; Map ID #$3E: Cave to Rhone 5F
.addr B06_A531      ; $06:$A531; Map ID #$3F: Cave to Rhone 6F
.addr $0000      ; $06:$0000; Map ID #$40: Spring of Bravery
.addr $0000      ; $06:$0000; Map ID #$41: unused?
.addr $0000      ; $06:$0000; Map ID #$42: unused?
.addr $0000      ; $06:$0000; Map ID #$43: Cave to Rimuldar
.addr $0000      ; $06:$0000; Map ID #$44: Hargon's Castle 2F
.addr $0000      ; $06:$0000; Map ID #$45: Hargon's Castle 3F
.addr $0000      ; $06:$0000; Map ID #$46: Hargon's Castle 4F
.addr $0000      ; $06:$0000; Map ID #$47: Hargon's Castle 5F

; warp spaces for irregularly-shaped maps; format is (destination map ID, destination X-pos, destination Y-pos, transition X-pos, transition Y-pos), all positions are 7-bit, describing a 2x2 space
; Map ID #$2C: Lake Cave B1
B06_A41B:
.byte $2C,$1E,$16,$FE,$10
.byte $2C,$00,$10,$20,$16
.byte $2C,$04,$00,$18,$20
.byte $2C,$18,$1E,$04,$FE
.byte $FF

; Map ID #$2D: Lake Cave B2
B06_A430:
.byte $2D,$16,$02,$0E,$20
.byte $2D,$0E,$1E,$16,$00
.byte $2D,$1A,$1C,$FE,$1C
.byte $2D,$00,$1C,$1C,$1C
.byte $FF

; Map ID #$2E: Sea Cave B1
B06_A445:
.byte $2E,$04,$02,$02,$1C
.byte $2E,$02,$1A,$04,$00
.byte $FF

; Map ID #$2F: Sea Cave B2
B06_A450:
.byte $2F,$20,$14,$12,$28
.byte $2F,$12,$26,$20,$12
.byte $FF

; Map ID #$39: Cave to Rhone 2F-1
B06_A45B:
.byte $3A,$06,$0A,$06,$00
.byte $3A,$10,$0A,$10,$00
.byte $3A,$1A,$0A,$1A,$00
.byte $3A,$24,$0A,$24,$00
.byte $3A,$2E,$0A,$2E,$00
.byte $3A,$06,$02,$06,$0C
.byte $3A,$10,$02,$10,$0C
.byte $3A,$1A,$02,$1A,$0C
.byte $3A,$24,$02,$24,$0C
.byte $3A,$2E,$02,$2E,$0C
.byte $3B,$08,$04,$FE,$08
.byte $3B,$00,$04,$36,$08
.byte $FF

; Map ID #$3A: Cave to Rhone 2F-2
B06_A498:
.byte $39,$06,$0A,$06,$00
.byte $39,$10,$0A,$10,$00
.byte $39,$1A,$0A,$1A,$00
.byte $39,$24,$0A,$24,$00
.byte $39,$2E,$0A,$2E,$00
.byte $39,$06,$02,$06,$0C
.byte $39,$10,$02,$10,$0C
.byte $39,$1A,$02,$1A,$0C
.byte $39,$24,$02,$24,$0C
.byte $39,$2E,$02,$2E,$0C
.byte $3B,$08,$0E,$FE,$08
.byte $3B,$00,$0E,$36,$08
.byte $FF

; Map ID #$3B: Cave to Rhone 2F-3
B06_A4D5:
.byte $3B,$04,$00,$04,$14
.byte $3B,$04,$12,$04,$FE
.byte $39,$34,$08,$FE,$04
.byte $39,$00,$08,$0A,$04
.byte $3A,$34,$08,$FE,$0E
.byte $3A,$00,$08,$0A,$0E
.byte $FF

; Map ID #$3C: Cave to Rhone 3F
B06_A4F4:
.byte $3C,$16,$18,$FE,$06
.byte $3C,$00,$06,$18,$18
.byte $3C,$26,$0A,$FE,$12
.byte $3C,$00,$12,$28,$0A
.byte $3C,$26,$16,$FE,$22
.byte $3C,$00,$22,$28,$16
.byte $3C,$22,$1E,$20,$38
.byte $3C,$20,$36,$22,$1C
.byte $3C,$0A,$2A,$28,$34
.byte $3C,$26,$34,$08,$2A
.byte $3C,$26,$02,$10,$16
.byte $3C,$12,$16,$28,$02
.byte $FF

; Map ID #$3F: Cave to Rhone 6F
B06_A531:
.byte $3F,$02,$16,$1A,$12
.byte $3F,$18,$12,$00,$16
.byte $3F,$18,$12,$20,$14
.byte $3F,$18,$12,$FE,$02
.byte $3F,$08,$0C,$12,$0E
.byte $3F,$12,$10,$08,$0E
.byte $3F,$12,$10,$06,$30
.byte $3F,$24,$0E,$0A,$12
.byte $3F,$0C,$12,$26,$0E
.byte $3F,$0C,$12,$06,$02
.byte $3F,$0C,$12,$06,$12
.byte $3F,$00,$0C,$28,$02
.byte $3F,$26,$02,$FE,$0C
.byte $3F,$00,$12,$28,$1A
.byte $3F,$26,$1A,$FE,$12
.byte $3F,$00,$26,$1E,$04
.byte $3F,$00,$26,$28,$14
.byte $3F,$00,$26,$20,$1C
.byte $3F,$10,$2C,$12,$24
.byte $3F,$10,$2C,$20,$22
.byte $3F,$10,$2C,$1A,$2C
.byte $3F,$22,$22,$12,$2C
.byte $3F,$00,$1C,$28,$24
.byte $3F,$00,$1C,$28,$2C
.byte $3F,$26,$24,$FE,$1C
.byte $3F,$00,$20,$28,$28
.byte $3F,$26,$28,$FE,$20
.byte $3F,$1C,$2C,$28,$20
.byte $3F,$0E,$0C,$1E,$26
.byte $3F,$1A,$1E,$0A,$FE
.byte $3F,$16,$2E,$1C,$16
.byte $3F,$08,$18,$1C,$24
.byte $3F,$1A,$24,$06,$18
.byte $3F,$18,$0A,$16,$1E
.byte $3F,$14,$1E,$16,$0A
.byte $3F,$06,$2E,$12,$FE
.byte $3F,$0C,$24,$0E,$0E
.byte $3F,$0C,$24,$1A,$20
.byte $3F,$0C,$24,$16,$30
.byte $3F,$12,$0A,$12,$1A
.byte $3F,$12,$18,$12,$08
.byte $3F,$12,$18,$0C,$22
.byte $3F,$12,$18,$22,$FE
.byte $3F,$1C,$04,$FE,$26
.byte $FF

    lda #$FF
    bne B06_A614
B06_A612:
    lda #$00
B06_A614:
    jsr B06_A61A
    jmp B0F_C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF


B06_A61A:
    pha
    lda a:$01
    beq B06_A623
    jsr B0F_C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

B06_A623:
    lda #$01
    sta $0183
    lda #$00
    sta $6080
    pla
    jsr B06_A763
    lda #$00
    sta $6081
    sta $6082
    lda $607B
    pha
    and #$F0
    lsr
    lsr
    lsr
    sta $607E
    pla
    and #$0F
    asl
    sta $607F
    sta $6083
    ldx a:$02
B06_A652:
    lda $08
    sta $6090
    lda $07
    sta $608F
    and #$1F
    sta $608B
    lda #$20
    sec
    sbc $608B
    sta $608D
    lda $607F
    sec
    sbc $608D
    sta $608E
    beq B06_A678
    bcs B06_A681
B06_A678:
    lda $607F
    sta $608D
    jmp B06_A6A4

B06_A681:
    jsr B06_A6D6
    lda $6090
    eor #$04
    sta $6090
    lda $608F
    and #$1F
    sta $608B
    lda $608F
    sec
    sbc $608B
    sta $608F
    lda $608E
    sta $608D
B06_A6A4:
    jsr B06_A6D6
    lda $08
    and #$FB
    cmp #$23
    bcc B06_A6C0
    lda $07
    cmp #$A0
    bcc B06_A6C0
    and #$1F
    sta $07
    lda $08
    and #$FC
    jmp B06_A6CB

B06_A6C0:
    lda $07
    clc
    adc #$20
    sta $07
    lda $08
    adc #$00
B06_A6CB:
    sta $08
    dec $607E
    bne B06_A652
    stx a:$02
    rts

B06_A6D6:
    lda $6090
    ora #$80
    sta $0300, x ; PPU write buffer start

    lda $608D
    sta $0301, x
    lda $608F
    sta $0302, x
    inx
    inx
    inx
    lda $608D
    pha
    ldy $6081
B06_A6F4:
    lda $600B, y
    sta $0300, x ; PPU write buffer start

    inx
    iny
    dec $608D
    bne B06_A6F4
    sty $6081
    pla
    lsr
    sta $608D
    lda $607E
    and #$01
    beq B06_A75F
    ldy $6082
    lda $6090
    sta $6098
    lda $608F
    sta $6097
B06_A71F:
    txa
    pha
    tya
    pha
    lda $6090
    pha
    lda $606B, y
    jsr B06_A789
    sta $608B
    pla
    sta $6090
    pla
    tay
    pla
    tax
    lda $609A
    sta $0300, x ; PPU write buffer start

    inx
    lda $6099
    sta $0300, x ; PPU write buffer start

    inx
    lda $608B
    sta $0300, x ; PPU write buffer start

    inx
    iny
    inc $6097
    inc $6097
    inc a:$01
    dec $608D
    bne B06_A71F
    sty $6082
B06_A75F:
    inc a:$01
    rts

B06_A763:
    pha
    jsr B06_A772
    pla
    bne B06_A76B
    rts

B06_A76B:
    lda $08
    eor #$04
    sta $08
    rts

B06_A772:
    lda $607C
    asl
    and #$1E
    sta $608B
    lda $607C
    lsr
    lsr
    lsr
    and #$1E
    sta $608C
    jmp B06_A809

B06_A789:
    sta $6096
    lda #$1F
    and $6097
    lsr
    lsr
    sta $6090
    lda #$80
    and $6097
    lsr
    lsr
    lsr
    lsr
    ora $6090
    sta $6090
    lda #$03
    and $6098
    asl
    asl
    asl
    asl
    ora #$C0
    ora $6090
    sta $6099
    ldx #$23
    lda $6098
    cmp #$24
    bcc B06_A7C1
    ldx #$27
B06_A7C1:
    stx $609A
    lda $6097
    and #$40
    lsr
    lsr
    lsr
    lsr
    sta $6093
    lda $6097
    and #$02
    ora $6093
    sta $6093
    lda $6099
    sta $57 ; pointer to start of main pointer table, low byte

    lda $609A
    and #$07
    sta $58 ; pointer to start of main pointer table, high byte

    ldy #$00
    lda ($57), y ; pointer to start of main pointer table, low byte

    sta $6094
    lda #$03
    ldy $6093
    beq B06_A7FC
B06_A7F5:
    asl
    asl $6096
    dey
    bne B06_A7F5
B06_A7FC:
    eor #$FF
    and $6094
    ora $6096
    ldy #$00
    sta ($57), y ; pointer to start of main pointer table, low byte

    rts

; from $02:$B74E, $06:$B0A8, $0F:$FD25, $0F:$FD98 via $8002
B06_A809:
    lda $04
    asl
    asl
    and #$04
    ora #$20
    sta $08
    lda $608B
    asl
    asl
    asl
    clc
    adc $05
    sta $07
    bcc B06_A826
    lda $08
    eor #$04
    sta $08
B06_A826:
    lda $06
    lsr
    lsr
    lsr
    clc
    adc $608C
    cmp #$1E
    bcc B06_A835
    sbc #$1E
B06_A835:
    lsr
    ror $07
    lsr
    ror $07
    lsr
    ror $07
    ora $08
    sta $08
    rts

; display and handle main game menu
; from $0F:$C6C7 via $8004
B06_A843:
    lda #$0C ; Music ID #$0C: game menu / Wellgarth singer BGM

    sta $05F7 ; probably BGM for current area

    jsr B0F_D14F
    lda #$00 ; Music ID #$00: BGM off

    sta $05F7 ; probably BGM for current area

    jsr B06_A8CA
B06_A853:
    jsr B06_A97E
B06_A856:
    jsr B06_A9A3 ; open apporpriate main game menu based on number of filled save slots, set $75DB = #$0A, #$05, or #$00 based on number of filled slots, return menu selection index in A

    jsr B06_A9CF
    jmp B06_A853

; from $0F:$D15F via $8008
B06_A85F:
    lda #$19 ; Menu ID #$19: General menu: YES/NO

    jsr B06_A993 ; open menu specified by A

    tax
    bne B06_A874 ; branch if NO

    lda #$FF
    sta $7070 ; ????, SRAM buffer

    jsr B06_A885 ; copy save data from system RAM to per-game save data

    lda #$78 ; String ID #$0078: ‘I have entered thy deeds in the Imperial Scrolls of Honor[.’][wait][end-FC]

    jsr B06_A99B ; display string ID specified by A

B06_A874:
    lda #$79 ; String ID #$0079: ‘Dost thou wish to continue thy quest?’[FD][FD][end-FC]

    jsr B06_A99B ; display string ID specified by A

    lda #$19 ; Menu ID #$19: General menu: YES/NO

    jsr B06_A993 ; open menu specified by A

    tax
    bne B06_A882 ; branch if NO

    rts

B06_A882:
    jmp B0F_D175

; copy save data from system RAM to per-game save data
; from $0F:$C6DA via $801E
B06_A885:
    jsr B06_AC3C ; copy save data from system RAM to $7000-$706F

    jsr B06_ACAD ; initialize the RNG based on 71 passes using SRAM data $7000-$7070 and save resulting seed to $7071-$7072

    jsr B06_AB87 ; copy data from SRAM buffer to per-game save data

    rts

; copy Midenhall's short name from save slot in A to $0100 in reverse
; from $0F:$EE7E via $801C
B06_A88F:
    jsr B06_A9F5 ; given save slot number in A, set $99-$9A to pointer to second part of save slot data

    ldy #$03 ; copy 4 bytes

    bne B06_A89E
; copy Midenhall's full name from save slot in $75DB to $0100 in reverse
; from $0F:$EF5B via $800A
B06_A896:
    lda $75DB ; in game: current game save slot; out of game: various temporary game menu setup values

    jsr B06_A9F5 ; given save slot number in A, set $99-$9A to pointer to second part of save slot data

    ldy #$07 ; copy 8 bytes

B06_A89E:
    ldx #$00
B06_A8A0:
    lda ($99), y
    sta $0100, x ; string copy buffer start (often referenced as $00FF, x)

    inx
    dey
    bpl B06_A8A0
    rts

; given current game save slot in $75DB, return Midenhall's level in that save game in A/$0E
B06_A8AA:
    lda $75DB ; in game: current game save slot; out of game: various temporary game menu setup values

    jsr B06_A9F5 ; given save slot number in A, set $99-$9A to pointer to second part of save slot data

    ldy #$08 ; offset for Midenhall's level

    lda ($99), y
    sta $0E
    rts

B06_A8B7:
    jsr B06_A9F5 ; given save slot number in A, set $99-$9A to pointer to second part of save slot data

    ldx #$02
    ldy #$09
    lda ($99), y
    bmi B06_A8C8
    cmp #$46
    beq B06_A8C7
    dex
B06_A8C7:
    dex
B06_A8C8:
    txa
    rts

B06_A8CA:
    ldx #$05
B06_A8CC:
    lda B06_ADB9, x
    cmp $75FA, x
    beq B06_A8DE
    cmp $6001, x
    beq B06_A8DE
    cmp $61A7, x
    bne B06_A8E3
B06_A8DE:
    dex
    bpl B06_A8CC
    bmi B06_A919
B06_A8E3:
    lda B06_ADF4
    sta a:$99
    lda B06_ADF4+1
    sta a:$9A
    ldx #$0D
B06_A8F1:
    ldy #$72
    lda #$00
B06_A8F5:
    sta ($99), y
    dey
    bpl B06_A8F5
    sec
    lda $99
    sbc #$73
    sta $99
    lda $9A
    sbc #$00
    sta $9A
    dex
    bne B06_A8F1
    lda #$00
    sta $75DA ; bit field for which save game slots are filled

    ldx #$02
    lda #$FF
B06_A913:
    sta $75D7, x ; save slot 1 status (write-only?)

    dex
    bpl B06_A913
B06_A919:
    ldx #$05
B06_A91B:
    lda B06_ADB9, x
    sta $75FA, x
    sta $6001, x
    sta $61A7, x
    dex
    bpl B06_A91B
    lda #$00
    sta $75DB ; in game: current game save slot; out of game: various temporary game menu setup values

B06_A92F:
    ldx $75DB ; in game: current game save slot; out of game: various temporary game menu setup values

    lda $75DA ; bit field for which save game slots are filled

B06_A935:
    lsr
    dex
    bpl B06_A935
    bcc B06_A96B
    jsr B06_AB44 ; copy current save game's data to save data buffer at $7000; CLC if data is valid, SEC if it's unrecoverable

    bcc B06_A968
    ldx $75DB ; in game: current game save slot; out of game: various temporary game menu setup values

    lda #$FD
    sta $75D7, x ; save slot 1 status (write-only?)

    inx
    stx $8F
    lda #$00
    sta $90
    lda #$04 ; Menu ID #$04: Dialogue window

    jsr B06_A993 ; open menu specified by A

    lda #$0A ; Music ID #$0A: cursed BGM

    jsr B0F_C58D ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM]), wait for it to finish, then play previous BGM

    inc $8E ; flag for in battle or not (#$FF)?

    lda #$77 ; String ID #$0077: [no voice]I'm afraid that[line][no voice]scenario [number] was not[line][no voice]recorded in the[line][no voice]Imperial Scrolls of[line][no voice]Honor.[end-FC]

    jsr B06_A99B ; display string ID specified by A

    inc $8E ; flag for in battle or not (#$FF)?

    jsr B06_A976 ; wait for controller input

    jsr B06_AAEB
B06_A968:
    jsr B06_AA02 ; copy more data to second part of per-game save data

B06_A96B:
    inc $75DB ; in game: current game save slot; out of game: various temporary game menu setup values

    lda $75DB ; in game: current game save slot; out of game: various temporary game menu setup values

    cmp #$03
    bcc B06_A92F
    rts

; wait for controller input
B06_A976:
    jsr B0F_C476 ; read joypad 1 data into $2F

    lda $2F ; joypad 1 data

    beq B06_A976 ; wait for controller input

    rts

B06_A97E:
    jsr B0F_C42A
    jsr B0F_C446 ; turn screen off, write $800 [space] tiles to PPU $2000, turn screen on

    jsr B0F_C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    lda #$80
    sta $6007
    jsr B0F_C41C ; wait for interrupt, turn screen sprites and backround on

    jsr B0F_D14F
    rts

; open menu specified by A
B06_A993:
    ldx #$06
    stx $94 ; return bank for various function calls, doubles as index of selected option for multiple-choice menus

    jsr B0F_EB89 ; open menu specified by A

    rts ; JMP > JSR + RTS


; display string ID specified by A
B06_A99B:
    ldx #$06
    stx $94 ; return bank for various function calls, doubles as index of selected option for multiple-choice menus

    jsr B0F_FA4A ; display string ID specified by A

    rts

; open apporpriate main game menu based on number of filled save slots, set $75DB = #$0A, #$05, or #$00 based on number of filled slots, return menu selection index in A
B06_A9A3:
    ldx #$02
    lda $75DA ; bit field for which save game slots are filled

    and #$07
    beq B06_A9B2 ; 0 slots filled => use X = #$02

    cmp #$07
    bne B06_A9B1 ; 1-2 slots filled => use X = #$01

    dex ; 3 slots filled => use X = #$00

B06_A9B1:
    dex
B06_A9B2:
    txa
    sta $75DB ; in game: current game save slot; out of game: various temporary game menu setup values; base index into main game menu handlers

    asl
    asl
    adc $75DB ; in game: current game save slot; out of game: various temporary game menu setup values; base index into main game menu handlers

    sta $75DB ; in game: current game save slot; out of game: various temporary game menu setup values; base index into main game menu handlers

    txa
    clc
    adc #$32 ; Menu ID #$32 - #$34: Game menu: 3, 1-2, or 0 saves

    jsr B06_A993 ; open menu specified by A

    cmp #$FF
    beq B06_A9CA
    rts

B06_A9CA:
    pla
    pla
    jmp B06_A856

B06_A9CF:
    clc
    adc $75DB ; in game: current game save slot; out of game: various temporary game menu setup values; base index into main game menu handlers

    tax
    lda B06_ADD7, x ; index into jump table at B06_ADE2

    asl
    tax
    lda B06_ADE2, x ; jump table for main game menu handlers

    sta $99
    lda B06_ADE2+1, x
    sta $9A
    jmp ($0099)

    tay
    ldx #$00
    lda $75DA ; bit field for which save game slots are filled

B06_A9EC:
    inx
    lsr
    bcc B06_A9EC
    dey
    bpl B06_A9EC
    dex
    txa
; given save slot number in A, set $99-$9A to pointer to second part of save slot data
B06_A9F5:
    asl
    tax
    lda B06_ADF6, x
    sta $99
    lda B06_ADF6+1, x
    sta $9A
    rts

; copy more data to second part of per-game save data
B06_AA02:
    lda $75DB ; in game: current game save slot; out of game: various temporary game menu setup values

    jsr B06_A9F5 ; given save slot number in A, set $99-$9A to pointer to second part of save slot data

    ldy #$09
    lda $706F ; current battle message delay, SRAM buffer

    sta ($99), y
    dey
    lda $7026
    sta ($99), y
    ldx #$03
B06_AA17:
    dey
    lda $7063, x ; party names, bytes 4-7, SRAM buffer

    sta ($99), y
    dex
    bpl B06_AA17
    dey
B06_AA21:
    lda $7009, y ; Midenhall name bytes 0-3, SRAM buffer

    sta ($99), y
    dey
    bpl B06_AA21
    rts

; mark save game slot specified by $75DB as filled
B06_AA2A:
    sec
    lda #$00
    ldx $75DB ; in game: current game save slot; out of game: various temporary game menu setup values

B06_AA30:
    rol
    dex
    bpl B06_AA30 ; keep shifting that 1 set bit until it's in the right position

    ora $75DA ; bit field for which save game slots are filled

    sta $75DA ; bit field for which save game slots are filled

    rts

; mark save game slot specified by $75DB as empty
B06_AA3B:
    clc
    lda #$FF
    ldx $75DB ; in game: current game save slot; out of game: various temporary game menu setup values

B06_AA41:
    rol
    dex
    bpl B06_AA41 ; keep shifting that 1 clear bit until it's in the right position

    and $75DA ; bit field for which save game slots are filled

    sta $75DA ; bit field for which save game slots are filled

    rts

; set $75D7,$75DB to #$FF (useless op?)
B06_AA4C:
    lda #$FF
    ldx $75DB ; in game: current game save slot; out of game: various temporary game menu setup values

    sta $75D7, x ; save slot 1 status (write-only?)

    rts

; CONTINUE A QUEST handler
B06_AA55:
    jsr B06_AB0C ; display filled slots selection menu, set A/$75DB to selected slot

    jsr B06_AB44 ; copy current save game's data to save data buffer at $7000; CLC if data is valid, SEC if it's unrecoverable

    jsr B06_ABC7 ; copy save data from save data buffer at $7000 to system RAM; update Don Mahone quest status if applicable

B06_AA5E:
    pla
    pla
    jsr B0F_C577 ; set $6144 to #$05

    rts

; CHANGE MESSAGE SPEED handler
B06_AA64:
    jsr B06_AB0C ; display filled slots selection menu, set A/$75DB to selected slot

    jsr B06_AB44 ; copy current save game's data to save data buffer at $7000; CLC if data is valid, SEC if it's unrecoverable

    jsr B06_AA6E ; display Menu ID #$45: Game menu: select message speed, update message speed based on new selection

    rts

; display Menu ID #$45: Game menu: select message speed, update message speed based on new selection
B06_AA6E:
    lda $706F ; current battle message delay, SRAM buffer

    sta $062C ; current battle message delay

    lda #$45 ; Menu ID #$45: Game menu: select message speed

    jsr B06_A993 ; open menu specified by A

    cmp #$FF
    beq B06_AA8F ; pop JSR return address and RTS back to to display and handle main game menu

    tax
    lda B06_ADBF, x ; battle message delays (frames between prints; higher = slower)

    sta $706F ; current battle message delay, SRAM buffer

    sta $062C ; current battle message delay

    jsr B06_ACAD ; initialize the RNG based on 71 passes using SRAM data $7000-$7070 and save resulting seed to $7071-$7072

    jsr B06_AB87 ; copy data from SRAM buffer to per-game save data

    clc
    rts

; pop JSR return address and RTS back to to display and handle main game menu
B06_AA8F:
    pla
    pla
    sec
    rts

; BEGIN A NEW QUEST handler
B06_AA93:
    lda #$00
    sta $7070 ; ????, SRAM buffer

    jsr B06_AB15 ; display empty slots selection menu, set A/$75DB to selected slot

    jsr B06_ACCD
    jsr B06_AAC0 ; if $0100 is [space], pop JSR return address and RTS back to to display and handle main game menu

    lda #$46 ; NORMAL

    sta $062C ; current battle message delay

    sta $706F ; current battle message delay, SRAM buffer

    jsr B06_AA6E ; display Menu ID #$45: Game menu: select message speed, update message speed based on new selection

    bcs B06_AABD ; impossible branch; if B06_AA6E finishes with SEC, it also popped its return address, so control flow does not end up here

    jsr B06_AA2A ; mark save game slot specified by $75DB as filled

    jsr B06_AA4C ; set $75D7,$75DB to #$FF (useless op?)

    jsr B06_ACAD ; initialize the RNG based on 71 passes using SRAM data $7000-$7070 and save resulting seed to $7071-$7072

    jsr B06_AB87 ; copy data from SRAM buffer to per-game save data

    jmp B06_AA5E

; pop JSR return address and RTS back to to display and handle main game menu
B06_AABD:
    pla
    pla
    rts

; if $0100 is [space], pop JSR return address and RTS back to to display and handle main game menu
B06_AAC0:
    lda $0100 ; string copy buffer start (often referenced as $00FF, x)

    cmp #$5F ; Tile ID #$5F: [space]

    bne B06_AAC9
    pla
    pla
B06_AAC9:
    rts

; COPY A QUEST handler
B06_AACA:
    jsr B06_AB0C ; display filled slots selection menu, set A/$75DB to selected slot

    jsr B06_AB44 ; copy current save game's data to save data buffer at $7000; CLC if data is valid, SEC if it's unrecoverable

    jsr B06_AB15 ; display empty slots selection menu, set A/$75DB to selected slot

    jsr B06_AA2A ; mark save game slot specified by $75DB as filled

    jsr B06_AA4C ; set $75D7,$75DB to #$FF (useless op?)

    jsr B06_AB87 ; copy data from SRAM buffer to per-game save data

    rts

; ERASE A QUEST handler
B06_AADD:
    jsr B06_AB0C ; display filled slots selection menu, set A/$75DB to selected slot

    jsr B06_AAFC ; display Menu ID #$43: Game menu: delete selected game and Menu ID #$19: General menu: YES/NO

    ldx $75DB ; in game: current game save slot; out of game: various temporary game menu setup values

    lda #$FE
    sta $75D7, x ; save slot 1 status (write-only?)

B06_AAEB:
    jsr B06_AA3B ; mark save game slot specified by $75DB as empty

    ldx #$72 ; fill save game buffer with #$00

    lda #$00
B06_AAF2:
    sta $7000, x ; Cannock runaround quest status (0 = start of game, 0 -> 1 = talked to King Cannock, 1 -> 2 = said YES to seeking Cannock in Spring of Bravery, 2 -> 3 = talked to King Midenhall; adding Cannock sets this to 3; some code checks for 4), SRAM buffer

    dex
    bpl B06_AAF2
    jsr B06_AB87 ; copy data from SRAM buffer to per-game save data

    rts

; display Menu ID #$43: Game menu: delete selected game and Menu ID #$19: General menu: YES/NO
B06_AAFC:
    lda #$43 ; Menu ID #$43: Game menu: delete selected game

    jsr B06_A993 ; open menu specified by A

    lda #$19 ; Menu ID #$19: General menu: YES/NO

    jsr B06_A993 ; open menu specified by A

    tax
; if NO, pop JSR return address and RTS back to to display and handle main game menu
    beq B06_AB0B
    pla
    pla
B06_AB0B:
    rts

; display filled slots selection menu, set A/$75DB to selected slot
B06_AB0C:
    lda #$00 ; get index for filled slots

    jsr B06_AB32 ; set A to offset of appropriate save slot selection menu: A = #$00 gets index for filled slots, A = #$FF gets index for empty slots; also sets $75DB to offset for corresponding current slot lut

    adc #$3C ; base menu ID

    bne B06_AB1C
; display empty slots selection menu, set A/$75DB to selected slot
B06_AB15:
    lda #$FF ; get index for empty slots

    jsr B06_AB32 ; set A to offset of appropriate save slot selection menu: A = #$00 gets index for filled slots, A = #$FF gets index for empty slots; also sets $75DB to offset for corresponding current slot lut

    adc #$35 ; base menu ID

B06_AB1C:
    jsr B06_A993 ; open menu specified by A

    cmp #$FF
    beq B06_AB2F ; pop JSR return address and RTS back to to display and handle main game menu

    clc
    adc $75DB ; in game: current game save slot; out of game: various temporary game menu setup values; offset for current slot lookup table

    tax
    lda B06_ADC2, x ; lookup table for save game slot based on save game slot selection type + menu selection index

    sta $75DB ; in game: current game save slot; out of game: various temporary game menu setup values

    rts

; pop JSR return address and RTS back to to display and handle main game menu
B06_AB2F:
    pla
    pla
    rts

; set A to offset of appropriate save slot selection menu: A = #$00 gets index for filled slots, A = #$FF gets index for empty slots; also sets $75DB to offset for corresponding current slot lut
B06_AB32:
    eor $75DA ; bit field for which save game slots are filled

    and #$07 ; 3 save slots

    tax
    dex
    txa
    sta $99
    asl
    adc $99
    sta $75DB ; in game: current game save slot; out of game: various temporary game menu setup values

    txa
    rts

; copy current save game's data to save data buffer at $7000; CLC if data is valid, SEC if it's unrecoverable
B06_AB44:
    jsr B06_AB90 ; set $99-$9A to pointer to current game's save slot, $9B-$9C to pointer to save data buffer at $7000

    ldx #$00 ; save data copy number

B06_AB49:
    ldy #$72 ; copy #$73 bytes of data from current game's save slot to save data buffer at $7000

B06_AB4B:
    lda ($99), y
    sta ($9B), y
    dey
    bpl B06_AB4B
    tya ; save Y and X on the stack

    pha
    txa
    pha
    jsr B06_ACBB ; initialize the RNG based on 71 passes using SRAM data $7000-$7070

    pla ; restore X and Y from the stack

    tax
    pla
    tay
    lda $7071 ; RNG byte 0, SRAM buffer

    cmp $32 ; RNG byte 0

    bne B06_AB6B ; save data corrupted!

    lda $7072 ; RNG byte 1, SRAM buffer

    cmp $33 ; RNG byte 1

    beq B06_AB7F ; save data valid!

; save data corrupted!
B06_AB6B:
    clc ; add #$159 (i.e. #$73 * 3) to $99-$9A

    lda #$59
    adc $99
    sta $99
    lda #$01
    adc $9A
    sta $9A
    inx ; save data copy number

    cpx #$04 ; there are 4 copies of save data

    bne B06_AB49
    sec ; flag data as unrecoverable :(

    rts

; save data valid!
B06_AB7F:
    txa
    beq B06_AB85 ; if first save data copy was bad, update all copies with good data

    jsr B06_ABAA ; copy save data from save data buffer to current game's save slot, making X copies of the data spaced 3 saves slots away

B06_AB85:
    clc ; flag data as valid

    rts

; copy data from SRAM buffer to per-game save data
B06_AB87:
    ldx #$04 ; make 4 copies of save data

    jsr B06_ABAA ; copy save data from save data buffer to current game's save slot, making X copies of the data spaced 3 saves slots away

    jsr B06_AA02 ; copy more data to second part of per-game save data

    rts

; set $99-$9A to pointer to current game's save slot, $9B-$9C to pointer to save data buffer at $7000
B06_AB90:
    lda $75DB ; in game: current game save slot; out of game: various temporary game menu setup values

    asl
    tay
    lda B06_ADEE, y ; pointers to start of per-game save data
    sta $99
    lda B06_ADEE+1, y
    sta $9A
    lda B06_ADEC ; pointer to start of current game save data buffer
    sta $9B
    lda B06_ADEC+1
    sta $9C
    rts

; copy save data from save data buffer to current game's save slot, making X copies of the data spaced 3 saves slots away
B06_ABAA:
    jsr B06_AB90 ; set $99-$9A to pointer to current game's save slot, $9B-$9C to pointer to save data buffer at $7000

B06_ABAD:
    ldy #$72
B06_ABAF:
    lda ($9B), y
    sta ($99), y
    dey
    bpl B06_ABAF
    clc ; add #$72 * 3 = #$0159 to write address $99-$9A

    lda #$59
    adc $99
    sta $99
    lda #$01
    adc $9A
    sta $9A
    dex
    bne B06_ABAD ; make X copies of the save data

    rts

; copy save data from save data buffer at $7000 to system RAM; update Don Mahone quest status if applicable
; from $0F:$C6F9 via $8006
B06_ABC7:
    lda $7000 ; Cannock runaround quest status (0 = start of game, 0 -> 1 = talked to King Cannock, 1 -> 2 = said YES to seeking Cannock in Spring of Bravery, 2 -> 3 = talked to King Midenhall; adding Cannock sets this to 3; some code checks for 4), SRAM buffer

    sta $CA ; Cannock runaround quest status (0 = start of game, 0 -> 1 = talked to King Cannock, 1 -> 2 = said YES to seeking Cannock in Spring of Bravery, 2 -> 3 = talked to King Midenhall; adding Cannock sets this to 3; some code checks for 4)

    lda $7001 ; Don Mahone quest status (#$00 = not started, #$01 = ingredients delivered, #$03 = game loaded after ingredients delivered), SRAM buffer

    beq B06_ABD3
    lda #$03
B06_ABD3:
    sta $CD ; Don Mahone quest status (#$00 = not started, #$01 = ingredients delivered, #$03 = game loaded after ingredients delivered)
    lda $7002 ; Tuhn Watergate open flag (#$00 = closed, #$01 = open), SRAM buffer
    sta $CE ; Tuhn Watergate open flag (#$00 = closed, #$01 = open)
    lda $7003 ; ship status (#$04 = on ship, #$02 = own ship, #$01 = beat Lianport Gremlins)
    sta $CF ; ship status (#$04 = on ship, #$02 = own ship, #$01 = beat Lianport Gremlins)
    lda $7004 ; Sea Cave shoal status (#$00 = shoals up, others = shoals down), SRAM buffer
    sta $05F8 ; Sea Cave shoal status (#$00 = shoals up, others = shoals down)
    lda $7005 ; Crests found bit field, SRAM buffer
    sta $0112 ; Crests found bit field (#$10 = Life, #$80 = Water, #$04 = Moon, #$02 = Stars, #$01 = Sun)
    lda $7006 ; last save point ID, SRAM buffer
    sta a:$48 ; last save point ID
    lda $7007 ; party gold, low byte, SRAM buffer
    sta $0624 ; party gold, low byte
    lda $7008 ; party gold, high byte, SRAM buffer
    sta $0625 ; party gold, high byte
    ldx #$35
B06_ABFF:
    lda $7015, x ; hero data from $062D, SRAM buffer

    sta $062D, x ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    dex
    bpl B06_ABFF
    ldx #$17
B06_AC0A:
    lda $704B, x ; party inventory, SRAM buffer

    sta $0600, x ; Midenhall inventory item 1 (| #$40 if equipped)

    dex
    bpl B06_AC0A
    ldx #$03
B06_AC15:
    lda $7009, x ; Midenhall name bytes 0-3, SRAM buffer

    sta $0113, x ; Midenhall name bytes 0-3 + terminator

    lda $700D, x ; Cannock name bytes 0-3, SRAM buffer

    sta $0118, x ; Cannock name bytes 0-3 + terminator

    lda $7011, x ; Moonbrooke name bytes 0-3, SRAM buffer

    sta $011D, x ; Moonbrooke name bytes 0-3 + terminator

    dex
    bpl B06_AC15
    ldx #$0B
B06_AC2C:
    lda $7063, x ; party names, bytes 4-7, SRAM buffer

    sta $0186, x ; Midenhall name bytes 4-7

    dex
    bpl B06_AC2C
    lda $706F ; current battle message delay, SRAM buffer

    sta $062C ; current battle message delay

    rts

; copy save data from system RAM to $7000-$706F
B06_AC3C:
    lda $CA ; Cannock runaround quest status (0 = start of game, 0 -> 1 = talked to King Cannock, 1 -> 2 = said YES to seeking Cannock in Spring of Bravery, 2 -> 3 = talked to King Midenhall; adding Cannock sets this to 3; some code checks for 4)
    sta $7000 ; Cannock runaround quest status (0 = start of game, 0 -> 1 = talked to King Cannock, 1 -> 2 = said YES to seeking Cannock in Spring of Bravery, 2 -> 3 = talked to King Midenhall; adding Cannock sets this to 3; some code checks for 4), SRAM buffer
    lda $CD ; Don Mahone quest status (#$00 = not started, #$01 = ingredients delivered, #$03 = game loaded after ingredients delivered)
    sta $7001 ; Don Mahone quest status (#$00 = not started, #$01 = ingredients delivered, #$03 = game loaded after ingredients delivered), SRAM buffer
    lda $CE ; Tuhn Watergate open flag (#$00 = closed, #$01 = open)
    sta $7002 ; Tuhn Watergate open flag (#$00 = closed, #$01 = open), SRAM buffer
    lda $CF ; ship status (#$04 = on ship, #$02 = own ship, #$01 = beat Lianport Gremlins)
    sta $7003 ; ship status (#$04 = on ship, #$02 = own ship, #$01 = beat Lianport Gremlins)
    lda $05F8 ; Sea Cave shoal status (#$00 = shoals up, others = shoals down)
    sta $7004 ; Sea Cave shoal status (#$00 = shoals up, others = shoals down), SRAM buffer
    lda $0112 ; Crests found bit field (#$10 = Life, #$80 = Water, #$04 = Moon, #$02 = Stars, #$01 = Sun)
    sta $7005 ; Crests found bit field, SRAM buffer
    lda a:$48 ; last save point ID
    sta $7006 ; last save point ID, SRAM buffer
    lda $0624 ; party gold, low byte
    sta $7007 ; party gold, low byte, SRAM buffer
    lda $0625 ; party gold, high byte
    sta $7008 ; party gold, high byte, SRAM buffer

    ldx #$35
B06_AC70:
    lda $062D, x ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    sta $7015, x ; hero data from $062D, SRAM buffer

    dex
    bpl B06_AC70
    ldx #$17
B06_AC7B:
    lda $0600, x ; Midenhall inventory item 1 (| #$40 if equipped)

    sta $704B, x ; party inventory, SRAM buffer

    dex
    bpl B06_AC7B
    ldx #$03
B06_AC86:
    lda $0113, x ; Midenhall name bytes 0-3 + terminator

    sta $7009, x ; Midenhall name bytes 0-3, SRAM buffer

    lda $0118, x ; Cannock name bytes 0-3 + terminator

    sta $700D, x ; Cannock name bytes 0-3, SRAM buffer

    lda $011D, x ; Moonbrooke name bytes 0-3 + terminator

    sta $7011, x ; Moonbrooke name bytes 0-3, SRAM buffer

    dex
    bpl B06_AC86
    ldx #$0B
B06_AC9D:
    lda $0186, x ; Midenhall name bytes 4-7

    sta $7063, x ; party names, bytes 4-7, SRAM buffer

    dex
    bpl B06_AC9D
    lda $062C ; current battle message delay

    sta $706F ; current battle message delay, SRAM buffer

    rts

; initialize the RNG based on 71 passes using SRAM data $7000-$7070 and save resulting seed to $7071-$7072
B06_ACAD:
    jsr B06_ACBB ; initialize the RNG based on 71 passes using SRAM data $7000-$7070

    lda $32 ; RNG byte 0

    sta $7071 ; RNG byte 0, SRAM buffer

    lda $33 ; RNG byte 1

    sta $7072 ; RNG byte 1, SRAM buffer

    rts

; initialize the RNG based on 71 passes using SRAM data $7000-$7070
B06_ACBB:
    ldx #$70
    stx $32 ; RNG byte 0

    stx $33 ; RNG byte 1

B06_ACC1:
    lda $7000, x ; Cannock runaround quest status (0 = start of game, 0 -> 1 = talked to King Cannock, 1 -> 2 = said YES to seeking Cannock in Spring of Bravery, 2 -> 3 = talked to King Midenhall; adding Cannock sets this to 3; some code checks for 4), SRAM buffer

    sta $0C
    jsr B0F_C3B6 ; generate a random number and store it in $32-$33 (one pass)

    dex
    bpl B06_ACC1
    rts

B06_ACCD:
    jsr B06_AE86
    ldx #$03
; save Midenhall's name
B06_ACD2:
    lda $0104, x
    sta $7063, x ; party names, bytes 4-7, SRAM buffer

    sta $0186, x ; Midenhall name bytes 4-7

    lda $0100, x ; string copy buffer start (often referenced as $00FF, x)

    sta $7009, x ; Midenhall name bytes 0-3, SRAM buffer

    sta $0113, x ; Midenhall name bytes 0-3 + terminator

    dex
    bpl B06_ACD2
    jsr B06_ACEB ; generate and save Cannock/Moonbrooke's names

    rts

; generate and save Cannock/Moonbrooke's names
B06_ACEB:
    lda #$00
    ldx #$03
    clc
B06_ACF0:
    adc $7009, x ; Midenhall name bytes 0-3, SRAM buffer; first 4 characters of Midenhall's name

    adc $7063, x ; party names, bytes 4-7, SRAM buffer; last 4 characters of Midenhall's name

    dex
    bpl B06_ACF0
    pha
    and #$07 ; Cannock's name is based on bits 0-2 of the sum of Midenhall's name

    asl ; << 3 since names are 8 bytes long

    asl
    asl
    tax
    ldy #$00
; save Cannock's name
B06_AD02:
    lda PrinceNames, x ; Prince of Cannock Names, first 4 bytes; pointer to list of Cannock names, starting at 0th byte
    sta $700D, y ; Cannock name bytes 0-3, SRAM buffer; store the first 4 characters in SRAM
    sta $0118, y ; Cannock name bytes 0-3 + terminator; store the first 4 characters in RAM

    lda PrinceNames+4, x ; Prince of Cannock Names, last 4 bytes; pointer to list of Cannock names, starting at 4th byte
    sta $7067, y ; store the last 4 characters in SRAM
    sta $018A, y ; Cannock name bytes 4-7; store the last 4 characters in RAM

    inx
    iny
    cpy #$04
    bne B06_AD02
    pla
    and #$38 ; Moonbrooke's name is based on bits 3-6 of the sum of Midenhall's name

    tax
    ldy #$00
; save Moonbrooke's name
B06_AD20:
    lda PrincessNames, x ; Princess of Moonbrooke Names, first 4 bytes; pointer to list of Moonbrooke names, starting at 0th byte
    sta $7011, y ; Moonbrooke name bytes 0-3, SRAM buffer; store the first 4 characters in SRAM
    sta $011D, y ; Moonbrooke name bytes 0-3 + terminator; store the first 4 characters in RAM

    lda PrincessNames+4, x ; Princess of Moonbrooke Names, last 4 bytes; pointer to list of Moonbrooke names, starting at 0th byte
    sta $706B, y ; store the last 4 characters in SRAM
    sta $018E, y ; Moonbrooke name bytes 4-7; store the last 4 characters in RAM

    inx
    iny
    cpy #$04
    bne B06_AD20
    rts

; Prince of Cannock Names
PrinceNames:
.byte "Bran    "
.byte "Glynn   "
.byte "Talint  "
.byte "Numor   "
.byte "Lars    "
.byte "Orfeo   "
.byte "Artho   "
.byte "Esgar   "

; Princess of Moonbrooke Names
PrincessNames:
.byte "Varia   "
.byte "Elani   "
.byte "Ollisa  "
.byte "Roz     "
.byte "Kailin  "
.byte "Peta    "
.byte "Illyth  "
.byte "Gwen    "

B06_ADB9:
.byte $44,$51,$32,$55,$53,$41

; battle message delays (frames between prints; higher = slower)
B06_ADBF:
.byte 40	 ; 40 frames
.byte 70	 ; 70 frames
.byte 255	 ; 255 frames

; lookup table for save game slot based on save game slot selection type + menu selection index
; only slot 0
B06_ADC2:
.byte $00	 ; slot 0
.byte $00	 ; (impossible)
.byte $00	 ; (impossible)
; only slot 1
.byte $01	 ; slot 1
.byte $00	 ; (impossible)
.byte $00	 ; (impossible)
; slots 0 and 1
.byte $00	 ; slot 0
.byte $01	 ; slot 1
.byte $00	 ; (impossible)
; only slot 2
.byte $02	 ; slot 2
.byte $00	 ; (impossible)
.byte $00	 ; (impossible)
; slots 0 and 2
.byte $00	 ; slot 0
.byte $02	 ; slot 2
.byte $00	 ; (impossible)
; slots 1 and 2
.byte $01	 ; slot 1
.byte $02	 ; slot 2
.byte $00	 ; (impossible)
; all 3 slots
.byte $00	 ; slot 0
.byte $01	 ; slot 1
.byte $02	 ; slot 2

; index into jump table at B06_ADE2
B06_ADD7:
.byte $00	 ; CONTINUE A QUEST
.byte $01	 ; CHANGE MESSAGE SPEED
.byte $04	 ; ERASE A QUEST
.byte $00	 ; (impossible)
.byte $00	 ; (impossible)
.byte $00	 ; CONTINUE A QUEST
.byte $01	 ; CHANGE MESSAGE SPEED
.byte $02	 ; BEGIN A NEW QUEST
.byte $03	 ; COPY A QUEST
.byte $04	 ; ERASE A QUEST
.byte $02	 ; BEGIN A NEW QUEST

; jump table for main game menu handlers
B06_ADE2:
.addr B06_AA55      ; $06:B06_AA55; CONTINUE A QUEST handler
.addr B06_AA64      ; $06:B06_AA64; CHANGE MESSAGE SPEED handler
.addr B06_AA93      ; $06:B06_AA93; BEGIN A NEW QUEST handler
.addr B06_AACA      ; $06:B06_AACA; COPY A QUEST handler
.addr B06_AADD      ; $06:B06_AADD; ERASE A QUEST handler

; pointer to start of current game save data buffer
B06_ADEC:
.addr $7000      ; $7000; Cannock runaround quest status (0 = start of game, 0 -> 1 = talked to King Cannock, 1 -> 2 = said YES to seeking Cannock in Spring of Bravery, 2 -> 3 = talked to King Midenhall; adding Cannock sets this to 3; some code checks for 4), SRAM buffer

; pointers to start of per-game save data
B06_ADEE:
.addr $7073      ; $7073; start of save game 1 backup #1
.addr $70E6      ; $70E6; start of save game 1 backup #2
.addr $7159      ; $7159; start of save game 1 backup #3

B06_ADF4:
.addr $7564      ; $7564
B06_ADF6:
.addr $75DC      ; $75DC
.addr $75E6      ; $75E6
.addr $75F0      ; $75F0

; given a selected list index in A, an item type in X, and a hero ID in $4A, set A to the A'th item of type X in hero $4A's inventory
; from $0F:$F4E6, $0F:$F5E4, $0F:$F614 via $8010
B06_ADFC:
    cmp #$FE
    bcs B06_AE2F ; A >= #$FE => just RTS

    stx $609D ; menu function parameter

    sta $10 ; selected item index

    jsr B0F_F1B0 ; given a hero ID in $4A, set A and X to hero ID * 8, a.k.a. offset for start of hero's inventory

    ldy #$08
    sty $60AA ; menu format (#$80 = has cursor, #$40 = is linked, #$20 = is single spaced, #$02 = only display equipped items, #$01 = display [left border, equipped] if equipped)

B06_AE0D:
    lda $0600, x ; Midenhall inventory item 1 (| #$40 if equipped)

    jsr B0F_F1D6 ; determine item type (#$00 = weapon, #$01 = armour, #$02 = shield, #$03 = helmet, #$04 = menu function wants all items or item is non-equipment, #$05 = menu format wants equipped items only and item not equipped)

    cmp $609D ; menu function parameter

    bne B06_AE1C ; if it's not the right type of item, it doesn't count

    dec $10 ; otherwise it does!

    bmi B06_AE24 ; branch if we've found the right item

B06_AE1C:
    inx ; increment inventory index

    dey ; decrement inventory counter

    bne B06_AE0D ; if more inventory slots to check, check them

    lda #$00 ; if item not found, set A = X = #$00

    tax
    rts

B06_AE24:
    lda $0600, x ; Midenhall inventory item 1 (| #$40 if equipped)

    pha
    txa ; X = X mod 8

    and #$07
    tax
    pla
    and #$3F ; strip off the equipped bit

B06_AE2F:
    rts

; given hero ID - 1 in $4A and field spell menu selection index in A, return spell ID in A
; from $0F:$F5FA via $8012
B06_AE30:
    asl $4A ; convert hero ID - 1 to spell list start index; 8 spells per hero

    asl $4A
    asl $4A
; add list start offset to spell menu selection index
    adc $4A
    tax
    lda FieldSpells, x ; Cannock field spell list

    rts

; given hero ID - 1 in $4A and battle spell menu selection index in A, return spell ID in A
; from $0F:$F4AC via $8014
B06_AE3D:
    asl $4A ; convert hero ID - 1 to spell list start index; 8 spells per hero

    asl $4A
    asl $4A
; add list start offset to spell menu selection index
    adc $4A
    tax
    lda BattleSpells, x ; Cannock battle spell list

    rts

; given spell ID in A, set A to spell name index
B06_AE4A:
    tax
    lda SpellIDS-1, x
    rts


; spell ID -> spell name index (built in offset from $AE4F)
SpellIDS:
.byte $00	 ; Spell ID #$00: (no spell)
.byte $10	 ; Spell ID #$01: Firebal
.byte $04	 ; Spell ID #$02: Sleep
.byte $06	 ; Spell ID #$03: Firebane
.byte $12	 ; Spell ID #$04: Defeat
.byte $02	 ; Spell ID #$05: Infernos
.byte $14	 ; Spell ID #$06: Stopspell
.byte $13	 ; Spell ID #$07: Surround
.byte $08	 ; Spell ID #$08: Defence
.byte $05	 ; Spell ID #$09: Heal
.byte $18	 ; Spell ID #$0A: Increase
.byte $07	 ; Spell ID #$0B: Healmore
.byte $1B	 ; Spell ID #$0C: Sacrifice
.byte $16	 ; Spell ID #$0D: Healall
.byte $17	 ; Spell ID #$0E: Explodet
.byte $1A	 ; Spell ID #$0F: Chance
.byte $08	 ; Spell ID #$10: Antidote
.byte $1C	 ; Spell ID #$11: Heal (not used by heroes)
.byte $19	 ; Spell ID #$12: Outside
.byte $0A	 ; Spell ID #$13: Repel
.byte $1E	 ; Spell ID #$14: Return
.byte $0D	 ; Spell ID #$15: Open
.byte $0E

; Cannock field spell list
FieldSpells:
.byte $09	 ; Spell ID #$09: Heal
.byte $10	 ; Spell ID #$10: Antidote
.byte $14	 ; Spell ID #$14: Return
.byte $12	 ; Spell ID #$12: Outside
.byte $0B	 ; Spell ID #$0B: Healmore
.byte $16	 ; Spell ID #$16: Stepguard
.byte $17	 ; Spell ID #$17: Revive
.byte $00	 ; Spell ID #$00: (no spell)
; Moonbrooke field spell list
.byte $0B	 ; Spell ID #$0B: Healmore
.byte $13	 ; Spell ID #$13: Repel
.byte $10	 ; Spell ID #$10: Antidote
.byte $0D	 ; Spell ID #$0D: Healall
.byte $12	 ; Spell ID #$12: Outside
.byte $16	 ; Spell ID #$16: Stepguard
.byte $15	 ; Spell ID #$15: Open
.byte $00	 ; Spell ID #$00: (no spell)

; Cannock battle spell list
BattleSpells:
.byte $01	 ; Spell ID #$01: Firebal
.byte $09	 ; Spell ID #$09: Heal
.byte $06	 ; Spell ID #$06: Stopspell
.byte $0B	 ; Spell ID #$0B: Healmore
.byte $03	 ; Spell ID #$03: Firebane
.byte $0A	 ; Spell ID #$0A: Increase
.byte $04	 ; Spell ID #$04: Defeat
.byte $0C	 ; Spell ID #$0C: Sacrifice
; Moonbrooke battle spell list
.byte $02	 ; Spell ID #$02: Sleep
.byte $0B	 ; Spell ID #$0B: Healmore
.byte $05	 ; Spell ID #$05: Infernos
.byte $08	 ; Spell ID #$08: Defence
.byte $07	 ; Spell ID #$07: Surround
.byte $0D	 ; Spell ID #$0D: Healall
.byte $0E	 ; Spell ID #$0E: Explodet
.byte $0F	 ; Spell ID #$0F: Chance


B06_AE86:
    jsr B06_AE9E
    jsr B06_AF56
    jsr B06_AF7F
B06_AE8F:
    jsr B06_AECC
    jsr B06_AF30
    bcs B06_AE9D
    jsr B06_AF8E
    jmp B06_AE8F

B06_AE9D:
    rts

B06_AE9E:
    lda #$FF
    sta $8E ; flag for in battle or not (#$FF)?

    lda #$00
    sta $60C2
    sta $60C3
    lda #$47 ; Menu ID #$47: Game menu: new game name entry display
    jsr B0F_EB89 ; open menu specified by A
    lda #$44 ; Menu ID #$44: Game menu: new game name input area
    jsr B0F_EB89 ; open menu specified by A
    jsr B0F_C22C
    lda #$12
    sta $60A5 ; menu cursor second column X-offset (from left edge of menu)

    lda #$21
    sta $60A9 ; menu cursor initial position (from ROM; X-pos = low nybble, Y-pos = high nybble)

    lda #$60
    ldx #$0C
B06_AEC5:
    sta $0100, x ; string copy buffer start (often referenced as $00FF, x)

    dex
    bpl B06_AEC5
    rts

B06_AECC:
    cmp #$FF
    beq B06_AF05
    cmp #$1A
    bcc B06_AEEF
    cmp #$21
    bcc B06_AEF9
    cmp #$3B
    bcc B06_AEF4
    cmp #$3D
    bcc B06_AEFF
    cmp #$3D
    beq B06_AF05
    jsr B06_AF46 ; CLC if $0100-$0103 are all #$60, SEC otherwise

    bcc B06_AEEE
    lda #$08
    sta $60C2
B06_AEEE:
    rts

B06_AEEF:
    clc
    adc #$24
    bne B06_AF14
B06_AEF4:
    sec
    sbc #$17
    bne B06_AF14
B06_AEF9:
    tax
    ;confirm???
    lda B06_AF76-$1a, x
    bne B06_AF14
B06_AEFF:
    tax ; A is either #$3B or #$3C

    lda B06_AF7D-$3b, x ; $AF7D or $AF7E

    bne B06_AF14
B06_AF05:
    lda $60C2
    beq B06_AF13
    jsr B06_AF5A
    dec $60C2
    jsr B06_AF56
B06_AF13:
    rts

B06_AF14:
    pha
    jsr B06_AF5A
    pla
    ldx $60C2
    sta $0100, x ; string copy buffer start (often referenced as $00FF, x)

    jsr B06_AF60
    inc $60C2
    lda $60C2
    cmp #$08
    bcs B06_AF2F
    jsr B06_AF56
B06_AF2F:
    rts

B06_AF30:
    lda $60C2
    cmp #$08
    bcc B06_AF45
    jsr B06_AF46 ; CLC if $0100-$0103 are all #$60, SEC otherwise

    bcs B06_AF45 ; branch if we have something != #$60

    lda #$07
    sta $60C2
    jsr B06_AF56
    clc
B06_AF45:
    rts

; CLC if $0100-$0103 are all #$60, SEC otherwise
B06_AF46:
    ldx #$03
B06_AF48:
    lda $0100, x ; string copy buffer start (often referenced as $00FF, x)

    cmp #$60
    bne B06_AF54
    dex
    bpl B06_AF48
    clc ; entire string is #$60

    rts

B06_AF54:
    sec ; not entire string is #$60

    rts

B06_AF56:
    lda #$77
    bne B06_AF5C
B06_AF5A:
    lda #$5F
B06_AF5C:
    ldx #$07
    bne B06_AF62
B06_AF60:
    ldx #$06
B06_AF62:
    stx $608C
    sta $09
    lda $60C2
    clc
    adc #$0C
    sta $608B
    jsr B06_A809
    jmp B0F_C1FA ; wait for $02 to not be #$C0, write PPU address in $07-$08 and data in $09 to PPU write buffer at $0300,$02, $01 += 1, $02 += 3, and set $0183 to #$00

B06_AF76:
.byte $67,$69,$6B,$70,$75,$63,$60
B06_AF7D:
.byte $6F,$6E

; from $0F:$F0BF via $8018
B06_AF7F:
    lda $60B4 ; menu phase (1 = first, 0 = second)

    bne B06_AF91
    jsr B06_AFC6
    lda #$80
    sta $60C5
    sta $2F ; joypad 1 data

B06_AF8E:
    jsr B06_AF92
B06_AF91:
    rts

B06_AF92:
    jsr B06_AF9B
    jsr B06_B0AC
    jmp B06_AF92

B06_AF9B:
    jsr B0F_C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    jsr B06_B085
    lda $2F ; joypad 1 data

    beq B06_AFAB
    lda $03 ; game clock?

    and #$0F
    bne B06_AFAE
B06_AFAB:
    sta $60C5
B06_AFAE:
    jsr B0F_C476 ; read joypad 1 data into $2F

    lda $60C5
    bne B06_AF9B
    lda $60C5
    and $2F ; joypad 1 data

    sta $60C5
    eor $2F ; joypad 1 data

    sta $608D
    beq B06_AF9B
    rts

B06_AFC6:
    lda #$00
    sta $82
    sta $83
    sta $81
    sta $60B0
    sta $60B1
    sta $60C5
    lda $60A5 ; menu cursor second column X-offset (from left edge of menu)

    lsr
    lsr
    lsr
    lsr
    tax
    lda B06_B2C8, x
    sta $60C4
    lda $59 ; menu ID

    cmp #$13 ; Menu ID #$13: Main menu: equip weapon

    beq B06_B043
    cmp #$2D ; Menu ID #$2D: Main menu: equip armour

    beq B06_B043
    cmp #$2E ; Menu ID #$2E: Main menu: equip shield

    beq B06_B043
    cmp #$2F ; Menu ID #$2F: Main menu: equip helmet

    beq B06_B043
    cmp #$45 ; Menu ID #$45: Game menu: select message speed

    beq B06_B002
    cmp #$07 ; Menu ID #$07: Battle menu: spell list

    beq B06_B01B
    jmp B06_B060

B06_B002:
    ldx #$00
    lda $062C ; current battle message delay

    cmp #$32
    bcc B06_B011
    inx
    cmp #$64
    bcc B06_B011
    inx
B06_B011:
    stx $83
    txa
    asl
    sta $60B1
    jmp B06_B060

B06_B01B:
    ldx #$00
B06_B01D:
    lda $60BA, x
    bne B06_B029
    inx
    cpx #$08
    bne B06_B01D
    ldx #$00
B06_B029:
    txa
    and #$01
    sta $82
    beq B06_B038
    lda $60A5 ; menu cursor second column X-offset (from left edge of menu)

    and #$0F
    sta $60B0
B06_B038:
    txa
    lsr
    sta $83
    asl
    sta $60B1
    jmp B06_B060

B06_B043:
    lda $60B9
    cmp #$FF
    beq B06_B053
    sta $83
    asl
    sta $60B1
    jmp B06_B060

B06_B053:
    sec
    lda $60A3 ; menu window height (ROM value * 2)

    sbc #$03
    lsr
    sta $83
    asl
    sta $60B1
B06_B060:
    lda $60A9 ; menu cursor initial position (from ROM; X-pos = low nybble, Y-pos = high nybble)

    pha
    and #$0F
    sta $60B2
    clc
    adc $60B0
    sta $60B0
    pla
    and #$F0
    lsr
    lsr
    lsr
    lsr
    sta $60B3
    adc $60B1
    sta $60B1
    lda #$05
    sta $03 ; game clock?

    rts

B06_B085:
    ldx #$5F
    lda $03 ; game clock?

    and #$1F
    cmp #$10
    bcs B06_B091
B06_B08F:
    ldx #$72
B06_B091:
    stx $09
    lda $4D
    clc
    adc $60B0
    sta $608B
    lda $4E
    clc
    adc $60B1
    sta $608C
    jsr B0F_FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000, x) in selected bank, swap back in original bank
    .byte $C1
    jmp B0F_C1FA ; wait for $02 to not be #$C0, write PPU address in $07-$08 and data in $09 to PPU write buffer at $0300,$02, $01 += 1, $02 += 3, and set $0183 to #$00


B06_B0AC:
    lda $608D
    lsr
    bcs B06_B0C9
    lsr
    bcs B06_B0E6
    lsr
    lsr
    lsr
    bcs B06_B0F3
    lsr
    bcs B06_B120
    lsr
    bcs B06_B0C6
    lsr
    bcc B06_B10A
    jmp B06_B1BE

B06_B0C6:
    jmp B06_B174

B06_B0C9:
    lda #$01
    sta $60C5
    jsr B06_B214
    lda #$85 ; Music ID #$85: single beep SFX

    jsr B0F_C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    lda $82
    sta $12
    lda $83
    sta $13
    jsr B06_B294
    pla
    pla
    lda $81
    rts

B06_B0E6:
    lda #$02
    sta $60C5
    jsr B06_B214
    pla
    pla
    lda #$FF
    rts

B06_B0F3:
    lda #$10
    sta $60C5
    bit $60AA ; menu format (#$80 = has cursor, #$40 = is linked, #$20 = is single spaced, #$02 = only display equipped items, #$01 = display [left border, equipped] if equipped)

    bvs B06_B10B
B06_B0FD:
    lda $83
    beq B06_B10A
    jsr B06_B20F
    jsr B06_B2BC
    jsr B06_B214
B06_B10A:
    rts

B06_B10B:
    lda $60B1
    beq B06_B10A
    lda $83
    bne B06_B0FD
    jsr B06_B20F
    lda #$00
    sta $60B1
    jsr B06_B214
    rts

B06_B120:
    lda #$20
    sta $60C5
    lda $59 ; menu ID

    cmp #$45 ; Menu ID #$45: Game menu: select message speed

    bne B06_B131
    lda $83
    cmp #$02
    beq B06_B173
B06_B131:
    sec
    lda $60A3 ; menu window height (ROM value * 2)

    sbc #$03
    lsr
    cmp $83
    beq B06_B173
    jsr B06_B20F
    lda $59 ; menu ID

    cmp #$44 ; Menu ID #$44: Game menu: new game name input area

    beq B06_B158
    cmp #$07 ; Menu ID #$07: Battle menu: spell list

    beq B06_B151
    cmp #$08 ; Menu ID #$08: Battle menu: item list window 1

    beq B06_B151
    cmp #$22 ; Menu ID #$22: Battle menu: item list window 2

    bne B06_B15B
B06_B151:
    jsr B06_B243
    bcc B06_B173
    bcs B06_B15B
B06_B158:
    jsr B06_B21E
B06_B15B:
    lda $60B1
    bne B06_B168
    lda $60B3
    sta $60B1
    bne B06_B170
B06_B168:
    clc
    adc #$02
    sta $60B1
    inc $83
B06_B170:
    jsr B06_B214
B06_B173:
    rts

B06_B174:
    lda #$40
    sta $60C5
    lda $82
    beq B06_B1BD
    lda $59 ; menu ID

    cmp #$44 ; Menu ID #$44: Game menu: new game name input area

    beq B06_B18E
    cmp #$07 ; Menu ID #$07: Battle menu: spell list

    bne B06_B1A5
    jsr B06_B252
    bcc B06_B1BD
    bcs B06_B1A5
B06_B18E:
    lda $83
    cmp #$05
    bne B06_B1A5
    lda $82
    cmp #$09
    bne B06_B1A5
    lda #$06
    sta $82
    jsr B06_B20F
    lda #$0D
    bne B06_B1B7
B06_B1A5:
    jsr B06_B20F
    dec $82
    lda $60A5 ; menu cursor second column X-offset (from left edge of menu)

    and #$0F
    sta $10
    lda $60B0
    sec
    sbc $10
B06_B1B7:
    sta $60B0
    jsr B06_B214
B06_B1BD:
    rts

B06_B1BE:
    lda #$80
    sta $60C5
    lda $60A5 ; menu cursor second column X-offset (from left edge of menu)

    beq B06_B20E
    lda $59 ; menu ID

    cmp #$44 ; Menu ID #$44: Game menu: new game name input area

    beq B06_B1D9
    cmp #$07 ; Menu ID #$07: Battle menu: spell list

    bne B06_B1F2
    jsr B06_B25A
    bcc B06_B20E
    bcs B06_B1F2
B06_B1D9:
    lda $83
    cmp #$05
    bne B06_B1F2
    lda $82
    cmp #$06
    bcc B06_B1F2
    bne B06_B20E
    jsr B06_B20F
    lda #$09
    sta $82
    lda #$13
    bne B06_B208
B06_B1F2:
    ldx $60C4
    dex
    cpx $82
    beq B06_B20E
    jsr B06_B20F
    inc $82
    lda $60A5 ; menu cursor second column X-offset (from left edge of menu)

    and #$0F
    clc
    adc $60B0
B06_B208:
    sta $60B0
    jsr B06_B214
B06_B20E:
    rts

B06_B20F:
    ldx #$5F
    jmp B06_B091

B06_B214:
    lda #$05
    sta $03 ; game clock?

    jsr B06_B08F
    jmp B0F_C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

B06_B21E:
    lda $83
    cmp #$04
    bne B06_B242
    lda $82
    cmp #$07
    beq B06_B239
    cmp #$08
    bcc B06_B242
    lda #$09
    sta $82
    lda #$13
    sta $60B0
    bne B06_B242
B06_B239:
    lda #$06
    sta $82
    lda #$0D
    sta $60B0
B06_B242:
    rts

B06_B243:
    jsr B06_B2B3 ; copy $82-$83 to $12-$13

    inc $13
    lda $60B1
    beq B06_B250
    jmp B06_B287

B06_B250:
    sec
    rts

B06_B252:
    jsr B06_B2B3 ; copy $82-$83 to $12-$13

    dec $12
    jmp B06_B25F

B06_B25A:
    jsr B06_B2B3 ; copy $82-$83 to $12-$13

    inc $12
B06_B25F:
    jsr B06_B287
    bcs B06_B286
    dec $13
    bmi B06_B286
    jsr B06_B287
    bcs B06_B27F
    dec $13
    bmi B06_B286
    jsr B06_B287
    bcc B06_B286
    jsr B06_B20F
    jsr B06_B2BC
    jmp B06_B282

B06_B27F:
    jsr B06_B20F
B06_B282:
    jsr B06_B2BC
    sec
B06_B286:
    rts

B06_B287:
    jsr B06_B294
    tax
    lda $60BA, x
    beq B06_B292
    sec
    rts

B06_B292:
    clc
    rts

B06_B294:
    lda $13
    ldx $60A5 ; menu cursor second column X-offset (from left edge of menu)

    beq B06_B2B0
    and #$0F
    sta $10
    lda #$00
    sta $11
    ldx #$10
    lda $60C4
    jsr B0F_F0F4 ; 16-bit multiplication: set 16-bit ($00, x-$01, x) = ($00, x-$01, x) * A

    lda $10
    clc
    adc $12
B06_B2B0:
    sta $81
    rts

; copy $82-$83 to $12-$13
B06_B2B3:
    lda $82
    sta $12
    lda $83
    sta $13
    rts

B06_B2BC:
    lda $60B1
    sec
    sbc #$02
    sta $60B1
    dec $83
    rts

B06_B2C8:
.byte $02
.byte $0B

; Item list part 1, line 1
ItemNames1_1:
.byte "Bamboo",$FF
.byte "Magic",$FF
.byte "Wizard's",$FF
.byte "Staff of",$FF
.byte "Club",$FF
.byte "Copper",$FF
.byte "Chain",$FF
.byte "Iron",$FF
.byte "Falcon",$FF
.byte "Broad",$FF
.byte "Giant",$FF
.byte "Sword of",$FF
.byte "Dragon",$FF
.byte "Light",$FF
.byte "Sword of",$FF
.byte "Thunder",$FF
.byte "Clothes",$FF
.byte "Clothes",$FF
.byte "Water Flying",$FF
.byte "Mink",$FF
.byte "Leather",$FF
.byte "Chain",$FF
.byte "Gremlin's",$FF
.byte "Magic",$FF
.byte "Full Plate",$FF
.byte "Armor of",$FF
.byte "Armor of",$FF
.byte "Leather",$FF
.byte "Shield of",$FF
.byte "Steel",$FF
.byte "Evil",$FF
.byte "Shield of",$FF
; Item list part 2, line 1
ItemNames2_1:
.byte "Mysterious",$FF
.byte "Iron",$FF
.byte "Helmet of",$FF
.byte "Token of",$FF
.byte "Tresures",$FF
.byte "Moon",$FF
.byte "Charm of",$FF
.byte "Eye of",$FF
.byte "Leaf of The",$FF
.byte "Echoing",$FF
.byte "Mirror of",$FF
.byte "Dew's",$FF
.byte "Magic",$FF
.byte "Cloak of",$FF
.byte "Gremlin's",$FF
.byte "Dragon's",$FF
.byte "Dragon's",$FF
.byte "Golden",$FF
.byte "Lottery",$FF
.byte "Fairy",$FF
.byte "Wing of",$FF
.byte $FF
.byte "Golden",$FF
.byte "Silver",$FF
.byte "Jailor's",$FF
.byte "Watergate",$FF
.byte "Antidote",$FF
.byte "Medical",$FF
.byte "Wizard's",$FF
.byte "Perilous",$FF
.byte $FF
.byte $FF
; Item list part 1, line 2
ItemNames1_2:
.byte "Stick",$FF
.byte "Knife",$FF
.byte "Wand",$FF
.byte "Thunder",$FF
.byte $FF
.byte "Sword",$FF
.byte "Sickle",$FF
.byte "Spear",$FF
.byte "Sword",$FF
.byte "Sword",$FF
.byte "Hammer",$FF
.byte "Destruction",$FF
.byte "Killer",$FF
.byte "Sword",$FF
.byte "Erdrick",$FF
.byte "Sword",$FF
.byte $FF
.byte "Hiding",$FF
.byte "Cloth",$FF
.byte "Coat",$FF
.byte "Armor",$FF
.byte "Mail",$FF
.byte "Armor",$FF
.byte "Armor",$FF
.byte "Armor",$FF
.byte "Gaia",$FF
.byte "Erdrick",$FF
.byte "Shield",$FF
.byte "Strength",$FF
.byte "Shield",$FF
.byte "Shield",$FF
.byte "Erdrick",$FF
; Item list part 2, line 2
ItemNames2_2:
.byte "Hat",$FF
.byte "Helmet",$FF
.byte "Erdrick",$FF
.byte "Erdrick",$FF
.byte $FF
.byte "Fragment",$FF
.byte "Rubiss",$FF
.byte "Malroth",$FF
.byte "World Tree",$FF
.byte "Flute",$FF
.byte "Ra",$FF
.byte "Yarn",$FF
.byte "Loom",$FF
.byte "Wind",$FF
.byte "Tail",$FF
.byte "Bane",$FF
.byte "Potion",$FF
.byte "Card",$FF
.byte "Ticket",$FF
.byte "Water",$FF
.byte "the Wyvern",$FF
.byte $FF
.byte "Key",$FF
.byte "Key",$FF
.byte "Key",$FF
.byte "Key",$FF
.byte "Herb",$FF
.byte "Herb",$FF
.byte "Ring",$FF
.byte $FF
.byte $FF
.byte $FF

; Spell name list
SpellNames:
.byte "Firebal",$FF
.byte "Heal",$FF
.byte "Stopspell",$FF
.byte "Healmore",$FF
.byte "Firebane",$FF
.byte "Increase",$FF
.byte "Defeat",$FF
.byte "Sacrifice",$FF
.byte "Heal",$FF
.byte "Antidote",$FF
.byte "Return",$FF
.byte "Outside",$FF
.byte "Healmore",$FF
.byte "Stepguard",$FF
.byte "Revive",$FF
.byte $FF
.byte "Sleep",$FF
.byte "Healmore",$FF
.byte "Infernos",$FF
.byte "Defence",$FF
.byte "Surround",$FF
.byte "Healall",$FF
.byte "Explodet",$FF
.byte "Chance",$FF
.byte "Healmore",$FF
.byte "Repel",$FF
.byte "Antidote",$FF
.byte "Healall",$FF
.byte "Outside",$FF
.byte "Stepguard",$FF
.byte "Open",$FF
.byte $FF

; Monster list part 1, line 1
MonsterNames1_1:
.byte "Slime",$FF
.byte "Big",$FF
.byte "Iron",$FF
.byte "Drakee",$FF
.byte "Wild",$FF
.byte "Healer",$FF
.byte "Ghost",$FF
.byte "Babble",$FF
.byte "Army",$FF
.byte "Magician",$FF
.byte "Big",$FF
.byte "Big",$FF
.byte "Magic",$FF
.byte "Magidrakee",$FF
.byte "Centipod",$FF
.byte "Man O'",$FF
.byte "Lizard",$FF
.byte "Zombie",$FF
.byte "Smoke",$FF
.byte "Ghost",$FF
.byte "Baboon",$FF
.byte "Carnivog",$FF
.byte "Megapede",$FF
.byte "Sea",$FF
.byte "Medusa",$FF
.byte "Enchanter",$FF
.byte "Mud",$FF
.byte "Magic",$FF
.byte "Demighost",$FF
.byte "Gremlin",$FF
.byte "Poison",$FF
.byte "Mummy",$FF
.byte "Gorgon",$FF
.byte "Saber",$FF
.byte "Dragon",$FF
.byte "Titan",$FF
.byte "Undead",$FF
.byte "Basilisk",$FF
.byte "Goopi",$FF
.byte "Orc",$FF
.byte "Puppet",$FF
.byte "Mummy",$FF
.byte "Evil",$FF
.byte "Gas",$FF
.byte "Hork",$FF
.byte "Hawk",$FF
.byte "Sorcerer",$FF
.byte "Metal",$FF
.byte "Hunter",$FF
.byte "Evil",$FF
; Monster list part 2, line 1
MonsterNames2_1:
.byte "Hibabango",$FF
.byte "Graboopi",$FF
.byte "Gold",$FF
.byte "Evil",$FF
.byte "Ghoul",$FF
.byte "Vampirus",$FF
.byte "Mega",$FF
.byte "Saber",$FF
.byte "Metal",$FF
.byte "Ozwarg",$FF
.byte "Dark",$FF
.byte "Gargoyle",$FF
.byte "Orc",$FF
.byte "Magic",$FF
.byte "Berserker",$FF
.byte "Metal",$FF
.byte "Hargon's",$FF
.byte "Cyclops",$FF
.byte "Attackbot",$FF
.byte "Green",$FF
.byte "Mace",$FF
.byte "Flame",$FF
.byte "Silver",$FF
.byte "Blizzard",$FF
.byte "Giant",$FF
.byte "Gold",$FF
.byte "Bullwong",$FF
.byte "Atlas",$FF
.byte "Bazuzu",$FF
.byte "Zarlox",$FF
.byte "Hargon",$FF
.byte "Malroth",$FF
.byte "Enemies",$FF
; Monster list part 1, line 2
MonsterNames1_2:
.byte $FF
.byte "Slug",$FF
.byte "Ant",$FF
.byte $FF
.byte "Mouse",$FF
.byte $FF
.byte "Mouse",$FF
.byte $FF
.byte "Ant",$FF
.byte $FF
.byte "Rat",$FF
.byte "Cobra",$FF
.byte "Ant",$FF
.byte $FF
.byte $FF
.byte "War",$FF
.byte "Fly",$FF
.byte $FF
.byte $FF
.byte "Rat",$FF
.byte $FF
.byte $FF
.byte $FF
.byte "Slug",$FF
.byte "Ball",$FF
.byte $FF
.byte "Man",$FF
.byte "Baboon",$FF
.byte $FF
.byte $FF
.byte "Lily",$FF
.byte "Man",$FF
.byte $FF
.byte "Tiger",$FF
.byte "Fly",$FF
.byte "Tree",$FF
.byte $FF
.byte $FF
.byte $FF
.byte $FF
.byte "Man",$FF
.byte $FF
.byte "Tree",$FF
.byte $FF
.byte $FF
.byte "Man",$FF
.byte $FF
.byte "Slime",$FF
.byte $FF
.byte "Eye",$FF
; Monster list part 2, line 2
MonsterNames2_2:
.byte $FF
.byte $FF
.byte "Orc",$FF
.byte "Clown",$FF
.byte $FF
.byte $FF
.byte "Knight",$FF
.byte "Lion",$FF
.byte "Hunter",$FF
.byte $FF
.byte "Eye",$FF
.byte $FF
.byte "King",$FF
.byte "Vampirus",$FF
.byte $FF
.byte "Babble",$FF
.byte "Knight",$FF
.byte $FF
.byte $FF
.byte "Dragon",$FF
.byte "Master",$FF
.byte $FF
.byte "Batboon",$FF
.byte $FF
.byte $FF
.byte "Batboon",$FF
.byte $FF
.byte $FF
.byte $FF
.byte $FF
.byte $FF
.byte $FF
.byte $FF

; tiles for redrawing the part of the main COMMAND menu obscured by the EQUIP sub-menu when the EQUIP sub-menu is closed; (only?) read during battle where there is no main COMMAND menu
; completely useless?
CommandTileRedraw:
.byte $24,$31,$5F,$5F
.byte $27,$77,$5F,$5F
.byte $77,$77,$5F,$5F
.byte $77,$7C,$5F,$5F
.byte $5F,$5F,$5F,$5F
.byte $36,$33,$5F,$5F
.byte $28,$2F,$5F,$5F
.byte $2F,$7B,$5F,$7B
.byte $5F,$5F,$5F,$5F
.byte $2C,$37,$5F,$5F
.byte $28,$30,$5F,$5F
.byte $5F,$7B,$5F,$7B
.byte $5F,$5F,$7D,$7D
.byte $28,$34,$7D,$7D
.byte $38,$2C,$7D,$7D
.byte $33,$7B,$7D,$7E
CommandTileRedraw2:
.byte $77,$77,$77,$77
.byte $77,$77,$77,$7C
.byte $79,$77,$77,$77
.byte $77,$77,$7C,$7B
.byte $76,$5F,$5F,$5F
.byte $5F,$5F,$7B,$7B
.byte $7A,$7D,$7D,$7D
.byte $7D,$7D,$7E,$7B

B06_BAA3:
    lda #$05
    sta $94 ; return bank for various function calls, doubles as index of selected option for multiple-choice menus

    lda $31 ; current map ID

    cmp #$03 ; Map ID #$03: Midenhall 1F

    beq B06_BAAE
B06_BAAD:
    rts

B06_BAAE:
    lda $0549 ; NPC #$01 sprite ID

    cmp #$FF
    beq B06_BAAD
    lda $17 ; current map Y-pos (1)

    cmp #$05
    bne B06_BAAD
    lda $16 ; current map X-pos (1)

    cmp #$0E
    bcc B06_BAAD
    cmp #$11
    bcs B06_BAAD
    lda $054B ; NPC #$01 scripted motion high byte

    cmp #$7F
    bne B06_BAD5
    jsr B0F_CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)
    .byte $82,$21,$D5,$80
    bcc B06_BADF
B06_BAD5:
    jsr B0F_CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)
    .byte $82,$21,$DB,$80
    inc $0565 ; NPC #$05 Y-pos

B06_BADF:
    jsr B0F_CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)
    .byte $81,$21,$CF,$80
    lda $16 ; current map X-pos (1)

    cmp #$0E
    bne B06_BAF4
    inc $055A ; NPC #$03 scripted motion low byte

    dec $055C ; NPC #$04 X-pos

    bne B06_BAFE
B06_BAF4:
    cmp #$10
    bne B06_BAFE
    dec $055A ; NPC #$03 scripted motion low byte

    inc $055C ; NPC #$04 X-pos

B06_BAFE:
    lda $16 ; current map X-pos (1)

    clc
    adc $0544 ; NPC #$01 ?

    clc
    adc $054C ; NPC #$02 ?

    cmp #$0E
    bne B06_BB14
    dec $0562 ; NPC #$04 scripted motion low byte

    dec $0564 ; NPC #$05 X-pos

    bne B06_BB1E
B06_BB14:
    cmp #$10
    bne B06_BB1E
    inc $0562 ; NPC #$04 scripted motion low byte

    inc $0564 ; NPC #$05 X-pos

B06_BB1E:
    lda #$00
    tay
B06_BB21:
    sta $0542, y ; NPC #$00 ?

    iny
    cpy #$10
    bne B06_BB21
    lda #$FF
    sta $0549 ; NPC #$01 sprite ID

    sta $0551 ; NPC #$02 sprite ID

    ldx #$01
    stx $0561 ; NPC #$04 sprite ID

    inx
    stx $0569 ; NPC #$05 sprite ID

    jmp B0F_CCD2 ; execute scripted motion


B06_BB3D:
    jsr B0F_CD26 ; set Z if your current map position is the (X, Y) co-ordinates given by the next 2 bytes
    .byte $0F,$03
    beq B06_BB45
    rts

B06_BB45:
    lda #$FF
    sta $35 ; flag indicating whether any menu is currently open

    lda #$46
    sta $062C ; current battle message delay

    jsr B0F_EB76 ; open menu specified by next byte
    .byte $04
    lda #$00
    jsr B0F_FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $B5
B06_BB5B:
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $B6
    jsr B0F_EB76 ; open menu specified by next byte
    .byte $19
    cmp #$00
    beq B06_BB6E
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $B7
    jmp B06_BB5B

B06_BB6E:
    lda #$01
    jsr B0F_FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $B8
    lda #$02
    jsr B0F_FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $BC
    jsr B0F_D0F5 ; wait for a while and then wipe menu regions #$03, #$00, and #$01

    jsr B0F_CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)
    .byte $85,$20,$BE,$80
    jsr B0F_CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)
    .byte $84,$20,$BE,$80
    jsr B0F_CCE7
    jsr B06_BC38
    jsr B0F_CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)
    .byte $82,$20,$55,$80
    jsr B0F_CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)
    .byte $81,$20,$55,$80
    jsr B0F_CCE7
    jsr B06_BC38
    jsr B0F_EB76 ; open menu specified by next byte
    .byte $04
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $B9
    jsr B0F_D0F5 ; wait for a while and then wipe menu regions #$03, #$00, and #$01

    ldy #$38
B06_BBB8:
    lda #$02
    sta $0578, y ; NPC #$07 motion nybble + direction nybble

    tya
    sec
    sbc #$08
    tay
    bpl B06_BBB8
    jsr B0F_CF64
    jsr B06_BC38
    jsr B0F_EB76 ; open menu specified by next byte
    .byte $04
    lda #$00
    jsr B0F_FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $BA
    jsr B0F_D0F5 ; wait for a while and then wipe menu regions #$03, #$00, and #$01

    lda #$01
    sta $0568 ; NPC #$05 motion nybble + direction nybble

    jsr B06_BC2D
    lda #$02
    sta $0568 ; NPC #$05 motion nybble + direction nybble

    jsr B06_BC2D
    ldx #$0A
    jsr B0F_C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

    lda #$03
    sta $0560 ; NPC #$04 motion nybble + direction nybble

    jsr B06_BC2D
    lda #$02
    sta $0560 ; NPC #$04 motion nybble + direction nybble

    jsr B06_BC2D
    jsr B06_BC34
    lda #$01
    sta $0540 ; NPC #$00 ? + direction nybble

    jsr B06_BC2D
    lda #$02
    sta $0540 ; NPC #$00 ? + direction nybble

    jsr B06_BC2D
    jsr B06_BC34
    lda #$19 ; Music ID #$19: end credits BGM

    jsr B0F_C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    jsr B06_BC38
    lda #$FF ; SLOW

    sta $062C ; current battle message delay

    jsr B0F_EB76 ; open menu specified by next byte
    .byte $04
    jsr B0F_FA2E ; display string ID specified by next byte + #$0100
    .byte $93
    jmp B0F_D343

B06_BC2D:
    jsr B0F_CF64
    ldx #$0A
    bne B06_BC3A
B06_BC34:
    ldx #$1E
    bne B06_BC3A
B06_BC38:
    ldx #$3C
B06_BC3A:
    jmp B0F_C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF


B06_BC3D:
    ldx #$3D
B06_BC3F:
    lda B06_BC4F, x ; code copied to and executed in RAM

    sta $0400, x ; menu-based palette overrides start

    dex
    bpl B06_BC3F
    lda $05F6 ; current bank

    pha
; call to code in RAM
    jmp $0433

; code copied to and executed in RAM
; indexed data load target (from $BC3F)
B06_BC4F:
    ldy $05F6 ; current bank

    iny
    tya
    and #$07
    pha
    ldx $43
    cpx #$03
    bne B06_BC66
    jsr B0F_C476 ; read joypad 1 data into $2F

    lsr $2F ; joypad 1 data

    ldx $43
    bcc B06_BC84
B06_BC66:
    inx
    cpx #$14
    bcc B06_BC84
    jsr B0F_C3AB ; generate a random number and store it in $32-$33 (two passes)

    lda $32 ; RNG byte 0

    and #$24
    bne B06_BC84
B06_BC74:
    jsr B0F_C476 ; read joypad 1 data into $2F

    lsr $2F ; joypad 1 data

    bcc B06_BC74
B06_BC7B:
    jsr B0F_C476 ; read joypad 1 data into $2F

    lsr $2F ; joypad 1 data

    bcs B06_BC7B
    ldx #$03
B06_BC84:
    pla
    jsr B0F_C3D5 ; save A to $05F6, X to $43, and load bank specified by A

    jsr B0F_C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

    beq B06_BC4F ; code copied to and executed in RAM

B06_BC8D:
    lda $17 ; current map Y-pos (1)

    cmp #$07
    beq B06_BC94
    rts

B06_BC94:
    ldy #$50
    lda #$00
B06_BC98:
    sta $053A, y
    iny
    cpy #$68
    bne B06_BC98
    lda #$FF
    sta $0591 ; NPC #$0A sprite ID

    sta $0599 ; NPC #$0B sprite ID

    sta $05A1 ; NPC #$0C sprite ID

    lda $16 ; current map X-pos (1)

    sta $058C ; NPC #$0A X-pos

    sta $0594 ; NPC #$0B X-pos

    dec $0594 ; NPC #$0B X-pos

    sta $059C ; NPC #$0C X-pos

    inc $059C ; NPC #$0C X-pos

    lda $17 ; current map Y-pos (1)

    sta $058D ; NPC #$0A Y-pos

    inc $058D ; NPC #$0A Y-pos

    sta $0595 ; NPC #$0B Y-pos

    sta $059D ; NPC #$0C Y-pos

    lda #$04
    sta $0591 ; NPC #$0A sprite ID

    jsr B06_BD6C
    sta $0599 ; NPC #$0B sprite ID

    jsr B06_BD6C
    sta $05A1 ; NPC #$0C sprite ID

    jsr B06_BD6C
    jsr B06_BD7C
    jsr B06_BD7C
    lda #$0A
    sta $D0 ; Malroth status flag (#$FF = defeated, #$00 = alive, others = countdown to battle)

B06_BCE8:
    jsr B0F_C3AB ; generate a random number and store it in $32-$33 (two passes)

    lda $32 ; RNG byte 0

    and #$0E
    sec
    sbc #$08
    sta $18
    jsr B0F_C3AB ; generate a random number and store it in $32-$33 (two passes)

    lda $32 ; RNG byte 0

    and #$0E
    sec
    sbc #$08
    sta $19
    lda #$00
    sta $1C
    sta $1E
    lda #$87 ; Music ID #$87: hit 2 SFX

    jsr B0F_C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    jsr B0F_D325
    jsr B0F_C3AB ; generate a random number and store it in $32-$33 (two passes)

    lda $32 ; RNG byte 0

    and #$07
    bne B06_BD1D
    jsr B0F_C511 ; flash screen 5 times

    jmp B06_BD21

B06_BD1D:
    tax
    jsr B0F_C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

B06_BD21:
    dec $D0 ; Malroth status flag (#$FF = defeated, #$00 = alive, others = countdown to battle)

    bne B06_BCE8
B06_BD25:
    lda #$94 ; Music ID #$94: burning SFX

    jsr B0F_C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    jsr B0F_D200
    lda $98 ; outcome of last fight?

    cmp #$FE
    bcc B06_BD25
    lda #$06
    sta $94 ; return bank for various function calls, doubles as index of selected option for multiple-choice menus

    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $E8
    jsr B0F_C515 ; flash screen 10 times

    jsr B0F_C515 ; flash screen 10 times

    lda #$84
    sta $062D ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    sta $063F ; Cannock status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    sta $0651 ; Moonbrooke status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    jsr B0F_C77B ; restore full HP/MP to all living party members

    jsr B0F_EB76 ; open menu specified by next byte
    .byte $01
    jsr B0F_C22C
    jsr B0F_FA32 ; display string ID specified by next byte + #$0200
    .byte $E9
    lda #$FF
    sta $D0 ; Malroth status flag (#$FF = defeated, #$00 = alive, others = countdown to battle)

    sta $44 ; non-saved event status (#$00 = event start, #$01 = Lianport Gremlins defeated, #$02 = met with Lianport grandfather/have no friends at Shrine SW of Cannock, #$03 = King Midenhall moved to stairs, #$04 = King Midenhall moved down stairs, #$05 = King Midenhall spoke on Midenhall 1F, #$0B = Lighthouse Wizard 7F, #$1B Lighthouse Wizard 2F spoke, #$64 = Hargon dead, #$FF = event end)

    ldx #$01
    jsr B0F_D2F1
    lda #$00
    sta $8E ; flag for in battle or not (#$FF)?

    jmp B0F_D88F ; warp to warp point given by ($0C)


B06_BD6C:
    lda #$91 ; Music ID #$91: swamp SFX

    jsr B0F_C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    jsr B0F_D32E
    ldx #$28
    jsr B0F_C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

    lda #$04
    rts

B06_BD7C:
    lda #$94 ; Music ID #$94: burning SFX

    jsr B0F_C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    jsr B0F_C511 ; flash screen 5 times

    ldx #$11
    jsr B0F_C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

    lda #$94 ; Music ID #$94: burning SFX

    jsr B0F_C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    jsr B0F_C511 ; flash screen 5 times

    ldx #$32
    jmp B0F_C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF


B06_BD96:
    lda $61AD
    bne B06_BDEC
    lda #$FF
    sta $0541 ; NPC #$00 sprite ID

    sta $0549 ; NPC #$01 sprite ID

    sta $0551 ; NPC #$02 sprite ID

    lda $CF ; ship status (#$04 = on ship, #$02 = own ship, #$01 = beat Lianport Gremlins)

    and #$04
    beq B06_BDB3
    lda #$05
    sta $0541 ; NPC #$00 sprite ID

    bne B06_BDC6
B06_BDB3:
    ldx #$07
    lda #$84
    sta $0E
    jsr B06_BDED
    lda #$04
    sta $0E
    jsr B06_BDED
    jsr B06_BE10
B06_BDC6:
    ldy #$00
B06_BDC8:
    lda $0541, y ; NPC #$00 sprite ID

    cmp #$FF
    bne B06_BDE3
    lda #$00
    sta $053A, y
    sta $053B, y
    sta $053C, y ; NPC #$00 ?

    sta $053D, y ; NPC #$00 ?

    sta $053E, y ; NPC #$00 ?

    sta $053F, y ; NPC #$00 ?

B06_BDE3:
    tya
    clc
    adc #$08
    tay
    cmp #$18
    bne B06_BDC8
B06_BDEC:
    rts

B06_BDED:
    ldy #$00
    sty $0C
B06_BDF1:
    lda $062D, y ; Midenhall status (80 = Alive, 40 = Sleep, 20 = Poison, 10 = ?, 08 = ?, 04 = In Party, 02 = Surround, 01 = Silence)

    and #$84
    cmp $0E
    bne B06_BE04
    lda $0C
    sta $053A, x
    txa
    clc
    adc #$08
    tax
B06_BE04:
    inc $0C
    tya
    clc
    adc #$12
    tay
    cmp #$36
    bne B06_BDF1
    rts

B06_BE10:
    lda $45
    cmp #$FF
    bne B06_BE17
    rts

B06_BE17:
    cmp #$00
    bne B06_BE23
    lda #$02
B06_BE1D:
    sta $0540 ; NPC #$00 ? + direction nybble

    jmp B06_BE27

B06_BE23:
    cmp #$01
    bne B06_BE51
B06_BE27:
    lda $053A
    sta $0542 ; NPC #$00 ?

    sta $054A ; NPC #$01 scripted motion low byte

    lda $053B
    sta $0543 ; NPC #$00 ?

    sta $054B ; NPC #$01 scripted motion high byte

    lda $0540 ; NPC #$00 ? + direction nybble

    sta $0548 ; NPC #$01 ? + direction nybble

    sta $0550 ; NPC #$02 ? + direction nybble

    lda #$00
    sta $0544 ; NPC #$01 ?

    sta $0545 ; NPC #$01 ?

    sta $054C ; NPC #$02 ?

    sta $054D ; NPC #$02 ?

    rts

B06_BE51:
    cmp #$03
    bne B06_BE59
    lda #$03
    bne B06_BE1D
B06_BE59:
    cmp #$04
    bne B06_BE61
    lda #$01
    bne B06_BE1D
B06_BE61:
    cmp #$09
    bne B06_BE69
    lda #$00
    beq B06_BE1D
B06_BE69:
    cmp #$0A
    bne B06_BE71
    lda #$02
    bne B06_BE1D
B06_BE71:
    cmp #$02
    bne B06_BEBC
    lda $17 ; current map Y-pos (1)

    bne B06_BE7D
B06_BE79:
    lda #$02
    bne B06_BE93
B06_BE7D:
    lda $16 ; current map X-pos (1)

    cmp $21 ; map width

    bne B06_BE87
B06_BE83:
    lda #$03
    bne B06_BE93
B06_BE87:
    lda $16 ; current map X-pos (1)

    bne B06_BE8F
B06_BE8B:
    lda #$01
    bne B06_BE93
B06_BE8F:
    lda #$00
    beq B06_BE93 ; useless op

B06_BE93:
    sta $0540 ; NPC #$00 ? + direction nybble

    sta $0548 ; NPC #$01 ? + direction nybble

    sta $0550 ; NPC #$02 ? + direction nybble

    asl
    asl
    asl
    tax
    ldy #$08
B06_BEA2:
    lda #$04
    sta $2E
B06_BEA6:
    lda B06_BECD, x
    sta $053A, y
    iny
    inx
    dec $2E
    bne B06_BEA6
    tya
    clc
    adc #$04
    tay
    cmp #$18
    bne B06_BEA2
    rts

B06_BEBC:
    cmp #$05
    beq B06_BE8F
    cmp #$06
    beq B06_BE8B
    cmp #$07
    beq B06_BE79
    cmp #$08
    beq B06_BE83
    rts

B06_BECD:
.byte $80,$7F,$00,$01
.byte $80,$8F,$00,$01
.byte $70,$6F,$FF,$00
.byte $60,$6F,$FF,$00
.byte $80,$5F,$00,$FF
.byte $80,$4F,$00,$FF

.byte $90,$6F,$01,$00
.byte $A0,$6F,$01,$00

; X = 1 => CLC and update $0C-$0D to warp point data to use if Outside allowed from current map, SEC otherwise, X = 2 => CLC and update $0C-$0D to warp point data to use if Return allowed from current map, SEC otherwise, X = 3 => disembark from ship and update ship position based on last save point ID $48
B06_BEED:
    dex
    beq B06_BEF8 ; CLC and update $0C-$0D to warp point data to use if Outside allowed from current map

    dex
    beq B06_BF3A ; CLC and update $0C-$0D to warp point data to use if Return allowed from current map

    dex
    beq B06_BF5F ; disembark from ship and update ship position based on last save point ID $48

    sec
    rts

; CLC and update $0C-$0D to warp point data to use if Outside allowed from current map
B06_BEF8:
    lda $31 ; current map ID

    cmp #$17 ; Map ID #$17: Hargon's Castle 7F

    bne B06_BF0F
; Hargon's Castle 7F is special: after defeating Hargon, you can't escape before defeating Malroth
    lda $D0 ; Malroth status flag (#$FF = defeated, #$00 = alive, others = countdown to battle)

    bmi B06_BF09 ; Outside from Hargon's Castle 7F is okay

    lda $0561 ; NPC #$04 sprite ID; #$FF if Hargon defeated

    cmp #$FF
    beq B06_BF23 ; SEC to flag Outside not allowed for calling code

; Outside from Hargon's Castle 7F is okay
B06_BF09:
    lda #$44 ; Map ID #$44: Hargon's Castle 2F

    ldy #$07 ; first floor index for Map ID #$44: Hargon's Castle 2F

    bne B06_BF25 ; Outside is allowed

B06_BF0F:
    cmp #$18 ; Map ID #$18: Charlock Castle B8

    bne B06_BF19
; Charlock Castle B8 is not considered a dungeon, so handle it specially
    lda #$34 ; Map ID #$34: Charlock Castle B1/B2

    ldy #$03 ; first floor index for Map ID #$34: Charlock Castle B1/B2

    bne B06_BF25 ; Outside is allowed

B06_BF19:
    ldy #$0C ; for everything else, start scanning the first floor list

B06_BF1B:
    cmp B06_BF82, y ; dungeon first floors

    bcs B06_BF25 ; Outside is allowed

    dey
    bpl B06_BF1B ; if more first floors to check, check them

; SEC to flag Outside not allowed for calling code
B06_BF23:
    sec
    rts

; Outside is allowed
B06_BF25:
    sec
    sbc B06_BF82, y ; dungeon first floors

    sta $0E ; floor number

    tya
    asl
    tay
    lda B06_BF8F, y ; pointer to warp point data used when casting Outside
    sta $0C
    lda B06_BF8F+1, y
    sta $0D
    clc
    rts

; CLC and update $0C-$0D to warp point data to use if Return allowed from current map
B06_BF3A:
    lda $31 ; current map ID

    beq B06_BF5D ; SEC to flag Return disallowed for calling code; Map ID #$00: Fake Midenhall

    cmp #$2B ; map IDs >= #$2B are dungeon maps

    bcs B06_BF5D ; SEC to flag Return disallowed for calling code

    cmp #$17 ; Map ID #$17: Hargon's Castle 7F

    beq B06_BF5D ; SEC to flag Return disallowed for calling code

    cmp #$18 ; Map ID #$18: Charlock Castle B8

    beq B06_BF5D ; SEC to flag Return disallowed for calling code

    jsr B06_BF5F ; disembark from ship and update ship position based on last save point ID $48

    lda $48 ; last save point ID

    asl
    tay
    lda B06_BFA9, y ; pointer to warp point data used when casting Return
    sta $0C
    lda B06_BFA9+1, y
    sta $0D
    clc ; CLC to flag Return allowed for calling code

    rts

; SEC to flag Return disallowed for calling code
B06_BF5D:
    sec
    rts

; disembark from ship and update ship position based on last save point ID $48
B06_BF5F:
    lda $CF ; ship status (#$04 = on ship, #$02 = own ship, #$01 = beat Lianport Gremlins)

    and #$03
    sta $CF ; ship status (#$04 = on ship, #$02 = own ship, #$01 = beat Lianport Gremlins)

    lda $48 ; last save point ID

    asl
    tay
    lda B06_BF74, y ; ship X-pos after warp
    sta $D2 ; ship X-pos (when you aren't on it)
    lda B06_BF74+1, y ; ship Y-pos after warp
    sta $D3 ; ship Y-pos (when you aren't on it)

    rts


; ship X, y-pos after warp
B06_BF74:
.byte $D4,$3C	 ; Save Point ID #$00: Midenhall 2F
.byte $A4,$09	 ; Save Point ID #$01: Cannock
.byte $3B,$2E	 ; Save Point ID #$02: Tantegel
.byte $DA,$91	 ; Save Point ID #$03: Osterfair
.byte $1F,$C5	 ; Save Point ID #$04: Beran
.byte $1F,$C5	 ; Save Point ID #$05: Rhone Shrine
.byte $78,$58	 ; Save Point ID #$06: Hamlin

; dungeon first floors
B06_BF82:
.byte $2B	 ; Map ID #$2B: Cave to Hamlin
.byte $2C	 ; Map ID #$2C: Lake Cave B1
.byte $2E	 ; Map ID #$2E: Sea Cave B1
.byte $34	 ; Map ID #$34: Charlock Castle B1/B2
.byte $37	 ; Map ID #$37: Cave to Rhone B1
.byte $40	 ; Map ID #$40: Spring of Bravery
.byte $43	 ; Map ID #$43: Cave to Rimuldar
.byte $44	 ; Map ID #$44: Hargon's Castle 2F
.byte $49	 ; Map ID #$49: Moon Tower 1F
.byte $50	 ; Map ID #$50: Lighthouse 1F
.byte $58	 ; Map ID #$58: Wind Tower 1F
.byte $60	 ; Map ID #$60: Dragon Horn South 1F
.byte $66	 ; Map ID #$66: Dragon Horn North 1F

; pointer to warp point data used when casting Outside
B06_BF8F:
.addr $A2A8      ; $02:$A2A8; Map ID #$2B: Cave to Hamlin
.addr $A2CF      ; $02:$A2CF; Map ID #$2C: Lake Cave B1
.addr $A2D2      ; $02:$A2D2; Map ID #$2E: Sea Cave B1
.addr $A2D8      ; $02:$A2D8; Map ID #$34: Charlock Castle B1/B2
.addr $A2DE      ; $02:$A2DE; Map ID #$37: Cave to Rhone B1
.addr $A2ED      ; $02:$A2ED; Map ID #$40: Spring of Bravery
.addr $A2EA      ; $02:$A2EA; Map ID #$43: Cave to Rimuldar
.addr $A2A2      ; $02:$A2A2; Map ID #$44: Hargon's Castle 2F
.addr $A2E1      ; $02:$A2E1; Map ID #$49: Moon Tower 1F
.addr $A2DB      ; $02:$A2DB; Map ID #$50: Lighthouse 1F
.addr $A2D5      ; $02:$A2D5; Map ID #$58: Wind Tower 1F
.addr $A2E4      ; $02:$A2E4; Map ID #$60: Dragon Horn South 1F
.addr $A2E7      ; $02:$A2E7; Map ID #$66: Dragon Horn North 1F

; pointer to warp point data used when casting Return
B06_BFA9:
; warp point data (map ID, X-pos, Y-pos) used when casting Return;
.addr $A269      ; $02:$A269; Save Point ID #$00: Midenhall 2F
.addr $A26C      ; $02:$A26C; Save Point ID #$01: Cannock
.addr $A26F      ; $02:$A26F; Save Point ID #$02: Tantegel
.addr $A272      ; $02:$A272; Save Point ID #$03: Osterfair
.addr $A275      ; $02:$A275; Save Point ID #$04: Beran
.addr $A278      ; $02:$A278; Save Point ID #$05: Rhone Shrine
.addr $A27B      ; $02:$A27B; Save Point ID #$06: Hamlin

.res $21

.byte $78,$EE,$DF,$BF,$4C,$86,$FF,$80
.literal "DRAGON WARRIORS2"
.byte $FF,$FF,$00,$00,$48,$04,$01,$0F
.byte $07,$9D,$D8,$BF,$D8,$BF,$D8,$BF

