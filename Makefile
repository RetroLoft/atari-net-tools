# Network tools for the Atari ST: small TOS programs for the STinG TCP/IP stack.
# m68k-atari-mint-gcc (e.g. in WSL). -mshort: STinG passes 16-bit ints.
# No C library: start-up in src/start.S, screen and keys through the BIOS.
CC = m68k-atari-mint-gcc
CFLAGS = -m68000 -mshort -O2 -Wall -fomit-frame-pointer -fno-builtin -Iinclude

all: URLVIEW.TTP

URLVIEW.TTP: src/start.o src/urlview.o
	$(CC) -mshort -nostdlib -o $@ $^ -lgcc -s

src/%.o: src/%.c include/transprt.h
	$(CC) $(CFLAGS) -c $< -o $@

src/%.o: src/%.S
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f URLVIEW.TTP src/*.o
