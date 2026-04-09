lines = open("src/us/prg/bank6.asm", "r").readlines()

addresses = []

opcodes = {
    "jmp": "cpu_addr",
    "jsr": "cpu_addr",
    "lda": "cpu_addr",
    "adc": "cpu_addr",
    "ldy": "cpu_addr",
    "ldx": "cpu_addr",
    "cmp": "cpu_addr",
    ".addr": "cpu_addr",
}

i = 0
while i < len(lines):
    line = lines[i].strip()

    if line.find(";") != -1:
        line = line.split(";")[0]

    if line.find("$") != -1 and line.find("#") == -1:
        for opcode in list(opcodes.keys()):
            if line.startswith(opcode):
                the = line.split("$")[-1]
                if the.find(",") != -1:
                    the = the.split(",")[0]
                the = the.replace(")", "")
                inter = int(the, 16)
                if inter < 0x8000:
                    continue
                if inter in addresses:
                    continue
                addresses.append(inter)

    i += 1

addresses.sort()
addresses.reverse()
for address in addresses:
    print(hex(address))