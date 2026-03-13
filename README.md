# Dragon Quest II

Disassembly of Dragon Quest II/Dragon Warrior II

Based off of the dissassembly found [here](https://datacrystal.tcrf.net/wiki/Dragon_Warrior_II_(NES)/ROM_map/ASM).

Supports the English localization of Dragon Quest II, with compatibility on the table.

For WSL2 Ubuntu. Probably also works on actual Linux.

Also works natively on Windows.

## Supported Hashes

| Game Version                       | MD5                              |
|------------------------------------|----------------------------------|
| Dragon Warrior II (US) (NES 2.0)   |`3188792f0e6baee937a9859542c8c155`|
| Dragon Warrior II (US) (iNES)      |`3aef63a01d6f57e3bf2c865a1d919d13`|

Headers may be different, making hashes fail. Check your header in a hex viewer against `src/global/header.asm` to see if your ROM is good or not.

Automatically outputs ROM as NES 2.0.

## Instructions

Note that if you are running on Windows, when it asks you to run a script, run the `.ps1` script of the same name instead.

1. Install python
  - Chances are you already have it installed if you are bothering with this repo.
  - On Linux, `./install` will add python for you.
  - On Windows, install python and make sure it is added to your system `PATH` under `Environment Variables`.
2. Obtain cc65
  - If running on a supported Linux distribution, run `./install` to download and set up cc65.
  - If running on another platform (ex. Windows), it can be obtained from https://cc65.github.io/.
  - If cc65 was not built from source, add the bin folder to your system `PATH` under `Environment Variables`. (like python)
2. Drop MOTHER (J) and/or Earthbound Beginnings (U) ROMs into this directory.
3. Run `./configure` to split banks from supported roms
  - Each rom will be scanned for in the root of this repository, and will split their own unique assets.
4. Run `./build` to make a new Earthbound Beginnings (U) ROM from assembly
  - Note that the output path will be `mother_rebuilt.nes`
5. Run `./build -j` to make a new MOTHER (J) rom

The newly built rom will be compared to the destination version's checksum, to see if it is byte matching. Make sure both US and JP are byte matching before opening a PR!

If you wish to make your own ROM Hack, simply remove all calls to `tools/checksum.py` as well as the file itself. Fork and enjoy!
