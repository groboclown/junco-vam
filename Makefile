
GO := go
GO_FLAGS :=
JQ := jq
MKD := mkdir
RMD := rm -r
SED := sed

OUTDIR=bin
GO_SRC=$(shell find . -name '*.go' -type f)

ifeq ($(GOOS),windows)
	BIN_EXT=.exe
else
	BIN_EXT=
endif
BIN=$(OUTDIR)/junco$(BIN_EXT)

build: $(BIN) test

all: clean fmt build test

## Build the source binary.
$(BIN): $(GO_SRC) $(OUTDIR) schema
	$(GO) build $(GO_FLAGS) -o $@ ./main

$(OUTDIR):
	$(MKD) -p $@

## Run unit tests.
test: .FORCE $(OUTDIR)
	$(GO) test -coverprofile=$(OUTDIR)/coverage.out ./...
	$(GO) tool cover -html=$(OUTDIR)/coverage.out -o=$(OUTDIR)/coverage.html

## Clean up the generated files.
clean: .FORCE
	-$(RMD) $(OUTDIR)
	-$(RMD) lib/vac/schema/parse.go

## Format the source.
fmt: $(GO_SRC)
	$(GO) mod tidy

## Install all dependencies.
## source dependencies + build dependencies.
install-deps: .FORCE
	$(GO) get -v ./...
	$(GO) install github.com/atombender/go-jsonschema@latest

## Upgrade all dependencies.
upgrade-deps: .FORCE
	$(GO) get -t -u ./...

## Handle the schema files as used by the source.
schema: minimize-schema generate-from-schema

## Generate json decoders from the schema
generate-from-schema: lib/vac/schema/parse.go

# This seems to have a bug where it doesn't add all the right imports.
lib/vac/schema/parse.go: vac-1.0.schema.json
	$$HOME/go/bin/go-jsonschema -v -p=schema $< > $@
	scripts/fix-schema-parser.sh $@
	
lib/vac/schema:
	$(MKD) -p $@

## Minimize the schema files
minimize-schema: vac-1.0-min.schema.json

vac-1.0-min.schema.json: vac-1.0.schema.json
	$(JQ) --compact-output < $< > $@

# Force a target to run.
.FORCE:
