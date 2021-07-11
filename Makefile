
PREFIX ?= /usr/local
BINDIR = $(PREFIX)/bin
LIBDIR = $(PREFIX)/lib/menjar
MANDIR = $(PREFIX)/share/man/man1

files = $(DESTDIR)$(BINDIR)/menjar \
	$(DESTDIR)$(MANDIR)/menjar.1.gz \
	$(DESTDIR)$(LIBDIR)/menjar1.awk \
	$(DESTDIR)$(LIBDIR)/menjar2.awk

install: $(files)

$(DESTDIR)$(BINDIR)/menjar: menjar
	install -Dm755 $^ $@
	sed -i -e '/^LLIB/ s;/usr/local/lib;'$(PREFIX)'/lib;' $@

$(DESTDIR)$(MANDIR)/menjar.1.gz: menjar.1
	install -Dm644 menjar.1 $(DESTDIR)$(MANDIR)/menjar.1
	gzip -9 $(DESTDIR)$(MANDIR)/menjar.1

$(DESTDIR)$(LIBDIR)/menjar1.awk: menjar1.awk
	install -Dm644 $^ $@

$(DESTDIR)$(LIBDIR)/menjar2.awk: menjar2.awk
	install -Dm644 $^ $@

# for manual installs only, ofc
uninstall:
	rm $(files)
	rmdir $(LIBDIR)

