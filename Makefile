#
# Copyright (c) 2017 Gaël PORTAY <gael.portay@savoirfairelinux.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

PREFIX ?= /usr/local

.PHONY: all
all:

.PHONY: doc
doc: deprotoc-c.1.gz

.PHONY: install
install:
	install -d $(DESTDIR)$(PREFIX)/bin/
	install -m 755 deprotoc-c $(DESTDIR)$(PREFIX)/bin/

.PHONY: install-doc
install-doc:
	install -d $(DESTDIR)$(PREFIX)/share/man/man1/
	install -m 644 deprotoc-c.1.gz $(DESTDIR)$(PREFIX)/share/man/man1/

.PHONY: install-bash-completion
install-bash-completion:
	completionsdir=$$(pkg-config --variable=completionsdir bash-completion); \
	if [ -n "$$completionsdir" ]; then \
		install -d $(DESTDIR)$$completionsdir/; \
		install -m 644 bash-completion $(DESTDIR)$$completionsdir/deprotoc-c; \
	fi

.PHONY: uninstall
uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/deprotoc-c
	rm -f $(DESTDIR)$(PREFIX)/share/man/man1/deprotoc-c.1.gz
	completionsdir=$$(pkg-config --variable=completionsdir bash-completion); \
	if [ -n "$$completionsdir" ]; then \
		rm -f $(DESTDIR)$$completionsdir/deprotoc-c; \
	fi

.PHONY: tests
tests:
	$(MAKE) -C $@

.PHONY: check
check: deprotoc-c
	shellcheck $^

.PHONY: clean
clean:
	rm -f deprotoc-c.1.gz
	$(MAKE) -C tests $@

%.1: %.1.adoc
	asciidoctor -b manpage -o $@ $<

%.gz: %
	gzip -c $^ >$@

