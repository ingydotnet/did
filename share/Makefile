name := $(shell grep '^name:' docker-id.yml | cut -d' ' -f2)
user := $(shell grep '^user:' docker-id.yml | cut -d' ' -f2)
base := $(shell basename $$PWD)
DID_NAME := $(user)/$(name)

default: build

build:
	did build

run: build
	did run $(DID_NAME)

update: doc

doc: ReadMe.pod

ReadMe.pod: $(base).swim
	did run swim --to=pod --complete < $< > $@
