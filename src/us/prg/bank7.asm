.segment        "PRG7":absolute
; code bytes:	$085C (13.06% of bytes in this ROM bank)
; data bytes:	$03AE (5.75% of bytes in this ROM bank)
; pcm bytes:	$0000 (0.00% of bytes in this ROM bank)
; chr bytes:	$0000 (0.00% of bytes in this ROM bank)
; free bytes:	$33C4 (80.88% of bytes in this ROM bank)
; unknown bytes:	$0032 (0.31% of bytes in this ROM bank)
; $0C0A bytes last seen in RAM bank $8000 - $BFFF (100.00% of bytes seen in this ROM bank, 18.81% of bytes in this ROM bank):
;	$085C code bytes (69.44% of bytes seen in this RAM bank, 13.06% of bytes in this ROM bank)
;	$03AE data bytes (30.56% of bytes seen in this RAM bank, 5.75% of bytes in this ROM bank)

; PRG Bank 0x07: Moonbrooke prologue + some extra text engine control code handlers

; [bank start] -> data
; from $0F:$C6DE
; possible external indexed data load target (from $0F:$F3ED, $0F:$FF28)
; external indirect data load target (via $0F:$C6DE)
; possible external indexed data load target (from $0F:$F3F2, $0F:$FF2D)
.byte $95
; -> $07:$87F1: given monster count in $8F singular monster name in $6119, and monster name length in X, print appropriate singluar/plural monster name to $60F1
.byte $81,$00
.byte $00
; external indirect data load target (via $02:$BE2F)
; -> $07:$87D8: if $8F-$90 == #$0001, print "s" + [end-FA] to $60F1 and SEC, else LDA [end-FA] and CLC
.byte $F1
.byte $87
; external indirect data load target (via $02:$BE37)

.byte $D8
.byte $87
; data -> unknown

