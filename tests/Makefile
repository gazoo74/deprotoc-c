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

PATH := $(PWD)/..:$(PATH)
SHELL := /bin/bash

DIFF_OPTS = --ignore-tab-expansion --ignore-trailing-space \
	--ignore-space-change --ignore-all-space --ignore-blank-lines

.PHONY: all
all:
	@for proto in [0-9][0-9]*.proto; do \
		opts="$${proto%.*}"; \
		opts="$${opts:2}"; \
		test="test-$${proto%.*}"; \
		echo -e "\e[1mRunning $$test...\e[0m"; \
		if $(MAKE) OPTS=$$opts --silent --no-print-directory $$test; then \
			ok=$$((ok+1)); \
			echo -e "\e[1m$$test: \e[32m[OK]\e[0m"; \
		else \
			ko=$$((ko+1)); \
			echo -e "\e[1m$$test: \e[31m[KO]\e[0m"; \
		fi; \
		echo; \
	done; \
	if [ -n "$$ok" ]; then \
		echo -e "\e[1m\e[32m$$ok test(s) succeed!\e[0m"; \
	fi; \
	if [ -n "$$ko" ]; then \
		echo -e "\e[1mError: \e[31m$$ko test(s) failed!\e[0m" >&2; \
		exit 1; \
	fi

.PHONY: clean
clean:
	rm -f *.pb-c.*

.PHONY: compile
compile:
	@for proto in [0-9][0-9]*.proto; do \
		$(MAKE) OPTS=$$opts --silent --no-print-directory $${proto%.*}.pb-c.h; \
	done; \

test-%: %.pb-c.h %.pb-c.c
	@cat $< | deprotoc-c $(OPTS) | tee /dev/stderr | sed -e '1d' | \
	diff $(DIFF_OPTS) - <(cat $*.proto             | sed -e '1d;/reserved \+/d;s, \[default = .*\],,')

%.pb-c.h %.pb-c.c: %.proto
	protoc-c --c_out=. $<

