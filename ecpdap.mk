#
# Deps: rustc libusb-1.0-0-dev
#

MODULE	= ecpdap

include make-module.mk

fetch:
	cd "$(SRC)" && cargo fetch

compile:
	cd "$(SRC)" && cargo build --target-dir "$(WORK)" --release -j4

install:
	install -m 0755 -d "$(PACK)/$(PREFIX)/bin"
	install -m 0755 "$(WORK)/release/ecpdap" "$(PACK)/$(PREFIX)/bin/"
