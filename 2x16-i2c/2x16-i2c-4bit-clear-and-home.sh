#!/bin/bash
## ./$1 cd|rh ## clear display / return home

if [[ ! $1 =~ ^cd|rh$ ]]; then echo wrong input; exit; fi

nibble=0
if [[ ${1} == "cd" ]]; then nibble=$(($nibble+1)); fi
if [[ ${1} == "rh" ]]; then nibble=$(($nibble+2)); fi
nibble=$(printf '%x' "$nibble")

i2c_addr="0x27"
i2c_bus="1"

## [7  6  5  4  3  2  1  0 ]
## [D7 D6 D5 D4 BL -E RW RS]

### Instruction: Clear Display
## [D7 D6 D5 D4 D3 D2 D1 D0 RS RW]
##   0  0  0  0  0  0  0  1  0  0
##   Write 00H to DDRAM and set DDRAM address to 00H from AC
##
### Instruction: Return Home
## [D7 D6 D5 D4 D3 D2 D1 D0 RS RW]
##   0  0  0  0  0  0  1  *  0  0
##   Set DDRAM address to 00H from AC and return cursor to its original position if shifted. The contents of DDRAM are not changed.

##   0000 00?? 00

## b0000 1100		0x0C
i2cset -y ${i2c_bus} ${i2c_addr} "0x0C"
sleep 0.1
## b0000 1000		0x0A
i2cset -y ${i2c_bus} ${i2c_addr} "0x0A"
sleep 0.1

## b00?? 1100		0x1C | 0x2C
i2cset -y ${i2c_bus} ${i2c_addr} "0x${nibble}C"
sleep 0.1
## b00?? 1000		0x1A | 0x2A
i2cset -y ${i2c_bus} ${i2c_addr} "0x${nibble}A"
sleep 0.1

