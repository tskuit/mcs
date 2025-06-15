
LCD1602 2x16 (4x20) lcd display datasheet
HD44780 controller/driver datasheet
PCF8574 8bit i/o expander for i2c bus datasheet


```
 1	VSS		0V		Ground
 2	VDD		5.0V		Supply Voltage for logic
 3	 VO		(Variable)	Operating voltage for LCD

 4	 RS		H/L		H: DATA, L: Instruction code (Register Select: 0 instruction, 1 data)
 5	R/W		H/L		H: Read(MPU->Module) L: Write(MPU->Module) (R/W: Read or Write)
 6	  E		H,H->L		Chip enable signal

 7	DB0		H/L		Data bus line
 8	DB1		H/L		Data bus line
 9	DB2		H/L		Data bus line
10	DB3		H/L		Data bus line
11	DB4		H/L		Data bus line
12	DB5		H/L		Data bus line
13	DB6		H/L		Data bus line
14	DB7		H/L		Data bus line 

15	  A		--		LED + (backlight)
15	  K		--		LED - (backlight)
```


```
 0	 RS
 1	 RW
 2	  E
 3	VO?				light enable (on/off display)

 4	DB4
 5	DB5
 6	DB6
 7	DB7
```

```
External contrast adjustment (Supply Voltage For LCD)

          ^
          |             | - - - - - - -
          | - - Vdd - - |
 VR      ^>             |     LCM
10K~20K   \ - -  Vo - - |    module
          <\            |
          | - - Vss - - |
                |       | - - - - - - -
               ___       
                -      
```

LCD controller can store 80 characters to handle 4x20 display. Using 2x16 it's possible to write character to additional space and shift them for example.

```
Character located		 1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16
DDRAM Address			00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F
DDRAM Address			40 41 42 43 44 45 46 47 48 49 4A 4B 4C 4D 4E 4F
```


Character Generator ROM (CGROM) -- predefined set of characters.
Character Generator RAM (CGRAM) -- In CGRAM, the user can rewrite character by program, eight characters for 5x8 dots, and four characters for 5x10 dots.

 BL (light enable)	-- High: display lights up, Low: dark -- always 1
  E (enable pin)	-- transition from High to Low state triggers reading data by chip
 RS 			-- High: data, Low: instruction code
R/W			-- High: read, Low: write 

To send an instrucion code
```
## Send Instruction (first nibble/high):
## b____ 1100		0x_C		-- DB7 DB6 DB5 DB4 BL(1--light) E(1--enable) RS(0--instruction) R/W(0-write)
## b____ 1000		0x_8		-- trigger read by changing state of Enable from High to Low
## Send Instruction (second nibble/low):
## b____ 1100		0x_C		-- DB3 DB2 DB1 DB0 BL(1--light) E(1--enable) RS(0--instruction) R/W(0-write)
## b____ 1000		0x_8		-- trigger read by changing state of Enable from High to Low
```

4-bit initialization procedure:
```

[ DB7 DB6 DB5 DB4  BL   E  RW  RS ]			-- LCD pins
[   7   6   5   4   3   2   1   0 ]			-- I2C byte

[   0   0   1   1   1   1   0   0 ]			-- LCD Function Set command



== == == ==

https://forum.arduino.cc/t/read-issues-on-lcd-4-bit-mode/1004919/42
host writing to LCD:
E falling edge tells the LCD to latch (read) the data on the LCD DBx pins

host reading from LCD:
when E goes high it tells the LCD to present the data on LCD DBx pins and the data on the LCD DBx pins will be valid for the host to read after tDDR and the data will remain valid on the LCD DBx pins as long as E is held high.
