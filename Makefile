# ==================================================================================== #
# HELPERS
# ==================================================================================== #

## help: print this help message
.PHONY: help
help:
	@echo "Usage:"
	@sed -n "s/^##//p" ${MAKEFILE_LIST} | column -t -s ":" |  sed -e "s/^/ /"

# ==================================================================================== #
# QUALITY CONTROL
# ==================================================================================== #

## audit: run quality control checks
.PHONY: audit
audit: test
	@find src -name '*.hs' | xargs ormolu --mode check
	@hlint src

## test: run all tests
.PHONY: test
test:
	@stack test

# ==================================================================================== #
# DEVELOPMENT
# ==================================================================================== #

## format: format code using ormolu
format:
	@find . -name '*.hs' | xargs ormolu -i

## build: build the app
.PHONY: build
build:
	@stack build

## run: run the app
.PHONY: run
run: build
	@stack run

## clean: clean all build files
.PHONY: clean
clean:
	@stack clean

# vim: set tabstop=4 shiftwidth=4 noexpandtab
