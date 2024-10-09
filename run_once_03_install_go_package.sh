#!/bin/sh

export GOPATH="$HOME/prog/go"

go install github.com/kubecolor/kubecolor@latest
go install github.com/nao1215/gup@latest
go install github.com/fairwindsops/nova@latest
