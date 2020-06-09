#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export PATH=$PATH:$DIR/bin

cd spire

if [ ! -d spire-tutorials ]
  then git clone https://github.com/spiffe/spire-tutorials/
  sed -i 's/gcr.io\/spiffe-io\/spire-agent:0.10.0/gcr.io\/spiffe-io\/spire-agent:1afb9bfd8fb4180d761e8c72de9e4740762ea1e7/g' spire-tutorials/k8s/quickstart/agent-daemonset.yaml
fi

./deploy_spire.sh
