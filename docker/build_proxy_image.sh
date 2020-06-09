#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
export PATH=$PATH:$DIR:$DIR/../bin

cd $DIR
wget https://raw.githubusercontent.com/istio/istio/1.5.4/tools/packaging/common/envoy_bootstrap_v2.json
sed -i 's/"\/etc\/istio\/proxy\/SDS"/"\/spire-agent-socket-dir\/agent.sock"/g' envoy_bootstrap_v2.json

docker build --tag docker.io/istio/proxyv2-spire:1.5.4 .
rm -f envoy_bootstrap_v2.json

kind load docker-image docker.io/istio/proxyv2-spire:1.5.4