.byte $FF,$FF,$FF,$FF
.byte $FF,$FF
.byte $FF
.byte $FF
; unknown -> data
; motion script for granddaughter in Lianport, part 1
; external indirect data load target (via $0F:$C937)
; indirect data load target
; motion script for Lianport Gremlin #2
.byte $03,$02,$02,$02
.byte $02,$01
.byte $01
.byte $FF
; external indirect data load target (via $0F:$C957)
; indirect data load target
; motion script for Lianport Gremlin #1
.byte $01,$02,$02
.byte $02
.byte $FF
; external indirect data load target (via $0F:$C950)
; indirect data load target
; motion script for granddaughter in Lianport, part 2
.byte $02,$02,$01
.byte $0A
.byte $FF
; external indirect data load target (via $0F:$C9B7)
; indirect data load target
; motion script for granddaughter in Lianport, part 3 (from left)
.byte $01,$01,$01,$01,$01,$01,$01
.byte $01,$01,$01
.byte $01,$08
.byte $FF
; external indirect data load target (via $0F:$CA01)
; indirect data load target
; motion script for granddaughter in Lianport, part 3 (from right)
.byte $01,$02
.byte $0B
.byte $FF
; external indirect data load target (via $0F:$CA0A)
; motion script for grandfather in Lianport, part 1 (from left or bottom)
.byte $03,$09
.byte $FF
; external indirect data load target (via $0F:$CA1A)
; indirect data load target
; motion script for grandfather in Lianport, part 1 (from bottom)
.byte $02,$0B
.byte $FF
; external indirect data load target (via $0F:$CA27)
; motion script for grandfather in Lianport, part 1 (from right)
.byte $02,$0A
.byte $FF
; external indirect data load target (via $0F:$CA30)
; motion script for grandfather in Lianport, part 2
.byte $02,$09
.byte $FF
; external indirect data load target (via $0F:$CA41)
; indirect data load target
; motion script for grandfather in Lianport, part 3
.byte $00
; external indirect data load target (via $0F:$CCA7)
; motion script for guard #1, Shrine SW of Cannock
.byte $00,$03
.byte $09
.byte $FF
; external indirect data load target (via $0F:$CA6B)
; indirect data load target
; motion script for guard #1, Shrine SW of Cannock
.byte $01,$08
.byte $FF
; external indirect data load target (via $0F:$CA64)
; indirect data load target
; motion script for King Midenhall, Lighthouse Wizard part 1
.byte $03,$08
.byte $FF
; external indirect data load target (via $0F:$C862, $0F:$CB59)
; indirect data load target
; motion script for Saber Lion, Osterfair
.byte $02,$02,$02
.byte $02
.byte $FF
; external indirect data load target (via $0F:$CAEE)
; indirect data load target
; motion script for dog in Zahan, triggered from left/top
.byte $01
.byte $01
; external indirect data load target (via $0F:$CB29)
; motion script for Cannock and Moonbrooke, ending part 3, dog in Zahan, triggered from right
.byte $01,$01
.byte $01
.byte $FF
; external indirect data load target (via $06:$BB9C, $06:$BBA3, $0F:$CB12)
; indirect data load target
; motion script for Lighthouse Wizard part 2
.byte $00,$00
.byte $00
.byte $FF
; external indirect data load target (via $0F:$CB9C)
; indirect data load target
; motion script for Lighthouse Wizard part 3
.byte $02,$02,$02,$02,$03,$03,$02,$03,$03,$03,$03,$03,$02
.byte $02,$03,$03,$03,$02,$02
.byte $03,$03,$03
.byte $03,$09
.byte $FF
; external indirect data load target (via $0F:$CEC7, $0F:$CF54)
; indirect data load target
; motion script for Lighthouse Wizard part 4
.byte $02,$01,$01,$01,$01,$01,$01,$01,$01,$02,$01
.byte $01,$01,$01,$01,$01
.byte $01,$01,$01
.byte $0B
.byte $FF
; external indirect data load target (via $0F:$CF56)
; indirect data load target
; motion script for Lighthouse Wizard part 5
.byte $00,$01,$00,$00,$00,$00
.byte $00,$00,$00
.byte $0A
.byte $FF
; external indirect data load target (via $0F:$CF58)
; indirect data load target
; motion script for Lighthouse Wizard part 6
.byte $02,$02,$02,$02,$02,$02,$03
.byte $03,$02,$02,$03
.byte $03,$09
.byte $FF
; external indirect data load target (via $0F:$CF5A)
; indirect data load target
; motion script for Lighthouse Wizard part 7
.byte $01,$01,$01,$01,$01,$01,$01,$01,$01,$01
.byte $00,$00,$00,$00,$00
.byte $00,$00
.byte $0A
.byte $FF
; external indirect data load target (via $0F:$CF5C)
; indirect data load target
; motion script for top 2 guards, ending part 2
.byte $02,$02,$02,$03,$03,$03
.byte $03,$03,$00
.byte $00
.byte $00
; external indirect data load target (via $06:$BB88, $06:$BB8F)
; indirect data load target
; motion script for guard #2 part 9, prologue
.byte $00,$0A
.byte $FF
; external indirect data load target (via $0F:$C834)
; indirect data load target
; motion script for Evil Clown #1, Sea Cave B5
.byte $00,$08,$08,$08,$00
.byte $08,$08,$08
.byte $00
.byte $FF
; external indirect data load target (via $0F:$CC7E)
; indirect data load target
; indirect data load target
.byte $03,$03
.byte $FF
; motion script for Moonbrooke, ending part 1 (not turned)
.byte $03
; external indirect data load target (via $06:$BAE4)
; indirect data load target
; indirect data load target
.byte $03,$09,$09
.byte $09
.byte $FF
; motion script for Moonbrooke, ending part 1 (turned)
.byte $01
; external indirect data load target (via $06:$BAD1)
; indirect data load target
; indirect data load target
.byte $01,$0B,$0B
.byte $0B
.byte $FF
; motion script for Cannock, ending part 1
.byte $01
; external indirect data load target (via $06:$BADA)
; indirect data load target
; motion script for guard #1 zig-zag to King, prologue
.byte $01,$00,$0B
.byte $0B,$0B
.byte $FF
; indirect data load target (via $822F)
; motion script for monster #1 walk to King, prologue
.byte $00,$00,$00,$01,$01,$00
.byte $00,$01,$00
.byte $00
.byte $00
; indirect data load target (via $8276)
; motion script for guard #1 walk left into ambush, prologue
.byte $01,$01
.byte $08
.byte $FF
; indirect data load target (via $8240)
; motion script for King and Princess part 1, prologue
.byte $03
.byte $FF
; indirect data load target (via $82D0)
; motion script for King and Princess part 2, prologue
.byte $03,$02,$02,$01,$01
.byte $02,$02
.byte $09
.byte $FF
; indirect data load target (via $82F3)
; motion script for facing left (monster #2, guard #2 part 4, prologue)
.byte $01
; indirect data load target (via $8372, $8501)

.byte $0B
.byte $FF
; data -> unknown

.byte $03
; unknown -> data
; motion script for King part 1, prologue
; indirect data load target (via $832E)
; motion script for King part 2, prologue
.byte $00,$00,$03
.byte $03
.byte $FF
; indirect data load target (via $835D)
; motion script for monster #2, prologue
.byte $09
.byte $FF
; indirect data load target (via $8383)
; motion script for guard #2 part 1, prologue
.byte $00,$00
.byte $03
.byte $FF
; indirect data load target (via $8461)
; motion script for monster #3, prologue
.byte $09,$09,$09,$09,$09,$09,$09,$09,$09,$09,$01,$09,$01,$09,$01
.byte $09,$01,$09,$01,$0A,$02,$0A,$02
.byte $0A,$02,$0A,$02
.byte $0A,$02
.byte $FF
; indirect data load target (via $849A)
; motion script for guard #2 part 2, prologue
.byte $09,$08
.byte $FF
; indirect data load target (via $84D3)
; motion script for guard #2 part 7, prologue
.byte $02,$0A,$02,$0A
.byte $02,$0A
.byte $02
.byte $FF
; indirect data load target (via $855E)
; motion script for left guard, prologue
.byte $00,$08,$08,$00,$08,$08,$00,$08,$08,$08,$00
.byte $08,$08,$08,$00,$08
.byte $08,$08,$08
.byte $00
.byte $FF
; indirect data load target (via $857D)
; motion script for right guard, prologue
.byte $01,$02,$02
.byte $09
.byte $FF
; indirect data load target (via $8576)

.byte $03,$02,$02
.byte $0B
.byte $FF
; data -> unknown

.byte $08
.byte $FF
; unknown -> data
; motion script for guard #2 part 8, prologue
; indirect data load target (via $85EC)
; motion script for left and right guards, prologue
.byte $00
.byte $FF
; indirect data load target (via $85B8, $85BF)
; motion script for guard #2 part 3, prologue
.byte $00
.byte $FF
; indirect data load target (via $84F4)
; motion script for guard #2 part 5, prologue
.byte $09,$01,$09,$09,$01,$09,$09,$09
.byte $01,$09,$09,$09
.byte $09,$01
.byte $FF
; indirect data load target (via $851A)
; motion script for Princess, prologue
.byte $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
.byte $0B,$0B,$01,$09,$01,$09
.byte $01,$09,$01
.byte $09
.byte $FF
; indirect data load target (via $83F9)
; motion script for guard #2 part 6, prologue
.byte $03,$00,$00
.byte $03
.byte $FF
; indirect data load target (via $8531)

.byte $01,$09,$01,$09,$02,$0A,$01,$09,$01
.byte $09,$02,$0A,$01,$09
.byte $02,$0A
.byte $01
.byte $FF
; data -> code
; from $0F:$C6DE via $8000
; indirect control flow target (via $8000)
    jsr $81B2 ; probably this displays the prologue

    jsr $81CE
    jsr $81D9
    jsr $81EA
    lda #$00
    sta $61AD
    sta $05D4 ; NPC #$13 X-pos

    sta $05D5 ; NPC #$13 Y-pos

    lda #$6F
    sta $053B
    rts

; probably this displays the prologue
; control flow target (from $8195)
    lda #$07
    sta $94 ; return bank for various function calls, doubles as index of selected option for multiple-choice menus

    lda #$FF
    sta $8E ; flag for in battle or not (#$FF)?

; call to code in a different bank ($0F:$C468)
    jsr $C468 ; set every 4th byte of $0200 - $02FC to #$F0

; call to code in a different bank ($0F:$C42A)
    jsr $C42A
; call to code in a different bank ($0F:$C446)
    jsr $C446 ; turn screen off, write $800 [space] tiles to PPU $2000, turn screen on

; call to code in a different bank ($0F:$C1DC)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

; call to code in a different bank ($0F:$C577)
    jsr $C577 ; set $6144 to #$05

    ldx #$1E
; call to code in a different bank ($0F:$C1EE)
    jmp $C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF


; control flow target (from $8198)
; call to code in a different bank ($0F:$FF60)
    jsr $FF60
    inc $8E ; flag for in battle or not (#$FF)?

    jsr $88E4
; call to code in a different bank ($0F:$C42A)
    jmp $C42A

; control flow target (from $819B)
    lda #$FF
    sta $61AD
    lda #$01
    sta $0541 ; NPC #$00 sprite ID

    lda #$08
    sta $48 ; last save point ID

; call to code in a different bank ($0F:$FF5A)
    jmp $FF5A

; control flow target (from $819E)
    lda #$FF
    sta $35 ; flag indicating whether any menu is currently open

    ldx #$14
; call to code in a different bank ($0F:$C1EE)
    jsr $C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

; call to code in a different bank ($0F:$F6EA)
    jsr $F6EA ; open main dialogue window and display string ID specified by byte following JSR


; code -> data
; indirect data load target

.byte $7D
; data -> code
    ldx #$3C
; call to code in a different bank ($0F:$C1EE)
    jsr $C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

; call to code in a different bank ($0F:$D0F5)
    jsr $D0F5 ; wait for a while and then wipe menu regions #$03, #$00, and #$01

; call to code in a different bank ($0F:$C577)
    jsr $C577 ; set $6144 to #$05

    jsr $867D ; set $6007 = #$00, set $00 = #$01, wait for #$50 interrupts, set $00 = #$FF

    lda #$00 ; Music ID #$00: BGM off

; call to code in a different bank ($0F:$C561)
    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    jsr $8670 ; set $6007 = #$00, set $00 = #$01, wait for #$1E interrupts, set $00 = #$FF

    jsr $8682
    jsr $8682
    jsr $867D ; set $6007 = #$00, set $00 = #$01, wait for #$50 interrupts, set $00 = #$FF

    lda #$17 ; Music ID #$17: normal battle BGM

; call to code in a different bank ($0F:$C561)
    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    jsr $865A
    inc $35 ; flag indicating whether any menu is currently open

    jsr $8678 ; set $6007 = #$00, set $00 = #$01, wait for #$37 interrupts, set $00 = #$FF

; call to code in a different bank ($0F:$F6EA)
    jsr $F6EA ; open main dialogue window and display string ID specified by byte following JSR


; code -> data
; indirect data load target

.byte $7E
; data -> code
; call to code in a different bank ($0F:$D0F5)
    jsr $D0F5 ; wait for a while and then wipe menu regions #$03, #$00, and #$01

; call to code in a different bank ($0F:$CCF1)
    jsr $CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)


; code -> data
; indirect data load target
; indirect data load target
.byte $84
; indirect data load target
.byte $20

.byte $E1
.byte $80
; data -> code
; call to code in a different bank ($0F:$FF84)
    jsr $FF84
; call to code in a different bank ($0F:$F6EA)
    jsr $F6EA ; open main dialogue window and display string ID specified by byte following JSR


; code -> data
; indirect data load target

.byte $7F
; data -> code
; call to code in a different bank ($0F:$D0F5)
    jsr $D0F5 ; wait for a while and then wipe menu regions #$03, #$00, and #$01

; call to code in a different bank ($0F:$CCF1)
    jsr $CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)


; code -> data
; indirect data load target
; indirect data load target
.byte $84
; indirect data load target
.byte $23

.byte $F0
.byte $80
; data -> code
; call to code in a different bank ($0F:$FF84)
    jsr $FF84
    lda #$05
    sta $608B
    sta $608F
    lda #$0B
    sta $6090
    lda #$01
    jsr $8698
    jsr $8675
    jsr $8620
    jsr $866B ; set $6007 = #$00, set $00 = #$01, wait for #$14 interrupts, set $00 = #$FF

    jsr $861B
    jsr $866B ; set $6007 = #$00, set $00 = #$01, wait for #$14 interrupts, set $00 = #$FF

    lda #$04
    jsr $8628
    jsr $863C
    jsr $8675
; call to code in a different bank ($0F:$CCF1)
    jsr $CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)


