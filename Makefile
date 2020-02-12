all: install test

.PHONY: all

install:
	./install.sh

minimal-install:
	./setup/minimal.sh

test:
	./setup/minimal.sh
