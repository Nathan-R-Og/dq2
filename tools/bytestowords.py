lines = """
.byte $CD,$8E	 ; $06:$8ECD; handler for dialogue ID #$9D: King in Map ID #$02: Midenhall 2F
.byte $6A,$8F	 ; $06:$8F6A; handler for dialogue ID #$9E: Guard in Map ID #$02: Midenhall 2F
.byte $85,$8F	 ; $06:$8F85; handler for dialogue ID #$9F: Wizard in Map ID #$02: Midenhall 2F
.byte $AC,$8F	 ; $06:$8FAC; handler for dialogue ID #$A0: Brute in Map ID #$04: Midenhall B1
.byte $CC,$8F	 ; $06:$8FCC; handler for dialogue ID #$A1: King in Map ID #$06: Cannock
.byte $19,$90	 ; $06:$9019; handler for dialogue ID #$A2: Princess Halla in Map ID #$06: Cannock
.byte $55,$90	 ; $06:$9055; handler for dialogue ID #$A3: Wizard in Map ID #$06: Cannock
.byte $65,$90	 ; $06:$9065; handler for dialogue ID #$A4-#$A5: Monsters in Map ID #$08: Hamlin Waterway
.byte $65,$90	 ; $06:$9065; handler for dialogue ID #$A4-#$A5: Monsters in Map ID #$08: Hamlin Waterway
.byte $77,$90	 ; $06:$9077; handler for dialogue ID #$A6: King Moonbrooke's Flame in Map ID #$09: Moonbrooke
.byte $95,$90	 ; $06:$9095; handler for dialogue ID #$A7: Guard in Map ID #$0A: Moonbrooke B1
.byte $A8,$90	 ; $06:$90A8; handler for dialogue ID #$A8: Wizard in Map ID #$0B: Lianport
.byte $CC,$90	 ; $06:$90CC; handler for dialogue ID #$A9: Echoing Flute guy in NE in Map ID #$0B: Lianport
.byte $EF,$90	 ; $06:$90EF; handler for dialogue ID #$AA: Woman in Map ID #$0B: Lianport
.byte $02,$91	 ; $06:$9102; handler for dialogue ID #$AB: Brute in Map ID #$0B: Lianport
.byte $12,$91	 ; $06:$9112; handler for dialogue ID #$AC: Woman in SW corner of Map ID #$0B: Lianport
.byte $4D,$91	 ; $06:$914D; handler for dialogue ID #$AD: Wizard in Map ID #$0C: Tantegel
.byte $6E,$91	 ; $06:$916E; handler for dialogue ID #$AE: Wizard in Map ID #$0C: Tantegel
.byte $7B,$91	 ; $06:$917B; handler for dialogue ID #$AF: Priest in Map ID #$0C: Tantegel
.byte $97,$91	 ; $06:$9197; handler for dialogue ID #$B0: King in Map ID #$0F: Osterfair
.byte $13,$92	 ; $06:$9213; handler for dialogue ID #$B1: crazy fortuneteller Wizard in NW Map ID #$0F: Osterfair
.byte $8B,$92	 ; $06:$928B; handler for dialogue IDs #$B2-#$B3: Dog in Map ID #$0F: Osterfair
.byte $8B,$92	 ; $06:$928B; handler for dialogue IDs #$B2-#$B3: Dog in Map ID #$0F: Osterfair
.byte $92,$92	 ; $06:$9292; handler for dialogue ID #$B4: Dog in Map ID #$10: Zahan
.byte $99,$92	 ; $06:$9299; handler for dialogue ID #$B5: Don Mahone in Map ID #$11: Tuhn
.byte $FE,$92	 ; $06:$92FE; handler for dialogue ID #$B6: Roge Fastfinger in NE Map ID #$14: Wellgarth Underground
.byte $2C,$93	 ; $06:$932C; handler for dialogue IDs #$B7-#$B9: Priest in Map ID #$15: Beran
.byte $2C,$93	 ; $06:$932C; handler for dialogue IDs #$B7-#$B9: Priest in Map ID #$15: Beran
.byte $2C,$93	 ; $06:$932C; handler for dialogue IDs #$B7-#$B9: Priest in Map ID #$15: Beran
.byte $3E,$93	 ; $06:$933E; handler for dialogue ID #$BA: Monster in Map ID #$16: Hargon's Castle 1F
.byte $48,$93	 ; $06:$9348; handler for dialogue ID #$BB: Hargon in Map ID #$17: Hargon's Castle 7F
.byte $7F,$93	 ; $06:$937F; handler for dialogue ID #$BC: Dragonlord's Grandson in Map ID #$18: Charlock Castle B8
.byte $9B,$93	 ; $06:$939B; handler for dialogue ID #$BD: Guard in Map ID #$1A: Shrine SW of Cannock
.byte $9F,$93	 ; $06:$939F; handler for dialogue ID #$BE: Guard in Map ID #$1A: Shrine SW of Cannock
.byte $BE,$93	 ; $06:$93BE; handler for dialogue ID #$BF: Wizard in Map ID #$1C: Shrine SE of Rimuldar
.byte $E1,$93	 ; $06:$93E1; handler for dialogue ID #$C0: Wizard in Map ID #$15: Beran
.byte $00,$94	 ; $06:$9400; handler for dialogue ID #$C1: Priest in Map ID #$1F: Rhone Shrine
.byte $4D,$94	 ; $06:$944D; handler for dialogue ID #$C2: Priest in Map ID #$20: Shrine SW of Moonbrooke

"""

lines = lines.strip().split("\n")

i = 0
while i < len(lines):
    line = lines[i]
    if line.startswith(";") or not line.startswith(".byte"):
        i += 1
        continue

    args = line.split(";")[0].split(",")
    byte1 = args[0].split(" ")[-1].replace("$", "")
    byte2 = args[1].strip().replace("$", "")
    toreplace = f".byte ${byte1},${byte2}"
    lines[i] = line.replace(toreplace, f".addr ${byte2}{byte1}")

    i += 1

for line in lines:
    print(line)