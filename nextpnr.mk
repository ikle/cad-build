#
# Deps:	python3-dev libboost-filesystem-dev libboost-thread-dev
#	libboost-program-options-dev libboost-iostreams-dev
#	libeigen3-dev
#

ARCHES	?= ecp5

MODULE	= nextpnr

include make-module.mk

fetch:
	cd "$(SRC)" && git reset --hard HEAD
	patch -d "$(SRC)" -p1 -i "$(CURDIR)/nextpnr-cmake-3.7.patch"

configure:
	cd "$(WORK)" && \
	cmake "$(SRC)" \
		-DARCH=$(ARCHES) \
		-DCMAKE_INSTALL_PREFIX="$(PREFIX)" \
		-DCMAKE_BUILD_TYPE=Release

compile:
	make -C "$(WORK)" -j4

install:
	umask 022 && make -C "$(WORK)" DESTDIR="$(PACK)" install
