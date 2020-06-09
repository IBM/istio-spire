#!/bin/sh

if [ -d istio-1.5.4 ]
  then exit 0
fi

echo downloading istio

curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.5.4 sh -