; code -> data
; indirect data load target
; indirect data load target
.byte $85
; indirect data load target
.byte $21

.byte $EC
.byte $80
; data -> code
; call to code in a different bank ($0F:$FF84)
    jsr $FF84
; call to code in a different bank ($0F:$F6EA)
    jsr $F6EA ; open main dialogue window and display string ID specified by byte following JSR


; code -> data
; indirect data load target

.byte $80
; data -> code
; call to code in a different bank ($0F:$D0F5)
    jsr $D0F5 ; wait for a while and then wipe menu regions #$03, #$00, and #$01

    lda #$F7
    sta $053B
    lda #$07
    sta $055C ; NPC #$04 X-pos

    lda #$0A
    sta $055D ; NPC #$04 Y-pos

; call to code in a different bank ($0F:$FF8A)
    jsr $FF8A
    jsr $8616
    jsr $8670 ; set $6007 = #$00, set $00 = #$01, wait for #$1E interrupts, set $00 = #$FF

    lda #$01
    jsr $8628
    jsr $8670 ; set $6007 = #$00, set $00 = #$01, wait for #$1E interrupts, set $00 = #$FF

    lda #$6F
    sta $053B
    lda #$64
    sta $055C ; NPC #$04 X-pos

    lda #$64
    sta $055D ; NPC #$04 Y-pos

; call to code in a different bank ($0F:$FF8A)
    jsr $FF8A
    jsr $8611
    jsr $8670 ; set $6007 = #$00, set $00 = #$01, wait for #$1E interrupts, set $00 = #$FF

    jsr $861B
    jsr $866B ; set $6007 = #$00, set $00 = #$01, wait for #$14 interrupts, set $00 = #$FF

    lda #$05
    jsr $8632
    jsr $863C
    jsr $8675
; call to code in a different bank ($0F:$CCF1)
    jsr $CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)


; code -> data
; indirect data load target
; indirect data load target
.byte $82
; indirect data load target
.byte $23

.byte $F2
.byte $80
; data -> code
    lda #$00
    jsr $8729
    lda #$03
    sta $0540 ; NPC #$00 ? + direction nybble

; call to code in a different bank ($0F:$FF8A)
    jsr $FF8A
    jsr $8675
    lda #$02
; call to code in a different bank ($0F:$FC50)
    jsr $FC50 ; print name of hero given by low 2 bits of A to $6119, terminated by #$FA

; call to code in a different bank ($0F:$F6EA)
    jsr $F6EA ; open main dialogue window and display string ID specified by byte following JSR


; code -> data
; indirect data load target

.byte $81
; data -> code
; call to code in a different bank ($0F:$D0F5)
    jsr $D0F5 ; wait for a while and then wipe menu regions #$03, #$00, and #$01

; call to code in a different bank ($0F:$CCF1)
    jsr $CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)


; code -> data
; indirect data load target
; indirect data load target
.byte $82
; indirect data load target
.byte $21

.byte $FB
.byte $80
; data -> code
    lda #$01
    jsr $8729
    jmp $831A

    jsr $8678 ; set $6007 = #$00, set $00 = #$01, wait for #$37 interrupts, set $00 = #$FF

    lda #$02
    jsr $8643
    jsr $8675
    lda #$F7
    sta $053B
    lda #$09
    sta $055C ; NPC #$04 X-pos

    lda #$0E
    sta $055D ; NPC #$04 Y-pos

    jmp $8405

; control flow target (from $82FA)
    lda #$F7
    sta $053B
    lda #$09
    sta $055C ; NPC #$04 X-pos

    lda #$0E
    sta $055D ; NPC #$04 Y-pos

; call to code in a different bank ($0F:$CCF1)
    jsr $CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)


; code -> data
; indirect data load target
; indirect data load target
.byte $81
; indirect data load target
.byte $20

.byte $FF
.byte $80
; data -> code
; call to code in a different bank ($0F:$FF84)
    jsr $FF84
    lda #$05
    sta $0581 ; NPC #$08 sprite ID

    lda #$01
    sta $0580 ; NPC #$08 motion nybble + direction nybble

    lda #$05
    sta $608B
    lda #$09
    sta $608F
    lda #$0E
    sta $6090
    lda #$01
    jsr $8698
; call to code in a different bank ($0F:$F6EA)
    jsr $F6EA ; open main dialogue window and display string ID specified by byte following JSR


; code -> data
; indirect data load target

.byte $85
; data -> code
; call to code in a different bank ($0F:$D0F5)
    jsr $D0F5 ; wait for a while and then wipe menu regions #$03, #$00, and #$01

; call to code in a different bank ($0F:$CCF1)
    jsr $CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)


; code -> data
; indirect data load target
; indirect data load target
.byte $81
; indirect data load target
.byte $21

.byte $04
.byte $81
; data -> code
; call to code in a different bank ($0F:$FF84)
    jsr $FF84
; call to code in a different bank ($0F:$F6EA)
    jsr $F6EA ; open main dialogue window and display string ID specified by byte following JSR


; code -> data
; indirect data load target

.byte $86
; data -> code
; call to code in a different bank ($0F:$D0F5)
    jsr $D0F5 ; wait for a while and then wipe menu regions #$03, #$00, and #$01

; call to code in a different bank ($0F:$F6EA)
    jsr $F6EA ; open main dialogue window and display string ID specified by byte following JSR


; code -> data
; indirect data load target

.byte $87
; data -> code
; call to code in a different bank ($0F:$CCF1)
    jsr $CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)


; code -> data
; indirect data load target
; indirect data load target
.byte $85
; indirect data load target
.byte $23

.byte $FC
.byte $80
; data -> code
; call to code in a different bank ($0F:$FF84)
    jsr $FF84
; call to code in a different bank ($0F:$FA2A)
    jsr $FA2A ; display string ID specified by next byte


; code -> data
; indirect data load target

.byte $88
; data -> code
; call to code in a different bank ($0F:$D0F5)
    jsr $D0F5 ; wait for a while and then wipe menu regions #$03, #$00, and #$01

; call to code in a different bank ($0F:$CCF1)
    jsr $CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)


; code -> data
; indirect data load target
; indirect data load target
.byte $85
; indirect data load target
.byte $23

.byte $06
.byte $81
; data -> code
; call to code in a different bank ($0F:$FF84)
    jsr $FF84
    jsr $8616
    jsr $866B ; set $6007 = #$00, set $00 = #$01, wait for #$14 interrupts, set $00 = #$FF

    lda #$01
    jsr $8628
    jsr $8611
    jsr $866B ; set $6007 = #$00, set $00 = #$01, wait for #$14 interrupts, set $00 = #$FF

    lda #$05
    jsr $8632
    jsr $863C
    jsr $8678 ; set $6007 = #$00, set $00 = #$01, wait for #$37 interrupts, set $00 = #$FF

    lda #$06
    sta $608B
    lda #$07
    sta $608C
    lda #$07
    sta $608F
    sta $6091
    lda #$0B
    sta $6090
    lda #$0D
    sta $6092
    lda #$03
    jsr $8698
    jsr $8678 ; set $6007 = #$00, set $00 = #$01, wait for #$37 interrupts, set $00 = #$FF

    jsr $8616
    jsr $866B ; set $6007 = #$00, set $00 = #$01, wait for #$14 interrupts, set $00 = #$FF

    lda #$01
    jsr $8628
    jsr $8616
    jsr $866B ; set $6007 = #$00, set $00 = #$01, wait for #$14 interrupts, set $00 = #$FF

    jsr $861B
    jsr $866B ; set $6007 = #$00, set $00 = #$01, wait for #$14 interrupts, set $00 = #$FF

    lda #$01
    jsr $8628
    lda #$00
    sta $0561 ; NPC #$04 sprite ID

; call to code in a different bank ($0F:$C577)
    jsr $C577 ; set $6144 to #$05

    jsr $8678 ; set $6007 = #$00, set $00 = #$01, wait for #$37 interrupts, set $00 = #$FF

    lda #$12 ; Music ID #$12: party defeat BGM

; call to code in a different bank ($0F:$C561)
    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

