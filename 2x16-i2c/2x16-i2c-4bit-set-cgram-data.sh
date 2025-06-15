#!/bin/bash

if [[ $1 =~ [0-9a-f][0-9a-f] ]]; then		## read cgram address
	address=$1
else
	echo "wrong input"
	exit
fi

if [[ $((0x${address} % 8 )) -ne 0 ]]; then 
	echo wrong input, address should be aligned to 8
	## maybe a single write should be possible
	exit
fi

i2c_addr="0x27"
i2c_bus="1"


## [7  6  5  4  3  2  0  0 ]
## [D7 D6 D5 D4 BL -E RW RS]

# 01AA AAAA 00

nibble=$((${address:0:1}+4)) ## 0100 == 4

i2cset -y ${i2c_bus} ${i2c_addr} "0x${nibble}C"		## SET first nibble
sleep 0.01
i2cset -y ${i2c_bus} ${i2c_addr} "0x${nibble}8"		## trigger READ first nibble
sleep 0.01

i2cset -y ${i2c_bus} ${i2c_addr} "0x${address:1:1}C"		## SET second nibble
sleep 0.01
i2cset -y ${i2c_bus} ${i2c_addr} "0x${address:1:1}8"		## trigger READ second nibble
sleep 0.01

## write data to RAM
## ***D DDDD 01

#1#   *****
#2#   *___*
#3#   *_*_*
#4#   *___*
#5#   *_*_*
#6#   *___*
#7#   *****
#8#   _____

#1#

i2cset -y ${i2c_bus} ${i2c_addr} "0x1D"		## SET first nibble
sleep 0.01
i2cset -y ${i2c_bus} ${i2c_addr} "0x19"		## trigger READ first nibble
sleep 0.01

i2cset -y ${i2c_bus} ${i2c_addr} "0xFD"		## SET second nibble
sleep 0.01
i2cset -y ${i2c_bus} ${i2c_addr} "0xF9"		## trigger READ second nibble
sleep 0.01

#2#

i2cset -y ${i2c_bus} ${i2c_addr} "0x1D"		## SET first nibble
sleep 0.01
i2cset -y ${i2c_bus} ${i2c_addr} "0x19"		## trigger READ first nibble
sleep 0.01

i2cset -y ${i2c_bus} ${i2c_addr} "0x1D"		## SET second nibble
sleep 0.01
i2cset -y ${i2c_bus} ${i2c_addr} "0x19"		## trigger READ second nibble
sleep 0.01

#3#

i2cset -y ${i2c_bus} ${i2c_addr} "0x1D"		## SET first nibble
sleep 0.01
i2cset -y ${i2c_bus} ${i2c_addr} "0x19"		## trigger READ first nibble
sleep 0.01

i2cset -y ${i2c_bus} ${i2c_addr} "0xFD"		## SET second nibble
sleep 0.01
i2cset -y ${i2c_bus} ${i2c_addr} "0xF9"		## trigger READ second nibble
sleep 0.01

#4#

i2cset -y ${i2c_bus} ${i2c_addr} "0x0D"		## SET first nibble
sleep 0.01
i2cset -y ${i2c_bus} ${i2c_addr} "0x09"		## trigger READ first nibble
sleep 0.01

i2cset -y ${i2c_bus} ${i2c_addr} "0x0D"		## SET second nibble
sleep 0.01
i2cset -y ${i2c_bus} ${i2c_addr} "0x09"		## trigger READ second nibble
sleep 0.01

#5#

i2cset -y ${i2c_bus} ${i2c_addr} "0x1D"		## SET first nibble
sleep 0.01
i2cset -y ${i2c_bus} ${i2c_addr} "0x19"		## trigger READ first nibble
sleep 0.01

i2cset -y ${i2c_bus} ${i2c_addr} "0xFD"		## SET second nibble
sleep 0.01
i2cset -y ${i2c_bus} ${i2c_addr} "0xF9"		## trigger READ second nibble
sleep 0.01

#6#

i2cset -y ${i2c_bus} ${i2c_addr} "0x1D"		## SET first nibble
sleep 0.01
i2cset -y ${i2c_bus} ${i2c_addr} "0x19"		## trigger READ first nibble
sleep 0.01

i2cset -y ${i2c_bus} ${i2c_addr} "0x1D"		## SET second nibble
sleep 0.01
i2cset -y ${i2c_bus} ${i2c_addr} "0x19"		## trigger READ second nibble
sleep 0.01

#7#

i2cset -y ${i2c_bus} ${i2c_addr} "0x1D"		## SET first nibble
sleep 0.01
i2cset -y ${i2c_bus} ${i2c_addr} "0x19"		## trigger READ first nibble
sleep 0.01

i2cset -y ${i2c_bus} ${i2c_addr} "0xFD"		## SET second nibble
sleep 0.01
i2cset -y ${i2c_bus} ${i2c_addr} "0xF9"		## trigger READ second nibble
sleep 0.01

#8#

i2cset -y ${i2c_bus} ${i2c_addr} "0x0D"		## SET first nibble
sleep 0.01
i2cset -y ${i2c_bus} ${i2c_addr} "0x09"		## trigger READ first nibble
sleep 0.01

i2cset -y ${i2c_bus} ${i2c_addr} "0x0D"		## SET second nibble
sleep 0.01
i2cset -y ${i2c_bus} ${i2c_addr} "0x09"		## trigger READ second nibble
sleep 0.01
