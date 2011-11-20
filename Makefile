
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

KIWI_SOURCES	= $(wildcard submodules/Kiwi/Kiwi/*.m)
KIWI_OBJECTS	= $(addprefix build/Kiwi/,$(notdir $(addsuffix .o,$(basename $(KIWI_SOURCES)))))

build/Kiwi/libKiwi.a: $(KIWI_OBJECTS)
	$(AR) -crs $@ $^

build/Kiwi/%.o: submodules/Kiwi/Kiwi/%.m build/Kiwi
	$(CC) $(CFLAGS) -c -o $@ $<

build/Kiwi:
	mkdir -p build/Kiwi

.PHONY: clean
clean:
	rm -rf build/