; call to code in a different bank ($0F:$CCF1)
    jsr $CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)


; code -> data
; indirect data load target
; indirect data load target
.byte $82
; indirect data load target
.byte $23

.byte $7E
.byte $81
; data -> code
; call to code in a different bank ($0F:$FF84)
    jsr $FF84
; call to code in a different bank ($0F:$F6EA)
    jsr $F6EA ; open main dialogue window and display string ID specified by byte following JSR


; code -> data
; indirect data load target

.byte $89
; data -> code
; call to code in a different bank ($0F:$D0F5)
    jsr $D0F5 ; wait for a while and then wipe menu regions #$03, #$00, and #$01

; control flow target (from $8317)
    ldy #$05
    lda #$00
    jsr $8645
    lda #$08
    jsr $8645
    lda #$09
    jsr $8645
    ldx #$02
; control flow target (from $842E)
B07_8418:
    lda $879E,X
    sta $608B,X
    txa
    asl
    tay
    lda $87A4,Y
    sta $608F,Y
    lda $87A5,Y
    sta $6090,Y
    dex
    bpl B07_8418
    lda #$07
    jsr $8698
    ldx #$03
; control flow target (from $844F)
B07_8437:
    lda $879E,X
    sta $6088,X
    txa
    asl
    tay
    lda $87A4,Y
    sta $6089,Y ; string word buffer index 2

    lda $87A5,Y
    sta $608A,Y
    inx
    cpx #$06
    bcc B07_8437
    lda #$07
    jsr $8698
    jsr $8678 ; set $6007 = #$00, set $00 = #$01, wait for #$37 interrupts, set $00 = #$FF

    jsr $8678 ; set $6007 = #$00, set $00 = #$01, wait for #$37 interrupts, set $00 = #$FF

; call to code in a different bank ($0F:$CCF1)
    jsr $CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)


; code -> data
; indirect data load target
; indirect data load target
.byte $83
; indirect data load target
.byte $20

.byte $0A
.byte $81
; data -> code
    lda #$02
    jsr $8729
    jsr $8678 ; set $6007 = #$00, set $00 = #$01, wait for #$37 interrupts, set $00 = #$FF

    jsr $8620
    jsr $866B ; set $6007 = #$00, set $00 = #$01, wait for #$14 interrupts, set $00 = #$FF

    lda #$11
    jsr $8628
    jsr $863C
    jsr $8670 ; set $6007 = #$00, set $00 = #$01, wait for #$1E interrupts, set $00 = #$FF

    lda #$12
    jsr $8628
    jsr $863C
    jsr $8670 ; set $6007 = #$00, set $00 = #$01, wait for #$1E interrupts, set $00 = #$FF

    jsr $8611
    jsr $8670 ; set $6007 = #$00, set $00 = #$01, wait for #$1E interrupts, set $00 = #$FF

    lda #$0F
    jsr $8632
    jsr $8678 ; set $6007 = #$00, set $00 = #$01, wait for #$37 interrupts, set $00 = #$FF

; call to code in a different bank ($0F:$CCF1)
    jsr $CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)


; code -> data
; indirect data load target
; indirect data load target
.byte $8F
; indirect data load target
.byte $22

.byte $28
.byte $81
; data -> code
; call to code in a different bank ($0F:$FF84)
    jsr $FF84
    jsr $866B ; set $6007 = #$00, set $00 = #$01, wait for #$14 interrupts, set $00 = #$FF

    jsr $8616
    jsr $8670 ; set $6007 = #$00, set $00 = #$01, wait for #$1E interrupts, set $00 = #$FF

    lda #$03
    jsr $8628
    jsr $8670 ; set $6007 = #$00, set $00 = #$01, wait for #$1E interrupts, set $00 = #$FF

    jsr $8611
    jsr $8670 ; set $6007 = #$00, set $00 = #$01, wait for #$1E interrupts, set $00 = #$FF

    jsr $861B
    jsr $8670 ; set $6007 = #$00, set $00 = #$01, wait for #$1E interrupts, set $00 = #$FF

    lda #$0F
    jsr $8628
    jsr $863C
    jsr $8670 ; set $6007 = #$00, set $00 = #$01, wait for #$1E interrupts, set $00 = #$FF

; call to code in a different bank ($0F:$F6EA)
    jsr $F6EA ; open main dialogue window and display string ID specified by byte following JSR


; code -> data
; indirect data load target

.byte $82
; data -> code
; call to code in a different bank ($0F:$D0F5)
    jsr $D0F5 ; wait for a while and then wipe menu regions #$03, #$00, and #$01

; call to code in a different bank ($0F:$CCF1)
    jsr $CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)


; code -> data
; indirect data load target
; indirect data load target
.byte $83
; indirect data load target
.byte $22

.byte $2B
.byte $81
; data -> code
; call to code in a different bank ($0F:$FF84)
    jsr $FF84
    lda #$82 ; Music ID #$82: Stairs SFX

; call to code in a different bank ($0F:$C561)
    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

; call to code in a different bank ($0F:$C42A)
    jsr $C42A
; call to code in a different bank ($0F:$C577)
    jsr $C577 ; set $6144 to #$05

    lda #$15
    sta $05F7 ; probably BGM for current area

    lda #$0A
    sta $48 ; last save point ID

; call to code in a different bank ($0F:$FF5A)
    jsr $FF5A
; call to code in a different bank ($0F:$CCF1)
    jsr $CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)


; code -> data
; indirect data load target
; indirect data load target
.byte $84
; indirect data load target
.byte $21

.byte $58
.byte $81
; data -> code
; call to code in a different bank ($0F:$FF84)
    jsr $FF84
; call to code in a different bank ($0F:$C511)
    jsr $C511 ; flash screen 5 times

; call to code in a different bank ($0F:$CCF1)
    jsr $CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)


; code -> data
; indirect data load target
; indirect data load target
.byte $84
; indirect data load target
.byte $23

.byte $FC
.byte $80
; data -> code
; call to code in a different bank ($0F:$FF84)
    jsr $FF84
    lda #$02
    jsr $8602
    lda #$03
    jsr $8602
    lda #$94 ; Music ID #$94: burning SFX

; call to code in a different bank ($0F:$C561)
    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

; call to code in a different bank ($0F:$CCF1)
    jsr $CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)


; code -> data
; indirect data load target
; indirect data load target
.byte $84
; indirect data load target
.byte $21

.byte $67
.byte $81
; data -> code
; call to code in a different bank ($0F:$FF84)
    jsr $FF84
; call to code in a different bank ($0F:$C42A)
    jsr $C42A
    dec $61AD
    lda #$0B
    sta $48 ; last save point ID

; call to code in a different bank ($0F:$FF5A)
    jsr $FF5A
; call to code in a different bank ($0F:$CCF1)
    jsr $CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)


; code -> data
; indirect data load target
; indirect data load target
.byte $80
; indirect data load target
.byte $21

.byte $83
.byte $81
; data -> code
; call to code in a different bank ($0F:$FF84)
    jsr $FF84
    lda #$82 ; Music ID #$82: Stairs SFX

; call to code in a different bank ($0F:$C561)
    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

; call to code in a different bank ($0F:$C42A)
    jsr $C42A
    lda #$0E
    sta $051A ; something to do with whether you've opened the chest containing the Shield of Erdrick

    lda #$02
    sta $051B
    lda #$0A
    sta $0541 ; NPC #$00 sprite ID

    lda #$09
    sta $48 ; last save point ID

    lda #$00
    sta $05F7 ; probably BGM for current area

; call to code in a different bank ($0F:$FF5A)
    jsr $FF5A
; call to code in a different bank ($0F:$CCF1)
    jsr $CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)


; code -> data
; indirect data load target
; indirect data load target
.byte $80
; indirect data load target
.byte $20

.byte $33
.byte $81
; data -> code
; call to code in a different bank ($0F:$FF84)
    jsr $FF84
    jsr $8670 ; set $6007 = #$00, set $00 = #$01, wait for #$1E interrupts, set $00 = #$FF

    lda #$00
    sta $0559 ; NPC #$03 sprite ID

; call to code in a different bank ($0F:$FF8A)
    jsr $FF8A
    jsr $867D ; set $6007 = #$00, set $00 = #$01, wait for #$50 interrupts, set $00 = #$FF

; call to code in a different bank ($0F:$CCF1)
    jsr $CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)


