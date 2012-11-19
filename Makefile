#AVR VAR SECTION
AVR_DEVICE  = atmega644p
AVR_F_CPU   = 20000000	# in Hz
AVRDUDE = avrdude -c avrispmkII -P usb -u -p $(AVR_DEVICE) # edit this line for your programmer
AVR_CFLAGS  = -Isource/usbdrv -Isource/firmware/ -DDEBUG_LEVEL=0
AVR_OBJECTS = $(patsubst %.c,%.o,$(wildcard source/firmware/*.c)) $(patsubst %.S,%.o,$(wildcard source/firmware/*.S)) #source/usbdrv/usbdrv.o source/usbdrv/usbdrvasm.o source/usbdrv/oddebug.o
AVR_COMPILE = avr-gcc -Wall -Os -DF_CPU=$(AVR_F_CPU) $(AVR_CFLAGS) -mmcu=$(AVR_DEVICE)

#UCOM VAR SECTION
UCOM_CFLAGS = -Isource/ucom
UCOM_CLIBS = -lusb
UCOM_COMPILE = gcc $(UCOM_CFLAGS) 
UCOM_OBJECTS = $(patsubst %.c,%.o,$(wildcard source/ucom/*.c))

all: bin/main.hex  

#AVR SECTION
hex: bin/main.hex
program: flash
# rule for uploading firmware:
flash: bin/main.hex
	$(AVRDUDE) -U flash:w:bin/main.hex:i
   
source/firmware/%.o: source/firmware/%.c
	@echo "cc $<"
	@$(AVR_COMPILE) -c $< -o $@
source/firmware/%.o: source/firmware/%.S
	@echo "as $<"
	@$(AVR_COMPILE) -x assembler-with-cpp -c $< -o $@
source/usbdrv/%.o: source/usbdrv/%.c
	@echo "cc $<"
	@$(AVR_COMPILE) -c $< -o $@
source/usbdrv/%.o: source/usbdrv/%.S
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
disasm:	bin/main.elf
	avr-objdump -d bin/main.elf

#UCOM SECTION
source/ucom/%.o: source/ucom/%.c
	@echo "cc $<"
	@$(UCOM_COMPILE) -c $< -o $@
bin/ucom: $(UCOM_OBJECTS)
	@echo "linking bin/ucom"
	@$(UCOM_COMPILE) $(UCOM_CLIBS) -o bin/ucom $(UCOM_OBJECTS)

# rule for deleting dependent files (those which can be built by Make):
clean:
	@rm -f bin/ucom source/ucom/*.o bin/main.hex bin/main.elf source/firmware/*.o source/usbdrv/*.o source/usbdrv/oddebug.s source/usbdrv/usbdrv.s
