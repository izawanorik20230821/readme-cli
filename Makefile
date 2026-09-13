CC      ?= cc
CFLAGS  ?= -std=c11 -Wall -Wextra -Wpedantic
PREFIX  ?= /usr/local

TARGET  = readme-cli
SRC     = src/main.c
OBJ     = $(SRC:.c=.o)

all: $(TARGET)

$(TARGET): $(SRC)
	$(CC) $(CFLAGS) -o $@ $<

clean:
	rm -f $(TARGET) *.o

install: $(TARGET)
	install -d $(PREFIX)/bin
	install -m 755 $(TARGET) $(PREFIX)/bin/$(TARGET)

debug: CFLAGS += -g -O0
debug: clean $(TARGET)

test: $(TARGET)
	bash tests/test.sh

.PHONY: all clean install debug test
