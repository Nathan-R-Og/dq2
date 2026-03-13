import subprocess
import os
from glob import glob
import argparse
import shutil
import time

DEFINES = ""
output = "dq2_rebuilt.nes"

def addDefine(define):
    global DEFINES
    DEFINES += f" -D{define}=1"
    DEFINES = DEFINES.strip()

if __name__ == "__main__":
    #pre cleanup
    if os.path.exists(output):
        os.remove(output)

    start_time = time.time()
    parser = argparse.ArgumentParser(description="Configure the project")
    parser.add_argument(
        "-j",
        "--japanese",
        help="Build japanese only assets",
        action="store_true",
    )

    DEFINES = ""

    args = parser.parse_args()

    if os.path.exists("build_artifacts/"):
        shutil.rmtree("build_artifacts/")

    dir = "us"
    if args.japanese:
        dir = "jp"
        addDefine("VER_JP")

    if not os.path.exists(f"split/{dir}"):
        raise Exception(
            f"ERROR: could not find split/{dir} - this likely means assets were\n"
            "not extracted correctly with configure.py")

    linker = "linker.cfg"
    if args.japanese:
        linker = "linker-j.cfg"

    subprocess.run(f"ca65 {DEFINES} -o example.o -g src/{dir}/main.asm -t nes -g".strip(), shell = True)
    subprocess.run(f"ld65 -Ln linked.txt -C {linker} -o {output} --dbgfile linked_m.dbg example.o", shell = True)

    resultTime = (time.time() - start_time)
    print(f"Assembly took {resultTime} seconds!")

    #post cleanup
    if os.path.exists(output):
        print(f"rom made!")
    else:
        print(f"ERR!")
        #fail cleanup
        os.remove(f"{output}.deb")

    os.remove("example.o")
