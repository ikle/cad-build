#
# Deps: flex bison libreadline-dev gawk tcl-dev libffi-dev git
#	graphviz xdot pkg-config python3 libboost-system-dev
#	libboost-python-dev libboost-filesystem-dev zlib1g-dev
#

PREFIX	?= "$(HOME)/cad"

MODULE	= yosys

SRC	= $(CURDIR)/$(MODULE)
WORK	= $(CURDIR)/$(MODULE)-build
PACK	= $(CURDIR)/$(MODULE)-pack

TARGET	= $(MODULE)-pack.tgz

.PHONY: all fetch configure compile install package clean

all: package

fetch:
	git submodule init
	git submodule update --init --recursive $(MODULE)

configure: fetch
	rm -rf "$(WORK)"
	mkdir "$(WORK)"
	cd "$(WORK)" && \
	make -f "$(SRC)/Makefile" config-gcc

compile: configure
	make -f "$(SRC)/Makefile" -C "$(WORK)" PREFIX="$(PREFIX)" -j4

install: compile
	rm -rf "$(PACK)"
	umask 022 && \
	make -f "$(SRC)/Makefile" -C "$(WORK)" \
	     PREFIX="$(PREFIX)" DESTDIR="$(PACK)" install

package: install
	fakeroot tar czf "$(TARGET)" -C "$(PACK)" .

clean:
	rm -rf "$(TARGET)" "$(PACK)" "$(WORK)"
