CC ?= gcc
CFLAGS ?= -Wall -Wextra -pedantic
LDFLAGS += -g
SRC = $(wildcard src/*.c)
OBJ = $(SRC:.c=.o)
TARGET = fdesc

$(TARGET): $(OBJ)
	$(CC) -o $@ $^ $(CFLAGS)

.PHONY: clean
clean:
	rm -f $(OBJ) $(TARGET)
