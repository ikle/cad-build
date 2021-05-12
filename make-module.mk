#
# Common rules to build CAD module
#

PREFIX	?= "$(HOME)/cad"

MODULE	?= dumb

SRC	= $(CURDIR)/$(MODULE)
WORK	= $(CURDIR)/$(MODULE)-build
PACK	= $(CURDIR)/$(MODULE)-pack

TARGET	= $(MODULE)-pack.tgz

.PHONY: all fetch configure compile install package clean

all: package

fetch-git:
	git submodule update --init --recursive $(MODULE)

fetch: fetch-git

configure-prepare: fetch
	rm -rf "$(WORK)"
	mkdir "$(WORK)"

configure: configure-prepare

compile: configure

install-prepare: compile
	rm -rf "$(PACK)"

install: install-prepare

package: install
	fakeroot tar czf "$(TARGET)" -C "$(PACK)" .

clean:
	rm -rf "$(TARGET)" "$(PACK)" "$(WORK)"
