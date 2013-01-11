#AVR VAR SECTION
AVR_DEVICE  = atmega644p
AVR_F_CPU   = 20000000

AVRDUDE = avrdude -c avrispmkII -P usb -u -p $(AVR_DEVICE)
AVR_COMPILE = avr-gcc -Wall -Os -DF_CPU=$(AVR_F_CPU) $(AVR_CFLAGS) -mmcu=$(AVR_DEVICE)   
AVR_FUSES = -U lfuse:w:0xf7:m -U hfuse:w:0xd9:m -U efuse:w:0xff:m 

AVR_CFLAGS  = -Isource/usbdrv -Isource/firmware/ -DDEBUG_LEVEL=0
AVR_OBJECTS = $(patsubst %.c,%.o,$(wildcard source/firmware/*.c)) $(patsubst %.S,%.o,$(wildcard source/firmware/*.S)) 

.PHONY: all clean hex program flash disasm fuses

all: bin/main.hex  

program: bin/main.hex
	$(AVRDUDE) -U flash:w:bin/main.hex:i  
fuses: 
	$(AVRDUDE) $(AVR_FUSES)
   
source/firmware/%.o: source/firmware/%.c
	@echo "cc $<"
	@$(AVR_COMPILE) -c $< -o $@
source/firmware/%.o: source/firmware/%.S
	@echo "as $<"
	@$(AVR_COMPILE) -x assembler-with-cpp -c $< -o $@

bin/main.elf: $(AVR_OBJECTS)
	@echo "linking bin/main.elf"
	@$(AVR_COMPILE) -o bin/main.elf $(AVR_OBJECTS)

bin/main.hex: bin/main.elf
	@echo "linking bin/main.hex"
	@rm -f bin/main.hex bin/main.eep.hex
	@avr-objcopy -j .text -j .data -O ihex bin/main.elf bin/main.hex
	@avr-size bin/main.hex

clean:
	@rm -f bin/main.hex bin/main.elf source/firmware/*.o 
