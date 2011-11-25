
CC		= clang
CFLAGS		= $(shell cat .clang_complete)

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
all: test kata

.PHONY: clean
clean:
	rm -rf build/

##############################################################################
## Kata

kata_SOURCES	= $(filter-out %Spec.m,$(wildcard *.m))
kata_OBJECTS	= $(addprefix build/kata/,$(addsuffix .o,$(basename $(kata_SOURCES))))

.PHONY: kata
kata: build/kata/kata

build/kata/%.o: %.m
	$(CC) $(CFLAGS) -c -o $@ $<

build/kata/kata: $(kata_OBJECTS)
	$(LD) $(LDFLAGS) $^ -o $@

##############################################################################
## Test bundle

test_NAME	= KataTest
test_BUNDLE	= build/$(test_NAME).octest
test_BINARY	= $(test_BUNDLE)/Contents/MacOS/$(test_NAME)
test_SOURCES	= $(wildcard *Spec.m)
test_OBJECTS	= $(filter-out build/kata/main.o,$(kata_OBJECTS)) \
		  $(addprefix build/kata/,$(addsuffix .o,$(basename $(test_SOURCES))))

.PHONY: test
test: build/KataTest.octest/Contents/MacOS/KataTest
	OBJC_DISABLE_GC=YES /Developer/Tools/otest $(test_BUNDLE)

$(test_BUNDLE)/Contents/MacOS/KataTest: build/Kiwi/libKiwi.a $(test_OBJECTS)
	mkdir -p $(dir $(test_BINARY)) && $(LD) $(LDFLAGS) $^ -o $@

##############################################################################
## Dependencies

$(shell mkdir -p build/kata)
kata_DEPFILES	= $(addsuffix .d,$(kata_OBJECTS))

build/kata/%.o.d: %.m
	$(CC) -MM $(CFLAGS) $^ |sed -e 's,^\([^ 	]\),build/kata/\1,' >$@

include $(kata_DEPFILES)

##############################################################################
## Kiwi library

# If invoked without submodules initialized, initialize them.

ifeq (,$(wildcard submodules/Kiwi/*))
$(shell git submodule init)
$(shell git submodule update)
endif

libKiwi_SOURCES	= $(wildcard submodules/Kiwi/Kiwi/*.m)
libKiwi_OBJECTS	= $(addprefix build/Kiwi/,$(notdir $(addsuffix .o,$(basename $(libKiwi_SOURCES)))))

build/Kiwi/libKiwi.a: $(libKiwi_OBJECTS)
	$(AR) -crs $@ $^

build/Kiwi/%.o: submodules/Kiwi/Kiwi/%.m
	mkdir -p build/Kiwi && $(CC) $(CFLAGS) -c -o $@ $<


