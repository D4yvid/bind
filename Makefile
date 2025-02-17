ARCH ?= arm64
CC ?= cc
AS ?= as
AR ?= ar
CFLAGS ?= -I include

TARGET ?= libbind.a

.PHONY: all
all:	test

.PHONY:	test
test:	test/person
	@sh -c ./test.sh

.PHONY: test/person
test/person:	libbind.a
	@echo "  CCLD    $@ "
	@$(CC) $(CFLAGS) -o $@ test/person.c libbind.a

libbind.a:	src/bind.o arch/$(ARCH)/bind.o
	@echo "  AR      $@ "
	@$(AR) r $@ src/bind.o arch/$(ARCH)/bind.o

%.o: %.c
	@echo "  CC      $@ "
	@$(CC) $(CFLAGS) -c -o $@ $<

%.o: %.S
	@echo "  AS      $@ "
	@$(AS) -o $@ $<

