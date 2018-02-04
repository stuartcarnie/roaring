# this converts rotate instructions from "ro[lr] <reg>" -> "ro[lr] <reg>, 1" for yasm compatibility
PERL_FIXUP_ROTATE=perl -i -pe 's/(ro[rl]\s+\w{2,3})$$/\1, 1/'

C2GOASM?=c2goasm
C2GOASM_ARGS=-a -f
CC=clang
C_FLAGS=-target x86_64-unknown-none -masm=intel -mno-red-zone -mstackrealign -mllvm -inline-threshold=1000 -fno-asynchronous-unwind-tables \
	-fno-exceptions -fno-rtti -O3 -fno-builtin -ffast-math -fno-jump-tables -I_lib
ASM_FLAGS_AVX2=-mavx2 -mfma -mllvm -force-vector-width=4
# ASM_FLAGS_AVX2=-mavx2 -mfma -mllvm -force-vector-width=32
ASM_FLAGS_SSE3=-msse3
ASM_FLAGS_SSE4=-msse4

INTEL_SOURCES := \
	popcnt_slice_avx2_amd64.s popcnt_slice_sse4_amd64.s


.PHONY: help all test format fmtcheck vet lint     qa deps clean nuke rle backrle ser fetch-real-roaring-datasets assembly

# Display general help about this command
help:
	@echo ""
	@echo "The following commands are available:"
	@echo ""
	@echo "    make qa          : Run all the tests"
	@echo "    make test        : Run the unit tests"
	@echo ""
	@echo "    make format      : Format the source code"
	@echo "    make fmtcheck    : Check if the source code has been formatted"
	@echo "    make vet         : Check for suspicious constructs"
	@echo "    make lint        : Check for style errors"
	@echo ""
	@echo "    make deps        : Get the dependencies"
	@echo "    make clean       : Remove any build artifact"
	@echo "    make nuke        : Deletes any intermediate file"
	@echo ""
	@echo "    make fuzz       : Fuzzy testing"
	@echo ""

# Alias for help target
all: help
test:
	go test
	go test -race -run TestConcurrent*
# Format the source code
format:
	@find ./ -type f -name "*.go" -exec gofmt -w {} \;

# Check if the source code has been formatted
fmtcheck:
	@mkdir -p target
	@find ./ -type f -name "*.go" -exec gofmt -d {} \; | tee target/format.diff
	@test ! -s target/format.diff || { echo "ERROR: the source code has not been formatted - please use 'make format' or 'gofmt'"; exit 1; }

# Check for syntax errors
vet:
	GOPATH=$(GOPATH) go vet ./...

# Check for style errors
lint:
	GOPATH=$(GOPATH) PATH=$(GOPATH)/bin:$(PATH) golint ./...





# Alias to run all quality-assurance checks
qa: fmtcheck test vet lint

# --- INSTALL ---

# Get the dependencies
deps:
	GOPATH=$(GOPATH) go get github.com/smartystreets/goconvey/convey
	GOPATH=$(GOPATH) go get github.com/willf/bitset
	GOPATH=$(GOPATH) go get github.com/golang/lint/golint
	GOPATH=$(GOPATH) go get github.com/mschoch/smat
	GOPATH=$(GOPATH) go get github.com/dvyukov/go-fuzz/go-fuzz
	GOPATH=$(GOPATH) go get github.com/dvyukov/go-fuzz/go-fuzz-build
	GOPATH=$(GOPATH) go get github.com/glycerine/go-unsnap-stream
	GOPATH=$(GOPATH) go get github.com/philhofer/fwd
	GOPATH=$(GOPATH) go get github.com/jtolds/gls

fuzz:
	go test -tags=gofuzz -run=TestGenerateSmatCorpus
	go-fuzz-build github.com/RoaringBitmap/roaring
	go-fuzz -bin=./roaring-fuzz.zip -workdir=workdir/ -timeout=200

# Remove any build artifact
clean:
	GOPATH=$(GOPATH) go clean ./...

# Deletes any intermediate file
nuke:
	rm -rf ./target
	GOPATH=$(GOPATH) go clean -i ./...

rle:
	cp rle.go rle16.go
	perl -pi -e 's/32/16/g' rle16.go
	cp rle_test.go rle16_test.go
	perl -pi -e 's/32/16/g' rle16_test.go

backrle:
	cp rle16.go rle.go
	perl -pi -e 's/16/32/g' rle.go
	perl -pi -e 's/2032/2016/g' rle.go

ser: rle
	go generate

cover:
	go test -coverprofile=coverage.out
	go tool cover -html=coverage.out

fetch-real-roaring-datasets:
	# pull github.com/RoaringBitmap/real-roaring-datasets -> testdata/real-roaring-datasets
	git submodule init
	git submodule update

assembly: $(INTEL_SOURCES)

_lib/popcnt_slice_avx2.s: _lib/popcnt_slice.c
	$(CC) -S $(C_FLAGS) $(ASM_FLAGS_AVX2) $^ -o $@ ; $(PERL_FIXUP_ROTATE) $@

popcnt_slice_avx2_amd64.s: _lib/popcnt_slice_avx2.s
	$(C2GOASM) $(C2GOASM_ARGS) $^ $@

_lib/popcnt_slice_sse4.s: _lib/popcnt_slice.c
	$(CC) -S $(C_FLAGS) $(ASM_FLAGS_SSE4) $^ -o $@ ; $(PERL_FIXUP_ROTATE) $@

popcnt_slice_sse4_amd64.s: _lib/popcnt_slice_sse4.s
	$(C2GOASM) $(C2GOASM_ARGS) $^ $@
