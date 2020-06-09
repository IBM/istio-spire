#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 [ns] [sa]"
    exit
fi

export PATH=$PATH:../bin

kubectl exec -n spire spire-server-0 -- \
    /opt/spire/bin/spire-server entry create \
    -spiffeID spiffe://example.org/ns/$1/sa/$2 \
    -parentID spiffe://example.org/ns/spire/sa/spire-agent \
    -selector k8s:ns:$1 \
    -selector k8s:sa:$2
