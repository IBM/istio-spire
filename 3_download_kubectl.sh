#!/bin/sh

if [ -f bin/kubectl ]
  then exit 0
fi

echo downloading kubectl

mkdir -p bin
curl -Lo ./bin/kubectl https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./bin/kubectl
