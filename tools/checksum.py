from hashlib import md5

rebuilt_rom = "dq2_rebuilt.nes"
hash_us = "3188792f0e6baee937a9859542c8c155"
hash_jp = "x"

if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser(description="Configure the project")
    parser.add_argument(
        "-j",
        "--japanese",
        help="Check the checksum of a japanese built rom",
        action="store_true",
    )

    #here because it passes the same args as build.py
    parser.add_argument(
        "-kf",
        "--kanafix",
        help="Build using the macro for japanese kana",
        action="store_true",
    )

    args = parser.parse_args()

    hash1 = hash_us #us hash
    if args.japanese:
        hash1 = hash_jp #jp hash

    with open(rebuilt_rom, "rb") as f:
        rebuilt_hash = md5(f.read()).hexdigest()
    if rebuilt_hash == hash1:
        print("OK")
        exit()
    #if no match
    raise Exception("Hashes do not match")