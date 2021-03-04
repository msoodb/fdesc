CC ?= gcc
CFLAGS ?= -Wall -Wextra -pedantic
LDFLAGS += -g
SRC = $(wildcard src/*.c)
OBJ = $(SRC:.c=.o)
TARGET = fdesc

.PHONY: clean

$(TARGET): $(OBJ)
	$(CC) -o $@ $^ $(CFLAGS)
clean:
	rm -f $(OBJ) $(TARGET)
