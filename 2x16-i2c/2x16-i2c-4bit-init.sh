#!/bin/bash

i2c_addr="0x27"
i2c_bus="1"

## [7  6  5  4  3  2  1  0 ]
## [D7 D6 D5 D4 BL -E RW RS]

### Instruction: Function Set 
## b0011 1100		0x3C
i2cset -y ${i2c_bus} ${i2c_addr} "0x3C"
sleep 0.1
## b0011 1000		0x38
i2cset -y ${i2c_bus} ${i2c_addr} "0x38"
sleep 0.1

echo "Function Set: 0011****"

### --- --- --- --- --- ###

### Instruction: Function Set 
## b0011 1100		0x3C
i2cset -y ${i2c_bus} ${i2c_addr} "0x3C"
sleep 0.1
## b0011 1000		0x38
i2cset -y ${i2c_bus} ${i2c_addr} "0x38"
sleep 0.1

echo "Function Set: 0011****"

### --- --- --- --- --- ###

### Instruction: Function Set 
## b0011 1100		0x3C
i2cset -y ${i2c_bus} ${i2c_addr} "0x3C"
sleep 0.1
## b0011 1000		0x38
i2cset -y ${i2c_bus} ${i2c_addr} "0x38"
sleep 0.1

echo "Function Set: 0011****"

### --- --- --- --- --- ###

### Instruction: Function Set 
## [D7 D6 D5 D4 D3 D2 D1 D0 RS RW]
##   0  0  1 DL  N  F  X  X  0  0
##   DL 8-bit/4-bit	[1/0] -- interface data length
##    N 2-line/1-line	[1/0] -- display line
##    F 5x10/5x8	[1/0] -- display font
##
## b0010 1100		0x2C
i2cset -y ${i2c_bus} ${i2c_addr} "0x2C"
sleep 0.1
## b0010 1000		0x28
i2cset -y ${i2c_bus} ${i2c_addr} "0x28"
sleep 0.1

echo "Function Set initialize 4-bit mode: 0010000  || 0 0 1 DL=0 *(N) *(F) * * "

###   --- --- --- --- ---  ###
### 4-bit mode initialized ###
###   --- --- --- --- ---  ###

### Instruction: Display ON/OFF Control (first nibble)
## b0000 1100		0x0C
i2cset -y ${i2c_bus} ${i2c_addr} "0x0C"
sleep 0.1
## b0000 1000		0x08
i2cset -y ${i2c_bus} ${i2c_addr} "0x08"
sleep 0.1
### Instruction: Display ON/OFF Control (second nibble)
## b1111 1100		0xFC		# 1, D(isplay), C(ursor), B(linking)
i2cset -y ${i2c_bus} ${i2c_addr} "0xFC"
sleep 0.1
## b1111 1000		0xF8
i2cset -y ${i2c_bus} ${i2c_addr} "0xF8"
sleep 0.1

echo "Display ON/OFF: 0000 1111  ||  0 0 0 0 1 D C B"

### Instruction: Clear display (first nibble)
## b0000 1100		0x0C
i2cset -y ${i2c_bus} ${i2c_addr} "0x0C"
sleep 0.1
## b0000 1000		0x08
i2cset -y ${i2c_bus} ${i2c_addr} "0x08"
sleep 0.1
### Instruction: Clear display (second nibble)
## b0001 1100		0x1C
i2cset -y ${i2c_bus} ${i2c_addr} "0x1C"
sleep 0.1
## b0001 1000		0x18
i2cset -y ${i2c_bus} ${i2c_addr} "0x18"
sleep 0.1

echo "Clear Display:  0000 0001  ||  0 0 0 0 0 0 0 1"

### Instruction: Entry mode set (first nibble)
## b0000 1100		0x0C
i2cset -y ${i2c_bus} ${i2c_addr} "0x0C"
sleep 0.1
## b0000 1000		0x08
i2cset -y ${i2c_bus} ${i2c_addr} "0x08"
sleep 0.1
### Instruction: Entry mode set (second nibble)
## b0110 1100		0x6C		# 0, 1, I(ncrement)/D(ecrement), S(hift of entire display)
i2cset -y ${i2c_bus} ${i2c_addr} "0x6C"
sleep 0.1
## b0110 1000		0x68
i2cset -y ${i2c_bus} ${i2c_addr} "0x68"
sleep 0.1

echo "Entry Mode Set: 0000 0110  ||  0 0 0 0 0 1 I/D S"
