GO_VERSION := 1.21.6

.DEFAULT_GOAL := build
.PHONY:fmt vet build

setup: install-go init-go 

install-go: 
	wget "https://golang.org/dl/go$(GO_VERSION).linux-amd64.tar.gz"
	sudo tar -C /usr/local -xzf go$(GO_VERSION).linux-amd64.tar.gz
	rm go$(GO_VERSION).linux-amd64.tar.gz

init-go: 
    echo 'export PATH=$$PATH:/usr/local/go/bin' >> $${HOME}/.bashrc
    echo 'export PATH=$$PATH:$${HOME}/go/bin' >> $${HOME}/.bashrc

upgrade-go: 
	sudo rm -rf /usr/bin/go
	wget "https://golang.org/dl/go$(GO_VERSION).linux-amd64.tar.gz"
	sudo tar -C /usr/local -xzf go$(GO_VERSION).linux-amd64.tar.gz
	rm go$(GO_VERSION).linux-amd64.tar.gz

fmt:
	go fmt ./...
vet: fmt
	go vet ./...

build: test
	go build -o api cmd/main.go

test: vet
	go test ./... -coverprofile=coverage.out

coverage:
	go tool cover -func coverage.out | grep "total:" | \
	awk '{print ((int($$3) > 80) != 1) }'

report:
	go tool cover -html=coverage.out -o cover.html