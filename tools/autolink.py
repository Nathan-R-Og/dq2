l = open("src/global/prg/title.asm", "r").readlines()

opcodes = {
    "jsr": "cpu_addr",
    "jmp": "cpu_addr",
    "and": "ram_addr",
    "lda": "ram_addr",
    "dec": "ram_addr",
    "lda": "ram_addr",
    "sta": "ram_addr",
    "ldx": "ram_addr",
    "ldy": "ram_addr",
    "sty": "ram_addr",
    "stx": "ram_addr",
    "eor": "ram_addr",
    "sbc": "ram_addr",
    "adc": "ram_addr",
}

addrs = []

i = 0
while i < len(l):
    line = l[i].strip()
    if line.find(";") != -1:
        line = line.split(";")[0]

    found = False
    if line.find("$") != -1 and line.find("#") == -1:
        for opcode in list(opcodes.keys()):
            if line.startswith(opcode):
                get = line
                if line.find(";") != -1:
                    get = line.split(";")[0]
                if get.find("$") == -1:
                    break

                if opcode != "MOV":
                    if get.find(",") != -1:
                        get = get.split(",")[0]
                    if get.find("#") != -1:
                        break

                    get = get.split("$")[1]
                else:
                    get = get.split(" ", 1)[1].strip()
                    if get.find(",") != -1:
                        get = get.split(",")
                        for e in get:
                            if e.find("#") != -1:
                                continue
                            if e.find("$") !=- 1:
                                get = e
                    if type(get) == list:
                        break
                    get = get.replace("$", "")

                if get.find(" ") != -1:
                    get = get.split(" ")[0]
                if get.find(")") != -1:
                    get = get.split(")")[0]
                get = get.strip()

                get_int = int(get, 16)
                get = "$"+get


                if opcodes[opcode] == "ram_addr":
                    if get_int in list(symbols.keys()):
                        get_symbol = symbols[get_int]
                        l[i] = l[i].replace(get, get_symbol)
                elif opcodes[opcode] == "cpu_addr":
                    if get_int in list(cpu.keys()):
                        get_symbol = cpu[get_int]
                        l[i] = l[i].replace(get, get_symbol)

                if get_int == 0xde4b:
                    print(l[i])

                found = True
                break
    if found:
        i += 1
        continue

    i += 1

out_lines = []
for addr in addrs:
    if type(addr) == int:
        out_lines.append(hex(addr)+"\n")
    else:
        out_lines.append(addr+" ; {}\n")


open("mesen_test.asm", "w").writelines(l)