# Constants
PROCESSOR_T85=t85
HIGH_FUSE_T85_Default=0xDF
LOW_FUSE_T85_NoCKDIV8=0xE2
MMCU_T85=attiny85

# Hardware Configuration
PROCESSOR=$(PROCESSOR_T85)
HIGH_FUSE=$(HIGH_FUSE_T85_Default)
LOW_FUSE=$(LOW_FUSE_T85_NoCKDIV8)
MMCU=$(MMCU_T85)

# Project Configuration
PROJECT=${project}
FILE_NAME=$(PROJECT)
HEX_PATH=$(FILE_NAME).hex

# Programmer - USBtiny
PROGRAMMER=usbtiny

# Tools
CC=avr-gcc
OBJCOPY=avr-objcopy
SOURCES=$(PROJECT).c
CFLAGS=-mmcu=$(MMCU) -Wall
AVRDUDE=avrdude

# "all" target runs by default (compiles and programs the chip)
all: program clean
	
# "hex" target: copies .out to .hex
$(PROJECT).hex: $(PROJECT).out
	$(OBJCOPY) -j .text -O ihex $(PROJECT).out $(PROJECT).hex
	rm $(PROJECT).out

# "out" target: compiles .c to .out
$(PROJECT).out: $(SOURCES)
	$(CC) $(CFLAGS) -I./ -Os -o $(PROJECT).out $(SOURCES)

# "program" target: programs .hex onto the chip
program: $(PROJECT).hex
	$(AVRDUDE) -v -p $(PROCESSOR) -c $(PROGRAMMER) -U flash:w:$(HEX_PATH):i -U lfuse:w:$(LOW_FUSE):m -U hfuse:w:$(HIGH_FUSE):m

# "clean" target: removes .out and .hex files
clean:
	rm -f $(PROJECT).out
	rm -f $(PROJECT).hex

# "verify" target: check if programmer is connected
verify:
	$(AVRDUDE) -v -p $(PROCESSOR) -c $(PROGRAMMER) -n