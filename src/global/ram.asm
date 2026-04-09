.feature force_range

.segment        "ZP": zeropage
; zeropage global variables
UNK_0: .res $16
map_xpos: .res 1 ; $16
map_ypos: .res 1 ; $17
UNK_18: .res $f
UNK_27: .res 1 ;Room ID?
UNK_28: .res 7
UNK_2f: .res 1 ;Input
; B0: A
; B1: B
; B2: Select
; B3: Start
; B4: Up
; B5: Down
; B6: Left
; B7: Right
UNK_30: .res 1
map_id: .res 1 ; $31 / True Room ID
; 00: Initial Menu;
; 01: Overworld;
; 02: Midenhall throne room;
; 03: Midenhall hall;
; 04: Midenhall prision;
; 06: Cannock Castle;
; 08: Hamlim basement;
; 09: Moonbrooke Castle;
; 0a: Moonbrooke Castle basement;
; 0b: Lianport;
; 0d: Tantegel Inn;
; 0f: Ostefair Castle;
; 10: Zahan;
; 11: Tuhn;
; 12: Tuhn Floodgate;
; 14: Wellgarth;
; 17: Hargon Castle top floor;
; 18: Charlock Castle throne room;
; 1c: Holy Monolith;
; 1e: Fire Shrine;
; 29: Rubiss Shrine;
; 2d: Silver Cave;
; 33: Malroth Cave bottom;
; 34: Charlook Castle sword floor;
; 37: Cave to Rhone (Crest floor);
; 38: Cave to Rhone (1st floor);
; 3c: Cave to Rhone (Thunder Sword);
; 3e: Cave to Rhone (Erdrick Armor);
; 49: Tower of the Moon (Shard floor);
; 51: Lighthouse (Crest floor);
; 59: Eastern Tower (Cape floor);
; 65: South Dragon Horn (top floor);
UNK_32: .res 2 ;RNG Dice

UNK_34: .res $19

UNK_4d: .res 1 ;X Position of SGTLC
; Command Menu = 04
; SGTLC: selectable grid top left corner

UNK_4e: .res 1 ;Y Position of SGTLC
; Command Menu = 02
; SGTLC: selectable grid top left corner

UNK_4f: .res $a

UNK_59: .res 1 ;Menu ID
; 06: Cammand Menu open
; 04: Talk or Search command

UNK_5a: .res $22

UNK_7c: .res 1 ;Current Text Character Position

UNK_7d: .res 5

UNK_82: .res 1 ;Menu Cursor Horizontal Position
UNK_83: .res 1 ;Menu Cursor Vertical Position

UNK_84: .res $a
UNK_8E: .res 1 ; flag for in battle or not (#$FF)?
UNK_8F: .res 5

UNK_94: .res 1 ;Battle Flag
;B1: Outside battle.

UNK_95: .res 1 ;ID of the Name of the Found Item
UNK_96: .res 1 ;ID of the Name of the Acquired Item

UNK_97: .res 1

UNK_98: .res 1 ;outcome of last fight?

UNK_99: .res $31

UNK_ca: .res 1 ;Position in Story

UNK_cb: .res 2

UNK_cd: .res 1 ;Water Cloth Flag
UNK_ce: .res 1 ;Floodgate Flag
UNK_cf: .res 1 ; ship status (#$04 = on ship, #$02 = own ship, #$01 = beat Lianport Gremlins)
UNK_d0: .res 1 ;Malroth Flag
UNK_d1: .res 1 ;Midenhall Prisioner Flag

UNK_d2: .res 4

UNK_D6: .res 2 ;pointer to gfx??
UNK_D8: .res $1a

UNK_F2: .res 2 ; pulse 1 addr
UNK_F4: .res 2 ; pulse 2 addr
UNK_F6: .res 2 ; triangle addr
UNK_F8: .res 2 ; noise addr?

UNK_Fa: .res 6

; *** RAM DEFINES ***
.segment        "RAM": absolute
UNK_100: .res $a0

;UNK_112: .res 1 ;Crests
;1: Sun
;2: Star
;3: Moon
;4: Water
;5: Life

;UNK_113: .res 4 ;Name first half

;yeah
stack: .res $60

;yeah
SHADOW_OAM: .res $100

UNK_300: .res $C0

;current attr
attr_buffer: .res $40

;array of screen to cover sprites with menu
menu_cover: .res $100

UNK_500: .res $300

;UNK_600: .res 8 ;Hero Inventory
;UNK_608: .res 8 ;Prince Inventory
;UNK_610: .res 8 ;Princess Inventory
;UNK_624: .res 2 ;Gold

; 0x062d
; Hero's Status?
; Bit 5 - poison
; Bit 7 - alive
; Bit 2 - in party

; 0x0630
; Hero's Max HP

; 0x0633
; Hero's Experience

; 0x0634
; Hero's Experience x256

; 0x0636
; Hero's Strength

; 0x0637
; Hero's Agility

; 0x0638
; Hero's Attack Power

; 0x0639
; Hero's Defence Power

; 0x063b
; Hero's Current HP

; 0x063d
; Hero's Current MP

; 0x063e
; Hero's Level

; 0x063f
; Prince's Status?

; 0x0642
; Prince's Max HP

; 0x0644
; Prince's Max MP

; 0x0648
; Prince's Strength

; 0x0649
; Prince's Agility

; 0x064a
; Prince's Attack Power

; 0x064b
; Prince's Defence Power

; 0x064d
; Prince's Current HP

; 0x064f
; Prince's Current MP

; 0x0650
; Prince's Level

; 0x0651
; Princess's Status 5=Poison

; 0x0654
; Princess's Max HP

; 0x0656
; Princess's Max MP

; 0x065a
; Princess's Strength

; 0x065b
; Princess's Agility

; 0x065c
; Princess's Attack Power

; 0x065d
; Princess's Defence Power

; 0x065f
; Princess's Current HP

; 0x0661
; Princess's Current MP

; 0x0662
; Princess's Level

.segment "SRAM": absolute
UNK_6000: .res $2000