; code -> data
; indirect data load target
; indirect data load target
.byte $82
; indirect data load target
.byte $23

.byte $4D
.byte $81
; data -> code
; call to code in a different bank ($0F:$CCF1)
    jsr $CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)


; code -> data
; indirect data load target
; indirect data load target
.byte $81
; indirect data load target
.byte $21

.byte $48
.byte $81
; data -> code
; call to code in a different bank ($0F:$FF84)
    jsr $FF84
; call to code in a different bank ($0F:$F6EA)
    jsr $F6EA ; open main dialogue window and display string ID specified by byte following JSR


; code -> data
; indirect data load target

.byte $83
; data -> code
    jsr $8678 ; set $6007 = #$00, set $00 = #$01, wait for #$37 interrupts, set $00 = #$FF

    lda #$0A
    sta $0559 ; NPC #$03 sprite ID

    jsr $8675
; call to code in a different bank ($0F:$FA2A)
    jsr $FA2A ; display string ID specified by next byte


; code -> data
; indirect data load target

.byte $84
; data -> code
; call to code in a different bank ($0F:$D0F5)
    jsr $D0F5 ; wait for a while and then wipe menu regions #$03, #$00, and #$01

    lda #$6F
    sta $053B
    lda #$08
    sta $0540 ; NPC #$00 ? + direction nybble

    lda #$0A
    sta $0541 ; NPC #$00 sprite ID

    lda #$FF
    sta $0559 ; NPC #$03 sprite ID

; call to code in a different bank ($0F:$FF8A)
    jsr $FF8A
    ldx #$0F
; control flow target (from $85CE)
B07_85B1:
    txa
    pha
; call to code in a different bank ($0F:$CCF1)
    jsr $CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)


; code -> data
; indirect data load target
; indirect data load target
.byte $82
; indirect data load target
.byte $20

.byte $56
.byte $81
; data -> code
; call to code in a different bank ($0F:$CCF1)
    jsr $CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)


; code -> data
; indirect data load target
; indirect data load target
.byte $81
; indirect data load target
.byte $20

.byte $56
.byte $81
; data -> code
    lda #$04
    jsr $8729
    ldx #$10
; call to code in a different bank ($0F:$C1EE)
    jsr $C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

    pla
    tax
    dex
    bne B07_85B1
    lda #$F7
    sta $053B
    lda #$0A
    sta $0559 ; NPC #$03 sprite ID

    lda #$0F
    sta $0554 ; NPC #$03 X-pos

    lda #$02
    sta $0555 ; NPC #$03 Y-pos

; call to code in a different bank ($0F:$FF8A)
    jsr $FF8A
; call to code in a different bank ($0F:$CCF1)
    jsr $CCF1 ; set up scripted motion variables based on next 4 bytes (low 5 bits = NPC index, NPC index + 1's motion + direction byte?, 2-byte pointer to motion script)


; code -> data
; indirect data load target
; indirect data load target
.byte $80
; indirect data load target
.byte $20

.byte $54
.byte $81
; data -> code
; call to code in a different bank ($0F:$FF84)
    jsr $FF84
    lda #$82 ; Music ID #$82: Stairs SFX

; call to code in a different bank ($0F:$C561)
    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

; call to code in a different bank ($0F:$C42A)
    jsr $C42A
    lda #$00
    sta $051A ; something to do with whether you've opened the chest containing the Shield of Erdrick

    sta $051B
    rts

; control flow target (from $8508, $850D)
    pha
    lda #$91 ; Music ID #$91: swamp SFX

; call to code in a different bank ($0F:$C561)
    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    pla
    ldy #$04
    jsr $8645
    jmp $8670 ; set $6007 = #$00, set $00 = #$01, wait for #$1E interrupts, set $00 = #$FF


; control flow target (from $82B4, $8393, $8487, $84B0)
    lda #$89 ; Music ID #$89: attack 1 SFX

; call to code in a different bank ($0F:$C561)
    jmp $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])


; control flow target (from $8294, $8388, $83C8, $83D3, $84A2)
    lda #$8B ; Music ID #$8B: attack 2 SFX

; call to code in a different bank ($0F:$C561)
    jmp $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])


; control flow target (from $8260, $82BA, $83D9, $84B6)
    lda #$88 ; Music ID #$88: critical hit SFX

; call to code in a different bank ($0F:$C561)
    jmp $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])


; control flow target (from $825A, $846B)
    lda #$90 ; Music ID #$90: casting SFX

; call to code in a different bank ($0F:$C561)
    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

; call to code in a different bank ($0F:$C515)
    jmp $C515 ; flash screen 10 times


; control flow target (from $8268, $829C, $8390, $83D0, $83E1, $8473, $847E, $84AA, $84BE)
    pha
    lda #$8A ; Music ID #$8A: hit 3 SFX

; call to code in a different bank ($0F:$C561)
    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    pla
    jmp $86F0

; control flow target (from $82C2, $839B, $848F)
    pha
    lda #$87 ; Music ID #$87: hit 2 SFX

; call to code in a different bank ($0F:$C561)
    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

    pla
    jmp $86F0

; control flow target (from $826B, $82C5, $839E, $8476, $8481, $84C1)
    pha
    ldx #$1E
; call to code in a different bank ($0F:$C1EE)
    jsr $C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

    pla
; control flow target (from $8302)
    ldy #$FF
; control flow target (from $8409, $840E, $8413, $860B)
    clc
    adc #$03
    asl
    asl
    asl
    tax
    tya
    sta $0541,X ; NPC #$00 sprite ID

    pha
; call to code in a different bank ($0F:$FF8A)
    jsr $FF8A
; call to code in a different bank ($0F:$C1DC)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    pla
    tay
    rts

; control flow target (from $821B)
    lda $87C9
    sta $0A
    lda $87CA
    sta $0B
    lda #$00
    sta $0C
; call to code in a different bank ($0F:$C228)
    jmp $C228

; set $6007 = #$00, set $00 = #$01, wait for #$14 interrupts, set $00 = #$FF
; control flow target (from $825D, $8263, $82BD, $838B, $8396, $83CB, $83D6, $83DC, $846E, $849F, $868A)
    ldx #$14
; call to code in a different bank ($0F:$C1EE)
    jmp $C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF


; set $6007 = #$00, set $00 = #$01, wait for #$1E interrupts, set $00 = #$FF
; control flow target (from $820A, $8297, $829F, $82B7, $8479, $8484, $848A, $84A5, $84AD, $84B3, $84B9, $84C4, $8563, $860E, $8695)
    ldx #$1E
; call to code in a different bank ($0F:$C1EE)
    jmp $C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF


; control flow target (from $8257, $826E, $82C8, $82DF, $8305, $858E)
; call to code in a different bank ($0F:$FF8A)
    jsr $FF8A
; set $6007 = #$00, set $00 = #$01, wait for #$37 interrupts, set $00 = #$FF
; control flow target (from $8220, $82FD, $83A1, $83C5, $83EC, $8456, $8459, $8468, $8492, $8586)
    ldx #$37
; call to code in a different bank ($0F:$C1EE)
    jmp $C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF


; set $6007 = #$00, set $00 = #$01, wait for #$50 interrupts, set $00 = #$FF
; control flow target (from $8202, $8213, $856E)
    ldx #$50
; call to code in a different bank ($0F:$C1EE)
    jmp $C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF


; control flow target (from $820D, $8210)
    lda #$94 ; Music ID #$94: burning SFX

; call to code in a different bank ($0F:$C561)
    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

; call to code in a different bank ($0F:$C511)
    jsr $C511 ; flash screen 5 times

    jsr $866B ; set $6007 = #$00, set $00 = #$01, wait for #$14 interrupts, set $00 = #$FF

    lda #$94 ; Music ID #$94: burning SFX

