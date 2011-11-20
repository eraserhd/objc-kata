
CC		= clang

build/Kiwi/%.o: submodules/Kiwi/Kiwi/%.m
	$(CC) -c -o $@ $^

build/Kiwi:
	mkdir -p build/Kiwi

submodules/Kiwi/Kiwi:
	git submodule init
	git submodule update
