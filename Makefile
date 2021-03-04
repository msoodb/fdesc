CC = gcc
CFLAGS = -Wall -Wextra -pedantic
LDFLAGS = -g
SRC = $(wildcard src/*.c)
OBJ = $(SRC:.c=.o)
TARGET = fdesc
DESTDIR ?=
PREFIX ?= /usr/local

$(TARGET): $(OBJ)
	$(CC) -o $@ $^ $(CFLAGS)

install: $(TARGET)
	install -m 0755 -d $(DESTDIR)$(PREFIX)/bin
	install -m 0755 $(TARGET) $(DESTDIR)$(PREFIX)/bin

.PHONY: clean

clean:
	rm -f $(OBJ) $(TARGET)
