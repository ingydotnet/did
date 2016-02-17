.PHONY: default build run update doc

name := $(shell grep '^name:' docker-id.yml | cut -d' ' -f2)
user := $(shell grep '^user:' docker-id.yml | cut -d' ' -f2)
swim := $(name).swim
DID_NAME := $(user)/$(name)

default: build

build:
	did build

run: build
	did run $(DID_NAME)

update: doc

doc: ReadMe.pod

ReadMe.pod: $(swim)
	did run swim --to=pod --complete < $< > $@
