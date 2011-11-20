
CC		= clang
CFLAGS		= -F/Developer/Library/Frameworks -framework SenTestingKit

KIWI_SOURCES	= $(wildcard submodules/Kiwi/Kiwi/*.m)
KIWI_OBJECTS	= $(addprefix build/Kiwi/,$(notdir $(addsuffix .o,$(basename $(KIWI_SOURCES)))))

build/Kiwi/libKiwi.a: $(KIWI_OBJECTS)
	$(AR) -crs $@ $^

build/Kiwi/%.o: submodules/Kiwi/Kiwi/%.m
	$(CC) -c -o $@ $(CFLAGS) $^

build/Kiwi:
	mkdir -p build/Kiwi

