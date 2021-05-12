#
# Deps:	python3-dev libboost-filesystem-dev libboost-thread-dev
#	libboost-program-options-dev
#

MODULE	= prjtrellis

include make-module.mk

configure:
	cd "$(WORK)" && \
	cmake "$(SRC)/libtrellis" \
		-DCMAKE_INSTALL_PREFIX="$(PREFIX)" \
		-DCMAKE_BUILD_TYPE=Release

compile:
	make -C "$(WORK)" -j4

install:
	umask 022 && make -C "$(WORK)" DESTDIR="$(PACK)" install
