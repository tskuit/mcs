#!/bin/bash
## ./$1 [cd] [rl]

if [[ ! $1 =~ ^[cd]$ ]]; then echo wrong input; exit; fi
if [[ ! $2 =~ ^[rl]$ ]]; then echo wrong input; exit; fi

nibble=0
if [[ ${1} == "d" ]]; then nibble=$(($nibble+8)); fi
if [[ ${2} == "r" ]]; then nibble=$(($nibble+4)); fi
nibble=$(printf '%x' "$nibble")

i2c_addr="0x27"
i2c_bus="1"

## [7  6  5  4  3  2  1  0 ]
## [D7 D6 D5 D4 BL -E RW RS]

### Instruction: Cursor or Display Shift
## [D7 D6 D5 D4  D3  D2  D1 D0 RS RW]
##   0  0  0  1 S/C  R/L  X  X  0  0
##   S/C - line/1-line	[1/0] -- Shift display / move Cursor
##   R/L - 8-bit/4-bit	[1/0] -- Right / Left

##   0001 01** 00

## b0001 1100		0x1C
i2cset -y ${i2c_bus} ${i2c_addr} "0x1C"
sleep 0.1
## b0001 1000		0x1A
i2cset -y ${i2c_bus} ${i2c_addr} "0x1A"
sleep 0.1

## b0100 1100		0x4C
i2cset -y ${i2c_bus} ${i2c_addr} "0x${nibble}C"
sleep 0.1
## b0100 1000		0x4A
i2cset -y ${i2c_bus} ${i2c_addr} "0x${nibble}A"
sleep 0.1

