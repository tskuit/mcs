#!/bin/bash

if [[ ${#1} -eq 1 ]]; then			## take a char and convert to hex ascii
	char=$(printf "%x" "'$1")
elif [[ $1 =~ [0-9a-f][0-9a-f] ]]; then		## take a hex
	char=$1
else
	echo "wrong input"
	exit
fi

i2c_addr="0x27"
i2c_bus="1"


## [7  6  5  4  3  2  1  0 ]
## [D7 D6 D5 D4 BL -E RW RS]

i2cset -y ${i2c_bus} ${i2c_addr} "0x${char:0:1}D"		## SET first nibble
sleep 0.01
i2cset -y ${i2c_bus} ${i2c_addr} "0x${char:0:1}9"		## trigger READ first nibble
sleep 0.01

i2cset -y ${i2c_bus} ${i2c_addr} "0x${char:1:1}D"		## SET second nibble
sleep 0.01
i2cset -y ${i2c_bus} ${i2c_addr} "0x${char:1:1}9"		## trigger READ second nibble
sleep 0.01

#echo "0x${char:1:1}9"

