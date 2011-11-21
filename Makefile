
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

LDFLAGS		= -arch x86_64 \
		  -ObjC \
		  -all_load \
		  -bundle \
		  -macosx_version_min 10.6 \
		  -lc -lobjc \
		  -F/Developer/Library/Frameworks \
		  -framework Foundation \
		  -framework SenTestingKit

.PHONY: all
all: test

.PHONY: clean
clean:
	rm -rf build/

## KataTest.octest

.PHONY: test
test: build/KataTest.octest/Contents/MacOS/KataTest
	OBJC_DISABLE_GC=YES /Developer/Tools/otest build/KataTest.octest


build/KataTest.octest/Contents/MacOS/KataTest: build/Kiwi/libKiwi.a
	mkdir -p build/KataTest.octest/Contents/MacOS && $(LD) $(LDFLAGS) $^ -o $@

## Kiwi

libKiwi_SOURCES	= $(wildcard submodules/Kiwi/Kiwi/*.m)
libKiwi_OBJECTS	= $(addprefix build/Kiwi/,$(notdir $(addsuffix .o,$(basename $(libKiwi_SOURCES)))))

build/Kiwi/libKiwi.a: $(libKiwi_OBJECTS)
	$(AR) -crs $@ $^

build/Kiwi/%.o: submodules/Kiwi/Kiwi/%.m
	mkdir -p build/Kiwi && $(CC) $(CFLAGS) -c -o $@ $<


