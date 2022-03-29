.POSIX:
.PHONY: all clean
.SILENT: clean

all: example

example: example.sunder
	sunder-compile -o example example.sunder

clean:
	rm -f example *.o *.asm
