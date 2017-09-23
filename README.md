# Prototype of protobuf C decompiler

## NAME

[deprotoc-c](deprotoc-c.1.adoc) - decompile protobuf C header

## DESCRIPTION

Parse generated **PROTO_CFILES** and output reverse to stdout.

## INSTALL

Run the following command to install *deprotoc-c(1)*

	$ sudo make install

Traditional variables *DESTDIR* and *PREFIX* can be overridden

	$ sudo PREFIX=/opt/deprotoc-c ./install.sh

or

	$ DESTDIR=$PWD/pkg PREFIX=/usr ./install.sh

## BUGS

Report bugs at *https://github.com/gazoo74/deprotoc-c/issues*

## AUTHOR

Written by Gaël PORTAY *gael.portay@savoirfairelinux.com*

## COPYRIGHT

Copyright (c) 2017 Gaël PORTAY

This program is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License version 3 as published by the
Free Software Foundation.
