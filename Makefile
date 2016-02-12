NAME = did
LIB = lib
LIBS = $(shell find $(LIB) -type f) \
	$(shell find $(LIB) -type l)
DOC = doc/$(NAME).swim
DOCS = $(shell echo doc/*.swim)
MAN1 = man/man1
MANS = $(DOCS:doc/%.swim=$(MAN1)/%.1)
SHARE = share

##
# User targets:
default: help

help:
	@echo 'Makefile rules:'
	@echo ''
	@echo '    doc        Generate the docs/manpages'
	@echo '    test       Run all tests'
	@echo ''

.PHONY: test
test:
ifeq ($(shell which prove),)
	@echo '`make test` requires the `prove` utility'
	@exit 1
endif
	prove $(PROVEOPT:%=% )test/

clean purge:
	git clean -fxd

##
# Build rules:

update: doc

doc: $(MAN1) $(MANS) ReadMe.pod
	perl tool/generate-help-functions.pl > bin/did-help

$(MAN1)/%.1: doc/%.swim
	swim --to=man $< > $@

$(MAN1):
	mkdir -p $(MAN1)

ReadMe.pod: $(DOC)
	swim --to=pod --complete --wrap $< > $@
