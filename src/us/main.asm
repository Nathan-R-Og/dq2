.setcpu "6502"

.include "../global/hardware.asm"
.include "../global/ram.asm"
.include "fontmap.asm"
.include "../global/macros.asm"

.include "../global/header.asm"

.include "prg/bank0.asm"
.include "prg/bank1.asm"
.include "prg/bank2.asm"
.include "prg/bank3.asm"
.include "prg/bank4.asm"
.include "prg/bank5.asm"
.include "prg/bank6.asm"
.include "prg/bank7.asm"
.include "prg/bank8.asm"
.include "prg/bank9.asm"
.include "prg/banka.asm"
.include "prg/bankb.asm"
.segment "PRGC":absolute
.segment "PRGD":absolute
.segment "PRGE":absolute
.include "prg/constant.asm"
