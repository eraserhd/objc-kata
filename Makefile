
CC		= clang
CFLAGS		= -x objective-c \
		  -arch x86_64 \
		  -std=gnu99 \
		  -fpascal-strings \
		  -O0 \
		  -DDEBUG=1 \
		  -gdwarf-2 \
		  -F/Developer/Library/Frameworks \
		  -framework SenTestingKit

libKiwi_SOURCES	= $(wildcard submodules/Kiwi/Kiwi/*.m)
libKiwi_OBJECTS	= $(addprefix build/Kiwi/,$(notdir $(addsuffix .o,$(basename $(libKiwi_SOURCES)))))

build/Kiwi/libKiwi.a: $(libKiwi_OBJECTS)
	$(AR) -crs $@ $^

build/Kiwi/%.o: submodules/Kiwi/Kiwi/%.m
	mkdir -p build/Kiwi && $(CC) $(CFLAGS) -c -o $@ $<

.PHONY: clean
clean:
	rm -rf build/

