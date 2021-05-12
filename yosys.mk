#
# Deps: flex bison libreadline-dev gawk tcl-dev libffi-dev git
#	graphviz xdot pkg-config python3 libboost-system-dev
#	libboost-python-dev libboost-filesystem-dev zlib1g-dev
#

MODULE	= yosys

include make-module.mk

configure:
	cd "$(WORK)" && \
	make -f "$(SRC)/Makefile" config-gcc

compile:
	make -f "$(SRC)/Makefile" -C "$(WORK)" PREFIX="$(PREFIX)" -j4

install:
	umask 022 && \
	make -f "$(SRC)/Makefile" -C "$(WORK)" \
	     PREFIX="$(PREFIX)" DESTDIR="$(PACK)" install