; call to code in a different bank ($0F:$C561)
    jsr $C561 ; play PCM specified by A (>= #$80 = sound effect [SFX], < #$80 = background music [BGM])

; call to code in a different bank ($0F:$FF66)
    jsr $FF66
    jmp $8670 ; set $6007 = #$00, set $00 = #$01, wait for #$1E interrupts, set $00 = #$FF


; control flow target (from $8254, $834E, $83C2, $8432, $8453)
    sta $6097
    ldx #$78
; control flow target (from $86ED)
B07_869D:
    txa
    pha
    ldy #$07
    cmp #$4B
    bcs B07_86AD
    ldy #$03
    cmp #$19
    bcs B07_86AD
    ldy #$01
; control flow target (from $86A3, $86A9)
B07_86AD:
    sty $6D
    ldx #$FF
    and $6D
    bne B07_86B7
    ldx #$80
; control flow target (from $86B3)
B07_86B7:
    stx $6D
    lda $6097
    sta $6E
    ldy #$00
; control flow target (from $86E0)
B07_86C0:
    lsr $6E
    bcc B07_86DC
    tya
    lsr
    tax
    lda $608B,X
    asl
    asl
    asl
    tax
    jsr $871F
    sta $0554,X ; NPC #$03 X-pos

    iny
    jsr $871F
    sta $0555,X ; NPC #$03 Y-pos

    dey
; control flow target (from $86C2)
B07_86DC:
    iny
    iny
    cpy #$08
    bcc B07_86C0
; call to code in a different bank ($0F:$FF8A)
    jsr $FF8A
; call to code in a different bank ($0F:$C1DC)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    pla
    tax
    dex
    cpx #$FF
    bne B07_869D
    rts

; control flow target (from $862F, $8639)
    pha
    asl
    asl
    asl
    tax
    stx $608B
    lda $0559,X ; NPC #$03 sprite ID

    sta $608C
    ldx #$18
; control flow target (from $871B)
B07_8700:
    txa
    pha
    ldy #$FF
    and #$03
    bne B07_870B
    ldy $608C
; control flow target (from $8706)
B07_870B:
    ldx $608B
    tya
    sta $0559,X ; NPC #$03 sprite ID

; call to code in a different bank ($0F:$FF8A)
    jsr $FF8A
; call to code in a different bank ($0F:$C1DC)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    pla
    tax
    dex
    bpl B07_8700
    pla
    rts

; control flow target (from $86CE, $86D5)
    lda $608F,Y
    dec $6D
    bpl B07_8728
    lda #$64
; control flow target (from $8724)
B07_8728:
    rts

; control flow target (from $82D4, $82F7, $8465, $85C3)
    sta $608E
    asl
    tax
    lda $87B0,X
    sta $55 ; pointer to start of sub pointer data, low byte

    lda $87B1,X
    sta $56 ; pointer to start of sub pointer data, high byte

    lda #$00
    sta $608D
; control flow target (from $876F)
B07_873D:
    ldy $608D
    lda ($55),Y ; pointer to start of sub pointer data, low byte

    cmp #$FF
    beq B07_8771
    pha
    and #$C0
    lsr
    lsr
    lsr
    lsr
    lsr
    sta $608B
    pla
    and #$3F
    sta $608C
; control flow target (from $876A)
B07_8757:
    ldx $608B
    lda $8796,X
    sta $6D
    lda $8797,X
    sta $6E
    jsr $877A
    dec $608C
    bne B07_8757
    inc $608D
    bne B07_873D
; control flow target (from $8744)
B07_8771:
    jsr $8781
    bcs B07_8779
; call to code in a different bank ($0F:$FF84)
    jsr $FF84
; control flow target (from $8774)
B07_8779:
    rts

; control flow target (from $8764)
    lda #$00
    sta $03 ; game clock?

    jmp ($006D)

; control flow target (from $8771)
    ldx #$00
; control flow target (from $8793)
B07_8783:
    lda $0540,X ; NPC #$00 ? + direction nybble

    and #$F0
    cmp #$20
    clc
    beq B07_8795
    txa
    adc #$08
    tax
    cpx #$B8
    bcc B07_8783
; control flow target (from $878B)
B07_8795:
    rts


; code -> data
; indexed data load target (from $875A)
; indexed data load target (from $875F)
.byte $78
; indexed data load target (from $8418, $8437)
.byte $FF,$6C,$FF,$7E
.byte $FF,$72
.byte $FF
; indexed data load target (from $8421, $8440)
.byte $0B,$0B,$0E
.byte $0C,$0A
.byte $0F
; indexed data load target (from $8427, $8446)
.byte $02
; indexed data load target (from $872E)
.byte $12,$02,$12,$0E,$09,$09
.byte $11,$03,$09
.byte $10
.byte $11
; indexed data load target (from $8733)
.byte $BA
; indirect data load target (via $87B0)
.byte $87,$BF,$87,$C1,$87
.byte $C5,$87
.byte $C7
.byte $87
; indirect data load target
.byte $82
; indirect data load target
.byte $42
; indirect data load target
.byte $82
; indirect data load target
.byte $41
; indirect data load target (via $87B2)
.byte $FF
; indirect data load target
.byte $C1
; indirect data load target (via $87B4)
.byte $FF
; indirect data load target
.byte $0A
; indirect data load target
.byte $47
; indirect data load target
.byte $8C
; indirect data load target (via $87B6)
.byte $FF
; indirect data load target (via $87B8)
.byte $83
.byte $FF
; indirect data load target
.byte $01
; data load target (from $865A)
.byte $FF
; data load target (from $865F)
.byte $CB
; indirect data load target (via $87C9)
.byte $87
; indirect data load target
.byte $0F
; indirect data load target
.byte $10
; indirect data load target
.byte $01
; indirect data load target
.byte $11
; indirect data load target
.byte $05
; indirect data load target
.byte $27
; indirect data load target
.byte $06
; indirect data load target
.byte $05
; indirect data load target
.byte $1B
; indirect data load target
.byte $0B
; indirect data load target
.byte $19
; indirect data load target
.byte $0A

.byte $17
; data -> code
; if $8F-$90 == #$0001, print "s" + [end-FA] to $60F1 and SEC, else LDA [end-FA] and CLC
; from $02:$BE37 via $8006
; indirect control flow target (via $8006)
    lda $90 ; if $90 > 0, add "s"

    bne B07_87E1
    ldy $8F
    dey
    beq B07_87ED ; if $90 == 0 and $8F - 1 == 0 (i.e. $8F == 1), do not add "s"

; control flow target (from $87DA)
B07_87E1:
    lda #$1C ; "s"

    sta $60F1 ; start of text variable buffer

    lda #$FA ; [end-FA]

    sta $60F2
    sec ; SEC to trigger read of [end-FA]-terminated string from $60F1, CLC to use A

    rts

; BUG: LDA #$FA triggers premature end of string, resulting in "1 piece" instead of "1 piece of gold"
; should write #$FA to $60F1 and SEC instead
; control flow target (from $87DF)
B07_87ED:
    lda #$FA ; [end-FA]

    clc ; SEC to trigger read of [end-FA]-terminated string from $60F1, CLC to use A

    rts

; given monster count in $8F singular monster name in $6119, and monster name length in X, print appropriate singluar/plural monster name to $60F1
; from $02:$BE2F via $8004
; starts reading the monster name backwards from the end of the string and applies the first applicable transformation
; -ch     -> -ches
; -dead   -> -dead (i.e. no change)
; -f      -> -ves (but no monster has a name that ends in f, so this rule is never used)
; -i      -> -ies
; -Man    -> -Men
; -man    -> -men
; -Mouse  -> -Mice
; -mouse  -> -mice
; -ngo    -> -ngo (i.e. no change)
; -rus    -> -rii
; -s      -> -ses
; -sh     -> -shes
; -y      -> -ies
; -       -> -s (everything else)
;
; IN:
; A/X/Y/C: irrelevant, they all get potentially clobbered
; $6119-????: singular monster name terminated by [end-FA]
; OUT:
; A/X/Y: unreliable
; C: set
; indirect control flow target (via $8004)
; call to code in a different bank ($0F:$FE97)
    jsr $FE97 ; read byte following JSR, parse it for bank and pointer index, execute ($8000,X) in selected bank, swap back in original bank


; code -> data
; indirect data load target

.byte $4B
; data -> code
; at this point, X points to next byte in monster name stored starting at $60F1, i.e. the byte after the end token
    ldy $8F ; number of monsters in the current group

    dey
    beq B07_8830 ; if only 1 monster, then no need to pluralize, so we're done

    dex ; back up to [end-FA]

    dex ; back up to final letter of monster name

    lda $60F1,X ; start of text variable buffer; read final letter of monster name

    cmp #$18 ; "o"

    beq B07_8835 ; -ngo -> -ngo, -o -> -os

    cmp #$0F ; "f"

    beq B07_8865 ; -f -> -ves (not used)

    cmp #$22 ; "y"

    beq B07_886A ; -y -> -ies

    cmp #$12 ; "i"

    beq B07_886A ; -i -> -ies

    cmp #$1C ; "s"

    beq B07_8845 ; -rus -> -rii, -s -> -ses

    cmp #$11 ; "h"

    beq B07_8872 ; -ch -> -ches, -sh -> -shes, -h -> -hs

    cmp #$17 ; "n"

    beq B07_887F ; -man -> -men, -Man -> -Men, -n -> -ns

    cmp #$0E ; "e"

    beq B07_8898 ; -mouse -> -mice, -Mouse -> -Mice, -e -> es

    cmp #$0D ; "d"

    beq B07_8832 ; -dead -> -dead, -d -> -ds

; append "s" to monster name
; default pluralization if not handled above
; control flow target (from $883A, $8841, $8863, $887D, $8884, $888F, $889D, $88E1)
B07_8823:
    inx
    lda #$1C ; "s"

    sta $60F1,X ; start of text variable buffer; append "s" to monster name

    inx
    lda #$FA ; [end-FA]

    sta $60F1,X ; start of text variable buffer; append [end-FA] to monster name

    inx
; control flow target (from $87F8, $8843)
B07_8830:
    sec ; SEC to trigger read of [end-FA]-terminated string from $60F1, CLC to use A

    rts

; jump to -d pluralization handler: -dead -> -dead, -d -> -ds
; control flow target (from $8821)
B07_8832:
    jmp $88CC

; -o pluralization handler: -ngo -> -ngo, -o -> -os
; control flow target (from $8801)
B07_8835:
    lda $60F0,X ; read second-last letter of monster name

    cmp #$10 ; "g"

    bne B07_8823 ; if not -go, append "s"

    lda $60EF,X ; read third-last letter of monster name

    cmp #$17 ; "n"

    bne B07_8823 ; if not -ngo, append "s"

    beq B07_8830 ; if -ngo, plural = singular

; -s pluralization handler: -rus -> -rii, -s -> -ses
; control flow target (from $8811)
B07_8845:
    lda $60F0,X ; read second-last letter of monster name

    cmp #$1E ; "u"

    bne B07_885D ; if not -us, append "es"

    lda $60EF,X ; read third-last letter of monster name

    cmp #$1B ; "r"

    bne B07_885D ; if not -rus, append "es"

    lda #$12 ; "i"

    sta $60F0,X ; replace -us with -ii

    sta $60F1,X ; start of text variable buffer

    sec ; SEC to trigger read of [end-FA]-terminated string from $60F1, CLC to use A

    rts

; append "es" to monster name
; control flow target (from $884A, $8851, $886F, $8877, $887B)
B07_885D:
    inx
    lda #$0E ; "e"

    sta $60F1,X ; start of text variable buffer; append "e" to monster name

    bne B07_8823 ; append "s" to monster name; note that this branch is always taken

; -f pluralization handler: -f -> -ves
; unused code
; control flow target (from $8805)
B07_8865:
    lda #$1F ; "v"

    jmp $886C ; replace "f" with "v" then append "es"


; -i pluralization handler: -i -> -ies
; control flow target (from $8809, $880D)
B07_886A:
    lda #$12 ; "i"

; control flow target (from $8867)
    sta $60F1,X ; start of text variable buffer; replace final letter with "i"

    jmp $885D ; append "es"


; -h pluralization handler: -ch -> -ches, -sh -> -shes, -h -> -hs
; control flow target (from $8815)
B07_8872:
    lda $60F0,X ; read second-last letter of monster name

    cmp #$0C ; "c"

    beq B07_885D ; if -ch, append "es"

    cmp #$1C ; "s"

    beq B07_885D ; if -sh, append "es"

    bne B07_8823 ; else, append "s"

; -n pluralization handler: -man -> -men, -Man -> -Men, -n -> -ns
; control flow target (from $8819)
B07_887F:
    lda $60F0,X ; read second-last letter of monster name

    cmp #$0A ; "a"

    bne B07_8823 ; if not -an, append "s"

    lda $60EF,X ; read third-last letter of monster name

    cmp #$16 ; "m"

    beq B07_8891 ; -man -> -men

    cmp #$30 ; "M"

    bne B07_8823 ; if not -Man, append "s"

; control flow target (from $888B)
B07_8891:
    lda #$0E ; "e"

    sta $60F0,X ; replace second-last letter of monster name

; control flow target (from $88DF)
B07_8896:
    sec ; SEC to trigger read of [end-FA]-terminated string from $60F1, CLC to use A

    rts

; -e pluralization handler: -mouse -> -mice, -Mouse -> -Mice, -e -> es
; control flow target (from $881D)
B07_8898:
    lda $60F0,X ; read second-last letter of monster name

    cmp #$1C ; "s"

    bne B07_8823 ; if not -se, append "s"

    lda $60EF,X ; read third-last letter of monster name

    cmp #$1E ; "u"

    bne B07_88E1 ; if not -use, append "s"

    lda $60EE,X ; read fourth-last letter of monster name

    cmp #$18 ; "o"

    bne B07_88E1 ; if not -ouse, append "s"

    lda $60ED,X ; read fifth-last letter of monster name

    cmp #$16 ; "m"

    beq B07_88B8 ; -mouse -> -mice

    cmp #$30 ; "M"

    bne B07_88E1 ; if not -Mouse, append "s"

; control flow target (from $88B2)
B07_88B8:
    ldy #$00 ; replace last 4 letters of monster name with "ice" + [end-FA]

; control flow target (from $88C4)
B07_88BA:
    lda $88C8,Y
    sta $60EE,X
    inx
    iny
    cpy #$04
    bcc B07_88BA
    sec ; SEC to trigger read of [end-FA]-terminated string from $60F1, CLC to use A

    rts


; code -> data
; indexed data load target (from $88BA)

.byte $12,$0C
.byte $0E
.byte $FA
; data -> code
; -d pluralization handler: -dead -> -dead, -d -> ds
; control flow target (from $8832)
    lda $60F0,X ; read second-last letter of monster name

    cmp #$0A ; "a"

    bne B07_88E1 ; if not -ad, append "s"

    lda $60EF,X ; read third-last letter of monster name

    cmp #$0E ; "e"

    bne B07_88E1 ; if not -ead, append "s"

    lda $60EE,X ; read fourth-last letter of monster name

    cmp #$0D ; "d"

    beq B07_8896 ; if -dead, plural = singular

; control flow target (from $88A4, $88AB, $88B6, $88D1, $88D8)
B07_88E1:
    jmp $8823 ; else, append "s"


; control flow target (from $81D3)
    pha
    lda $0C
    pha
    lda $0D
    pha
    lda $0E
    pha
    lda $0F
    pha
    lda $10
    pha
    lda $11
    pha
    lda $608B
    pha
    lda $608C
    pha
; call to code in a different bank ($0F:$C42A)
    jsr $C42A
; call to code in a different bank ($0F:$C446)
    jsr $C446 ; turn screen off, write $800 [space] tiles to PPU $2000, turn screen on

; call to code in a different bank ($0F:$C465)
    jsr $C465 ; wait for interrupt and then set every 4th byte of $0200 - $02FC to #$F0

; call to code in a different bank ($0F:$C1DC)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

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
    jsr $8A64
    lda $8AA1 ; -> $07:$8AB2: Prologue text

    sta $77
    lda $8AA2
    sta $78
    lda #$00
    sta $76
    lda #$10
    sta $75
    lda #$1E
    sta $608C
; control flow target (from $8960)
B07_893E:
    ldy #$00
    lda ($77),Y
    bpl B07_8967
    cmp #$FF
    bne B07_894B
    jmp $89BD

; control flow target (from $8946)
B07_894B:
    pha
    and #$C0
    cmp #$C0
    bne B07_8956
    lda #$08
    sta $75
; control flow target (from $8950)
B07_8956:
    pla
    and #$1F
    sta $76
    jsr $89EE
; control flow target (from $89BA)
    lda $76
    beq B07_893E
    dec $76
    jmp $8989

; control flow target (from $8942)
B07_8967:
    sta $608B
    jsr $89EE
; control flow target (from $8983)
    ldy #$00
    lda ($77),Y
    cmp #$FF
    beq B07_8986
    sta $09
    jsr $89F5
; call to code in a different bank ($0F:$C1FA)
    jsr $C1FA ; wait for $02 to not be #$C0, write PPU address in $07-$08 and data in $09 to PPU write buffer at $0300,$02, $01 += 1, $02 += 3, and set $0183 to #$00

    inc $608B
    jsr $89EE
    jmp $896D

; control flow target (from $8973)
B07_8986:
    jsr $89EE
; control flow target (from $8964)
    lda $75
    sta $6F
; control flow target (from $89B7)
    ldx #$03
; call to code in a different bank ($0F:$C1EE)
    jsr $C1EE ; set $6007 = #$00, set $00 = #$01, wait for X interrupts, set $00 = #$FF

    inc $06
    lda $06
    cmp #$F0
    bcc B07_89A4
    lda #$00
    sta $06
    lda $04
    eor #$08
    sta $04
; control flow target (from $8998)
B07_89A4:
    lda $06
    and #$07
    bne B07_89B3
    ldy #$3B
    lda #$5F
    sta $6D
    jsr $8A79
; control flow target (from $89A8)
B07_89B3:
    dec $6F
    beq B07_89BA
    jmp $898D

; control flow target (from $89B5)
B07_89BA:
    jmp $895E

; control flow target (from $8948)
; call to code in a different bank ($0F:$C1DC)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    lda #$0E
; call to code in a different bank ($0F:$C61F)
    jsr $C61F ; set MMC control mode based on A

    lda #$88
    sta $61AE
    lda #$89
    sta $61AF
; call to code in a different bank ($0F:$C1DC)
    jsr $C1DC ; set $6007 = #$00, set $00 = #$01, wait for interrupt, set $00 = #$FF

    pla
    sta $608C
    pla
    sta $608B
    pla
    sta $11
    pla
    sta $10
    pla
    sta $0F
    pla
    sta $0E
    pla
    sta $0D
    pla
    sta $0C
    pla
    rts

; control flow target (from $895B, $896A, $8980, $8986)
    inc $77
    bne B07_89F4
    inc $78
; control flow target (from $89F0)
B07_89F4:
    rts

; control flow target (from $8977, $8A8D)
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
    bcc B07_8A0C
    sbc #$20
; control flow target (from $8A08)
B07_8A0C:
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
    bcc B07_8A26
    inc $6E
; control flow target (from $8A22)
B07_8A26:
    sec
    sbc #$F0
    sta $6D
    lda $6E
    sbc #$00
    sta $6E
    bcc B07_8A4E
    lda $6D
    sec
    sbc #$F0
    tay
    lda $6E
    sbc #$00
    bcs B07_8A4A
    lda $08
    eor #$08
    sta $08
    lda $6D
    jmp $8A4F

; control flow target (from $8A3D)
B07_8A4A:
    tya
    jmp $8A4F

; control flow target (from $8A31)
B07_8A4E:
    txa
; control flow target (from $8A47, $8A4B)
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

; control flow target (from $8924)
    lda $8AA3
    sta $0E
    sta $10
    lda $8AA4
    sta $0F
    sta $11
    lda #$FF
    sta $0D
; call to code in a different bank ($0F:$C2CD)
    jmp $C2CD

; control flow target (from $89B0)
    lda $608C
    pha
    lda $608B
    pha
    sty $608C
    lda #$20
    sta $608B
    lda $6D
    sta $09
; control flow target (from $8A96)
B07_8A8D:
    jsr $89F5
; call to code in a different bank ($0F:$C1FA)
    jsr $C1FA ; wait for $02 to not be #$C0, write PPU address in $07-$08 and data in $09 to PPU write buffer at $0300,$02, $01 += 1, $02 += 3, and set $0183 to #$00

    dec $608B
    bne B07_8A8D
    pla
    sta $608B
    pla
    sta $608C
    rts


; code -> data
; -> $07:$8AB2: Prologue text
; data load target (from $8927)
; data load target (from $892C)
.byte $B2
; data load target (from $8A64)
.byte $8A
; data load target (from $8A6B)
.byte $A5
; indirect data load target (via $8AA3)
.byte $8A
; Prologue text
.byte $0F,$20,$20,$20,$20,$20,$20
.byte $20,$20,$20
.byte $20,$20
.byte $20
; indirect data load target (via $8AA1)

.byte $0C,$33,$35,$32,$2F,$32,$2A,$38,$28,$FF,$82,$05,$30,$0A,$17,$22
.byte $5F,$22,$0E,$0A,$1B,$1C,$5F,$0A,$10,$18,$5F,$0A,$5F,$22,$18,$1E
.byte $17,$10,$FF,$05,$20,$0A,$1B,$1B,$12,$18,$1B,$5F,$20,$11,$18,$5F
.byte $20,$0A,$1C,$5F,$18,$0F,$5F,$1D,$11,$0E,$FF,$07,$15,$12,$17,$0E
.byte $5F,$18,$0F,$5F,$1D,$11,$0E,$5F,$10,$1B,$0E,$0A,$1D,$FF,$04,$28
.byte $1B,$0D,$1B,$12,$0C,$14,$5F,$0C,$0A,$16,$0E,$5F,$1D,$18,$5F,$24
.byte $15,$0E,$0F,$10,$0A,$1B,$0D,$FF,$04,$0A,$17,$0D,$5F,$0D,$0E,$0F
.byte $0E,$0A,$1D,$0E,$0D,$5F,$1D,$11,$0E,$5F,$0D,$1B,$0E,$0A,$0D,$0E
.byte $0D,$FF,$05,$27,$1B,$0A,$10,$18,$17,$15,$18,$1B,$0D,$69,$5F,$1B
.byte $0E,$1C,$1D,$18,$1B,$12,$17,$10,$FF,$07,$19,$0E,$0A,$0C,$0E,$5F
.byte $1D,$18,$5F,$1D,$11,$0E,$5F,$15,$0A,$17,$0D,$6B,$FF,$82,$06,$29
.byte $18,$1B,$5F,$16,$0A,$17,$22,$5F,$10,$0E,$17,$0E,$1B,$0A,$1D,$12
.byte $18,$17,$1C,$FF,$05,$1D,$11,$0E,$5F,$0D,$0E,$1C,$0C,$0E,$17,$0D
.byte $0A,$17,$1D,$1C,$5F,$18,$0F,$5F,$1D,$11,$0A,$1D,$FF,$05,$20,$0A
.byte $1B,$1B,$12,$18,$1B,$5F,$1B,$1E,$15,$0E,$0D,$5F,$24,$15,$0E,$0F
.byte $10,$0A,$1B,$0D,$FF,$06,$0A,$17,$0D,$5F,$1D,$11,$0E,$5F,$1C,$1E
.byte $1B,$1B,$18,$1E,$17,$0D,$12,$17,$10,$FF,$06,$15,$0A,$17,$0D,$1C
.byte $69,$5F,$12,$17,$0C,$15,$1E,$0D,$12,$17,$10,$5F,$1D,$11,$0E,$FF
.byte $05,$2E,$12,$17,$10,$0D,$18,$16,$5F,$18,$0F,$5F,$30,$18,$18,$17
.byte $0B,$1B,$18,$18,$14,$0E,$FF,$05,$0A,$0C,$1B,$18,$1C,$1C,$5F,$1D
.byte $11,$0E,$5F,$0E,$0A,$1C,$1D,$0E,$1B,$17,$5F,$1C,$0E,$0A,$FF,$09
.byte $0F,$1B,$18,$16,$5F,$24,$15,$0E,$0F
.byte $10,$0A,$1B,$0D
.byte $6B,$FF
.byte $8F
.byte $FF
; data -> free
.res $13ea
; ... skipping $13EA FF bytes
.byte $FF

.byte $FF
; free -> data

.byte $FF
; data -> free
.res $1fd6
; ... skipping $1FD6 FF bytes
.byte $FF

.byte $FF
; free -> unknown

.byte $78,$EE,$DF,$BF,$4C,$86,$FF,$80
.literal "DRAGON WARRIORS2"
.byte $D5,$BB,$00,$00,$48,$04,$01,$0F
.byte $07,$9D,$D8,$BF,$D8,$BF,$D8,$BF

