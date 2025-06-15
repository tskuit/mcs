#!/bin/bash

i2c_addr="0x27"
i2c_bus="1"

## [7  6  5  4  3  2  1  0 ]
## [D7 D6 D5 D4 BL -E RW RS]

##  1111 1010		## read busy flag and address counter
##
##  .... 1010		## read busy flag and address counter command -- BL:1, E:0, RS: 0, R/W:1
##  1111 ....		## setting bits high allows reading of their state from PCF8574

## reading first nibble
i2cset -y ${i2c_bus} ${i2c_addr} "0xFA"				## RS: 0, R/W:1, E:0
sleep 0.01
i2cset -y ${i2c_bus} ${i2c_addr} "0xFE"				## Enable: 1
sleep 0.01
i2cget -y ${i2c_bus} ${i2c_addr}

## reading second nibble
sleep 0.01
i2cset -y ${i2c_bus} ${i2c_addr} "0xFA"				## Enable: 0
sleep 0.01
i2cset -y ${i2c_bus} ${i2c_addr} "0xFE"				## Enable: 1
sleep 0.01
i2cget -y ${i2c_bus} ${i2c_addr}


