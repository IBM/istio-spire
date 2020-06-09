#!/bin/sh

if [ -f bin/kind ]
  then exit 0
fi

echo downloading kind

mkdir -p bin
curl -Lo ./bin/kind https://kind.sigs.k8s.io/dl/v0.8.1/kind-$(uname)-amd64
chmod +x ./bin/kind
