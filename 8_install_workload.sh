#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export PATH=$PATH:$DIR/bin

if [ ! -d go ]
  then wget https://dl.google.com/go/go1.14.3.linux-amd64.tar.gz
  tar xfz go1.14.3.linux-amd64.tar.gz
  rm go1.14.3.linux-amd64.tar.gz
fi

cd deployment/webecho
./build.sh

cd ../k8s_yamls
./load_images.sh
./deploy_all.sh

kubectl wait --for=condition=Ready pod -l app=web
kubectl wait --for=condition=Ready pod -l app=echo

INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}')
INGRESS_HOST=$(kubectl get po -l istio=ingressgateway -n istio-system -o jsonpath='{.items[0].status.hostIP}')

GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT

firefox $GATEWAY_URL &
