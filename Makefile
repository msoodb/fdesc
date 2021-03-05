CC ?= gcc
CFLAGS ?= -Wall -Wextra -pedantic
LDFLAGS += -g
SRC = $(wildcard src/*.c)
OBJ = $(SRC:.c=.o)
TARGET = fdesc

.PHONY: clean

$(TARGET): $(OBJ)
	$(CC) -o $@ $^ $(CFLAGS)

# install-man: $(TARGET)
# 	install ... apple.3 $(mandir)/man3/apple.3
# 	mkdir -p %{buildroot}%{_bindir}	
# 	install -p -m 755 %{name} %{buildroot}%{_bindir}/%{name}

clean:
	rm -f $(OBJ) $(TARGET)
