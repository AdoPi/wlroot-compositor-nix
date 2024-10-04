BINS = tinywl

CFLAGS += -Wall -Wextra -Wno-unused-parameter -g -DWLR_USE_UNSTABLE

WAYLAND_PROTOCOLS=$(shell pkg-config --variable=pkgdatadir wayland-protocols)
WAYLAND_SCANNER=$(shell pkg-config --variable=wayland_scanner wayland-scanner)

all: $(BINS)
default: all

clean:
	$(RM) $(BINS) $(addsuffix .o,$(BINS))

xdg-shell-protocol.h:
	$(WAYLAND_SCANNER) client-header $(WAYLAND_PROTOCOLS)/stable/xdg-shell/xdg-shell.xml $@
xdg-shell-protocol.c:
	$(WAYLAND_SCANNER) private-code $(WAYLAND_PROTOCOLS)/stable/xdg-shell/xdg-shell.xml $@
xdg-shell-protocol.o: xdg-shell-protocol.h

tinywl.o: xdg-shell-protocol.h
tinywl: xdg-shell-protocol.o tinywl.o

# Library dependencies
tinywl: CFLAGS+=$(shell pkg-config --cflags wayland-server wlroots xkbcommon lua5.3 wayland-protocols wayland-client cairo gl) -Iinclude
tinywl: LDLIBS+=$(shell pkg-config --libs wayland-server wlroots xkbcommon lua5.3 wayland-protocols wayland-client cairo gl) -lrt -lm

install:


.PHONY: install all default
