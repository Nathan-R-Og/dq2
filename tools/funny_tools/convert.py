lines = open("tools/outputs/in_asm.asm", "r").readlines()

outlines = []

i = 0
while i < len(lines):
    line = lines[i]
    if line.startswith(";") or line.strip() == "":
        outlines.append(line)
        i += 1
        continue

    args = line.split("|", 1)
    rom_addr = args[0]
    args = args[1].split(":", 1)
    bank = args[0]
    args = args[1].split(":", 1)
    cpu_addr = args[0]
    args = args[1].split(";", 1)
    data = args[0]
    comment = ""
    if len(args) > 1:
        comment = args[1].strip()

    new_line = ".byte "

    bytes = data.split(" ")
    for byte in bytes:
        new_line += f"${byte},"

    new_line = new_line[:-1]
    if comment:
        new_line += " ; "+comment+"\n"
    else:
        new_line += "\n"

    outlines.append(new_line)


    i += 1

open("tools/outputs/out_asm.asm", "w").writelines(outlines)