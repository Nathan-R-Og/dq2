;this helps us even use quotes in the first place.
;if a better method is found (escapes dont work), deprecate this.
.feature loose_string_term

;numbers
.charmap $30, $00 ;0 == $00
.charmap $31, $01 ;1 == $01
.charmap $32, $02 ;2 == $02
.charmap $33, $03 ;3 == $03
.charmap $34, $04 ;4 == $04
.charmap $35, $05 ;5 == $05
.charmap $36, $06 ;6 == $06
.charmap $37, $07 ;7 == $07
.charmap $38, $08 ;8 == $08
.charmap $39, $09 ;9 == $09


.charmap $61, $0A ;a == $0a
.charmap $62, $0B ;b == $0b
.charmap $63, $0C ;c == $0c
.charmap $64, $0D ;d == $0d
.charmap $65, $0E ;e == $0e
.charmap $66, $0F ;f == $0f
.charmap $67, $10 ;g == $10
.charmap $68, $11 ;h == $11
.charmap $69, $12 ;i == $12
.charmap $6A, $13 ;j == $13
.charmap $6B, $14 ;k == $14
.charmap $6C, $15 ;l == $15
.charmap $6D, $16 ;m == $16
.charmap $6E, $17 ;n == $17
.charmap $6F, $18 ;o == $18
.charmap $70, $19 ;p == $19
.charmap $71, $1A ;q == $1a
.charmap $72, $1B ;r == $1b
.charmap $73, $1C ;s == $1c
.charmap $74, $1D ;t == $1d
.charmap $75, $1E ;u == $1e
.charmap $76, $1F ;v == $1f
.charmap $77, $20 ;w == $20
.charmap $78, $21 ;x == $21
.charmap $79, $22 ;y == $22
.charmap $7A, $23 ;z == $23

.charmap $41, $24 ;A == $24
.charmap $42, $25 ;B == $25
.charmap $43, $26 ;C == $26
.charmap $44, $27 ;D == $27
.charmap $45, $28 ;E == $28
.charmap $46, $29 ;F == $29
.charmap $47, $2A ;G == $2a
.charmap $48, $2B ;H == $2b
.charmap $49, $2C ;I == $2c
.charmap $4A, $2D ;J == $2d
.charmap $4B, $2E ;K == $2e
.charmap $4C, $2F ;L == $2f
.charmap $4D, $30 ;M == $30
.charmap $4E, $31 ;N == $31
.charmap $4F, $32 ;O == $32
.charmap $50, $33 ;P == $33
.charmap $51, $34 ;Q == $34
.charmap $52, $35 ;R == $35
.charmap $53, $36 ;S == $36
.charmap $54, $37 ;T == $37
.charmap $55, $38 ;U == $38
.charmap $56, $39 ;V == $39
.charmap $57, $3A ;W == $3a
.charmap $58, $3B ;X == $3b
.charmap $59, $3C ;Y == $3c
.charmap $5A, $3D ;Z == $3d

;symbols
.charmap $20, $5F ;" " == $A0
.charmap $21, $A1 ;!
.charmap $3F, $A2 ;?
.charmap $23, $A3 ;..
.charmap $24, $A4 ;$
.charmap $25, $A5 ;.
.charmap $22, $A6 ;"
.charmap $27, $67 ;' == $A7
.charmap $28, $A8 ;(
.charmap $29, $A9 ;)
.charmap $3A, $AA ;:
.charmap $2B, $AB ;;
.charmap $2C, $AC ;, == $AC
.charmap $2D, $AD ;-
.charmap $2E, $AE ;. == $AE
.charmap $2F, $AF ;/
.charmap $2A, $C0 ;* == $C0 (is technically ◆, but can't be typed/is too big)
.charmap $3E, $FF ;> == $FF (is technically ▶, but can't be typed/is too big)
;also, > is specifically hardcoded for enemy CHECK listings. otherwise i wouldnt have put it here



;manual defines
.ifndef stopText
;insertion codes
;https://datacrystal.tcrf.net/wiki/EarthBound_Beginnings/TBL#Text_Commands
stopText = 0
newLine = 1
waitThenOverwrite = 2
pauseText = 3
t_nop = 5

.define goto(ta) 4,.LOBYTE(ta),.HIBYTE(ta)
.define set_pos(tx,ty) $20,tx,ty
.define print_string(ta) $21,.LOBYTE(ta),.HIBYTE(ta)
.define repeatTile(ta,tb) $22,ta,tb
.define print_number(ta, tb, tc) $23,.LOBYTE(ta),.HIBYTE(ta),tb,tc

.define price print_number $2A, 2, 0
.define lvFIGinc print_number $58, 1, 0
.define lvSPDinc print_number $59, 1, 0
.define lvWISinc print_number $5A, 1, 0
.define lvSTRinc print_number $5B, 1, 0
.define lvFORinc print_number $5C, 1, 0
.define lvHPPPinc print_number $5D, 1, 0
.define attacker print_string $580
.define beingAttacked print_string $588
.define attackResult print_string $590
.define damageAmount print_number $590, 2, 0
.define defenseStat print_number $592, 2, 0
.define partyLead print_string $670A
.define result print_string $6d00
.define item print_string $6D04
.define user print_string $6D20
.define recipient print_string $6D24
.define currentCash print_number $7412, 3, 0
.define cashDeposit print_number $7415, 3, 0
.define playerName print_string $7420
.define nintenName print_string Ninten_Data+party_info::name
.define lloydName print_string Lloyd_Data+party_info::name
.define anaName print_string Ana_Data+party_info::name
.define teddyName print_string Teddy_Data+party_info::name
.define favFood print_string $7689
.define SMAAAAASH $97,$98,$99,$9A,$9B,$9C,$9D,$9E,$9F ; this isnt a command per se but this is helpful enough


;i cant charmap these :(
music_note = $96 ;
dot_tile = $a5 ;
alpha = $BB ; α
beta  = $BC ; β
gamma = $BD ; γ
pi    = $BE ; π
omega = $BF ; Ω
c00 = $BA ; 00. even if i could i dont know how to do it
arrow = $E0

;top
uibox_tl = $DB
uibox_t = $DC
uibox_tr = $DD
uibox_tc = $FE ;version cut off (save menus and whatnot)

;middle
;(problem area)
uibox_l = $24 ;is actually $DE
uibox_r = $25 ;is actually $DF

;middle
;(For real this time)
uibox_l_r = $DE
uibox_r_r = $DF

;bottom
uibox_bl = $FB
uibox_b = $FC
uibox_br = $FD

radial_empty = $94
radial_filled = $95

.endif

