#
# Deps:	python3-dev libboost-filesystem-dev libboost-thread-dev
#	libboost-program-options-dev
#

PREFIX	?= "$(HOME)/cad"

MODULE	= prjtrellis

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
	cmake "$(SRC)/libtrellis" \
		-DCMAKE_INSTALL_PREFIX="$(PREFIX)" \
		-DCMAKE_BUILD_TYPE=Release

compile: configure
	make -C "$(WORK)" -j4

install: compile
	rm -rf "$(PACK)"
	umask 022 && make -C "$(WORK)" DESTDIR="$(PACK)" install

package: install
	fakeroot tar czf "$(TARGET)" -C "$(PACK)" .

clean:
	rm -rf "$(TARGET)" "$(PACK)" "$(WORK)"
